Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWHJULS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWHJULS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWHJTga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:30 -0400
Received: from ns.suse.de ([195.135.220.2]:49040 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932622AbWHJTg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:27 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [70/145] x86_64: initialize end of memory variables as early as possible
Message-Id: <20060810193626.45F5313C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:26 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: "Jan Beulich" <jbeulich@novell.com>
While an earlier patch already did a small step into that direction,
this patch moves initialization of all memory end variables to as
early as possible, so that dependent code doesn't need to check
whether these variables have already been set.

Also, remove a misleading (perhaps just outdated) comment, and make
static a variable only used in a single file.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/e820.c  |    2 +-
 arch/x86_64/kernel/setup.c |    7 ++++++-
 arch/x86_64/mm/init.c      |    6 ------
 3 files changed, 7 insertions(+), 8 deletions(-)

Index: linux/arch/x86_64/kernel/e820.c
===================================================================
--- linux.orig/arch/x86_64/kernel/e820.c
+++ linux/arch/x86_64/kernel/e820.c
@@ -40,7 +40,7 @@ unsigned long end_pfn_map; 
 /* 
  * Last pfn which the user wants to use.
  */
-unsigned long end_user_pfn = MAXMEM>>PAGE_SHIFT;  
+static unsigned long __initdata end_user_pfn = MAXMEM>>PAGE_SHIFT;
 
 extern struct resource code_resource, data_resource;
 
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -556,7 +556,7 @@ void __init setup_arch(char **cmdline_p)
 	 * we are rounding upwards:
 	 */
 	end_pfn = e820_end_of_ram();
-	num_physpages = end_pfn;		/* for pfn_valid */
+	num_physpages = end_pfn;
 
 	check_efer();
 
@@ -576,6 +576,11 @@ void __init setup_arch(char **cmdline_p)
 	acpi_boot_table_init();
 #endif
 
+	/* How many end-of-memory variables you have, grandma! */
+	max_low_pfn = end_pfn;
+	max_pfn = end_pfn;
+	high_memory = (void *)__va(end_pfn * PAGE_SIZE - 1) + 1;
+
 #ifdef CONFIG_ACPI_NUMA
 	/*
 	 * Parse SRAT to discover nodes.
Index: linux/arch/x86_64/mm/init.c
===================================================================
--- linux.orig/arch/x86_64/mm/init.c
+++ linux/arch/x86_64/mm/init.c
@@ -597,12 +597,6 @@ void __init mem_init(void)
 
 	pci_iommu_alloc();
 
-	/* How many end-of-memory variables you have, grandma! */
-	max_low_pfn = end_pfn;
-	max_pfn = end_pfn;
-	num_physpages = end_pfn;
-	high_memory = (void *) __va(end_pfn * PAGE_SIZE);
-
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
 
