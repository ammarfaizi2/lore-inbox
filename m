Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVCOVw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVCOVw0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 16:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVCOVw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 16:52:26 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:41735 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261888AbVCOVvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 16:51:44 -0500
Date: Tue, 15 Mar 2005 16:51:33 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: ctindel@users.sourceforge.net, fubar@us.ibm.com,
       bonding-devel@lists.sourceforge.net, netdev@oss.sgi.com,
       jgarzik@pobox.com
Subject: [patch 2.6.11] bonding: avoid tx balance for IGMP (alb/tlb mode)
Message-ID: <20050315215128.GA18262@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ctindel@users.sourceforge.net, fubar@us.ibm.com,
	bonding-devel@lists.sourceforge.net, netdev@oss.sgi.com,
	jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add special case to bond_alb_xmit() to avoid tx balance for IGMP.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Some switches (e.g. the Cisco Catalyst 3750) use IGMP snooping to
determine which hosts belong to which multicast groups.  Typically
such switches use a timeout to determine when hosts have quietly left
a group.

In ALB or TLB mode, only one interface is configured to receive
packets at a time.  (Receive load balancing doesn't seem to be
effective for IGMP traffic.)  If both Ethernet interfaces are up,
the load balancing capability can move the sending of IGMP packets
to the non-receiving interface.  If the switch ends up timing out the
interface configured to receive packets, the multicast packets are then
only sent to the non-receiving interface and are subsequently dropped.
This behaviour is undesirable.

The fix is to add a new special case (alongside some existing special
cases) in bond_alb_xmit() in order to ensure that IGMP traffic is
always sent out the port which is configured to receive frames.

Of course, this patch has the downside of not load balancing IGMP
traffic from the host.  But, I'm inclined to believe that is "no big
deal"... :-)  Also, I'm sure other solutions might exist.  But, they
are likely no where near as simple as this one.  And, this is probably
the most in keeping with the ALB/TLB philosophy of not requiring any
special switch support.

 drivers/net/bonding/bond_alb.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.11/drivers/net/bonding/bond_alb.c.orig	2005-03-15 16:25:09.648034108 -0500
+++ linux-2.6.11/drivers/net/bonding/bond_alb.c	2005-03-15 16:25:09.649033971 -0500
@@ -54,6 +54,7 @@
 #include <linux/if_ether.h>
 #include <linux/if_bonding.h>
 #include <linux/if_vlan.h>
+#include <linux/in.h>
 #include <net/ipx.h>
 #include <net/arp.h>
 #include <asm/byteorder.h>
@@ -1300,7 +1301,8 @@ int bond_alb_xmit(struct sk_buff *skb, s
 	switch (ntohs(skb->protocol)) {
 	case ETH_P_IP:
 		if ((memcmp(eth_data->h_dest, mac_bcast, ETH_ALEN) == 0) ||
-		    (skb->nh.iph->daddr == ip_bcast)) {
+		    (skb->nh.iph->daddr == ip_bcast) ||
+		    (skb->nh.iph->protocol == IPPROTO_IGMP)) {
 			do_tx_balance = 0;
 			break;
 		}
-- 
John W. Linville
linville@tuxdriver.com
