Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbVLMIZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVLMIZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVLMIZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:25:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:25732 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932562AbVLMIZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:25:09 -0500
Date: Tue, 13 Dec 2005 00:23:26 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       fubar@us.ibm.com, linville@tuxdriver.com
Subject: [patch 19/26] bonding: fix feature consolidation
Message-ID: <20051213082326.GS5823@kroah.com>
References: <20051213073430.558435000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="bonding-fix-feature-consolidation.patch"
In-Reply-To: <20051213082143.GA5823@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Jay Vosburgh <fubar@us.ibm.com>

[PATCH] bonding: fix feature consolidation

This should resolve http://bugzilla.kernel.org/show_bug.cgi?id=5519

The current feature computation loses bits that it doesn't know about,
resulting in an inability to add VLANs and possibly other havoc.
Rewrote function to preserve bits it doesn't know about, remove an
unneeded state variable, and simplify the code.

Signed-off-by: Jay Vosburgh <fubar@us.ibm.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/bonding/bond_main.c |   32 +++++++++++---------------------
 drivers/net/bonding/bonding.h   |    7 ++-----
 2 files changed, 13 insertions(+), 26 deletions(-)

--- linux-2.6.14.3.orig/drivers/net/bonding/bond_main.c
+++ linux-2.6.14.3/drivers/net/bonding/bond_main.c
@@ -1604,35 +1604,27 @@ static int bond_sethwaddr(struct net_dev
 	(NETIF_F_SG|NETIF_F_IP_CSUM|NETIF_F_NO_CSUM|NETIF_F_HW_CSUM)
 
 /* 
- * Compute the features available to the bonding device by 
- * intersection of all of the slave devices' BOND_INTERSECT_FEATURES.
- * Call this after attaching or detaching a slave to update the 
- * bond's features.
+ * Compute the common dev->feature set available to all slaves.  Some
+ * feature bits are managed elsewhere, so preserve feature bits set on
+ * master device that are not part of the examined set.
  */
 static int bond_compute_features(struct bonding *bond)
 {
-	int i;
+	unsigned long features = BOND_INTERSECT_FEATURES;
 	struct slave *slave;
 	struct net_device *bond_dev = bond->dev;
-	int features = bond->bond_features;
+	int i;
 
-	bond_for_each_slave(bond, slave, i) {
-		struct net_device * slave_dev = slave->dev;
-		if (i == 0) {
-			features |= BOND_INTERSECT_FEATURES;
-		}
-		features &=
-			~(~slave_dev->features & BOND_INTERSECT_FEATURES);
-	}
+	bond_for_each_slave(bond, slave, i)
+		features &= (slave->dev->features & BOND_INTERSECT_FEATURES);
 
-	/* turn off NETIF_F_SG if we need a csum and h/w can't do it */
 	if ((features & NETIF_F_SG) && 
-		!(features & (NETIF_F_IP_CSUM |
-			      NETIF_F_NO_CSUM |
-			      NETIF_F_HW_CSUM))) {
+	    !(features & (NETIF_F_IP_CSUM |
+			  NETIF_F_NO_CSUM |
+			  NETIF_F_HW_CSUM)))
 		features &= ~NETIF_F_SG;
-	}
 
+	features |= (bond_dev->features & ~BOND_INTERSECT_FEATURES);
 	bond_dev->features = features;
 
 	return 0;
@@ -4508,8 +4500,6 @@ static int __init bond_init(struct net_d
 			       NETIF_F_HW_VLAN_RX |
 			       NETIF_F_HW_VLAN_FILTER);
 
-	bond->bond_features = bond_dev->features;
-
 #ifdef CONFIG_PROC_FS
 	bond_create_proc_entry(bond);
 #endif
--- linux-2.6.14.3.orig/drivers/net/bonding/bonding.h
+++ linux-2.6.14.3/drivers/net/bonding/bonding.h
@@ -40,8 +40,8 @@
 #include "bond_3ad.h"
 #include "bond_alb.h"
 
-#define DRV_VERSION	"2.6.4"
-#define DRV_RELDATE	"September 26, 2005"
+#define DRV_VERSION	"2.6.5"
+#define DRV_RELDATE	"November 4, 2005"
 #define DRV_NAME	"bonding"
 #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"
 
@@ -211,9 +211,6 @@ struct bonding {
 	struct   bond_params params;
 	struct   list_head vlan_list;
 	struct   vlan_group *vlgrp;
-	/* the features the bonding device supports, independently 
-	 * of any slaves */
-	int	 bond_features; 
 };
 
 /**

--
