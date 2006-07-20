Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWGTQLB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWGTQLB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 12:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbWGTQLB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 12:11:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:156 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030345AbWGTQLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 12:11:00 -0400
Subject: e1000: Problem with "disable CRC stripping workaround" patch
From: Mark McLoughlin <markmc@redhat.com>
To: jesse.brandeburg@intel.com
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: multipart/mixed; boundary="=-SwOkWO6IEoNS04cOLIvX"
Date: Thu, 20 Jul 2006 17:11:08 +0100
Message-Id: <1153411868.2758.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SwOkWO6IEoNS04cOLIvX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Jesse,
	I just came across this:

  http://www.mail-archive.com/netdev@vger.kernel.org/msg14547.html

	I'm seeing a problem with this currently under Xen's bridging
configuration.

	Basically, with the patch, packets are being dropped at this point in
net/bridge/br_forward.c:

---
int br_dev_queue_push_xmit(struct sk_buff *skb)
{
        /* drop mtu oversized packets except gso */
	if (packet_length(skb) > skb->dev->mtu && !skb_is_gso(skb)) {
		kfree_skb(skb);
--

	What's happening that a 1500 byte packet comes in from e1000, onto the
bridge and is to be forwarded to a device whose mtu is 1500. Because the
CRC hasn't been stripped, skb->len is 1504 and the packet is dropped.

	One option is to fix this specific problem is to subtract the CRC
length from skb->len in e1000, another is to raise the MTU on the
receive side of Xen's loopback interface. I've attached a patch for the
latter, but I've no real opinion on which is more correct.

Cheers,
Mark.

--=-SwOkWO6IEoNS04cOLIvX
Content-Disposition: attachment; filename=xen-netback-jumbo-mtu-on-vif.patch
Content-Type: text/x-patch; name=xen-netback-jumbo-mtu-on-vif.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- ./xen/netback/loopback.c.jumbo-mtu-on-vif	2006-07-20 16:21:52.000000000 +0100
+++ ./xen/netback/loopback.c	2006-07-20 16:23:08.000000000 +0100
@@ -161,16 +161,6 @@
 				NETIF_F_IP_CSUM);
 
 	SET_ETHTOOL_OPS(dev, &network_ethtool_ops);
-
-	/*
-	 * We do not set a jumbo MTU on the interface. Otherwise the network
-	 * stack will try to send large packets that will get dropped by the
-	 * Ethernet bridge (unless the physical Ethernet interface is
-	 * configured to transfer jumbo packets). If a larger MTU is desired
-	 * then the system administrator can specify it using the 'ifconfig'
-	 * command.
-	 */
-	/*dev->mtu             = 16*1024;*/
 }
 
 static int __init make_loopback(int i)
@@ -193,6 +183,16 @@
 	loopback_construct(dev2, dev1);
 
 	/*
+	 * We only set a jumbo MTU on vif0.0. Otherwise the network
+	 * stack will try to send large packets that will get dropped by the
+	 * Ethernet bridge (unless the physical Ethernet interface is
+	 * configured to transfer jumbo packets). If a larger MTU is desired
+	 * then the system administrator can specify it using the 'ifconfig'
+	 * command.
+	 */
+	dev1->mtu = 16*1024;
+
+	/*
 	 * Initialise a dummy MAC address for the 'dummy backend' interface. We
 	 * choose the numerically largest non-broadcast address to prevent the
 	 * address getting stolen by an Ethernet bridge for STP purposes.

--=-SwOkWO6IEoNS04cOLIvX--

