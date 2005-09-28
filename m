Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVI1V4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVI1V4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbVI1VzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:55:15 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:45573 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751043AbVI1Vy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:54:56 -0400
Date: Wed, 28 Sep 2005 17:50:53 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       bonding-devel@lists.sourceforge.net
Cc: ctindel@users.sourceforge.net, fubar@us.ibm.com, jgarzik@pobox.com
Subject: [patch 2.6.14-rc2] bonding: replicate IGMP traffic in activebackup mode
Message-ID: <09282005175053.11150@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replicate IGMP frames across all slaves in activebackup mode. This
ensures fail-over is rapid for multicast traffic as well. Otherwise,
multicast traffic will be lost until the next IGMP membership report
poll timeout.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
This is conceptually similar to the treatment of IGMP traffic in
bond_alb_xmit. In that case, IGMP traffic transmitted on any slave
is re-routed to the active slave in order to ensure that multicast
traffic continues to be directed to the active receiver.

 drivers/net/bonding/bond_main.c |   53 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4391,6 +4391,39 @@ out:
 	return 0;
 }
 
+static void bond_activebackup_xmit_copy(struct sk_buff *skb,
+                                         struct bonding *bond,
+                                         struct slave *slave)
+{
+	struct sk_buff *skb2 = skb_copy(skb, GFP_ATOMIC);
+	struct ethhdr *eth_data;
+	u8 *hwaddr;
+	int res;
+
+	if (!skb2) {
+		printk(KERN_ERR DRV_NAME ": Error: "
+		       "bond_activebackup_xmit_copy(): skb_copy() failed\n");
+		return;
+	}
+
+	skb2->mac.raw = (unsigned char *)skb2->data;
+	eth_data = eth_hdr(skb2);
+
+	/* Pick an appropriate source MAC address */
+	hwaddr = slave->perm_hwaddr;
+	if (!memcmp(eth_data->h_source, hwaddr, ETH_ALEN))
+		hwaddr = bond->curr_active_slave->perm_hwaddr;
+
+	/* Set source MAC address appropriately */
+	memcpy(eth_data->h_source, hwaddr, ETH_ALEN);
+
+	res = bond_dev_queue_xmit(bond, skb2, slave->dev);
+	if (res)
+		dev_kfree_skb(skb2);
+
+	return;
+}
+
 /*
  * in active-backup mode, we know that bond->curr_active_slave is always valid if
  * the bond has a usable interface.
@@ -4407,10 +4440,26 @@ static int bond_xmit_activebackup(struct
 		goto out;
 	}
 
-	if (bond->curr_active_slave) { /* one usable interface */
-		res = bond_dev_queue_xmit(bond, skb, bond->curr_active_slave->dev);
+	if (!bond->curr_active_slave)
+		goto out;
+
+	/* Xmit IGMP frames on all slaves to ensure rapid fail-over
+	   for multicast traffic on snooping switches */
+	if (skb->protocol == __constant_htons(ETH_P_IP) &&
+	    skb->nh.iph->protocol == IPPROTO_IGMP) {
+		struct slave *slave, *active_slave;
+		int i;
+
+		active_slave = bond->curr_active_slave;
+		bond_for_each_slave_from_to(bond, slave, i, active_slave->next,
+		                            active_slave->prev)
+			if (IS_UP(slave->dev) &&
+			    (slave->link == BOND_LINK_UP))
+				bond_activebackup_xmit_copy(skb, bond, slave);
 	}
 
+	res = bond_dev_queue_xmit(bond, skb, bond->curr_active_slave->dev);
+
 out:
 	if (res) {
 		/* no suitable interface, frame not sent */
