Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWFOJPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWFOJPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWFOJPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:15:12 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:28072 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S932434AbWFOJPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:15:05 -0400
Date: Thu, 15 Jun 2006 02:07:34 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606150907.k5F97YtU008130@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 5/16] 2.6.17-rc6 perfmon2 patch for review: new sysfs support
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the sysfs support.




--- linux-2.6.17-rc6.orig/perfmon/perfmon_sysfs.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc6/perfmon/perfmon_sysfs.c	2006-06-08 05:36:31.000000000 -0700
@@ -0,0 +1,636 @@
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
+ * 	http://www.hpl.hp.com/research/linux/perfmon
+ */
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
+static void pfm_sysfs_init_percpu(int i);
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
+static void pfm_reset_stats(void)
+{
+	struct pfm_stats *st;
+	int m;
+
+	for_each_online_cpu(m) {
+
+		st = &per_cpu(pfm_stats,m);
+		/*
+		 * cannot use memset because of kobj member
+		 */
+		st->pfm_ovfl_intr_replay_count = 0;
+		st->pfm_ovfl_intr_regular_count = 0;
+		st->pfm_ovfl_intr_all_count = 0;
+		st->pfm_ovfl_intr_cycles = 0;
+		st->pfm_ovfl_intr_phase1 = 0;
+		st->pfm_ovfl_intr_phase2 = 0;
+		st->pfm_ovfl_intr_phase3 = 0;
+		st->pfm_fmt_handler_calls = 0;
+		st->pfm_fmt_handler_cycles = 0;
+		st->pfm_set_switch_count = 0;
+		st->pfm_set_switch_cycles = 0;
+		st->pfm_handle_timeout_count = 0;
+	}
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
+static ssize_t pfm_stats_attr_store(struct kobject *kobj,
+		struct attribute *attr, const char *buf, size_t count)
+{
+	struct pfm_stats *st = to_stats(kobj);
+	struct pfm_attribute *attribute = to_attr(attr);
+	return attribute->store ? attribute->store(st, buf, count) : -EIO;
+}
+
+static struct sysfs_ops pfm_fmt_sysfs_ops = {
+	.show = pfm_fmt_attr_show,
+};
+
+static struct sysfs_ops pfm_pmu_sysfs_ops = {
+	.show = pfm_pmu_attr_show,
+};
+
+static struct sysfs_ops pfm_stats_sysfs_ops = {
+	.show  = pfm_stats_attr_show,
+	.store = pfm_stats_attr_store,
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
+decl_subsys_name(pfm_fmt, pfm_fmt, &pfm_fmt_ktype, NULL);
+decl_subsys_name(pfm_pmu, pfm_pmu, &pfm_pmu_ktype, NULL);
+decl_subsys_name(pfm_stats, pfm_stats, &pfm_stats_ktype, NULL);
+
+static ssize_t version_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%u.%u\n",  PFM_VERSION_MAJ, PFM_VERSION_MIN);
+}
+
+static ssize_t pmu_model_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 0);
+}
+
+static ssize_t counter_width_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 1);
+}
+
+static ssize_t task_sessions_count_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 2);
+}
+
+static ssize_t sys_sessions_count_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 3);
+}
+
+static ssize_t smpl_buffer_mem_show(void *info, char *buf)
+{
+	return pfm_sysfs_session_show(buf, PAGE_SIZE, 4);
+}
+
+static ssize_t debug_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.debug);
+}
+
+static ssize_t debug_store(void *info, const char *buf, size_t sz)
+{
+	int d;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.debug = d;
+
+	if (d == 0)
+		pfm_reset_stats();
+	return strnlen(buf, PAGE_SIZE);
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
+	pfm_reset_stats();
+	return count;
+}
+
+static ssize_t expert_mode_show(void *info, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.expert_mode);
+}
+
+static ssize_t expert_mode_store(void *info, const char *buf, size_t sz)
+{
+	int d;
+
+	if (sscanf(buf,"%d", &d) != 1)
+		return -EINVAL;
+
+	pfm_controls.expert_mode = d;
+
+	return strnlen(buf, PAGE_SIZE);
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
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.expert_mode);
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
+	return snprintf(buf, PAGE_SIZE, "%d\n", pfm_controls.expert_mode);
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
+	 * we impose a page as the minimum
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
+static PFM_RO_ATTR(pmu_model);
+static PFM_RO_ATTR(counter_width);
+static PFM_RO_ATTR(task_sessions_count);
+static PFM_RO_ATTR(sys_sessions_count);
+static PFM_RO_ATTR(smpl_buffer_mem);
+
+static PFM_RW_ATTR(debug, 0644, debug_show, debug_store);
+static PFM_RW_ATTR(debug_ovfl, 0644, debug_ovfl_show, debug_ovfl_store);
+static PFM_RW_ATTR(reset_stats, 0644, reset_stats_show, reset_stats_store);
+static PFM_RW_ATTR(expert_mode, 0644, expert_mode_show, expert_mode_store);
+static PFM_RW_ATTR(sys_group, 0644, sys_group_show, sys_group_store);
+static PFM_RW_ATTR(task_group, 0644, task_group_show, task_group_store);
+static PFM_RW_ATTR(buf_size_max, 0644, buf_size_show, buf_size_store);
+static PFM_RW_ATTR(arg_size_max, 0644, arg_size_show, arg_size_store);
+
+static struct attribute *pfm_kernel_attrs[] = {
+	&attr_version.attr,
+	&attr_pmu_model.attr,
+	&attr_counter_width.attr,
+	&attr_task_sessions_count.attr,
+	&attr_sys_sessions_count.attr,
+	&attr_smpl_buffer_mem.attr,
+	&attr_debug.attr,
+	&attr_debug_ovfl.attr,
+	&attr_reset_stats.attr,
+	&attr_expert_mode.attr,
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
+
+int pfm_sysfs_init(void)
+{
+	int i, ret;
+	
+	ret = subsystem_register(&pfm_fmt_subsys);
+	if (ret) {
+		PFM_INFO("cannot register pfm_fmt_subsys: %d", ret);
+		return ret;
+	}
+
+	ret = subsystem_register(&pfm_pmu_subsys);
+	if (ret) {
+		PFM_INFO("cannot register pfm_pmu_subsys: %d", ret);
+		subsystem_unregister(&pfm_fmt_subsys);
+		return ret;
+	}
+
+	ret = subsystem_register(&pfm_stats_subsys);
+	if (ret) {
+		PFM_INFO("cannot register pfm_statssubsys: %d", ret);
+		subsystem_unregister(&pfm_fmt_subsys);
+		subsystem_unregister(&pfm_pmu_subsys);
+		return ret;
+	}
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
+	kobject_add(&pfm_kernel_kobj);
+	kobject_add(&pfm_kernel_fmt_kobj);
+
+	sysfs_create_group(&pfm_kernel_kobj, &pfm_kernel_attr_group);
+
+	for_each_online_cpu(i) {
+		pfm_sysfs_init_percpu(i);
+	}
+
+	pfm_sysfs_init_done = 1;
+
+	pfm_builtin_fmt_sysfs_add();
+
+	if (pfm_pmu_conf)
+		pfm_sysfs_add_pmu(pfm_pmu_conf);
+
+	return 0;
+}
+
+#define PFM_DECL_ATTR(name) \
+static ssize_t name##_show(void *info, char *buf) \
+{ \
+	struct pfm_stats *st = info;\
+	return snprintf(buf, PAGE_SIZE, "%llu\n", \
+			(unsigned long long)st->pfm_##name); \
+} \
+static PFM_RO_ATTR(name)
+
+/*
+ * per-cpu perfmon stats attributes
+ */
+PFM_DECL_ATTR(ovfl_intr_replay_count);
+PFM_DECL_ATTR(ovfl_intr_all_count);
+PFM_DECL_ATTR(ovfl_intr_cycles);
+PFM_DECL_ATTR(fmt_handler_calls);
+PFM_DECL_ATTR(fmt_handler_cycles);
+PFM_DECL_ATTR(set_switch_count);
+PFM_DECL_ATTR(set_switch_cycles);
+PFM_DECL_ATTR(handle_timeout_count);
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
+	&attr_ovfl_intr_cycles.attr,
+	&attr_fmt_handler_calls.attr,
+	&attr_fmt_handler_cycles.attr,
+	&attr_set_switch_count.attr,
+	&attr_set_switch_cycles.attr,
+	&attr_handle_timeout_count.attr,
+	NULL
+};
+
+static struct attribute_group pfm_cpu_attr_group = {
+	.attrs = pfm_cpu_attrs,
+};
+
+static void pfm_sysfs_init_percpu(int i)
+{
+	struct sys_device *cpudev;
+	struct pfm_stats *st;
+
+	cpudev = get_cpu_sysdev(i);
+	if (!cpudev)
+		return;
+
+	st = &per_cpu(pfm_stats, i);
+
+	kobject_init(&st->kobj);
+
+	st->kobj.parent = &cpudev->kobj;
+	kobject_set_name(&st->kobj, "perfmon");
+	kobj_set_kset_s(st, pfm_stats_subsys);
+
+	kobject_add(&st->kobj);
+
+	sysfs_create_group(&st->kobj, &pfm_cpu_attr_group);
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
+
+PFM_RO_ATTR(uuid);
+
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
+
+	return sysfs_create_file(&fmt->kobj, &attr_uuid.attr);
+}
+
+int pfm_sysfs_remove_fmt(struct pfm_smpl_fmt *fmt)
+{
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	sysfs_remove_file(&fmt->kobj, &attr_uuid.attr);
+
+	kobject_del(&fmt->kobj);
+
+	return 0;
+}
+
+/*
+ * because the mappings can vary between one PMU and the other, we cannot really
+ * use an attribute per PMC to describe a mapping. Instead we have a single
+ * mappings attribute per PMU.
+ */
+static ssize_t mappings_show(void *data, char *buf)
+{
+	struct _pfm_pmu_config *pmu = data;
+	size_t s = PAGE_SIZE;
+	u32 n = 0, i;
+
+	for (i = 0; i < PFM_MAX_PMCS;  i++) {
+
+		if ((pmu->pmc_desc[i].type & PFM_REG_I) == 0)
+			continue;
+
+		n = snprintf(buf, s, "PMC%u:0x%llx:0x%llx:%s\n",
+			     i,
+			     (unsigned long long)pfm_pmu_conf->pmc_desc[i].dfl_val,
+			     (unsigned long long)pfm_pmu_conf->pmc_desc[i].rsvd_msk,
+			     pfm_pmu_conf->pmc_desc[i].desc);
+		buf += n;
+		if (n > s)
+			goto skip;
+		s -= n;
+	}
+
+	for (i = 0; i < PFM_MAX_PMDS;  i++) {
+
+		if ((pmu->pmd_desc[i].type & PFM_REG_I) == 0)
+			continue;
+
+		n = snprintf(buf, s, "PMD%u:0x%llx:0x%llx:%s\n",
+			     i,
+			     (unsigned long long)pfm_pmu_conf->pmd_desc[i].dfl_val,
+			     (unsigned long long)pfm_pmu_conf->pmd_desc[i].rsvd_msk,
+			     pfm_pmu_conf->pmd_desc[i].desc);
+		buf += n;
+		if (n > s)
+			break;
+		s -= n;
+	}
+skip:
+	return PAGE_SIZE - s;
+}
+
+PFM_RO_ATTR(mappings);
+
+int pfm_sysfs_add_pmu(struct _pfm_pmu_config *pmu)
+{
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	kobject_init(&pmu->kobj);
+	kobject_set_name(&pmu->kobj, "pmu_desc");
+	kobj_set_kset_s(pmu, pfm_pmu_subsys);
+	pmu->kobj.parent = &pfm_kernel_kobj;
+
+	kobject_add(&pmu->kobj);
+
+	return sysfs_create_file(&pmu->kobj, &attr_mappings.attr);
+}
+
+int pfm_sysfs_remove_pmu(struct _pfm_pmu_config *pmu)
+{
+	if (pfm_sysfs_init_done == 0)
+		return 0;
+
+	sysfs_remove_file(&pmu->kobj, &attr_mappings.attr);
+
+	kobject_del(&pmu->kobj);
+
+	return 0;
+}
