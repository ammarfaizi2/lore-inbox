Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965522AbWJaCEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965522AbWJaCEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 21:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965524AbWJaCEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 21:04:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18339 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965522AbWJaCEi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 21:04:38 -0500
Date: Mon, 30 Oct 2006 18:04:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrew.j.wade@gmail.com
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [2.6.19-rc3-mm1] BUG at arch/i386/mm/pageattr.c:165
Message-Id: <20061030180430.2466212f.akpm@osdl.org>
In-Reply-To: <200610302026.24724.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
References: <20061029160002.29bb2ea1.akpm@osdl.org>
	<200610302026.24724.ajwade@cpe001346162bf9-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2006 20:26:24 -0500
Andrew James Wade <andrew.j.wade@gmail.com> wrote:

> I got the BUG below while booting. -rc2-mm2 worked fine, but with a
> different .config. I'm going to try and narrow this down further.
> 
> cheers,
> Andrew Wade
> 
> agpgart: Detected VIA KT266/KY266x/KT333 chipset
> agpgart: unable to get minor: 175
> agpgart: agp_frontend_initialize() failed.
> ------------[ cut here ]------------
> kernel BUG at arch/i386/mm/pageattr.c:165!
> invalid opcode: 0000 [#1]
> last sysfs file: 
> CPU:    0
> EIP:    0060:[<c010fdd7>]    Not tainted VLI
> EFLAGS: 00010082   (2.6.19-rc3-mm1 #1)
> EIP is at change_page_attr+0x167/0x234
> eax: 1fc001e3   ebx: c1009c80   ecx: dfc20000   edx: c04e4dfc
> esi: 1fc20000   edi: e0820000   ebp: 00000005   esp: dffc5e7c
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 1, ti=dffc4000 task=dffc3530 task.ti=dffc4000)
> Stack: 00000011 c13f8400 00000010 00000292 c04e4dfc dfc20000 00000163 00000163 
>        c13f8200 dfe66984 e0820000 00000005 c010fab8 c03ee740 c03ee740 dfe2334c 
>        00000004 e080f000 c0289195 dfe2334c dfe2334c e080f000 c02881f6 fffffffb 
> Call Trace:
>  [<c010fab8>] iounmap+0xaa/0xdc
>  [<00000004>] 0x4
>  =======================
> Code: 84 b7 00 00 00 eb d2 ff 43 0c eb 23 84 c0 78 1b 0b 74 24 1c 8b 54 24 10 89 32 8b 43 0c 85 c0 75 04 0f 0b eb fe 48 89 43 0c eb 04 <0f> 0b eb fe 8b 03 f6 c4 04 75 6c f6 05 0c 7c 45 c0 08 74 63 83 
> EIP: [<c010fdd7>] change_page_attr+0x167/0x234 SS:ESP 0068:dffc5e7c
>  <0>Kernel panic - not syncing: Attempted to kill init!

I'd be suspecting x86_64-mm-i386-clflush-size.patch and
x86_64-mm-i386-cpa-clflush.patch.  Because x86_64-mm-cpa-clflush.patch made
my x86_64 box instacrash in a similar manner, so I reverted that.

below is a ptch which reverts x86_64-mm-i386-clflush-size.patch and
x86_64-mm-i386-cpa-clflush.patch.  Can you test it please?

 arch/i386/kernel/cpu/common.c |    3 ---
 arch/i386/kernel/cpu/proc.c   |    3 +--
 arch/i386/mm/pageattr.c       |   24 +++++++-----------------
 include/asm-i386/cpufeature.h |    1 -
 include/asm-i386/processor.h  |    1 -
 5 files changed, 8 insertions(+), 24 deletions(-)

diff -puN arch/i386/mm/pageattr.c~revert-x86_64-mm-i386-cpa-clflush arch/i386/mm/pageattr.c
--- a/arch/i386/mm/pageattr.c~revert-x86_64-mm-i386-cpa-clflush
+++ a/arch/i386/mm/pageattr.c
@@ -67,17 +67,11 @@ static struct page *split_large_page(uns
 	return base;
 } 
 
-static void flush_kernel_map(void *arg)
+static void flush_kernel_map(void *dummy) 
 { 
-	unsigned long adr = (unsigned long)arg;
-
-	if (adr && cpu_has_clflush) {
-		int i;
-		for (i = 0; i < PAGE_SIZE; i += boot_cpu_data.x86_clflush_size)
-			asm volatile("clflush (%0)" :: "r" (adr + i));
-	} else if (boot_cpu_data.x86_model >= 4)
+	/* Could use CLFLUSH here if the CPU supports it (Hammer,P4) */
+	if (boot_cpu_data.x86_model >= 4) 
 		wbinvd();
-
 	/* Flush all to work around Errata in early athlons regarding 
 	 * large page flushing. 
 	 */
@@ -179,9 +173,9 @@ __change_page_attr(struct page *page, pg
 	return 0;
 } 
 
-static inline void flush_map(void *adr)
+static inline void flush_map(void)
 {
-	on_each_cpu(flush_kernel_map, adr, 1, 1);
+	on_each_cpu(flush_kernel_map, NULL, 1, 1);
 }
 
 /*
@@ -223,13 +217,9 @@ void global_flush_tlb(void)
 	spin_lock_irq(&cpa_lock);
 	list_replace_init(&df_list, &l);
 	spin_unlock_irq(&cpa_lock);
-	if (!cpu_has_clflush)
-		flush_map(0);
-	list_for_each_entry_safe(pg, next, &l, lru) {
-		if (cpu_has_clflush)
-			flush_map(page_address(pg));
+	flush_map();
+	list_for_each_entry_safe(pg, next, &l, lru)
 		__free_page(pg);
-	}
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
diff -puN include/asm-i386/cpufeature.h~revert-x86_64-mm-i386-cpa-clflush include/asm-i386/cpufeature.h
--- a/include/asm-i386/cpufeature.h~revert-x86_64-mm-i386-cpa-clflush
+++ a/include/asm-i386/cpufeature.h
@@ -137,7 +137,6 @@
 #define cpu_has_pmm_enabled	boot_cpu_has(X86_FEATURE_PMM_EN)
 #define cpu_has_ds		boot_cpu_has(X86_FEATURE_DS)
 #define cpu_has_pebs 		boot_cpu_has(X86_FEATURE_PEBS)
-#define cpu_has_clflush		boot_cpu_has(X86_FEATURE_CLFLSH)
 
 #endif /* __ASM_I386_CPUFEATURE_H */
 
diff -puN arch/i386/kernel/cpu/common.c~revert-x86_64-mm-i386-cpa-clflush arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c~revert-x86_64-mm-i386-cpa-clflush
+++ a/arch/i386/kernel/cpu/common.c
@@ -314,8 +314,6 @@ static void __cpuinit generic_identify(s
 #else
 			c->apicid = (ebx >> 24) & 0xFF;
 #endif
-			if (c->x86_capability[0] & (1<<19))
-				c->x86_clflush_size = ((ebx >> 8) & 0xff) * 8;
 		} else {
 			/* Have CPUID level 0 only - unheard of */
 			c->x86 = 4;
@@ -380,7 +378,6 @@ void __cpuinit identify_cpu(struct cpuin
 	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
-	c->x86_clflush_size = 32;
 	memset(&c->x86_capability, 0, sizeof c->x86_capability);
 
 	if (!have_cpuid_p()) {
diff -puN arch/i386/kernel/cpu/proc.c~revert-x86_64-mm-i386-cpa-clflush arch/i386/kernel/cpu/proc.c
--- a/arch/i386/kernel/cpu/proc.c~revert-x86_64-mm-i386-cpa-clflush
+++ a/arch/i386/kernel/cpu/proc.c
@@ -152,10 +152,9 @@ static int show_cpuinfo(struct seq_file 
 				seq_printf(m, " [%d]", i);
 		}
 
-	seq_printf(m, "\nbogomips\t: %lu.%02lu\n",
+	seq_printf(m, "\nbogomips\t: %lu.%02lu\n\n",
 		     c->loops_per_jiffy/(500000/HZ),
 		     (c->loops_per_jiffy/(5000/HZ)) % 100);
-	seq_printf(m, "clflush size\t: %u\n\n", c->x86_clflush_size);
 
 	return 0;
 }
diff -puN include/asm-i386/processor.h~revert-x86_64-mm-i386-cpa-clflush include/asm-i386/processor.h
--- a/include/asm-i386/processor.h~revert-x86_64-mm-i386-cpa-clflush
+++ a/include/asm-i386/processor.h
@@ -73,7 +73,6 @@ struct cpuinfo_x86 {
 #endif
 	unsigned char x86_max_cores;	/* cpuid returned max cores value */
 	unsigned char apicid;
-	unsigned short x86_clflush_size;
 #ifdef CONFIG_SMP
 	unsigned char booted_cores;	/* number of cores as seen by OS */
 	__u8 phys_proc_id; 		/* Physical processor id. */
_

