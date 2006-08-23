Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWHWKTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWHWKTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWHWKTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:19:47 -0400
Received: from ns2.suse.de ([195.135.220.15]:19675 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964814AbWHWKTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:19:46 -0400
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] 2.6.17.9 perfmon2 patch for review: new x86_64 files
References: <200608230806.k7N869KD000552@frankl.hpl.hp.com>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 12:19:44 +0200
In-Reply-To: <200608230806.k7N869KD000552@frankl.hpl.hp.com>
Message-ID: <p73fyfn7nzz.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@frankl.hpl.hp.com> writes:


Earlier comment about logical pieces applies too.

> 
> --- linux-2.6.17.9.base/arch/x86_64/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17.9/arch/x86_64/perfmon/Kconfig	2006-08-21 03:37:46.000000000 -0700
> @@ -0,0 +1,39 @@
> +menu "Hardware Performance Monitoring support"
> +config PERFMON
> + 	bool "Perfmon2 performance monitoring interface"
> +	select X86_LOCAL_APIC
> +	default y

No default y please unless the kernel doesn't boot without it.

> + 	help
> +  	Enables the perfmon2 interface to access the hardware
> +	performance counters. See <http://perfmon2.sf.net/> for
> + 	more details. If you're unsure, say Y.
> +
> +config X86_64_PERFMON_AMD64
> +	tristate "Support 64-bit mode AMD64 hardware performance counters"
> +	depends on PERFMON
> +	default m

No default m please.  If someone just presses return in make oldconfig
with a new kernel they don't want all kinds of new random optional drivers.

I think I would prefer to call it _K8, because in theory new AMD CPUs
might have difference performance counters.

> +	help
> +	Enables support for 64-bit mode AMD64 hardware performance
> +	counters. Does not work with Intel EM64T processors.
> +	If unsure, say m.

I would drop the if unsure ... too

> +
> +config X86_64_PERFMON_EM64T
> +	tristate "Support Intel EM64T hardware performance counters"
> +	depends on PERFMON
> +	default m
> +	help
> +	Enables support for the Intel EM64T hardware performance
> +	counters. Does not work with AMD64 processors.
> +	If unsure, say m.

Does that include the Core 2 support that you had in the i386 patch? 

In general I would prefer to call it P4, not EM64T which is just
a generic architecture name and at least on P4 performance counters
are not really architected yet.


> +
> +	if (cpu_data->x86 != 15) {
> +		PFM_INFO("unsupported family=%d", cpu_data->x86);
> +		return -1;
> +	}
> +
> +	if (cpu_data->x86_vendor != X86_VENDOR_AMD) {
> +		PFM_INFO("not an AMD processor");
> +		return -1;
> +	}

Doing the checks the other way round would be more logical.

> + *
> + * This file implements the PEBS sampling format for Intel
> + * EM64T Intel Pentium 4/Xeon processors. It does not work
> + * with Intel 32-bit P4/Xeon processors.

Why not anyways? The registers are basically the same. What's so different
in 64bit? oprofile shares that code too.

The file seems a bit underdocumented. At least some brief description
what PEBS is and maybe at least one sentence for each function?

> + */
> +#ifndef __PERFMON_EM64T_PEBS_SMPL_H__
> +#define __PERFMON_EM64T_PEBS_SMPL_H__ 1
> +
> +#define PFM_EM64T_PEBS_SMPL_UUID { \
> +	0x36, 0xbe, 0x97, 0x94, 0x1f, 0xbf, 0x41, 0xdf,\
> +	0xb4, 0x63, 0x10, 0x62, 0xeb, 0x72, 0x9b, 0xad}

What does it need the UUID for?

> +
> +/*
> + * format specific parameters (passed at context creation)
> + *
> + * intr_thres: index from start of buffer of entry where the
> + * PMU interrupt must be triggered. It must be several samples
> + * short of the end of the buffer.
> + */
> +struct pfm_em64t_pebs_smpl_arg {
> +	size_t	buf_size;	/* size of the buffer in bytes */
> +	size_t	intr_thres;	/* index of interrupt threshold entry */
> +	u32	flags;		/* buffer specific flags */
> +	u64	cnt_reset;	/* counter reset value */
> +	u32	res1;		/* for future use */
> +	u64	reserved[2];	/* for future use */

I hope you double checked the alignment comes up everywhere correctly.
u64 alignment is different on the 32bit and 64bit ABIs. That can screw

Normally it's safer to use aligned_u64 on files that can be used on 
32bit too, because that avoids that problem.


Where is the actual code that implements the code that you hooked 
into arch/x86_64/*? I must have missed that.

-Andi
