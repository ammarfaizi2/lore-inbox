Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbVFGPnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbVFGPnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVFGPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:43:44 -0400
Received: from fmr23.intel.com ([143.183.121.15]:58065 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261892AbVFGPlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 11:41:39 -0400
Date: Tue, 7 Jun 2005 08:40:32 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>, x86-64 <discuss@x86-64.org>,
       Rusty Russell <rusty@rustycorp.com.au>, ak <ak@muc.de>
Subject: Re: [patch 4/5] try2: x86_64: Dont use broadcast shortcut to make it cpu hotplug safe.
Message-ID: <20050607084031.A26067@unix-os.sc.intel.com>
References: <20050606191433.104273000@araj-em64t> <20050606192113.307745000@araj-em64t> <1118128410.3949.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1118128410.3949.3.camel@linux-hp.sh.intel.com>; from shaohua.li@intel.com on Tue, Jun 07, 2005 at 03:13:30PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 03:13:30PM +0800, Shaohua Li wrote:
> With the patch. smp_call_function still has race. It accesses
> cpu_online_map twice. First calculate online cpu counter and second,
> send the ipi, so it's not atomic. We should do something like this:
> 
> Thanks,
> Shaohua
> 

Correct, i though this was taken care earlier because i was holding call_lock
but i forgot that i just removed it based on zwane's feedback.

I re-introduced that with the comment so i dont forget the purpose.

attached patch should fix that by holding call_lock before setting, so 
we exclude current upcomming cpu from on-going smp_call_function() 
transactions.

x86_64-hold-call-lock-when-setting-online-map:

Need to hold call_lock when setting cpu_online_map for a new cpu. 
__smp_call_function() reads num_cpus_online() to find out how many consumers 
to wait. These counts are done at different times, and unless we keep 
writes off cpu_online_map gaurded, these counts could be different. Worst
case a new cpu would also participate, this basically keeps the new cpu off
currently ongoing smp_call_functions().

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---------------------------------------------------
 arch/x86_64/kernel/smp.c     |   10 ++++++++++
 arch/x86_64/kernel/smpboot.c |   12 ++++++++++++
 include/asm-x86_64/smp.h     |    2 ++
 3 files changed, 24 insertions(+)

Index: linux-2.6.12-rc6-mm1/arch/x86_64/kernel/smp.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/x86_64/kernel/smp.c
+++ linux-2.6.12-rc6-mm1/arch/x86_64/kernel/smp.c
@@ -283,6 +283,16 @@ struct call_data_struct {
 
 static struct call_data_struct * call_data;
 
+void lock_ipi_call_lock(void)
+{
+	spin_lock_irq(&call_lock);
+}
+
+void unlock_ipi_call_lock(void)
+{
+	spin_unlock_irq(&call_lock);
+}
+
 /*
  * this function sends a 'generic call function' IPI to all other CPUs
  * in the system.
Index: linux-2.6.12-rc6-mm1/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.12-rc6-mm1.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.12-rc6-mm1/arch/x86_64/kernel/smpboot.c
@@ -448,9 +448,21 @@ void __cpuinit start_secondary(void)
 	enable_APIC_timer();
 
 	/*
+	 * We need to hold call_lock, so there is no inconsistency
+	 * between the time smp_call_function() determines number of
+	 * IPI receipients, and the time when the determination is made
+	 * for which cpus receive the IPI in genapic_flat.c. Holding this
+	 * lock helps us to not include this cpu in a currently in progress
+	 * smp_call_function().
+	 */
+	lock_ipi_call_lock();
+
+	/*
 	 * Allow the master to continue.
 	 */
 	cpu_set(smp_processor_id(), cpu_online_map);
+	unlock_ipi_call_lock();
+
 	mb();
 
 	/* Wait for TSC sync to not schedule things before.
Index: linux-2.6.12-rc6-mm1/include/asm-x86_64/smp.h
===================================================================
--- linux-2.6.12-rc6-mm1.orig/include/asm-x86_64/smp.h
+++ linux-2.6.12-rc6-mm1/include/asm-x86_64/smp.h
@@ -43,6 +43,8 @@ extern cpumask_t cpu_callout_map;
 extern void smp_alloc_memory(void);
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
+extern void lock_ipi_call_lock(void);
+extern void unlock_ipi_call_lock(void);
 extern int smp_num_siblings;
 extern void smp_flush_tlb(void);
 extern void smp_message_irq(int cpl, void *dev_id, struct pt_regs *regs);
