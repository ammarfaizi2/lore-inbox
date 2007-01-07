Return-Path: <linux-kernel-owner+w=401wt.eu-S932619AbXAGRrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbXAGRrc (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 12:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932620AbXAGRrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 12:47:32 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:57303 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932619AbXAGRrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 12:47:31 -0500
Date: Sun, 7 Jan 2007 18:44:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
Message-ID: <20070107174416.GA14607@elte.hu>
References: <20070105215223.GA5361@elte.hu> <45A0E586.50806@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A0E586.50806@qumranet.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> >2-task context-switch performance (in microseconds, lower is better):
> >
> > native:                       1.11
> > ----------------------------------
> > Qemu:                        61.18
> > KVM upstream:                53.01
> > KVM trunk:                    6.36
> > KVM trunk+paravirt/cr3:       1.60
> >
> >i.e. 2-task context-switch performance is faster by a factor of 4, and 
> >is now quite close to native speed!
> >  
> 
> Very impressive!  The gain probably comes not only from avoiding the 
> vmentry/vmexit, but also from avoiding the flushing of the global page 
> tlb entries.

90% of the win comes from the avoidance of the VM exit. To quantify this 
more precisely i have added an artificial __flush_tlb_global() call to 
after switch_to(), just to see how much impact an extra global flush has 
on the native kernel. Context-switch cost went from 1.11 usecs to 1.65 
usecs. Then i added a __flush_tlb(), which made the cost go to 1.75, 
which means that the global flush component is at around 0.5 usecs.

> >"hackbench 1" (utilizes 40 tasks, numbers in seconds, lower is better):
> >
> > native:                       0.25
> > ----------------------------------
> > Qemu:                         7.8
> > KVM upstream:                 2.8
> > KVM trunk:                    0.55
> > KVM paravirt/cr3:             0.36
> >
> >almost twice as fast.
> >
> >"hackbench 5" (utilizes 200 tasks, numbers in seconds, lower is better):
> >
> > native:                       0.9
> > ----------------------------------
> > Qemu:                        35.2
> > KVM upstream:                 9.4
> > KVM trunk:                    2.8
> > KVM paravirt/cr3:             2.2
> >
> >still a 30% improvement - which isnt too bad considering that 200 tasks 
> >are context-switching in this workload and the cr3 cache in current CPUs 
> >is only 4 entries.
> >  
> 
> This is a little too good to be true.  Were both runs with the same 
> KVM_NUM_MMU_PAGES?

yes, both had the same elevated KVM_NUM_MMU_PAGES of 2048. The 'trunk' 
run should have been labeled as: 'cr3 tree with paravirt turned off'. 
That's not completely 'trunk' but close to it, and all other changes 
(like elimination of unnecessary TLB flushes) are fairly applied to 
both.

i also did a run with much less MMU cache pages of 256, and hackbench 1 
stayed the same, while hackbench 5 numbers started fluctuating badly (i 
think that workload if trashing the MMU cache badly).

> I'm also concerned that at this point in time the cr3 optimizations 
> will only show an improvement in microbenchmarks.  In real life 
> workloads a context switch is usually preceded by an I/O, and with the 
> current sorry state of kvm I/O the context switch time would be 
> dominated by the I/O time.

oh, i agreed completely - but in my opinion accelerating virtual I/O is 
really easy. Accelerating the context-switch path (and basic syscall 
overhead like KVM does) is /hard/. So i wanted to see whether KVM runs 
well in all the hard cases, before looking at the low hanging 
performance fruits in the I/O area =B-)

also note that there's lots of internal reasons why application 
workloads can be heavily context-switching - it's not just I/O that 
generates them. (pipes, critical sections / futexes, etc.) So having 
near-native performance for context-switches is very important.

> >+    if (irq & 8) {
> >+        outb(cached_slave_mask, PIC_SLAVE_IMR);
> >+        outb(0x60+(irq&7),PIC_SLAVE_CMD);/* 'Specific EOI' to slave */
> >+        outb(0x60+PIC_CASCADE_IR,PIC_MASTER_CMD); /* 'Specific EOI' 
> >to master-IRQ2 */
> >+    } else {
> >+        outb(cached_master_mask, PIC_MASTER_IMR);
> >+        /* 'Specific EOI' to master: */
> >+        outb(0x60+irq, PIC_MASTER_CMD);
> >+    }
> >+    spin_unlock_irqrestore(&i8259A_lock, flags);
> >+}
> 
> Any reason this can't be applied to mainline?  There's probably no 
> downside to native, and it would benefit all virtualization solutions 
> equally.

this is legacy stuff ...

> >-    u64 *pae_root;
> >+    u64 *pae_root[KVM_CR3_CACHE_SIZE];
> 
> hmm.  wouldn't it be simpler to have pae_root always point at the 
> current root?

does that guarantee that it's available? I wanted to 'pin' the root 
itself this way, to make sure that if a guest switches to it via the 
cache, that it's truly available and a valid root. cr3 addresses are 
non-virtual so this is the only mechanism available to guarantee that 
the host-side memory truly contains a root pagetable.

> >+            vcpu->mmu.pae_root[j][i] = INVALID_PAGE;
> >+        }
> >     }
> >     vcpu->mmu.root_hpa = INVALID_PAGE;
> > }
> 
> You keep the page directories pinned here. [...]

yes.

> [...]  This can be a problem if a guest frees a page directory, and 
> then starts using it as a regular page.  kvm sometimes chooses not to 
> emulate a write to a guest page table, but instead to zap it, which is 
> impossible when the page is freed.  You need to either unpin the page 
> when that happens, or add a hypercall to let kvm know when a page 
> directory is freed.

the cache is zapped upon pagefaults anyway, so unpinning ought to be 
possible. Which one would you prefer?

> >-    for (i = 0; i < 4; ++i)
> >-        vcpu->mmu.pae_root[i] = INVALID_PAGE;
> >+    for (j = 0; j < KVM_CR3_CACHE_SIZE; j++) {
> >+        /*
> >+         * When emulating 32-bit mode, cr3 is only 32 bits even on
> >+         * x86_64. Therefore we need to allocate shadow page tables
> >+         * in the first 4GB of memory, which happens to fit the DMA32
> >+         * zone:
> >+         */
> >+        page = alloc_page(GFP_KERNEL | __GFP_DMA32);
> >+        if (!page)
> >+            goto error_1;
> >+
> >+        ASSERT(!vcpu->mmu.pae_root[j]);
> >+        vcpu->mmu.pae_root[j] = page_address(page);
> >+        for (i = 0; i < 4; ++i)
> >+            vcpu->mmu.pae_root[j][i] = INVALID_PAGE;
> >+    }
> 
> Since a pae root uses just 32 bytes, you can store all cache entries 
> in a single page.  Not that it matters much.

yeah - i wanted to extend the current code in a safe way, before 
optimizing it.

> >+#define KVM_API_MAGIC 0x87654321
> >+
> 
> <linux/kvm.h> is the vmm userspace interface.  The guest/host 
> interface should probably go somewhere else.

yeah. kvm_para.h?

	Ingo
