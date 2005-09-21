Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbVIUWj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbVIUWj4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 18:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbVIUWj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 18:39:56 -0400
Received: from fmr23.intel.com ([143.183.121.15]:62632 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S964991AbVIUWjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 18:39:55 -0400
Date: Wed, 21 Sep 2005 15:39:15 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org, ak@muc.de,
       suresh.b.siddha@intel.com, discuss@x86-64.org
Subject: Re: init and zap low address mappings on demand for cpu hotplug
Message-ID: <20050921153915.A16422@unix-os.sc.intel.com>
References: <20050921135731.B14439@unix-os.sc.intel.com> <20050921141157.1bd7aa94.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050921141157.1bd7aa94.akpm@osdl.org>; from akpm@osdl.org on Wed, Sep 21, 2005 at 02:11:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2005 at 02:11:57PM -0700, Andrew Morton wrote:
> Ashok Raj <ashok.raj@intel.com> wrote:
> >
> > +/*
> >  + * mode
> >  + * 	0 indicates its for __cpu_up to kick an AP into boot sequence.
> >  + *  1 indicates completion os smp boot process, so we can zap the low
> >  + *    until there is need to bring a cpu up again.
> >  + */
> >  +__cpuinit void zap_low_mappings(int mode)
> 
> grump.  `mode' is a terrible identifier name.  Better to call it something
> which identifies its meaning if true, such as `do_mapping_zapping' or
> something.
> 

Valid Grump!

> 
> And that comment is incomprehensible, partly due to all its typos.  Care to
> try again?
> 

Something has to do about zap and corruption in this patch :-), infact i 
accidently deleted some of the text from Suresh when i sent earlier.

I removed the param, made the var have a more meaningful name.

Below are re-worked patches.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


We need to dynamically map and unmap the low address mappings on demand.
Originally we left these low address mappings unzapped since they were 
required later for cpu hotplug. Due to the following sigthting, we are now 
doing this dynamically on demand just before we bringup a cpu and then zap 
when the secondary boot is complete. We defer the zap during first boot 
until smpboot process is complete.

>From Suresh: 
Identity mapped low address mappings cause corruption when udev process is 
spawned early in boot. Since these low mappings are mapped global, cr3 writes
(during context switches to udev process) will not flush these identity low
mappings. These low mappings will be used by the kernel when it writes into
the udev/hotplug user space, thereby corrupting kernel memory.

Thanks to suresh for identifying and help comming up with the fix.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Suresh B Siddha <suresh.b.siddha@intel.com>
---------------------------------------------------
 arch/x86_64/kernel/smpboot.c |   11 ++++++++---
 arch/x86_64/mm/init.c        |   24 +++++++++++++++++++++---
 include/asm-x86_64/smp.h     |    2 ++
 3 files changed, 31 insertions(+), 6 deletions(-)

Index: linux-2.6.14-rc1-mm1/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.14-rc1-mm1.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.14-rc1-mm1/arch/x86_64/kernel/smpboot.c
@@ -748,6 +748,12 @@ do_rest:
 
 	cpu_pda[cpu].pcurrent = c_idle.idle;
 
+	/*
+	 * Re-establish low mappings to facilitate boot.
+	 * zap it back when boot process is complete.
+	 */
+	init_low_mappings();
+
 	start_rip = setup_trampoline();
 
 	init_rsp = c_idle.idle->thread.rsp;
@@ -829,6 +835,7 @@ do_rest:
 #endif
 		}
 	}
+	zap_low_mappings();
 	if (boot_error) {
 		cpu_clear(cpu, cpu_callout_map); /* was set here (do_boot_cpu()) */
 		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
@@ -1067,9 +1074,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
  */
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-#ifndef CONFIG_HOTPLUG_CPU
-	zap_low_mappings();
-#endif
+	zap_low_after_boot();
 	smp_cleanup_boot();
 
 #ifdef CONFIG_X86_IO_APIC
Index: linux-2.6.14-rc1-mm1/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.14-rc1-mm1.orig/arch/x86_64/mm/init.c
+++ linux-2.6.14-rc1-mm1/arch/x86_64/mm/init.c
@@ -311,15 +311,33 @@ void __init init_memory_mapping(unsigned
 }
 
 extern struct x8664_pda cpu_pda[NR_CPUS];
+__cpuinitdata static int low_mem_valid = 1;
 
 /* Assumes all CPUs still execute in init_mm */
-void zap_low_mappings(void)
+__cpuinit void init_low_mappings(void)
 {
-	pgd_t *pgd = pgd_offset_k(0UL);
+	if (!low_mem_valid)
+		set_pgd(pgd_offset_k(0UL), *pgd_offset_k(PAGE_OFFSET));
+}
+
+__cpuinit void zap_low_mappings(void)
+{
+	pgd_t *pgd;
+
+	if (low_mem_valid)
+		return;
+
+	pgd = pgd_offset_k(0UL);
 	pgd_clear(pgd);
 	flush_tlb_all();
 }
 
+__cpuinit void zap_low_after_boot(void)
+{
+	low_mem_valid = 0;
+	zap_low_mappings();
+}
+
 /* Compute zone sizes for the DMA and DMA32 zones in a node. */
 __init void
 size_zones(unsigned long *z, unsigned long *h,
@@ -481,7 +499,7 @@ void __init mem_init(void)
 	 * the WP-bit has been tested.
 	 */
 #ifndef CONFIG_SMP
-	zap_low_mappings();
+	zap_low_after_boot();
 #endif
 }
 
Index: linux-2.6.14-rc1-mm1/include/asm-x86_64/smp.h
===================================================================
--- linux-2.6.14-rc1-mm1.orig/include/asm-x86_64/smp.h
+++ linux-2.6.14-rc1-mm1/include/asm-x86_64/smp.h
@@ -47,7 +47,9 @@ extern void lock_ipi_call_lock(void);
 extern void unlock_ipi_call_lock(void);
 extern int smp_num_siblings;
 extern void smp_send_reschedule(int cpu);
+extern void init_low_mappings(void);
 extern void zap_low_mappings(void);
+extern void zap_low_after_boot(void);
 void smp_stop_cpu(void);
 extern int smp_call_function_single(int cpuid, void (*func) (void *info),
 				void *info, int retry, int wait);
