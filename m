Return-Path: <linux-kernel-owner+w=401wt.eu-S1752044AbXAROjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbXAROjM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 09:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbXAROjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 09:39:12 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:45440 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752044AbXAROjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 09:39:11 -0500
Date: Thu, 18 Jan 2007 17:45:27 +0300
From: Alexey Dobriyan <adobriyan@openvz.org>
To: ak@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
       devel@vger.kernel.org
Subject: [PATCH] rdmsr_on_cpu, wrmsr_on_cpu 
Message-ID: <20070118144527.GA6021@localhost.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was OpenVZ specific bug rendering some cpufreq drivers unusable
on SMP. In short, when cpufreq code thinks it confined itself to
needed cpu by means of set_cpus_allowed() to execute rdmsr, some
"virtual cpu" feature can migrate process to anywhere. This triggers
bugons and does wrong things in general.

This got fixed by introducing rdmsr_on_cpu and wrmsr_on_cpu executing
rdmsr and wrmsr on given physical cpu by means of
smp_call_function_single().

Dave Jones mentioned cpufreq might be not only user of rdmsr_on_cpu()
and wrmsr_on_cpu(), so I'm going to put them into arch/i386/lib/
(after patch gets some more testing othen than compile and UP run)

Does this looks OK?


 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c |   30 ++----------
 arch/i386/lib/Makefile                     |    2
 arch/i386/lib/msr-on-cpu.c                 |   70 +++++++++++++++++++++++++++++
 include/asm-i386/msr.h                     |    3 +
 4 files changed, 81 insertions(+), 24 deletions(-)

--- a/arch/i386/lib/Makefile
+++ b/arch/i386/lib/Makefile
@@ -7,3 +7,5 @@ lib-y = checksum.o delay.o usercopy.o ge
 	bitops.o semaphore.o
 
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
+
+obj-y = msr-on-cpu.o
--- /dev/null
+++ b/arch/i386/lib/msr-on-cpu.c
@@ -0,0 +1,70 @@
+#include <linux/module.h>
+#include <linux/preempt.h>
+#include <linux/smp.h>
+#include <asm/msr.h>
+
+#ifdef CONFIG_SMP
+struct msr_info {
+	u32 msr_no;
+	u32 l, h;
+};
+
+static void __rdmsr_on_cpu(void *info)
+{
+	struct msr_info *rv = info;
+
+	rdmsr(rv->msr_no, rv->l, rv->h);
+}
+
+void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
+{
+	preempt_disable();
+	if (smp_processor_id() == cpu)
+		rdmsr(msr_no, *l, *h);
+	else {
+		struct msr_info rv;
+
+		rv.msr_no = msr_no;
+		smp_call_function_single(cpu, __rdmsr_on_cpu, &rv, 0, 1);
+		*l = rv.l;
+		*h = rv.h;
+	}
+	preempt_enable();
+}
+
+static void __wrmsr_on_cpu(void *info)
+{
+	struct msr_info *rv = info;
+
+	wrmsr(rv->msr_no, rv->l, rv->h);
+}
+
+void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
+{
+	preempt_disable();
+	if (smp_processor_id() == cpu)
+		wrmsr(msr_no, l, h);
+	else {
+		struct msr_info rv;
+
+		rv.msr_no = msr_no;
+		rv.l = l;
+		rv.h = h;
+		smp_call_function_single(cpu, __wrmsr_on_cpu, &rv, 0, 1);
+	}
+	preempt_enable();
+}
+#else
+void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
+{
+	rdmsr(msr_no, *l, *h);
+}
+
+void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
+{
+	wrmsr(msr_no, l, h);
+}
+#endif
+
+EXPORT_SYMBOL(rdmsr_on_cpu);
+EXPORT_SYMBOL(wrmsr_on_cpu);
--- a/include/asm-i386/msr.h
+++ b/include/asm-i386/msr.h
@@ -83,6 +83,9 @@ #define rdpmc(counter,low,high) \
 			  : "c" (counter))
 #endif	/* !CONFIG_PARAVIRT */
 
+void rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
+void wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
+
 /* symbolic names for some interesting MSRs */
 /* Intel defined MSRs. */
 #define MSR_IA32_P5_MC_ADDR		0
--- a/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
+++ b/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
@@ -63,7 +63,7 @@ static int cpufreq_p4_setdc(unsigned int
 	if (!cpu_online(cpu) || (newstate > DC_DISABLE) || (newstate == DC_RESV))
 		return -EINVAL;
 
-	rdmsr(MSR_IA32_THERM_STATUS, l, h);
+	rdmsr_on_cpu(cpu, MSR_IA32_THERM_STATUS, &l, &h);
 
 	if (l & 0x01)
 		dprintk("CPU#%d currently thermal throttled\n", cpu);
@@ -71,10 +71,10 @@ static int cpufreq_p4_setdc(unsigned int
 	if (has_N44_O17_errata[cpu] && (newstate == DC_25PT || newstate == DC_DFLT))
 		newstate = DC_38PT;
 
-	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
+	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &l, &h);
 	if (newstate == DC_DISABLE) {
 		dprintk("CPU#%d disabling modulation\n", cpu);
-		wrmsr(MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
+		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
 	} else {
 		dprintk("CPU#%d setting duty cycle to %d%%\n",
 			cpu, ((125 * newstate) / 10));
@@ -85,7 +85,7 @@ static int cpufreq_p4_setdc(unsigned int
 		 */
 		l = (l & ~14);
 		l = l | (1<<4) | ((newstate & 0x7)<<1);
-		wrmsr(MSR_IA32_THERM_CONTROL, l, h);
+		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, l, h);
 	}
 
 	return 0;
@@ -112,7 +112,6 @@ static int cpufreq_p4_target(struct cpuf
 {
 	unsigned int    newstate = DC_RESV;
 	struct cpufreq_freqs freqs;
-	cpumask_t cpus_allowed;
 	int i;
 
 	if (cpufreq_frequency_table_target(policy, &p4clockmod_table[0], target_freq, relation, &newstate))
@@ -133,17 +132,8 @@ static int cpufreq_p4_target(struct cpuf
 	/* run on each logical CPU, see section 13.15.3 of IA32 Intel Architecture Software
 	 * Developer's Manual, Volume 3
 	 */
-	cpus_allowed = current->cpus_allowed;
-
-	for_each_cpu_mask(i, policy->cpus) {
-		cpumask_t this_cpu = cpumask_of_cpu(i);
-
-		set_cpus_allowed(current, this_cpu);
-		BUG_ON(smp_processor_id() != i);
-
+	for_each_cpu_mask(i, policy->cpus)
 		cpufreq_p4_setdc(i, p4clockmod_table[newstate].index);
-	}
-	set_cpus_allowed(current, cpus_allowed);
 
 	/* notifiers */
 	for_each_cpu_mask(i, policy->cpus) {
@@ -265,17 +255,9 @@ static int cpufreq_p4_cpu_exit(struct cp
 
 static unsigned int cpufreq_p4_get(unsigned int cpu)
 {
-	cpumask_t cpus_allowed;
 	u32 l, h;
 
-	cpus_allowed = current->cpus_allowed;
-
-	set_cpus_allowed(current, cpumask_of_cpu(cpu));
-	BUG_ON(smp_processor_id() != cpu);
-
-	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
-
-	set_cpus_allowed(current, cpus_allowed);
+	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &l, &h);
 
 	if (l & 0x10) {
 		l = l >> 1;

