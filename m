Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264557AbTLVWgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 17:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264565AbTLVWgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 17:36:42 -0500
Received: from users.ccur.com ([208.248.32.211]:44761 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S264557AbTLVWgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 17:36:38 -0500
Date: Mon, 22 Dec 2003 17:35:48 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Rob Love <rml@ximian.com>
Cc: Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       albert@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: atomic copy_from_user?
Message-ID: <20031222223547.GA3737@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <1072054100.1742.156.camel@cube> <20031222150026.GD27687@holomorphy.com> <20031222182637.GA2659@rudolph.ccur.com> <1072126506.3318.31.camel@fur> <20031222141431.111e7611.akpm@osdl.org> <1072131587.3318.54.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072131587.3318.54.camel@fur>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 05:19:48PM -0500, Rob Love wrote:
> On Mon, 2003-12-22 at 17:14, Andrew Morton wrote:
> 
> > But preempt_enable_no_resched() calls dec_preempt_count().
> 
> Yah, Joe just pointed that out.
> 
> I do not really want to change the base interfaces, anyway ;)
> 
> I do think we should add an explicit preempt_check_resched() after calls
> to dec_preempt_count() where we might be delaying a reschedule, though.

Thanks, Robert and Andrew, for you explanations.  This patch should
do the trick.

Joe


diff -ura base/arch/i386/mm/highmem.c new/arch/i386/mm/highmem.c
--- base/arch/i386/mm/highmem.c	2003-12-17 21:58:56.000000000 -0500
+++ new/arch/i386/mm/highmem.c	2003-12-22 17:32:46.000000000 -0500
@@ -30,6 +30,7 @@
 	enum fixed_addresses idx;
 	unsigned long vaddr;
 
+	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	inc_preempt_count();
 	if (page < highmem_start_page)
 		return page_address(page);
@@ -54,6 +55,7 @@
 
 	if (vaddr < FIXADDR_START) { // FIXME
 		dec_preempt_count();
+		preempt_check_resched();
 		return;
 	}
 
@@ -69,6 +71,7 @@
 #endif
 
 	dec_preempt_count();
+	preempt_check_resched();
 }
 
 struct page *kmap_atomic_to_page(void *ptr)
diff -ura base/arch/mips/mm/highmem.c new/arch/mips/mm/highmem.c
--- base/arch/mips/mm/highmem.c	2003-12-17 21:58:28.000000000 -0500
+++ new/arch/mips/mm/highmem.c	2003-12-22 17:32:59.000000000 -0500
@@ -40,6 +40,7 @@
 	enum fixed_addresses idx;
 	unsigned long vaddr;
 
+	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	inc_preempt_count();
 	if (page < highmem_start_page)
 		return page_address(page);
@@ -64,6 +65,7 @@
 
 	if (vaddr < FIXADDR_START) { // FIXME
 		dec_preempt_count();
+		preempt_check_resched();
 		return;
 	}
 
@@ -79,6 +81,7 @@
 #endif
 
 	dec_preempt_count();
+	preempt_check_resched();
 }
 
 struct page *kmap_atomic_to_page(void *ptr)
diff -ura base/arch/sparc/mm/highmem.c new/arch/sparc/mm/highmem.c
--- base/arch/sparc/mm/highmem.c	2003-12-17 21:58:28.000000000 -0500
+++ new/arch/sparc/mm/highmem.c	2003-12-22 17:33:05.000000000 -0500
@@ -33,6 +33,7 @@
 	unsigned long idx;
 	unsigned long vaddr;
 
+	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	inc_preempt_count();
 	if (page < highmem_start_page)
 		return page_address(page);
@@ -69,6 +70,7 @@
 
 	if (vaddr < fix_kmap_begin) { // FIXME
 		dec_preempt_count();
+		preempt_check_resched();
 		return;
 	}
 
@@ -96,4 +98,5 @@
 #endif
 #endif
 	dec_preempt_count();
+	preempt_check_resched();
 }
diff -ura base/include/asm-ppc/highmem.h new/include/asm-ppc/highmem.h
--- base/include/asm-ppc/highmem.h	2003-12-17 21:59:45.000000000 -0500
+++ new/include/asm-ppc/highmem.h	2003-12-22 17:33:13.000000000 -0500
@@ -81,6 +81,7 @@
 	unsigned int idx;
 	unsigned long vaddr;
 
+	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
 	inc_preempt_count();
 	if (page < highmem_start_page)
 		return page_address(page);
@@ -105,6 +106,7 @@
 
 	if (vaddr < KMAP_FIX_BEGIN) { // FIXME
 		dec_preempt_count();
+		preempt_check_resched();
 		return;
 	}
 
@@ -119,6 +121,7 @@
 	flush_tlb_page(0, vaddr);
 #endif
 	dec_preempt_count();
+	preempt_check_resched();
 }
 
 static inline struct page *kmap_atomic_to_page(void *ptr)
