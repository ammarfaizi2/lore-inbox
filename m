Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbUKQDcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbUKQDcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbUKQDcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:32:18 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:13828
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262189AbUKQDcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:32:05 -0500
Message-Id: <200411170545.iAH5jQm7007146@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: user-mode-linux-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Another bug report for UML in latest Linux 2.6-BK repository. 
In-Reply-To: Your message of "Tue, 16 Nov 2004 13:41:11 GMT."
             <1100612471.24599.42.camel@imp.csi.cam.ac.uk> 
References: <1100612471.24599.42.camel@imp.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 17 Nov 2004 00:45:26 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aia21@cam.ac.uk said:
> If I enable HIGHMEM in my .config (see my previous bug report for my
> .config and just change HIGHMEM to enabled) compilation fails: 

The patch below fixes it.

				Jeff

Index: 2.6.9/arch/um/Kconfig
===================================================================
--- 2.6.9.orig/arch/um/Kconfig	2004-11-16 21:25:38.000000000 -0500
+++ 2.6.9/arch/um/Kconfig	2004-11-16 21:44:53.000000000 -0500
@@ -224,7 +224,15 @@
 
 config HIGHMEM
 	bool "Highmem support"
-	depends on BROKEN
+	default n
+	help
+	This enables UML's highmem support.  This allows UML to have
+	more physical memory than it can map into its virtual address
+	space.  In tt mode, or with CONFIG_MODE_TT enabled, the limit is a
+	bit less than 512M.  With CONFIG_MODE_TT disabled and
+	CONFIG_LOAD_LOW and CONFIG_STATIC_LINK enabled, the limit is
+	around 2.75G.
+	Enabling this option slows down UML, signficantly in skas mode.
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
Index: 2.6.9/arch/um/kernel/mem.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/mem.c	2004-11-16 21:54:53.000000000 -0500
+++ 2.6.9/arch/um/kernel/mem.c	2004-11-16 21:55:45.000000000 -0500
@@ -68,7 +68,7 @@
 
 	max_low_pfn = (high_physmem - uml_physmem) >> PAGE_SHIFT;
 #ifdef CONFIG_HIGHMEM
-	highmem_start_page = phys_page(__pa(high_physmem));
+	highmem_start_page = pfn_to_page(phys_to_pfn(__pa(high_physmem)));
 #endif
 
         /* clear the zero-page */
@@ -140,7 +140,7 @@
 pgprot_t kmap_prot;
 
 #define kmap_get_fixmap_pte(vaddr)					\
-	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr),
+	pte_offset_kernel(pmd_offset(pml4_pgd_offset(pml4_offset_k(vaddr), \
 						     vaddr), (vaddr)), (vaddr))
 
 void __init kmap_init(void)

