Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVDNNxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVDNNxy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 09:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVDNNxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 09:53:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:12259 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261504AbVDNNxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 09:53:48 -0400
Date: Thu, 14 Apr 2005 14:54:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Dave Jones <davej@redhat.com>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
In-Reply-To: <20050407062928.GH24469@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com>
References: <20050330214455.GF10159@redhat.com> 
    <20050331104117.GD1623@wotan.suse.de> <20050407024902.GA9017@redhat.com> 
    <20050407062928.GH24469@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2005, Andi Kleen wrote:
> Dave Jones wrote:
> > I realised today that this happens every time X starts up for
> > the first time.   I did some experiments, and found that with 2.6.12rc1
> > it's gone. Either it got fixed accidentally, or its hidden now
> > by one of the many changes in 4-level patches.
> > 
> > I'll try and narrow this down a little more tomorrow, to see if I
> > can pinpoint the exact -bk snapshot (may be tricky given they were
> > broken for a while), as it'd be good to get this fixed in 2.6.11.x
> > if .12 isn't going to show up any time soon.
> 
> Can you supply a strace of the /dev/mem, /dev/kmem accesses of 
> your X server? (including the mmaps or read/writes if available)
> 
> My X server doesn't seem to cause that.

I can't explain why it should appear fixed in 2.6.12-rc1 (probably
other complicating factors at work), but I do believe you've fixed
this in 2.6.12-rc2, and the patch which should go into -stable is
your load_cr3 patch below, which Linus took from Andrew on 28 March.

I say this because I was intrigued by the resemblance between Sergey's
and Dave's corruptions, and spent a while trying to work out where they
come from.  The giveaway is the little ASCII string they share at the
end (seen also in Clem's extract)

 mm/memory.c:97: bad pmd ffff81004b017730(5f36387800000000).
 mm/memory.c:97: bad pmd ffff81004b017738(0000000000003436).

That says "x86_64", and a grep for that as a string shows ELF_PLATFORM,
and a grep for that shows create_elf_tables in fs/binfmt_elf.c.  _All_
this pmd corruption (except for the first line, presumably pushing a
user address on stack) originates from create_elf_tables (the neatly
ascending stack addresses being the argv and envp pointers, incrementing
by 1 because only a NUL-string is found for each, the real strings being
off elsewhere in the intended new stack page, not in this pmd page).

It looks very much as if the mm being created has for pmd a page
which was used for user stack in the outgoing mm; but somehow exec's
exit_mmap TLB flushing hasn't taken effect.  I only now noticed this
patch where you fix just such an issue.

Hugh

From: "Andi Kleen" <ak@suse.de>

Always reload CR3 completely when a lazy MM thread drops a MM.  This avoids
keeping stale mappings around in the TLB that could be run into by the CPU by
itself (e.g.  during prefetches).

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/smp.c         |    3 ++-
 25-akpm/include/asm-x86_64/mmu_context.h |   10 ++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff -puN arch/x86_64/kernel/smp.c~x86_64-always-reload-cr3-completely-when-a-lazy-mm arch/x86_64/kernel/smp.c
--- 25/arch/x86_64/kernel/smp.c~x86_64-always-reload-cr3-completely-when-a-lazy-mm	Wed Mar 23 15:38:58 2005
+++ 25-akpm/arch/x86_64/kernel/smp.c	Wed Mar 23 15:38:58 2005
@@ -25,6 +25,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/mach_apic.h>
+#include <asm/mmu_context.h>
 #include <asm/proto.h>
 
 /*
@@ -52,7 +53,7 @@ static inline void leave_mm (unsigned lo
 	if (read_pda(mmu_state) == TLBSTATE_OK)
 		BUG();
 	clear_bit(cpu, &read_pda(active_mm)->cpu_vm_mask);
-	__flush_tlb();
+	load_cr3(swapper_pg_dir);
 }
 
 /*
diff -puN include/asm-x86_64/mmu_context.h~x86_64-always-reload-cr3-completely-when-a-lazy-mm include/asm-x86_64/mmu_context.h
--- 25/include/asm-x86_64/mmu_context.h~x86_64-always-reload-cr3-completely-when-a-lazy-mm	Wed Mar 23 15:38:58 2005
+++ 25-akpm/include/asm-x86_64/mmu_context.h	Wed Mar 23 15:38:58 2005
@@ -28,6 +28,11 @@ static inline void enter_lazy_tlb(struct
 }
 #endif
 
+static inline void load_cr3(pgd_t *pgd)
+{
+	asm volatile("movq %0,%%cr3" :: "r" (__pa(pgd)) : "memory");
+}
+
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 
 			     struct task_struct *tsk)
 {
@@ -40,7 +45,8 @@ static inline void switch_mm(struct mm_s
 		write_pda(active_mm, next);
 #endif
 		set_bit(cpu, &next->cpu_vm_mask);
-		asm volatile("movq %0,%%cr3" :: "r" (__pa(next->pgd)) : "memory");
+		load_cr3(next->pgd);
+
 		if (unlikely(next->context.ldt != prev->context.ldt)) 
 			load_LDT_nolock(&next->context, cpu);
 	}
@@ -54,7 +60,7 @@ static inline void switch_mm(struct mm_s
 			 * tlb flush IPI delivery. We must reload CR3
 			 * to make sure to use no freed page tables.
 			 */
-			asm volatile("movq %0,%%cr3" :: "r" (__pa(next->pgd)) : "memory");
+			load_cr3(next->pgd);
 			load_LDT_nolock(&next->context, cpu);
 		}
 	}
