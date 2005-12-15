Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161121AbVLOF00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161121AbVLOF00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161120AbVLOF00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:26:26 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:5031 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161119AbVLOF0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:26:25 -0500
Message-ID: <43A0FE0D.6030100@jp.fujitsu.com>
Date: Thu, 15 Dec 2005 14:24:29 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: Andrew Morton <akpm@osdl.org>, Yasunori Goto <y-goto@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org, tony.luck@intel.com
Subject: Re: 2.6.15-rc5-mm2 can't boot on ia64 due to changing on_each_cpu().
References: <20051215103344.241C.Y-GOTO@jp.fujitsu.com> <20051214185658.7a60aa07.akpm@osdl.org> <20051215030040.GA28660@kvack.org>
In-Reply-To: <20051215030040.GA28660@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Wed, Dec 14, 2005 at 06:56:58PM -0800, Andrew Morton wrote:
> 
>>Thanks.  I'll drop it.
> 
> 
> Please don't.  Fix ia64's brain damage instead.  Function pointers 
> should not be cast, period.
> 
> 		-ben

How about this?

Thanks,
Kenji Kaneshige


We need this patch on ia64 to convert on_each_cpu to a macro.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 arch/ia64/kernel/smp.c         |    4 ++--
 arch/ia64/kernel/smpboot.c     |    2 +-
 arch/ia64/mm/tlb.c             |    6 +++---
 include/asm-ia64/mmu_context.h |    4 ++--
 include/asm-ia64/tlbflush.h    |    5 +++--
 5 files changed, 11 insertions(+), 10 deletions(-)

Index: linux-2.6.15-rc5-mm2/arch/ia64/kernel/smpboot.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/ia64/kernel/smpboot.c
+++ linux-2.6.15-rc5-mm2/arch/ia64/kernel/smpboot.c
@@ -652,7 +652,7 @@ int __cpu_disable(void)
 	remove_siblinginfo(cpu);
 	cpu_clear(cpu, cpu_online_map);
 	fixup_irqs();
-	local_flush_tlb_all();
+	local_flush_tlb_all(NULL);
 	cpu_clear(cpu, cpu_callin_map);
 	return 0;
 }
Index: linux-2.6.15-rc5-mm2/arch/ia64/mm/tlb.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/ia64/mm/tlb.c
+++ linux-2.6.15-rc5-mm2/arch/ia64/mm/tlb.c
@@ -81,7 +81,7 @@ wrap_mmu_context (struct mm_struct *mm)
 		if (i != cpu)
 			per_cpu(ia64_need_tlb_flush, i) = 1;
 	put_cpu();
-	local_flush_tlb_all();
+	local_flush_tlb_all(NULL);
 }
 
 void
@@ -111,7 +111,7 @@ ia64_global_tlb_purge (struct mm_struct 
 }
 
 void
-local_flush_tlb_all (void)
+local_flush_tlb_all (void *dummy)
 {
 	unsigned long i, j, flags, count0, count1, stride0, stride1, addr;
 
@@ -192,5 +192,5 @@ ia64_tlb_init (void)
 	local_cpu_data->ptce_stride[0] = ptce_info.stride[0];
 	local_cpu_data->ptce_stride[1] = ptce_info.stride[1];
 
-	local_flush_tlb_all();	/* nuke left overs from bootstrapping... */
+	local_flush_tlb_all(NULL);/* nuke left overs from bootstrapping... */
 }
Index: linux-2.6.15-rc5-mm2/arch/ia64/kernel/smp.c
===================================================================
--- linux-2.6.15-rc5-mm2.orig/arch/ia64/kernel/smp.c
+++ linux-2.6.15-rc5-mm2/arch/ia64/kernel/smp.c
@@ -225,7 +225,7 @@ smp_send_reschedule (int cpu)
 void
 smp_flush_tlb_all (void)
 {
-	on_each_cpu((void (*)(void *))local_flush_tlb_all, NULL, 1, 1);
+	on_each_cpu(local_flush_tlb_all, NULL, 1, 1);
 }
 
 void
@@ -248,7 +248,7 @@ smp_flush_tlb_mm (struct mm_struct *mm)
 	 * anyhow, and once a CPU is interrupted, the cost of local_flush_tlb_all() is
 	 * rather trivial.
 	 */
-	on_each_cpu((void (*)(void *))local_finish_flush_tlb_mm, mm, 1, 1);
+	on_each_cpu(local_finish_flush_tlb_mm, mm, 1, 1);
 }
 
 /*
Index: linux-2.6.15-rc5-mm2/include/asm-ia64/tlbflush.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-ia64/tlbflush.h
+++ linux-2.6.15-rc5-mm2/include/asm-ia64/tlbflush.h
@@ -23,7 +23,7 @@
  * Flush everything (kernel mapping may also have changed due to
  * vmalloc/vfree).
  */
-extern void local_flush_tlb_all (void);
+extern void local_flush_tlb_all (void *dummy);
 
 #ifdef CONFIG_SMP
   extern void smp_flush_tlb_all (void);
@@ -34,8 +34,9 @@ extern void local_flush_tlb_all (void);
 #endif
 
 static inline void
-local_finish_flush_tlb_mm (struct mm_struct *mm)
+local_finish_flush_tlb_mm (void *info)
 {
+	struct mm_struct *mm = (struct mm_struct *)info;
 	if (mm == current->active_mm)
 		activate_context(mm);
 }
Index: linux-2.6.15-rc5-mm2/include/asm-ia64/mmu_context.h
===================================================================
--- linux-2.6.15-rc5-mm2.orig/include/asm-ia64/mmu_context.h
+++ linux-2.6.15-rc5-mm2/include/asm-ia64/mmu_context.h
@@ -60,13 +60,13 @@ enter_lazy_tlb (struct mm_struct *mm, st
 static inline void
 delayed_tlb_flush (void)
 {
-	extern void local_flush_tlb_all (void);
+	extern void local_flush_tlb_all (void *);
 	unsigned long flags;
 
 	if (unlikely(__ia64_per_cpu_var(ia64_need_tlb_flush))) {
 		spin_lock_irqsave(&ia64_ctx.lock, flags);
 		if (__ia64_per_cpu_var(ia64_need_tlb_flush)) {
-			local_flush_tlb_all();
+			local_flush_tlb_all(NULL);
 			__ia64_per_cpu_var(ia64_need_tlb_flush) = 0;
 		}
 		spin_unlock_irqrestore(&ia64_ctx.lock, flags);


