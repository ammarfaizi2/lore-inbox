Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262638AbVDYPag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262638AbVDYPag (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbVDYPae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:30:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7590 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262657AbVDYPJJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:09:09 -0400
Date: Mon, 25 Apr 2005 23:12:50 +0800
From: David Teigland <teigland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 4/7] dlm: configuration
Message-ID: <20050425151250.GE6826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Per-lockspace configuration happens through files under:
/sys/kernel/dlm/<lockspace_name>/.  This includes telling each lockspace
which nodes are using the lockspace and suspending locking in a lockspace.

Lockspace-independent configuration involves telling the dlm communication
layer the IP address of each node ID that's being used.  These addresses
are set using an ioctl on a misc device.

Signed-Off-By: Dave Teigland <teigland@redhat.com>
Signed-Off-By: Patrick Caulfield <pcaulfie@redhat.com>

---

 drivers/dlm/config.c       |   42 +++++
 drivers/dlm/config.h       |   31 ++++
 drivers/dlm/member_sysfs.c |  321 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/dlm/member_sysfs.h |   21 ++
 drivers/dlm/node_ioctl.c   |  126 +++++++++++++++++
 include/linux/dlm_node.h   |   43 ++++++
 6 files changed, 584 insertions(+)

--- a/include/linux/dlm_node.h	1970-01-01 07:30:00.000000000 +0730
+++ b/include/linux/dlm_node.h	2005-04-25 22:52:03.852832568 +0800
@@ -0,0 +1,43 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+**
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __DLM_NODE_DOT_H__
+#define __DLM_NODE_DOT_H__
+
+#define DLM_ADDR_LEN			(256)
+#define DLM_MAX_ADDR_COUNT		(3)
+#define DLM_NODE_MISC_NAME		("dlm-node")
+
+#define DLM_NODE_VERSION_MAJOR		(1)
+#define DLM_NODE_VERSION_MINOR		(0)
+#define DLM_NODE_VERSION_PATCH		(0)
+
+struct dlm_node_ioctl {
+	__u32	version[3];
+	int	nodeid;
+	int	weight;
+	char	addr[DLM_ADDR_LEN];
+};
+
+enum {
+	DLM_NODE_VERSION_CMD = 0,
+	DLM_SET_NODE_CMD,
+	DLM_SET_LOCAL_CMD,
+};
+
+#define DLM_IOCTL			(0xd1)
+
+#define DLM_NODE_VERSION _IOWR(DLM_IOCTL, DLM_NODE_VERSION_CMD, struct dlm_node_ioctl)
+#define DLM_SET_NODE     _IOWR(DLM_IOCTL, DLM_SET_NODE_CMD, struct dlm_node_ioctl)
+#define DLM_SET_LOCAL    _IOWR(DLM_IOCTL, DLM_SET_LOCAL_CMD, struct dlm_node_ioctl)
+
+#endif
--- a/drivers/dlm/config.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/config.c	2005-04-25 22:52:03.729851264 +0800
@@ -0,0 +1,42 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#include "dlm_internal.h"
+#include "config.h"
+
+/* Config file defaults */
+#define DEFAULT_TCP_PORT       21064
+#define DEFAULT_BUFFER_SIZE     4096
+#define DEFAULT_RSBTBL_SIZE      256
+#define DEFAULT_LKBTBL_SIZE     1024
+#define DEFAULT_DIRTBL_SIZE      512
+#define DEFAULT_RECOVER_TIMER      5
+
+struct dlm_config_info dlm_config = {
+	.tcp_port = DEFAULT_TCP_PORT,
+	.buffer_size = DEFAULT_BUFFER_SIZE,
+	.rsbtbl_size = DEFAULT_RSBTBL_SIZE,
+	.lkbtbl_size = DEFAULT_LKBTBL_SIZE,
+	.dirtbl_size = DEFAULT_DIRTBL_SIZE,
+	.recover_timer = DEFAULT_RECOVER_TIMER
+};
+
+int dlm_config_init(void)
+{
+	/* FIXME: hook the config values into sysfs */
+	return 0;
+}
+
+void dlm_config_exit(void)
+{
+}
--- a/drivers/dlm/config.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/config.h	2005-04-25 22:52:03.738849896 +0800
@@ -0,0 +1,31 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) Sistina Software, Inc.  1997-2003  All rights reserved.
+**  Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __CONFIG_DOT_H__
+#define __CONFIG_DOT_H__
+
+struct dlm_config_info {
+	int tcp_port;
+	int buffer_size;
+	int rsbtbl_size;
+	int lkbtbl_size;
+	int dirtbl_size;
+	int recover_timer;
+};
+
+extern struct dlm_config_info dlm_config;
+
+extern int dlm_config_init(void);
+extern void dlm_config_exit(void);
+
+#endif				/* __CONFIG_DOT_H__ */
--- a/drivers/dlm/member_sysfs.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/member_sysfs.c	2005-04-25 22:52:04.036804600 +0800
@@ -0,0 +1,321 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+**
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#include "dlm_internal.h"
+#include "member.h"
+
+/*
+/dlm/lsname/stop       RW  write 1 to suspend operation
+/dlm/lsname/start      RW  write event_nr to start recovery
+/dlm/lsname/finish     RW  write event_nr to finish recovery
+/dlm/lsname/terminate  RW  write event_nr to term recovery
+/dlm/lsname/done       RO  event_nr dlm is done processing
+/dlm/lsname/id         RW  global id of lockspace
+/dlm/lsname/members    RW  read = current members, write = next members
+*/
+
+
+static ssize_t dlm_stop_show(struct dlm_ls *ls, char *buf)
+{
+	ssize_t ret;
+	int val;
+
+	spin_lock(&ls->ls_recover_lock);
+	val = ls->ls_last_stop;
+	spin_unlock(&ls->ls_recover_lock);
+	ret = sprintf(buf, "%d\n", val);
+	return ret;
+}
+
+static ssize_t dlm_stop_store(struct dlm_ls *ls, const char *buf, size_t len)
+{
+	ssize_t ret = -EINVAL;
+
+	if (simple_strtol(buf, NULL, 0) == 1) {
+		dlm_ls_stop(ls);
+		ret = len;
+	}
+	return ret;
+}
+
+static ssize_t dlm_start_show(struct dlm_ls *ls, char *buf)
+{
+	ssize_t ret;
+	int val;
+
+	spin_lock(&ls->ls_recover_lock);
+	val = ls->ls_last_start;
+	spin_unlock(&ls->ls_recover_lock);
+	ret = sprintf(buf, "%d\n", val);
+	return ret;
+}
+
+static ssize_t dlm_start_store(struct dlm_ls *ls, const char *buf, size_t len)
+{
+	ssize_t ret;
+	ret = dlm_ls_start(ls, simple_strtol(buf, NULL, 0));
+	return ret ? ret : len;
+}
+
+static ssize_t dlm_finish_show(struct dlm_ls *ls, char *buf)
+{
+	ssize_t ret;
+	int val;
+
+	spin_lock(&ls->ls_recover_lock);
+	val = ls->ls_last_finish;
+	spin_unlock(&ls->ls_recover_lock);
+	ret = sprintf(buf, "%d\n", val);
+	return ret;
+}
+
+static ssize_t dlm_finish_store(struct dlm_ls *ls, const char *buf, size_t len)
+{
+	dlm_ls_finish(ls, simple_strtol(buf, NULL, 0));
+	return len;
+}
+
+static ssize_t dlm_terminate_show(struct dlm_ls *ls, char *buf)
+{
+	ssize_t ret;
+	int val = 0;
+
+	spin_lock(&ls->ls_recover_lock);
+	if (test_bit(LSFL_LS_TERMINATE, &ls->ls_flags))
+		val = 1;
+	spin_unlock(&ls->ls_recover_lock);
+	ret = sprintf(buf, "%d\n", val);
+	return ret;
+}
+
+static ssize_t dlm_terminate_store(struct dlm_ls *ls, const char *buf, size_t len)
+{
+	ssize_t ret = -EINVAL;
+
+	if (simple_strtol(buf, NULL, 0) == 1) {
+		dlm_ls_terminate(ls);
+		ret = len;
+	}
+	return ret;
+}
+
+static ssize_t dlm_done_show(struct dlm_ls *ls, char *buf)
+{
+	ssize_t ret;
+	int val;
+
+	spin_lock(&ls->ls_recover_lock);
+	val = ls->ls_startdone;
+	spin_unlock(&ls->ls_recover_lock);
+	ret = sprintf(buf, "%d\n", val);
+	return ret;
+}
+
+static ssize_t dlm_id_show(struct dlm_ls *ls, char *buf)
+{
+	return sprintf(buf, "%u\n", ls->ls_global_id);
+}
+
+static ssize_t dlm_id_store(struct dlm_ls *ls, const char *buf, size_t len)
+{
+	ls->ls_global_id = simple_strtol(buf, NULL, 0);
+	return len;
+}
+
+static ssize_t dlm_members_show(struct dlm_ls *ls, char *buf)
+{
+	struct dlm_member *memb;
+	ssize_t ret = 0;
+
+	if (!down_read_trylock(&ls->ls_in_recovery))
+		return -EBUSY;
+	list_for_each_entry(memb, &ls->ls_nodes, list)
+		ret += sprintf(buf+ret, "%u ", memb->nodeid);
+	ret += sprintf(buf+ret, "\n");
+	up_read(&ls->ls_in_recovery);
+	return ret;
+}
+
+static ssize_t dlm_members_store(struct dlm_ls *ls, const char *buf, size_t len)
+{
+	int *nodeids, id, count = 1, i;
+	ssize_t ret = len;
+	char *p, *t;
+
+	/* count number of id's in buf, assumes no trailing spaces */
+	for (i = 0; i < len; i++)
+		if (isspace(buf[i]))
+			count++;
+
+	nodeids = kmalloc(sizeof(int) * count, GFP_KERNEL);
+	if (!nodeids)
+		return -ENOMEM;
+
+	p = kmalloc(len, GFP_KERNEL);
+	if (!p) {
+		kfree(nodeids);
+		return -ENOMEM;
+	}
+	memcpy(p, buf, len);
+
+	for (i = 0; i < count; i++) {
+		if ((t = strsep(&p, " ")) == NULL)
+			break;
+		if (sscanf(t, "%u", &id) != 1)
+			break;
+		nodeids[i] = id;
+	}
+
+	if (i != count) {
+		kfree(nodeids);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	spin_lock(&ls->ls_recover_lock);
+	if (ls->ls_nodeids_next) {
+		kfree(nodeids);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	ls->ls_nodeids_next = nodeids;
+	ls->ls_nodeids_next_count = count;
+
+ out_unlock:
+	spin_unlock(&ls->ls_recover_lock);
+ out:
+	kfree(p);
+	return ret;
+}
+
+struct dlm_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct dlm_ls *, char *);
+	ssize_t (*store)(struct dlm_ls *, const char *, size_t);
+};
+
+static struct dlm_attr dlm_attr_stop = {
+	.attr  = {.name = "stop", .mode = S_IRUGO | S_IWUSR},
+	.show  = dlm_stop_show,
+	.store = dlm_stop_store
+};
+
+static struct dlm_attr dlm_attr_start = {
+	.attr  = {.name = "start", .mode = S_IRUGO | S_IWUSR},
+	.show  = dlm_start_show,
+	.store = dlm_start_store
+};
+
+static struct dlm_attr dlm_attr_finish = {
+	.attr  = {.name = "finish", .mode = S_IRUGO | S_IWUSR},
+	.show  = dlm_finish_show,
+	.store = dlm_finish_store
+};
+
+static struct dlm_attr dlm_attr_terminate = {
+	.attr  = {.name = "terminate", .mode = S_IRUGO | S_IWUSR},
+	.show  = dlm_terminate_show,
+	.store = dlm_terminate_store
+};
+
+static struct dlm_attr dlm_attr_done = {
+	.attr  = {.name = "done", .mode = S_IRUGO},
+	.show  = dlm_done_show,
+};
+
+static struct dlm_attr dlm_attr_id = {
+	.attr  = {.name = "id", .mode = S_IRUGO | S_IWUSR},
+	.show  = dlm_id_show,
+	.store = dlm_id_store
+};
+
+static struct dlm_attr dlm_attr_members = {
+	.attr  = {.name = "members", .mode = S_IRUGO | S_IWUSR},
+	.show  = dlm_members_show,
+	.store = dlm_members_store
+};
+
+static struct attribute *dlm_attrs[] = {
+	&dlm_attr_stop.attr,
+	&dlm_attr_start.attr,
+	&dlm_attr_finish.attr,
+	&dlm_attr_terminate.attr,
+	&dlm_attr_done.attr,
+	&dlm_attr_id.attr,
+	&dlm_attr_members.attr,
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
+int dlm_member_sysfs_init(void)
+{
+	int error;
+
+	error = kset_register(&dlm_kset);
+	if (error)
+		printk("dlm_lockspace_init: cannot register kset %d\n", error);
+	return error;
+}
+
+void dlm_member_sysfs_exit(void)
+{
+	kset_unregister(&dlm_kset);
+}
+
+int dlm_kobject_setup(struct dlm_ls *ls)
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
--- a/drivers/dlm/member_sysfs.h	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/member_sysfs.h	2005-04-25 22:52:04.041803840 +0800
@@ -0,0 +1,21 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+**  
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#ifndef __MEMBER_SYSFS_DOT_H__
+#define __MEMBER_SYSFS_DOT_H__
+
+int dlm_member_sysfs_init(void);
+void dlm_member_sysfs_exit(void);
+int dlm_kobject_setup(struct dlm_ls *ls);
+
+#endif                          /* __MEMBER_SYSFS_DOT_H__ */
+
--- a/drivers/dlm/node_ioctl.c	1970-01-01 07:30:00.000000000 +0730
+++ b/drivers/dlm/node_ioctl.c	2005-04-25 22:52:04.463739696 +0800
@@ -0,0 +1,126 @@
+/******************************************************************************
+*******************************************************************************
+**
+**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
+**
+**  This copyrighted material is made available to anyone wishing to use,
+**  modify, copy, or redistribute it subject to the terms and conditions
+**  of the GNU General Public License v.2.
+**
+*******************************************************************************
+******************************************************************************/
+
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+
+#include <linux/dlm_node.h>
+
+#include "dlm_internal.h"
+#include "lowcomms.h"
+
+
+static int check_version(unsigned int cmd,
+			 struct dlm_node_ioctl __user *u_param)
+{
+	u32 version[3];
+	int error = 0;
+
+	if (copy_from_user(version, u_param->version, sizeof(version)))
+		return -EFAULT;
+
+	if ((DLM_NODE_VERSION_MAJOR != version[0]) ||
+	    (DLM_NODE_VERSION_MINOR < version[1])) {
+		printk("dlm node_ioctl: interface mismatch: "
+		       "kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)\n",
+		       DLM_NODE_VERSION_MAJOR,
+		       DLM_NODE_VERSION_MINOR,
+		       DLM_NODE_VERSION_PATCH,
+		       version[0], version[1], version[2], cmd);
+		error = -EINVAL;
+	}
+
+	version[0] = DLM_NODE_VERSION_MAJOR;
+	version[1] = DLM_NODE_VERSION_MINOR;
+	version[2] = DLM_NODE_VERSION_PATCH;
+
+	if (copy_to_user(u_param->version, version, sizeof(version)))
+		return -EFAULT;
+	return error;
+}
+
+static int node_ioctl(struct inode *inode, struct file *file,
+	              uint command, ulong u)
+{
+	struct dlm_node_ioctl *k_param;
+	struct dlm_node_ioctl __user *u_param;
+	unsigned int cmd, type;
+	int error;
+
+	u_param = (struct dlm_node_ioctl __user *) u;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	type = _IOC_TYPE(command);
+	cmd = _IOC_NR(command);
+
+	if (type != DLM_IOCTL) {
+		printk("dlm node_ioctl: bad ioctl 0x%x 0x%x 0x%x\n",
+		       command, type, cmd);
+		return -ENOTTY;
+	}
+
+	error = check_version(cmd, u_param);
+	if (error)
+		return error;
+
+	if (cmd == DLM_NODE_VERSION_CMD)
+		return 0;
+
+	k_param = kmalloc(sizeof(*k_param), GFP_KERNEL);
+	if (!k_param)
+		return -ENOMEM;
+
+	if (copy_from_user(k_param, u_param, sizeof(*k_param))) {
+		kfree(k_param);
+		return -EFAULT;
+	}
+
+	if (cmd == DLM_SET_NODE_CMD)
+		error = dlm_set_node(k_param->nodeid, k_param->weight,
+				     k_param->addr);
+	else if (cmd == DLM_SET_LOCAL_CMD)
+		error = dlm_set_local(k_param->nodeid, k_param->weight,
+				      k_param->addr);
+
+	kfree(k_param);
+	return error;
+}
+
+static struct file_operations node_fops = {
+	.ioctl	= node_ioctl,
+	.owner	= THIS_MODULE,
+};
+
+static struct miscdevice node_misc = {
+	.minor	= MISC_DYNAMIC_MINOR,
+	.name	= DLM_NODE_MISC_NAME,
+	.fops	= &node_fops
+};
+
+int dlm_node_ioctl_init(void)
+{
+	int error;
+
+	error = misc_register(&node_misc);
+	if (error)
+		printk("dlm node_ioctl: misc_register failed %d\n", error);
+	return error;
+}
+
+void dlm_node_ioctl_exit(void)
+{
+	if (misc_deregister(&node_misc) < 0)
+		printk("dlm node_ioctl: misc_deregister failed\n");
+}
+
