Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965258AbWHWWfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965258AbWHWWfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965259AbWHWWfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:35:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18626 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965258AbWHWWft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:35:49 -0400
Date: Wed, 23 Aug 2006 15:26:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 5/18] 2.6.17.9 perfmon2 patch for review: sysfs support
Message-Id: <20060823152604.61de4157.akpm@osdl.org>
In-Reply-To: <200608230805.k7N85uvv000396@frankl.hpl.hp.com>
References: <200608230805.k7N85uvv000396@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 01:05:56 -0700
Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:

> This patch contains the sysfs support.
> 
> We use the sysfs interface fot two reasons:
> 	- perfmon2 administration
> 	- user level information
> 
> Perfmon2 creates new directories in /sys:
> 	- /sys/kernel/perfmon: for adminstration and global information
> 	- /sys/devices/system/cpu/cpuXX/perfmon: per-cpu statistics (debugging)
> 
> In /sys/kernel/perfmon we find:
> 	- arg_size_max (R/W): maximum size of vector arguments in bytes
> 	- buf_size_max (R/W):  maximum aggregated size of all smapling buffers
> 	- smpl_buffer_mem (R): current consumption of buf_size_max
> 	- counter_width	(R): PMU HW counter width
> 	- debug (R/W) : enable perfmon2 debugging messages
> 	- debug_ovfl (R/W): enable perfmon2 interrupt debugging messages
> 	- formats/	: information about available sampling formats
> 	- pmc_max_fast_arg (R): how many vector arguments can be processed on the stack for pfarg_pmc_t
> 	- pmd_max_fast_arg (R):  how many vector arguments can be processed on the stack for pfarg_pmd_t
> 	- pmu_desc/ : information about PMU register mapping
> 	- pmu_model (R): name of active PMU description module
> 	- reset_stats (W):  reset statistics
> 	- sys_group (R/W): which user group is allowed to create systemwide perfmon2 contexts
> 	- task_group (R/W): which user group is allowed to create per-thread perfmon2 contexts
> 	- sys_sessions_count (R):  number of active per-thread contexts
> 	- task_sessions_count (R): number of active system-wide contexts
> 	- version (R): perfmon2 version
> 
> The statistics we maintained in /sys/system/devices/cpu/cpuXX are mostly
> for debugging purposes at this point.
> 
> 
> 
> 
> --- linux-2.6.17.9.base/perfmon/perfmon_sysfs.c	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.17.9/perfmon/perfmon_sysfs.c	2006-08-21 03:37:46.000000000 -0700
> @@ -0,0 +1,637 @@
> +/*
> + * perfmon_proc.c: perfmon2 /proc interface
> + *
> + * This file implements the perfmon2 interface which
> + * provides access to the hardware performance counters
> + * of the host processor.
> + *
> + * The initial version of perfmon.c was written by
> + * Ganesh Venkitachalam, IBM Corp.
> + *
> + * Then it was modified for perfmon-1.x by Stephane Eranian and
> + * David Mosberger, Hewlett Packard Co.
> + *
> + * Version Perfmon-2.x is a complete rewrite of perfmon-1.x
> + * by Stephane Eranian, Hewlett Packard Co.
> + *
> + * Copyright (c) 1999-2006 Hewlett-Packard Development Company, L.P.
> + * Contributed by Stephane Eranian <eranian@hpl.hp.com>
> + *                David Mosberger-Tang <davidm@hpl.hp.com>
> + *
> + * More information about perfmon available at:
> + * 	http://www.hpl.hp.com/research/linux/perfmon
> + */
> +#include <linux/config.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/smp_lock.h>
> +#include <linux/proc_fs.h>
> +#include <linux/list.h>
> +#include <linux/version.h>
> +#include <linux/perfmon.h>
> +#include <linux/device.h>
> +#include <linux/cpu.h>
> +
> +#include <asm/bitops.h>
> +#include <asm/errno.h>
> +#include <asm/processor.h>
> +
> +struct pfm_attribute {
> +	struct attribute attr;
> +	ssize_t (*show)(void *, char *);
> +	ssize_t (*store)(void *, const char *, size_t);
> +};
> +#define to_attr(n) container_of(n, struct pfm_attribute, attr);
> +
> +#define PFM_RO_ATTR(_name) \
> +struct pfm_attribute attr_##_name = __ATTR_RO(_name)
> +
> +#define PFM_RW_ATTR(_name,_mode,_show,_store) 			\
> +struct pfm_attribute attr_##_name = __ATTR(_name,_mode,_show,_store);
> +
> +static int pfm_sysfs_init_done;	/* true when pfm_sysfs_init() completed */
> +
> +static void pfm_sysfs_init_percpu(int i);
> 
> +int pfm_sysfs_add_pmu(struct _pfm_pmu_config *pmu);

This is effectively an extern-decl-in-a-C-file.  Either it should be
static, or this declaration should be moved to a shared header file.

> +static ssize_t debug_store(void *info, const char *buf, size_t sz)
> +{
> +	int d;
> +
> +	if (sscanf(buf,"%d", &d) != 1)
> +		return -EINVAL;
> +
> +	pfm_controls.debug = d;
> +
> +	if (d == 0)
> +		pfm_reset_stats();
> +	return strnlen(buf, PAGE_SIZE);
> +}

hm.  Does the sysfs core zero-terminate the incoming buffer?  iirc it does.

perhaps a `return sz;' would be simpler and sufficient here.

> +int pfm_sysfs_init(void)
> +{
> +	int i, ret;
> +	
> +	ret = subsystem_register(&pfm_fmt_subsys);
> +	if (ret) {
> +		PFM_INFO("cannot register pfm_fmt_subsys: %d", ret);
> +		return ret;
> +	}
> +
> +	ret = subsystem_register(&pfm_pmu_subsys);
> +	if (ret) {
> +		PFM_INFO("cannot register pfm_pmu_subsys: %d", ret);
> +		subsystem_unregister(&pfm_fmt_subsys);
> +		return ret;
> +	}
> +
> +	ret = subsystem_register(&pfm_stats_subsys);
> +	if (ret) {
> +		PFM_INFO("cannot register pfm_statssubsys: %d", ret);
> +		subsystem_unregister(&pfm_fmt_subsys);
> +		subsystem_unregister(&pfm_pmu_subsys);
> +		return ret;
> +	}

We prefer the `goto out;' version of error recovery.

> +	kobject_init(&pfm_kernel_kobj);
> +	kobject_init(&pfm_kernel_fmt_kobj);
> +
> +	pfm_kernel_kobj.parent = &kernel_subsys.kset.kobj;
> +	kobject_set_name(&pfm_kernel_kobj, "perfmon");
> +
> +	pfm_kernel_fmt_kobj.parent = &pfm_kernel_kobj;
> +	kobject_set_name(&pfm_kernel_fmt_kobj, "formats");
> +
> +	kobject_add(&pfm_kernel_kobj);
> +	kobject_add(&pfm_kernel_fmt_kobj);
> +
> +	sysfs_create_group(&pfm_kernel_kobj, &pfm_kernel_attr_group);
> +
> +	for_each_online_cpu(i) {
> +		pfm_sysfs_init_percpu(i);
> +	}

Does this code support CPU hotplug?

> +	pfm_sysfs_init_done = 1;
> +
> +	pfm_builtin_fmt_sysfs_add();
> +
> +	if (pfm_pmu_conf)
> +		pfm_sysfs_add_pmu(pfm_pmu_conf);
> +
> +	return 0;
> +}
> +
>
> ...
>
> +
> +static ssize_t uuid_show(void *data, char *buf)
> +{
> +	struct pfm_smpl_fmt *fmt = data;
> +
> +	return snprintf(buf, PAGE_SIZE, "%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x"
> +			   "-%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x\n",
> +			fmt->fmt_uuid[0],
> +			fmt->fmt_uuid[1],
> +			fmt->fmt_uuid[2],
> +			fmt->fmt_uuid[3],
> +			fmt->fmt_uuid[4],
> +			fmt->fmt_uuid[5],
> +			fmt->fmt_uuid[6],
> +			fmt->fmt_uuid[7],
> +			fmt->fmt_uuid[8],
> +			fmt->fmt_uuid[9],
> +			fmt->fmt_uuid[10],
> +			fmt->fmt_uuid[11],
> +			fmt->fmt_uuid[12],
> +			fmt->fmt_uuid[13],
> +			fmt->fmt_uuid[14],
> +			fmt->fmt_uuid[15]);
> +}

Why does perfmon play with UUIDs??

> +
> +int pfm_sysfs_add_fmt(struct pfm_smpl_fmt *fmt)
> +{
> +	int ret;
> +
> +	if (pfm_sysfs_init_done == 0)
> +		return 0;
> +
> +	kobject_init(&fmt->kobj);
> +	kobject_set_name(&fmt->kobj, fmt->fmt_name);
> +	kobj_set_kset_s(fmt, pfm_fmt_subsys);
> +	fmt->kobj.parent = &pfm_kernel_fmt_kobj;
> +
> +	ret = kobject_add(&fmt->kobj);
> +
> +	return sysfs_create_file(&fmt->kobj, &attr_uuid.attr);
> +}
> +
> +int pfm_sysfs_remove_fmt(struct pfm_smpl_fmt *fmt)
> +{
> +	if (pfm_sysfs_init_done == 0)
> +		return 0;
> +
> +	sysfs_remove_file(&fmt->kobj, &attr_uuid.attr);
> +
> +	kobject_del(&fmt->kobj);
> +
> +	return 0;
> +}

What do these do?  (Some comments would be nice)

> +/*
> + * because the mappings can vary between one PMU and the other, we cannot really
> + * use an attribute per PMC to describe a mapping. Instead we have a single
> + * mappings attribute per PMU.
> + */
> +static ssize_t mappings_show(void *data, char *buf)
> +{
> +	struct _pfm_pmu_config *pmu = data;
> +	size_t s = PAGE_SIZE;
> +	u32 n = 0, i;
> +
> +	for (i = 0; i < PFM_MAX_PMCS;  i++) {
> +
> +		if ((pmu->pmc_desc[i].type & PFM_REG_I) == 0)
> +			continue;
> +
> +		n = snprintf(buf, s, "PMC%u:0x%llx:0x%llx:%s\n",
> +			     i,
> +			     (unsigned long long)pfm_pmu_conf->pmc_desc[i].dfl_val,
> +			     (unsigned long long)pfm_pmu_conf->pmc_desc[i].rsvd_msk,
> +			     pfm_pmu_conf->pmc_desc[i].desc);
> +		buf += n;
> +		if (n > s)
> +			goto skip;
> +		s -= n;
> +	}
> +
> +	for (i = 0; i < PFM_MAX_PMDS;  i++) {
> +
> +		if ((pmu->pmd_desc[i].type & PFM_REG_I) == 0)
> +			continue;
> +
> +		n = snprintf(buf, s, "PMD%u:0x%llx:0x%llx:%s\n",
> +			     i,
> +			     (unsigned long long)pfm_pmu_conf->pmd_desc[i].dfl_val,
> +			     (unsigned long long)pfm_pmu_conf->pmd_desc[i].rsvd_msk,
> +			     pfm_pmu_conf->pmd_desc[i].desc);
> +		buf += n;
> +		if (n > s)
> +			break;
> +		s -= n;
> +	}
> +skip:
> +	return PAGE_SIZE - s;
> +}

This breaks the one-value-per-sysfs-file rule.

> +PFM_RO_ATTR(mappings);
> +
> +int pfm_sysfs_add_pmu(struct _pfm_pmu_config *pmu)
> +{
> +	if (pfm_sysfs_init_done == 0)
> +		return 0;
> +
> +	kobject_init(&pmu->kobj);
> +	kobject_set_name(&pmu->kobj, "pmu_desc");
> +	kobj_set_kset_s(pmu, pfm_pmu_subsys);
> +	pmu->kobj.parent = &pfm_kernel_kobj;
> +
> +	kobject_add(&pmu->kobj);
> +
> +	return sysfs_create_file(&pmu->kobj, &attr_mappings.attr);
> +}
> +
> +int pfm_sysfs_remove_pmu(struct _pfm_pmu_config *pmu)
> +{
> +	if (pfm_sysfs_init_done == 0)
> +		return 0;
> +
> +	sysfs_remove_file(&pmu->kobj, &attr_mappings.attr);
> +
> +	kobject_del(&pmu->kobj);
> +
> +	return 0;
> +}

Again - comments, please.
