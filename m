Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311403AbSDAK1q>; Mon, 1 Apr 2002 05:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311418AbSDAK1g>; Mon, 1 Apr 2002 05:27:36 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:725 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S311403AbSDAK10>; Mon, 1 Apr 2002 05:27:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Define struct page early - uml patch
Date: Mon, 1 Apr 2002 02:25:49 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020324112659Z16123-25734+21@humbolt.nl.linux.org> <20020324234249.GA10457@holomorphy.com> <20020327002358Z16384-8743+61@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020401102718Z16098-8743+335@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 26, 2002 04:22 pm, Daniel Phillips wrote:
> As soon as I had the inline version of __pa, it picked up an oversight where
> Jeff uses virtual addresses in his page tables instead of physical addresses.
> It works in the case of uml, but it's quite unexpected and has only gone
> unnoticed this long because of weak type checking due to use of macros.

Further to that, here's the patch I sent to Jeff Dike that changes the contents
of UML's page tables from virtual to physical addresses.  (UML 'physical'
addresses are are really user virtual addresses in a memory-mapped file, and its
kernel 'virtual' addresses are just constant offsets from that, as in native
Linux.)  It's interesting that only three lines had to be changed.  Nonetheless,
to find the correct three lines I had to make several hundred lines worth of
changes, to discover all the paths affected by the change from virtual to
physical.  The BUG added below is on a path that was certainly wrong in the
original but is never used, which is proven by booting UML with the BUG.

The new version is not less efficient than the original, perhaps slightly more
efficient if anything.  It is a whole lot more correct.

This together with the previously described header file cleanup put me in
position to test a UML prototype of a CONFIG_NONLINEAR option that maps
nonlinear physical memory to linear, contiguous kernel virtual addresses.

--- ../2.4.17.uml.clean/arch/um/kernel/process_kern.c	Mon Mar 25 17:27:26 2002
+++ ./arch/um/kernel/process_kern.c	Thu Mar 28 00:14:34 2002
@@ -501,12 +501,8 @@
 #ifdef CONFIG_SMP
 	return("(Unknown)");
 #else
-	unsigned long addr;
-
-	if((addr = um_virt_to_phys(current, 
-				   current->mm->arg_start)) == 0xffffffff) 
-		return("(Unknown)");
-	else return((char *) addr);
+	unsigned long addr = um_virt_to_phys(current, current->mm->arg_start);
+	return addr == 0xffffffff? "(Unknown)": __va(addr);
 #endif
 }
 
--- ../2.4.17.uml.clean/include/asm-um/pgtable.h	Mon Mar 25 17:27:28 2002
+++ ./include/asm-um/pgtable.h	Thu Mar 28 00:35:51 2002
@@ -197,9 +197,8 @@
 #define page_address(page) ({ if (!(page)->virtual) BUG(); (page)->virtual; })
 #define __page_address(page) ({ PAGE_OFFSET + (((page) - mem_map) << PAGE_SHIFT); })
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
-#define pte_page(x) \
-    (mem_map+((unsigned long)((__pa(pte_val(x)) >> PAGE_SHIFT))))
-#define pte_address(x) ((void *) ((unsigned long) pte_val(x) & PAGE_MASK))
+#define pte_page(x) (mem_map + (pte_val(x) >> PAGE_SHIFT))
+#define pte_address(x) (__va(pte_val(x) & PAGE_MASK))
 
 static inline pte_t pte_mknewprot(pte_t pte)
 {
@@ -316,15 +315,14 @@
 #define mk_pte(page, pgprot) \
 ({					\
 	pte_t __pte;                    \
-                                        \
-	pte_val(__pte) = ((unsigned long) __va((page-mem_map)*(unsigned long)PAGE_SIZE + pgprot_val(pgprot)));         \
+	pte_val(__pte) = ((page - mem_map) << PAGE_SHIFT) + pgprot_val(pgprot); \
 	if(pte_present(__pte)) pte_mknewprot(pte_mknewpage(__pte)); \
 	__pte;                          \
 })
 
 /* This takes a physical page address that is used by the remapping functions */
 #define mk_pte_phys(physpage, pgprot) \
-({ pte_t __pte; pte_val(__pte) = physpage + pgprot_val(pgprot); __pte; })
+({ pte_t __pte; pte_val(__pte) = physpage + pgprot_val(pgprot); BUG(); __pte; })
 
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {


