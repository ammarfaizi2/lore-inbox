Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbVADXgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbVADXgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVADXgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:36:20 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:42697 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262425AbVADXQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:16:14 -0500
Date: Tue, 4 Jan 2005 15:16:04 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Prezeroing V3 [4/4]: Driver for hardware zeroing on Altix
In-Reply-To: <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0501041515230.1536@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
 <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o Zeroing driver implemented with the Block Transfer Engine in the Altix
  SN2 SHub.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/arch/ia64/sn/kernel/bte.c
===================================================================
--- linux-2.6.10.orig/arch/ia64/sn/kernel/bte.c	2004-12-24 13:34:58.000000000 -0800
+++ linux-2.6.10/arch/ia64/sn/kernel/bte.c	2005-01-03 13:36:07.000000000 -0800
@@ -4,6 +4,8 @@
  * for more details.
  *
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
+ *
+ * Support for zeroing pages, Christoph Lameter, SGI, December 2004.
  */

 #include <linux/config.h>
@@ -20,6 +22,8 @@
 #include <linux/bootmem.h>
 #include <linux/string.h>
 #include <linux/sched.h>
+#include <linux/mm.h>
+#include <linux/scrub.h>

 #include <asm/sn/bte.h>

@@ -30,7 +34,7 @@
 /* two interfaces on two btes */
 #define MAX_INTERFACES_TO_TRY		4

-static struct bteinfo_s *bte_if_on_node(nasid_t nasid, int interface)
+static inline struct bteinfo_s *bte_if_on_node(nasid_t nasid, int interface)
 {
 	nodepda_t *tmp_nodepda;

@@ -132,7 +136,6 @@
 			if (bte == NULL) {
 				continue;
 			}
-
 			if (spin_trylock(&bte->spinlock)) {
 				if (!(*bte->most_rcnt_na & BTE_WORD_AVAILABLE) ||
 				    (BTE_LNSTAT_LOAD(bte) & BTE_ACTIVE)) {
@@ -157,7 +160,7 @@
 		}
 	} while (1);

-	if (notification == NULL) {
+	if (notification == NULL || (mode & BTE_NOTIFY_AND_GET_POINTER)) {
 		/* User does not want to be notified. */
 		bte->most_rcnt_na = &bte->notify;
 	} else {
@@ -192,6 +195,8 @@

 	itc_end = ia64_get_itc() + (40000000 * local_cpu_data->cyc_per_usec);

+	if (mode & BTE_NOTIFY_AND_GET_POINTER)
+		 *(u64 volatile **)(notification) = &bte->notify;
 	spin_unlock_irqrestore(&bte->spinlock, irq_flags);

 	if (notification != NULL) {
@@ -449,5 +454,37 @@
 		mynodepda->bte_if[i].cleanup_active = 0;
 		mynodepda->bte_if[i].bh_error = 0;
 	}
+}
+
+u64 *bte_zero_notify[MAX_COMPACT_NODES];
+
+static int bte_check_bzero(void)
+{
+	int node = get_nasid();
+
+	return *(bte_zero_notify[node]) != BTE_WORD_BUSY;
+}
+
+static int bte_start_bzero(void *p, unsigned long len)
+{
+	int node = get_nasid();
+
+	/* Check limitations.
+		1. System must be running (weird things happen during bootup)
+		2. Size >64KB. Smaller requests cause too much bte traffic
+	 */
+	if (len >= BTE_MAX_XFER || len < 60000 || system_state != SYSTEM_RUNNING)
+		return EINVAL;
+
+	return bte_zero(ia64_tpa(p), len, BTE_NOTIFY_AND_GET_POINTER, bte_zero_notify+node);
+}
+
+static struct zero_driver bte_bzero = {
+	.start = bte_start_bzero,
+	.check = bte_check_bzero,
+	.rate = 500000000		/* 500 MB /sec */
+};

+void sn_bte_bzero_init(void) {
+	register_zero_driver(&bte_bzero);
 }
Index: linux-2.6.10/arch/ia64/sn/kernel/setup.c
===================================================================
--- linux-2.6.10.orig/arch/ia64/sn/kernel/setup.c	2004-12-24 13:34:27.000000000 -0800
+++ linux-2.6.10/arch/ia64/sn/kernel/setup.c	2005-01-03 13:36:07.000000000 -0800
@@ -243,6 +243,7 @@
 	int pxm;
 	int major = sn_sal_rev_major(), minor = sn_sal_rev_minor();
 	extern void sn_cpu_init(void);
+	extern void sn_bte_bzero_init(void);

 	/*
 	 * If the generic code has enabled vga console support - lets
@@ -333,6 +334,7 @@
 	screen_info = sn_screen_info;

 	sn_timer_init();
+	sn_bte_bzero_init();
 }

 /**
Index: linux-2.6.10/include/asm-ia64/sn/bte.h
===================================================================
--- linux-2.6.10.orig/include/asm-ia64/sn/bte.h	2004-12-24 13:34:45.000000000 -0800
+++ linux-2.6.10/include/asm-ia64/sn/bte.h	2005-01-03 13:36:07.000000000 -0800
@@ -48,6 +48,8 @@
 #define BTE_ZERO_FILL (BTE_NOTIFY | IBCT_ZFIL_MODE)
 /* Use a reserved bit to let the caller specify a wait for any BTE */
 #define BTE_WACQUIRE (0x4000)
+/* Return the pointer to the notification cacheline to the user */
+#define BTE_NOTIFY_AND_GET_POINTER (0x8000)
 /* Use the BTE on the node with the destination memory */
 #define BTE_USE_DEST (BTE_WACQUIRE << 1)
 /* Use any available BTE interface on any node for the transfer */

