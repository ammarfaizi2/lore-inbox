Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268275AbUI2J17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268275AbUI2J17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 05:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268278AbUI2J17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 05:27:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:38812 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268275AbUI2J1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 05:27:54 -0400
Subject: [PATCH] ppc64: DART iommu allocation fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096449896.9331.15.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 19:24:57 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The current code allocating the DART has a couple of bugs, first
it's called on all machines including the ones who have no DART
(oops), and then it tries to access the device-tree using the
"of_chosen" pointer before it was initialized.

The enclosed patch fixes these.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== arch/ppc64/kernel/pmac_setup.c 1.8 vs edited =====
--- 1.8/arch/ppc64/kernel/pmac_setup.c	2004-09-27 19:12:49 +10:00
+++ edited/arch/ppc64/kernel/pmac_setup.c	2004-09-29 18:23:58 +10:00
@@ -447,6 +447,14 @@
 	if (platform != PLATFORM_POWERMAC)
 		return 0;
 
+	/*
+	 * On U3, the DART (iommu) must be allocated now since it
+	 * has an impact on htab_initialize (due to the large page it
+	 * occupies having to be broken up so the DART itself is not
+	 * part of the cacheable linar mapping
+	 */
+	alloc_u3_dart_table();
+
 	return 1;
 }
 
===== arch/ppc64/kernel/prom.c 1.101 vs edited =====
--- 1.101/arch/ppc64/kernel/prom.c	2004-09-22 19:56:16 +10:00
+++ edited/arch/ppc64/kernel/prom.c	2004-09-29 18:21:55 +10:00
@@ -83,6 +83,7 @@
 static int __initdata dt_root_addr_cells;
 static int __initdata dt_root_size_cells;
 static int __initdata iommu_is_off;
+int __initdata iommu_force_on;
 typedef u32 cell_t;
 
 #if 0
@@ -876,9 +877,11 @@
 		return 0;
 	systemcfg->platform = *prop;
 
-	/* check if iommu is forced off */
+	/* check if iommu is forced on or off */
 	if (get_flat_dt_prop(node, "linux,iommu-off", NULL) != NULL)
 		iommu_is_off = 1;
+	if (get_flat_dt_prop(node, "linux,iommu-force-on", NULL) != NULL)
+		iommu_force_on = 1;
 
 #ifdef CONFIG_PPC_PSERIES
 	/* To help early debugging via the front panel, we retreive a minimal
===== arch/ppc64/kernel/setup.c 1.80 vs edited =====
--- 1.80/arch/ppc64/kernel/setup.c	2004-09-27 19:12:49 +10:00
+++ edited/arch/ppc64/kernel/setup.c	2004-09-29 18:23:48 +10:00
@@ -406,16 +406,6 @@
 
 	DBG("Found, Initializing memory management...\n");
 
-#ifdef CONFIG_U3_DART
-	/*
-	 * On U3, the DART (iommu) must be allocated now since it
-	 * has an impact on htab_initialize (due to the large page it
-	 * occupies having to be broken up so the DART itself is not
-	 * part of the cacheable linar mapping
-	 */
-	alloc_u3_dart_table();
-#endif /* CONFIG_U3_DART */
-
 	/*
 	 * Initialize stab / SLB management
 	 */
===== arch/ppc64/kernel/u3_iommu.c 1.6 vs edited =====
--- 1.6/arch/ppc64/kernel/u3_iommu.c	2004-09-27 19:12:49 +10:00
+++ edited/arch/ppc64/kernel/u3_iommu.c	2004-09-29 18:22:24 +10:00
@@ -47,6 +47,7 @@
 
 #include "pci.h"
 
+extern int iommu_force_on;
 
 /* physical base of DART registers */
 #define DART_BASE        0xf8033000UL
@@ -305,8 +306,7 @@
 	/* Only reserve DART space if machine has more than 2GB of RAM
 	 * or if requested with iommu=on on cmdline.
 	 */
-	if (lmb_end_of_DRAM() <= 0x80000000ull &&
-	    get_property(of_chosen, "linux,iommu-force-on", NULL) == NULL)
+	if (lmb_end_of_DRAM() <= 0x80000000ull && !iommu_force_on)
 		return;
 
 	/* 512 pages (2MB) is max DART tablesize. */


