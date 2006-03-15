Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752086AbWCOPsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbWCOPsv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbWCOPsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 10:48:51 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:15503 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752086AbWCOPsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 10:48:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=D7w3NW2//QFU6DbCkrfT2hu7W4WjkJAEehDm21fi24e6dKbhHa1lM3EDwMkTEJoJPVCaQKujeNSHKIgKVe7hbKL5ff3MzXpenN+6Dhhzj7nlSGS/fX2+ULOnlXPirwRQDjxArNdATV+oPhdigUrUGBfV9BkqRvbq4Ipy15U3eh8=
Message-ID: <4418375C.5090703@gmail.com>
Date: Wed, 15 Mar 2006 23:48:44 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [2.6.16-rc6-m1 PATCH] Connector: Filesystem Events Connector
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a new connector, Filesystem Event Connector,
 the user can monitor filesystem activities via it, currently, it
 can monitor access, attribute change, open, create, modify, delete,
 move and close of any file or directory.

Every filesystem event will include tgid, uid and gid of the process
 which triggered this event, process name, file or directory name 
operated by it.

 drivers/connector/Kconfig  |    8 +
 drivers/connector/Makefile |    1
 drivers/connector/cn_fs.c  |  204+++++++++++++++++++++++++++++++++++++++++++++ 
 include/linux/connector.h  |    2
 include/linux/fsevent.h    |   82 ++++++++++++++++++
 include/linux/fsnotify.h   |   56 +++++++++++-
 6 files changed, 348 insertions(+), 5 deletions(-)

Signed-off-by: Yi Yang <yang.y.yi@gmail.com>

--- a/include/linux/connector.h.orig	2006-03-15 23:21:37.000000000 +0800
+++ b/include/linux/connector.h	2006-03-15 23:23:09.000000000 +0800
@@ -34,6 +34,8 @@
 #define CN_VAL_PROC			0x1
 #define CN_IDX_CIFS			0x2
 #define CN_VAL_CIFS                     0x1
+#define CN_IDX_FS			0x3
+#define CN_VAL_FS			0x1
 
 #define CN_NETLINK_USERS		1
 
--- a/include/linux/fsnotify.h.orig	2006-03-15 22:31:34.000000000 +0800
+++ b/include/linux/fsnotify.h	2006-03-15 22:48:56.000000000 +0800
@@ -16,6 +16,7 @@
 #include <linux/dnotify.h>
 #include <linux/inotify.h>
 #include <linux/audit.h>
+#include <linux/fsevent.h>
 
 /*
  * fsnotify_d_instantiate - instantiate a dentry for inode
@@ -44,6 +45,7 @@ static inline void fsnotify_move(struct 
 				 int isdir, struct inode *target, struct inode *source)
 {
 	u32 cookie = inotify_get_cookie();
+	u32 fsevent_mask = FSEVENT_MOVE;
 
 	if (old_dir == new_dir)
 		inode_dir_notify(old_dir, DN_RENAME);
@@ -67,6 +69,11 @@ static inline void fsnotify_move(struct 
 	}
 	audit_inode_child(old_name, source, old_dir->i_ino);
 	audit_inode_child(new_name, target, new_dir->i_ino);
+
+	if (isdir)
+		fsevent_mask |= FSEVENT_ISDIR;
+
+	raise_fsevent_move(old_dir, old_name, new_dir, new_name, fsevent_mask);
 }
 
 /*
@@ -78,6 +85,10 @@ static inline void fsnotify_nameremove(s
 		isdir = IN_ISDIR;
 	dnotify_parent(dentry, DN_DELETE);
 	inotify_dentry_parent_queue_event(dentry, IN_DELETE|isdir, 0, dentry->d_name.name);
+
+	if (isdir)
+		isdir = FSEVENT_ISDIR;
+	raise_fsevent(dentry, FSEVENT_DELETE | isdir);
 }
 
 /*
@@ -97,6 +108,7 @@ static inline void fsnotify_create(struc
 	inode_dir_notify(inode, DN_CREATE);
 	inotify_inode_queue_event(inode, IN_CREATE, 0, dentry->d_name.name);
 	audit_inode_child(dentry->d_name.name, dentry->d_inode, inode->i_ino);
+	raise_fsevent_create(inode, dentry->d_name.name, FSEVENT_CREATE);
 }
 
 /*
@@ -108,6 +120,7 @@ static inline void fsnotify_mkdir(struct
 	inotify_inode_queue_event(inode, IN_CREATE | IN_ISDIR, 0, 
 				  dentry->d_name.name);
 	audit_inode_child(dentry->d_name.name, dentry->d_inode, inode->i_ino);
+	raise_fsevent_create(inode, dentry->d_name.name, FSEVENT_CREATE | FSEVENT_ISDIR);
 }
 
 /*
@@ -117,13 +130,17 @@ static inline void fsnotify_access(struc
 {
 	struct inode *inode = dentry->d_inode;
 	u32 mask = IN_ACCESS;
+	u32 fsevent_mask = FSEVENT_ACCESS;
 
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode)) {
 		mask |= IN_ISDIR;
+		fsevent_mask |= FSEVENT_ISDIR;
+	}
 
 	dnotify_parent(dentry, DN_ACCESS);
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);
+	raise_fsevent(dentry, fsevent_mask);
 }
 
 /*
@@ -133,13 +150,17 @@ static inline void fsnotify_modify(struc
 {
 	struct inode *inode = dentry->d_inode;
 	u32 mask = IN_MODIFY;
+	u32 fsevent_mask = FSEVENT_MODIFY;
 
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode)) {
 		mask |= IN_ISDIR;
+		fsevent_mask |= FSEVENT_ISDIR;
+	}
 
 	dnotify_parent(dentry, DN_MODIFY);
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);
+	raise_fsevent(dentry, fsevent_mask);
 }
 
 /*
@@ -149,12 +170,16 @@ static inline void fsnotify_open(struct 
 {
 	struct inode *inode = dentry->d_inode;
 	u32 mask = IN_OPEN;
+	u32 fsevent_mask = FSEVENT_OPEN;
 
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode)) {
 		mask |= IN_ISDIR;
+		fsevent_mask |= FSEVENT_ISDIR;
+	}
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);	
+	raise_fsevent(dentry, fsevent_mask);
 }
 
 /*
@@ -167,12 +192,16 @@ static inline void fsnotify_close(struct
 	const char *name = dentry->d_name.name;
 	mode_t mode = file->f_mode;
 	u32 mask = (mode & FMODE_WRITE) ? IN_CLOSE_WRITE : IN_CLOSE_NOWRITE;
+	u32 fsevent_mask = FSEVENT_CLOSE;
 
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode)) {
 		mask |= IN_ISDIR;
+		fsevent_mask |= FSEVENT_ISDIR;
+	}
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);
+	raise_fsevent(dentry, fsevent_mask);
 }
 
 /*
@@ -182,12 +211,16 @@ static inline void fsnotify_xattr(struct
 {
 	struct inode *inode = dentry->d_inode;
 	u32 mask = IN_ATTRIB;
+	u32 fsevent_mask = FSEVENT_MODIFY_ATTRIB;
 
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode)) {
 		mask |= IN_ISDIR;
+		fsevent_mask |= FSEVENT_ISDIR;
+	}
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);
+	raise_fsevent(dentry, fsevent_mask);
 }
 
 /*
@@ -199,34 +232,42 @@ static inline void fsnotify_change(struc
 	struct inode *inode = dentry->d_inode;
 	int dn_mask = 0;
 	u32 in_mask = 0;
+	u32 fsevent_mask = 0;
 
 	if (ia_valid & ATTR_UID) {
 		in_mask |= IN_ATTRIB;
 		dn_mask |= DN_ATTRIB;
+		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
 	}
 	if (ia_valid & ATTR_GID) {
 		in_mask |= IN_ATTRIB;
 		dn_mask |= DN_ATTRIB;
+		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
 	}
 	if (ia_valid & ATTR_SIZE) {
 		in_mask |= IN_MODIFY;
 		dn_mask |= DN_MODIFY;
+		fsevent_mask |= FSEVENT_MODIFY;
 	}
 	/* both times implies a utime(s) call */
 	if ((ia_valid & (ATTR_ATIME | ATTR_MTIME)) == (ATTR_ATIME | ATTR_MTIME))
 	{
 		in_mask |= IN_ATTRIB;
 		dn_mask |= DN_ATTRIB;
+		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
 	} else if (ia_valid & ATTR_ATIME) {
 		in_mask |= IN_ACCESS;
 		dn_mask |= DN_ACCESS;
+		fsevent_mask |= FSEVENT_ACCESS;
 	} else if (ia_valid & ATTR_MTIME) {
 		in_mask |= IN_MODIFY;
 		dn_mask |= DN_MODIFY;
+		fsevent_mask |= FSEVENT_MODIFY;
 	}
 	if (ia_valid & ATTR_MODE) {
 		in_mask |= IN_ATTRIB;
 		dn_mask |= DN_ATTRIB;
+		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
 	}
 
 	if (dn_mask)
@@ -238,6 +279,11 @@ static inline void fsnotify_change(struc
 		inotify_dentry_parent_queue_event(dentry, in_mask, 0,
 						  dentry->d_name.name);
 	}
+	if (fsevent_mask) {
+		if (S_ISDIR(inode->i_mode))
+			fsevent_mask |= FSEVENT_ISDIR;
+		raise_fsevent(dentry, fsevent_mask);
+	}
 }
 
 #ifdef CONFIG_INOTIFY	/* inotify helpers */
--- a/drivers/connector/Makefile.orig	2006-03-12 21:23:18.000000000 +0800
+++ b/drivers/connector/Makefile	2006-03-12 21:24:25.000000000 +0800
@@ -1,4 +1,5 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
 obj-$(CONFIG_PROC_EVENTS)	+= cn_proc.o
+obj-$(CONFIG_FS_EVENTS)	+= cn_fs.o
 
 cn-y				+= cn_queue.o connector.o
--- a/drivers/connector/Kconfig.orig	2006-03-12 21:23:53.000000000 +0800
+++ b/drivers/connector/Kconfig	2006-03-12 21:21:44.000000000 +0800
@@ -18,4 +18,12 @@ config PROC_EVENTS
 	  Provide a connector that reports process events to userspace. Send
 	  events such as fork, exec, id change (uid, gid, suid, etc), and exit.
 
+config FS_EVENTS
+	boolean "Report filesystem events to userspace"
+	depends on CONNECTOR=y
+	default y
+	---help---
+	  Provide a connector that reports filesystem events to userspace. The
+	  reported event include open, read, write.
+
 endmenu
--- /dev/null	2003-01-30 18:24:37.000000000 +0800
+++ b/include/linux/fsevent.h	2006-03-15 23:22:30.000000000 +0800
@@ -0,0 +1,82 @@
+/*
+ * fsevent.h - filesystem events connector
+ *
+ * Copyright (C) 2006 Yi Yang <yang.y.yi@gmail.com>
+ * Based on cn_proc.h by Matt Helsley, IBM Corp
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef LINUX_FSEVENT_H
+#define LINUX_FSEVENT_H
+
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/connector.h>
+
+enum  fsevent_type {
+	FSEVENT_ACCESS = 	0x00000001,	/* File was accessed */
+	FSEVENT_MODIFY = 	0x00000002,	/* File was modified */
+	FSEVENT_MODIFY_ATTRIB = 0x00000004,	/* Metadata changed */
+	FSEVENT_CLOSE = 	0x00000008,	/* File was closed */
+	FSEVENT_OPEN = 		0x00000010,	/* File was opened */
+	FSEVENT_MOVE = 		0x00000020,	/* File was moved */
+	FSEVENT_CREATE = 	0x00000040,	/* File was created */
+	FSEVENT_DELETE =	0x00000080,	/* File was deleted */
+	FSEVENT_CMDACK = 	0x40000000,	/* For used internally */
+	FSEVENT_ISDIR = 	0x80000000	/* It is set for a dir */
+};
+
+/*
+ * Userspace sends this enum to register with the kernel that it is listening
+ * for events on the connector.
+ */
+enum fsevent_mode {
+	FSEVENT_LISTEN = 1,
+	FSEVENT_IGNORE = 2
+};
+
+struct fsevent {
+	__u32 type;
+	__u32 cpu;
+	struct timespec timestamp;
+	__u32 tgid;
+	__u32 uid;
+	__u32 gid;
+	__u32 err;
+	__u32 len;
+	__u32 pname_len;
+	__u32 fname_len;
+	__u32 new_fname_len;
+	char name[0];
+};
+
+#ifdef __KERNEL__
+#ifdef CONFIG_FS_EVENTS
+extern void raise_fsevent(struct dentry * dentryp, u32 mask);
+extern void raise_fsevent_move(struct inode * olddir, const char * oldname, struct inode * newdir, const char * newname, u32 mask);
+extern void raise_fsevent_create(struct inode * inode, const char * name, u32 mask);
+#else
+static void raise_fsevent(struct dentry * dentryp,  u32 mask);
+{}
+
+static void raise_fsevent_move(struct inode * olddir, const char * oldname, struct inode * newdir, const char * newname, u32 mask)
+{}
+
+static void raise_fsevent_create(struct inode * inode, const char * name, u32 mask)
+{}
+#endif	/* CONFIG_FS_EVENTS */
+#endif	/* __KERNEL__ */
+#endif	/* LINUX_FSEVENT_H */
--- /dev/null	2003-01-30 18:24:37.000000000 +0800
+++ b/drivers/connector/cn_fs.c	2006-03-15 23:20:51.000000000 +0800
@@ -0,0 +1,204 @@
+/*
+ * cn_fs.c - filesystem events connector
+ *
+ * Copyright (C) 2006 Yi Yang <yang.y.yi@gmail.com>
+ * Based on cn_proc.c by Matt Helsley, IBM Corp
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/ktime.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/fsevent.h>
+#include <asm/atomic.h>
+
+#define CN_FS_MSG_SIZE (sizeof(struct cn_msg) + sizeof(struct fsevent))
+
+static atomic_t cn_fs_event_listeners = ATOMIC_INIT(0);
+static struct cb_id cn_fs_event_id = { CN_IDX_FS, CN_VAL_FS };
+
+static DEFINE_PER_CPU(__u32, cn_fs_event_counts) = { 0 };
+static int fsevent_burst_limit = 100;
+static int fsevent_ratelimit = 5 * HZ;
+static DEFINE_SPINLOCK(fsevent_ratelimit_lock);
+
+static inline void get_seq(__u32 *ts, int *cpu)
+{
+	*ts = get_cpu_var(cn_fs_event_counts)++;
+	*cpu = smp_processor_id();
+	put_cpu_var(cn_fs_event_counts);
+}
+
+int __raise_fsevent(const char * oldname, const char * newname, u32 mask)
+{
+	struct cn_msg *msg;
+	struct fsevent *event;
+	__u8 * buffer;
+	int namelen = 0;
+	static unsigned long last;
+	static int fsevent_sum = 0;
+
+	if (atomic_read(&cn_fs_event_listeners) < 1)
+		return 0;
+
+	spin_lock(&fsevent_ratelimit_lock);
+	if (fsevent_sum == 0) {
+		last = jiffies;
+	}
+	if (jiffies - last <= fsevent_ratelimit) {
+		if (fsevent_sum > fsevent_burst_limit) {
+			return -1;
+		}
+		fsevent_sum++;
+	}
+	else {
+		last = jiffies;
+		fsevent_sum = 0;
+	}
+	spin_unlock(&fsevent_ratelimit_lock);
+
+	namelen = strlen(current->comm) + strlen(oldname) + 2;
+	if (newname) {
+		namelen += strlen(newname) + 1;
+	}
+	
+	if ((buffer = (__u8 *)kmalloc(CN_FS_MSG_SIZE + namelen, GFP_KERNEL)) == NULL) {
+		printk("cn_fs: out of memory\n");
+		return -1;
+	}
+
+	msg = (struct cn_msg*)buffer;
+	event = (struct fsevent*)msg->data;
+	get_seq(&msg->seq, &event->cpu);
+	ktime_get_ts(&event->timestamp);
+	event->type = mask;
+	event->tgid = current->tgid;
+	event->uid = current->uid;
+	event->gid = current->gid;
+	event->pname_len = strlen(current->comm);
+	memcpy(event->name, current->comm, event->pname_len);
+	event->name[event->pname_len] = '\0';
+	event->fname_len = strlen(oldname);
+	memcpy(event->name + event->pname_len + 1, oldname, strlen(oldname));
+	event->len = event->pname_len +  event->fname_len + 2;
+	event->name[event->len-1] = '\0';
+	event->new_fname_len = 0;
+	if (newname) {
+		event->new_fname_len = strlen(newname);
+		memcpy(event->name + event->len, newname, strlen(newname));
+		event->len += event->new_fname_len + 1;
+		event->name[event->len-1] = '\0';
+	}
+
+	memcpy(&msg->id, &cn_fs_event_id, sizeof(msg->id));
+	msg->ack = 0;
+	msg->len = sizeof(struct fsevent) + event->len;
+	cn_netlink_send(msg, CN_IDX_FS, GFP_KERNEL);
+	kfree(buffer);
+	return 0;
+}
+
+void raise_fsevent(struct dentry * dentryp, u32 mask)
+{
+	__raise_fsevent(dentryp->d_name.name, NULL, mask);
+}
+EXPORT_SYMBOL_GPL(raise_fsevent);
+
+void raise_fsevent_create(struct inode * inode, const char * name, u32 mask)
+{
+	__raise_fsevent(name, NULL, mask);
+}
+EXPORT_SYMBOL_GPL(raise_fsevent_create);
+
+void raise_fsevent_move(struct inode * olddir, const char * oldname, struct inode * newdir, const char * newname, u32 mask)
+{
+	__raise_fsevent(oldname, newname, mask);
+}
+EXPORT_SYMBOL_GPL(raise_fsevent_move);
+
+static void cn_fs_event_ack(int err, int rcvd_seq, int rcvd_ack)
+{
+	struct cn_msg *msg;
+	struct fsevent *event;
+	__u8 * buffer = NULL;
+
+	if (atomic_read(&cn_fs_event_listeners) < 1)
+		return;
+
+	if ((buffer = (__u8 *)kmalloc(CN_FS_MSG_SIZE, GFP_KERNEL)) == NULL) {
+		printk("cn_fs: out of memory\n");
+		return;
+	}
+
+	msg = (struct cn_msg*)buffer;
+	event = (struct fsevent*)msg->data;
+	msg->seq = rcvd_seq;
+	ktime_get_ts(&event->timestamp);
+	event->cpu = -1;
+	event->type = FSEVENT_CMDACK;
+	event->tgid = 0;
+	event->uid = 0;
+	event->gid = 0;
+	event->len = 0;
+	event->pname_len = 0;
+	event->fname_len = 0;
+	event->new_fname_len = 0;
+	event->err = err;
+	memcpy(&msg->id, &cn_fs_event_id, sizeof(msg->id));
+	msg->ack = rcvd_ack + 1;
+	msg->len = sizeof(struct fsevent);
+	cn_netlink_send(msg, CN_IDX_FS, GFP_KERNEL);
+}
+
+static void cn_fsevent_mode_ctl(void *data)
+{
+	struct cn_msg *msg = data;
+	enum fsevent_mode *mode = NULL;
+	int err = 0;
+
+	if (msg->len != sizeof(*mode))
+		return;
+
+	mode = (enum fsevent_mode*)msg->data;
+	switch (*mode) {
+	case FSEVENT_LISTEN:
+		atomic_inc(&cn_fs_event_listeners);
+		break;
+	case FSEVENT_IGNORE:
+		atomic_dec(&cn_fs_event_listeners);
+		break;
+	default:
+		err = EINVAL;
+		break;
+	}
+	cn_fs_event_ack(err, msg->seq, msg->ack);
+}
+
+static int __init cn_fs_init(void)
+{
+	int err;
+
+	if ((err = cn_add_callback(&cn_fs_event_id, "cn_fs",
+	 			   &cn_fsevent_mode_ctl))) {
+		printk(KERN_WARNING "cn_fs failed to register\n");
+		return err;
+	}
+	return 0;
+}
+
+module_init(cn_fs_init);


