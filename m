Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbSJHUke>; Tue, 8 Oct 2002 16:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSJHTB0>; Tue, 8 Oct 2002 15:01:26 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15120 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262676AbSJHS77>; Tue, 8 Oct 2002 14:59:59 -0400
Subject: PATCH: fix all the isdn compile mess
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 19:57:04 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzXU-0004rw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This doesnt fix all the isdn code but it sorts out the tqueue stuff so we
are no worse than before

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/eicon/Divas_mod.c linux.2.5.41-ac1/drivers/isdn/eicon/Divas_mod.c
--- linux.2.5.41/drivers/isdn/eicon/Divas_mod.c	2002-10-07 22:12:23.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/eicon/Divas_mod.c	2002-10-08 00:22:01.000000000 +0100
@@ -10,7 +10,6 @@
 #undef N_DATA
 
 #include <linux/kernel.h>
-#include <linux/tqueue.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/ioport.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/hisax/config.c linux.2.5.41-ac1/drivers/isdn/hisax/config.c
--- linux.2.5.41/drivers/isdn/hisax/config.c	2002-10-07 22:12:23.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/hisax/config.c	2002-10-08 00:23:59.000000000 +0100
@@ -1173,7 +1173,6 @@
 	cs->tx_skb = NULL;
 	cs->tx_cnt = 0;
 	cs->event = 0;
-	cs->tqueue.sync = 0;
 	cs->tqueue.data = cs;
 
 	skb_queue_head_init(&cs->rq);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/hisax/ipacx.c linux.2.5.41-ac1/drivers/isdn/hisax/ipacx.c
--- linux.2.5.41/drivers/isdn/hisax/ipacx.c	2002-10-07 22:12:23.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/hisax/ipacx.c	2002-10-08 00:26:38.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/workqueue.h>
 #include "hisax_if.h"
 #include "hisax.h"
 #include "isdnl1.h"
@@ -509,7 +510,7 @@
 {
 	printk(KERN_INFO "HiSax: IPACX ISDN driver v0.1.0\n");
 
-	INIT_WORK(&cs->tqueue, (void *)(void *) dch_bh);
+	INIT_WORK(&cs->tqueue, (void *)(void *) dch_bh, cs);
 	cs->setstack_d      = dch_setstack;
   
 	cs->dbusytimer.function = (void *) dbusy_timer_handler;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/i4l/isdn_concap.c linux.2.5.41-ac1/drivers/isdn/i4l/isdn_concap.c
--- linux.2.5.41/drivers/isdn/i4l/isdn_concap.c	2002-10-07 22:12:23.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/i4l/isdn_concap.c	2002-10-07 22:42:38.000000000 +0100
@@ -19,7 +19,9 @@
 #include "isdn_net.h"
 #include <linux/concap.h>
 #include "isdn_concap.h"
+#include <linux/if_arp.h>
 
+#ifdef CONFIG_ISDN_X25
 
 /* The following set of device service operations are for encapsulation
    protocols that require for reliable datalink semantics. That means:
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/pcbit/callbacks.c linux.2.5.41-ac1/drivers/isdn/pcbit/callbacks.c
--- linux.2.5.41/drivers/isdn/pcbit/callbacks.c	2002-07-20 20:11:18.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/pcbit/callbacks.c	2002-10-08 00:35:37.000000000 +0100
@@ -22,7 +22,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
-#include <linux/tqueue.h>
 #include <linux/skbuff.h>
 
 #include <asm/io.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/pcbit/capi.c linux.2.5.41-ac1/drivers/isdn/pcbit/capi.c
--- linux.2.5.41/drivers/isdn/pcbit/capi.c	2002-07-20 20:11:29.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/pcbit/capi.c	2002-10-08 00:35:19.000000000 +0100
@@ -35,7 +35,6 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 
-#include <linux/tqueue.h>
 #include <linux/skbuff.h>
 
 #include <asm/io.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/pcbit/edss1.c linux.2.5.41-ac1/drivers/isdn/pcbit/edss1.c
--- linux.2.5.41/drivers/isdn/pcbit/edss1.c	2002-07-20 20:11:07.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/pcbit/edss1.c	2002-10-08 00:35:01.000000000 +0100
@@ -22,7 +22,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
-#include <linux/tqueue.h>
 #include <linux/skbuff.h>
 
 #include <linux/timer.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/pcbit/module.c linux.2.5.41-ac1/drivers/isdn/pcbit/module.c
--- linux.2.5.41/drivers/isdn/pcbit/module.c	2002-07-20 20:11:27.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/pcbit/module.c	2002-10-08 00:34:42.000000000 +0100
@@ -14,7 +14,6 @@
 #include <linux/sched.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
-#include <linux/tqueue.h>
 #include <linux/skbuff.h>
 
 #include <linux/isdnif.h>
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/tpam/tpam_commands.c linux.2.5.41-ac1/drivers/isdn/tpam/tpam_commands.c
--- linux.2.5.41/drivers/isdn/tpam/tpam_commands.c	2002-07-20 20:11:08.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/tpam/tpam_commands.c	2002-10-08 00:37:51.000000000 +0100
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/sched.h>
-#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <asm/io.h>
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/tpam/tpam_main.c linux.2.5.41-ac1/drivers/isdn/tpam/tpam_main.c
--- linux.2.5.41/drivers/isdn/tpam/tpam_main.c	2002-10-07 22:12:23.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/tpam/tpam_main.c	2002-10-08 00:37:12.000000000 +0100
@@ -14,8 +14,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/sched.h>
-#include <linux/tqueue.h>
-#include <linux/interrupt.h>
+
 #include <linux/init.h>
 #include <asm/io.h>
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/isdn/tpam/tpam_nco.c linux.2.5.41-ac1/drivers/isdn/tpam/tpam_nco.c
--- linux.2.5.41/drivers/isdn/tpam/tpam_nco.c	2002-07-20 20:11:10.000000000 +0100
+++ linux.2.5.41-ac1/drivers/isdn/tpam/tpam_nco.c	2002-10-08 00:37:33.000000000 +0100
@@ -14,7 +14,6 @@
 
 #include <linux/pci.h>
 #include <linux/sched.h>
-#include <linux/tqueue.h>
 #include <linux/interrupt.h>
 #include <asm/io.h>
 
