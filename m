Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWHWIQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWHWIQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbWHWIQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:16:25 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:52185 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932384AbWHWIQF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:16:05 -0400
Date: Wed, 23 Aug 2006 01:05:57 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200608230805.k7N85v1s000408@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 6/18] 2.6.17.9 perfmon2 patch for review: sampling format support
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This files contains the sampling format support.

Perfmon2 supports an in-kernel sampling buffer for performance
reasons. Yet to ensure maximum flexibility to applications,
the formats is which infmration is recorded into the kernel
buffer is not specified by the interface. Instead it is
delegated to a kernel plug-in modules called sampling formats.

Each formats controls:
	- what is recorded in the the sampling buffer
	- how the information is recorded
	- when to notify the application to extract the information
	- how the buffer is exported to user level
	- hoe the buffer is allocated

Each format is identified via a 128-bit UUID which can be requested
when the context is created with pfm_create_context().

The interface comes with a simple default sampling format. It records
information sequentially in the buffer. Each entry, called sample,
is composed of a fixed size header and a variable size body where
the values of PMDS can be recorded based upon the user's request.

Sampling formats can be dynamically registered with perfmon. The management
of sampling formats is implemented in perfmon_fmt.c:

pfm_register_smpl_fmt(struct pfm_smpl_fmt *fmt):
	- register a new sampling format
		
pfm_unregister_smpl_fmt(pfm_uuid_t uuid):
	- unregister a sampling format

It is possible to list the available formats by looking at /sys/kernel/perfmon/formats.





--- linux-2.6.17.9.base/perfmon/perfmon_fmt.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/perfmon/perfmon_fmt.c	2006-08-21 03:37:46.000000000 -0700
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
+	return !(f->fmt_flags & PFM_FMTFL_IS_BUILTIN);
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
+		if (!pfm_uuid_cmp(uuid, entry->fmt_uuid))
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
+	if (fmt == NULL || !fmt_is_mod(fmt))
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
+	if (!pfm_uuid_cmp(fmt->fmt_uuid, null_uuid)) {
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
--- linux-2.6.17.9.base/include/linux/perfmon_fmt.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.17.9/include/linux/perfmon_fmt.h	2006-08-21 03:37:46.000000000 -0700
@@ -0,0 +1,74 @@
+/*
+ * Copyright (c) 2001-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * Interface for custom sampling buffer format modules
+ */
+#ifndef __PERFMON_FMT_H__
+#define __PERFMON_FMT_H__ 1
+
+#include <linux/kobject.h>
+
+struct pfm_ovfl_arg {
+	u16 ovfl_pmd;	/* index of overflowed PMD  */
+	u16 active_set;	/* set active at the time of the overflow */
+	pfm_flags_t ovfl_ctrl;	/* control flags */
+	u64 pmd_last_reset;	/* last reset value of overflowed PMD */
+	u64 smpl_pmds_values[PFM_MAX_PMDS]; 	/* values of other PMDs */
+	u64 pmd_eventid;	/* eventid associated with PMD */
+	u16 num_smpl_pmds;	/* number of PMDS in smpl_pmd_values */
+};
+
+/*
+ * ovfl_ctrl bitmask of flags
+ */
+#define PFM_OVFL_CTRL_NOTIFY	0x1	/* notify user */
+#define PFM_OVFL_CTRL_RESET	0x2	/* reset overflowed pmds */
+#define PFM_OVFL_CTRL_MASK	0x4	/* mask monitoring */
+
+
+typedef int (*fmt_validate_t )(u32 flags, u16 npmds, void *arg);
+typedef	int (*fmt_getsize_t)(u32 flags, void *arg, size_t *size);
+typedef int (*fmt_init_t)(struct pfm_context *ctx, void *buf, u32 flags, u16 nmpds, void *arg);
+typedef int (*fmt_restart_t)(int is_active, pfm_flags_t *ovfl_ctrl, void *buf);
+typedef int (*fmt_exit_t)(void *buf);
+typedef int (*fmt_handler_t)(void *buf, struct pfm_ovfl_arg *arg,
+			     unsigned long ip, u64 stamp, void *data);
+
+struct pfm_smpl_fmt {
+	char		*fmt_name;	/* name of the format (required) */
+	pfm_uuid_t	fmt_uuid;	/* 128-bit unique id (required) */
+	size_t		fmt_arg_size;	/* size of fmt args for ctx create */
+	pfm_flags_t	fmt_flags;	/* format specific flags */
+
+	fmt_validate_t	fmt_validate;	/* validate context flags */
+	fmt_getsize_t	fmt_getsize;	/* get size for sampling buffer */
+	fmt_init_t	fmt_init;	/* initialize buffer area */
+	fmt_handler_t	fmt_handler;	/* overflow handler (required) */
+	fmt_restart_t	fmt_restart;	/* restart after notification  */
+	fmt_exit_t	fmt_exit;	/* context termination */
+
+	struct list_head fmt_list;	/* internal use only */
+
+	struct kobject	kobj;		/* sysfs internal use only */
+	struct module	*owner;		/* pointer to module owner */
+	u32		fmt_qdepth;	/* Max notify queue depth (required) */
+};
+#define to_smpl_fmt(n) container_of(n, struct pfm_smpl_fmt, kobj)
+
+#define PFM_FMTFL_IS_BUILTIN	0x1	/* fmt is compiled in */
+/*
+ * we need to know whether the format is builtin or compiled
+ * as a module
+ */
+#ifdef MODULE
+#define PFM_FMT_BUILTIN_FLAG	0	/* not built as a module */
+#else
+#define PFM_FMT_BUILTIN_FLAG	PFM_PMUFL_IS_BUILTIN /* built as a module */
+#endif
+
+int pfm_register_smpl_fmt(struct pfm_smpl_fmt *fmt);
+int pfm_unregister_smpl_fmt(pfm_uuid_t uuid);
+void pfm_builtin_fmt_sysfs_add(void);
+
+#endif /* __PERFMON_FMT_H__ */
