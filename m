Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266331AbSKGE2m>; Wed, 6 Nov 2002 23:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266335AbSKGE2m>; Wed, 6 Nov 2002 23:28:42 -0500
Received: from dp.samba.org ([66.70.73.150]:1995 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266331AbSKGE2l>;
	Wed, 6 Nov 2002 23:28:41 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15817.60772.305789.777076@argo.ozlabs.ibm.com>
Date: Thu, 7 Nov 2002 15:34:44 +1100
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH] update BMAC and MACE ethernet drivers
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains some minor updates to the bmac and mace
ethernet drivers used on powermacs.  The bmac.c change is just to
remove some compile warnings.  The mace.c change is to move an inline
function definition to before the point where it is used.

Jeff, will you forward this to Linus or should I?

Thanks,
Paul.

diff -urN linux-2.5/drivers/net/bmac.c pmac-2.5/drivers/net/bmac.c
--- linux-2.5/drivers/net/bmac.c	2002-11-06 23:10:51.000000000 +1100
+++ pmac-2.5/drivers/net/bmac.c	2002-11-07 08:43:00.000000000 +1100
@@ -25,10 +25,10 @@
 #include <asm/pgtable.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
+#include <asm/irq.h>
 #ifdef CONFIG_PMAC_PBOOK
 #include <linux/adb.h>
 #include <linux/pmu.h>
-#include <asm/irq.h>
 #endif
 #include "bmac.h"
 
@@ -1053,7 +1053,7 @@
 {
 	struct dev_mc_list *dmi = dev->mc_list;
 	char *addrs;
-	int i, j, bit, byte;
+	int i;
 	unsigned short rx_cfg;
 	u32 crc;
 
diff -urN linux-2.5/drivers/net/mace.c pmac-2.5/drivers/net/mace.c
--- linux-2.5/drivers/net/mace.c	2002-05-25 10:21:39.000000000 +1000
+++ pmac-2.5/drivers/net/mace.c	2002-08-28 09:14:31.000000000 +1000
@@ -362,6 +362,24 @@
     return 0;
 }
 
+static inline void mace_clean_rings(struct mace_data *mp)
+{
+    int i;
+
+    /* free some skb's */
+    for (i = 0; i < N_RX_RING; ++i) {
+	if (mp->rx_bufs[i] != 0) {
+	    dev_kfree_skb(mp->rx_bufs[i]);
+	    mp->rx_bufs[i] = 0;
+	}
+    }
+    for (i = mp->tx_empty; i != mp->tx_fill; ) {
+	dev_kfree_skb(mp->tx_bufs[i]);
+	if (++i >= N_TX_RING)
+	    i = 0;
+    }
+}
+
 static int mace_open(struct net_device *dev)
 {
     struct mace_data *mp = (struct mace_data *) dev->priv;
@@ -432,24 +450,6 @@
     return 0;
 }
 
-static inline void mace_clean_rings(struct mace_data *mp)
-{
-    int i;
-
-    /* free some skb's */
-    for (i = 0; i < N_RX_RING; ++i) {
-	if (mp->rx_bufs[i] != 0) {
-	    dev_kfree_skb(mp->rx_bufs[i]);
-	    mp->rx_bufs[i] = 0;
-	}
-    }
-    for (i = mp->tx_empty; i != mp->tx_fill; ) {
-	dev_kfree_skb(mp->tx_bufs[i]);
-	if (++i >= N_TX_RING)
-	    i = 0;
-    }
-}
-
 static int mace_close(struct net_device *dev)
 {
     struct mace_data *mp = (struct mace_data *) dev->priv;
