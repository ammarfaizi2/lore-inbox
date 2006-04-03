Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbWDCO20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWDCO20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 10:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWDCO20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 10:28:26 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:18589 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751445AbWDCO2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 10:28:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=sJu+dm3yonDja8OQ8zM4b+jmKttExiaig7KLCV9BEQyMl+Zs5EJOvIBxES9rjU4781MxN3uEKqAMPEUKaTBiSrFiTHQnfe5RV3IgJ6/FKLEPl3SbXqoH2l1byUzHAIoVLgGT/jZKDbJ3sYv10qyU37pl9KtOnGmW7lumdtHaO2k=
Message-ID: <443130FA.6020006@gmail.com>
Date: Mon, 03 Apr 2006 22:28:10 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Matt Helsley <matthltc@us.ibm.com>
Subject: [2.6.16 PATCH] Filesystem Events Reporter v1
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has some very big changes with comparison to Filesystem Events Connector v4, 
the following features are added newly:

	- Use netlink instead of connector. 
	- Every application using fsevent can set its own fsevent filter list 
	  without effect in other applications using fsevent, there are three
	  filter lists, they are pid filter list, uid filetr list and gid 
	  filter list, respectively, moreover, there is a fsevent mask used to
	  control those fsevents which fail to match  three filter lists, an 
	  application using fsevent can listen those fsevents it want to 
	  monitor and ignore those fsevents it doesn't interest in by set 
	  series of filters, there is a fsevent mask used to take effects on
	  all the applications using fsevent, it can be set by sysctl and proc
	  interface(not implemented).
	- Remove lock race overhead and file system code path delay completely
	  by a per cpu fsevent queue and kthread per cpu, fsevent_send just 
	  mallocs a skb and insert the percpu queue and wake up fseventd 
	  kthread, then return immediately, fseventd per cpu is responsible for
	  send fsevent to userspace application.

 fs/Kconfig               |   10 
 fs/Makefile              |    1 
 fs/fsevent.c             |  642 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/namespace.c           |   12 
 include/linux/fsevent.h  |  132 +++++++++
 include/linux/fsnotify.h |   37 ++
 include/linux/netlink.h  |    3 
 7 files changed, 836 insertions(+), 1 deletion(-)

Signed-off-by: Yi Yang <yang.y.yi@gmail.com>

--- a/include/linux/netlink.h.orig	2006-03-31 22:58:50.000000000 +0800
+++ b/include/linux/netlink.h	2006-03-31 23:00:22.000000000 +0800
@@ -20,7 +20,8 @@
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
 #define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
-#define NETLINK_GENERIC		16
+#define NETLINK_FSEVENT		16	/* File system events to userspace */
+#define NETLINK_GENERIC		17
 
 #define MAX_LINKS 32		
 
--- a/include/linux/fsnotify.h.orig	2006-01-03 11:21:10.000000000 +0800
+++ b/include/linux/fsnotify.h	2006-03-27 23:09:18.000000000 +0800
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
+++ b/fs/namespace.c	2006-03-27 23:09:18.000000000 +0800
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
--- a/fs/Kconfig.orig	2006-03-31 21:23:20.000000000 +0800
+++ b/fs/Kconfig	2006-04-03 22:01:17.000000000 +0800
@@ -405,6 +405,16 @@ config INOTIFY
 
 	  If unsure, say Y.
 
+config FS_EVENTS
+	tristate "Report filesystem events to userspace"
+	---help---
+	  Provide a facility that reports filesystem events to userspace. The
+	  reported event include access, write, utime, chmod, chown, chgrp,
+	  close, open, create, rename, unlink, mkdir, rmdir, mount, umount.
+
+	  The user can set filesystem events filter to filter its events, so
+	  that he just get those events he concerns.
+
 config QUOTA
 	bool "Quota support"
 	help
--- a/fs/Makefile.orig	2006-03-31 21:23:33.000000000 +0800
+++ b/fs/Makefile	2006-03-31 21:30:58.000000000 +0800
@@ -13,6 +13,7 @@ obj-y :=	open.o read_write.o file_table.
 		ioprio.o pnode.o drop_caches.o
 
 obj-$(CONFIG_INOTIFY)		+= inotify.o
+obj-$(CONFIG_FS_EVENTS)		+= fsevent.o
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
 obj-$(CONFIG_COMPAT)		+= compat.o compat_ioctl.o
 
--- /dev/null	2003-01-30 18:24:37.000000000 +0800
+++ b/include/linux/fsevent.h	2006-04-02 01:35:04.000000000 +0800
@@ -0,0 +1,132 @@
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
+#include <linux/netlink.h>
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
+enum filter_control {
+	FSEVENT_FILTER_LISTEN = 1,		/* Listen fsevents mask defines*/
+	FSEVENT_FILTER_IGNORE ,		/* Ignore fsevents mask defines*/
+	FSEVENT_FILTER_REMOVE,			/* Remove a given filter */
+};	
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
+	union {
+		pid_t pid;
+		uid_t uid;
+		gid_t gid;
+	} id;
+
+	enum filter_control control;
+};
+
+struct fsevent {
+	__u32 type;
+	__u32 cpu;
+	struct timespec timestamp;
+	pid_t pid;
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
+#define FSEVENT_FILTER_MSGSIZE \
+	(sizeof(struct fsevent_filter) + sizeof(struct nlmsghdr))
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
+++ b/fs/fsevent.c	2006-04-02 23:10:45.000000000 +0800
@@ -0,0 +1,642 @@
+/*
+ * 	fsevent.c
+ * 
+ * 2006 Copyright (c) Yi Yang <yang.y.yi@gmail.com>
+ * All rights reserved.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/moduleparam.h>
+#include <linux/fsevent.h>
+#include <linux/skbuff.h>
+#include <net/sock.h>
+#include <linux/list.h>
+#include <linux/percpu.h>
+#include <linux/cpu.h>
+#include <linux/kthread.h>
+#include <linux/notifier.h>
+#include <linux/compiler.h>
+
+static DEFINE_PER_CPU(struct sk_buff_head, fsevent_send_queue);
+static DEFINE_PER_CPU(task_t *, kfseventd_task);
+
+typedef struct pid_filter {
+	pid_t pid;
+	u32 mask;
+	struct list_head list;
+} pid_filter;
+
+typedef struct uid_filter {
+	uid_t uid;
+	u32 mask;
+	struct list_head list;
+} uid_filter;
+
+typedef struct gid_filter {
+	gid_t gid;
+	u32 mask;
+	struct list_head list;
+} gid_filter;
+
+typedef struct fsevent_listener {
+	pid_t pid;
+	struct list_head pid_filter_list_head;
+	struct list_head uid_filter_list_head;
+	struct list_head gid_filter_list_head;
+	u32 mask;
+	struct list_head list;
+} listener;
+
+	
+/* The netlink socket. */
+static struct sock * fsevent_sock = NULL;
+static LIST_HEAD(listener_list_head);
+static DEFINE_SPINLOCK(listener_list_lock);
+
+static DEFINE_PER_CPU(__u32, cn_fs_event_counts) = { 0 };
+static int fsevent_burst_limit = 100;
+static int fsevent_ratelimit = 5 * HZ;
+static unsigned long last = 0;
+static int fsevent_sum = 0;
+static u32 fsevents_mask = FSEVENT_MASK;
+static atomic_t fsevent_listener_num = ATOMIC_INIT(0);
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
+static inline int filter_fsevent(u32 filter_mask, u32 event_mask)
+{
+	event_mask &= FSEVENT_MASK;
+	event_mask &= filter_mask;
+	if (event_mask == 0) {
+		return -1;
+	}
+	return 0;
+}
+
+static int filter_fsevent_all(u32 * mask)
+{
+	int ret = 0;
+
+	(*mask) &= FSEVENT_MASK;
+
+	if ((((*mask) & FSEVENT_ISDIR) == FSEVENT_ISDIR)
+		 && ((fsevents_mask & FSEVENT_ISDIR) == 0)) {
+		ret = -1;
+		goto out;
+	}
+
+	(*mask) &= fsevents_mask;
+	if ((*mask) == 0) {
+		ret = -5;
+	}
+
+out:
+	return ret;
+}
+
+static void fsevent_send(struct sk_buff * skb)
+{
+	struct sk_buff_head * head = &get_cpu_var(fsevent_send_queue);
+	skb_queue_tail(head, skb);
+	wake_up_process(per_cpu(kfseventd_task, smp_processor_id()));
+	put_cpu_var(fsevent_send_queue);
+}
+
+int __raise_fsevent(const char * oldname, const char * newname, u32 mask)
+{
+	struct fsevent *event;
+	int namelen = 0;
+	char * nameptr = NULL;
+	unsigned int size;
+	struct nlmsghdr * nlhdr;
+	struct sk_buff * skb = NULL;
+
+	if (filter_fsevent_all(&mask) != 0)
+		return -1;
+
+	if (atomic_read(&fsevent_listener_num) <= 0)
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
+	size = NLMSG_SPACE(sizeof(struct fsevent) + namelen);
+	                                                                                                                                       
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+	        return -ENOMEM;
+	                                                                                                                                       
+	nlhdr = NLMSG_PUT(skb, 0, 0, NLMSG_DONE, size - sizeof(*nlhdr));
+	event = NLMSG_DATA(nlhdr);
+
+	get_seq(&(nlhdr->nlmsg_seq), &event->cpu);
+	ktime_get_ts(&event->timestamp);
+	event->type = mask;
+	event->pid = current->tgid;
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
+		append_string(&nameptr, newname, event->new_fname_len);
+		event->len += event->new_fname_len + 1;
+	}
+	fsevent_send(skb);
+	return 0;
+
+nlmsg_failure:
+	kfree_skb(skb);
+	return -1;
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
+static int fsevent_ack(enum fsevent_type type, pid_t pid, u32 seq)
+{
+	struct fsevent *event;
+	unsigned int size;
+	struct sk_buff * skb = NULL;
+	struct nlmsghdr * nlhdr = NULL;
+
+	size = NLMSG_SPACE(sizeof(struct fsevent));
+	                                                                                                                                       
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+	        return -ENOMEM;
+	                                                                                                                                       
+	nlhdr = NLMSG_PUT(skb, 0, seq, NLMSG_DONE, size - sizeof(*nlhdr));
+	event = NLMSG_DATA(nlhdr);
+
+	ktime_get_ts(&event->timestamp);
+	event->cpu = -1;
+	event->type = type; 
+	event->pid = 0;
+	event->uid = 0;
+	event->gid = 0;
+	event->len = 0;
+	event->pname_len = 0;
+	event->fname_len = 0;
+	event->new_fname_len = 0;
+	event->err = 0;
+	                                                                                                                                       
+	NETLINK_CB(skb).dst_group = 0;
+	NETLINK_CB(skb).dst_pid = pid;
+	NETLINK_CB(skb).pid = 0;
+
+	return (netlink_unicast(fsevent_sock, skb, pid, MSG_DONTWAIT));
+
+nlmsg_failure:
+	kfree_skb(skb);
+	return -1;
+}
+
+static void set_fsevent_mask(u32 * to_mask, u32 from_mask, int mode)
+{
+	if (mode == FSEVENT_FILTER_IGNORE)
+		(*to_mask) &= ~(from_mask);
+	else if (mode == FSEVENT_FILTER_LISTEN)
+		(*to_mask) |= from_mask;
+}
+
+#define DEFINE_FILTER_FIND_FUNC(type, key) 				\
+	type * find_##type(struct list_head * head, key##_t id)		\
+	{								\
+		int alloc_flag = 1;					\
+		type * entry = NULL;					\
+									\
+		list_for_each_entry(entry, head, list) {		\
+			if (entry->key == id) {				\
+				alloc_flag = 0;				\
+				break;					\
+			}						\
+		}							\
+									\
+		if (alloc_flag == 1) {					\
+			entry  = (type *)kmalloc(sizeof(type), GFP_KERNEL); \
+			if (entry == NULL) 				\
+				return NULL;				\
+			memset(entry, 0, sizeof(type));			\
+			entry->key = id;				\
+			list_add_tail(&(entry->list), head);		\
+		}							\
+		return entry;						\
+	}								\
+
+DEFINE_FILTER_FIND_FUNC(pid_filter, pid)
+
+DEFINE_FILTER_FIND_FUNC(uid_filter, uid)
+
+DEFINE_FILTER_FIND_FUNC(gid_filter, gid)
+		
+DEFINE_FILTER_FIND_FUNC(listener, pid)
+
+static void set_fsevent_filter(struct fsevent_filter * filter, pid_t pid)
+{
+	enum fsevent_type type;
+	u32 mask = 0;
+	int control = 0;
+	listener * listenerp = NULL;
+	pid_filter * pfilter = NULL;
+	uid_filter * ufilter = NULL;
+	gid_filter * gfilter = NULL;
+
+
+	mask = filter->mask;
+	control = filter->control;
+	type = filter->type;
+	mask &= FSEVENT_MASK;
+	if (mask == 0)
+		goto out;
+
+	spin_lock(&listener_list_lock);
+	listenerp = find_listener(&listener_list_head, pid);
+	if (unlikely(listenerp == NULL)) {
+		spin_unlock(&listener_list_lock);
+		return;
+	}
+
+	if (!(listenerp->pid_filter_list_head.next)) {
+		INIT_LIST_HEAD(&(listenerp->pid_filter_list_head));
+		INIT_LIST_HEAD(&(listenerp->uid_filter_list_head));
+		INIT_LIST_HEAD(&(listenerp->gid_filter_list_head));
+	}
+	spin_unlock(&listener_list_lock);
+
+	if ((type & FSEVENT_FILTER_ALL) == FSEVENT_FILTER_ALL) {
+		if (control == FSEVENT_FILTER_REMOVE) {
+			atomic_dec(&fsevent_listener_num);
+			spin_lock(&listener_list_lock);
+			list_del(&(listenerp->list));
+			spin_unlock(&listener_list_lock);
+			kfree(listenerp);
+		} else
+			set_fsevent_mask(&(listenerp->mask), mask, control);
+	}
+		
+
+	if ((type & FSEVENT_FILTER_PID) == FSEVENT_FILTER_PID) {
+		pfilter = find_pid_filter(&(listenerp->pid_filter_list_head),
+				filter->id.pid);
+		if (unlikely(pfilter == NULL))
+			return;
+
+		if (control == FSEVENT_FILTER_REMOVE) {
+			list_del(&(pfilter->list));
+			kfree(pfilter);
+		} else
+			set_fsevent_mask(&(pfilter->mask), mask, control);
+	}
+
+	if ((type & FSEVENT_FILTER_UID) == FSEVENT_FILTER_UID) {
+		ufilter = find_uid_filter(&(listenerp->uid_filter_list_head),
+						filter->id.uid);
+		if (unlikely(ufilter == NULL))
+			return;
+
+		if (control == FSEVENT_FILTER_REMOVE) {
+			list_del(&(ufilter->list));
+			kfree(ufilter);
+		} else
+			set_fsevent_mask(&(ufilter->mask), mask, control);
+	}
+
+	if ((type & FSEVENT_FILTER_GID) == FSEVENT_FILTER_GID) {
+		gfilter = find_gid_filter(&(listenerp->gid_filter_list_head),
+						filter->id.gid);
+		if (unlikely(gfilter == NULL))
+			return;
+
+		if (control == FSEVENT_FILTER_REMOVE) {
+			list_del(&(gfilter->list));
+			kfree(gfilter);
+		} else
+			set_fsevent_mask(&(gfilter->mask), mask, control);
+	}
+
+out:
+	fsevent_ack(type, pid, 0);
+}
+
+static listener * find_fsevent_listener(pid_t pid)
+{
+	listener * listenerp = NULL;
+	spin_lock(&listener_list_lock);
+	list_for_each_entry(listenerp, &listener_list_head, list) {
+		if (listenerp->pid == pid) {
+			spin_unlock(&listener_list_lock);
+			return listenerp;
+		}
+	}
+	spin_unlock(&listener_list_lock);
+	return NULL;
+}
+
+static void cleanup_dead_listener(listener * x)
+{
+	pid_filter * p = NULL, * pq = NULL;
+	uid_filter * u = NULL, * uq = NULL;
+	gid_filter * g = NULL, * gq = NULL;
+
+	if (p == NULL)
+		return;
+
+	list_del(&(x->list));
+
+	list_for_each_entry_safe(p, pq, &(x->pid_filter_list_head), list) {
+		list_del(&(p->list));
+		kfree(p);
+	}
+
+	list_for_each_entry_safe(u, uq, &(x->uid_filter_list_head), list) {
+		list_del(&(u->list));
+		kfree(u);
+	}
+
+	list_for_each_entry_safe(g, gq, &(x->gid_filter_list_head), list) {
+		list_del(&(g->list));
+		kfree(g);
+	}
+	
+	kfree(x);
+}
+
+static void fsevent_recv(struct sock *sk, int len)
+{
+	struct sk_buff *skb = NULL;
+	struct nlmsghdr *nlhdr = NULL;
+	struct fsevent_filter * filter = NULL;
+	pid_t pid;
+
+	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
+		skb_get(skb);
+		if (skb->len >= FSEVENT_FILTER_MSGSIZE) {
+			nlhdr = (struct nlmsghdr *)skb->data;
+			filter = NLMSG_DATA(nlhdr);
+			pid = NETLINK_CREDS(skb)->pid;
+			if (find_fsevent_listener(pid) == NULL)
+				atomic_inc(&fsevent_listener_num);
+			set_fsevent_filter(filter, pid);
+		}
+		kfree_skb(skb);
+	}
+}
+
+#define DEFINE_FILTER_MATCH_FUNC(filtertype, key) 			\
+	static int match_##filtertype(listener * p,			\
+				struct fsevent * event,			\
+				struct sk_buff * skb)			\
+	{								\
+		int ret = 0;						\
+		filtertype * xfilter = NULL;				\
+		struct sk_buff * skb2 = NULL;				\
+		struct list_head *  head = &(p->key##_filter_list_head);  \
+		list_for_each_entry(xfilter, head, list) {		\
+			if (xfilter->key != event->key)			\
+				continue;				\
+			ret = filter_fsevent(xfilter->mask, event->type); \
+			if ( ret != 0)					\
+				return -1;				\
+			skb2 = skb_clone(skb, GFP_KERNEL);		\
+       			if (skb2 == NULL)				\
+				return -ENOMEM;				\
+			NETLINK_CB(skb2).dst_group = 0;			\
+			NETLINK_CB(skb2).dst_pid = p->pid;		\
+			NETLINK_CB(skb2).pid = 0;			\
+			return (netlink_unicast(fsevent_sock, skb2,	\
+					p->pid, MSG_DONTWAIT));		\
+		}							\
+		return -ENODEV;						\
+	}								\
+
+DEFINE_FILTER_MATCH_FUNC(pid_filter, pid)
+
+DEFINE_FILTER_MATCH_FUNC(uid_filter, uid)
+
+DEFINE_FILTER_MATCH_FUNC(gid_filter, gid)
+
+#define MATCH_XID(key, listenerp, event, skb) 			\
+	ret = match_##key##_filter(listenerp, event, skb); 	\
+	if (ret == 0) {					 	\
+		kfree_skb(skb);				 	\
+	        continue;				 	\
+	}						 	\
+	do {} while (0)					 	\
+
+static int fsevent_send_to_process(struct sk_buff * skb)
+{
+	listener * p  = NULL, * q = NULL;
+	struct fsevent * event = NULL;
+	struct sk_buff * skb2 = NULL;
+	int ret = 0;
+
+	event = (struct fsevent *)(skb->data + sizeof(struct nlmsghdr));
+	spin_lock(&listener_list_lock);
+	list_for_each_entry_safe(p, q, &listener_list_head, list) {
+		MATCH_XID(pid, p, event, skb);
+		MATCH_XID(uid, p, event, skb);
+		MATCH_XID(gid, p, event, skb);
+
+		if (filter_fsevent(p->mask, event->type) == 0) {
+			 skb2 = skb_clone(skb, GFP_KERNEL);
+	                 if (skb2 == NULL)
+	                 	return -ENOMEM;
+	                 NETLINK_CB(skb2).dst_group = 0;
+	                 NETLINK_CB(skb2).dst_pid = p->pid;
+	                 NETLINK_CB(skb2).pid = 0;
+	                 ret = netlink_unicast(fsevent_sock, skb2,
+	                                p->pid, MSG_DONTWAIT);
+			if (ret == -ECONNREFUSED) {
+				atomic_dec(&fsevent_listener_num);
+				cleanup_dead_listener(p);
+			}
+		}
+	}
+	spin_unlock(&listener_list_lock);
+	return ret;
+}
+
+static int kfseventd(void * bind_to_cpu)
+{
+	struct sk_buff * skb = NULL;
+	//int cpu = (unsigned long) bind_to_cpu;
+	current->flags |= PF_NOFREEZE;
+        set_current_state(TASK_INTERRUPTIBLE);
+
+	while (!kthread_should_stop()) {
+		
+		while((skb = skb_dequeue(&get_cpu_var(fsevent_send_queue)))
+			!= NULL) {
+			fsevent_send_to_process(skb);
+			put_cpu_var(fsevent_send_queue);
+		}
+        	set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+		set_current_state(TASK_RUNNING);
+	}
+	set_current_state(TASK_RUNNING);
+	return 0;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void takeover_fsevent(void * hcpu)
+{
+	struct sk_buff * skb = NULL;
+	int hotcpu = (unsigned long)hcpu;
+	struct sk_buff_head * fsevent_queue =
+			&per_cpu(fsevent_send_queue, hotcpu);
+
+	while((skb = skb_dequeue(fsevent_queue)) != NULL) {
+                fsevent_send_to_process(skb);
+        }
+}
+#endif
+	
+
+static int __devinit cpu_callback(struct notifier_block *nfb,
+                                  unsigned long action,
+                                  void *hcpu)
+{
+        int hotcpu = (unsigned long)hcpu;
+        struct task_struct *p;
+                                                                                                                                               
+        switch (action) {
+        case CPU_UP_PREPARE:
+                p = kthread_create(kfseventd, hcpu, "kfseventd/%d", hotcpu);
+                if (IS_ERR(p)) {
+                        printk("kfseventd for %i failed\n", hotcpu);
+                        return NOTIFY_BAD;
+                }
+                kthread_bind(p, hotcpu);
+                per_cpu(kfseventd_task, hotcpu) = p;
+                break;
+        case CPU_ONLINE:
+                wake_up_process(per_cpu(kfseventd_task, hotcpu));
+                break;
+#ifdef CONFIG_HOTPLUG_CPU
+        case CPU_UP_CANCELED:
+                /* Unbind so it can run.  Fall thru. */
+                kthread_bind(per_cpu(kfseventd, hotcpu),
+                             any_online_cpu(cpu_online_map));
+        case CPU_DEAD:
+                p = per_cpu(kfseventd, hotcpu);
+                per_cpu(kfseventd, hotcpu) = NULL;
+                kthread_stop(p);
+                takeover_fsevent(hotcpu);
+                break;
+#endif /* CONFIG_HOTPLUG_CPU */
+        }
+        return NOTIFY_OK;
+}
+
+static struct notifier_block __devinitdata cpu_nfb = {
+        .notifier_call = cpu_callback
+};
+
+static int __init fsevent_init(void)
+{
+	int cpu;
+	struct sk_buff_head * listptr;
+	void * hotcpu;
+
+	fsevent_sock = netlink_kernel_create(NETLINK_FSEVENT, 0,
+					 fsevent_recv, THIS_MODULE);
+	if (!fsevent_sock)
+		return -EIO;
+	for_each_cpu(cpu) {
+		listptr = &per_cpu(fsevent_send_queue, cpu);
+		skb_queue_head_init(listptr);
+	}
+
+	hotcpu = (void *)(long)smp_processor_id();
+	cpu_callback(&cpu_nfb, CPU_UP_PREPARE, hotcpu);
+	cpu_callback(&cpu_nfb, CPU_ONLINE, hotcpu);
+	register_cpu_notifier(&cpu_nfb);
+
+	return 0;
+}
+
+static void __exit fsevent_exit(void)
+{
+	sock_release(fsevent_sock->sk_socket);
+}
+
+module_init(fsevent_init);
+module_exit(fsevent_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yi Yang <yang.y.yi@gmail.com>");
+MODULE_DESCRIPTION("File System Events Reporter");


