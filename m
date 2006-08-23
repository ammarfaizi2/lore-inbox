Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWHWK66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWHWK66 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWHWK66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:58:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:58850 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964855AbWHWK65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:58:57 -0400
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 12:58:55 +0200
In-Reply-To: <200608230806.k7N8654c000504@frankl.hpl.hp.com>
Message-ID: <p733bbn7m6o.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@frankl.hpl.hp.com> writes:


> +#ifdef __i386__
> +#define __pfm_wrmsrl(a, b) wrmsr((a), (b), 0)
> +#else
> +#define __pfm_wrmsrl(a, b) wrmsrl((a), (b))
> +#endif

i386 should have wrmsrl so this ifdef shouldn't be needed.

> +void pfm_arch_init_percpu(void)
> +{
> +	/*
> +	 * We initialize APIC with LVTPC vector masked.
> +	 *
> +	 * this is motivated by the fact that the PMU may be
> +	 * in a condition where it has already an interrupt pending.
> +	 * Given that we cannot touch the PMU registers
> +	 * at this point, we may not have a way to remove the condition.
> +	 * As such, we need to keep the interrupt masked until a PMU
> +	 * description is loaded. At that point, we can enable intr.
> +	 *
> +	 * If NMI is using local APIC, then the problem does not exist
> +	 * because LAPIC has already been properly initialized.
> +	 */
> +	if (nmi_watchdog != NMI_LOCAL_APIC) {

This needs cleaner interaction with the nmi watchdog code.  Maybe call
some functions there.

> +int pfm_arch_load_context(struct pfm_context *ctx, struct task_struct *task)
> +{
> +	struct pfm_arch_context *ctx_arch;
> +
> +	ctx_arch = pfm_ctx_arch(ctx);
> +
> +	/*
> +	 * always authorize user level rdpmc for self-monitoring
> +	 * only. It is not possible to do this for system-wide because
> +	 * thread may not be running on the monitored CPU.
> +	 *
> +	 * We set a private flag to avoid write cr4.ce on context switch
> +	 * if not necessary as this is a very expensive operation.
> +	 */
> +	if (task == current) {
> +		ctx_arch->flags |= PFM_X86_FL_INSECURE;

My plan was to always allow RDPMC to export perfctr0 as an alternative to RDTSC.
Can you please drop this secure/insecure handling?

> +
> +fastcall void smp_pmu_interrupt(struct pt_regs *regs)
> +{

This misses enter/exit_idle on x86-64.

> + */
> +void pfm_arch_pmu_config_init(void)
> +{
> +	/*
> +	 * if NMI watchdog is using Local APIC, then
> +	 * counters are already initialized to a decent
> +	 * state
> +	 */
> +	if (nmi_watchdog == NMI_LOCAL_APIC)
> +		return;

Earlier comment applies.

> +void pfm_arch_mask_monitoring(struct pfm_context *ctx)
> +{
> +	/*
> +	 * on IA-32 masking/unmasking uses start/stop
> +	 * mechanism
> +	 */
> +	pfm_arch_stop(current, ctx, ctx->active_set);
> +}
> +
> +void pfm_arch_unmask_monitoring(struct pfm_context *ctx)
> +{
> +	/*
> +	 * on IA-32 masking/unmasking uses start/stop
> +	 * mechanism
> +	 */
> +	__pfm_arch_start(current, ctx, ctx->active_set);
> +}

This looks like a bit much abstraction. Is it really needed to have
that many levels?  Please aim for simple code.

> +
> +static int
> +pfm_reserve_lapic_nmi(void)
> +{
> +	int ret = 0;
> +	unsigned long flags;
> +
> +	local_save_flags(flags);
> +	local_irq_enable();
> +
> +
> +	/*
> +	 * keep track that we have disabled NMI watchdog
> +	 */
> +	pfm_nmi_watchdog = 1;


No no no. Don't disable the NMI watchdog. Run cooperatively with it.
Surely it can't be that difficult to let the watchdog play
with perfctr0 and you with all the others?

There is a new sysctl in the upcomming .19 tree that will allow
to disable it at runtime. If that's done it's fine if you take
over the PMU completely, but don't do it by default please.
> +
> +static int has_ia32_arch_pmu(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	if (cpu_data->x86_vendor != X86_VENDOR_INTEL)
> +		return 0;
> +
> +	cpuid(0x0, &eax, &ebx, &ecx, &edx);
> +	if (eax < 0xa)
> +		return 0;

Technically that's wrong on i386 because you don't check first
if the CPU has CPUID (386s don't).

This whole function should be just boot_cpu_has(X86_FEATURE_ARCH_PERFMON) in .19
and be expanded in the caller.


x86-64 has a convenient cpu_data[].extended_cpuid_level. i386 doesn't currently


> +char *pfm_arch_get_pmu_module_name(void)
> +{
> +	switch(cpu_data->x86) {
> +		case 6:
> +			switch(cpu_data->x86_model) {
> +				case 3: /* Pentium II */
> +				case 7 ... 11:
> +				case 13:
> +					return "perfmon_p6";
> +				default:
> +					return NULL;
> +			}

Athlon? Cyrix etc.?

> +		case 15:
> +			/* All Opteron processors */
> +			if (cpu_data->x86_vendor == X86_VENDOR_AMD)
> +				return "perfmon_amd64";
> +
> +			switch(cpu_data->x86_model) {
> +				case 0 ... 6:
> +					return "perfmon_p4";
> +			}

And if some other vendor ever does a family==15 CPU?

> +			/* FALL THROUGH */
> +		default:
> +			if (has_ia32_arch_pmu())
> +				return "perfmon_gen_ia32";
> +			return NULL;
> +	}
> +	return NULL;

I think it would be much nicer if you defined new synthetic flags for this 
stuff in cpufeature.h and set the bits in the standard cpu initialization
functions in arch/*. Then check that here.



> +}
> --- linux-2.6.17.9.base/arch/i386/perfmon/perfmon_gen_ia32.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17.9/arch/i386/perfmon/perfmon_gen_ia32.c	2006-08-21 03:37:46.000000000 -0700

So is this used on 64bit too?

> +
> +	PFM_INFO("family=%d x86_model=%d",
> +		 cpu_data->x86, cpu_data->x86_model);
> +	/*
> +	 * check for P6 processor family
> +	 */
> +	if (cpu_data->x86 != 6) {
> +		PFM_INFO("unsupported family=%d", cpu_data->x86);
> +		return -1;
> +	}

It seems pointless to have an architected PMU when you check 
the family and vendor again?  Probably you only want to check CPUID

> +
> +	/*
> +	 * only works on Intel processors
> +	 */
> +	if (cpu_data->x86_vendor != X86_VENDOR_INTEL) {
> +		PFM_INFO("not running on Intel processor");
> +		return -1;
> +	}
> +
> +	/*
> +	 * check if CPU supports 0xa function of CPUID
> +	 * 0xa started with Core Duo/Solo. Needed to detect if
> +	 * architected PMU is present
> +	 */
> +	cpuid(0x0, &eax.val, &ebx, &ecx, &edx);
> +	if (eax.val < 0xa) {
> +		PFM_INFO("CPUID 0xa function not supported\n");
> +		return -1;
> +	}
> +
> +	cpuid(0xa, &eax.val, &ebx, &ecx, &edx);
> +	if (eax.eax.version < 1) {
> +		PFM_INFO("architectural perfmon not supported\n");
> +		return -1;
> +	}

Same problem as described above. Use the generic bit.


> +	num_cnt = eax.eax.num_cnt;
> +
> +	/*
> +	 * sanity check number of counters
> +	 */
> +	if (num_cnt == 0 || num_cnt >= PFM_MAX_HW_PMCS) {
> +		PFM_INFO("invalid number of counters %u\n", eax.eax.num_cnt);
> +		return -1;
> +	}
> +	/*
> +	 * instead of dynamically generaint the description table
> +	 * and MSR addresses, we have a default description with a reasonably
> +	 * large number of counters (32). We believe this is plenty for quite
> +	 * some time. Thus allows us to have a much simpler probing and
> +	 * initialization routine, especially because we have no dynamic
> +	 * allocation, especially for the counter names
> +	 */
> +	if (num_cnt >= PFM_GEN_IA32_MAX_PMCS) {
> +		PFM_INFO("too many counters (max=%d) actual=%u\n",
> +			PFM_GEN_IA32_MAX_PMCS, num_cnt);

Is there a particular reason you can't just limit it to the number
of compiled in counters and ignore the others? 

> +		return -1;
> +	}
> +
> +	if (eax.eax.cnt_width > 63) {
> +		PFM_INFO("invalid counter width %u\n", eax.eax.cnt_width);
> +		return -1;
> +	}
> +
> +	if (!cpu_has_apic) {
> +		PFM_INFO("no Local APIC, unsupported");
> +		return -1;
> +	}
> +
> +	rdmsr(MSR_IA32_APICBASE, low, high);
> +	if ((low & MSR_IA32_APICBASE_ENABLE) == 0) {
> +		PFM_INFO("local APIC disabled, you must enable "
> +			 "with lapic kernel command line option");
> +		return -1;
> +	}

I don't think that belongs here. Normally we should clear cpu_has_apic
if the APIC is not enabled. If that's not the case anywhere fix that 
code.
> +	switch(cpu_data->x86_model) {
> +		case 1:
> +			PFM_INFO("Willamette P4 detected");
> +			break;
> +		case 2:
> +			PFM_INFO("Northwood P4 detected");
> +			break;
> +		case 3: /* Pentium 4 505, 520, 540, 550 */
> +		case 4: 
> +		case 5: /* incl. some Celeron D */
> +		case 0:
> +			PFM_INFO("P4 detected");
> +			break;
> +		case 6:
> +			PFM_INFO("Pentium D or Extreme Edition detected");
> +			break;

The PFM_INFOs seem a bit pointless.

> +		default:
> +			/*
> +			 * do not know if they all work the same, so reject
> +			 * for now
> +			 */
> +			PFM_INFO("unknown model %d", cpu_data->x86_model);
> +			return -1;

This causes endless problems later. On oprofile i added a force module
argument to override this. I would suggest that too.


> +	}
> +
> +	/*
> +	 * check for local APIC (required)
> +	 */
> +	if (!cpu_has_apic) {
> +		PFM_INFO("no local APIC, unsupported");
> +		return -1;
> +	}
> +	rdmsr(MSR_IA32_APICBASE, low, high);
> +	if ((low & MSR_IA32_APICBASE_ENABLE) == 0)
> +		PFM_INFO("Local APIC in 3-wire mode");

Earlier comment applies.

> +
> +#ifdef CONFIG_SMP
> +	num_ht = cpus_weight(cpu_sibling_map[0]);
> +#else
> +	num_ht = 1;
> +#endif
> +
> +	PFM_INFO("cores/package=%d threads/core=%d",
> +		 cpu_data->x86_max_cores,
> +		 num_ht);

Not trusting /proc/cpuinfo?
> +#ifndef __i386__
> +#error "this module is for the 32-bit Pentium 4/Xeon processors"
> +#endif


Still not clear why you can't share with 64bit.
> +
> +static int pfm_p6_probe_pmu(void)
> +{
> +	int high, low;
> +
> +	PFM_INFO("family=%d x86_model=%d",
> +		 cpu_data->x86, cpu_data->x86_model);
> +	/*
> +	 * check for P6 processor family
> +	 */
> +	if (cpu_data->x86 != 6) {
> +		PFM_INFO("unsupported family=%d", cpu_data->x86);
> +		return -1;
> +	}

Shouldn't you check for Intel here?

> +{
> +	unsigned long val, dest;
> +	/*
> +	 * we cannot use hw_resend_irq() because it goes to
> +	 * the I/O APIC. We need to go to the Local Apic.
> +	 *
> +	 * The "int vec" is not the right solution either
> +	 * because it triggers a software intr. We need
> +	 * to regenerate the intr. and have it pended until
> +	 * we unmask interrupts.
> +	 *
> +	 * Instead we send ourself an IPI on the perfmon
> +	 * vector.
> +	 */
> +	val  = APIC_DEST_SELF|APIC_INT_ASSERT|
> +	       APIC_DM_FIXED|LOCAL_PERFMON_VECTOR;
> +	dest = apic_read(APIC_ID);
> +	apic_write(APIC_ICR2, dest);
> +	apic_write(APIC_ICR, val);

I think for some old i386 cpus you're missing workarounds here, but might be ok.
I hope the caller takes care of preemption etc.

> +
> +}
> +
> +#define pfm_arch_serialize()	/* nothing */

Not even a sync_core()? 

> +
> +static inline u64 pfm_arch_get_itc(void)
> +{
> +	u64 tmp;
> +	rdtscll(tmp);
> +	return tmp;

All callers should use sched_clock()
> +
> +static inline u64 pfm_arch_read_pmd(struct pfm_context *ctx, unsigned int cnum)
> +{
> +	struct pfm_arch_pmu_info *arch_info = pfm_pmu_conf->arch_info;
> +	u64 tmp;
> +	__pfm_read_reg(&arch_info->pmd_addrs[cnum], &tmp);
> +	return tmp;


This seems a bit overabstracted again. Drop one level of function calls?
Applies to many functions in this file.

-Andi
