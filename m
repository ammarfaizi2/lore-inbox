Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWFOJPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWFOJPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWFOJPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:15:15 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:6114 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932437AbWFOJPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:15:06 -0400
Date: Thu, 15 Jun 2006 02:07:35 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606150907.k5F97ZDm008144@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/16] 2.6.17-rc6 perfmon2 patch for review: sampling format support
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This files contains the sampling format support.




--- linux-2.6.17-rc6.orig/perfmon/perfmon_fmt.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc6/perfmon/perfmon_fmt.c	2006-06-08 01:49:22.000000000 -0700
@@ -0,0 +1,223 @@
+/*
+ * perfmon_fmt.c: perfmon2 sampling buffer format management
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
+#include <linux/module.h>
+#include <linux/perfmon.h>
+
+static __cacheline_aligned_in_smp DEFINE_SPINLOCK(pfm_smpl_fmt_lock);
+static LIST_HEAD(pfm_smpl_fmt_list);
+static pfm_uuid_t null_uuid;
+
+static inline int pfm_uuid_cmp(pfm_uuid_t a, pfm_uuid_t b)
+{
+	return memcmp(a, b, sizeof(a));
+}
+
+static inline int fmt_is_mod(struct pfm_smpl_fmt *f)
+{
+	return (f->fmt_flags & PFM_FMTFL_IS_BUILTIN) == 0;
+}
+
+
+int pfm_use_smpl_fmt(pfm_uuid_t uuid)
+{
+	return pfm_uuid_cmp(uuid, null_uuid);
+}
+
+static struct pfm_smpl_fmt *__pfm_find_smpl_fmt(pfm_uuid_t uuid)
+{
+	struct pfm_smpl_fmt * entry;
+
+	list_for_each_entry(entry, &pfm_smpl_fmt_list, fmt_list) {
+		if (pfm_uuid_cmp(uuid, entry->fmt_uuid) == 0)
+			return entry;
+	}
+	return NULL;
+}
+
+static struct pfm_smpl_fmt *pfm_find_fmt_name(char *name)
+{
+	struct pfm_smpl_fmt * entry;
+
+	list_for_each_entry(entry, &pfm_smpl_fmt_list, fmt_list) {
+		if (!strcmp(entry->fmt_name, name))
+			return entry;
+	}
+	return NULL;
+}
+/*
+ * find a buffer format based on its uuid
+ */
+struct pfm_smpl_fmt *pfm_smpl_fmt_get(pfm_uuid_t uuid)
+{
+	struct pfm_smpl_fmt * fmt;
+
+	spin_lock(&pfm_smpl_fmt_lock);
+
+	fmt = __pfm_find_smpl_fmt(uuid);
+
+	/*
+	 * increase module refcount
+	 */
+	if (fmt && fmt_is_mod(fmt) && !try_module_get(fmt->owner))
+		fmt = NULL;
+
+	spin_unlock(&pfm_smpl_fmt_lock);
+
+	return fmt;
+}
+
+void pfm_smpl_fmt_put(struct pfm_smpl_fmt *fmt)
+{
+	if (fmt == NULL || fmt_is_mod(fmt) == 0)
+		return;
+	BUG_ON(fmt->owner == NULL);
+
+	spin_lock(&pfm_smpl_fmt_lock);
+	module_put(fmt->owner);
+	spin_unlock(&pfm_smpl_fmt_lock);
+}
+
+int pfm_register_smpl_fmt(struct pfm_smpl_fmt *fmt)
+{
+	int ret = 0;
+
+	/* some sanity checks */
+	if (fmt == NULL) {
+		PFM_INFO("perfmon: NULL format for register");
+		return -EINVAL;
+	}
+
+	if (fmt->fmt_name == NULL) {
+		PFM_INFO("perfmon: format has no name");
+		return -EINVAL;
+	}
+	if (pfm_uuid_cmp(fmt->fmt_uuid, null_uuid) == 0) {
+		PFM_INFO("perfmon: format %s has null uuid", fmt->fmt_name);
+		return -EINVAL;
+	}
+
+	if (fmt->fmt_qdepth > PFM_MAX_MSGS) {
+		PFM_INFO("perfmon: format %s requires %u msg queue depth (max %d)",
+		       fmt->fmt_name,
+		       fmt->fmt_qdepth,
+		       PFM_MAX_MSGS);
+		return -EINVAL;
+	}
+
+	/*
+	 * fmt is missing the initialization of .owner = THIS_MODULE
+	 * this is only valid when format is compiled as a module
+	 */
+	if (fmt->owner == NULL && fmt_is_mod(fmt)) {
+		PFM_INFO("format %s has no module owner", fmt->fmt_name);
+		return -EINVAL;
+	}
+	/*
+	 * we need at least a handler
+	 */
+	if (fmt->fmt_handler == NULL) {
+		PFM_INFO("format %s has no handler", fmt->fmt_name);
+		return -EINVAL;
+	}
+
+	/*
+	 * format argument size cannot be bigger than PAGE_SIZE
+	 */
+	if (fmt->fmt_arg_size > PAGE_SIZE) {
+		PFM_INFO("format %s arguments too big", fmt->fmt_name);
+		return -EINVAL;
+	}
+
+	spin_lock(&pfm_smpl_fmt_lock);
+
+	if (__pfm_find_smpl_fmt(fmt->fmt_uuid)) {
+		PFM_INFO("duplicate sampling format %s", fmt->fmt_name);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * because of sysfs, we cannot have two formats with the same name
+	 */
+	if (pfm_find_fmt_name(fmt->fmt_name)) {
+		PFM_INFO("duplicate sampling format name %s", fmt->fmt_name);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	pfm_sysfs_add_fmt(fmt);
+
+	list_add(&fmt->fmt_list, &pfm_smpl_fmt_list);
+
+	PFM_INFO("added sampling format %s", fmt->fmt_name);
+out:
+	spin_unlock(&pfm_smpl_fmt_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(pfm_register_smpl_fmt);
+
+int pfm_unregister_smpl_fmt(pfm_uuid_t uuid)
+{
+	struct pfm_smpl_fmt *fmt;
+	int ret = 0;
+
+	spin_lock(&pfm_smpl_fmt_lock);
+
+	fmt = __pfm_find_smpl_fmt(uuid);
+	if (!fmt) {
+		PFM_INFO("unregister failed, unknown format");
+		ret = -EINVAL;
+		goto out;
+	}
+	list_del_init(&fmt->fmt_list);
+
+	pfm_sysfs_remove_fmt(fmt);
+
+	PFM_INFO("removed sampling format: %s", fmt->fmt_name);
+
+out:
+	spin_unlock(&pfm_smpl_fmt_lock);
+	return ret;
+
+}
+EXPORT_SYMBOL(pfm_unregister_smpl_fmt);
+
+/*
+ * we defer adding the builtin formats to /sys/kernel/perfmon/formats
+ * until after the pfm sysfs subsystem is initialized. This function
+ * is called from pfm_sysfs_init()
+ */
+void pfm_builtin_fmt_sysfs_add(void)
+{
+	struct pfm_smpl_fmt * entry;
+
+	/*
+	 * locking not needed, kernel not fully booted
+	 * when called
+	 */
+	list_for_each_entry(entry, &pfm_smpl_fmt_list, fmt_list) {
+		pfm_sysfs_add_fmt(entry);
+	}
+}
--- linux-2.6.17-rc6.orig/perfmon/perfmon_dfl_smpl.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17-rc6/perfmon/perfmon_dfl_smpl.c	2006-06-08 01:49:22.000000000 -0700
@@ -0,0 +1,269 @@
+/*
+ * Copyright (c) 1999-2006 Hewlett-Packard Development Company, L.P.
+ *               Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This file implements the new default sampling buffer format
+ * for the Linux/ia64 perfmon2 subsystem.
+ */
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/sysctl.h>
+
+#include <linux/perfmon.h>
+#include <linux/perfmon_dfl_smpl.h>
+
+MODULE_AUTHOR("Stephane Eranian <eranian@hpl.hp.com>");
+MODULE_DESCRIPTION("new perfmon default sampling format");
+MODULE_LICENSE("GPL");
+
+static int pfm_dfl_fmt_validate(u32 ctx_flags, u16 npmds, void *data)
+{
+	struct pfm_dfl_smpl_arg *arg = data;
+	u64 min_buf_size;
+
+	if (data == NULL) {
+		PFM_DBG("no argument passed");
+		return -EINVAL;
+	}
+
+	/*
+	 * sanity check in case size_t is smaller then u64
+	 */
+#if BITS_PER_LONG == 4
+#define MAX_SIZE_T	(1ULL<<(sizeof(size_t)<<3))
+	if (sizeof(size_t) < sizeof(arg->buf_size)) {
+		if (arg->buf_size >= MAX_SIZE_T)
+			return -ETOOBIG;
+	}
+#endif
+	
+	/*
+	 * compute min buf size. npmds is the maximum number
+	 * of implemented PMD registers.
+	 */
+	min_buf_size = sizeof(struct pfm_dfl_smpl_hdr)
+	             + (sizeof(struct pfm_dfl_smpl_entry) + (npmds*sizeof(u64)));
+
+	PFM_DBG("validate ctx_flags=0x%x flags=0x%x npmds=%u "
+		   "min_buf_size=%llu buf_size=%llu\n",
+		   ctx_flags,
+		   arg->buf_flags,
+		   npmds,
+		   (unsigned long long)min_buf_size,
+		   (unsigned long long)arg->buf_size);
+
+	/*
+	 * must hold at least the buffer header + one minimally sized entry
+	 */
+	if (arg->buf_size < min_buf_size)
+		return -EINVAL;
+
+
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_get_size(u32 flags, void *data, size_t *size)
+{
+	struct pfm_dfl_smpl_arg *arg = data;
+
+	/*
+	 * size has been validated in default_validate
+	 * we can never loose bits from buf_size.
+	 */
+	*size = (size_t)arg->buf_size;
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_init(struct pfm_context *ctx, void *buf, u32 ctx_flags,
+			    u16 npmds, void *data)
+{
+	struct pfm_dfl_smpl_hdr *hdr;
+	struct pfm_dfl_smpl_arg *arg = data;
+
+	hdr = buf;
+
+	hdr->hdr_version = PFM_DFL_SMPL_VERSION;
+	hdr->hdr_buf_size = arg->buf_size;
+	hdr->hdr_buf_flags = arg->buf_flags;
+	hdr->hdr_cur_offs = sizeof(*hdr);
+	hdr->hdr_overflows = 0;
+	hdr->hdr_count = 0;
+	hdr->hdr_min_buf_space = sizeof(struct pfm_dfl_smpl_entry) + (npmds*sizeof(u64));
+
+	PFM_DBG("buffer=%p buf_size=%llu hdr_size=%zu hdr_version=%u.%u "
+		  "min_space=%llu npmds=%u",
+		  buf,
+		  (unsigned long long)hdr->hdr_buf_size,
+		  sizeof(*hdr),
+		  PFM_VERSION_MAJOR(hdr->hdr_version),
+		  PFM_VERSION_MINOR(hdr->hdr_version),
+		  (unsigned long long)hdr->hdr_min_buf_space,
+		  npmds);
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_handler(void *buf, struct pfm_ovfl_arg *arg,
+			       unsigned long ip, u64 tstamp, void *data)
+{
+	struct pfm_dfl_smpl_hdr *hdr;
+	struct pfm_dfl_smpl_entry *ent;
+	void *cur, *last;
+	u64 *e;
+	size_t entry_size, min_size;
+	u16 npmds, i;
+	u16 ovfl_pmd;
+
+	hdr = buf;
+	cur = buf+hdr->hdr_cur_offs;
+	last = buf+hdr->hdr_buf_size;
+	ovfl_pmd = arg->ovfl_pmd;
+	min_size = hdr->hdr_min_buf_space;
+
+	/*
+	 * precheck for sanity
+	 */
+	if ((last - cur) < min_size)
+		goto full;
+
+	npmds = arg->num_smpl_pmds;
+
+	ent = (struct pfm_dfl_smpl_entry *)cur;
+
+	entry_size = sizeof(*ent) + (npmds << 3);
+
+	/* position for first pmd */
+	e = (u64 *)(ent+1);
+
+	hdr->hdr_count++;
+
+	PFM_DBG_ovfl("count=%llu cur=%p last=%p free_bytes=%zu ovfl_pmd=%d "
+		       "npmds=%u",
+		       (unsigned long long)hdr->hdr_count,
+		       cur, last,
+		       (last-cur),
+		       ovfl_pmd,
+		       npmds);
+
+	/*
+	 * current = task running at the time of the overflow.
+	 *
+	 * per-task mode:
+	 * 	- this is usually the task being monitored.
+	 * 	  Under certain conditions, it might be a different task
+	 *
+	 * system-wide:
+	 * 	- this is not necessarily the task controlling the session
+	 */
+	ent->pid = current->pid;
+	ent->ovfl_pmd = ovfl_pmd;
+	ent->last_reset_val = arg->pmd_last_reset;
+
+	/*
+	 * where did the fault happen (includes slot number)
+	 */
+	ent->ip = ip;
+
+	ent->tstamp = tstamp;
+	ent->cpu = smp_processor_id();
+	ent->set = arg->active_set;
+	ent->tgid = current->tgid;
+
+	/*
+	 * selectively store PMDs in increasing index number
+	 */
+	if (npmds) {
+		u64 *val = arg->smpl_pmds_values;
+		for(i=0; i < npmds; i++) {
+			*e++ = *val++;
+		}
+	}
+
+	/*
+	 * update position for next entry
+	 */
+	hdr->hdr_cur_offs += entry_size;
+	cur += entry_size;
+
+	/*
+	 * post check to avoid losing the last sample
+	 */
+	if ((last - cur) < min_size)
+		goto full;
+
+	/* reset before returning from interrupt handler */
+	arg->ovfl_ctrl = PFM_OVFL_CTRL_RESET;
+
+	return 0;
+full:
+	PFM_DBG_ovfl("sampling buffer full free=%zu, count=%llu",
+		     last-cur,
+		     (unsigned long long)hdr->hdr_count);
+
+	/*
+	 * increment number of buffer overflows.
+	 * important to detect duplicate set of samples.
+	 */
+	hdr->hdr_overflows++;
+
+	/*
+	 * request notification and masking of monitoring.
+	 * Notification is still subject to the overflowed
+	 * register having the FL_NOTIFY flag set.
+	 */
+	arg->ovfl_ctrl = PFM_OVFL_CTRL_NOTIFY| PFM_OVFL_CTRL_MASK;
+
+	return -ENOBUFS; /* we are full, sorry */
+}
+
+static int pfm_dfl_fmt_restart(int is_active, pfm_flags_t *ovfl_ctrl, void *buf)
+{
+	struct pfm_dfl_smpl_hdr *hdr;
+
+	hdr = buf;
+
+	hdr->hdr_count = 0;
+	hdr->hdr_cur_offs = sizeof(*hdr);
+
+	*ovfl_ctrl = PFM_OVFL_CTRL_RESET;
+
+	return 0;
+}
+
+static int pfm_dfl_fmt_exit(void *buf)
+{
+	return 0;
+}
+
+static struct pfm_smpl_fmt dfl_fmt={
+	.fmt_name = "default",
+	.fmt_uuid = PFM_DFL_SMPL_UUID,
+	.fmt_arg_size = sizeof(struct pfm_dfl_smpl_arg),
+	.fmt_validate = pfm_dfl_fmt_validate,
+	.fmt_getsize = pfm_dfl_fmt_get_size,
+	.fmt_init = pfm_dfl_fmt_init,
+	.fmt_handler = pfm_dfl_fmt_handler,
+	.fmt_restart = pfm_dfl_fmt_restart,
+	.fmt_exit = pfm_dfl_fmt_exit,
+	.fmt_flags = PFM_FMT_BUILTIN_FLAG,
+	.owner = THIS_MODULE
+};
+
+static int pfm_dfl_fmt_init_module(void)
+{
+	return pfm_register_smpl_fmt(&dfl_fmt);
+}
+
+static void pfm_dfl_fmt_cleanup_module(void)
+{
+	pfm_unregister_smpl_fmt(dfl_fmt.fmt_uuid);
+}
+
+module_init(pfm_dfl_fmt_init_module);
+module_exit(pfm_dfl_fmt_cleanup_module);
