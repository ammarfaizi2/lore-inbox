Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUEaGRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUEaGRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 02:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUEaGRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 02:17:15 -0400
Received: from ozlabs.org ([203.10.76.45]:44492 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264540AbUEaGRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 02:17:12 -0400
Date: Mon, 31 May 2004 16:14:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: Add watchdog timer to iseries_veth driver
Message-ID: <20040531061442.GA28167@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linuxppc64-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Currently the iSeries virtual ethernet driver has no Tx watchdog
timer.  This makes it vulnerable to clagging up if the other end of
connection is misbehaving - in particular if it is not giving timely
hypervisor level acks to our data frams.

This patch adds a watchdog timer which resets the connection to any
lpar we seem to be having trouble sending to.  With any luck the other
end might behave better after the reset.  If not, this will at least
unclag the queue for a while so we can keep talking to the lpars which
are behaving correctly.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/iseries_veth.c
===================================================================
--- working-2.6.orig/drivers/net/iseries_veth.c	2004-05-31 14:32:10.257660120 +1000
+++ working-2.6/drivers/net/iseries_veth.c	2004-05-31 15:42:30.639623512 +1000
@@ -807,6 +807,48 @@
 	return -EOPNOTSUPP;
 }
 
+static void veth_tx_timeout(struct net_device *dev)
+{
+	struct veth_port *port = (struct veth_port *)dev->priv;
+	struct net_device_stats *stats = &port->stats;
+	unsigned long flags;
+	int i;
+
+	stats->tx_errors++;
+
+	spin_lock_irqsave(&port->pending_gate, flags);
+
+	printk(KERN_WARNING "%s: Tx timeout!  Resetting lp connections: %08x\n",
+	       dev->name, port->pending_lpmask);
+
+	/* If we've timed out the queue must be stopped, which should
+	 * only ever happen when there is a pending packet. */
+	WARN_ON(! port->pending_lpmask);
+
+	for (i = 0; i < HVMAXARCHITECTEDLPS; i++) {
+		struct veth_lpar_connection *cnx = veth_cnx[i];
+
+		if (! (port->pending_lpmask & (1<<i)))
+			continue;
+
+		/* If we're pending on it, we must be connected to it,
+		 * so we should certainly have a structure for it. */
+		BUG_ON(! cnx);
+
+		/* Theoretically we could be kicking a connection
+		 * which doesn't deserve it, but in practice if we've
+		 * had a Tx timeout, the pending_lpmask will have
+		 * exactly one bit set - the connection causing the
+		 * problem. */
+		spin_lock(&cnx->lock);
+		cnx->state |= VETH_STATE_RESET;
+		veth_kick_statemachine(cnx);
+		spin_unlock(&cnx->lock);
+	}
+
+	spin_unlock_irqrestore(&port->pending_gate, flags);
+}
+
 struct net_device * __init veth_probe_one(int vlan)
 {
 	struct net_device *dev;
@@ -854,6 +896,9 @@
 	dev->set_multicast_list = veth_set_multicast_list;
 	dev->do_ioctl = veth_ioctl;
 
+	dev->watchdog_timeo = 2 * (VETH_ACKTIMEOUT * HZ / 1000000);
+	dev->tx_timeout = veth_tx_timeout;
+
 	rc = register_netdev(dev);
 	if (rc != 0) {
 		veth_printk(KERN_ERR,


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
