Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262444AbUKKX6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbUKKX6Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 18:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbUKKXz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 18:55:56 -0500
Received: from fmr12.intel.com ([134.134.136.15]:47576 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S262444AbUKKXxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 18:53:07 -0500
Date: Fri, 12 Nov 2004 15:51:49 -0800 (PST)
From: Radheka Godse <radheka.godse@intel.com>
X-X-Sender: radheka@localhost.localdomain
To: bonding-devel@lists.sourceforge.net, fubar@us.ibm.com,
       ctindel@users.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update)
Message-ID: <Pine.LNX.4.61.0411121515530.15487@localhost.localdomain>
ReplyTo: "Radheka Godse" <radheka.godse@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.61.0411121515532.15487@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore previous submittal, it has reversed tags ('-'s instead of 
'+'s; I had swapped the order for diff of modified and un-modified 
src trees)

The patch below ADDS Zero Copy Transmit Support to bonding device.

We saw around ~50% system utilization improvement with tcp sendfile() 
function enabled netperf test in 802.3ad mode.

Note that this patch was generated for 2.6.9 kernel after applying 
bond-patch-2.6.1(also attached to this thread) that was submitted last week and 
got accepted into the kernel.

Signed-off-by: Radheka Godse <radheka.godse@intel.com>

diff -uprN -X dontdiff linux-2.6.9_bond-patch-2.6.1/drivers/net/bonding/bonding.h linux-2.6.9/drivers/net/bonding/bonding.h
--- linux-2.6.9_bond-patch-2.6.1/drivers/net/bonding/bonding.h	2004-11-10 15:42:55.000000000 -0800
+++ linux-2.6.9/drivers/net/bonding/bonding.h	2004-11-11 13:05:54.000000000 -0800
@@ -36,8 +36,8 @@
  #include "bond_3ad.h"
  #include "bond_alb.h"

-#define DRV_VERSION	"2.6.1"
-#define DRV_RELDATE	"October 29, 2004"
+#define DRV_VERSION	"2.6.2"
+#define DRV_RELDATE	"November 09, 2004"
  #define DRV_NAME	"bonding"
  #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"

diff -uprN -X dontdiff linux-2.6.9_bond-patch-2.6.1/drivers/net/bonding/bond_main.c linux-2.6.9/drivers/net/bonding/bond_main.c
--- linux-2.6.9_bond-patch-2.6.1/drivers/net/bonding/bond_main.c	2004-11-10 15:42:55.000000000 -0800
+++ linux-2.6.9/drivers/net/bonding/bond_main.c	2004-11-11 13:05:54.000000000 -0800
@@ -475,6 +475,9 @@
   *        Solution is to move call to dev_remove_pack outside of the
   *        spinlock.
   *        Set version to 2.6.1.
+ * 2004/11/09 - Radheka Godse <radheka.godse at intel dot com>
+ *      - Added Zero Copy Transmit Support by setting appropriate flags.
+ *        Set version to 2.6.2.
   *
   */

@@ -4318,7 +4321,22 @@ static int __init bond_init(struct net_d
  	bond_dev->features |= (NETIF_F_HW_VLAN_TX |
  			       NETIF_F_HW_VLAN_RX |
  			       NETIF_F_HW_VLAN_FILTER);
-
+ 
+	/* We let the bond device publish all hardware
+	 * acceleration features possible. This is OK,
+	 * since if an skb is passed from the bond to
+	 * a slave that doesn't support one of those
+	 * features, everything is fixed in the
+	 * dev_queue_xmit() function (e.g. calculate
+	 * check sum, linearize the skb, etc.).
+	 */
+	bond_dev->features |= (NETIF_F_SG      |
+			       NETIF_F_IP_CSUM |
+			       NETIF_F_NO_CSUM |
+			       NETIF_F_HW_CSUM |
+			       NETIF_F_HIGHDMA |
+			       NETIF_F_FRAGLIST);
+
  #ifdef CONFIG_PROC_FS
  	bond_create_proc_entry(bond);
  #endif
