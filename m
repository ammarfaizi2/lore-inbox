Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030242AbVLVStc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030242AbVLVStc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVLVStb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:49:31 -0500
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:29357 "EHLO
	tayrelbas03.tay.hp.com") by vger.kernel.org with ESMTP
	id S965096AbVLVSta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:49:30 -0500
Date: Thu, 22 Dec 2005 10:48:00 -0800
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: perfmon@napali.hpl.hp.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, perfctr-devel@lists.sourceforge.net
Subject: Re: [perfmon] Re: quick overview of the perfmon2 interface
Message-ID: <20051222184800.GC8773@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20051219113140.GC2690@frankl.hpl.hp.com> <20051220025156.a86b418f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220025156.a86b418f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

> > 6/ PMU DESCRIPTION MODULES
> >    -----------------------
> > 
> > 	The logical PMU is driven by a PMU description table. The table
> > 	is implemented by a kernel pluggable module. As such, it can be
> > 	updated at will without recompiling the kernel, waiting for the next
> > 	release of a Linux kernel or distribution, and without rebooting the
> > 	machine as long as the PMU model belongs to the same PMU family. For
> > 	instance, for the Itanium Processor Family, the architecture specifies
> > 	the framework for the PMU. Thus the Itanium PMU specific code is common
> > 	across all processor implementations. This is not the case for IA-32.
> 
> I think the usefulness of this needs justification.  CPUs are updated all
> the time, and we release new kernels all the time to exploit the new CPU
> features.  What's so special about performance counters that they need such
> special treatment?
> 
Given the discussion we are having, I thought it would be useful to take
a concrete example to try and clarify what I am talking about here. I chose
to use the PMU description module/table of the Pentium M because this is
a very common platform supported by all interfaces. The actual module contains
the following (arch/i386/perfmon/perfmon_pm.c) information:

	- desciption of the PMU register: where they are, their type
	- a callback for an option PMC write checker.
	- a probe routine (not shown)
	- an module_init/module_exit (not shown)

Let's look at the informaiton in more details:

The first information is architecture specific structure
used by the architecture specific code (arch/i386/perfmon/perfmon.c).
It contains the information about the MSR addresses for each register
that we want to access. Let's look at PMC0:

	{{MSR_P6_EVNTSEL0, 0}, 0, PFM_REGT_PERFSEL},

   - field 0=MSR_P6_EVNTSEL0: PMC0 is mapped onto MSR EVENTSEL0 (for thread 0)
   - field 1=0: unused Pentium M does not support Hyperthreading (no thread 1)
   - field 2=0: PMC0 is controlling PMD 0
   - field 3=PFM_REGT_PERFSEL: this is a PMU control register

The business about HT is due to the fact that the i386 code is shared
with P4/Xeon.

struct pfm_arch_pmu_info pfm_pm_pmu_info={
	.pmc_addrs = {
		{{MSR_P6_EVNTSEL0, 0}, 0, PFM_REGT_PERFSEL},
                    
		{{MSR_P6_EVNTSEL1, 0}, 1, PFM_REGT_PERFSEL}
	},
	.pmd_addrs = {
		{{MSR_P6_PERFCTR0, 0}, 0, PFM_REGT_CTR},
		{{MSR_P6_PERFCTR1, 0}, 0, PFM_REGT_CTR}
	},
	.pmu_style = PFM_I386_PMU_P6,
	.lps_per_core = 1
};

Now let's look at the mapping table. It contains the following information:
	- attribute of the register
	- logical name
	- default value
	- reserved bitfield

The mapping table describes the very basic and generic properties of a register and
is using the same structure for all PMU models. In contrast the first structure
is totally architecture specific.

static struct pfm_reg_desc pfm_pm_pmc_desc[PFM_MAX_PMCS+1]={
/* pmc0  */ { PFM_REG_W, "PERFSEL0", PFM_PM_PMC_VAL, PFM_PM_PMC_RSVD},
/* pmc1  */ { PFM_REG_W, "PERFSEL1", PFM_PM_PMC_VAL, PFM_PM_PMC_RSVD},
	    { PFM_REG_END} /* end marker */
};

static struct pfm_reg_desc pfm_pm_pmd_desc[PFM_MAX_PMDS+1]={
/* pmd0  */ { PFM_REG_C  , "PERFCTR0", 0x0, -1},
/* pmd1  */ { PFM_REG_C  , "PERFCTR1", 0x0, -1},
	    { PFM_REG_END} /* end marker */
};

Now the write checker. It is used to intervene on the value passed by 
the user when it programs a PMC register. The role of the function is
to ensure that the reserved bitfields retains their default value.
It can be used to verify that a PMC value is actually authorized and
sane. PMU may disallowd certain combination of values. The checker is
optional. On Pentium M we simply enforce resreved bitfields.

static int pfm_pm_pmc_check(struct pfm_context *ctx, struct pfm_event_set *set,
			    u16 cnum, u32 flags, u64 *val)
{
	u64 tmpval, tmp1, tmp2;
	u64 rsvd_mask, dfl_value;

	tmpval = *val;
	rsvd_mask = pfm_pm_pmc_desc[cnum].reserved_mask;
	dfl_value = pfm_pm_pmc_desc[cnum].default_value;

	if (flags & PFM_REGFL_NO_EMUL64)
		dfl_value &= ~(1ULL << 20);

	/* remove reserved areas from user value */
	tmp1 = tmpval & rsvd_mask;

	/* get reserved fields values */
	tmp2 = dfl_value & ~rsvd_mask;
	*val = tmp1 | tmp2;

	return 0;
}

And finally the structure that we register with the core of perfmon.
It includes among other things the actual width of the counters as this
is useful for sampling and 64-bit virtualization of counters.

static struct pfm_pmu_config pfm_pm_pmu_conf={
	.pmu_name = "Intel Pentium M Processor",
	.counter_width = 31,
	.pmd_desc = pfm_pm_pmd_desc,
	.pmc_desc = pfm_pm_pmc_desc,
	.pmc_write_check = pfm_pm_pmc_check,
	.probe_pmu = pfm_pm_probe_pmu,
	.version = "1.0",
	.flags = PMU_FLAGS,
	.owner = THIS_MODULE,
	.arch_info = &pfm_pm_pmu_info
};

This is not much information.

If this is not implemented as a kernel module, it would have to be integrated into
the kernel no matter what. This is very basic information that perfmon needs to operate
on the PMU registers. I prefer the table driven approach to the hardcoding and checking
everywhere. I hope you agree with me here.

The PMU description module is simply a way to separate this information from the
core. Note that the modules can, of course, be compiled in.

