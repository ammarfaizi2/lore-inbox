Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVJNJmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVJNJmU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 05:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVJNJmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 05:42:19 -0400
Received: from fairlite.demon.co.uk ([80.176.228.186]:32656 "EHLO
	windows.demon.co.uk") by vger.kernel.org with ESMTP id S932175AbVJNJmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 05:42:19 -0400
Date: Fri, 14 Oct 2005 10:42:17 +0100
From: Alan Hourihane <alanh@fairlite.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.14-rc4 AGP performance fixes
Message-ID: <20051014094217.GA15871@fairlite.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AGP allocation/deallocation is suffering major performance issues due to the 
nature of global_flush_tlb() being called on every change_page_attr() call.

For small allocations this isn't really seen, but when you start allocating
50000 pages of AGP space, for say, texture memory, then things can take 
seconds to complete.

In some cases the situation is doubled or even quadrupled in the time due 
to SMP, or a deallocation, then a new reallocation. I've had a case of 
upto 20 seconds wait time to deallocate and reallocate AGP space.

This patch fixes the problem by making it the caller's responsibility to 
call global_flush_tlb(), and so removes it from every instance of mapping 
a page into AGP space until the time that all change_page_attr() changes 
are done.

Patch is against 2.6.14-rc4.

Alan.

diff -u linux-2.6.14-rc4.old/drivers/char/agp/backend.c linux-2.6.14-rc4/drivers/char/agp/backend.c
--- linux-2.6.14-rc4.old/drivers/char/agp/backend.c	2005-10-14 10:23:28.000000000 +0100
+++ linux-2.6.14-rc4/drivers/char/agp/backend.c	2005-10-14 10:23:37.000000000 +0100
@@ -147,6 +147,7 @@
 			printk(KERN_ERR PFX "unable to get memory for scratch page.\n");
 			return -ENOMEM;
 		}
+		global_flush_tlb();
 
 		bridge->scratch_page_real = virt_to_gart(addr);
 		bridge->scratch_page =
@@ -187,9 +188,11 @@
 	return 0;
 
 err_out:
-	if (bridge->driver->needs_scratch_page)
+	if (bridge->driver->needs_scratch_page) {
 		bridge->driver->agp_destroy_page(
 				gart_to_virt(bridge->scratch_page_real));
+		global_flush_tlb();
+	}
 	if (got_gatt)
 		bridge->driver->free_gatt_table(bridge);
 	if (got_keylist) {
@@ -211,9 +214,11 @@
 	bridge->key_list = NULL;
 
 	if (bridge->driver->agp_destroy_page &&
-	    bridge->driver->needs_scratch_page)
+	    bridge->driver->needs_scratch_page) {
 		bridge->driver->agp_destroy_page(
 				gart_to_virt(bridge->scratch_page_real));
+		global_flush_tlb();
+	}
 }
 
 /* When we remove the global variable agp_bridge from all drivers
diff -u linux-2.6.14-rc4.old/drivers/char/agp/generic.c linux-2.6.14-rc4/drivers/char/agp/generic.c
--- linux-2.6.14-rc4.old/drivers/char/agp/generic.c	2005-10-14 10:23:28.000000000 +0100
+++ linux-2.6.14-rc4/drivers/char/agp/generic.c	2005-10-14 10:23:37.000000000 +0100
@@ -57,7 +57,8 @@
 {
 	int i;
 	i = change_page_attr(page, 1, PAGE_KERNEL_NOCACHE);
-	global_flush_tlb();
+	/* Caller's responsibility to call global_flush_tlb() for
+	 * performance reasons */
 	return i;
 }
 EXPORT_SYMBOL_GPL(map_page_into_agp);
@@ -66,7 +67,8 @@
 {
 	int i;
 	i = change_page_attr(page, 1, PAGE_KERNEL);
-	global_flush_tlb();
+	/* Caller's responsibility to call global_flush_tlb() for
+	 * performance reasons */
 	return i;
 }
 EXPORT_SYMBOL_GPL(unmap_page_from_agp);
@@ -155,6 +157,7 @@
 		for (i = 0; i < curr->page_count; i++) {
 			curr->bridge->driver->agp_destroy_page(gart_to_virt(curr->memory[i]));
 		}
+		global_flush_tlb();
 	}
 	agp_free_key(curr->key);
 	vfree(curr->memory);
@@ -212,7 +215,9 @@
 		new->memory[i] = virt_to_gart(addr);
 		new->page_count++;
 	}
-       new->bridge = bridge;
+	global_flush_tlb();
+       
+	new->bridge = bridge;
 
 	flush_agp_mappings();
 
diff -u linux-2.6.14-rc4.old/drivers/char/agp/i460-agp.c linux-2.6.14-rc4/drivers/char/agp/i460-agp.c
--- linux-2.6.14-rc4.old/drivers/char/agp/i460-agp.c	2005-10-14 10:23:28.000000000 +0100
+++ linux-2.6.14-rc4/drivers/char/agp/i460-agp.c	2005-10-14 10:24:26.000000000 +0100
@@ -514,9 +514,10 @@
 {
 	void *page;
 
-	if (I460_IO_PAGE_SHIFT <= PAGE_SHIFT)
+	if (I460_IO_PAGE_SHIFT <= PAGE_SHIFT) {
 		page = agp_generic_alloc_page(agp_bridge);
-	else
+		global_flush_tlb();
+	} else
 		/* Returning NULL would cause problems */
 		/* AK: really dubious code. */
 		page = (void *)~0UL;
@@ -525,8 +526,10 @@
 
 static void i460_destroy_page (void *page)
 {
-	if (I460_IO_PAGE_SHIFT <= PAGE_SHIFT)
+	if (I460_IO_PAGE_SHIFT <= PAGE_SHIFT) {
 		agp_generic_destroy_page(page);
+		global_flush_tlb();
+	}
 }
 
 #endif /* I460_LARGE_IO_PAGES */
diff -u linux-2.6.14-rc4.old/drivers/char/agp/intel-agp.c linux-2.6.14-rc4/drivers/char/agp/intel-agp.c
--- linux-2.6.14-rc4.old/drivers/char/agp/intel-agp.c	2005-10-14 10:23:28.000000000 +0100
+++ linux-2.6.14-rc4/drivers/char/agp/intel-agp.c	2005-10-14 10:23:37.000000000 +0100
@@ -270,6 +270,7 @@
 
 	switch (pg_count) {
 	case 1: addr = agp_bridge->driver->agp_alloc_page(agp_bridge);
+		global_flush_tlb();
 		break;
 	case 4:
 		/* kludge to get 4 physical pages for ARGB cursor */
@@ -330,9 +331,11 @@
 	if(curr->type == AGP_PHYS_MEMORY) {
 		if (curr->page_count == 4)
 			i8xx_destroy_pages(gart_to_virt(curr->memory[0]));
-		else
+		else {
 			agp_bridge->driver->agp_destroy_page(
 				 gart_to_virt(curr->memory[0]));
+			global_flush_tlb();
+		}
 		vfree(curr->memory);
 	}
 	kfree(curr);
