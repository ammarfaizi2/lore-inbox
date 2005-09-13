Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVIMPyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVIMPyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVIMPyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:54:24 -0400
Received: from serv01.siteground.net ([70.85.91.68]:6812 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964819AbVIMPyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:54:23 -0400
Date: Tue, 13 Sep 2005 08:54:16 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 1/11] mm: Reimplementation of dynamic per-cpu allocator -- vmalloc_fixup
Message-ID: <20050913155416.GC3570@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913155112.GB3570@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to add gfp_flags as args to __get_vm_area.  alloc_percpu needs to use
GFP flags as the dst_entry.refcount needs to be allocated with GFP_ATOMIC.
Since alloc_percpu needs get_vm_area underneath, this patch changes
__get_vmarea to accept gfp_flags as arg, so that alloc_percpu can use
__get_vm_area.  get_vm_area remains unchanged.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: alloc_percpu-2.6.13-rc6/arch/arm/kernel/module.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/arch/arm/kernel/module.c	2005-06-17 12:48:29.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/arch/arm/kernel/module.c	2005-08-14 23:03:49.000000000 -0700
@@ -40,7 +40,8 @@
 	if (!size)
 		return NULL;
 
-	area = __get_vm_area(size, VM_ALLOC, MODULE_START, MODULE_END);
+	area = __get_vm_area(size, VM_ALLOC, MODULE_START, MODULE_END,
+				GFP_KERNEL);
 	if (!area)
 		return NULL;
 
Index: alloc_percpu-2.6.13-rc6/arch/sh/kernel/cpu/sh4/sq.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/arch/sh/kernel/cpu/sh4/sq.c	2005-06-17 12:48:29.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/arch/sh/kernel/cpu/sh4/sq.c	2005-08-14 23:04:48.000000000 -0700
@@ -189,7 +189,8 @@
 	 * writeout before we hit the TLB flush, we do it anyways. This way
 	 * we at least save ourselves the initial page fault overhead.
 	 */
-	vma = __get_vm_area(map->size, VM_ALLOC, map->sq_addr, SQ_ADDRMAX);
+	vma = __get_vm_area(map->size, VM_ALLOC, map->sq_addr, SQ_ADDRMAX,
+				GFP_KERNEL);
 	if (!vma)
 		return ERR_PTR(-ENOMEM);
 
Index: alloc_percpu-2.6.13-rc6/arch/sparc64/kernel/module.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/arch/sparc64/kernel/module.c	2005-06-17 12:48:29.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/arch/sparc64/kernel/module.c	2005-08-14 23:05:49.000000000 -0700
@@ -25,7 +25,8 @@
 	if (!size || size > MODULES_LEN)
 		return NULL;
 
-	area = __get_vm_area(size, VM_ALLOC, MODULES_VADDR, MODULES_END);
+	area = __get_vm_area(size, VM_ALLOC, MODULES_VADDR, MODULES_END,
+				GFP_KERNEL);
 	if (!area)
 		return NULL;
 
Index: alloc_percpu-2.6.13-rc6/arch/x86_64/kernel/module.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/arch/x86_64/kernel/module.c	2005-06-17 12:48:29.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/arch/x86_64/kernel/module.c	2005-08-14 23:06:28.000000000 -0700
@@ -48,7 +48,8 @@
 	if (size > MODULES_LEN)
 		return NULL;
 
-	area = __get_vm_area(size, VM_ALLOC, MODULES_VADDR, MODULES_END);
+	area = __get_vm_area(size, VM_ALLOC, MODULES_VADDR, MODULES_END,
+				GFP_KERNEL);
 	if (!area)
 		return NULL;
 
Index: alloc_percpu-2.6.13-rc6/include/linux/vmalloc.h
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/include/linux/vmalloc.h	2005-06-17 12:48:29.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/include/linux/vmalloc.h	2005-08-14 23:12:29.000000000 -0700
@@ -39,7 +39,8 @@
  */
 extern struct vm_struct *get_vm_area(unsigned long size, unsigned long flags);
 extern struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
-					unsigned long start, unsigned long end);
+					unsigned long start, unsigned long end,
+					unsigned int gfpflags);
 extern struct vm_struct *remove_vm_area(void *addr);
 extern struct vm_struct *__remove_vm_area(void *addr);
 extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
Index: alloc_percpu-2.6.13-rc6/mm/vmalloc.c
===================================================================
--- alloc_percpu-2.6.13-rc6.orig/mm/vmalloc.c	2005-06-17 12:48:29.000000000 -0700
+++ alloc_percpu-2.6.13-rc6/mm/vmalloc.c	2005-08-14 22:29:31.000000000 -0700
@@ -161,7 +161,8 @@
 #define IOREMAP_MAX_ORDER	(7 + PAGE_SHIFT)	/* 128 pages */
 
 struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
-				unsigned long start, unsigned long end)
+				unsigned long start, unsigned long end,
+				unsigned int gfp_flags)
 {
 	struct vm_struct **p, *tmp, *area;
 	unsigned long align = 1;
@@ -180,7 +181,7 @@
 	addr = ALIGN(start, align);
 	size = PAGE_ALIGN(size);
 
-	area = kmalloc(sizeof(*area), GFP_KERNEL);
+	area = kmalloc(sizeof(*area), gfp_flags);
 	if (unlikely(!area))
 		return NULL;
 
@@ -245,7 +246,8 @@
  */
 struct vm_struct *get_vm_area(unsigned long size, unsigned long flags)
 {
-	return __get_vm_area(size, flags, VMALLOC_START, VMALLOC_END);
+	return __get_vm_area(size, flags, VMALLOC_START, VMALLOC_END, 
+				GFP_KERNEL);
 }
 
 /* Caller must hold vmlist_lock */
