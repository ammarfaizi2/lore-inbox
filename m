Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWBHGrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWBHGrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbWBHGnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:43:11 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:43906 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161009AbWBHGmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:42:47 -0500
Message-Id: <20060208064916.157450000@sorel.sous-sol.org>
References: <20060208064503.924238000@sorel.sous-sol.org>
Date: Tue, 07 Feb 2006 22:45:23 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH 20/23] [PATCH] bridge: fix RCU race on device removal
Content-Disposition: inline; filename=bridge-fix-rcu-race-on-device-removal.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Patch to 2.6.15 stable kernel to fix race conditions on device
removal.  These are reproducible by doing delif while packets are
in flight.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 net/bridge/br_if.c       |    7 ++-----
 net/bridge/br_input.c    |   10 ++++++++--
 net/bridge/br_stp_bpdu.c |    8 ++++++--
 3 files changed, 16 insertions(+), 9 deletions(-)

Index: linux-2.6.15.3/net/bridge/br_if.c
===================================================================
--- linux-2.6.15.3.orig/net/bridge/br_if.c
+++ linux-2.6.15.3/net/bridge/br_if.c
@@ -99,7 +99,6 @@ static void del_nbp(struct net_bridge_po
 	struct net_bridge *br = p->br;
 	struct net_device *dev = p->dev;
 
-	dev->br_port = NULL;
 	dev_set_promiscuity(dev, -1);
 
 	spin_lock_bh(&br->lock);
@@ -110,9 +109,7 @@ static void del_nbp(struct net_bridge_po
 
 	list_del_rcu(&p->list);
 
-	del_timer_sync(&p->message_age_timer);
-	del_timer_sync(&p->forward_delay_timer);
-	del_timer_sync(&p->hold_timer);
+	rcu_assign_pointer(dev->br_port, NULL);
 	
 	call_rcu(&p->rcu, destroy_nbp_rcu);
 }
@@ -217,7 +214,6 @@ static struct net_bridge_port *new_nbp(s
 	p->dev = dev;
 	p->path_cost = cost;
  	p->priority = 0x8000 >> BR_PORT_BITS;
-	dev->br_port = p;
 	p->port_no = index;
 	br_init_port(p);
 	p->state = BR_STATE_DISABLED;
@@ -360,6 +356,7 @@ int br_add_if(struct net_bridge *br, str
 	else if ((err = br_sysfs_addif(p)))
 		del_nbp(p);
 	else {
+		rcu_assign_pointer(dev->br_port, p);
 		dev_set_promiscuity(dev, 1);
 
 		list_add_rcu(&p->list, &br->port_list);
Index: linux-2.6.15.3/net/bridge/br_input.c
===================================================================
--- linux-2.6.15.3.orig/net/bridge/br_input.c
+++ linux-2.6.15.3/net/bridge/br_input.c
@@ -45,11 +45,17 @@ static void br_pass_frame_up(struct net_
 int br_handle_frame_finish(struct sk_buff *skb)
 {
 	const unsigned char *dest = eth_hdr(skb)->h_dest;
-	struct net_bridge_port *p = skb->dev->br_port;
-	struct net_bridge *br = p->br;
+	struct net_bridge_port *p = rcu_dereference(skb->dev->br_port);
+	struct net_bridge *br;
 	struct net_bridge_fdb_entry *dst;
 	int passedup = 0;
 
+	if (unlikely(!p || p->state == BR_STATE_DISABLED)) {
+		kfree_skb(skb);
+		return 0;
+	}
+
+	br = p->br;
 	/* insert into forwarding database after filtering to avoid spoofing */
 	br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
 
Index: linux-2.6.15.3/net/bridge/br_stp_bpdu.c
===================================================================
--- linux-2.6.15.3.orig/net/bridge/br_stp_bpdu.c
+++ linux-2.6.15.3/net/bridge/br_stp_bpdu.c
@@ -136,10 +136,13 @@ static const unsigned char header[6] = {
 /* NO locks */
 int br_stp_handle_bpdu(struct sk_buff *skb)
 {
-	struct net_bridge_port *p = skb->dev->br_port;
-	struct net_bridge *br = p->br;
+	struct net_bridge_port *p = rcu_dereference(skb->dev->br_port);
+	struct net_bridge *br;
 	unsigned char *buf;
 
+	if (!p)
+		goto err;
+
 	/* insert into forwarding database after filtering to avoid spoofing */
 	br_fdb_update(p->br, p, eth_hdr(skb)->h_source);
 
@@ -150,6 +153,7 @@ int br_stp_handle_bpdu(struct sk_buff *s
 
 	buf = skb_pull(skb, sizeof(header));
 
+	br = p->br;
 	spin_lock_bh(&br->lock);
 	if (p->state == BR_STATE_DISABLED 
 	    || !(br->dev->flags & IFF_UP)

--
