Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWHYNBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWHYNBR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 09:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWHYNBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 09:01:17 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:15590 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S1750818AbWHYNBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 09:01:16 -0400
Date: Fri, 25 Aug 2006 05:49:05 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
Message-ID: <20060825124905.GD5330@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com> <p733bbn7m6o.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p733bbn7m6o.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Aug 23, 2006 at 12:58:55PM +0200, Andi Kleen wrote:
> Stephane Eranian <eranian@frankl.hpl.hp.com> writes:
> 
> 
> > +#ifdef __i386__
> > +#define __pfm_wrmsrl(a, b) wrmsr((a), (b), 0)
> > +#else
> > +#define __pfm_wrmsrl(a, b) wrmsrl((a), (b))
> > +#endif
> 
> i386 should have wrmsrl so this ifdef shouldn't be needed.
> 

Yes, wrmsrl() is fine as long as I write MSR for counters (i.e., more than 32 bits)
using wrmsrl() is fine. But there is code where I need to write an address into
an MSR (namely MSR_IA32_DS_AREA). On i386 the address is 32 bit, on x86_64, it
is 64-bit, the macros is mostly here to hide this.

	wrmsrl(MSR_IA32_DS_AREA, ctx_arch->ds_area);

That generates a warning from the compiler for i386.


> > +int pfm_arch_load_context(struct pfm_context *ctx, struct task_struct *task)
> > +{
> > +	struct pfm_arch_context *ctx_arch;
> > +
> > +	ctx_arch = pfm_ctx_arch(ctx);
> > +
> > +	/*
> > +	 * always authorize user level rdpmc for self-monitoring
> > +	 * only. It is not possible to do this for system-wide because
> > +	 * thread may not be running on the monitored CPU.
> > +	 *
> > +	 * We set a private flag to avoid write cr4.ce on context switch
> > +	 * if not necessary as this is a very expensive operation.
> > +	 */
> > +	if (task == current) {
> > +		ctx_arch->flags |= PFM_X86_FL_INSECURE;
> 
> My plan was to always allow RDPMC to export perfctr0 as an alternative to RDTSC.
> Can you please drop this secure/insecure handling?
> 
Are we already running with cr4.pce set today?

The cr4.pce allows all PMC (counter) to be read at user level, not just perfctr0.
When enabled all counters are readable at user level from any process. A process
can see the value accumulated by another process (assuming monitoring in per-thread
mode). Some people may see this as a security risk. On the other hand all you see
is counts. So as long as the i386/x86_64 PMU only collect counts, this could be
fine. The day they can capture addresses, this becomes more problematic, I think.

The way it is setup today is that we only set cr4.pce for self-monitoring (per-thread)
context. That's the only situation where this makes sense, anyway.

> > +
> > +fastcall void smp_pmu_interrupt(struct pt_regs *regs)
> > +{
> 
> This misses enter/exit_idle on x86-64.
> 

I don't understand this. Could you describe some more?

> > +
> > +static int
> > +pfm_reserve_lapic_nmi(void)
> > +{
> > +	int ret = 0;
> > +	unsigned long flags;
> > +
> > +	local_save_flags(flags);
> > +	local_irq_enable();
> > +
> > +
> > +	/*
> > +	 * keep track that we have disabled NMI watchdog
> > +	 */
> > +	pfm_nmi_watchdog = 1;
> 
> 
> No no no. Don't disable the NMI watchdog. Run cooperatively with it.
> Surely it can't be that difficult to let the watchdog play
> with perfctr0 and you with all the others?
> 
Yes, that is my end goal. The current does not do this just yet.
There needs to be an (MSR) reservation API that both NMI watchdog
and perfmon could use.

Are you planning on using perfctr0 for both NMI watchdog and a
replacement for RDTSC? Don't you need more than one counter for
this?


> There is a new sysctl in the upcomming .19 tree that will allow
> to disable it at runtime. If that's done it's fine if you take
> over the PMU completely, but don't do it by default please.
> > +

When NMI watchdog shuts down, it would need to free the counter
it was using. Then we could pick it up.


> > +static int has_ia32_arch_pmu(void)
> > +{
> > +	unsigned int eax, ebx, ecx, edx;
> > +
> > +	if (cpu_data->x86_vendor != X86_VENDOR_INTEL)
> > +		return 0;
> > +
> > +	cpuid(0x0, &eax, &ebx, &ecx, &edx);
> > +	if (eax < 0xa)
> > +		return 0;
> 
> Technically that's wrong on i386 because you don't check first
> if the CPU has CPUID (386s don't).
> 

> This whole function should be just boot_cpu_has(X86_FEATURE_ARCH_PERFMON) in .19
> and be expanded in the caller.
> 
I agree with this. This is much cleaner.

> > +char *pfm_arch_get_pmu_module_name(void)
> > +{
> > +	switch(cpu_data->x86) {
> > +		case 6:
> > +			switch(cpu_data->x86_model) {
> > +				case 3: /* Pentium II */
> > +				case 7 ... 11:
> > +				case 13:
> > +					return "perfmon_p6";
> > +				default:
> > +					return NULL;
> > +			}
> 
> Athlon? Cyrix etc.?

Are those following the K8 PMU model?

> 
> > +		case 15:
> > +			/* All Opteron processors */
> > +			if (cpu_data->x86_vendor == X86_VENDOR_AMD)
> > +				return "perfmon_amd64";
> > +
> > +			switch(cpu_data->x86_model) {
> > +				case 0 ... 6:
> > +					return "perfmon_p4";
> > +			}
> 
> And if some other vendor ever does a family==15 CPU?
> 
I will fix that.

> > +			/* FALL THROUGH */
> > +		default:
> > +			if (has_ia32_arch_pmu())
> > +				return "perfmon_gen_ia32";
> > +			return NULL;
> > +	}
> > +	return NULL;
> 
> I think it would be much nicer if you defined new synthetic flags for this 
> stuff in cpufeature.h and set the bits in the standard cpu initialization
> functions in arch/*. Then check that here.
> 
Agreed. You would need more than one bit for this.

> 
> > +}
> > --- linux-2.6.17.9.base/arch/i386/perfmon/perfmon_gen_ia32.c	1969-12-31 16:00:00.000000000 -0800
> > +++ linux-2.6.17.9/arch/i386/perfmon/perfmon_gen_ia32.c	2006-08-21 03:37:46.000000000 -0700
> 
> So is this used on 64bit too?
> 
> > +
> > +	PFM_INFO("family=%d x86_model=%d",
> > +		 cpu_data->x86, cpu_data->x86_model);
> > +	/*
> > +	 * check for P6 processor family
> > +	 */
> > +	if (cpu_data->x86 != 6) {
> > +		PFM_INFO("unsupported family=%d", cpu_data->x86);
> > +		return -1;
> > +	}
> 
> It seems pointless to have an architected PMU when you check 
> the family and vendor again?  Probably you only want to check CPUID
> 
Agreed.

> > +	num_cnt = eax.eax.num_cnt;
> > +
> > +	/*
> > +	 * sanity check number of counters
> > +	 */
> > +	if (num_cnt == 0 || num_cnt >= PFM_MAX_HW_PMCS) {
> > +		PFM_INFO("invalid number of counters %u\n", eax.eax.num_cnt);
> > +		return -1;
> > +	}
> > +	/*
> > +	 * instead of dynamically generaint the description table
> > +	 * and MSR addresses, we have a default description with a reasonably
> > +	 * large number of counters (32). We believe this is plenty for quite
> > +	 * some time. Thus allows us to have a much simpler probing and
> > +	 * initialization routine, especially because we have no dynamic
> > +	 * allocation, especially for the counter names
> > +	 */
> > +	if (num_cnt >= PFM_GEN_IA32_MAX_PMCS) {
> > +		PFM_INFO("too many counters (max=%d) actual=%u\n",
> > +			PFM_GEN_IA32_MAX_PMCS, num_cnt);
> 
> Is there a particular reason you can't just limit it to the number
> of compiled in counters and ignore the others? 
> 
Yes, that's another possibility as long as counters are totally independent
of each other.


> > +		return -1;
> > +	}
> > +
> > +	if (eax.eax.cnt_width > 63) {
> > +		PFM_INFO("invalid counter width %u\n", eax.eax.cnt_width);
> > +		return -1;
> > +	}
> > +
> > +	if (!cpu_has_apic) {
> > +		PFM_INFO("no Local APIC, unsupported");
> > +		return -1;
> > +	}
> > +
> > +	rdmsr(MSR_IA32_APICBASE, low, high);
> > +	if ((low & MSR_IA32_APICBASE_ENABLE) == 0) {
> > +		PFM_INFO("local APIC disabled, you must enable "
> > +			 "with lapic kernel command line option");
> > +		return -1;
> > +	}
> 
> I don't think that belongs here. Normally we should clear cpu_has_apic
> if the APIC is not enabled. If that's not the case anywhere fix that 
> code.

I need to check this. I remember having had some problems with this on i386.


> > +		default:
> > +			/*
> > +			 * do not know if they all work the same, so reject
> > +			 * for now
> > +			 */
> > +			PFM_INFO("unknown model %d", cpu_data->x86_model);
> > +			return -1;
> 
> This causes endless problems later. On oprofile i added a force module
> argument to override this. I would suggest that too.
> 

I can add a force option too.

> > +
> > +#ifdef CONFIG_SMP
> > +	num_ht = cpus_weight(cpu_sibling_map[0]);
> > +#else
> > +	num_ht = 1;
> > +#endif
> > +
> > +	PFM_INFO("cores/package=%d threads/core=%d",
> > +		 cpu_data->x86_max_cores,
> > +		 num_ht);
> 
> Not trusting /proc/cpuinfo?

I need to know the info from inside the kernel to dynamically adjust the
number of PMU registers available.

> > +#ifndef __i386__
> > +#error "this module is for the 32-bit Pentium 4/Xeon processors"
> > +#endif
> 
> 
> Still not clear why you can't share with 64bit.

I have now merged the PEBS formats for 32-bit and 64-bit.

> > +
> > +static int pfm_p6_probe_pmu(void)
> > +{
> > +	int high, low;
> > +
> > +	PFM_INFO("family=%d x86_model=%d",
> > +		 cpu_data->x86, cpu_data->x86_model);
> > +	/*
> > +	 * check for P6 processor family
> > +	 */
> > +	if (cpu_data->x86 != 6) {
> > +		PFM_INFO("unsupported family=%d", cpu_data->x86);
> > +		return -1;
> > +	}
> 
> Shouldn't you check for Intel here?
> 
Done.


> > +{
> > +	unsigned long val, dest;
> > +	/*
> > +	 * we cannot use hw_resend_irq() because it goes to
> > +	 * the I/O APIC. We need to go to the Local Apic.
> > +	 *
> > +	 * The "int vec" is not the right solution either
> > +	 * because it triggers a software intr. We need
> > +	 * to regenerate the intr. and have it pended until
> > +	 * we unmask interrupts.
> > +	 *
> > +	 * Instead we send ourself an IPI on the perfmon
> > +	 * vector.
> > +	 */
> > +	val  = APIC_DEST_SELF|APIC_INT_ASSERT|
> > +	       APIC_DM_FIXED|LOCAL_PERFMON_VECTOR;
> > +	dest = apic_read(APIC_ID);
> > +	apic_write(APIC_ICR2, dest);
> > +	apic_write(APIC_ICR, val);
> 
> I think for some old i386 cpus you're missing workarounds here, but might be ok.
> I hope the caller takes care of preemption etc.
> 
You are in the low level context switch code when this happens. I assume
there is no preemption possible there.
 
Thanks.

-- 
-Stephane
