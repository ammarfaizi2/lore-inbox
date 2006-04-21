Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWDUQNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWDUQNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 12:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWDUQNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 12:13:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55977 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932397AbWDUQNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 12:13:09 -0400
Subject: [PATCH 12/16] GFS2: Mounting & sysfs interface
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 21 Apr 2006 17:21:44 +0100
Message-Id: <1145636505.3856.116.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 12/16] GFS2: Mounting & sysfs interface

Mount/umount routines and GFS2's sysfs interface.


Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>


 fs/gfs2/mount.c |  215 ++++++++++++++++++++
 fs/gfs2/mount.h |   15 +
 fs/gfs2/sys.c   |  582 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/sys.h   |   24 ++
 4 files changed, 836 insertions(+)

--- /dev/null
+++ b/fs/gfs2/sys.c
@@ -0,0 +1,582 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/module.h>
+#include <linux/kobject.h>
+#include <linux/gfs2_ondisk.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "lm.h"
+#include "sys.h"
+#include "super.h"
+#include "glock.h"
+#include "quota.h"
+#include "util.h"
+
+char *gfs2_sys_margs;
+spinlock_t gfs2_sys_margs_lock;
+
+static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
+{
+	return sprintf(buf, "%s\n", sdp->sd_vfs->s_id);
+}
+
+static ssize_t fsname_show(struct gfs2_sbd *sdp, char *buf)
+{
+	return sprintf(buf, "%s\n", sdp->sd_fsname);
+}
+
+static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
+{
+	unsigned int count;
+
+	mutex_lock(&sdp->sd_freeze_lock);
+	count = sdp->sd_freeze_count;
+	mutex_unlock(&sdp->sd_freeze_lock);
+
+	return sprintf(buf, "%u\n", count);
+}
+
+static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
+{
+	ssize_t ret = len;
+	int error = 0;
+	int n = simple_strtol(buf, NULL, 0);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	switch (n) {
+	case 0:
+		gfs2_unfreeze_fs(sdp);
+		break;
+	case 1:
+		error = gfs2_freeze_fs(sdp);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (error)
+		fs_warn(sdp, "freeze %d error %d", n, error);
+
+	return ret;
+}
+
+static ssize_t withdraw_show(struct gfs2_sbd *sdp, char *buf)
+{
+	unsigned int b = test_bit(SDF_SHUTDOWN, &sdp->sd_flags);
+	return sprintf(buf, "%u\n", b);
+}
+
+static ssize_t withdraw_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (simple_strtol(buf, NULL, 0) != 1)
+		return -EINVAL;
+
+	gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: withdrawing from cluster at user's request\n",
+		sdp->sd_fsname);
+	return len;
+}
+
+static ssize_t statfs_sync_store(struct gfs2_sbd *sdp, const char *buf,
+				 size_t len)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (simple_strtol(buf, NULL, 0) != 1)
+		return -EINVAL;
+
+	gfs2_statfs_sync(sdp);
+	return len;
+}
+
+static ssize_t shrink_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (simple_strtol(buf, NULL, 0) != 1)
+		return -EINVAL;
+
+	gfs2_gl_hash_clear(sdp, NO_WAIT);
+	return len;
+}
+
+static ssize_t quota_sync_store(struct gfs2_sbd *sdp, const char *buf,
+				size_t len)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (simple_strtol(buf, NULL, 0) != 1)
+		return -EINVAL;
+
+	gfs2_quota_sync(sdp);
+	return len;
+}
+
+static ssize_t quota_refresh_user_store(struct gfs2_sbd *sdp, const char *buf,
+					size_t len)
+{
+	uint32_t id;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	id = simple_strtoul(buf, NULL, 0);
+
+	gfs2_quota_refresh(sdp, 1, id);
+	return len;
+}
+
+static ssize_t quota_refresh_group_store(struct gfs2_sbd *sdp, const char *buf,
+					 size_t len)
+{
+	uint32_t id;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	id = simple_strtoul(buf, NULL, 0);
+
+	gfs2_quota_refresh(sdp, 0, id);
+	return len;
+}
+
+struct gfs2_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd *, char *);
+	ssize_t (*store)(struct gfs2_sbd *, const char *, size_t);
+};
+
+#define GFS2_ATTR(name, mode, show, store) \
+static struct gfs2_attr gfs2_attr_##name = __ATTR(name, mode, show, store)
+
+GFS2_ATTR(id,                  0444, id_show,       NULL);
+GFS2_ATTR(fsname,              0444, fsname_show,   NULL);
+GFS2_ATTR(freeze,              0644, freeze_show,   freeze_store);
+GFS2_ATTR(shrink,              0200, NULL,          shrink_store);
+GFS2_ATTR(withdraw,            0644, withdraw_show, withdraw_store);
+GFS2_ATTR(statfs_sync,         0200, NULL,          statfs_sync_store);
+GFS2_ATTR(quota_sync,          0200, NULL,          quota_sync_store);
+GFS2_ATTR(quota_refresh_user,  0200, NULL,          quota_refresh_user_store);
+GFS2_ATTR(quota_refresh_group, 0200, NULL,          quota_refresh_group_store);
+
+static struct attribute *gfs2_attrs[] = {
+	&gfs2_attr_id.attr,
+	&gfs2_attr_fsname.attr,
+	&gfs2_attr_freeze.attr,
+	&gfs2_attr_shrink.attr,
+	&gfs2_attr_withdraw.attr,
+	&gfs2_attr_statfs_sync.attr,
+	&gfs2_attr_quota_sync.attr,
+	&gfs2_attr_quota_refresh_user.attr,
+	&gfs2_attr_quota_refresh_group.attr,
+	NULL,
+};
+
+static ssize_t gfs2_attr_show(struct kobject *kobj, struct attribute *attr,
+			      char *buf)
+{
+	struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
+	struct gfs2_attr *a = container_of(attr, struct gfs2_attr, attr);
+	return a->show ? a->show(sdp, buf) : 0;
+}
+
+static ssize_t gfs2_attr_store(struct kobject *kobj, struct attribute *attr,
+			       const char *buf, size_t len)
+{
+	struct gfs2_sbd *sdp = container_of(kobj, struct gfs2_sbd, sd_kobj);
+	struct gfs2_attr *a = container_of(attr, struct gfs2_attr, attr);
+	return a->store ? a->store(sdp, buf, len) : len;
+}
+
+static struct sysfs_ops gfs2_attr_ops = {
+	.show  = gfs2_attr_show,
+	.store = gfs2_attr_store,
+};
+
+static struct kobj_type gfs2_ktype = {
+	.default_attrs = gfs2_attrs,
+	.sysfs_ops     = &gfs2_attr_ops,
+};
+
+static struct kset gfs2_kset = {
+	.subsys = &fs_subsys,
+	.kobj   = {.name = "gfs2",},
+	.ktype  = &gfs2_ktype,
+};
+
+/*
+ * display struct lm_lockstruct fields
+ */
+
+struct lockstruct_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd *, char *);
+};
+
+#define LOCKSTRUCT_ATTR(name, fmt)                                          \
+static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                 \
+{                                                                           \
+	return sprintf(buf, fmt, sdp->sd_lockstruct.ls_##name);             \
+}                                                                           \
+static struct lockstruct_attr lockstruct_attr_##name = __ATTR_RO(name)
+
+LOCKSTRUCT_ATTR(jid,      "%u\n");
+LOCKSTRUCT_ATTR(first,    "%u\n");
+LOCKSTRUCT_ATTR(lvb_size, "%u\n");
+LOCKSTRUCT_ATTR(flags,    "%d\n");
+
+static struct attribute *lockstruct_attrs[] = {
+	&lockstruct_attr_jid.attr,
+	&lockstruct_attr_first.attr,
+	&lockstruct_attr_lvb_size.attr,
+	&lockstruct_attr_flags.attr,
+	NULL
+};
+
+/*
+ * display struct gfs2_args fields
+ */
+
+struct args_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd *, char *);
+};
+
+#define ARGS_ATTR(name, fmt)                                                \
+static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                 \
+{                                                                           \
+	return sprintf(buf, fmt, sdp->sd_args.ar_##name);                   \
+}                                                                           \
+static struct args_attr args_attr_##name = __ATTR_RO(name)
+
+ARGS_ATTR(lockproto,       "%s\n");
+ARGS_ATTR(locktable,       "%s\n");
+ARGS_ATTR(hostdata,        "%s\n");
+ARGS_ATTR(spectator,       "%d\n");
+ARGS_ATTR(ignore_local_fs, "%d\n");
+ARGS_ATTR(localcaching,    "%d\n");
+ARGS_ATTR(localflocks,     "%d\n");
+ARGS_ATTR(debug,           "%d\n");
+ARGS_ATTR(upgrade,         "%d\n");
+ARGS_ATTR(num_glockd,      "%u\n");
+ARGS_ATTR(posix_acl,       "%d\n");
+ARGS_ATTR(quota,           "%u\n");
+ARGS_ATTR(suiddir,         "%d\n");
+ARGS_ATTR(data,            "%d\n");
+
+/* one oddball doesn't fit the macro mold */
+static ssize_t noatime_show(struct gfs2_sbd *sdp, char *buf)
+{
+	return sprintf(buf, "%d\n", !!test_bit(SDF_NOATIME, &sdp->sd_flags));
+}
+static struct args_attr args_attr_noatime = __ATTR_RO(noatime);
+
+static struct attribute *args_attrs[] = {
+	&args_attr_lockproto.attr,
+	&args_attr_locktable.attr,
+	&args_attr_hostdata.attr,
+	&args_attr_spectator.attr,
+	&args_attr_ignore_local_fs.attr,
+	&args_attr_localcaching.attr,
+	&args_attr_localflocks.attr,
+	&args_attr_debug.attr,
+	&args_attr_upgrade.attr,
+	&args_attr_num_glockd.attr,
+	&args_attr_posix_acl.attr,
+	&args_attr_quota.attr,
+	&args_attr_suiddir.attr,
+	&args_attr_data.attr,
+	&args_attr_noatime.attr,
+	NULL
+};
+
+/*
+ * display counters from superblock
+ */
+
+struct counters_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd *, char *);
+};
+
+#define COUNTERS_ATTR(name, fmt)                                            \
+static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                 \
+{                                                                           \
+	return sprintf(buf, fmt, (unsigned int)atomic_read(&sdp->sd_##name)); \
+}                                                                           \
+static struct counters_attr counters_attr_##name = __ATTR_RO(name)
+
+COUNTERS_ATTR(glock_count,      "%u\n");
+COUNTERS_ATTR(glock_held_count, "%u\n");
+COUNTERS_ATTR(inode_count,      "%u\n");
+COUNTERS_ATTR(reclaimed,        "%u\n");
+
+static struct attribute *counters_attrs[] = {
+	&counters_attr_glock_count.attr,
+	&counters_attr_glock_held_count.attr,
+	&counters_attr_inode_count.attr,
+	&counters_attr_reclaimed.attr,
+	NULL
+};
+
+/*
+ * get and set struct gfs2_tune fields
+ */
+
+static ssize_t quota_scale_show(struct gfs2_sbd *sdp, char *buf)
+{
+	return sprintf(buf, "%u %u\n", sdp->sd_tune.gt_quota_scale_num,
+				       sdp->sd_tune.gt_quota_scale_den);
+}
+
+static ssize_t quota_scale_store(struct gfs2_sbd *sdp, const char *buf,
+				 size_t len)
+{
+	struct gfs2_tune *gt = &sdp->sd_tune;
+	unsigned int x, y;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (sscanf(buf, "%u %u", &x, &y) != 2 || !y)
+		return -EINVAL;
+
+	spin_lock(&gt->gt_spin);
+	gt->gt_quota_scale_num = x;
+	gt->gt_quota_scale_den = y;
+	spin_unlock(&gt->gt_spin);
+	return len;
+}
+
+static ssize_t tune_set(struct gfs2_sbd *sdp, unsigned int *field,
+			int check_zero, const char *buf, size_t len)
+{
+	struct gfs2_tune *gt = &sdp->sd_tune;
+	unsigned int x;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	x = simple_strtoul(buf, NULL, 0);
+
+	if (check_zero && !x)
+		return -EINVAL;
+
+	spin_lock(&gt->gt_spin);
+	*field = x;
+	spin_unlock(&gt->gt_spin);
+	return len;
+}
+
+struct tune_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct gfs2_sbd *, char *);
+	ssize_t (*store)(struct gfs2_sbd *, const char *, size_t);
+};
+
+#define TUNE_ATTR_3(name, show, store)                                        \
+static struct tune_attr tune_attr_##name = __ATTR(name, 0644, show, store)
+
+#define TUNE_ATTR_2(name, store)                                              \
+static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                   \
+{                                                                             \
+	return sprintf(buf, "%u\n", sdp->sd_tune.gt_##name);                  \
+}                                                                             \
+TUNE_ATTR_3(name, name##_show, store)
+
+#define TUNE_ATTR(name, check_zero)                                           \
+static ssize_t name##_store(struct gfs2_sbd *sdp, const char *buf, size_t len)\
+{                                                                             \
+	return tune_set(sdp, &sdp->sd_tune.gt_##name, check_zero, buf, len);  \
+}                                                                             \
+TUNE_ATTR_2(name, name##_store)
+
+#define TUNE_ATTR_DAEMON(name, process)                                       \
+static ssize_t name##_store(struct gfs2_sbd *sdp, const char *buf, size_t len)\
+{                                                                             \
+	ssize_t r = tune_set(sdp, &sdp->sd_tune.gt_##name, 1, buf, len);      \
+	wake_up_process(sdp->sd_##process);                                   \
+	return r;                                                             \
+}                                                                             \
+TUNE_ATTR_2(name, name##_store)
+
+TUNE_ATTR(ilimit, 0);
+TUNE_ATTR(ilimit_tries, 0);
+TUNE_ATTR(ilimit_min, 0);
+TUNE_ATTR(demote_secs, 0);
+TUNE_ATTR(incore_log_blocks, 0);
+TUNE_ATTR(log_flush_secs, 0);
+TUNE_ATTR(jindex_refresh_secs, 0);
+TUNE_ATTR(quota_warn_period, 0);
+TUNE_ATTR(quota_quantum, 0);
+TUNE_ATTR(atime_quantum, 0);
+TUNE_ATTR(max_readahead, 0);
+TUNE_ATTR(complain_secs, 0);
+TUNE_ATTR(reclaim_limit, 0);
+TUNE_ATTR(prefetch_secs, 0);
+TUNE_ATTR(statfs_slow, 0);
+TUNE_ATTR(new_files_jdata, 0);
+TUNE_ATTR(new_files_directio, 0);
+TUNE_ATTR(quota_simul_sync, 1);
+TUNE_ATTR(quota_cache_secs, 1);
+TUNE_ATTR(max_atomic_write, 1);
+TUNE_ATTR(stall_secs, 1);
+TUNE_ATTR(entries_per_readdir, 1);
+TUNE_ATTR(greedy_default, 1);
+TUNE_ATTR(greedy_quantum, 1);
+TUNE_ATTR(greedy_max, 1);
+TUNE_ATTR(statfs_quantum, 1);
+TUNE_ATTR_DAEMON(scand_secs, scand_process);
+TUNE_ATTR_DAEMON(recoverd_secs, recoverd_process);
+TUNE_ATTR_DAEMON(logd_secs, logd_process);
+TUNE_ATTR_DAEMON(quotad_secs, quotad_process);
+TUNE_ATTR_DAEMON(inoded_secs, inoded_process);
+TUNE_ATTR_3(quota_scale, quota_scale_show, quota_scale_store);
+
+static struct attribute *tune_attrs[] = {
+	&tune_attr_ilimit.attr,
+	&tune_attr_ilimit_tries.attr,
+	&tune_attr_ilimit_min.attr,
+	&tune_attr_demote_secs.attr,
+	&tune_attr_incore_log_blocks.attr,
+	&tune_attr_log_flush_secs.attr,
+	&tune_attr_jindex_refresh_secs.attr,
+	&tune_attr_quota_warn_period.attr,
+	&tune_attr_quota_quantum.attr,
+	&tune_attr_atime_quantum.attr,
+	&tune_attr_max_readahead.attr,
+	&tune_attr_complain_secs.attr,
+	&tune_attr_reclaim_limit.attr,
+	&tune_attr_prefetch_secs.attr,
+	&tune_attr_statfs_slow.attr,
+	&tune_attr_quota_simul_sync.attr,
+	&tune_attr_quota_cache_secs.attr,
+	&tune_attr_max_atomic_write.attr,
+	&tune_attr_stall_secs.attr,
+	&tune_attr_entries_per_readdir.attr,
+	&tune_attr_greedy_default.attr,
+	&tune_attr_greedy_quantum.attr,
+	&tune_attr_greedy_max.attr,
+	&tune_attr_statfs_quantum.attr,
+	&tune_attr_scand_secs.attr,
+	&tune_attr_recoverd_secs.attr,
+	&tune_attr_logd_secs.attr,
+	&tune_attr_quotad_secs.attr,
+	&tune_attr_inoded_secs.attr,
+	&tune_attr_quota_scale.attr,
+	&tune_attr_new_files_jdata.attr,
+	&tune_attr_new_files_directio.attr,
+	NULL
+};
+
+static struct attribute_group lockstruct_group = {
+	.name = "lockstruct",
+	.attrs = lockstruct_attrs
+};
+
+static struct attribute_group counters_group = {
+	.name = "counters",
+	.attrs = counters_attrs
+};
+
+static struct attribute_group args_group = {
+	.name = "args",
+	.attrs = args_attrs
+};
+
+static struct attribute_group tune_group = {
+	.name = "tune",
+	.attrs = tune_attrs
+};
+
+int gfs2_sys_fs_add(struct gfs2_sbd *sdp)
+{
+	int error;
+
+	sdp->sd_kobj.kset = &gfs2_kset;
+	sdp->sd_kobj.ktype = &gfs2_ktype;
+
+	error = kobject_set_name(&sdp->sd_kobj, "%s", sdp->sd_table_name);
+	if (error)
+		goto fail;
+
+	error = kobject_register(&sdp->sd_kobj);
+	if (error)
+		goto fail;
+
+	error = sysfs_create_group(&sdp->sd_kobj, &lockstruct_group);
+	if (error)
+		goto fail_reg;
+
+	error = sysfs_create_group(&sdp->sd_kobj, &counters_group);
+	if (error)
+		goto fail_lockstruct;
+
+	error = sysfs_create_group(&sdp->sd_kobj, &args_group);
+	if (error)
+		goto fail_counters;
+
+	error = sysfs_create_group(&sdp->sd_kobj, &tune_group);
+	if (error)
+		goto fail_args;
+
+	return 0;
+
+ fail_args:
+	sysfs_remove_group(&sdp->sd_kobj, &args_group);
+ fail_counters:
+	sysfs_remove_group(&sdp->sd_kobj, &counters_group);
+ fail_lockstruct:
+	sysfs_remove_group(&sdp->sd_kobj, &lockstruct_group);
+ fail_reg:
+	kobject_unregister(&sdp->sd_kobj);
+ fail:
+	return error;
+}
+
+void gfs2_sys_fs_del(struct gfs2_sbd *sdp)
+{
+	sysfs_remove_group(&sdp->sd_kobj, &tune_group);
+	sysfs_remove_group(&sdp->sd_kobj, &args_group);
+	sysfs_remove_group(&sdp->sd_kobj, &counters_group);
+	sysfs_remove_group(&sdp->sd_kobj, &lockstruct_group);
+	kobject_unregister(&sdp->sd_kobj);
+}
+
+int gfs2_sys_init(void)
+{
+	gfs2_sys_margs = NULL;
+	spin_lock_init(&gfs2_sys_margs_lock);
+	return kset_register(&gfs2_kset);
+}
+
+void gfs2_sys_uninit(void)
+{
+	kfree(gfs2_sys_margs);
+	kset_unregister(&gfs2_kset);
+}
+
--- /dev/null
+++ b/fs/gfs2/sys.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __SYS_DOT_H__
+#define __SYS_DOT_H__
+
+/* Allow args to be passed to GFS2 when using an initial ram disk */
+extern char *gfs2_sys_margs;
+extern spinlock_t gfs2_sys_margs_lock;
+
+int gfs2_sys_fs_add(struct gfs2_sbd *sdp);
+void gfs2_sys_fs_del(struct gfs2_sbd *sdp);
+
+int gfs2_sys_init(void);
+void gfs2_sys_uninit(void);
+
+#endif /* __SYS_DOT_H__ */
+
--- /dev/null
+++ b/fs/gfs2/mount.c
@@ -0,0 +1,215 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/gfs2_ondisk.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "mount.h"
+#include "sys.h"
+#include "util.h"
+
+/**
+ * gfs2_mount_args - Parse mount options
+ * @sdp:
+ * @data:
+ *
+ * Return: errno
+ */
+
+int gfs2_mount_args(struct gfs2_sbd *sdp, char *data_arg, int remount)
+{
+	struct gfs2_args *args = &sdp->sd_args;
+	char *data = data_arg;
+	char *options, *o, *v;
+	int error = 0;
+
+	if (!remount) {
+		/*  If someone preloaded options, use those instead  */
+		spin_lock(&gfs2_sys_margs_lock);
+		if (gfs2_sys_margs) {
+			data = gfs2_sys_margs;
+			gfs2_sys_margs = NULL;
+		}
+		spin_unlock(&gfs2_sys_margs_lock);
+
+		/*  Set some defaults  */
+		args->ar_num_glockd = GFS2_GLOCKD_DEFAULT;
+		args->ar_quota = GFS2_QUOTA_DEFAULT;
+		args->ar_data = GFS2_DATA_DEFAULT;
+	}
+
+	/* Split the options into tokens with the "," character and
+	   process them */
+
+	for (options = data; (o = strsep(&options, ",")); ) {
+		if (!*o)
+			continue;
+
+		v = strchr(o, '=');
+		if (v)
+			*v++ = 0;
+
+		if (!strcmp(o, "lockproto")) {
+			if (!v)
+				goto need_value;
+			if (remount && strcmp(v, args->ar_lockproto))
+				goto cant_remount;
+			strncpy(args->ar_lockproto, v, GFS2_LOCKNAME_LEN);
+			args->ar_lockproto[GFS2_LOCKNAME_LEN - 1] = 0;
+		}
+
+		else if (!strcmp(o, "locktable")) {
+			if (!v)
+				goto need_value;
+			if (remount && strcmp(v, args->ar_locktable))
+				goto cant_remount;
+			strncpy(args->ar_locktable, v, GFS2_LOCKNAME_LEN);
+			args->ar_locktable[GFS2_LOCKNAME_LEN - 1] = 0;
+		}
+
+		else if (!strcmp(o, "hostdata")) {
+			if (!v)
+				goto need_value;
+			if (remount && strcmp(v, args->ar_hostdata))
+				goto cant_remount;
+			strncpy(args->ar_hostdata, v, GFS2_LOCKNAME_LEN);
+			args->ar_hostdata[GFS2_LOCKNAME_LEN - 1] = 0;
+		}
+
+		else if (!strcmp(o, "spectator")) {
+			if (remount && !args->ar_spectator)
+				goto cant_remount;
+			args->ar_spectator = 1;
+			sdp->sd_vfs->s_flags |= MS_RDONLY;
+		}
+
+		else if (!strcmp(o, "ignore_local_fs")) {
+			if (remount && !args->ar_ignore_local_fs)
+				goto cant_remount;
+			args->ar_ignore_local_fs = 1;
+		}
+
+		else if (!strcmp(o, "localflocks")) {
+			if (remount && !args->ar_localflocks)
+				goto cant_remount;
+			args->ar_localflocks = 1;
+		}
+
+		else if (!strcmp(o, "localcaching")) {
+			if (remount && !args->ar_localcaching)
+				goto cant_remount;
+			args->ar_localcaching = 1;
+		}
+
+		else if (!strcmp(o, "debug"))
+			args->ar_debug = 1;
+
+		else if (!strcmp(o, "nodebug"))
+			args->ar_debug = 0;
+
+		else if (!strcmp(o, "upgrade")) {
+			if (remount && !args->ar_upgrade)
+				goto cant_remount;
+			args->ar_upgrade = 1;
+		}
+
+		else if (!strcmp(o, "num_glockd")) {
+			unsigned int x;
+			if (!v)
+				goto need_value;
+			sscanf(v, "%u", &x);
+			if (remount && x != args->ar_num_glockd)
+				goto cant_remount;
+			if (!x || x > GFS2_GLOCKD_MAX) {
+				fs_info(sdp, "0 < num_glockd <= %u  (not %u)\n",
+				        GFS2_GLOCKD_MAX, x);
+				error = -EINVAL;
+				break;
+			}
+			args->ar_num_glockd = x;
+		}
+
+		else if (!strcmp(o, "acl")) {
+			args->ar_posix_acl = 1;
+			sdp->sd_vfs->s_flags |= MS_POSIXACL;
+		}
+
+		else if (!strcmp(o, "noacl")) {
+			args->ar_posix_acl = 0;
+			sdp->sd_vfs->s_flags &= ~MS_POSIXACL;
+		}
+
+		else if (!strcmp(o, "quota")) {
+			if (!v)
+				goto need_value;
+			if (!strcmp(v, "off"))
+				args->ar_quota = GFS2_QUOTA_OFF;
+			else if (!strcmp(v, "account"))
+				args->ar_quota = GFS2_QUOTA_ACCOUNT;
+			else if (!strcmp(v, "on"))
+				args->ar_quota = GFS2_QUOTA_ON;
+			else {
+				fs_info(sdp, "invalid value for quota\n");
+				error = -EINVAL;
+				break;
+			}
+		}
+
+		else if (!strcmp(o, "suiddir"))
+			args->ar_suiddir = 1;
+
+		else if (!strcmp(o, "nosuiddir"))
+			args->ar_suiddir = 0;
+
+		else if (!strcmp(o, "data")) {
+			if (!v)
+				goto need_value;
+			if (!strcmp(v, "writeback"))
+				args->ar_data = GFS2_DATA_WRITEBACK;
+			else if (!strcmp(v, "ordered"))
+				args->ar_data = GFS2_DATA_ORDERED;
+			else {
+				fs_info(sdp, "invalid value for data\n");
+				error = -EINVAL;
+				break;
+			}
+		}
+
+		else {
+			fs_info(sdp, "unknown option: %s\n", o);
+			error = -EINVAL;
+			break;
+		}
+	}
+
+	if (error)
+		fs_info(sdp, "invalid mount option(s)\n");
+
+	if (data != data_arg)
+		kfree(data);
+
+	return error;
+
+ need_value:
+	fs_info(sdp, "need value for option %s\n", o);
+	return -EINVAL;
+
+ cant_remount:
+	fs_info(sdp, "can't remount with option %s\n", o);
+	return -EINVAL;
+}
+
--- /dev/null
+++ b/fs/gfs2/mount.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __MOUNT_DOT_H__
+#define __MOUNT_DOT_H__
+
+int gfs2_mount_args(struct gfs2_sbd *sdp, char *data_arg, int remount);
+
+#endif /* __MOUNT_DOT_H__ */


