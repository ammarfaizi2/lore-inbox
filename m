Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268696AbTBZJn0>; Wed, 26 Feb 2003 04:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268697AbTBZJn0>; Wed, 26 Feb 2003 04:43:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:1734 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268696AbTBZJnY>;
	Wed, 26 Feb 2003 04:43:24 -0500
Date: Wed, 26 Feb 2003 01:54:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: schlicht@uni-mannheim.de, torvalds@transmeta.com, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] fix preempt-issues with smp_call_function()
Message-Id: <20030226015409.78e8e1fb.akpm@digeo.com>
In-Reply-To: <20030226103742.GA29250@suse.de>
References: <200302251908.55097.schlicht@uni-mannheim.de>
	<20030226103742.GA29250@suse.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Feb 2003 09:53:34.0533 (UTC) FILETIME=[ED37B750:01C2DD7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> On Tue, Feb 25, 2003 at 07:08:48PM +0100, Thomas Schlichter wrote:
> 
>  > here is a patch to solve all (I hope I missed none) possible problems that 
>  > could occur on SMP machines running a preemptible kernel when 
>  > smp_call_function() calls a function which should be also executed on the 
>  > current processor.
>  > 
>  > This patch is based on the one Dave Jones sent to the LKML last friday and 
>  > applies to the linux kernel version 2.5.63.
> 
> Just one comment. You moved quite a few of the preempt_disable/enable
> pairs outside of the CONFIG_SMP checks.  The issue we're working against
> here is to try and prevent preemption and ending up on a different CPU.
> As this cannot happen if CONFIG_SMP=n, I don't see why you've done this.
> 

Just in two places.


 arch/i386/kernel/ldt.c   |    6 ++++--
 arch/x86_64/kernel/ldt.c |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff -puN arch/i386/kernel/ldt.c~on_each_cpu-ldt-cleanup arch/i386/kernel/ldt.c
--- 25/arch/i386/kernel/ldt.c~on_each_cpu-ldt-cleanup	2003-02-26 01:51:27.000000000 -0800
+++ 25-akpm/arch/i386/kernel/ldt.c	2003-02-26 01:52:21.000000000 -0800
@@ -55,13 +55,15 @@ static int alloc_ldt(mm_context_t *pc, i
 	wmb();
 
 	if (reload) {
+#ifdef CONFIG_SMP
 		preempt_disable();
 		load_LDT(pc);
-#ifdef CONFIG_SMP
 		if (current->mm->cpu_vm_mask != (1 << smp_processor_id()))
 			smp_call_function(flush_ldt, 0, 1, 1);
-#endif
 		preempt_enable();
+#else
+		load_LDT(pc);
+#endif
 	}
 	if (oldsize) {
 		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)
diff -puN arch/x86_64/kernel/ldt.c~on_each_cpu-ldt-cleanup arch/x86_64/kernel/ldt.c
--- 25/arch/x86_64/kernel/ldt.c~on_each_cpu-ldt-cleanup	2003-02-26 01:51:36.000000000 -0800
+++ 25-akpm/arch/x86_64/kernel/ldt.c	2003-02-26 01:52:37.000000000 -0800
@@ -60,13 +60,15 @@ static int alloc_ldt(mm_context_t *pc, i
 	pc->size = mincount;
 	wmb();
 	if (reload) {
+#ifdef CONFIG_SMP
 		preempt_disable();
 		load_LDT(pc);
-#ifdef CONFIG_SMP
 		if (current->mm->cpu_vm_mask != (1<<smp_processor_id()))
 			smp_call_function(flush_ldt, 0, 1, 1);
-#endif
 		preempt_enable();
+#else
+		load_LDT(pc);
+#endif
 	}
 	if (oldsize) {
 		if (oldsize*LDT_ENTRY_SIZE > PAGE_SIZE)

_

