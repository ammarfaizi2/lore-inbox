Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVHRGEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVHRGEg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 02:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVHRGEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 02:04:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14484 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750791AbVHRGEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 02:04:35 -0400
Date: Thu, 18 Aug 2005 14:10:14 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-cluster@redhat.com
Subject: [PATCH 2/3] dlm: remove file
Message-ID: <20050818061014.GB10133@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The reduced member_sysfs.c is no longer related to lockspace members.
Move what's left into lockspace.c which is the only file that uses the
remaining functions.

Signed-off-by: David Teigland <teigland@redhat.com>

---

 Makefile       |    1 
 lockspace.c    |  155 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 lockspace.h    |    1 
 main.c         |   14 +---
 member.c       |    2 
 member_sysfs.c |  165 ---------------------------------------------------------
 member_sysfs.h |   22 -------
 7 files changed, 156 insertions(+), 204 deletions(-)

diff -urpN a/drivers/dlm/Makefile b/drivers/dlm/Makefile
--- a/drivers/dlm/Makefile	2005-08-18 13:26:02.648375344 +0800
+++ b/drivers/dlm/Makefile	2005-08-18 13:26:25.736865360 +0800
@@ -9,7 +9,6 @@ dlm-y :=			ast.o \
 				lowcomms.o \
 				main.o \
 				member.o \
-				member_sysfs.o \
 				memory.o \
 				midcomms.o \
 				rcom.o \
diff -urpN a/drivers/dlm/lockspace.c b/drivers/dlm/lockspace.c
--- a/drivers/dlm/lockspace.c	2005-08-18 13:26:02.651374888 +0800
+++ b/drivers/dlm/lockspace.c	2005-08-18 13:26:25.737865208 +0800
@@ -14,7 +14,6 @@
 #include "dlm_internal.h"
 #include "lockspace.h"
 #include "member.h"
-#include "member_sysfs.h"
 #include "recoverd.h"
 #include "ast.h"
 #include "dir.h"
@@ -38,13 +37,159 @@ static spinlock_t		lslist_lock;
 static struct task_struct *	scand_task;
 
 
+static ssize_t dlm_control_store(struct dlm_ls *ls, const char *buf, size_t len)
+{
+	ssize_t ret = len;
+	int n = simple_strtol(buf, NULL, 0);
+
+	switch (n) {
+	case 0:
+		dlm_ls_stop(ls);
+		break;
+	case 1:
+		dlm_ls_start(ls);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static ssize_t dlm_event_store(struct dlm_ls *ls, const char *buf, size_t len)
+{
+	ls->ls_uevent_result = simple_strtol(buf, NULL, 0);
+	set_bit(LSFL_UEVENT_WAIT, &ls->ls_flags);
+	wake_up(&ls->ls_uevent_wait);
+	return len;
+}
+
+static ssize_t dlm_id_show(struct dlm_ls *ls, char *buf)
+{
+	return sprintf(buf, "%u\n", ls->ls_global_id);
+}
+
+static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
+{
+	ls->ls_global_id = simple_strtoul(buf, NULL, 0);
+	return len;
+}
+
+struct dlm_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct dlm_ls *, char *);
+	ssize_t (*store)(struct dlm_ls *, const char *, size_t);
+};
+
+static struct dlm_attr dlm_attr_control = {
+	.attr  = {.name = "control", .mode = S_IWUSR},
+	.store = dlm_control_store
+};
+
+static struct dlm_attr dlm_attr_event = {
+	.attr  = {.name = "event_done", .mode = S_IWUSR},
+	.store = dlm_event_store
+};
+
+static struct dlm_attr dlm_attr_id = {
+	.attr  = {.name = "id", .mode = S_IRUGO | S_IWUSR},
+	.show  = dlm_id_show,
+	.store = dlm_id_store
+};
+
+static struct attribute *dlm_attrs[] = {
+	&dlm_attr_control.attr,
+	&dlm_attr_event.attr,
+	&dlm_attr_id.attr,
+	NULL,
+};
+
+static ssize_t dlm_attr_show(struct kobject *kobj, struct attribute *attr,
+			     char *buf)
+{
+	struct dlm_ls *ls  = container_of(kobj, struct dlm_ls, ls_kobj);
+	struct dlm_attr *a = container_of(attr, struct dlm_attr, attr);
+	return a->show ? a->show(ls, buf) : 0;
+}
+
+static ssize_t dlm_attr_store(struct kobject *kobj, struct attribute *attr,
+			      const char *buf, size_t len)
+{
+	struct dlm_ls *ls  = container_of(kobj, struct dlm_ls, ls_kobj);
+	struct dlm_attr *a = container_of(attr, struct dlm_attr, attr);
+	return a->store ? a->store(ls, buf, len) : len;
+}
+
+static struct sysfs_ops dlm_attr_ops = {
+	.show  = dlm_attr_show,
+	.store = dlm_attr_store,
+};
+
+static struct kobj_type dlm_ktype = {
+	.default_attrs = dlm_attrs,
+	.sysfs_ops     = &dlm_attr_ops,
+};
+
+static struct kset dlm_kset = {
+	.subsys = &kernel_subsys,
+	.kobj   = {.name = "dlm",},
+	.ktype  = &dlm_ktype,
+};
+
+static int kobject_setup(struct dlm_ls *ls)
+{
+	char lsname[DLM_LOCKSPACE_LEN];
+	int error;
+
+	memset(lsname, 0, DLM_LOCKSPACE_LEN);
+	snprintf(lsname, DLM_LOCKSPACE_LEN, "%s", ls->ls_name);
+
+	error = kobject_set_name(&ls->ls_kobj, "%s", lsname);
+	if (error)
+		return error;
+
+	ls->ls_kobj.kset = &dlm_kset;
+	ls->ls_kobj.ktype = &dlm_ktype;
+	return 0;
+}
+
+static int do_uevent(struct dlm_ls *ls, int in)
+{
+	int error;
+
+	if (in)
+		kobject_uevent(&ls->ls_kobj, KOBJ_ONLINE, NULL);
+	else
+		kobject_uevent(&ls->ls_kobj, KOBJ_OFFLINE, NULL);
+
+	error = wait_event_interruptible(ls->ls_uevent_wait,
+			test_and_clear_bit(LSFL_UEVENT_WAIT, &ls->ls_flags));
+	if (error)
+		goto out;
+
+	error = ls->ls_uevent_result;
+ out:
+	return error;
+}
+
+
 int dlm_lockspace_init(void)
 {
+	int error;
+
 	ls_count = 0;
 	init_MUTEX(&ls_lock);
 	INIT_LIST_HEAD(&lslist);
 	spin_lock_init(&lslist_lock);
-	return 0;
+
+	error = kset_register(&dlm_kset);
+	if (error)
+		printk("dlm_lockspace_init: cannot register kset %d\n", error);
+	return error;
+}
+
+void dlm_lockspace_exit(void)
+{
+	kset_unregister(&dlm_kset);
 }
 
 static int dlm_scand(void *data)
@@ -310,7 +455,7 @@ static int new_lockspace(char *name, int
 
 	dlm_create_debug_file(ls);
 
-	error = dlm_kobject_setup(ls);
+	error = kobject_setup(ls);
 	if (error)
 		goto out_del;
 
@@ -318,7 +463,7 @@ static int new_lockspace(char *name, int
 	if (error)
 		goto out_del;
 
-	error = dlm_uevent(ls, 1);
+	error = do_uevent(ls, 1);
 	if (error)
 		goto out_unreg;
 
@@ -409,7 +554,7 @@ static int release_lockspace(struct dlm_
 		return -EBUSY;
 
 	if (force < 3)
-		dlm_uevent(ls, 0);
+		do_uevent(ls, 0);
 
 	dlm_recoverd_stop(ls);
 
diff -urpN a/drivers/dlm/lockspace.h b/drivers/dlm/lockspace.h
--- a/drivers/dlm/lockspace.h	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/lockspace.h	2005-08-18 13:26:25.737865208 +0800
@@ -15,6 +15,7 @@
 #define __LOCKSPACE_DOT_H__
 
 int dlm_lockspace_init(void);
+void dlm_lockspace_exit(void);
 struct dlm_ls *dlm_find_lockspace_global(uint32_t id);
 struct dlm_ls *dlm_find_lockspace_local(void *id);
 struct dlm_ls *dlm_find_lockspace_name(char *name, int namelen);
diff -urpN a/drivers/dlm/main.c b/drivers/dlm/main.c
--- a/drivers/dlm/main.c	2005-08-18 13:26:02.653374584 +0800
+++ b/drivers/dlm/main.c	2005-08-18 13:26:25.738865056 +0800
@@ -13,9 +13,7 @@
 
 #include "dlm_internal.h"
 #include "lockspace.h"
-#include "member_sysfs.h"
 #include "lock.h"
-#include "device.h"
 #include "memory.h"
 #include "lowcomms.h"
 #include "config.h"
@@ -40,13 +38,9 @@ static int __init init_dlm(void)
 	if (error)
 		goto out_mem;
 
-	error = dlm_member_sysfs_init();
-	if (error)
-		goto out_mem;
-
 	error = dlm_config_init();
 	if (error)
-		goto out_member;
+		goto out_lockspace;
 
 	error = dlm_register_debugfs();
 	if (error)
@@ -64,8 +58,8 @@ static int __init init_dlm(void)
 	dlm_unregister_debugfs();
  out_config:
 	dlm_config_exit();
- out_member:
-	dlm_member_sysfs_exit();
+ out_lockspace:
+	dlm_lockspace_exit();
  out_mem:
 	dlm_memory_exit();
  out:
@@ -75,9 +69,9 @@ static int __init init_dlm(void)
 static void __exit exit_dlm(void)
 {
 	dlm_lowcomms_exit();
-	dlm_member_sysfs_exit();
 	dlm_config_exit();
 	dlm_memory_exit();
+	dlm_lockspace_exit();
 	dlm_unregister_debugfs();
 }
 
diff -urpN a/drivers/dlm/member.c b/drivers/dlm/member.c
--- a/drivers/dlm/member.c	2005-08-18 13:26:02.654374432 +0800
+++ b/drivers/dlm/member.c	2005-08-18 13:26:25.738865056 +0800
@@ -221,7 +221,7 @@ int dlm_recover_members(struct dlm_ls *l
 }
 
 /*
- * Following called from member_sysfs.c
+ * Following called from lockspace.c
  */
 
 int dlm_ls_stop(struct dlm_ls *ls)
diff -urpN a/drivers/dlm/member_sysfs.c b/drivers/dlm/member_sysfs.c
--- a/drivers/dlm/member_sysfs.c	2005-08-18 13:26:02.655374280 +0800
+++ b/drivers/dlm/member_sysfs.c	1970-01-01 07:30:00.000000000 +0730
@@ -1,165 +0,0 @@
-/******************************************************************************
-*******************************************************************************
-**
-**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
-**
-**  This copyrighted material is made available to anyone wishing to use,
-**  modify, copy, or redistribute it subject to the terms and conditions
-**  of the GNU General Public License v.2.
-**
-*******************************************************************************
-******************************************************************************/
-
-#include "dlm_internal.h"
-#include "member.h"
-
-
-static ssize_t dlm_control_store(struct dlm_ls *ls, const char *buf, size_t len)
-{
-	ssize_t ret = len;
-	int n = simple_strtol(buf, NULL, 0);
-
-	switch (n) {
-	case 0:
-		dlm_ls_stop(ls);
-		break;
-	case 1:
-		dlm_ls_start(ls);
-		break;
-	default:
-		ret = -EINVAL;
-	}
-	return ret;
-}
-
-static ssize_t dlm_event_store(struct dlm_ls *ls, const char *buf, size_t len)
-{
-	ls->ls_uevent_result = simple_strtol(buf, NULL, 0);
-	set_bit(LSFL_UEVENT_WAIT, &ls->ls_flags);
-	wake_up(&ls->ls_uevent_wait);
-	return len;
-}
-
-static ssize_t dlm_id_show(struct dlm_ls *ls, char *buf)
-{
-	return sprintf(buf, "%u\n", ls->ls_global_id);
-}
-
-static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
-{
-	ls->ls_global_id = simple_strtoul(buf, NULL, 0);
-	return len;
-}
-
-struct dlm_attr {
-	struct attribute attr;
-	ssize_t (*show)(struct dlm_ls *, char *);
-	ssize_t (*store)(struct dlm_ls *, const char *, size_t);
-};
-
-static struct dlm_attr dlm_attr_control = {
-	.attr  = {.name = "control", .mode = S_IWUSR},
-	.store = dlm_control_store
-};
-
-static struct dlm_attr dlm_attr_event = {
-	.attr  = {.name = "event_done", .mode = S_IWUSR},
-	.store = dlm_event_store
-};
-
-static struct dlm_attr dlm_attr_id = {
-	.attr  = {.name = "id", .mode = S_IRUGO | S_IWUSR},
-	.show  = dlm_id_show,
-	.store = dlm_id_store
-};
-
-static struct attribute *dlm_attrs[] = {
-	&dlm_attr_control.attr,
-	&dlm_attr_event.attr,
-	&dlm_attr_id.attr,
-	NULL,
-};
-
-static ssize_t dlm_attr_show(struct kobject *kobj, struct attribute *attr,
-			     char *buf)
-{
-	struct dlm_ls *ls  = container_of(kobj, struct dlm_ls, ls_kobj);
-	struct dlm_attr *a = container_of(attr, struct dlm_attr, attr);
-	return a->show ? a->show(ls, buf) : 0;
-}
-
-static ssize_t dlm_attr_store(struct kobject *kobj, struct attribute *attr,
-			      const char *buf, size_t len)
-{
-	struct dlm_ls *ls  = container_of(kobj, struct dlm_ls, ls_kobj);
-	struct dlm_attr *a = container_of(attr, struct dlm_attr, attr);
-	return a->store ? a->store(ls, buf, len) : len;
-}
-
-static struct sysfs_ops dlm_attr_ops = {
-	.show  = dlm_attr_show,
-	.store = dlm_attr_store,
-};
-
-static struct kobj_type dlm_ktype = {
-	.default_attrs = dlm_attrs,
-	.sysfs_ops     = &dlm_attr_ops,
-};
-
-static struct kset dlm_kset = {
-	.subsys = &kernel_subsys,
-	.kobj   = {.name = "dlm",},
-	.ktype  = &dlm_ktype,
-};
-
-int dlm_member_sysfs_init(void)
-{
-	int error;
-
-	error = kset_register(&dlm_kset);
-	if (error)
-		printk("dlm_lockspace_init: cannot register kset %d\n", error);
-	return error;
-}
-
-void dlm_member_sysfs_exit(void)
-{
-	kset_unregister(&dlm_kset);
-}
-
-int dlm_kobject_setup(struct dlm_ls *ls)
-{
-	char lsname[DLM_LOCKSPACE_LEN];
-	int error;
-
-	memset(lsname, 0, DLM_LOCKSPACE_LEN);
-	snprintf(lsname, DLM_LOCKSPACE_LEN, "%s", ls->ls_name);
-
-	error = kobject_set_name(&ls->ls_kobj, "%s", lsname);
-	if (error)
-		return error;
-
-	ls->ls_kobj.kset = &dlm_kset;
-	ls->ls_kobj.ktype = &dlm_ktype;
-	return 0;
-}
-
-int dlm_uevent(struct dlm_ls *ls, int in)
-{
-	int error;
-
-	if (in)
-		kobject_uevent(&ls->ls_kobj, KOBJ_ONLINE, NULL);
-	else
-		kobject_uevent(&ls->ls_kobj, KOBJ_OFFLINE, NULL);
-
-	error = wait_event_interruptible(ls->ls_uevent_wait,
-			test_and_clear_bit(LSFL_UEVENT_WAIT, &ls->ls_flags));
-	if (error)
-		goto out;
-
-	error = ls->ls_uevent_result;
- out:
-	return error;
-}
-
diff -urpN a/drivers/dlm/member_sysfs.h b/drivers/dlm/member_sysfs.h
--- a/drivers/dlm/member_sysfs.h	2005-08-17 17:19:22.000000000 +0800
+++ b/drivers/dlm/member_sysfs.h	1970-01-01 07:30:00.000000000 +0730
@@ -1,22 +0,0 @@
-/******************************************************************************
-*******************************************************************************
-**
-**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
-**
-**  This copyrighted material is made available to anyone wishing to use,
-**  modify, copy, or redistribute it subject to the terms and conditions
-**  of the GNU General Public License v.2.
-**
-*******************************************************************************
-******************************************************************************/
-
-#ifndef __MEMBER_SYSFS_DOT_H__
-#define __MEMBER_SYSFS_DOT_H__
-
-int dlm_member_sysfs_init(void);
-void dlm_member_sysfs_exit(void);
-int dlm_kobject_setup(struct dlm_ls *ls);
-int dlm_uevent(struct dlm_ls *ls, int in);
-
-#endif                          /* __MEMBER_SYSFS_DOT_H__ */
-
