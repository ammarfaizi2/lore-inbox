Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbULUUIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbULUUIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 15:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbULUUHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 15:07:55 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:11186 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261617AbULUT6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:58:02 -0500
Date: Tue, 21 Dec 2004 11:57:57 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "Luck, Tony" <tony.luck@intel.com>, Robin Holt <holt@sgi.com>,
       Adam Litke <agl@us.ibm.com>, linux-ia64@vger.kernel.org,
       torvalds@osdl.org, linux-mm@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Increase page fault rate by prezeroing V1 [3/3]: Altix SN2 BTE
 Zeroing
In-Reply-To: <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412211157180.1313@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o Use the Block Transfer Engine in the Altix SN2 SHub for background zeroing

Index: linux-2.6.9/arch/ia64/sn/kernel/bte.c
===================================================================
--- linux-2.6.9.orig/arch/ia64/sn/kernel/bte.c	2004-12-17 14:40:10.000000000 -0800
+++ linux-2.6.9/arch/ia64/sn/kernel/bte.c	2004-12-21 11:03:49.000000000 -0800
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

@@ -30,7 +34,11 @@
 /* two interfaces on two btes */
 #define MAX_INTERFACES_TO_TRY		4

-static struct bteinfo_s *bte_if_on_node(nasid_t nasid, int interface)
+DEFINE_PER_CPU(u64 *, bte_zero_notify);
+
+#define bte_zero_notify __get_cpu_var(bte_zero_notify)
+
+static inline struct bteinfo_s *bte_if_on_node(nasid_t nasid, int interface)
 {
 	nodepda_t *tmp_nodepda;

@@ -132,7 +140,6 @@
 			if (bte == NULL) {
 				continue;
 			}
-
 			if (spin_trylock(&bte->spinlock)) {
 				if (!(*bte->most_rcnt_na & BTE_WORD_AVAILABLE) ||
 				    (BTE_LNSTAT_LOAD(bte) & BTE_ACTIVE)) {
@@ -157,7 +164,7 @@
 		}
 	} while (1);

-	if (notification == NULL) {
+	if (notification == NULL || (mode & BTE_NOTIFY_AND_GET_POINTER)) {
 		/* User does not want to be notified. */
 		bte->most_rcnt_na = &bte->notify;
 	} else {
@@ -192,6 +199,8 @@

 	itc_end = ia64_get_itc() + (40000000 * local_cpu_data->cyc_per_usec);

+	if (mode & BTE_NOTIFY_AND_GET_POINTER)
+		 *(u64 volatile **)(notification) = &bte->notify;
 	spin_unlock_irqrestore(&bte->spinlock, irq_flags);

 	if (notification != NULL) {
@@ -449,5 +458,31 @@
 		mynodepda->bte_if[i].cleanup_active = 0;
 		mynodepda->bte_if[i].bh_error = 0;
 	}
+}
+
+static int bte_check_bzero(void)
+{
+	return *bte_zero_notify != BTE_WORD_BUSY;
+}
+
+static int bte_start_bzero(void *p, unsigned long len)
+{
+	/* Check limitations.
+		1. System must be running (weird things happen during bootup)
+		2. Size >64KB. Smaller requests cause too much bte traffic
+	 */
+	if (len >= BTE_MAX_XFER || len < 60000 || system_state != SYSTEM_RUNNING)
+		return EINVAL;
+
+	return bte_zero(ia64_tpa(p), len, BTE_NOTIFY_AND_GET_POINTER, &bte_zero_notify);
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
Index: linux-2.6.9/arch/ia64/sn/kernel/setup.c
===================================================================
--- linux-2.6.9.orig/arch/ia64/sn/kernel/setup.c	2004-12-17 14:40:10.000000000 -0800
+++ linux-2.6.9/arch/ia64/sn/kernel/setup.c	2004-12-21 11:02:35.000000000 -0800
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
Index: linux-2.6.9/include/asm-ia64/sn/bte.h
===================================================================
--- linux-2.6.9.orig/include/asm-ia64/sn/bte.h	2004-12-17 14:40:16.000000000 -0800
+++ linux-2.6.9/include/asm-ia64/sn/bte.h	2004-12-21 11:02:35.000000000 -0800
@@ -48,6 +48,8 @@
 #define BTE_ZERO_FILL (BTE_NOTIFY | IBCT_ZFIL_MODE)
 /* Use a reserved bit to let the caller specify a wait for any BTE */
 #define BTE_WACQUIRE (0x4000)
+/* Return the pointer to the notification cacheline to the user */
+#define BTE_NOTIFY_AND_GET_POINTER (0x8000)
 /* Use the BTE on the node with the destination memory */
 #define BTE_USE_DEST (BTE_WACQUIRE << 1)
 /* Use any available BTE interface on any node for the transfer */

