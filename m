Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265176AbTFMGmf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 02:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTFMGmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 02:42:35 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:6458 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S265176AbTFMGmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 02:42:32 -0400
Date: Thu, 12 Jun 2003 23:56:16 -0700
Message-Id: <200306130656.h5D6uGc32359@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: FIXMAP-related change to mm/memory.c
In-Reply-To: David Mosberger's message of  Thursday, 12 June 2003 23:37:30 -0700 <16105.28970.526326.249287@napali.hpl.hp.com>
X-Fcc: ~/Mail/linus
X-Zippy-Says: ..  does your DRESSING ROOM have enough ASPARAGUS?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you test Linus' proposal?  It would definitely do the trick for ia64.

This patch vs 2.5.70 works fine for me on x86.  include/asm-x86_64/fixmap.h
needs the macros added for its vsyscall page too.

Enjoy,
Roland


--- linux-2.5.70/include/asm-i386/fixmap.h.~1~	Mon May 26 18:00:21 2003
+++ linux-2.5.70/include/asm-i386/fixmap.h	Thu Jun 12 23:46:11 2003
@@ -107,6 +107,14 @@ extern void __set_fixmap (enum fixed_add
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
 
+/*
+ * This is the range that is readable by user mode, and things
+ * acting like user mode such as get_user_pages.
+ */
+#define FIXADDR_USER_START	(__fix_to_virt(FIX_VSYSCALL))
+#define FIXADDR_USER_END	(FIXADDR_USER_START + PAGE_SIZE)
+
+
 extern void __this_fixmap_does_not_exist(void);
 
 /*

--- linux-2.5.70/mm/memory.c.~1~	Mon May 26 18:00:39 2003
+++ linux-2.5.70/mm/memory.c	Thu Jun 12 23:41:04 2003
@@ -689,15 +689,16 @@ int get_user_pages(struct task_struct *t
 
 		vma = find_extend_vma(mm, start);
 
-#ifdef FIXADDR_START
-		if (!vma && start >= FIXADDR_START && start < FIXADDR_TOP) {
+#ifdef FIXADDR_USER_START
+		if (!vma &&
+		    start >= FIXADDR_USER_START && start < FIXADDR_USER_END) {
 			static struct vm_area_struct fixmap_vma = {
 				/* Catch users - if there are any valid
 				   ones, we can make this be "&init_mm" or
 				   something.  */
 				.vm_mm = NULL,
-				.vm_start = FIXADDR_START,
-				.vm_end = FIXADDR_TOP,
+				.vm_start = FIXADDR_USER_START,
+				.vm_end = FIXADDR_USER_END,
 				.vm_page_prot = PAGE_READONLY,
 				.vm_flags = VM_READ | VM_EXEC,
 			};
@@ -705,6 +706,8 @@ int get_user_pages(struct task_struct *t
 			pgd_t *pgd;
 			pmd_t *pmd;
 			pte_t *pte;
+			if (write) /* user fixmap pages are read-only */
+				return i ? : -EFAULT;
 			pgd = pgd_offset_k(pg);
 			if (!pgd)
 				return i ? : -EFAULT;
@@ -712,8 +715,7 @@ int get_user_pages(struct task_struct *t
 			if (!pmd)
 				return i ? : -EFAULT;
 			pte = pte_offset_kernel(pmd, pg);
-			if (!pte || !pte_present(*pte) || !pte_user(*pte) ||
-			    !(write ? pte_write(*pte) : pte_read(*pte)))
+			if (!pte || !pte_present(*pte))
 				return i ? : -EFAULT;
 			if (pages) {
 				pages[i] = pte_page(*pte);

