Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWF3MQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWF3MQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 08:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWF3MQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 08:16:28 -0400
Received: from mx1.suse.de ([195.135.220.2]:61898 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932144AbWF3MQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 08:16:28 -0400
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/16] 2.6.17-rc6 perfmon2 patch for review: new x86_64 files
References: <200606150907.k5F97jR5008252@frankl.hpl.hp.com>
From: Andi Kleen <ak@suse.de>
Date: 30 Jun 2006 14:16:26 +0200
In-Reply-To: <200606150907.k5F97jR5008252@frankl.hpl.hp.com>
Message-ID: <p73k66yx2hx.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@frankl.hpl.hp.com> writes:

> This patch contains the new files for x86_64 (AMD and Intel EM64T).
> 

Again description/what/why missing here.

> 
> 
> 
> --- linux-2.6.17-rc6.orig/arch/x86_64/perfmon/Kconfig	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17-rc6/arch/x86_64/perfmon/Kconfig	2006-06-13 06:58:44.000000000 -0700
> @@ -0,0 +1,39 @@
> +menu "Hardware Performance Monitoring support"
> +config PERFMON
> +	select X86_LOCAL_APIC

This is useless on x86-64

> +	default y
> + 	help
> + 	  include the perfmon2 performance monitoring interface
> +	  in the kernel.  See <http://www.hpl.hp.com/research/linux/perfmon> for
> +	  If you're unsure, say Y.

Really?

> +
> +config X86_64_PERFMON_AMD
> +	tristate "Support AMD X86-64 generic hardware performance counters"
> +	depends on PERFMON
> +	default m
> +	help
> +	Enables support for the generic AMD X86-64 hardware performance
> +	counters. Does not work with Intel EM64T processors.


That's a strange comment. I assume it will work anyways if both are loaded? 

Also this should be probably AMD_K8 in case AMD brings out something
with different performance counters.

> +	If unsure, say m.
> +
> +config X86_64_PERFMON_EM64T
> +	tristate "Support Intel EM64T hardware performance counters"
> +	depends on PERFMON
> +	default m
> +	help
> +	Enables support for the Intel EM64T hardware performance
> +	counters. Does not work with AMD X86-64 processors.
> +	If unsure, say m.

The name is wrong. You probably mean NETBURST or P4. Intel has other x86-64
CPUs now too which likely have a different PMU.

5B
> +
> +config X86_64_PERFMON_EM64T_PEBS
> +	tristate "Support for Intel EM64T PEBS sampling format"
> +	depends on X86_64_PERFMON_EM64T
> +	default m
> +	help
> +	Enables support for Precise Event-Based Sampling (PEBS) on the Intel
> +	EM64T processors which support it.  Does not work with AMD X86-64
> +	processors.
> +	If unsure, say m.
> +
> +endmenu
> --- linux-2.6.17-rc6.orig/arch/x86_64/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17-rc6/arch/x86_64/perfmon/Makefile	2006-06-08 01:49:22.000000000 -0700
> @@ -0,0 +1,11 @@
> +#
> +# Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
> +# Contributed by Stephane Eranian <eranian@hpl.hp.com>
> +#
> +
> +obj-$(CONFIG_PERFMON)			+= perfmon.o
> +obj-$(CONFIG_X86_64_PERFMON_AMD)	+= perfmon_amd.o
> +obj-$(CONFIG_X86_64_PERFMON_EM64T)	+= ../../i386/perfmon/perfmon_p4.o
> +obj-$(CONFIG_X86_64_PERFMON_EM64T_PEBS)	+= perfmon_em64t_pebs_smpl.o
> +
> +perfmon-$(subst m,y,$(CONFIG_PERFMON)) += ../../i386/perfmon/perfmon.o
> --- linux-2.6.17-rc6.orig/arch/x86_64/perfmon/perfmon_amd.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17-rc6/arch/x86_64/perfmon/perfmon_amd.c	2006-06-08 02:35:42.000000000 -0700
> @@ -0,0 +1,127 @@

Again name and x86_64 prefixes are wrong.

Also surely this driver doesn't only work under 64bit? The CPUs run in 32bit mode too.
> +static int pfm_x86_64_probe_pmu(void)
> +{
> +	PFM_INFO("family=%d x86_model=%d",
> +		 cpu_data->x86, cpu_data->x86_model);
> +
> +	if (cpu_data->x86 != 15) {
> +		PFM_INFO("unsupported family=%d", cpu_data->x86);
> +		return -1;

-ENODEV?

> --- linux-2.6.17-rc6.orig/arch/x86_64/perfmon/perfmon_em64t_pebs_smpl.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17-rc6/arch/x86_64/perfmon/perfmon_em64t_pebs_smpl.c	2006-06-08 02:24:56.000000000 -0700

Again naming/prefixes wrong.
> @@ -0,0 +1,218 @@
> +/*
> + * Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
> + * Contributed by Stephane Eranian <eranian@hpl.hp.com>
> + *
> + * This file implements the PEBS sampling format for Intel
> + * EM64T Intel Pentium 4/Xeon processors. It does not work
> + * with Intel 32-bit P4/Xeon processors.
> + */
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <linux/smp.h>
> +#include <linux/sysctl.h>
> +#include <asm/msr.h>
> +
> +#include <linux/perfmon.h>
> +#include <asm/perfmon_em64t_pebs_smpl.h>
> +
> +#ifndef __x86_64__
> +#error "this module is for the Intel EM64T processors"
> +#endif


This should probably work on these CPUs when running in 32bit mode too.

The file probably needs some descriptive comment on top what PEBS 
is and roughly how it is supported.


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

Is this visible to user space? If yes then it's definitely
not compat safe.

> +	u32	flags;		/* buffer specific flags */
> +	u64	cnt_reset;	/* counter reset value */
> +	u32	res1;		/* for future use */
> +	u64	reserved[2];	/* for future use */

And that also isn't

(alignof(u64) differs between the 32bit and 64bit ABI)


> +};
> +
> +/*
> + * combined context+format specific structure. Can be passed
> + * to pfm_context_create()
> + */
> +struct pfm_em64t_pebs_smpl_ctx_arg {
> +	struct pfarg_ctx		ctx_arg;
> +	struct pfm_em64t_pebs_smpl_arg	buf_arg;
> +};
> +
> +/*
> + * DS Save Area as described in section 15.10.5 for
> + * 32-bit but extended to 64-bit
> + */
> +struct pfm_em64t_ds_area {
> +	u64	bts_buf_base;
> +	u64	bts_index;
> +	u64	bts_abs_max;
> +	u64	bts_intr_thres;
> +	u64	pebs_buf_base;
> +	u64	pebs_index;
> +	u64	pebs_abs_max;
> +	u64	pebs_intr_thres;
> +	u64     pebs_cnt_reset;
> +};
> +
> +/*
> + * This header is at the beginning of the sampling buffer returned to the user.
> + *
> + * Because of PEBS alignement constraints, the actual PEBS buffer area does
> + * not necessarily begin right after the header. The hdr_start_offs must be
> + * used to compute the first byte of the buffer. The offset is defined as
> + * the number of bytes between the end of the header and the beginning of
> + * the buffer. As such the formula is:
> + * 	actual_buffer = (unsigned long)(hdr+1)+hdr->hdr_start_offs
> + */
> +struct pfm_em64t_pebs_smpl_hdr {
> +	u64			hdr_overflows;	/* #overflows for buffer */
> +	size_t			hdr_buf_size;	/* bytes in the buffer */
> +	size_t			hdr_start_offs; /* actual buffer start offset */
> +	u32			hdr_version;	/* smpl format version */
> +	u64			hdr_res[3];	/* for future use */

Similar.

> +	struct pfm_em64t_ds_area hdr_ds;	/* DS management Area */
> +};

Only reviewed x86-64 specific files. Someone else will need to go through
the generic ones. 

-Andi
