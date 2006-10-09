Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932853AbWJIOKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbWJIOKg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932829AbWJIOKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:10:36 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:25841 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932853AbWJIOKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:10:34 -0400
Date: Mon, 9 Oct 2006 07:10:11 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EABcN026051@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/21] 2.6.18 perfmon2 : sysfs support
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the sysfs support.

We use the sysfs interface fot two reasons:
	- perfmon2 administration
	- user level information

Perfmon2 creates new directories in /sys:
	- /sys/kernel/perfmon: for adminstration and global information
	- /sys/devices/system/cpu/cpuXX/perfmon: per-cpu statistics (debugging)

In /sys/kernel/perfmon we find:
	- arg_size_max (R/W): maximum size of vector arguments in bytes
	- buf_size_max (R/W):  maximum aggregated size of all smapling buffers
	- smpl_buffer_mem (R): current consumption of buf_size_max
	- debug (R/W) : enable perfmon2 debugging messages
	- debug_ovfl (R/W): enable perfmon2 interrupt debugging messages
	- formats/	: information about available sampling formats
	- pmc_max_fast_arg (R): how many vector arguments can be processed on the stack for pfarg_pmc_t
	- pmd_max_fast_arg (R):  how many vector arguments can be processed on the stack for pfarg_pmd_t

	- reset_stats (W):  reset statistics
	- sys_group (R/W): which user group is allowed to create systemwide perfmon2 contexts
	- task_group (R/W): which user group is allowed to create per-thread perfmon2 contexts
	- sys_sessions_count (R):  number of active per-thread contexts
	- task_sessions_count (R): number of active system-wide contexts
	- version (R): perfmon2 version

In /sys/kernel/perfmon/pmu_desc (created at first use of subsystem):
	- model (R): name of active PMU description module
	- counter_width	(R): PMU HW counter width
	- one subdirs for each pmd or pmc register

In /sys/kernel/perfmon/pmu_desc/pmdX:
	- addr	 (R) : hardware address or index of register
	- dfl_val (R): default value
	- name    (R): logical name
	- rsvd_msk(R): reserved bits 

In /sys/kernel/perfmon/pmu_desc/pmcX:
	- addr	 (R) : hardware address or index of register
	- dfl_val (R): default value
	- name    (R): logical name
	- rsvd_msk(R): reserved bits 

The statistics we maintained in /sys/system/devices/cpu/cpuXX are mostly
for debugging purposes at this point. Added/removed on CPU hotplug events.




--- linux-2.6.18.base/perfmon/perfmon_sysfs.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/perfmon/perfmon_sysfs.c	2006-09-25 12:11:05.000000000 -0700
@@ -0,0 +1,893 @@
+/*
+ * perfmon_proc.c: perfmon2 /proc interface
+ *
+ * This file implements the perfmon2 interface which
+ * provides access to the hardware performance counters
+ * of the host processor.
+ *
+ * The initial version of perfmon.c was written by
+ * Ganesh Venkitachalam, IBM Corp.
+ *
+ * Then it was modified for perfmon-1.x by Stephane Eranian and
+ * David Mosberger, Hewlett Packard Co.
+ *
+ * Version Perfmon-2.x is a complete rewrite of perfmon-1.x
+ * by Stephane Eranian, Hewlett Packard Co.
+ *
+ * Copyright (c) 1999-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *                David Mosberger-Tang <davidm@hpl.hp.com>
+ *
+ * More information about perfmon available at:
+ * 	http://perfmon2.sf.net
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/smp_lock.h>
+#include <linux/proc_fs.h>
+#include <linux/list.h>
+#include <linux/version.h>
+#include <linux/perfmon.h>
+#include <linux/device.h>
+#include <linux/cpu.h>
+
+#include <asm/bitops.h>
+#include <asm/errno.h>
+#include <asm/processor.h>
+
+struct pfm_attribute {
+	struct attribute attr;
+	ssize_t (*show)(void *, char *);
+	ssize_t (*store)(void *, const char *, size_t);
+};
+#define to_attr(n) container_of(n, struct pfm_attribute, attr);
+
+#define PFM_RO_ATTR(_name) \
+struct pfm_attribute attr_##_name = __ATTR_RO(_name)
+
+#define PFM_RW_ATTR(_name,_mode,_show,_store) 			\
+struct pfm_attribute attr_##_name = __ATTR(_name,_mode,_show,_store);
+
+static int pfm_sysfs_init_done;	/* true when pfm_sysfs_init() completed */
+
+int pfm_sysfs_add_pmu(struct _pfm_pmu_config *pmu);
+
+struct pfm_controls pfm_controls = {
+	.sys_group = PFM_GROUP_PERM_ANY,
+	.task_group = PFM_GROUP_PERM_ANY,
+	.arg_size_max = PAGE_SIZE,
+	.smpl_buf_size_max = ~0,
+};
+EXPORT_SYMBOL(pfm_controls);
+
+DECLARE_PER_CPU(struct pfm_stats, pfm_stats);
+
+static struct kobject pfm_kernel_kobj, pfm_kernel_fmt_kobj;
+
+static void pfm_reset_stats(int cpu)
+{
+	struct pfm_stats *st;
+
+
+	st = &per_cpu(pfm_stats, cpu);
+	/*
+	 * cannot use memset because of kobj member
+	 */
+	st->pfm_ovfl_intr_replay_count = 0;
+	st->pfm_ovfl_intr_regular_count = 0;
+	st->pfm_ovfl_intr_all_count = 0;
+	st->pfm_ovfl_intr_ns = 0;
+	st->pfm_ovfl_intr_phase1 = 0;
+	st->pfm_ovfl_intr_phase2 = 0;
+	st->pfm_ovfl_intr_phase3 = 0;
+	st->pfm_ovfl_intr_nmi_count = 0;
+	st->pfm_fmt_handler_calls = 0;
+	st->pfm_fmt_handler_ns = 0;
+	st->pfm_set_switch_count = 0;
+	st->pfm_set_switch_ns = 0;
+	st->pfm_ctxsw_count = 0;
+	st->pfm_ctxsw_ns = 0;
+	st->pfm_handle_timeout_count = 0;
+}
+
+
+static ssize_t pfm_fmt_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct pfm_smpl_fmt *fmt = to_smpl_fmt(kobj);
+	struct pfm_attribute *attribute = to_attr(attr);
+	return attribute->show ? attribute->show(fmt, buf) : -EIO;
+}
+
+static ssize_t pfm_pmu_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct _pfm_pmu_config *pmu= to_pmu(kobj);
+	struct pfm_attribute *attribute = to_attr(attr);
+	return attribute->show ? attribute->show(pmu, buf) : -EIO;
+}
+
+static ssize_t pfm_stats_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct pfm_stats *st = to_stats(kobj);
+	struct pfm_attribute *attribute = to_attr(attr);
+	return attribute->show ? attribute->show(st, buf) : -EIO;
+}
+
+static ssize_t pfm_regs_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct pfm_reg_desc *reg = to_reg(kobj);
+	struct pfm_attribute *attribute = to_attr(attr);
+	return attribute->show ? attribute->show(reg, buf) : -EIO;
+}
+
+static ssize_t pfm_stats_attr_store(struct kobject *kobj,
+		struct attribute *attr, const char *buf, size_t count)
+{
+	struct pfm_stats *st = to_stats(kobj);
+	struct pfm_attribute *attribute = to_attr(attr);
+	return attribute->store ? attribute->store(st, buf, count) : -EIO;
+}
+
+static struct sysfs_ops pfm_fmt_sysfs_ops = {
+	.show = pfm_fmt_attr_show
+};
+
+static struct sysfs_ops pfm_pmu_sysfs_ops = {
+	.show = pfm_pmu_attr_show
+};
+
+static struct sysfs_ops pfm_stats_sysfs_ops = {
+	.show  = pfm_stats_attr_show,
+	.store = pfm_stats_attr_store
+};
+
+static struct sysfs_ops pfm_regs_sysfs_ops = {
+	.show  = pfm_regs_attr_show
+};
+
+static struct kobj_type pfm_fmt_ktype = {
+	.sysfs_ops = &pfm_fmt_sysfs_ops,
+};
+
+static struct kobj_type pfm_pmu_ktype = {
+	.sysfs_ops = &pfm_pmu_sysfs_ops,
+};
+
+static struct kobj_type pfm_stats_ktype = {
+	.sysfs_ops = &pfm_stats_sysfs_ops,
+};
+
+static struct kobj_type pfm_regs_ktype = {
+	.sysfs_ops = &pfm_regs_sysfs_ops,
+};
+
+decl_subsys_name(pfm_fmt, pfm_fmt, &pfm_fmt_ktype, NULL);
+decl_subsys_name(pfm_pmu, pfm_pmu, &pfm_pmu_ktype, NULL);
+decl_subsys_name(pfm_stats, pfm_stats, &pfm_stats_ktype, NULL);
+decl_subsys_name(pfm_regs, pfm_regs, &pfm_regs_ktype, NULL);
+
+static ssize_t version_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u.%u\n",  PFM_VERSION_MAJ, PFM_VERSION_MIN);
+}
+
+static ssize_t pmd_max_fast_arg_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u\n",  PFM_PMD_STK_ARG);
+}
+
+static ssize_t pmc_max_fast_arg_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u\n",  PFM_PMC_STK_ARG);
+}
+
+
+
+static ssize_t task_sessions_count_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 0);
+}
+
+static ssize_t sys_sessions_count_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 1);
+}
+
+static ssize_t smpl_buffer_mem_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 2);
+}
+
+static ssize_t debug_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.debug);
+}
+
+static ssize_t debug_store(void *info, const char *buf, size_t sz)
+{
+	int d, i;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.debug = d;
+
+	if (d == 0) {
+		for_each_online_cpu(i) {
+			pfm_reset_stats(i);
+		}
+	}
+	return sz;
+}
+
+static ssize_t debug_ovfl_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.debug_ovfl);
+}
+
+static ssize_t debug_ovfl_store(void *info, const char *buf, size_t sz)
+{
+	int d;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.debug_ovfl = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t reset_stats_show(void *info, char *buf)
+{
+	buf[0]='0';
+	buf[1]='\0';
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t reset_stats_store(void *info, const char *buf, size_t count)
+{
+	int i;
+
+	for_each_online_cpu(i) {
+		pfm_reset_stats(i);
+	}
+	return count;
+}
+
+static ssize_t sys_group_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.sys_group);
+}
+
+static ssize_t sys_group_store(void *info, const char *buf, size_t sz)
+{
+	int d;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.sys_group = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t task_group_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.task_group);
+}
+
+static ssize_t task_group_store(void *info, const char *buf, size_t sz)
+{
+	int d;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.task_group = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t buf_size_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%zu\n", pfm_controls.smpl_buf_size_max);
+}
+
+static ssize_t buf_size_store(void *info, const char *buf, size_t sz)
+{
+	size_t d;
+
+	if (sscanf(buf,"%zu", &d) != 1)
+		return -EINVAL;
+	/*
+	 * we impose a page as the minimum
+	 */
+	if (d < PAGE_SIZE)
+		return -EINVAL;
+
+	pfm_controls.smpl_buf_size_max = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static ssize_t arg_size_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%zu\n", pfm_controls.arg_size_max);
+}
+
+static ssize_t arg_size_store(void *info, const char *buf, size_t sz)
+{
+	size_t d;
+
+	if (sscanf(buf,"%zu", &d) != 1)
+		return -EINVAL;
+
+	/*
+	 * we impose a page as the minimum.
+	 *
+	 * This limit may be smaller than the stack buffer
+	 * available and that is fine.
+	 */
+	if (d < PAGE_SIZE)
+		return -EINVAL;
+
+	pfm_controls.arg_size_max = d;
+
+	return strnlen(buf, PAGE_SIZE);
+}
+
+/*
+ * /sys/kernel/perfmon attributes
+ */
+static PFM_RO_ATTR(version);
+static PFM_RO_ATTR(task_sessions_count);
+static PFM_RO_ATTR(sys_sessions_count);
+static PFM_RO_ATTR(smpl_buffer_mem);
+static PFM_RO_ATTR(pmd_max_fast_arg);
+static PFM_RO_ATTR(pmc_max_fast_arg);
+
+static PFM_RW_ATTR(debug, 0644, debug_show, debug_store);
+static PFM_RW_ATTR(debug_ovfl, 0644, debug_ovfl_show, debug_ovfl_store);
+static PFM_RW_ATTR(reset_stats, 0644, reset_stats_show, reset_stats_store);
+static PFM_RW_ATTR(sys_group, 0644, sys_group_show, sys_group_store);
+static PFM_RW_ATTR(task_group, 0644, task_group_show, task_group_store);
+static PFM_RW_ATTR(buf_size_max, 0644, buf_size_show, buf_size_store);
+static PFM_RW_ATTR(arg_size_max, 0644, arg_size_show, arg_size_store);
+
+static struct attribute *pfm_kernel_attrs[] = {
+	&attr_version.attr,
+	&attr_task_sessions_count.attr,
+	&attr_sys_sessions_count.attr,
+	&attr_smpl_buffer_mem.attr,
+	&attr_pmd_max_fast_arg.attr,
+	&attr_pmc_max_fast_arg.attr,
+	&attr_debug.attr,
+	&attr_debug_ovfl.attr,
+	&attr_reset_stats.attr,
+	&attr_sys_group.attr,
+	&attr_task_group.attr,
+	&attr_buf_size_max.attr,
+	&attr_arg_size_max.attr,
+	NULL
+};
+
+static struct attribute_group pfm_kernel_attr_group = {
+	.attrs = pfm_kernel_attrs,
+};
+
+int __init pfm_init_sysfs(void)
+{
+	int ret;
+	int done_fmt = 0, done_pmu = 0, done_stats = 0, done_regs = 0;
+	int done_kobj_fmt = 0, done_kobj_kernel = 0;
+	int i, cpu = -1;
+	
+	ret = subsystem_register(&pfm_fmt_subsys);
+	if (ret) {
+		PFM_INFO("cannot register pfm_fmt_subsys: %d", ret);
+		goto error;
+	}
+	done_fmt = 1;
+
+	ret = subsystem_register(&pfm_pmu_subsys);
+	if (ret) {
+		PFM_INFO("cannot register pfm_pmu_subsys: %d", ret);
+		goto error;
+	}
+	done_pmu = 1;
+
+	ret = subsystem_register(&pfm_stats_subsys);
+	if (ret) {
+		PFM_INFO("cannot register pfm_stats_subsys: %d", ret);
+		goto error;
+	}
+	done_stats = 1;
+
+	ret = subsystem_register(&pfm_regs_subsys);
+	if (ret) {
+		PFM_INFO("cannot register pfm_regs_subsys: %d", ret);
+		goto error;
+	}
+	done_regs = 1;
+
+
+	kobject_init(&pfm_kernel_kobj);
+	kobject_init(&pfm_kernel_fmt_kobj);
+
+	pfm_kernel_kobj.parent = &kernel_subsys.kset.kobj;
+	kobject_set_name(&pfm_kernel_kobj, "perfmon");
+
+	pfm_kernel_fmt_kobj.parent = &pfm_kernel_kobj;
+	kobject_set_name(&pfm_kernel_fmt_kobj, "formats");
+
+	ret = kobject_add(&pfm_kernel_kobj);
+	if (ret) {
+		PFM_INFO("cannot add kernel object: %d", ret);
+		goto error;
+	}
+	done_kobj_kernel = 1;
+
+	ret = kobject_add(&pfm_kernel_fmt_kobj);
+	if (ret) {
+		PFM_INFO("cannot add fmt object: %d", ret);
+		goto error;
+	}
+	done_kobj_fmt = 1;
+
+	ret = sysfs_create_group(&pfm_kernel_kobj, &pfm_kernel_attr_group);
+	if (ret) {
+		PFM_INFO("cannot create kernel group");
+		goto error;
+	}
+
+	/*
+	 * must be set before builtin_fmt and
+	 * add_pmu() calls
+	 */
+	pfm_sysfs_init_done = 1;
+
+	pfm_sysfs_builtin_fmt_add();
+
+	if (pfm_pmu_conf)
+		pfm_sysfs_add_pmu(pfm_pmu_conf);
+
+	for_each_online_cpu(cpu) {
+		ret = pfm_sysfs_add_cpu(cpu);
+		if (ret)
+			goto error;
+	}
+	return 0;
+error:
+	if (done_fmt)
+		subsystem_unregister(&pfm_fmt_subsys);
+	if (done_pmu)
+		subsystem_unregister(&pfm_pmu_subsys);
+	if (done_stats)
+		subsystem_unregister(&pfm_stats_subsys);
+	if (done_regs)
+		subsystem_unregister(&pfm_regs_subsys);
+	if (done_kobj_kernel)
+		kobject_del(&pfm_kernel_kobj);
+	if (done_kobj_fmt)
+		kobject_del(&pfm_kernel_fmt_kobj);
+
+	for (i=0; i < cpu; i++)
+		pfm_sysfs_del_cpu(i);
+
+	return ret;
+}
+
+/*
+ * per-cpu perfmon stats attributes
+ */
+#define PFM_DECL_STATS_ATTR(name) \
+static ssize_t name##_show(void *info, char *buf) \
+{ \
+	struct pfm_stats *st = info;\
+	return snprintf(buf, PAGE_SIZE, "%llu\n", \
+			(unsigned long long)st->pfm_##name); \
+} \
+static PFM_RO_ATTR(name)
+
+PFM_DECL_STATS_ATTR(ovfl_intr_replay_count);
+PFM_DECL_STATS_ATTR(ovfl_intr_all_count);
+PFM_DECL_STATS_ATTR(ovfl_intr_ns);
+PFM_DECL_STATS_ATTR(fmt_handler_calls);
+PFM_DECL_STATS_ATTR(fmt_handler_ns);
+PFM_DECL_STATS_ATTR(set_switch_count);
+PFM_DECL_STATS_ATTR(set_switch_ns);
+PFM_DECL_STATS_ATTR(ctxsw_count);
+PFM_DECL_STATS_ATTR(ctxsw_ns);
+PFM_DECL_STATS_ATTR(handle_timeout_count);
+PFM_DECL_STATS_ATTR(ovfl_intr_nmi_count);
+
+/*
+ * per-reg attributes
+ */
+static ssize_t name_show(void *info, char *buf)
+{ 
+	struct pfm_reg_desc *reg = info;
+	return snprintf(buf, PAGE_SIZE, "%s\n", reg->desc);
+}
+static PFM_RO_ATTR(name);
+
+static ssize_t dfl_val_show(void *info, char *buf)
+{ 
+	struct pfm_reg_desc *reg = info;
+	return snprintf(buf, PAGE_SIZE, "0x%llx\n",
+			(unsigned long long)reg->dfl_val);
+}
+static PFM_RO_ATTR(dfl_val);
+
+static ssize_t rsvd_msk_show(void *info, char *buf)
+{ 
+	struct pfm_reg_desc *reg = info;
+	return snprintf(buf, PAGE_SIZE, "0x%llx\n",
+			(unsigned long long)reg->rsvd_msk);
+}
+static PFM_RO_ATTR(rsvd_msk);
+
+static ssize_t addr_show(void *info, char *buf)
+{ 
+	struct pfm_reg_desc *reg = info;
+	return snprintf(buf, PAGE_SIZE, "0x%lx\n", reg->hw_addr);
+}
+static PFM_RO_ATTR(addr);
+
+static ssize_t ovfl_intr_spurious_count_show(void *info, char *buf)
+{
+	struct pfm_stats *st = info;
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)(st->pfm_ovfl_intr_all_count
+					     - st->pfm_ovfl_intr_regular_count));
+}
+
+static ssize_t ovfl_intr_regular_count_show(void *info, char *buf)
+{
+	struct pfm_stats *st = info;
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)(st->pfm_ovfl_intr_regular_count
+					     - st->pfm_ovfl_intr_replay_count));
+}
+
+static PFM_RO_ATTR(ovfl_intr_spurious_count);
+static PFM_RO_ATTR(ovfl_intr_regular_count);
+
+static struct attribute *pfm_cpu_attrs[] = {
+	&attr_ovfl_intr_spurious_count.attr,
+	&attr_ovfl_intr_replay_count.attr,
+	&attr_ovfl_intr_regular_count.attr,
+	&attr_ovfl_intr_all_count.attr,
+	&attr_ovfl_intr_ns.attr,
+	&attr_fmt_handler_calls.attr,
+	&attr_fmt_handler_ns.attr,
+	&attr_set_switch_count.attr,
+	&attr_set_switch_ns.attr,
+	&attr_ctxsw_count.attr,
+	&attr_ctxsw_ns.attr,
+	&attr_handle_timeout_count.attr,
+	&attr_ovfl_intr_nmi_count.attr,
+	NULL
+};
+
+static struct attribute_group pfm_cpu_attr_group = {
+	.attrs = pfm_cpu_attrs,
+};
+
+int pfm_sysfs_add_cpu(int mycpu)
+{
+	struct sys_device *cpudev;
+	struct pfm_stats *st;
+	int ret;
+
+	cpudev = get_cpu_sysdev(mycpu);
+	if (!cpudev)
+		return -EINVAL;
+
+	st = &per_cpu(pfm_stats, mycpu);
+
+	kobject_init(&st->kobj);
+
+	st->kobj.parent = &cpudev->kobj;
+	kobject_set_name(&st->kobj, "perfmon");
+	kobj_set_kset_s(st, pfm_stats_subsys);
+
+	ret = kobject_add(&st->kobj);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_group(&st->kobj, &pfm_cpu_attr_group);
+	if (ret)
+		kobject_del(&st->kobj);
+
+	pfm_reset_stats(mycpu);
+
+	return ret;
+}
+
+void pfm_sysfs_del_cpu(int mycpu)
+{
+	struct sys_device *cpudev;
+	struct pfm_stats *st;
+
+	cpudev = get_cpu_sysdev(mycpu);
+	if (!cpudev)
+		return;
+
+	st = &per_cpu(pfm_stats, mycpu);
+	kobject_del(&st->kobj);
+
+	sysfs_remove_group(&st->kobj, &pfm_cpu_attr_group);
+}
+
+static ssize_t uuid_show(void *data, char *buf)
+{
+	struct pfm_smpl_fmt *fmt = data;
+
+	return snprintf(buf, PAGE_SIZE, "%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x"
+			   "-%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x\n",
+			fmt->fmt_uuid[0],
+			fmt->fmt_uuid[1],
+			fmt->fmt_uuid[2],
+			fmt->fmt_uuid[3],
+			fmt->fmt_uuid[4],
+			fmt->fmt_uuid[5],
+			fmt->fmt_uuid[6],
+			fmt->fmt_uuid[7],
+			fmt->fmt_uuid[8],
+			fmt->fmt_uuid[9],
+			fmt->fmt_uuid[10],
+			fmt->fmt_uuid[11],
+			fmt->fmt_uuid[12],
+			fmt->fmt_uuid[13],
+			fmt->fmt_uuid[14],
+			fmt->fmt_uuid[15]);
+}
+PFM_RO_ATTR(uuid);
+
+/*
+ * when a sampling format module is inserted, we populate
+ * sysfs with some information
+ */
+int pfm_sysfs_add_fmt(struct pfm_smpl_fmt *fmt)
+{
+	int ret;
+
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	kobject_init(&fmt->kobj);
+	kobject_set_name(&fmt->kobj, fmt->fmt_name);
+	kobj_set_kset_s(fmt, pfm_fmt_subsys);
+	fmt->kobj.parent = &pfm_kernel_fmt_kobj;
+
+	ret = kobject_add(&fmt->kobj);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_file(&fmt->kobj, &attr_uuid.attr);
+	if (ret)
+		kobject_del(&fmt->kobj);
+
+	return ret;
+}
+
+/*
+ * when a sampling format module is removed, its information
+ * must also be removed from sysfs
+ */
+int pfm_sysfs_remove_fmt(struct pfm_smpl_fmt *fmt)
+{
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	sysfs_remove_file(&fmt->kobj, &attr_uuid.attr);
+	kobject_del(&fmt->kobj);
+
+	return 0;
+}
+
+static struct attribute *pfm_reg_attrs[] = {
+	&attr_name.attr,
+	&attr_dfl_val.attr,
+	&attr_rsvd_msk.attr,
+	&attr_addr.attr,
+	NULL
+};
+
+static struct attribute_group pfm_reg_attr_group = {
+	.attrs = pfm_reg_attrs,
+};
+
+static ssize_t counter_width_show(void *info, char *buf)
+{
+	struct _pfm_pmu_config *p = info;
+	return snprintf(buf, PAGE_SIZE, "%d\n", p->counter_width);
+}
+static PFM_RO_ATTR(counter_width);
+
+static ssize_t model_show(void *info, char *buf)
+{
+	struct _pfm_pmu_config *p = info;
+	return snprintf(buf, PAGE_SIZE, "%s\n", p->pmu_name);
+}
+static PFM_RO_ATTR(model);
+
+static struct attribute *pfm_pmu_desc_attrs[] = {
+	&attr_model.attr,
+	&attr_counter_width.attr,
+	NULL
+};
+
+static struct attribute_group pfm_pmu_desc_attr_group = {
+	.attrs = pfm_pmu_desc_attrs,
+};
+
+static int pfm_sysfs_add_pmu_regs(struct _pfm_pmu_config *pmu)
+{
+	struct pfm_reg_desc *reg;
+	unsigned int i, j, k;
+	int ret;
+	char reg_name[8];
+
+	reg = pmu->pmc_desc;
+	for(i=0; i < pmu->max_pmc; i++, reg++) {
+
+		if (!(reg->type & PFM_REG_I))
+			continue;
+
+		kobject_init(&reg->kobj);
+
+		reg->kobj.parent = &pmu->kobj;
+		snprintf(reg_name, sizeof(reg_name), "pmc%u", i);
+		kobject_set_name(&reg->kobj, reg_name);
+		kobj_set_kset_s(reg, pfm_regs_subsys);
+
+		ret = kobject_add(&reg->kobj);
+		if (ret)
+			goto undo_pmcs;
+
+		ret = sysfs_create_group(&reg->kobj, &pfm_reg_attr_group);
+		if (ret) {
+			kobject_del(&reg->kobj);
+			goto undo_pmcs;
+		}
+	}
+
+	reg = pmu->pmd_desc;
+	for(j=0; j < pmu->max_pmd; j++, reg++) {
+
+		if (!(reg->type & PFM_REG_I))
+			continue;
+
+		kobject_init(&reg->kobj);
+
+		reg->kobj.parent = &pmu->kobj;
+		snprintf(reg_name, sizeof(reg_name), "pmd%u", j);
+		kobject_set_name(&reg->kobj, reg_name);
+		kobj_set_kset_s(reg, pfm_regs_subsys);
+
+		ret = kobject_add(&reg->kobj);
+		if (ret)
+			goto undo_pmds;
+
+		ret = sysfs_create_group(&reg->kobj, &pfm_reg_attr_group);
+		if (ret) {
+			kobject_del(&reg->kobj);
+			goto undo_pmds;
+		}
+	}
+	return 0;
+undo_pmds:
+	reg = pmu->pmd_desc;
+	for(k = 0; k < j; k++, reg++) {
+		if (!(reg->type & PFM_REG_I))
+			continue;
+		sysfs_remove_group(&reg->kobj, &pfm_reg_attr_group);
+		kobject_del(&reg->kobj);
+	}
+undo_pmcs:
+	reg = pmu->pmc_desc;
+	for(k=0; k < i; k++, reg++) {
+		if (!(reg->type & PFM_REG_I))
+			continue;
+		sysfs_remove_group(&reg->kobj, &pfm_reg_attr_group);
+		kobject_del(&reg->kobj);
+	}
+	return ret;
+}
+
+static int pfm_sysfs_del_pmu_regs(struct _pfm_pmu_config *pmu)
+{
+	struct pfm_reg_desc *reg;
+	unsigned int i;
+
+	reg = pmu->pmc_desc;
+	for(i=0; i < pmu->max_pmc; i++, reg++) {
+
+		if (!(reg->type & PFM_REG_I))
+			continue;
+
+		sysfs_remove_group(&reg->kobj, &pfm_reg_attr_group);
+		kobject_del(&reg->kobj);
+	}
+
+	reg = pmu->pmd_desc;
+	for(i=0; i < pmu->max_pmd; i++, reg++) {
+
+		if (!(reg->type & PFM_REG_I))
+			continue;
+
+		sysfs_remove_group(&reg->kobj, &pfm_reg_attr_group);
+		kobject_del(&reg->kobj);
+	}
+	return 0;
+}
+
+/*
+ * when a PMU description module is inserted, we create
+ * a pmu_desc subdir in sysfs and we populate it with
+ * PMU specific information, such as register mappings
+ */
+int pfm_sysfs_add_pmu(struct _pfm_pmu_config *pmu)
+{
+	int ret;
+
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	kobject_init(&pmu->kobj);
+	kobject_set_name(&pmu->kobj, "pmu_desc");
+	kobj_set_kset_s(pmu, pfm_pmu_subsys);
+	pmu->kobj.parent = &pfm_kernel_kobj;
+
+	ret = kobject_add(&pmu->kobj);
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_group(&pmu->kobj, &pfm_pmu_desc_attr_group);
+	if (ret)
+		kobject_del(&pmu->kobj);
+
+	ret = pfm_sysfs_add_pmu_regs(pmu);
+	if (ret) {
+		sysfs_remove_group(&pmu->kobj, &pfm_pmu_desc_attr_group);
+                kobject_del(&pmu->kobj);
+	}
+	return ret;
+}
+
+/*
+ * when a PMU description module is removed, we also remove
+ * all its information from sysfs, i.e., the pmu_desc subdir
+ * disappears
+ */
+int pfm_sysfs_remove_pmu(struct _pfm_pmu_config *pmu)
+{
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	pfm_sysfs_del_pmu_regs(pmu);
+	sysfs_remove_group(&pmu->kobj, &pfm_pmu_desc_attr_group);
+	kobject_del(&pmu->kobj);
+
+	return 0;
+}
