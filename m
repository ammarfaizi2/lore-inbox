Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265209AbUKBAlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbUKBAlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 19:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S387178AbUKBAks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 19:40:48 -0500
Received: from fmr06.intel.com ([134.134.136.7]:696 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S386873AbUKBAkG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 19:40:06 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH] Fix for 802.3ad shutdown issue
Date: Mon, 1 Nov 2004 16:39:40 -0800
Message-ID: <F3EE2A9EB4576F40AFE238EC0AC04BC504191A10@orsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Fix for 802.3ad shutdown issue
Thread-Index: AcTAPkSMS0g60WiTSxyG12ug+f5/xwAMzZLA
From: "Williams, Mitch A" <mitch.a.williams@intel.com>
To: <bonding-devel@lists.sourceforge.net>, <fubar@us.ibm.com>,
       <ctindel@users.sourceforge.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Nov 2004 00:39:41.0863 (UTC) FILETIME=[710CF370:01C4C074]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a problem with shutting down 802.3ad bonds on the
2.6 
kernel.  Taking the interface down or removing the module causes a stack
dump if spinlock debugging is enabled.  This patch was generated from
the
2.6.9 kernel.

This patch has been peer reviewed by our Linux software engineering
team, 
and the fix has been verified by our test labs.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
 

diff -uprN -X dontdiff linux/drivers/net/bonding/bonding.h
linux-2.6.9/drivers/net/bonding/bonding.h
--- linux/drivers/net/bonding/bonding.h	2004-10-18 14:53:44.000000000
-0700
+++ linux-2.6.9/drivers/net/bonding/bonding.h	2004-10-29
14:01:14.000000000 -0700
@@ -36,8 +36,8 @@
 #include "bond_3ad.h"
 #include "bond_alb.h"
 
-#define DRV_VERSION	"2.6.0"
-#define DRV_RELDATE	"January 14, 2004"
+#define DRV_VERSION	"2.6.1"
+#define DRV_RELDATE	"October 29, 2004"
 #define DRV_NAME	"bonding"
 #define DRV_DESCRIPTION	"Ethernet Channel Bonding Driver"
 
diff -uprN -X dontdiff linux/drivers/net/bonding/bond_main.c
linux-2.6.9/drivers/net/bonding/bond_main.c
--- linux/drivers/net/bonding/bond_main.c	2004-10-18
14:55:21.000000000 -0700
+++ linux-2.6.9/drivers/net/bonding/bond_main.c	2004-10-29
14:01:37.000000000 -0700
@@ -469,6 +469,13 @@
  *	  * Add support for VLAN hardware acceleration capable slaves.
  *	  * Add capability to tag self generated packets in ALB/TLB
modes.
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
@@ -3566,15 +3573,15 @@ static int bond_close(struct net_device 
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
 
+	write_lock_bh(&bond->lock);
+
+	bond_mc_list_destroy(bond);
+
 	/* signal timers not to re-arm */
 	bond->kill_timers = 1;
 
 
