Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbUKRStA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbUKRStA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbUKRSru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:47:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63108 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262862AbUKRSpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:45:02 -0500
Date: Thu, 18 Nov 2004 20:46:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] fix __flush_tlb*() preemption bug on CONFIG_PREEMPT
Message-ID: <20041118194619.GA23483@elte.hu>
References: <20041118124656.GA4256@elte.hu> <Pine.LNX.4.58.0411180742290.2222@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411180742290.2222@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Thu, 18 Nov 2004, Ingo Molnar wrote:
> > 
> > note that reproducing this bug was only possible under PREEMPT_RT (there
> > it can be triggered in 30 seconds, with the right reproducer) - it needs
> > a really unlikely scenario which PREEMPT_RT's high concurrency does
> > offer but which is apparently much harder to reproduce in the vanilla
> > kernel. The patch fixes x86 and x64. Other architectures are most likely
> > safe, but they need review as well.
> 
> Ok, that's a pretty race.
> 
> However, I'm wondering whether this is the proper approach. After all,
> a lazy-tlb process should never have any reason to flush its TLB,
> since "its TLB" just aint there, and it ends up flushing somebody
> elses.

e.g. it can happen with the init thread doing ioremap()s during driver
setup - there it's the kernel VM that gets modified and flushed. I
suspect driver-related ioremap() could in theory happen in just about
any thread context, and in fact during modprobe it will definitely
execute in a lazy-TLB context.

Another place where i've seen TLB flushes done with preemption enabled
is the flush_tlb_mm() in dup_mmap() - but here we should never be
lazy-TLB. But this case should be kept in mind nevertheless, if we ever
allow tasks to 'switch' the MM of another task asynchronously (e.g.
there are UML patches that do that), then this would be unsafe code too.

the third category is activate_mm() users (exec and aio), but they are
in a critical section due to lock_task(). (that is not a nonpreemptible
critical section on PREEMPT_RT though - probably this contributed to
this bug triggering more likely there.)

> So I assume that this happens only with kswapd or similar? It really
> might be interesting to make the "we were a lazy tlb, and we're
> flushing somebody else" case do a stack dump, because I _suspect_ that
> this really is a special thing, and maybe the right thing to do is to
> make it special in _that_ path.

yeah, if we have such a debugging check then it should be pretty safe to
find the places one by one and fix them. The patch below (against -rc2)
adds the debugging check and fixes ioremap, on x86. I've done a quick
testboot and it doesnt trigger any other warnings.

(maybe we want to change that check to WARN_ON(!preempt_count()), while
non-lazy-TLB tasks are fine right now, it's quite fragile i think to
allow a TLB flush to preempt and it's a ticking timebomb i think.)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/mm/ioremap.c.orig
+++ linux/arch/i386/mm/ioremap.c
@@ -93,7 +93,11 @@ static int remap_area_pages(unsigned lon
 		dir++;
 	} while (address && (address < end));
 	spin_unlock(&init_mm.page_table_lock);
+
+	preempt_disable();
 	flush_tlb_all();
+	preempt_enable();
+
 	return error;
 }
 
@@ -215,7 +219,9 @@ void __iomem *ioremap_nocache (unsigned 
 			iounmap(p); 
 			p = NULL;
 		}
+		preempt_disable();
 		global_flush_tlb();
+		preempt_enable();
 	}
 
 	return p;					
@@ -236,7 +242,9 @@ void iounmap(volatile void __iomem *addr
 		change_page_attr(virt_to_page(__va(p->phys_addr)),
 				 p->size >> PAGE_SHIFT,
 				 PAGE_KERNEL); 				 
+		preempt_disable();
 		global_flush_tlb();
+		preempt_enable();
 	} 
 	kfree(p); 
 }
--- linux/include/asm-i386/tlbflush.h.orig
+++ linux/include/asm-i386/tlbflush.h
@@ -5,10 +5,18 @@
 #include <linux/mm.h>
 #include <asm/processor.h>
 
+/*
+ * flush the TLB.
+ *
+ * NOTE: must not do this from a lazy-TLB task (kernel-thread, exit path),
+ * if in a preemptible section.
+ */
 #define __flush_tlb()							\
 	do {								\
 		unsigned int tmpreg;					\
 									\
+		WARN_ON(!preempt_count() && !current->mm);		\
+									\
 		__asm__ __volatile__(					\
 			"movl %%cr3, %0;              \n"		\
 			"movl %0, %%cr3;  # flush TLB \n"		\
@@ -24,6 +32,8 @@
 	do {								\
 		unsigned int tmpreg;					\
 									\
+		WARN_ON(!preempt_count() && !current->mm);		\
+									\
 		__asm__ __volatile__(					\
 			"movl %1, %%cr4;  # turn off PGE     \n"	\
 			"movl %%cr3, %0;                     \n"	\
