Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWC0PFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWC0PFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 10:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWC0PFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 10:05:20 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:49449 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751070AbWC0PFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 10:05:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=bHPkp89/uF+P9tr6vqhbyZLUlG+ogNxMjNhH5JIkoFgWGhrTg8bQ0rSrK91MHy5z6jSzA7QirQ8JULQRbYr1ZIlBs4KJvnS+sGfLMhAnQFhrSOwOt9rb3MVudA06gtujTBGicVIOg5xbVlD4d7VOO6LVda3p1qyGzeNXDOmgMkc=
Message-ID: <4427FF42.8070100@gmail.com>
Date: Mon, 27 Mar 2006 23:05:38 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Matt Helsley <matthltc@us.ibm.com>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [2.6.16 PATCH] Filesystem Events Connector v4
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This release is v4, compared with v3, it adds and improve some functions:
	* The user can set event filter in order to just get 
	  those events who concerns, filter may be based on 
	  event mask, pid, uid and gid.
	* it removes the atomic_t variable cn_fs_listener and
	  adopt a smart way to decide whether it should send a
	  event.
	* Add several filter operation commands and acknowleges
	  , add a new struct fsevent_filter as command struct.

basically, these functions enable it to meet the user's requirements better,
 but, it can't do better because of connector broadcast property, I plan to
 use netlink to let different user see different events, filter is based on
 userspace appplication using it, every application can set its own filters
 and see different events.

 drivers/connector/Kconfig     |   12 +
 drivers/connector/Makefile    |    1 
 drivers/connector/cn_fs.c     |  298 +++++++++++++++++++++++++++++++++++++++++
 drivers/connector/connector.c |    4 
 fs/namespace.c                |   12 +
 include/linux/connector.h     |    8 -
 include/linux/fsevent.h       |  122 +++++++++++++++++
 include/linux/fsnotify.h      |   37 +++++
 8 files changed, 490 insertions(+), 4 deletions(-)

Signed-off-by: Yi Yang <yang.y.yi@gmail.com>

--- a/include/linux/connector.h.orig	2006-03-27 22:33:52.000000000 +0800
+++ b/include/linux/connector.h	2006-03-25 14:30:35.000000000 +0800
@@ -35,7 +35,13 @@
 #define CN_IDX_CIFS			0x2
 #define CN_VAL_CIFS                     0x1
 
-#define CN_NETLINK_USERS		1
+/*
+ * Filesystem Events Connector unique ids -- used for message routing
+ */
+#define CN_IDX_FS			0x3
+#define CN_VAL_FS			0x1
+
+#define CN_NETLINK_USERS		3
 
 /*
  * Maximum connector's message size.
--- a/include/linux/fsnotify.h.orig	2006-01-03 11:21:10.000000000 +0800
+++ b/include/linux/fsnotify.h	2006-03-25 14:30:35.000000000 +0800
@@ -15,6 +15,7 @@
 
 #include <linux/dnotify.h>
 #include <linux/inotify.h>
+#include <linux/fsevent.h>
 
 /*
  * fsnotify_move - file old_name at old_dir was moved to new_name at new_dir
@@ -45,6 +46,8 @@ static inline void fsnotify_move(struct 
 	if (source) {
 		inotify_inode_queue_event(source, IN_MOVE_SELF, 0, NULL);
 	}
+	raise_fsevent_move(old_dir, old_name, new_dir, new_name,
+			   FSEVENT_MOVE | (isdir?FSEVENT_ISDIR:0));
 }
 
 /*
@@ -56,6 +59,8 @@ static inline void fsnotify_nameremove(s
 		isdir = IN_ISDIR;
 	dnotify_parent(dentry, DN_DELETE);
 	inotify_dentry_parent_queue_event(dentry, IN_DELETE|isdir, 0, dentry->d_name.name);
+	raise_fsevent(dentry,
+		      FSEVENT_DELETE | (isdir?FSEVENT_ISDIR:0));
 }
 
 /*
@@ -74,6 +79,7 @@ static inline void fsnotify_create(struc
 {
 	inode_dir_notify(inode, DN_CREATE);
 	inotify_inode_queue_event(inode, IN_CREATE, 0, name);
+	raise_fsevent_create(inode, name, FSEVENT_CREATE);
 }
 
 /*
@@ -83,6 +89,8 @@ static inline void fsnotify_mkdir(struct
 {
 	inode_dir_notify(inode, DN_CREATE);
 	inotify_inode_queue_event(inode, IN_CREATE | IN_ISDIR, 0, name);
+	raise_fsevent_create(inode, name,
+			     FSEVENT_CREATE | FSEVENT_ISDIR);
 }
 
 /*
@@ -99,6 +107,8 @@ static inline void fsnotify_access(struc
 	dnotify_parent(dentry, DN_ACCESS);
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);
+	raise_fsevent(dentry, FSEVENT_ACCESS |
+				((S_ISDIR(inode->i_mode))?FSEVENT_ISDIR:0));
 }
 
 /*
@@ -115,6 +125,8 @@ static inline void fsnotify_modify(struc
 	dnotify_parent(dentry, DN_MODIFY);
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);
+	raise_fsevent(dentry, FSEVENT_MODIFY |
+				((S_ISDIR(inode->i_mode))?FSEVENT_ISDIR:0));
 }
 
 /*
@@ -130,6 +142,9 @@ static inline void fsnotify_open(struct 
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);	
+	raise_fsevent(dentry, FSEVENT_OPEN |
+				((S_ISDIR(inode->i_mode))?FSEVENT_ISDIR:0));
+
 }
 
 /*
@@ -148,6 +163,8 @@ static inline void fsnotify_close(struct
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);
+	raise_fsevent(dentry, FSEVENT_CLOSE |
+				((S_ISDIR(inode->i_mode))?FSEVENT_ISDIR:0));
 }
 
 /*
@@ -163,6 +180,8 @@ static inline void fsnotify_xattr(struct
 
 	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
 	inotify_inode_queue_event(inode, mask, 0, NULL);
+	raise_fsevent(dentry, FSEVENT_MODIFY_ATTRIB |
+				((S_ISDIR(inode->i_mode))?FSEVENT_ISDIR:0));
 }
 
 /*
@@ -213,6 +232,24 @@ static inline void fsnotify_change(struc
 		inotify_dentry_parent_queue_event(dentry, in_mask, 0,
 						  dentry->d_name.name);
 	}
+
+#ifdef CONFIG_FS_EVENTS
+	{
+	u32 fsevent_mask = 0;
+	if (ia_valid & (ATTR_UID | ATTR_GID | ATTR_MODE))
+		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
+	if ((ia_valid & ATTR_ATIME) && (ia_valid & ATTR_MTIME))
+		fsevent_mask |= FSEVENT_MODIFY_ATTRIB;
+	else if (ia_valid & ATTR_ATIME)
+		fsevent_mask |= FSEVENT_ACCESS;
+	else if (ia_valid & ATTR_MTIME)
+		fsevent_mask |= FSEVENT_MODIFY;
+	if (ia_valid & ATTR_SIZE)
+		fsevent_mask |= FSEVENT_MODIFY;
+	if (fsevent_mask)
+		raise_fsevent(dentry, fsevent_mask);
+	}
+#endif /* CONFIG_FS_EVENTS */
 }
 
 #ifdef CONFIG_INOTIFY	/* inotify helpers */
--- a/fs/namespace.c.orig	2006-03-25 23:13:42.000000000 +0800
+++ b/fs/namespace.c	2006-03-26 22:13:33.000000000 +0800
@@ -25,6 +25,7 @@
 #include <linux/mount.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
+#include <linux/fsevent.h>
 #include "pnode.h"
 
 extern int __init init_rootfs(void);
@@ -612,6 +613,13 @@ asmlinkage long sys_umount(char __user *
 		goto dput_and_out;
 
 	retval = do_umount(nd.mnt, flags);
+
+	if (retval == 0) {
+		char * tmp = getname(name);
+		raise_fsevent_umount(tmp);
+		putname(tmp);
+	}
+
 dput_and_out:
 	path_release_on_umount(&nd);
 out:
@@ -1459,6 +1467,10 @@ asmlinkage long sys_mount(char __user * 
 	retval = do_mount((char *)dev_page, dir_page, (char *)type_page,
 			  flags, (void *)data_page);
 	unlock_kernel();
+
+	if (retval == 0)
+		raise_fsevent_mount((char *)dev_page, dir_page);
+
 	free_page(data_page);
 
 out3:
--- a/drivers/connector/connector.c.orig	2006-03-27 21:35:15.000000000 +0800
+++ b/drivers/connector/connector.c	2006-03-27 21:35:53.000000000 +0800
@@ -111,9 +111,7 @@ int cn_netlink_send(struct cn_msg *msg, 
 
 	NETLINK_CB(skb).dst_group = group;
 
-	netlink_broadcast(dev->nls, skb, 0, group, gfp_mask);
-
-	return 0;
+	return (netlink_broadcast(dev->nls, skb, 0, group, gfp_mask));
 
 nlmsg_failure:
 	kfree_skb(skb);
--- a/drivers/connector/Kconfig.orig	2006-03-25 14:29:41.000000000 +0800
+++ b/drivers/connector/Kconfig	2006-03-27 22:41:23.000000000 +0800
@@ -18,4 +18,16 @@ config PROC_EVENTS
 	  Provide a connector that reports process events to userspace. Send
 	  events such as fork, exec, id change (uid, gid, suid, etc), and exit.
 
+config FS_EVENTS
+	boolean "Report filesystem events to userspace"
+	depends on CONNECTOR=y
+	default y
+	---help---
+	  Provide a connector that reports filesystem events to userspace. The
+	  reported event include access, write, utime, chmod, chown, chgrp,
+	  close, open, create, rename, unlink, mkdir, rmdir, mount, umount.
+
+	  The user can set filesystem events filter to filter its events, so
+	  that he just get those events he concerns.
+
 endmenu
--- a/drivers/connector/Makefile.orig	2006-03-25 14:29:53.000000000 +0800
+++ b/drivers/connector/Makefile	2006-03-25 14:30:35.000000000 +0800
@@ -1,4 +1,5 @@
 obj-$(CONFIG_CONNECTOR)		+= cn.o
 obj-$(CONFIG_PROC_EVENTS)	+= cn_proc.o
+obj-$(CONFIG_FS_EVENTS)	+= cn_fs.o
 
 cn-y				+= cn_queue.o connector.o
--- /dev/null	2003-01-30 18:24:37.000000000 +0800
+++ b/include/linux/fsevent.h	2006-03-27 21:43:27.000000000 +0800
@@ -0,0 +1,122 @@
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
+	FSEVENT_MOUNT =		0x00000100,	/* File system is mounted */
+	FSEVENT_UMOUNT =	0x00000200,	/* File system is umounted */
+
+	/* The following definitions are commands for event filter
+	 * , in acknowlege event for the corresponding command, it
+	 * will set to type field of struct fsevent.
+	*/
+	FSEVENT_FILTER_ALL = 	0x08000000,	/* For all events */
+	FSEVENT_FILTER_PID = 	0x10000000,	/* For some process ID */
+	FSEVENT_FILTER_UID = 	0x20000000,	/* For some user ID */
+	FSEVENT_FILTER_GID =	0x40000000,	/* For some group ID */
+
+	FSEVENT_ISDIR = 	0x80000000	/* It is set for a dir */
+};
+
+#define FSEVENT_MASK 0x800003ff
+
+typedef unsigned long fsevent_mask_t;
+
+struct fsevent_filter {
+	/* filter type, it just is one or bit-or of them
+	 * FSEVENT_FILTER_ALL
+	 * FSEVENT_FILTER_PID
+	 * FSEVENT_FILTER_UID
+	 * FSEVENT_FILTER_GID
+	 */
+	enum fsevent_type type;	/* filter type */
+
+	/* mask of file system events the user listen or ignore
+	 * if the user need to ignore all the events of some pid
+	 * , gid or uid, he(she) must set mask to FSEVENT_MASK.
+	 */ 
+	fsevent_mask_t mask;
+	pid_t pid;
+	uid_t uid;
+	gid_t gid;
+
+	/* listen or ignore: 0 -> listen, 1 -> ignore */
+	int control;
+};
+
+struct fsevent {
+	__u32 type;
+	__u32 cpu;
+	struct timespec timestamp;
+	pid_t tgid;
+	uid_t uid;
+	gid_t gid;
+	int err;
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
+extern void raise_fsevent_move(struct inode * olddir, const char * oldname, 
+		struct inode * newdir, const char * newname, u32 mask);
+extern void raise_fsevent_create(struct inode * inode, 
+		const char * name, u32 mask);
+extern void raise_fsevent_mount(const char * devname, const char * mountpoint);
+extern void raise_fsevent_umount(const char * mountpoint);
+#else
+static void raise_fsevent(struct dentry * dentryp,  u32 mask)
+{}
+
+static void raise_fsevent_move(struct inode * olddir, const char * oldname, 
+		struct inode * newdir, const char * newname, u32 mask)
+{}
+
+static void raise_fsevent_create(struct inode * inode, 
+		const char * name, u32 mask)
+{}
+
+static void raise_fsevent_mount(const char * devname, const char * mountpoint)
+{}
+
+static void raise_fsevent_umount(const char * mountpoint)
+{}
+#endif	/* CONFIG_FS_EVENTS */
+#endif	/* __KERNEL__ */
+#endif	/* LINUX_FSEVENT_H */
--- /dev/null	2003-01-30 18:24:37.000000000 +0800
+++ b/drivers/connector/cn_fs.c	2006-03-27 22:26:32.000000000 +0800
@@ -0,0 +1,298 @@
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
+static struct cb_id cn_fs_event_id = { CN_IDX_FS, CN_VAL_FS };
+
+static DEFINE_PER_CPU(__u32, cn_fs_event_counts) = { 0 };
+static int fsevent_burst_limit = 100;
+static int fsevent_ratelimit = 5 * HZ;
+static unsigned long last = 0;
+static int fsevent_sum = 0;
+static u32 fsevents_mask = 0;
+static u32 fsevents_pid_mask = 0;
+static pid_t filter_pid = -1;
+static u32 fsevents_uid_mask = 0;
+static uid_t filter_uid = -1;
+static u32 fsevents_gid_mask = 0;
+static gid_t filter_gid = -1;
+static DEFINE_RWLOCK(fsevents_lock);
+
+static inline void get_seq(__u32 *ts, int *cpu)
+{
+	*ts = get_cpu_var(cn_fs_event_counts)++;
+	*cpu = smp_processor_id();
+	put_cpu_var(cn_fs_event_counts);
+}
+
+static void append_string(char **dest, const char *src, size_t len)
+{
+	strncpy(*dest, src, len);
+	(*dest)[len] = '\0';
+	*dest += len + 1;
+}
+
+static void turn_off_fsevents(void)
+{
+	write_lock(&fsevents_lock);
+	fsevents_mask = 0;
+	fsevents_pid_mask = 0;
+	filter_pid = -1;
+	fsevents_uid_mask = 0;
+	filter_uid = -1;
+	fsevents_gid_mask = 0;
+	filter_gid = -1;
+	write_unlock(&fsevents_lock);
+}
+
+static int filter_fsevents(u32 * mask)
+{
+	int ret = 0;
+
+	(*mask) &= FSEVENT_MASK;
+	read_lock(&fsevents_lock);
+	if (current->pid == filter_pid) {
+		(*mask) &= fsevents_pid_mask;
+		if ((*mask) == 0) {
+			ret = -2;
+		}
+		goto release_lock;
+	}
+			
+	if (current->uid == filter_uid) {
+		(*mask) &= fsevents_uid_mask;
+		if ((*mask) == 0) {
+			ret = -3;
+		}
+		goto release_lock;
+	}
+		
+	if (current->gid == filter_gid) {
+		(*mask) &= fsevents_gid_mask;
+		if ((*mask) == 0) {
+			ret = -4;
+		}
+		goto release_lock;
+	}
+
+	if ((((*mask) & FSEVENT_ISDIR) == FSEVENT_ISDIR)
+		 & ((fsevents_mask & FSEVENT_ISDIR) == 0)) {
+		ret = -1;
+		goto release_lock;
+	}
+
+	(*mask) &= fsevents_mask;
+	if ((*mask) == 0) {
+		ret = -5;
+	}
+
+release_lock:
+	read_unlock(&fsevents_lock);
+	return ret;
+}
+
+int __raise_fsevent(const char * oldname, const char * newname, u32 mask)
+{
+	struct cn_msg *msg;
+	struct fsevent *event;
+	char * buffer;
+	int namelen = 0;
+	char * nameptr = NULL;
+	int ret;
+
+	if (filter_fsevents(&mask) != 0)
+		return -1;
+
+	if (jiffies - last <= fsevent_ratelimit) {
+		if (fsevent_sum > fsevent_burst_limit)
+			return -2;
+		fsevent_sum++;
+	} else {
+		last = jiffies;
+		fsevent_sum = 0;
+	}
+
+	namelen = strlen(current->comm) + strlen(oldname) + 2;
+	if (newname)
+		namelen += strlen(newname) + 1;
+
+	buffer = kmalloc(CN_FS_MSG_SIZE + namelen, GFP_KERNEL);
+	if (buffer == NULL)
+		return -1;
+
+	msg = (struct cn_msg*)buffer;
+	event = (struct fsevent*)msg->data;
+	get_seq(&msg->seq, &event->cpu);
+	ktime_get_ts(&event->timestamp);
+	event->type = mask;
+	event->tgid = current->tgid;
+	event->uid = current->uid;
+	event->gid = current->gid;
+	nameptr = event->name;
+	event->pname_len = strlen(current->comm);
+	append_string(&nameptr, current->comm, event->pname_len);
+	event->fname_len = strlen(oldname);
+	append_string(&nameptr, oldname, event->fname_len);
+	event->len = event->pname_len +  event->fname_len + 2;
+	event->new_fname_len = 0;
+	if (newname) {
+		event->new_fname_len = strlen(newname);
+		 append_string(&nameptr, newname, event->new_fname_len);
+		event->len += event->new_fname_len + 1;
+	}
+
+	memcpy(&msg->id, &cn_fs_event_id, sizeof(msg->id));
+	msg->ack = 0;
+	msg->len = sizeof(struct fsevent) + event->len;
+	ret = cn_netlink_send(msg, CN_IDX_FS, GFP_KERNEL);
+	if (ret == -ESRCH) {
+		turn_off_fsevents();
+	}
+	kfree(buffer);
+	return 0;
+}
+
+void raise_fsevent(struct dentry * dentryp, u32 mask)
+{
+	if (dentryp->d_inode && (MAJOR(dentryp->d_inode->i_rdev) == 4))
+		return;
+	__raise_fsevent(dentryp->d_name.name, NULL, mask);
+}
+EXPORT_SYMBOL_GPL(raise_fsevent);
+
+void raise_fsevent_create(struct inode * inode, const char * name, u32 mask)
+{
+	read_lock(&fsevents_lock);
+	__raise_fsevent(name, NULL, mask);
+}
+EXPORT_SYMBOL_GPL(raise_fsevent_create);
+
+void raise_fsevent_move(struct inode * olddir, const char * oldname, 
+		struct inode * newdir, const char * newname, u32 mask)
+{
+	__raise_fsevent(oldname, newname, mask);
+}
+EXPORT_SYMBOL_GPL(raise_fsevent_move);
+
+void raise_fsevent_mount(const char * devname, const char * mountpoint)
+{
+	__raise_fsevent(devname, mountpoint, FSEVENT_MOUNT);
+}
+
+void raise_fsevent_umount(const char * mountpoint)
+{
+	__raise_fsevent(mountpoint, NULL, FSEVENT_UMOUNT);
+}
+
+static void cn_fs_event_ack(enum fsevent_type type, int rcvd_seq, int rcvd_ack)
+{
+	struct cn_msg *msg;
+	struct fsevent *event;
+	char * buffer = NULL;
+
+	buffer = kmalloc(CN_FS_MSG_SIZE, GFP_KERNEL);
+	if (buffer == NULL)
+		return;
+
+	msg = (struct cn_msg*)buffer;
+	event = (struct fsevent*)msg->data;
+	msg->seq = rcvd_seq;
+	ktime_get_ts(&event->timestamp);
+	event->cpu = -1;
+	event->type = type; 
+	event->tgid = 0;
+	event->uid = 0;
+	event->gid = 0;
+	event->len = 0;
+	event->pname_len = 0;
+	event->fname_len = 0;
+	event->new_fname_len = 0;
+	event->err = 0;
+	memcpy(&msg->id, &cn_fs_event_id, sizeof(msg->id));
+	msg->ack = rcvd_ack + 1;
+	msg->len = sizeof(struct fsevent);
+	cn_netlink_send(msg, CN_IDX_FS, GFP_KERNEL);
+}
+static void set_fsevents_mask(u32 * to_mask, u32 from_mask, int mode)
+{
+	write_lock(&fsevents_lock);	
+	if (mode)
+		(*to_mask) &= ~(from_mask);
+	else
+		(*to_mask) |= from_mask;
+	write_unlock(&fsevents_lock);	
+}
+
+static void cn_fsevent_filter_ctl(void *data)
+{
+	struct cn_msg *msg = data;
+	struct fsevent_filter *filter = NULL;
+	enum fsevent_type type;
+	u32 mask = 0;
+	int control = 0;
+
+	if (msg->len != sizeof(*filter))
+		return;
+
+	filter = (struct fsevent_filter *)msg->data;
+	mask = filter->mask;
+	control = filter->control;
+	mask &= FSEVENT_MASK;
+	type = filter->type;
+	if ((type & FSEVENT_FILTER_ALL) == FSEVENT_FILTER_ALL)
+		set_fsevents_mask(&fsevents_mask, mask, control); 
+	if ((type & FSEVENT_FILTER_PID) == FSEVENT_FILTER_PID) {
+		set_fsevents_mask(&fsevents_pid_mask, mask, control);
+		filter_pid = filter->pid;
+	}
+	if ((type & FSEVENT_FILTER_UID) == FSEVENT_FILTER_UID) {
+		set_fsevents_mask(&fsevents_uid_mask, mask, control);
+		filter_uid = filter->uid;
+	}
+	if ((type & FSEVENT_FILTER_GID) == FSEVENT_FILTER_GID) {
+		set_fsevents_mask(&fsevents_gid_mask, mask, control);
+		filter_gid = filter->gid;
+	}
+	cn_fs_event_ack(type, msg->seq, msg->ack);
+}
+
+static int __init cn_fs_init(void)
+{
+	int err;
+
+	if ((err = cn_add_callback(&cn_fs_event_id, "cn_fs",
+	 			   &cn_fsevent_filter_ctl))) {
+		printk(KERN_WARNING "cn_fs failed to register\n");
+		return err;
+	}
+	return 0;
+}
+
+module_init(cn_fs_init);


