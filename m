Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVFMUtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVFMUtI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVFMUtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:49:08 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:51087 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261289AbVFMUpL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:45:11 -0400
Subject: Re: [RFC][PATCH] filesystem auditing by location+name
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Steve Grubb <sgrubb@redhat.com>,
       Stephen Smalley <sds@tycho.nsa.gov>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Mounir Bsaibes <bsaibes@us.ibm.com>
In-Reply-To: <20050610232809.GC9046@shell0.pdx.osdl.net>
References: <200506101728.25709.tinytim@us.ibm.com>
	 <20050610232809.GC9046@shell0.pdx.osdl.net>
Content-Type: text/plain
Organization: IBM
Date: Mon, 13 Jun 2005 15:45:22 -0500
Message-Id: <1118695522.6918.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 16:28 -0700, Chris Wright wrote:
> Perhaps you could describe any specific reasons inotify isn't sufficient,
> as it's similar in many ways.

Hi Chris,

I replied to Cristoph with my attempt at explaining this to some degree.
I believe that the objectives of both auditfs and inotify are actually
quite different and should not be implemented in terms of one another or
merged.  However, they do share some commonality in that they are both
interested in receiving event notification from the file system.  In
this light, I do believe that having some generic hooking framework that
inotify, auditfs, and whatever else comes in the future can use to
mitigate duplicating code and function while not compromising objective.

> 
> Also, could drop some of that extra debugging code (heh, like that MKDEV
> in audit_inode_free ;-)

Done.

> 
> Anyway, some quick comments below...
> 

Thanks, this patch incorporates most of those comments.

-tim

diff -Nurp audit-2.6.git/fs/dcache.c audit-2.6.git~tc/fs/dcache.c
--- audit-2.6.git/fs/dcache.c	2005-06-07 13:53:54.000000000 -0500
+++ audit-2.6.git~tc/fs/dcache.c	2005-06-09 10:09:51.000000000 -0500
@@ -32,6 +32,7 @@
 #include <linux/seqlock.h>
 #include <linux/swap.h>
 #include <linux/bootmem.h>
+#include <linux/audit.h>
 
 /* #define DCACHE_DEBUG 1 */
 
@@ -97,6 +98,7 @@ static inline void dentry_iput(struct de
 {
 	struct inode *inode = dentry->d_inode;
 	if (inode) {
+		audit_update_watch(dentry, AUDIT_UPDATE_REMOVE);
 		dentry->d_inode = NULL;
 		list_del_init(&dentry->d_alias);
 		spin_unlock(&dentry->d_lock);
@@ -802,6 +804,7 @@ void d_instantiate(struct dentry *entry,
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
 	entry->d_inode = inode;
+	audit_update_watch(entry, AUDIT_UPDATE_NORMAL);
 	spin_unlock(&dcache_lock);
 	security_d_instantiate(entry, inode);
 }
@@ -978,6 +981,7 @@ struct dentry *d_splice_alias(struct ino
 		new = __d_find_alias(inode, 1);
 		if (new) {
 			BUG_ON(!(new->d_flags & DCACHE_DISCONNECTED));
+			audit_update_watch(new, AUDIT_UPDATE_NORMAL);
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(new, inode);
 			d_rehash(dentry);
@@ -987,6 +991,7 @@ struct dentry *d_splice_alias(struct ino
 			/* d_instantiate takes dcache_lock, so we do it by hand */
 			list_add(&dentry->d_alias, &inode->i_dentry);
 			dentry->d_inode = inode;
+			audit_update_watch(dentry, AUDIT_UPDATE_NORMAL);
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(dentry, inode);
 			d_rehash(dentry);
@@ -1090,6 +1095,7 @@ struct dentry * __d_lookup(struct dentry
 		if (!d_unhashed(dentry)) {
 			atomic_inc(&dentry->d_count);
 			found = dentry;
+			audit_update_watch(dentry, AUDIT_UPDATE_NORMAL);
 		}
 		spin_unlock(&dentry->d_lock);
 		break;
@@ -1299,6 +1305,8 @@ void d_move(struct dentry * dentry, stru
 		spin_lock(&target->d_lock);
 	}
 
+	audit_update_watch(dentry, AUDIT_UPDATE_REMOVE);
+
 	/* Move the dentry to the target hash queue, if on different bucket */
 	if (dentry->d_flags & DCACHE_UNHASHED)
 		goto already_unhashed;
@@ -1332,6 +1340,7 @@ already_unhashed:
 		list_add(&target->d_child, &target->d_parent->d_subdirs);
 	}
 
+	audit_update_watch(dentry, AUDIT_UPDATE_NORMAL);
 	list_add(&dentry->d_child, &dentry->d_parent->d_subdirs);
 	spin_unlock(&target->d_lock);
 	spin_unlock(&dentry->d_lock);
diff -Nurp audit-2.6.git/fs/inode.c audit-2.6.git~tc/fs/inode.c
--- audit-2.6.git/fs/inode.c	2005-06-07 13:53:54.000000000 -0500
+++ audit-2.6.git~tc/fs/inode.c	2005-06-08 11:05:20.000000000 -0500
@@ -21,6 +21,7 @@
 #include <linux/pagemap.h>
 #include <linux/cdev.h>
 #include <linux/bootmem.h>
+#include <linux/audit.h>
 
 /*
  * This is needed for the following functions:
@@ -172,6 +173,7 @@ void destroy_inode(struct inode *inode) 
 {
 	if (inode_has_buffers(inode))
 		BUG();
+	audit_inode_free(inode);
 	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
@@ -257,7 +259,7 @@ void clear_inode(struct inode *inode)
 		bd_forget(inode);
 	if (inode->i_cdev)
 		cd_forget(inode);
-	inode->i_state = I_CLEAR;
+	inode->i_state = I_CLEAR | (inode->i_state & I_AUDIT);
 }
 
 EXPORT_SYMBOL(clear_inode);
@@ -1009,7 +1011,7 @@ void generic_delete_inode(struct inode *
 	hlist_del_init(&inode->i_hash);
 	spin_unlock(&inode_lock);
 	wake_up_inode(inode);
-	if (inode->i_state != I_CLEAR)
+	if ((inode->i_state & ~I_AUDIT) != I_CLEAR)
 		BUG();
 	destroy_inode(inode);
 }
@@ -1323,6 +1325,7 @@ void __init inode_init(unsigned long mem
 	inode_cachep = kmem_cache_create("inode_cache", sizeof(struct inode),
 				0, SLAB_RECLAIM_ACCOUNT|SLAB_PANIC, init_once, NULL);
 	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
+	audit_filesystem_init();
 
 	/* Hash may have been set up in inode_init_early */
 	if (!hashdist)
diff -Nurp audit-2.6.git/fs/namei.c audit-2.6.git~tc/fs/namei.c
--- audit-2.6.git/fs/namei.c	2005-06-07 13:53:54.000000000 -0500
+++ audit-2.6.git~tc/fs/namei.c	2005-06-13 14:14:20.000000000 -0500
@@ -224,6 +224,8 @@ int generic_permission(struct inode *ino
 int permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	int retval, submask;
+	
+	audit_notify_watch(inode, mask);
 
 	if (mask & MAY_WRITE) {
 		umode_t mode = inode->i_mode;
@@ -358,6 +360,8 @@ static inline int exec_permission_lite(s
 	if (inode->i_op && inode->i_op->permission)
 		return -EAGAIN;
 
+	audit_notify_watch(inode, MAY_EXEC);
+
 	if (current->fsuid == inode->i_uid)
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
@@ -1172,6 +1176,8 @@ static inline int may_delete(struct inod
 
 	BUG_ON(victim->d_parent->d_inode != dir);
 
+	audit_notify_watch(victim->d_inode, 0);
+
 	error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
 	if (error)
 		return error;
@@ -1296,6 +1302,7 @@ int vfs_create(struct inode *dir, struct
 	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode, nd);
 	if (!error) {
+		audit_notify_watch(dentry->d_inode, MAY_WRITE);
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_create(dir, dentry, mode);
 	}
@@ -1602,6 +1609,7 @@ int vfs_mknod(struct inode *dir, struct 
 	DQUOT_INIT(dir);
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
 	if (!error) {
+		audit_notify_watch(dentry->d_inode, MAY_WRITE);
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_mknod(dir, dentry, mode, dev);
 	}
@@ -1675,6 +1683,7 @@ int vfs_mkdir(struct inode *dir, struct 
 	DQUOT_INIT(dir);
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	if (!error) {
+		audit_notify_watch(dentry->d_inode, MAY_WRITE);
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_mkdir(dir,dentry, mode);
 	}
@@ -1915,6 +1924,7 @@ int vfs_symlink(struct inode *dir, struc
 	DQUOT_INIT(dir);
 	error = dir->i_op->symlink(dir, dentry, oldname);
 	if (!error) {
+		audit_notify_watch(dentry->d_inode, MAY_WRITE);
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_symlink(dir, dentry, oldname);
 	}
@@ -1988,6 +1998,7 @@ int vfs_link(struct dentry *old_dentry, 
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
 	up(&old_dentry->d_inode->i_sem);
 	if (!error) {
+		audit_notify_watch(new_dentry->d_inode, MAY_WRITE);
 		inode_dir_notify(dir, DN_CREATE);
 		security_inode_post_link(old_dentry, dir, new_dentry);
 	}
@@ -2111,6 +2122,7 @@ static int vfs_rename_dir(struct inode *
 	}
 	if (!error) {
 		d_move(old_dentry,new_dentry);
+		audit_notify_watch(old_dentry->d_inode, MAY_WRITE);
 		security_inode_post_rename(old_dir, old_dentry,
 					   new_dir, new_dentry);
 	}
@@ -2139,6 +2151,7 @@ static int vfs_rename_other(struct inode
 		/* The following d_move() should become unconditional */
 		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
 			d_move(old_dentry, new_dentry);
+		audit_notify_watch(old_dentry->d_inode, MAY_WRITE);
 		security_inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
 	}
 	if (target)
diff -Nurp audit-2.6.git/include/linux/audit.h audit-2.6.git~tc/include/linux/audit.h
--- audit-2.6.git/include/linux/audit.h	2005-06-07 13:53:54.000000000 -0500
+++ audit-2.6.git~tc/include/linux/audit.h	2005-06-11 10:31:11.000000000 -0500
@@ -24,9 +24,15 @@
 #ifndef _LINUX_AUDIT_H_
 #define _LINUX_AUDIT_H_
 
+#ifdef __KERNEL__
 #include <linux/sched.h>
 #include <linux/elf.h>
 
+struct hlist_head;
+struct hlist_node;
+struct dentry;
+#endif
+
 /* The netlink messages for the audit system is divided into blocks:
  * 1000 - 1099 are for commanding the audit system
  * 1100 - 1199 user space trusted application messages
@@ -67,6 +73,7 @@
 #define AUDIT_CONFIG_CHANGE	1305	/* Audit system configuration change */
 #define AUDIT_SOCKADDR		1306	/* sockaddr copied as syscall arg */
 #define AUDIT_CWD		1307	/* Current working directory */
+#define AUDIT_FS_INODE		1308	/* Filesystem inode event */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
@@ -169,6 +176,9 @@
 #define AUDIT_ARCH_V850		(EM_V850|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_X86_64	(EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 
+/* 32 byte max key size */
+#define AUDIT_FILTERKEY_MAX   32
+
 struct audit_status {
 	__u32		mask;		/* Bit mask for valid entries */
 	__u32		enabled;	/* 1 = enabled, 0 = disabled */
@@ -189,13 +199,52 @@ struct audit_rule {		/* for AUDIT_LIST, 
 	__u32		values[AUDIT_MAX_FIELDS];
 };
 
+/* Structure to transport watch data to and from the kernel */
+
+struct watch_transport {
+	__u32 dev_major;
+	__u32 dev_minor;
+	__u32 perms;
+	__u32 valid;
+	__u32 pathlen;
+	__u32 fklen;
+	char buf[0];
+};
+
 #ifdef __KERNEL__
+/* Structure associated with inode->i_audit */
+
+struct audit_watch {
+	atomic_t		w_count;
+	struct hlist_node 	w_node;		/* per-directory list	      */
+	struct hlist_node	w_master;	/* Master watch list	      */
+	struct hlist_node	w_watched;	/* Watches on inode	      */
+	dev_t			w_dev;		/* Superblock device	      */
+	__u32			w_perms;	/* Permissions filtering      */
+	char			*w_name;	/* Watch point beneath parent */
+	char			*w_path;	/* Insertion path             */
+	char			*w_filterkey;	/* An arbitrary filtering key */
+};
+
+struct audit_inode_data {
+	int			count;
+	struct audit_inode_data *next_hash;	/* Watch data hash table      */
+	struct inode		*inode;		/* Inode to which it belongs  */
+	struct hlist_head	watches;	/* List of watches on inode   */
+	struct hlist_head 	watchlist;	/* Watches for children       */
+};
+
 
 struct audit_sig_info {
 	uid_t		uid;
 	pid_t		pid;
 };
 
+struct audit_watch_info {
+	struct hlist_node node;
+	struct audit_watch *watch;
+};
+
 struct audit_buffer;
 struct audit_context;
 struct inode;
@@ -248,6 +297,31 @@ extern void audit_signal_info(int sig, s
 #define audit_signal_info(s,t) do { ; } while (0)
 #endif
 
+#define AUDIT_UPDATE_NORMAL	0
+#define AUDIT_UPDATE_REMOVE	1
+#ifdef CONFIG_AUDITFILESYSTEM
+extern int audit_filesystem_init(void);
+extern int audit_list_watches(int pid, int seq);
+extern int audit_receive_watch(int type, int pid, int uid, int seq,
+			       struct watch_transport *req, uid_t loginuid);
+extern void audit_inode_free(struct inode *inode);
+extern void audit_update_watch(struct dentry *dentry, int remove);
+extern void audit_watch_put(struct audit_watch *watch);
+extern struct audit_watch *audit_watch_get(struct audit_watch *watch);
+extern int audit_notify_watch(struct inode *inode, int mask);
+extern int auditfs_attach_wdata(struct inode *inode, struct hlist_head *watches,
+				int mask);
+#else
+#define audit_filesystem_init() ({ 0; })
+#define audit_list_watches(p,s) ({ -EOPNOTSUPP; })
+#define audit_receive_watch(t,p,u,s,r,l) ({ -EOPNOTSUPP; })
+#define audit_inode_free(i) do { ; } while(0)
+#define audit_update_watch(d,r) do { ; } while (0)
+#define audit_watch_put(w) do { ; } while(0)
+#define audit_watch_get(w) ({ 0; })
+#define audit_notify_watch(i,m) ({ 0; })
+#endif
+
 #ifdef CONFIG_AUDIT
 /* These are defined in audit.c */
 				/* Public API */
diff -Nurp audit-2.6.git/include/linux/fs.h audit-2.6.git~tc/include/linux/fs.h
--- audit-2.6.git/include/linux/fs.h	2005-06-10 15:16:52.000000000 -0500
+++ audit-2.6.git~tc/include/linux/fs.h	2005-06-13 09:45:56.000000000 -0500
@@ -225,6 +225,7 @@ struct poll_table_struct;
 struct kstatfs;
 struct vm_area_struct;
 struct vfsmount;
+struct audit_inode_data;
 
 /* Used to be a macro which just called the function, now just a function */
 extern void update_atime (struct inode *);
@@ -1024,6 +1025,7 @@ struct super_operations {
 #define I_FREEING		16
 #define I_CLEAR			32
 #define I_NEW			64
+#define I_AUDIT			128
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
 
diff -Nurp audit-2.6.git/init/Kconfig audit-2.6.git~tc/init/Kconfig
--- audit-2.6.git/init/Kconfig	2005-06-07 13:53:54.000000000 -0500
+++ audit-2.6.git~tc/init/Kconfig	2005-06-11 10:23:26.000000000 -0500
@@ -181,6 +181,16 @@ config AUDITSYSCALL
 	  can be used independently or with another kernel subsystem,
 	  such as SELinux.
 
+config AUDITFILESYSTEM
+	bool "Enable file system auditing support"
+	depends on AUDITSYSCALL
+	default n
+	help
+	  Enable file system auditing for regular files and directories.
+	  When a targeted file or directory is accessed, an audit record
+	  is generated describing the inode accessed, how it was accessed,
+	  and by whom (ie: pid and system call).
+
 config HOTPLUG
 	bool "Support for hot-pluggable devices" if !ARCH_S390
 	default ARCH_S390
diff -Nurp audit-2.6.git/kernel/Makefile audit-2.6.git~tc/kernel/Makefile
--- audit-2.6.git/kernel/Makefile	2005-06-07 13:53:54.000000000 -0500
+++ audit-2.6.git~tc/kernel/Makefile	2005-06-08 10:47:03.000000000 -0500
@@ -24,6 +24,7 @@ obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+obj-$(CONFIG_AUDITFILESYSTEM) += auditfs.o
 obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
diff -Nurp audit-2.6.git/kernel/audit.c audit-2.6.git~tc/kernel/audit.c
--- audit-2.6.git/kernel/audit.c	2005-06-10 11:01:43.000000000 -0500
+++ audit-2.6.git~tc/kernel/audit.c	2005-06-11 10:23:11.000000000 -0500
@@ -350,6 +350,9 @@ static int audit_netlink_ok(kernel_cap_t
 	case AUDIT_SET:
 	case AUDIT_ADD:
 	case AUDIT_DEL:
+	case AUDIT_WATCH_LIST:
+	case AUDIT_WATCH_INS:
+	case AUDIT_WATCH_REM:
 	case AUDIT_SIGNAL_INFO:
 		if (!cap_raised(eff_cap, CAP_AUDIT_CONTROL))
 			err = -EPERM;
@@ -454,6 +457,17 @@ static int audit_receive_msg(struct sk_b
 		err = audit_receive_filter(nlh->nlmsg_type, NETLINK_CB(skb).pid,
 					   uid, seq, data, loginuid);
 		break;
+	case AUDIT_WATCH_LIST:
+		err = audit_list_watches(pid, seq);
+		break;
+	case AUDIT_WATCH_INS:
+	case AUDIT_WATCH_REM:
+		if (nlh->nlmsg_len < sizeof(struct watch_transport))
+			return -EINVAL;
+		err = audit_receive_watch(nlh->nlmsg_type,
+					  NETLINK_CB(skb).pid,
+					  uid, seq, data, loginuid);
+		break;
 	case AUDIT_SIGNAL_INFO:
 		sig_data.uid = audit_sig_uid;
 		sig_data.pid = audit_sig_pid;
diff -Nurp audit-2.6.git/kernel/auditfs.c audit-2.6.git~tc/kernel/auditfs.c
--- audit-2.6.git/kernel/auditfs.c	1969-12-31 18:00:00.000000000 -0600
+++ audit-2.6.git~tc/kernel/auditfs.c	2005-06-13 11:14:03.000000000 -0500
@@ -0,0 +1,844 @@
+/* auditfs.c -- Filesystem auditing support
+ * Implements filesystem auditing support, depends on kernel/auditsc.c
+ *
+ * Copyright 2005 International Business Machines Corp. (IBM)
+ * Copyright 2005 Red Hat, Inc.
+ *
+ * All Rights Reserved.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307  USA
+ *
+ * Written by:		Timothy R. Chavez <chavezt@us.ibm.com>
+ *			David Woodhouse <dwmw2@infradead.org>
+ */
+
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/namei.h>
+#include <linux/mount.h>
+#include <linux/list.h>
+#include <linux/hash.h>
+#include <linux/slab.h>
+#include <linux/audit.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+#if 1
+#define dprintk(...) do { } while(0)
+#define __print_symbol(x, y) do { } while(0)
+#else
+#define dprintk(...) printk(KERN_DEBUG  __VA_ARGS__);
+extern void __print_symbol(char *, void *);
+#define inline
+#endif
+
+extern int audit_enabled;
+
+static kmem_cache_t *audit_watch_cache;
+
+static HLIST_HEAD(master_watchlist);
+static DEFINE_SPINLOCK(auditfs_lock);
+
+struct audit_skb_list {
+	struct hlist_node list;
+	void *memblk;
+	size_t size;
+};
+
+extern spinlock_t inode_lock;
+
+static int audit_nr_watches;
+static int audit_pool_size;
+static struct audit_inode_data *audit_data_pool;
+static struct audit_inode_data **auditfs_hash_table;
+static DEFINE_SPINLOCK(auditfs_hash_lock);
+static int auditfs_hash_bits;
+static int auditfs_cache_buckets = 16384;
+module_param(auditfs_cache_buckets, int, 0);
+MODULE_PARM_DESC(auditfs_cache_buckets, "Number of auditfs cache entries to allocate (default 16384)\n");
+
+static void audit_data_put(struct audit_inode_data *data);
+
+static int audit_data_pool_grow(void)
+{
+	struct audit_inode_data *new;
+
+	new = kmalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+	new->next_hash = kmalloc(sizeof(*new), GFP_KERNEL);
+	if (!new->next_hash) {
+		kfree(new);
+		return -ENOMEM;
+	}
+		
+	spin_lock(&auditfs_hash_lock);
+	new->next_hash->next_hash = audit_data_pool;
+	audit_data_pool = new;
+	audit_nr_watches++;
+	audit_pool_size += 2;
+	spin_unlock(&auditfs_hash_lock);
+	return 0;
+}
+
+static void audit_data_pool_shrink(void)
+{
+	spin_lock(&auditfs_hash_lock);
+	audit_nr_watches--;
+
+	while (audit_pool_size > audit_nr_watches + 1) {
+		struct audit_inode_data *old = audit_data_pool;
+		audit_data_pool = old->next_hash;
+		audit_pool_size--;
+		kfree(old);
+	}
+	spin_unlock(&auditfs_hash_lock);
+}
+
+static struct audit_inode_data *audit_data_get(struct inode *inode, int allocate)
+{
+	struct audit_inode_data **list;
+	struct audit_inode_data *ret = NULL;
+	int h;
+
+	spin_lock(&auditfs_hash_lock);
+
+	/* I_AUDIT bit can only be changed under auditfs_hash_lock, so no need
+	   to lock inode_lock (on all known hardware) */
+	if (!allocate && !(inode->i_state & I_AUDIT))
+		goto out;
+
+	h = hash_ptr(inode, auditfs_hash_bits);
+	list = &auditfs_hash_table[h];
+
+	while (*list && (unsigned long)((*list)->inode) < (unsigned long)inode) {
+		dprintk("list %p -> %p\n", list, *list);
+		list = &(*list)->next_hash;
+	}
+	if (*list && (*list)->inode == inode)
+		ret = *list;
+
+	if (ret) {
+		ret->count++;
+	} else if (allocate) {
+		ret = audit_data_pool;
+		audit_data_pool = ret->next_hash;
+		audit_pool_size--;
+		dprintk("allocate from pool. %d left\n", audit_pool_size);
+
+		INIT_HLIST_HEAD(&ret->watchlist);
+		INIT_HLIST_HEAD(&ret->watches);
+		ret->inode = inode;
+		ret->next_hash = *list;
+		ret->count = 2;
+		*list = ret;
+
+		spin_lock(&inode_lock);
+		inode->i_state |= I_AUDIT;
+		spin_unlock(&inode_lock);
+	}
+	if (ret) {
+		dprintk("Got audit data %p for inode %p (%lu), count++ now %d. From %p: ",
+			ret, ret->inode, ret->inode->i_ino, ret->count, __builtin_return_address(0));
+		__print_symbol("%s\n", __builtin_return_address(0));
+	}
+ out:
+	spin_unlock(&auditfs_hash_lock);
+
+	return ret;
+}
+
+/* Private Interface */
+
+/* Caller should be holding auditfs_lock */
+static inline struct audit_watch *audit_fetch_watch(const char *name,
+						    struct audit_inode_data *data)
+{
+	struct audit_watch *watch, *ret = NULL;
+	struct hlist_node *pos;
+
+	hlist_for_each_entry(watch, pos, &data->watchlist, w_node)
+		if (!strcmp(watch->w_name, name)) {
+			ret = audit_watch_get(watch);
+			break;
+		}
+
+	return ret;
+}
+
+static inline struct audit_watch *audit_fetch_watch_lock(const char *name,
+							 struct audit_inode_data *data)
+{
+	struct audit_watch *ret = NULL;
+
+	if (name && data) {
+		spin_lock(&auditfs_lock);
+		ret = audit_fetch_watch(name, data);
+		spin_unlock(&auditfs_lock);
+	}
+
+	return ret;
+}
+
+static inline struct audit_watch *audit_watch_alloc(void)
+{
+	struct audit_watch *watch;
+
+	watch = kmem_cache_alloc(audit_watch_cache, GFP_KERNEL);
+	if (watch) {
+		memset(watch, 0, sizeof(*watch));
+		atomic_set(&watch->w_count, 1);
+	}
+
+	return watch;
+}
+
+static inline void audit_watch_free(struct audit_watch *watch)
+{
+	if (watch) {
+		kfree(watch->w_name);
+		kfree(watch->w_path);
+		kfree(watch->w_filterkey);
+		BUG_ON(!hlist_unhashed(&watch->w_node));
+		BUG_ON(!hlist_unhashed(&watch->w_master));
+		kmem_cache_free(audit_watch_cache, watch);
+	}
+}
+
+
+/* Convert a watch_transport structure into a kernel audit_watch structure. */
+static inline struct audit_watch *audit_to_watch(void *memblk)
+{
+	unsigned int offset;
+	struct watch_transport *t;
+	struct audit_watch *watch;
+
+	watch = audit_watch_alloc();
+	if (!watch)
+		return NULL;
+
+	t = memblk;
+
+	watch->w_perms = t->perms;
+
+	offset = sizeof(struct watch_transport);
+	watch->w_filterkey = kmalloc(t->fklen+1, GFP_KERNEL);
+	if (!watch->w_filterkey)
+		goto audit_to_watch_fail;
+	watch->w_filterkey[t->fklen] = 0;
+	memcpy(watch->w_filterkey, memblk + offset, t->fklen);
+
+	offset += t->fklen;
+	watch->w_path = kmalloc(t->pathlen+1, GFP_KERNEL);
+	if (!watch->w_path)
+		goto audit_to_watch_fail;
+	watch->w_path[t->pathlen] = 0;
+	memcpy(watch->w_path, memblk + offset, t->pathlen);
+
+	return watch;
+
+audit_to_watch_fail:
+	audit_watch_free(watch);
+	return NULL;
+}
+
+/*
+ * Convert a kernel audit_watch structure into a watch_transport structure.
+ * We do this to send watch information back to user space.
+ */
+static inline void *audit_to_transport(struct audit_watch *watch, size_t size)
+{
+	struct watch_transport *t;
+	char *p;
+
+	t = kmalloc(size, GFP_KERNEL);
+	if (!t)
+		goto out;
+
+	memset(t, 0, sizeof(*t));
+
+	t->dev_major = MAJOR(watch->w_dev);
+	t->dev_minor = MINOR(watch->w_dev);
+	t->perms = watch->w_perms;
+	t->pathlen = strlen(watch->w_path) + 1;
+
+	p = (char *)&t[1];
+
+	if (watch->w_filterkey) {
+		t->fklen = strlen(watch->w_filterkey) + 1;
+		memcpy(p, watch->w_filterkey, t->fklen);
+		p += t->fklen;
+	}
+	memcpy(p, watch->w_path, t->pathlen);
+
+ out:
+	return t;
+}
+
+static inline void audit_destroy_watch(struct audit_watch *watch)
+{
+	if (watch) {
+		hlist_del_init(&watch->w_watched);
+		hlist_del_init(&watch->w_master);
+		hlist_del_init(&watch->w_node);
+		audit_watch_put(watch);
+		audit_watch_put(watch);
+		audit_watch_put(watch);
+		audit_log(NULL, AUDIT_CONFIG_CHANGE,
+			  "auid=%u removed watch implicitly", -1);
+	}
+}
+
+static inline void audit_drain_watchlist(struct audit_inode_data *data)
+{
+	struct audit_watch *watch;
+	struct hlist_node *pos, *tmp;
+
+	hlist_for_each_entry_safe(watch, pos, tmp, &data->watchlist, w_node) {
+		spin_lock(&auditfs_lock);
+		audit_destroy_watch(watch);
+		spin_unlock(&auditfs_lock);
+		audit_data_pool_shrink();
+	}
+}
+
+static void audit_data_unhash(struct audit_inode_data *data)
+{
+	int h = hash_ptr(data->inode, auditfs_hash_bits);
+	struct audit_inode_data **list = &auditfs_hash_table[h];
+
+	while (*list && (unsigned long)((*list)->inode) < (unsigned long)data->inode)
+		list = &(*list)->next_hash;
+
+	BUG_ON(*list != data);
+	*list = data->next_hash;
+
+	spin_lock(&inode_lock);
+	data->inode->i_state &= ~I_AUDIT;
+	spin_unlock(&inode_lock);
+	data->inode = NULL;
+}
+
+static void audit_data_put(struct audit_inode_data *data)
+{
+	if (!data)
+		return;
+
+	spin_lock(&auditfs_hash_lock);
+	data->count--;
+	dprintk("Put audit_data %p for inode %p (%lu), count-- now %d. From %p:", data,
+	       data->inode, data->inode?data->inode->i_ino:0, data->count, __builtin_return_address(0));
+	__print_symbol("%s\n", __builtin_return_address(0));
+
+	if (data->count == 1 && data->inode &&
+	    hlist_empty(&data->watches) && hlist_empty(&data->watchlist)) {
+		dprintk("Last put.\n");
+		data->count--;
+	}
+
+	if (!data->count) {
+		/* We are last user. Remove it from the hash table to
+		   disassociate it from its inode */
+		if (data->inode)
+			audit_data_unhash(data);
+		spin_unlock(&auditfs_hash_lock);
+
+		audit_drain_watchlist(data);
+
+		spin_lock(&auditfs_hash_lock);
+		/* Check whether to free it or return it to the pool */
+		if (audit_nr_watches > audit_pool_size) {
+			dprintk("Back to pool. %d watches, %d in pool\n", audit_nr_watches, audit_pool_size);
+			data->next_hash = audit_data_pool;
+			audit_data_pool = data;
+			audit_pool_size++;
+		} else {
+			dprintk("Freed. %d watches, %d in pool\n", audit_nr_watches, audit_pool_size);
+			kfree(data);
+		}
+	}
+	spin_unlock(&auditfs_hash_lock);
+}
+
+static inline int audit_insert_watch(struct audit_watch *watch, uid_t loginuid)
+{
+	int ret;
+	struct nameidata nd;
+	struct audit_inode_data *pdata;
+	struct audit_watch *lookup;
+
+	/* Grow the pool by two -- one for the watch itself, and
+	   one for the parent directory */
+	if (audit_data_pool_grow())
+		return -ENOMEM;
+
+	ret = path_lookup(watch->w_path, LOOKUP_PARENT, &nd);
+	if (ret < 0)
+		goto out;
+	
+	ret = -EPERM;
+	if (nd.last_type != LAST_NORM || !nd.last.name)
+		goto release;
+
+	pdata = audit_data_get(nd.dentry->d_inode, 1);
+	if (!pdata)
+		goto put_pdata;
+
+	ret = -EEXIST;
+	lookup = audit_fetch_watch_lock(nd.last.name, pdata);
+	if (lookup) {
+		audit_watch_put(lookup);
+		goto put_pdata;
+	}
+
+	ret = -ENOMEM;
+	watch->w_name = kmalloc(strlen(nd.last.name)+1, GFP_KERNEL);
+	if (!watch->w_name)
+		goto put_pdata;
+	strcpy(watch->w_name, nd.last.name);
+
+	watch->w_dev = nd.dentry->d_inode->i_sb->s_dev;
+
+	ret = 0;
+	/* Get a reference for the master watchlist */
+	audit_watch_get(watch);
+	spin_lock(&auditfs_lock);
+	hlist_add_head(&watch->w_node, &pdata->watchlist);
+	hlist_add_head(&watch->w_master, &master_watchlist);
+	spin_unlock(&auditfs_lock);
+
+	audit_log(NULL, AUDIT_CONFIG_CHANGE, "auid=%u inserted watch", loginuid);
+
+	/* __d_lookup will attach the audit data, if nd.last exists. */
+	dput(d_lookup(nd.dentry, &nd.last));
+
+ put_pdata:
+	audit_data_put(pdata);
+ release:
+	path_release(&nd);
+ out:
+	if (ret)
+		audit_data_pool_shrink();
+
+	return ret;
+}
+
+static inline int audit_remove_watch(struct audit_watch *watch, uid_t loginuid)
+{
+	int ret = 0;
+	struct nameidata nd;
+	struct audit_inode_data *data = NULL;
+	struct audit_watch *real, *this;
+	struct hlist_node *pos, *tmp;
+
+	/* Let's try removing via the master watchlist first */
+	spin_lock(&auditfs_lock);
+	hlist_for_each_entry_safe(this, pos, tmp, &master_watchlist, w_master)
+		if (!strcmp(this->w_path, watch->w_path)) {
+			audit_destroy_watch(this);
+			spin_unlock(&auditfs_lock);
+			goto audit_remove_watch_exit;
+		}
+	spin_unlock(&auditfs_lock);
+
+	ret = path_lookup(watch->w_path, LOOKUP_PARENT, &nd);
+	if (ret < 0)
+		goto audit_remove_watch_exit;
+
+	ret = -ENOENT;
+	if (nd.last_type != LAST_NORM || !nd.last.name)
+		goto audit_remove_watch_release;
+
+	data = audit_data_get(nd.dentry->d_inode, 0);
+	if (!data)
+		goto audit_remove_watch_release;
+
+	spin_lock(&auditfs_lock);
+	real = audit_fetch_watch(nd.last.name, data);
+	if (!real) {
+		spin_unlock(&auditfs_lock);
+		goto audit_remove_watch_release;
+	}
+	ret = 0;
+	audit_destroy_watch(real);
+	spin_unlock(&auditfs_lock);
+	audit_watch_put(real);
+
+audit_remove_watch_release:
+	path_release(&nd);
+audit_remove_watch_exit:
+	audit_data_put(data);
+	if (!ret) {
+		audit_log(NULL, AUDIT_CONFIG_CHANGE, "auid=%u removed watch", loginuid);
+		audit_data_pool_shrink();
+	}
+
+	return ret;
+}
+
+
+/* Caller should be holding auditfs_lock */
+struct audit_watch *audit_is_watched(struct audit_watch *watch,
+				     struct audit_inode_data *data)
+{
+	struct audit_watch *watched;
+	struct hlist_node *pos;
+
+	if (watch && data) {
+		hlist_for_each_entry(watched, pos, &data->watches, w_watched)
+			if (!strcmp(watch->w_name, watched->w_name))
+				return audit_watch_get(watched);
+	}
+
+	return NULL;
+}
+
+struct audit_watch *audit_watch_get(struct audit_watch *watch)
+{
+	int new;
+
+	if (watch) {
+		new = atomic_inc_return(&watch->w_count);
+		BUG_ON(new == 1);
+		dprintk("Increase count on watch %p to %d\n",
+		       watch, new);
+	}
+
+	return watch;
+}
+
+void audit_watch_put(struct audit_watch *watch)
+{
+	int new;
+
+	if (watch) {
+		new = atomic_dec_return(&watch->w_count);
+		if (!new)
+			audit_watch_free(watch);
+		dprintk("Reduce count on watch %p to %d\n",
+		       watch, new);
+	}
+}
+
+/*
+ * The update hook is responsible for watching and unwatching d_inodes during
+ * their lifetimes in dcache.  Each d_inode being watched is pinned in memory.
+ * As soon as a d_inode becomes unwatched (ie: dentry is destroyed, watch is
+ * unhashed / removed from watchlist, dentry is moved out of watch path).
+ *
+ * Hook appears in fs/dcache.c:
+ *	d_move(),
+ * 	dentry_iput(),
+ *	d_instantiate(),
+ *	d_splice_alias()
+ *	__d_lookup()
+ *
+ * Called with dcache_lock held
+ */
+void audit_update_watch(struct dentry *dentry, int remove)
+{
+	struct audit_watch *me, *this, *watch;
+	struct audit_inode_data *data, *parent;
+	struct hlist_node *pos, *tmp;
+
+	if (likely(!audit_enabled))
+		return;
+
+	if (!dentry || !dentry->d_inode)
+		return;
+
+	if (!dentry->d_parent || !dentry->d_parent->d_inode)
+		return;
+
+	/* If there's no audit data on the parent inode, then there can
+	   be no watches to add or remove */
+	parent = audit_data_get(dentry->d_parent->d_inode, 0);
+	if (!parent)
+		return;
+
+	watch = audit_fetch_watch_lock(dentry->d_name.name, parent);
+
+	/* Fetch audit data, using the preallocated one from the watch if
+	   there is actually a relevant watch and the inode didn't already
+	   have any audit data */
+	data = audit_data_get(dentry->d_inode, !!watch);
+
+	/* If there's no data, then there wasn't a watch either.
+	   Nothing to see here; move along */
+	if (!data)
+		goto put_watch;
+
+	spin_lock(&auditfs_lock);
+	if (remove) {
+		me = audit_is_watched(watch, data);
+		if (me) {
+			hlist_del_init(&me->w_watched);
+			audit_watch_put(me);
+		}
+	} else {
+		hlist_for_each_entry_safe(this, pos, tmp, &data->watches, w_watched)
+			if (hlist_unhashed(&this->w_node)) {
+				hlist_del(&this->w_watched);
+				audit_watch_put(this);
+			}
+		me = audit_is_watched(watch, data);
+		if (!me && watch) {
+			audit_watch_get(watch);
+			hlist_add_head(&watch->w_watched, &data->watches);
+		}
+		audit_watch_put(me);
+	}
+	spin_unlock(&auditfs_lock);
+	audit_data_put(data);
+
+ put_watch:
+	audit_watch_put(watch);
+	audit_data_put(parent);
+}
+
+/* Convert a watch to a audit_skb_list */
+struct audit_skb_list *audit_to_skb(struct audit_watch *watch)
+{
+	size_t size;
+	void *memblk;
+	struct audit_skb_list *entry;
+
+	/* We must include space for both "\0" */
+	size = sizeof(struct watch_transport) + strlen(watch->w_path) +
+	       strlen(watch->w_filterkey) + 2;
+
+	entry = ERR_PTR(-ENOMEM);
+	memblk = audit_to_transport(watch, size);
+	if (!memblk)
+		goto audit_queue_watch_exit;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		entry = ERR_PTR(-ENOMEM);
+		goto audit_queue_watch_exit;
+	}
+
+	entry->memblk = memblk;
+	entry->size = size;
+
+audit_queue_watch_exit:
+	return entry;
+}
+
+/*
+ * Read the "master watchlist" which is a watchlist of all watches in the
+ * file system and send it to user space.  There will never be concurrent
+ * readers of this list.
+ *
+ * The reference to watch will not be put back during a read upon a
+ * watch removal, until after we're done reading.  So, the potential
+ * for the rug being pulled out from under us is NIL.
+ *
+ * This list is only a "snapshot in time".  It is not gospel.
+ */
+int audit_list_watches(int pid, int seq)
+{
+	int ret = 0;
+	struct hlist_head skb_list;
+	struct hlist_node *tmp, *pos;
+	struct audit_skb_list *entry;
+	struct audit_watch *watch;
+
+ restart:
+	INIT_HLIST_HEAD(&skb_list);
+	spin_lock(&auditfs_lock);
+
+	hlist_for_each_entry(watch, pos, &master_watchlist, w_master) {
+		audit_watch_get(watch);
+		spin_unlock(&auditfs_lock);
+		entry = audit_to_skb(watch);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry);
+			goto audit_list_watches_fail;
+		}
+		hlist_add_head(&entry->list, &skb_list);
+		spin_lock(&auditfs_lock);
+		if (hlist_unhashed(&watch->w_master)) {
+			/* This watch was removed from the list while we
+			   pondered it. We could play tricks to find how far
+			   we'd got, but we might as well just start again
+			   from scratch. There's no real chance of livelock,
+			   as the number of watches in the system has
+			   decreased, and the netlink sem prevents new watches
+			   from being added while we're looping */
+			audit_watch_put(watch);
+			hlist_for_each_entry_safe(entry, pos, tmp, &skb_list, list) {
+				hlist_del(&entry->list);
+				kfree(entry->memblk);
+				kfree(entry);
+			}
+			goto restart;
+		}
+		audit_watch_put(watch);
+	}
+	spin_unlock(&auditfs_lock);
+
+	hlist_for_each_entry_safe(entry, pos, tmp, &skb_list, list) {
+		audit_send_reply(pid, seq, AUDIT_WATCH_LIST, 0, 1,
+				 entry->memblk, entry->size);
+		hlist_del(&entry->list);
+		kfree(entry->memblk);
+		kfree(entry);
+	}
+
+	audit_send_reply(pid, seq, AUDIT_WATCH_LIST, 1, 1, NULL, 0);
+	return ret;
+
+audit_list_watches_fail:
+	hlist_for_each_entry_safe(entry, pos, tmp, &skb_list, list) {
+		hlist_del(&entry->list);
+		kfree(entry->memblk);
+		kfree(entry);
+	}
+	return ret;
+}
+
+int audit_receive_watch(int type, int pid, int uid, int seq,
+			struct watch_transport *req, uid_t loginuid)
+{
+	int ret = 0;
+	struct audit_watch *watch = NULL;
+	char *payload = (char *)&req[1];
+
+	ret = -ENAMETOOLONG;
+	if (req->pathlen >= PATH_MAX)
+		goto audit_receive_watch_exit;
+
+	if (req->fklen >= AUDIT_FILTERKEY_MAX)
+		goto audit_receive_watch_exit;
+
+	ret = -EINVAL;
+	if (req->pathlen == 0)
+		goto audit_receive_watch_exit;
+
+	if (payload[req->fklen] != '/')
+		goto audit_receive_watch_exit;
+
+	if (req->perms > (MAY_READ|MAY_WRITE|MAY_EXEC|MAY_APPEND))
+		goto audit_receive_watch_exit;
+
+	ret = -ENOMEM;
+	watch = audit_to_watch(req);
+	if (!watch)
+		goto audit_receive_watch_exit;
+
+	switch (type) {
+	case AUDIT_WATCH_INS:
+		ret = audit_insert_watch(watch, loginuid);
+		break;
+	case AUDIT_WATCH_REM:
+		ret = audit_remove_watch(watch, loginuid);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret < 0 || type == AUDIT_WATCH_REM)
+		audit_watch_put(watch);
+
+audit_receive_watch_exit:
+	return ret;
+}
+
+void audit_inode_free(struct inode *inode)
+{
+	struct audit_watch *watch;
+	struct hlist_node *pos, *tmp;
+	struct audit_inode_data *data = audit_data_get(inode, 0);
+
+	if (data) {
+		spin_lock(&auditfs_hash_lock);
+		audit_data_unhash(data);
+		spin_unlock(&auditfs_hash_lock);
+
+		audit_drain_watchlist(data);
+		/* Release all our references to any watches we may have on us */
+		hlist_for_each_entry_safe(watch, pos, tmp, &data->watches, w_watched) {
+			hlist_del(&watch->w_watched);
+			audit_watch_put(watch);
+		}
+		audit_data_put(data);
+	}
+}
+
+int audit_filesystem_init(void)
+{
+	int ret;
+
+	ret = -ENOMEM;
+	audit_watch_cache =
+	    kmem_cache_create("audit_watch_cache",
+			      sizeof(struct audit_watch), 0, 0, NULL, NULL);
+	if (!audit_watch_cache)
+		goto audit_filesystem_init_fail;
+
+	/* Set up hash table for inode objects */
+	auditfs_hash_bits = long_log2(auditfs_cache_buckets);
+	if (auditfs_cache_buckets != (1 << auditfs_hash_bits)) {
+		auditfs_hash_bits++;
+		auditfs_cache_buckets = 1 << auditfs_hash_bits;
+		printk(KERN_NOTICE
+		       "%s: auditfs_cache_buckets set to %d (bits %d)\n",
+		       __FUNCTION__, auditfs_cache_buckets, auditfs_hash_bits);
+	}
+
+	auditfs_hash_table = kmalloc(auditfs_cache_buckets * sizeof(void *), GFP_KERNEL);
+
+	if (!auditfs_hash_table) {
+		printk(KERN_NOTICE "No memory to initialize auditfs cache.\n");
+		goto audit_filesystem_init_fail;
+	}
+
+	memset(auditfs_hash_table, 0, auditfs_cache_buckets * sizeof(void *));
+
+	return 0;
+
+audit_filesystem_init_fail:
+	kmem_cache_destroy(audit_watch_cache);
+	return ret;
+}
+
+int audit_notify_watch(struct inode *inode, int mask)
+{
+	int ret = 0;
+	struct audit_inode_data *data;
+
+	if (likely(!audit_enabled))
+		return 0;
+
+	if (!inode || !current->audit_context)
+		return 0;
+
+	data = audit_data_get(inode, 0);
+	if (!data)
+		return 0;
+
+	if (hlist_empty(&data->watches))
+		return 0;
+
+	ret = auditfs_attach_wdata(inode, &data->watches, mask);
+	audit_data_put(data);
+	
+	return ret;
+}
+
diff -Nurp audit-2.6.git/kernel/auditsc.c audit-2.6.git~tc/kernel/auditsc.c
--- audit-2.6.git/kernel/auditsc.c	2005-06-09 13:47:02.000000000 -0500
+++ audit-2.6.git~tc/kernel/auditsc.c	2005-06-13 09:38:34.000000000 -0500
@@ -131,6 +131,17 @@ struct audit_aux_data_path {
 	struct vfsmount		*mnt;
 };
 
+struct audit_aux_data_watched {
+	struct audit_aux_data	link;
+	struct hlist_head	watches;
+	unsigned long		ino;
+	int			mask;
+	uid_t			uid;
+	gid_t			gid;
+	dev_t			dev;
+	dev_t			rdev;
+};
+
 /* The per-task audit context. */
 struct audit_context {
 	int		    in_syscall;	/* 1 if task is in a syscall */
@@ -565,13 +576,26 @@ static inline void audit_free_names(stru
 static inline void audit_free_aux(struct audit_context *context)
 {
 	struct audit_aux_data *aux;
+	struct audit_watch_info *winfo;
+	struct hlist_node *pos, *tmp;
 
 	while ((aux = context->aux)) {
-		if (aux->type == AUDIT_AVC_PATH) {
+		switch(aux->type) {
+		case AUDIT_AVC_PATH: {
 			struct audit_aux_data_path *axi = (void *)aux;
 			dput(axi->dentry);
 			mntput(axi->mnt);
+			break; }
+		case AUDIT_FS_INODE: {
+			struct audit_aux_data_watched *axi = (void *)aux;
+			hlist_for_each_entry_safe(winfo, pos, tmp, &axi->watches, node) {
+				audit_watch_put(winfo->watch);
+				hlist_del(&winfo->node);
+				kfree(winfo);
+			}
+			break; }
 		}
+
 		context->aux = aux->next;
 		kfree(aux);
 	}
@@ -684,6 +708,8 @@ static void audit_log_exit(struct audit_
 	int i;
 	struct audit_buffer *ab;
 	struct audit_aux_data *aux;
+	struct audit_watch_info *winfo;
+	struct hlist_node *pos;
 
 	ab = audit_log_start(context, AUDIT_SYSCALL);
 	if (!ab)
@@ -748,6 +774,29 @@ static void audit_log_exit(struct audit_
 			audit_log_d_path(ab, "path=", axi->dentry, axi->mnt);
 			break; }
 
+		case AUDIT_FS_INODE: {
+			struct audit_aux_data_watched *axi = (void *)aux;
+			struct audit_buffer *sub_ab;
+			audit_log_format(ab,
+					 "inode=%lu inode_uid=%u inode_gid=%u"
+					 " inode_dev=%02x:%02x inode_rdev=%02x:%02x",
+					 axi->ino, axi->uid, axi->gid,
+					 MAJOR(axi->dev), MINOR(axi->dev),
+					 MAJOR(axi->rdev), MINOR(axi->rdev));
+			hlist_for_each_entry(winfo, pos, &axi->watches, node) {
+				sub_ab = audit_log_start(context, AUDIT_FS_WATCH);
+				if (!sub_ab)
+					return;		/* audit_panic has been called */
+				audit_log_format(sub_ab, "watch_inode=%lu", axi->ino);
+				audit_log_format(sub_ab, " watch=");
+				audit_log_untrustedstring(sub_ab, winfo->watch->w_name);
+				audit_log_format(sub_ab,
+						 " filterkey=%s perm=%u perm_mask=%u",
+						 winfo->watch->w_filterkey,
+						 winfo->watch->w_perms, axi->mask);
+				audit_log_end(sub_ab);
+			}
+			break; }
 		}
 		audit_log_end(ab);
 	}
@@ -1164,3 +1213,58 @@ void audit_signal_info(int sig, struct t
 	}
 }
 
+#ifdef CONFIG_AUDITFILESYSTEM
+/* This has to be here instead of in auditfs.c, because it needs to
+   see the audit context */
+int auditfs_attach_wdata(struct inode *inode, struct hlist_head *watches,
+			 int mask)
+{
+	struct audit_context *context = current->audit_context;
+	struct audit_aux_data_watched *ax;
+	struct audit_watch *watch;
+	struct audit_watch_info *this, *winfo;
+	struct hlist_node *pos, *tmp;
+
+	ax = kmalloc(sizeof(*ax), GFP_KERNEL);
+	if (!ax)
+		return -ENOMEM;
+
+	if (context->in_syscall && !context->auditable)
+		context->auditable = 1;
+
+	INIT_HLIST_HEAD(&ax->watches);
+
+	hlist_for_each_entry(watch, pos, watches, w_watched) {
+		winfo = kmalloc(sizeof(struct audit_watch_info), GFP_KERNEL);
+		if (!winfo)
+			goto auditfs_attach_wdata_fail;
+		if (mask && (watch->w_perms && !(watch->w_perms&mask)))
+			continue;
+		winfo->watch = audit_watch_get(watch);
+		hlist_add_head(&winfo->node, &ax->watches);
+	}
+
+	ax->mask = mask;
+	ax->ino = inode->i_ino;
+	ax->uid = inode->i_uid;
+	ax->gid = inode->i_gid;
+	ax->dev = inode->i_sb->s_dev;
+	ax->rdev = inode->i_rdev;
+
+	ax->link.type = AUDIT_FS_INODE;
+	ax->link.next = context->aux;
+	context->aux = (void *)ax;
+
+	return 0;
+
+auditfs_attach_wdata_fail:
+	hlist_for_each_entry_safe(this, pos, tmp, &ax->watches, node) {
+		hlist_del(&this->node);
+		audit_watch_put(this->watch);
+		kfree(this);
+	}
+	kfree(ax);
+
+	return -ENOMEM;
+}
+#endif /* CONFIG_AUDITFILESYSTEM */
diff -Nurp audit-2.6.git/security/selinux/nlmsgtab.c audit-2.6.git~tc/security/selinux/nlmsgtab.c
--- audit-2.6.git/security/selinux/nlmsgtab.c	2005-06-07 13:53:57.000000000 -0500
+++ audit-2.6.git~tc/security/selinux/nlmsgtab.c	2005-06-09 17:41:49.000000000 -0500
@@ -98,6 +98,9 @@ static struct nlmsg_perm nlmsg_audit_per
 	{ AUDIT_DEL,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
 	{ AUDIT_USER,		NETLINK_AUDIT_SOCKET__NLMSG_RELAY    },
 	{ AUDIT_SIGNAL_INFO,	NETLINK_AUDIT_SOCKET__NLMSG_READ     },
+	{ AUDIT_WATCH_INS,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
+	{ AUDIT_WATCH_REM,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
+	{ AUDIT_WATCH_LIST,	NETLINK_AUDIT_SOCKET__NLMSG_READPRIV },
 };
 
 


