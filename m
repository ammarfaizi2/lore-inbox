Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVBGUfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVBGUfy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVBGTqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:46:47 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:30382 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261273AbVBGTel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:34:41 -0500
Date: Mon, 7 Feb 2005 11:32:33 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: prezeroing V6 [3/3]: Altix SN2 Block Transfer Engine Zeroing Driver
In-Reply-To: <Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0502071131560.27951@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the Block Transfer Engine in the Altix SN2 SHub for background
zeroing

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.10/arch/ia64/sn/kernel/bte.c
===================================================================
--- linux-2.6.10.orig/arch/ia64/sn/kernel/bte.c	2005-02-03 17:13:07.000000000 -0800
+++ linux-2.6.10/arch/ia64/sn/kernel/bte.c	2005-02-03 18:11:45.000000000 -0800
@@ -3,7 +3,9 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
+ * Copyright (c) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
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

@@ -199,6 +203,7 @@ retry_bteop:
 	}

 	while ((transfer_stat = *bte->most_rcnt_na) == BTE_WORD_BUSY) {
+		cpu_relax();
 		if (ia64_get_itc() > itc_end) {
 			BTE_PRINTK(("BTE timeout nasid 0x%x bte%d IBLS = 0x%lx na 0x%lx\n",
 				NASID_GET(bte->bte_base_addr), bte->bte_num,
@@ -449,5 +454,25 @@ void bte_init_node(nodepda_t * mynodepda
 		mynodepda->bte_if[i].cleanup_active = 0;
 		mynodepda->bte_if[i].bh_error = 0;
 	}
+}
+
+static int bte_start_bzero(void *p, unsigned long len)
+{
+
+	/* Check limitations.
+		1. System must be running (weird things happen during bootup)
+		2. Size >64KB. Smaller requests cause too much bte traffic
+	 */
+	if (len >= BTE_MAX_XFER || len < 60000 || system_state != SYSTEM_RUNNING)
+		return EINVAL;
+
+	return bte_zero(ia64_tpa(p), len, 0, NULL);
+}
+
+static struct zero_driver bte_bzero = {
+	.start = bte_start_bzero,
+};

+void sn_bte_bzero_init(void) {
+	register_zero_driver(&bte_bzero);
 }
Index: linux-2.6.10/arch/ia64/sn/kernel/setup.c
===================================================================
--- linux-2.6.10.orig/arch/ia64/sn/kernel/setup.c	2005-02-03 13:33:33.000000000 -0800
+++ linux-2.6.10/arch/ia64/sn/kernel/setup.c	2005-02-03 18:08:26.000000000 -0800
@@ -251,6 +251,7 @@ void __init sn_setup(char **cmdline_p)
 	int pxm;
 	int major = sn_sal_rev_major(), minor = sn_sal_rev_minor();
 	extern void sn_cpu_init(void);
+	extern void sn_bte_bzero_init(void);

 	/*
 	 * If the generic code has enabled vga console support - lets
@@ -341,6 +342,7 @@ void __init sn_setup(char **cmdline_p)
 	screen_info = sn_screen_info;

 	sn_timer_init();
+	sn_bte_bzero_init();
 }

 /**

