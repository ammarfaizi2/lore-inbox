Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264474AbTLVVXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTLVVXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:23:46 -0500
Received: from users.ccur.com ([208.248.32.211]:52983 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S264474AbTLVVXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:23:36 -0500
Date: Mon, 22 Dec 2003 16:22:37 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Rob Love <rml@ximian.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: atomic copy_from_user?
Message-ID: <20031222212237.GA2865@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <1072054100.1742.156.camel@cube> <20031222150026.GD27687@holomorphy.com> <20031222182637.GA2659@rudolph.ccur.com> <1072126506.3318.31.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072126506.3318.31.camel@fur>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 03:55:06PM -0500, Rob Love wrote:
> On Mon, 2003-12-22 at 13:26, Joe Korty wrote:
> 
> > Shouldn't the dec_prempt_count() in kunmap_atomic() be followed
> > by a preempt_check_resched()???
> 
> Probably.
> 
> Actually, dec_preempt_count() ought to call preempt_check_resched()
> itself.  In the case of !CONFIG_PREEMPT, that call would simply optimize
> away.
> 
> Attached patch is against 2.6.0.
> 
> 	Rob Love
> 
> 
>  linux/preempt.h |    1 +
>  1 files changed, 1 insertion(+)
> 
> diff -urN include/linux/preempt.h.orig include/linux/preempt.h
> --- include/linux/preempt.h.orig	2003-12-22 15:53:11.329113296 -0500
> +++ include/linux/preempt.h	2003-12-22 15:53:51.314034664 -0500
> @@ -18,6 +18,7 @@
>  #define dec_preempt_count() \
>  do { \
>  	preempt_count()--; \
> +	preempt_check_resched(); \
>  } while (0)
>  
>  #ifdef CONFIG_PREEMPT


I am guessing that nowdays even when preemption is disabled one can
find preempt_count still being used somewhere.  Otherwise it would be
better to replace all uses of inc_preempt_count() with
preempt_disable() and dec_preempt_count() with preempt_enable().

Joe

diff -ura base/arch/i386/mm/highmem.c new/arch/i386/mm/highmem.c
--- base/arch/i386/mm/highmem.c	2003-12-17 21:58:56.000000000 -0500
+++ new/arch/i386/mm/highmem.c	2003-12-22 16:16:27.000000000 -0500
@@ -30,7 +30,7 @@
 	enum fixed_addresses idx;
 	unsigned long vaddr;
 
-	inc_preempt_count();
+	preempt_disable();
 	if (page < highmem_start_page)
 		return page_address(page);
 
@@ -53,7 +53,7 @@
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
 	if (vaddr < FIXADDR_START) { // FIXME
-		dec_preempt_count();
+		preempt_enable();
 		return;
 	}
 
@@ -68,7 +68,7 @@
 	__flush_tlb_one(vaddr);
 #endif
 
-	dec_preempt_count();
+	preempt_enable();
 }
 
 struct page *kmap_atomic_to_page(void *ptr)
diff -ura base/arch/mips/mm/highmem.c new/arch/mips/mm/highmem.c
--- base/arch/mips/mm/highmem.c	2003-12-17 21:58:28.000000000 -0500
+++ new/arch/mips/mm/highmem.c	2003-12-22 16:17:28.000000000 -0500
@@ -40,7 +40,7 @@
 	enum fixed_addresses idx;
 	unsigned long vaddr;
 
-	inc_preempt_count();
+	preempt_disable();
 	if (page < highmem_start_page)
 		return page_address(page);
 
@@ -63,7 +63,7 @@
 	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
 
 	if (vaddr < FIXADDR_START) { // FIXME
-		dec_preempt_count();
+		preempt_enable();
 		return;
 	}
 
@@ -78,7 +78,7 @@
 	local_flush_tlb_one(vaddr);
 #endif
 
-	dec_preempt_count();
+	preempt_enable();
 }
 
 struct page *kmap_atomic_to_page(void *ptr)
diff -ura base/arch/sparc/mm/highmem.c new/arch/sparc/mm/highmem.c
--- base/arch/sparc/mm/highmem.c	2003-12-17 21:58:28.000000000 -0500
+++ new/arch/sparc/mm/highmem.c	2003-12-22 16:17:02.000000000 -0500
@@ -33,7 +33,7 @@
 	unsigned long idx;
 	unsigned long vaddr;
 
-	inc_preempt_count();
+	preempt_disable();
 	if (page < highmem_start_page)
 		return page_address(page);
 
@@ -68,7 +68,7 @@
 	unsigned long idx = type + KM_TYPE_NR*smp_processor_id();
 
 	if (vaddr < fix_kmap_begin) { // FIXME
-		dec_preempt_count();
+		preempt_enable();
 		return;
 	}
 
@@ -95,5 +95,5 @@
 	flush_tlb_all();
 #endif
 #endif
-	dec_preempt_count();
+	preempt_enable();
 }
diff -ura base/include/asm-ppc/highmem.h new/include/asm-ppc/highmem.h
--- base/include/asm-ppc/highmem.h	2003-12-17 21:59:45.000000000 -0500
+++ new/include/asm-ppc/highmem.h	2003-12-22 16:18:05.000000000 -0500
@@ -81,7 +81,7 @@
 	unsigned int idx;
 	unsigned long vaddr;
 
-	inc_preempt_count();
+	preempt_disable();
 	if (page < highmem_start_page)
 		return page_address(page);
 
@@ -104,7 +104,7 @@
 	unsigned int idx = type + KM_TYPE_NR*smp_processor_id();
 
 	if (vaddr < KMAP_FIX_BEGIN) { // FIXME
-		dec_preempt_count();
+		preempt_disable();
 		return;
 	}
 
@@ -118,7 +118,7 @@
 	pte_clear(kmap_pte+idx);
 	flush_tlb_page(0, vaddr);
 #endif
-	dec_preempt_count();
+	preempt_enable();
 }
 
 static inline struct page *kmap_atomic_to_page(void *ptr)
