Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUC1Ni3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 08:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUC1Ni3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 08:38:29 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:2570 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261292AbUC1NiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 08:38:24 -0500
Date: Sun, 28 Mar 2004 15:38:17 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, jhartmann@precisioninsight.com
Subject: [PATCH-2.4.26] AGPGART cleanup
Message-ID: <20040328133817.GI24421@pcw.home.local>
References: <20040328042608.GA17969@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328042608.GA17969@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Jeff,

drivers/char/agp/agpgart_be.c defines several agp_generic_*
functions for chipsets which do not need a specific one.
Unfortunately, a lot of chipsets don't use them all, so in
most cases, some of them are defined but not used. This makes
gcc print warnings and adds useless code. This afternoon, I
felt brave and added all the #ifdef needed depending on what
the chipsets use. I did it carefully, so I think I did not
miss any, but a second check might be useful. An interesting
side effect is that it reduced the driver by about 2 kB for a
VIA chipset.

Here is the patch against 2.4.26-rc1. I don't know if it's
too late for 2.4.26, but at least it could be reviewed.

Cheers,
Willy


--- ./drivers/char/agp/agpgart_be.c.orig	Sun Mar 28 11:48:47 2004
+++ ./drivers/char/agp/agpgart_be.c	Sun Mar 28 15:28:29 2004
@@ -398,6 +398,8 @@
 
 /* Generic Agp routines - Start */
 
+#if CONFIG_AGP_I460 || CONFIG_AGP_INTEL || CONFIG_AGP_VIA || CONFIG_AGP_SIS \
+ || CONFIG_AGP_AMD || CONFIG_AGP_ALI || CONFIG_AGP_NVIDIA || CONFIG_AGP_ATI
 static void agp_generic_agp_enable(u32 mode)
 {
 	struct pci_dev *device = NULL;
@@ -490,7 +492,10 @@
 			pci_write_config_dword(device, cap_ptr + 8, command);
 	}
 }
+#endif /* CONFIG_AGP_* */
 
+#if CONFIG_AGP_I810 || CONFIG_AGP_INTEL || CONFIG_AGP_VIA || CONFIG_AGP_SIS \
+ || CONFIG_AGP_AMD_K8 || CONFIG_AGP_ALI || CONFIG_AGP_NVIDIA
 static int agp_generic_create_gatt_table(void)
 {
 	char *table;
@@ -614,7 +619,11 @@
 
 	return 0;
 }
+#endif /* CONFIG_AGP_* */
 
+#if CONFIG_AGP_I810 || CONFIG_AGP_I460 || CONFIG_AGP_INTEL || CONFIG_AGP_VIA \
+ || CONFIG_AGP_SIS || CONFIG_AGP_AMD || CONFIG_AGP_AMD_K8 || CONFIG_AGP_ALI \
+ || CONFIG_AGP_SWORKS || CONFIG_AGP_NVIDIA || CONFIG_AGP_ATI
 static int agp_generic_suspend(void)
 {
 	return 0;
@@ -624,7 +633,10 @@
 {
 	return;
 }
+#endif /* CONFIG_AGP_* */
 
+#if CONFIG_AGP_I810 || CONFIG_AGP_INTEL || CONFIG_AGP_VIA || CONFIG_AGP_SIS \
+ || CONFIG_AGP_AMD_K8 || CONFIG_AGP_ALI || CONFIG_AGP_NVIDIA
 static int agp_generic_free_gatt_table(void)
 {
 	int page_order;
@@ -675,7 +687,9 @@
 	free_pages((unsigned long) agp_bridge.gatt_table_real, page_order);
 	return 0;
 }
+#endif /* CONFIG_AGP_* */
 
+#if CONFIG_AGP_INTEL || CONFIG_AGP_VIA || CONFIG_AGP_SIS || CONFIG_AGP_ALI
 static int agp_generic_insert_memory(agp_memory * mem,
 				     off_t pg_start, int type)
 {
@@ -737,7 +751,11 @@
 	agp_bridge.tlb_flush(mem);
 	return 0;
 }
+#endif /* CONFIG_AGP_* */
 
+
+#if CONFIG_AGP_INTEL || CONFIG_AGP_VIA || CONFIG_AGP_SIS || CONFIG_AMD_K8 \
+ || CONFIG_AGP_ALI
 static int agp_generic_remove_memory(agp_memory * mem, off_t pg_start,
 				     int type)
 {
@@ -755,7 +773,12 @@
 	agp_bridge.tlb_flush(mem);
 	return 0;
 }
+#endif /* CONFIG_AGP_* */
+
 
+#if CONFIG_AGP_I460 || CONFIG_AGP_INTEL || CONFIG_AGP_VIA || CONFIG_AGP_SIS \
+ || CONFIG_AGP_AMD || CONFIG_AGP_AMD_K8 || CONFIG_AGP_ALI || CONFIG_AGP_SWORKS \
+ || CONFIG_AGP_NVIDIA || CONFIG_AGP_HP_ZX1 ||  CONFIG_AGP_ATI
 static agp_memory *agp_generic_alloc_by_type(size_t page_count, int type)
 {
 	return NULL;
@@ -769,6 +792,7 @@
 	agp_free_key(curr->key);
 	kfree(curr);
 }
+#endif /* CONFIG_AGP_* */
 
 /* 
  * Basic Page Allocation Routines -
@@ -779,6 +803,9 @@
  * against a maximum value.
  */
 
+#if CONFIG_AGP_I810 || CONFIG_AGP_INTEL || CONFIG_AGP_VIA || CONFIG_AGP_SIS \
+ || CONFIG_AGP_AMD || CONFIG_AGP_AMD_K8 || CONFIG_AGP_ALI || CONFIG_AGP_SWORKS \
+ || CONFIG_AGP_NVIDIA || CONFIG_AGP_HP_ZX1 ||  CONFIG_AGP_ATI
 static unsigned long agp_generic_alloc_page(void)
 {
 	struct page * page;
@@ -798,7 +825,11 @@
 	atomic_inc(&agp_bridge.current_memory_agp);
 	return (unsigned long)page_address(page);
 }
+#endif /* CONFIG_AGP_* */
 
+#if CONFIG_AGP_I810 || CONFIG_AGP_INTEL || CONFIG_AGP_VIA || CONFIG_AGP_SIS \
+ || CONFIG_AGP_AMD || CONFIG_AGP_AMD_K8 || CONFIG_AGP_SWORKS \
+ || CONFIG_AGP_NVIDIA || CONFIG_AGP_HP_ZX1 ||  CONFIG_AGP_ATI
 static void agp_generic_destroy_page(unsigned long addr)
 {
 	void *pt = (void *) addr;
@@ -817,6 +848,7 @@
 	free_page((unsigned long) pt);
 	atomic_dec(&agp_bridge.current_memory_agp);
 }
+#endif /* CONFIG_AGP_* */
 
 /* End Basic Page Allocation Routines */
 
