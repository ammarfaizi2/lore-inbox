Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbUK1Dyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbUK1Dyo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 22:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUK1Dyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 22:54:43 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:14533 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S261394AbUK1Dyk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 22:54:40 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org
Subject: [patch 1/3] kallsyms: Clean up x86-64 special casing of in_gate_area()
In-reply-to: Your message of "Sun, 28 Nov 2004 14:38:47 +1100."
             <28912.1101613127@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Nov 2004 14:54:31 +1100
Message-ID: <19427.1101614071@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86-64 has special case code for in_gate_area(), but it is not clean.

* Replace CONFIG_ARCH_GATE_AREA with __HAVE_ARCH_GATE_AREA.
  ARCH_GATE_AREA is not a config option.

* The definitions of get_gate_vma() and in_gate_area() are identical in
  include/asm-x86_64/page.h and include/linux/mm.h.  Fold the duplicate
  definitions into include/linux/mm.h.

Does not affect kallsyms directly, this patch just creates a clean base
for patch 2.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: 2.6.10-rc2-bk11/include/asm-x86_64/page.h
===================================================================
--- 2.6.10-rc2-bk11.orig/include/asm-x86_64/page.h	2004-11-15 14:26:40.778123375 +1100
+++ 2.6.10-rc2-bk11/include/asm-x86_64/page.h	2004-11-28 14:42:13.850863382 +1100
@@ -134,13 +134,7 @@ extern __inline__ int get_order(unsigned
 	(((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0 ) | \
 	 VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
-#define CONFIG_ARCH_GATE_AREA 1	
-
-#ifndef __ASSEMBLY__
-struct task_struct;
-struct vm_area_struct *get_gate_vma(struct task_struct *tsk);
-int in_gate_area(struct task_struct *task, unsigned long addr);
-#endif
+#define __HAVE_ARCH_GATE_AREA 1	
 
 #endif /* __KERNEL__ */
 
Index: 2.6.10-rc2-bk11/include/linux/mm.h
===================================================================
--- 2.6.10-rc2-bk11.orig/include/linux/mm.h	2004-11-28 14:41:04.390462272 +1100
+++ 2.6.10-rc2-bk11/include/linux/mm.h	2004-11-28 14:42:13.868860636 +1100
@@ -799,10 +799,8 @@ kernel_map_pages(struct page *page, int 
 }
 #endif
 
-#ifndef CONFIG_ARCH_GATE_AREA
 extern struct vm_area_struct *get_gate_vma(struct task_struct *tsk);
 int in_gate_area(struct task_struct *task, unsigned long addr);
-#endif
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MM_H */
Index: 2.6.10-rc2-bk11/mm/memory.c
===================================================================
--- 2.6.10-rc2-bk11.orig/mm/memory.c	2004-11-28 14:41:04.802399415 +1100
+++ 2.6.10-rc2-bk11/mm/memory.c	2004-11-28 14:42:13.870860331 +1100
@@ -1811,7 +1811,7 @@ unsigned long vmalloc_to_pfn(void * vmal
 
 EXPORT_SYMBOL(vmalloc_to_pfn);
 
-#if !defined(CONFIG_ARCH_GATE_AREA)
+#if !defined(__HAVE_ARCH_GATE_AREA)
 
 #if defined(AT_SYSINFO_EHDR)
 struct vm_area_struct gate_vma;
@@ -1846,4 +1846,4 @@ int in_gate_area(struct task_struct *tas
 	return 0;
 }
 
-#endif
+#endif	/* __HAVE_ARCH_GATE_AREA */

