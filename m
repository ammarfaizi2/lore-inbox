Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbUKKWsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbUKKWsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKKWqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:46:52 -0500
Received: from havoc.gtf.org ([69.28.190.101]:3244 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262416AbUKKWob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:44:31 -0500
Date: Thu, 11 Nov 2004 17:44:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [BK PATCHES] 2.6.x net driver fixes
Message-ID: <20041111224429.GA2311@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please do a

	bk pull bk://gkernel.bkbits.net/net-drivers-2.6

This will update the following files:

 drivers/net/bonding/bond_main.c |   15 +++++++++++----
 drivers/net/bonding/bonding.h   |    4 ++--
 drivers/net/e1000/e1000_main.c  |    4 +++-
 drivers/net/ixgb/ixgb_main.c    |   13 +++++++------
 net/core/netpoll.c              |    4 ++--
 5 files changed, 25 insertions(+), 15 deletions(-)

through these ChangeSets:

<akpm@osdl.org> (04/11/11 1.2090)
   [PATCH] Fix for 802.3ad shutdown issue
   
   The patch below fixes a problem with shutting down 802.3ad bonds on the 2.6
   kernel.  Taking the interface down or removing the module causes a stack
   dump if spinlock debugging is enabled.  This patch was generated from the
   2.6.9 kernel.
   
   This patch has been peer reviewed by our Linux software engineering team,
   and the fix has been verified by our test labs.
   
   Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<akpm@osdl.org> (04/11/11 1.2089)
   [PATCH] ixgb: fix ixgb_intr looping checks
   
   This patch undoes a change that we believe will impact performance
   adversely, by creating possibly too long a delay between servicing
   completions.  The comment pretty much explains it.  We need to call both
   cleanup routines each pass through the loop, this time we have a comment
   explaining why.
   
   Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<akpm@osdl.org> (04/11/11 1.2088)
   [PATCH] E1000 stop working after resume
   
   Obviously pci_enable_device should be called after pci_restore_state.
   
   Signed-off-by: Li Shaohua <shaohua.li@intel.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

<akpm@osdl.org> (04/11/11 1.2087)
   [PATCH] netpoll: fix null ifa_list pointer dereference
   
   This fixes a bug where netpoll can dereference a null ifa_list pointer when
   not supplied an IP address at module load and the interface is up but no IP
   is configured.
   
   Bonus: unrelated netif_running cleanup
   
   Signed-off by: Jeff Moyer <jmoyer@redhat.com>
   Signed-off by: Matt Mackall <mpm@selenic.com>
   Signed-off-by: Andrew Morton <akpm@osdl.org>
   Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

diff -Nru a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
--- a/drivers/net/bonding/bond_main.c	2004-11-11 17:43:44 -05:00
+++ b/drivers/net/bonding/bond_main.c	2004-11-11 17:43:44 -05:00
@@ -469,6 +469,13 @@
  *	  * Add support for VLAN hardware acceleration capable slaves.
  *	  * Add capability to tag self generated packets in ALB/TLB modes.
  *	  Set version to 2.6.0.
+ * 2004/10/29 - Mitch Williams <mitch.a.williams at intel dot com>
+ *      - Fixed bug when unloading module while using 802.3ad.  If
+ *        spinlock debugging is turned on, this causes a stack dump.
+ *        Solution is to move call to dev_remove_pack outside of the
+ *        spinlock.
+ *        Set version to 2.6.1.
+ *
  */
 
 //#define BONDING_DEBUG 1
@@ -3566,14 +3573,14 @@
 {
 	struct bonding *bond = bond_dev->priv;
 
-	write_lock_bh(&bond->lock);
-
-	bond_mc_list_destroy(bond);
-
 	if (bond->params.mode == BOND_MODE_8023AD) {
 		/* Unregister the receive of LACPDUs */
 		bond_unregister_lacpdu(bond);
 	}
+
+	write_lock_bh(&bond->lock);
+
+	bond_mc_list_destroy(bond);
 
 	/* signal timers not to re-arm */
 	bond->kill_timers = 1;
diff -Nru a/drivers/net/bonding/bonding.h b/drivers/net/bonding/bonding.h
--- a/drivers/net/bonding/bonding.h	2004-11-11 17:43:44 -05:00
+++ b/drivers/net/bonding/bonding.h	2004-11-11 17:43:44 -05:00
@@ -36,8 +36,8 @@
 #include "bond_3ad.h"
 #include "bond_alb.h"
 
-#define DRV_VERSION	"2.6.0"
-#define DRV_RELDATE	"January 14, 2004"
+#define DRV_VERSION	"2.6.1"
+#define DRV_RELDATE	"October 29, 2004"
 #define DRV_NAME	"bonding"
 #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"
 
diff -Nru a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
--- a/drivers/net/e1000/e1000_main.c	2004-11-11 17:43:44 -05:00
+++ b/drivers/net/e1000/e1000_main.c	2004-11-11 17:43:44 -05:00
@@ -2885,9 +2885,11 @@
 	struct e1000_adapter *adapter = netdev->priv;
 	uint32_t manc, ret;
 
-	ret = pci_enable_device(pdev);
 	pci_set_power_state(pdev, 0);
 	pci_restore_state(pdev);
+	ret = pci_enable_device(pdev);
+	if (pdev->is_busmaster)
+		pci_set_master(pdev);
 
 	pci_enable_wake(pdev, 3, 0);
 	pci_enable_wake(pdev, 4, 0); /* 4 == D3 cold */
diff -Nru a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
--- a/drivers/net/ixgb/ixgb_main.c	2004-11-11 17:43:44 -05:00
+++ b/drivers/net/ixgb/ixgb_main.c	2004-11-11 17:43:44 -05:00
@@ -1613,13 +1613,14 @@
 		__netif_rx_schedule(netdev);
 	}
 #else
-	for (i = 0; i < IXGB_MAX_INTR; i++)
-		if (ixgb_clean_rx_irq(adapter) == FALSE)
+	/* yes, that is actually a & and it is meant to make sure that
+	 * every pass through this for loop checks both receive and
+	 * transmit queues for completed descriptors, intended to
+	 * avoid starvation issues and assist tx/rx fairness. */
+	for(i = 0; i < IXGB_MAX_INTR; i++)
+		if(!ixgb_clean_rx_irq(adapter) &
+		   !ixgb_clean_tx_irq(adapter))
 			break;
-	for (i = 0; i < IXGB_MAX_INTR; i++)
-		if (ixgb_clean_tx_irq(adapter) == FALSE)
-			break;
-
 	/* if RAIDC:EN == 1 and ICR:RXDMT0 == 1, we need to
 	 * set IMS:RXDMT0 to 1 to restart the RBD timer (POLL)
 	 */
diff -Nru a/net/core/netpoll.c b/net/core/netpoll.c
--- a/net/core/netpoll.c	2004-11-11 17:43:44 -05:00
+++ b/net/core/netpoll.c	2004-11-11 17:43:44 -05:00
@@ -565,7 +565,7 @@
 		goto release;
 	}
 
-	if (!(ndev->flags & IFF_UP)) {
+	if (!netif_running(ndev)) {
 		unsigned short oflags;
 		unsigned long atmost, atleast;
 
@@ -611,7 +611,7 @@
 		rcu_read_lock();
 		in_dev = __in_dev_get(ndev);
 
-		if (!in_dev) {
+		if (!in_dev || !in_dev->ifa_list) {
 			rcu_read_unlock();
 			printk(KERN_ERR "%s: no IP address for %s, aborting\n",
 			       np->name, np->dev_name);
