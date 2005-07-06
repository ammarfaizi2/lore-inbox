Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVGFUbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVGFUbr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVGFU2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:28:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:1278 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262512AbVGFUXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:23:49 -0400
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
Organization: IBM
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Date: Wed, 6 Jul 2005 15:23:10 -0500
User-Agent: KMail/1.8
Cc: linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Steve Grubb <sgrubb@redhat.com>,
       Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
References: <1120668881.8328.1.camel@localhost>
In-Reply-To: <1120668881.8328.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061523.11468.tinytim@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch augments the audit subsystem and VFS to support file system 
auditing in which an object is audited based on its location and name.  
Depending on the administrator's requirement, this feature can be used 
standalone or in conjunction with the (device,inode)-based filters.  The 
audit subsystem is currently incapable of auditing a file system object based 
on its location and name.  This is critical for auditing well-defined and 
security-relevant locations such as /etc/shadow, where the file is re-created 
on each transaction and cannot rely solely on the (device, inode)-based 
filters to ensure persistence of auditing across transactions. 

This work is being done to make the Linux audit subsystem compliant with 
Common Criteria's Controlled Access Protection Profile (CAPP) specification. 
CAPP requires that the administrator is able to audit a file's content in two 
fundamental ways:

1)  Where content confidentiality is important.  

This includes security-relevant databases like /etc/passwd and the audit
logs of which the contents are security sensitive. (device,inode)-based 
system-call filtering is sufficient to cover this requirement and is 
already available to the administrator.

2)  Where content integrity is important.

This includes configuration files that affect the operation of trusted 
programs like /etc/shadow.  Content integrity ensures audit persists 
across transactions where the underlying inode may change and content
confidentiality is important.  This is currently not doable without 
this patch.

To implement this feature we rely on the concepts of a "watch" and
"watch list".  Directories hold lists of "watches" (ie: "watch lists")
that describe auditable file names one level beneath them.  If a file 
holds a pointer into a "watch list" it is auditable.  When accessed by 
a system call, information about the inode and its "watches" is added 
to the audit context of the current task (an inode may have multiple 
"watches" if a hard link to a "watched" file is itself being "watched")
which is sent to user space upon system call exit.  

This is similar to Inotify in that the audit subsystem watches for file
system activity and collects information about inodes its interested 
in, but this is where the similarities stop.  Despite the fact that the
Inotify requirements only dictate a subset of the activity the audit
subsystem is interested in, there is a more fundamental divergence 
between the two projects.  Like audit, Inotify takes paths and resolves 
them to a single inode.  But, unlike audit, Inotify does not find the path 
itself interesting.  Much like the (device,inode)-based system call filters 
currently available in the audit subsystem, Inotify targets only individual 
inodes.  Thus, if the underlying inode associated with the file /etc/shadow 
was changed, and /etc/shadow was being "watched", we'd lose auditability 
on /etc/shadow across transactions.  More so, Inotify cannot watch inodes 
that do not yet exist (because the file does not yet exist).  To do this, the 
audit subsystem must hook deeper than Inotify (in fs/dcache.c) to adapt 
with the file system as it changes.  Where it makes sense, the small set of 
notification hooks in the VFS that Inotify and audit could share should be 
consolidated.

Some notable implementation details are as follows:

  * struct inode is _not_ extended to associate audit data with the
    inode.  A hash table is used in which the inode is hashed to 
    retrieve its audit data.  We know if an inode has audit data
    if I_AUDIT has been turned on in inode->i_state.
  * Inodes with audit data are implicitly pinned in memory when 
    I_AUDIT is turned on in inode->i_state.  This prevents an
    auditable incore inode from being pushed out of the icache,
    preserving auditability even under memory pressures.

The user interface provided in kernel/audit.c is extended to allow the
administrator to add "watches", remove "watches", and list "watches".
Once the "watch" is inserted into the file system by the administrator, 
the audit subsystem takes over its maintenance until its removal.

We've submitted for inclusion to the -mm tree.

Thank you.

-tim

Signed-off-by:  Timothy R. Chavez <tinytim@us.ibm.com>
---
 fs/attr.c                   |    3
 fs/dcache.c                 |    9
 fs/inode.c                  |    7
 fs/namei.c                  |   13
 fs/open.c                   |    6
 include/linux/audit.h       |   74 +++
 include/linux/fs.h          |    3
 init/Kconfig                |   10
 kernel/Makefile             |    1
 kernel/audit.c              |   23 +
 kernel/auditfs.c            |  855 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/auditsc.c            |  138 +++++++
 security/selinux/nlmsgtab.c |    3
 13 files changed, 1140 insertions(+), 5 deletions(-)
---
diff -Nurp linux-2.6.13-rc1-mm1/fs/attr.c linux-2.6.13-rc1-mm1~auditfs/fs/attr.c
--- linux-2.6.13-rc1-mm1/fs/attr.c	2011-07-05 01:57:30.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/fs/attr.c	2011-07-05 02:01:36.000000000 -0500
@@ -15,6 +15,7 @@
 #include <linux/quotaops.h>
 #include <linux/security.h>
 #include <linux/time.h>
+#include <linux/audit.h>
 
 /* Taken over from the old code... */
 
@@ -69,6 +70,8 @@ int inode_setattr(struct inode * inode, 
 	unsigned int ia_valid = attr->ia_valid;
 	int error = 0;
 
+	audit_notify_watch(inode, MAY_WRITE);	
+
 	if (ia_valid & ATTR_SIZE) {
 		if (attr->ia_size != i_size_read(inode)) {
 			error = vmtruncate(inode, attr->ia_size);
diff -Nurp linux-2.6.13-rc1-mm1/fs/dcache.c linux-2.6.13-rc1-mm1~auditfs/fs/dcache.c
--- linux-2.6.13-rc1-mm1/fs/dcache.c	2011-07-05 01:57:30.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/fs/dcache.c	2011-07-05 02:01:36.000000000 -0500
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
+		audit_update_watch(dentry, 1);
 		dentry->d_inode = NULL;
 		list_del_init(&dentry->d_alias);
 		spin_unlock(&dentry->d_lock);
@@ -966,6 +968,7 @@ void d_instantiate(struct dentry *entry,
 	if (inode)
 		list_add(&entry->d_alias, &inode->i_dentry);
 	entry->d_inode = inode;
+	audit_update_watch(entry, 0);
 	spin_unlock(&dcache_lock);
 	security_d_instantiate(entry, inode);
 }
@@ -1142,6 +1145,7 @@ struct dentry *d_splice_alias(struct ino
 		new = __d_find_alias(inode, 1);
 		if (new) {
 			BUG_ON(!(new->d_flags & DCACHE_DISCONNECTED));
+			audit_update_watch(new, 0);
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(new, inode);
 			d_rehash(dentry);
@@ -1151,6 +1155,7 @@ struct dentry *d_splice_alias(struct ino
 			/* d_instantiate takes dcache_lock, so we do it by hand */
 			list_add(&dentry->d_alias, &inode->i_dentry);
 			dentry->d_inode = inode;
+			audit_update_watch(dentry, 0);
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(dentry, inode);
 			d_rehash(dentry);
@@ -1254,6 +1259,7 @@ struct dentry * __d_lookup(struct dentry
 		if (!d_unhashed(dentry)) {
 			atomic_inc(&dentry->d_count);
 			found = dentry;
+			audit_update_watch(dentry, 0);
 		}
 		spin_unlock(&dentry->d_lock);
 		break;
@@ -1463,6 +1469,8 @@ void d_move(struct dentry * dentry, stru
 		spin_lock(&target->d_lock);
 	}
 
+	audit_update_watch(dentry, 1);
+
 	/* Move the dentry to the target hash queue, if on different bucket */
 	if (dentry->d_flags & DCACHE_UNHASHED)
 		goto already_unhashed;
@@ -1496,6 +1504,7 @@ already_unhashed:
 		list_add(&target->d_child, &target->d_parent->d_subdirs);
 	}
 
+	audit_update_watch(dentry, 0);
 	list_add(&dentry->d_child, &dentry->d_parent->d_subdirs);
 	spin_unlock(&target->d_lock);
 	spin_unlock(&dentry->d_lock);
diff -Nurp linux-2.6.13-rc1-mm1/fs/inode.c linux-2.6.13-rc1-mm1~auditfs/fs/inode.c
--- linux-2.6.13-rc1-mm1/fs/inode.c	2011-07-05 01:57:30.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/fs/inode.c	2011-07-05 02:01:36.000000000 -0500
@@ -22,6 +22,7 @@
 #include <linux/cdev.h>
 #include <linux/bootmem.h>
 #include <linux/inotify.h>
+#include <linux/audit.h>
 
 /*
  * This is needed for the following functions:
@@ -173,6 +174,7 @@ void destroy_inode(struct inode *inode) 
 {
 	if (inode_has_buffers(inode))
 		BUG();
+	audit_inode_free(inode);
 	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode)
 		inode->i_sb->s_op->destroy_inode(inode);
@@ -262,7 +264,7 @@ void clear_inode(struct inode *inode)
 		bd_forget(inode);
 	if (inode->i_cdev)
 		cd_forget(inode);
-	inode->i_state = I_CLEAR;
+	inode->i_state = I_CLEAR | (inode->i_state & I_AUDIT);
 }
 
 EXPORT_SYMBOL(clear_inode);
@@ -1051,7 +1053,7 @@ void generic_delete_inode(struct inode *
 	hlist_del_init(&inode->i_hash);
 	spin_unlock(&inode_lock);
 	wake_up_inode(inode);
-	if (inode->i_state != I_CLEAR)
+	if ((inode->i_state & ~I_AUDIT) != I_CLEAR)
 		BUG();
 	destroy_inode(inode);
 }
@@ -1364,6 +1366,7 @@ void __init inode_init(unsigned long mem
 				0, SLAB_RECLAIM_ACCOUNT|SLAB_PANIC, init_once, NULL);
 	set_shrinker(DEFAULT_SEEKS, shrink_icache_memory);
 
+	audit_filesystem_init();
 	/* Hash may have been set up in inode_init_early */
 	if (!hashdist)
 		return;
diff -Nurp linux-2.6.13-rc1-mm1/fs/namei.c linux-2.6.13-rc1-mm1~auditfs/fs/namei.c
--- linux-2.6.13-rc1-mm1/fs/namei.c	2011-07-05 01:57:30.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/fs/namei.c	2011-07-05 02:01:36.000000000 -0500
@@ -243,6 +243,8 @@ int permission(struct inode *inode, int 
 	}
 

+	audit_notify_watch(inode, mask);
+
 	/* Ordinary permission routines do not understand MAY_APPEND. */
 	submask = mask & ~MAY_APPEND;
 	if (inode->i_op && inode->i_op->permission)
@@ -358,6 +360,8 @@ static inline int exec_permission_lite(s
 	if (inode->i_op && inode->i_op->permission)
 		return -EAGAIN;
 
+	audit_notify_watch(inode, MAY_EXEC);
+
 	if (current->fsuid == inode->i_uid)
 		mode >>= 6;
 	else if (in_group_p(inode->i_gid))
@@ -1188,6 +1192,8 @@ static inline int may_delete(struct inod
 
 	BUG_ON(victim->d_parent->d_inode != dir);
 
+	audit_notify_watch(victim->d_inode, MAY_WRITE);
+
 	error = permission(dir,MAY_WRITE | MAY_EXEC, NULL);
 	if (error)
 		return error;
@@ -1312,6 +1318,7 @@ int vfs_create(struct inode *dir, struct
 	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode, nd);
 	if (!error) {
+		audit_notify_watch(dentry->d_inode, MAY_WRITE);
 		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_create(dir, dentry, mode);
 	}
@@ -1637,6 +1644,7 @@ int vfs_mknod(struct inode *dir, struct 
 	DQUOT_INIT(dir);
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
 	if (!error) {
+		audit_notify_watch(dentry->d_inode, MAY_WRITE);
 		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_mknod(dir, dentry, mode, dev);
 	}
@@ -1710,6 +1718,7 @@ int vfs_mkdir(struct inode *dir, struct 
 	DQUOT_INIT(dir);
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	if (!error) {
+		audit_notify_watch(dentry->d_inode, MAY_WRITE);
 		fsnotify_mkdir(dir, dentry->d_name.name);
 		security_inode_post_mkdir(dir,dentry, mode);
 	}
@@ -1951,6 +1960,7 @@ int vfs_symlink(struct inode *dir, struc
 	DQUOT_INIT(dir);
 	error = dir->i_op->symlink(dir, dentry, oldname);
 	if (!error) {
+		audit_notify_watch(dentry->d_inode, MAY_WRITE);
 		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_symlink(dir, dentry, oldname);
 	}
@@ -2024,6 +2034,7 @@ int vfs_link(struct dentry *old_dentry, 
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
 	up(&old_dentry->d_inode->i_sem);
 	if (!error) {
+		audit_notify_watch(new_dentry->d_inode, MAY_WRITE);
 		fsnotify_create(dir, new_dentry->d_name.name);
 		security_inode_post_link(old_dentry, dir, new_dentry);
 	}
@@ -2147,6 +2158,7 @@ static int vfs_rename_dir(struct inode *
 	}
 	if (!error) {
 		d_move(old_dentry,new_dentry);
+		audit_notify_watch(old_dentry->d_inode, MAY_WRITE);
 		security_inode_post_rename(old_dir, old_dentry,
 					   new_dir, new_dentry);
 	}
@@ -2175,6 +2187,7 @@ static int vfs_rename_other(struct inode
 		/* The following d_move() should become unconditional */
 		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
 			d_move(old_dentry, new_dentry);
+		audit_notify_watch(old_dentry->d_inode, MAY_WRITE);
 		security_inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
 	}
 	if (target)
diff -Nurp linux-2.6.13-rc1-mm1/fs/open.c linux-2.6.13-rc1-mm1~auditfs/fs/open.c
--- linux-2.6.13-rc1-mm1/fs/open.c	2011-07-05 01:57:31.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/fs/open.c	2011-07-05 02:01:36.000000000 -0500
@@ -25,6 +25,7 @@
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
 #include <linux/rcupdate.h>
+#include <linux/audit.h>
 
 #include <asm/unistd.h>
 
@@ -608,6 +609,8 @@ asmlinkage long sys_fchmod(unsigned int 
 
 	dentry = file->f_dentry;
 	inode = dentry->d_inode;
+	
+	audit_notify_watch(inode, MAY_WRITE);
 
 	err = -EROFS;
 	if (IS_RDONLY(inode))
@@ -640,6 +643,8 @@ asmlinkage long sys_chmod(const char __u
 	if (error)
 		goto out;
 	inode = nd.dentry->d_inode;
+	
+	audit_notify_watch(inode, MAY_WRITE);
 
 	error = -EROFS;
 	if (IS_RDONLY(inode))
@@ -674,6 +679,7 @@ static int chown_common(struct dentry * 
 		printk(KERN_ERR "chown_common: NULL inode\n");
 		goto out;
 	}
+	audit_notify_watch(inode, MAY_WRITE);
 	error = -EROFS;
 	if (IS_RDONLY(inode))
 		goto out;
diff -Nurp linux-2.6.13-rc1-mm1/include/linux/audit.h linux-2.6.13-rc1-mm1~auditfs/include/linux/audit.h
--- linux-2.6.13-rc1-mm1/include/linux/audit.h	2011-07-05 01:57:32.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/include/linux/audit.h	2011-07-05 02:01:36.000000000 -0500
@@ -24,9 +24,16 @@
 #ifndef _LINUX_AUDIT_H_
 #define _LINUX_AUDIT_H_
 
+#ifdef __KERNEL__
 #include <linux/sched.h>
 #include <linux/elf.h>
 
+struct hlist_head;
+struct hlist_node;
+struct dentry;
+struct atomic_t;
+#endif
+
 /* The netlink messages for the audit system is divided into blocks:
  * 1000 - 1099 are for commanding the audit system
  * 1100 - 1199 user space trusted application messages
@@ -68,6 +75,7 @@
 #define AUDIT_CONFIG_CHANGE	1305	/* Audit system configuration change */
 #define AUDIT_SOCKADDR		1306	/* sockaddr copied as syscall arg */
 #define AUDIT_CWD		1307	/* Current working directory */
+#define AUDIT_FS_INODE		1308	/* File system inode */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
@@ -175,6 +183,9 @@
 #define AUDIT_ARCH_V850		(EM_V850|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_X86_64	(EM_X86_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 
+/* 32 byte max key size */
+#define AUDIT_FILTERKEY_MAX   32
+
 struct audit_status {
 	__u32		mask;		/* Bit mask for valid entries */
 	__u32		enabled;	/* 1 = enabled, 0 = disabled */
@@ -195,13 +206,52 @@ struct audit_rule {		/* for AUDIT_LIST, 
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
@@ -248,6 +298,7 @@ extern int audit_filter_user(struct netl
 #define audit_inode(n,i,f) do { ; } while (0)
 #define audit_receive_filter(t,p,u,s,d,l) ({ -EOPNOTSUPP; })
 #define auditsc_get_stamp(c,t,s) do { BUG(); } while (0)
+#define audit_receive_filter(t,p,u,s,d,l) ({ -EOPNOTSUPP; })
 #define audit_get_loginuid(c) ({ -1; })
 #define audit_ipc_perms(q,u,g,m) ({ 0; })
 #define audit_socketcall(n,a) ({ 0; })
@@ -257,6 +308,29 @@ extern int audit_filter_user(struct netl
 #define audit_filter_user(cb,t) ({ 1; })
 #endif
 
+#ifdef CONFIG_AUDITFILESYSTEM
+extern int audit_filesystem_init(void);
+extern int audit_list_watches(int pid, int seq);
+extern int audit_receive_watch(int type, int pid, int uid, int seq,
+			       struct watch_transport *req, uid_t loginuid);
+extern void audit_inode_free(struct inode *inode);
+extern void audit_update_watch(struct dentry *dentry, int remove);
+extern void audit_watch_put(struct audit_watch *watch);
+extern struct audit_watch *audit_watch_get(struct audit_watch *watch);
+extern void audit_notify_watch(struct inode *inode, int mask);
+extern void auditfs_attach_wdata(struct inode *inode, struct hlist_head *watches,
+				 int mask);
+#else
+#define audit_filesystem_init() ({ 0; })
+#define audit_list_watches(p,s) ({ -EOPNOTSUPP; })
+#define audit_receive_watch(t,p,u,s,r,l) ({ -EOPNOTSUPP; })
+#define audit_inode_free(i) do { ; } while(0)
+#define audit_update_watch(d,r) do { ; } while (0)
+#define audit_watch_put(w) do { ; } while(0)
+#define audit_watch_get(w) ({ 0; })
+#define audit_notify_watch(i,m) do { ; } while(0)
+#endif
+
 #ifdef CONFIG_AUDIT
 /* These are defined in audit.c */
 				/* Public API */
diff -Nurp linux-2.6.13-rc1-mm1/include/linux/fs.h linux-2.6.13-rc1-mm1~auditfs/include/linux/fs.h
--- linux-2.6.13-rc1-mm1/include/linux/fs.h	2011-07-05 01:57:32.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/include/linux/fs.h	2011-07-05 02:01:36.000000000 -0500
@@ -228,6 +228,7 @@ struct poll_table_struct;
 struct kstatfs;
 struct vm_area_struct;
 struct vfsmount;
+struct audit_inode_data;
 
 /* Used to be a macro which just called the function, now just a function */
 extern void update_atime (struct inode *);
@@ -1060,6 +1061,8 @@ struct super_operations {
 #define I_CLEAR			32
 #define I_NEW			64
 #define I_WILL_FREE		128
+#define I_AUDIT			256
+
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
 
diff -Nurp linux-2.6.13-rc1-mm1/init/Kconfig linux-2.6.13-rc1-mm1~auditfs/init/Kconfig
--- linux-2.6.13-rc1-mm1/init/Kconfig	2011-07-05 01:56:42.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/init/Kconfig	2011-07-05 02:01:36.000000000 -0500
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
diff -Nurp linux-2.6.13-rc1-mm1/kernel/audit.c linux-2.6.13-rc1-mm1~auditfs/kernel/audit.c
--- linux-2.6.13-rc1-mm1/kernel/audit.c	2011-07-05 01:57:32.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/kernel/audit.c	2011-07-05 02:01:36.000000000 -0500
@@ -109,8 +109,13 @@ static DECLARE_WAIT_QUEUE_HEAD(kauditd_w
 static DECLARE_WAIT_QUEUE_HEAD(audit_backlog_wait);
 
 /* The netlink socket is only to be read by 1 CPU, which lets us assume
- * that list additions and deletions never happen simultaneously in
- * auditsc.c */
+ * that list additions and deletions, and watch insertions never happen
+ * simultaneiously in auditsc.c and auditfs.c respectively.
+ *
+ * Even though there can only be one watch removal via netlink at a time,
+ * there is still a chance of watch removal via a hook.  In this case, the
+ * semaphore is not enough.
+ */
 DECLARE_MUTEX(audit_netlink_sem);
 
 /* AUDIT_BUFSIZ is the size of the temporary buffer used for formatting
@@ -346,6 +351,9 @@ static int audit_netlink_ok(kernel_cap_t
 	case AUDIT_SET:
 	case AUDIT_ADD:
 	case AUDIT_DEL:
+	case AUDIT_WATCH_LIST:
+	case AUDIT_WATCH_INS:
+	case AUDIT_WATCH_REM:
 	case AUDIT_SIGNAL_INFO:
 		if (!cap_raised(eff_cap, CAP_AUDIT_CONTROL))
 			err = -EPERM;
@@ -462,6 +470,17 @@ static int audit_receive_msg(struct sk_b
 		audit_send_reply(NETLINK_CB(skb).pid, seq, AUDIT_SIGNAL_INFO, 
 				0, 0, &sig_data, sizeof(sig_data));
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
 	default:
 		err = -EINVAL;
 		break;
diff -Nurp linux-2.6.13-rc1-mm1/kernel/auditfs.c linux-2.6.13-rc1-mm1~auditfs/kernel/auditfs.c
--- linux-2.6.13-rc1-mm1/kernel/auditfs.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.13-rc1-mm1~auditfs/kernel/auditfs.c	2011-07-05 02:01:36.000000000 -0500
@@ -0,0 +1,855 @@
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
+#include <linux/kthread.h>
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
+spinlock_t auditfs_lock = SPIN_LOCK_UNLOCKED;
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
+static spinlock_t auditfs_hash_lock = SPIN_LOCK_UNLOCKED;
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
+		BUG_ON(!hlist_unhashed(&watch->w_watched));
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
+		goto audit_to_watch_fail;
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
+        t = kmalloc(size, GFP_KERNEL);
+        if (!t)
+                goto audit_to_transport_exit;
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
+audit_to_transport_exit:
+	return t;
+}
+
+static inline void audit_destroy_watch(struct audit_watch *watch)
+{
+	if (watch) {
+		if (!hlist_unhashed(&watch->w_watched)) {
+			hlist_del_init(&watch->w_watched);
+			audit_watch_put(watch);
+		}
+	
+		if (!hlist_unhashed(&watch->w_master)) {
+			hlist_del_init(&watch->w_master);
+			audit_watch_put(watch);
+		}
+
+		if (!hlist_unhashed(&watch->w_node)) {
+			hlist_del_init(&watch->w_node);
+			audit_watch_put(watch);
+		}
+	}
+}
+
+static inline void audit_drain_watchlist(struct audit_inode_data *data)
+{
+	struct audit_watch *watch;
+	struct hlist_node *pos, *tmp;
+
+	spin_lock(&auditfs_lock);
+	hlist_for_each_entry_safe(watch, pos, tmp, &data->watchlist, w_node) {
+		audit_destroy_watch(watch);
+		audit_data_pool_shrink();
+		audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE, "auid=%u removed watch implicitly", -1);
+	}
+	spin_unlock(&auditfs_lock);
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
+	spin_lock(&auditfs_lock);
+	hlist_add_head(&watch->w_node, &pdata->watchlist);
+	audit_watch_get(watch);
+	hlist_add_head(&watch->w_master, &master_watchlist);
+	spin_unlock(&auditfs_lock);
+
+	audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE, "auid=%u inserted watch", loginuid);
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
+		audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE, "auid=%u removed watch", loginuid);
+		audit_data_pool_shrink();
+	}
+
+	return ret;
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
+ */
+void audit_update_watch(struct dentry *dentry, int remove)
+{
+	struct audit_watch *this, *watch;
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
+		if (watch && !hlist_unhashed(&watch->w_watched)) {
+			hlist_del_init(&watch->w_watched);
+			audit_watch_put(watch);
+		}
+	} else {
+		hlist_for_each_entry_safe(this, pos, tmp, &data->watches, w_watched)
+			if (hlist_unhashed(&this->w_node)) {
+				hlist_del_init(&this->w_watched);
+				audit_watch_put(this);
+			}
+		if (watch && hlist_unhashed(&watch->w_watched)) {
+			audit_watch_get(watch);
+			hlist_add_head(&watch->w_watched, &data->watches);
+		}
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
+ * This list is only a "snapshot in time".  It is not gospel.
+ */
+static int audit_list_watches_fn(void *_dest)
+{
+	int ret;
+	int pid, seq;
+	struct hlist_head skb_list;
+	struct hlist_node *tmp, *pos;
+	struct audit_skb_list *entry;
+	struct audit_watch *watch;
+	int *dest = _dest;
+
+	pid = dest[0];
+	seq = dest[1];
+	kfree(dest);
+
+	down(&audit_netlink_sem);
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
+			audit_watch_put(watch);
+			goto audit_list_watches_fail;
+		}
+
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
+			spin_unlock(&auditfs_lock);
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
+	audit_send_reply(pid, seq, AUDIT_WATCH_LIST, 1, 1, NULL, 0);
+	
+	up(&audit_netlink_sem);
+	return 0;
+
+audit_list_watches_fail:
+	hlist_for_each_entry_safe(entry, pos, tmp, &skb_list, list) {
+		hlist_del(&entry->list);
+		kfree(entry->memblk);
+		kfree(entry);
+	}
+	up(&audit_netlink_sem);
+	return ret;
+}
+
+int audit_list_watches(int pid, int seq)
+{
+	struct task_struct *tsk;
+	int *dest = kmalloc(2 * sizeof(int), GFP_KERNEL);
+	if (!dest)
+		return -ENOMEM;
+	dest[0] = pid;
+	dest[1] = seq;
+
+	tsk = kthread_run(audit_list_watches_fn, dest, "audit_list_watches");
+	if (IS_ERR(tsk)) {
+		kfree(dest);
+		return PTR_ERR(tsk);
+	}
+	return 0;
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
+		spin_lock(&auditfs_lock);
+		hlist_for_each_entry_safe(watch, pos, tmp, &data->watches, w_watched) {
+			hlist_del(&watch->w_watched);
+                	audit_watch_put(watch);
+        	}
+		spin_unlock(&auditfs_lock);
+		audit_data_put(data);
+	}
+}
+
+int audit_filesystem_init(void)
+{
+
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
+	return -ENOMEM;
+}
+
+
+void audit_notify_watch(struct inode *inode, int mask)
+{
+	struct audit_inode_data *data;
+
+	if (likely(!audit_enabled))
+		return;
+
+	if (!inode || !current->audit_context)
+		return;
+
+	data = audit_data_get(inode, 0);
+	if (!data)
+		return;
+
+	if (hlist_empty(&data->watches))
+		goto out;
+
+	auditfs_attach_wdata(inode, &data->watches, mask);
+
+out:
+	audit_data_put(data);
+}
+
diff -Nurp linux-2.6.13-rc1-mm1/kernel/auditsc.c linux-2.6.13-rc1-mm1~auditfs/kernel/auditsc.c
--- linux-2.6.13-rc1-mm1/kernel/auditsc.c	2011-07-05 01:57:32.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/kernel/auditsc.c	2011-07-05 02:01:36.000000000 -0500
@@ -134,6 +134,17 @@ struct audit_aux_data_path {
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
@@ -664,13 +675,26 @@ static inline void audit_free_names(stru
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
+                        }
+			break; }
 		}
+		
 		context->aux = aux->next;
 		kfree(aux);
 	}
@@ -783,6 +807,8 @@ static void audit_log_exit(struct audit_
 	int i;
 	struct audit_buffer *ab;
 	struct audit_aux_data *aux;
+	struct audit_watch_info *winfo;
+	struct hlist_node *pos;
 
 	ab = audit_log_start(context, GFP_KERNEL, AUDIT_SYSCALL);
 	if (!ab)
@@ -848,6 +874,29 @@ static void audit_log_exit(struct audit_
 			audit_log_d_path(ab, "path=", axi->dentry, axi->mnt);
 			break; }
 
+		case AUDIT_FS_INODE: {
+			struct audit_aux_data_watched *axi = (void *)aux;
+			struct audit_buffer *sub_ab;
+			audit_log_format(ab,
+					"inode=%lu inode_uid=%u inode_gid=%u"
+					" inode_dev=%02x:%02x inode_rdev=%02x:%02x",
+					axi->ino, axi->uid, axi->gid,
+					MAJOR(axi->dev), MINOR(axi->dev),
+					MAJOR(axi->rdev), MINOR(axi->rdev));
+			hlist_for_each_entry(winfo, pos, &axi->watches, node) {
+				sub_ab = audit_log_start(context, GFP_KERNEL, AUDIT_FS_WATCH);
+				if (!sub_ab)
+					return;         /* audit_panic has been called */
+				audit_log_format(sub_ab, "watch_inode=%lu", axi->ino);
+				audit_log_format(sub_ab, " watch=");
+				audit_log_untrustedstring(sub_ab, winfo->watch->w_name);
+				audit_log_format(sub_ab,
+						" filterkey=%s perm=%u perm_mask=%u",
+						winfo->watch->w_filterkey,
+						winfo->watch->w_perms, axi->mask);
+				audit_log_end(sub_ab);
+			}
+			break; }
 		}
 		audit_log_end(ab);
 	}
@@ -1267,3 +1316,90 @@ void audit_signal_info(int sig, struct t
 	}
 }
 
+#ifdef CONFIG_AUDITFILESYSTEM
+extern spinlock_t auditfs_lock;
+
+/* This has to be here instead of in auditfs.c, because it needs to
+   see the audit context */
+void auditfs_attach_wdata(struct inode *inode, struct hlist_head *watches,
+			 int mask)
+{
+	struct audit_context *context = current->audit_context;
+	struct audit_aux_data_watched *ax;
+	struct audit_watch *watch;
+	struct audit_watch_info *this, *winfo;
+	struct hlist_node *pos, *tmp;
+
+	if (!context)
+		return;
+
+	ax = kmalloc(sizeof(*ax), GFP_KERNEL);
+	if (!ax)
+		return;
+
+	INIT_HLIST_HEAD(&ax->watches);
+
+	spin_lock(&auditfs_lock);
+	hlist_for_each_entry(watch, pos, watches, w_watched) {
+	restart:
+		audit_watch_get(watch);
+		spin_unlock(&auditfs_lock);
+		winfo = kmalloc(sizeof(struct audit_watch_info), GFP_KERNEL);
+		if (!winfo)
+			goto auditfs_attach_wdata_fail;
+ 		if (mask && (watch->w_perms && !(watch->w_perms&mask))) {
+			spin_lock(&auditfs_lock);
+			continue;
+		}
+		winfo->watch = audit_watch_get(watch);
+		hlist_add_head(&winfo->node, &ax->watches);
+		spin_lock(&auditfs_lock);
+		if (hlist_unhashed(&watch->w_watched)) {
+			audit_watch_put(watch);
+			/* Someone took it off the list while we didn't have it locked.
+			   Go through the list of watches again until we find one which
+			   we haven't already dealt with... */
+			hlist_for_each_entry(watch, pos, watches, w_watched) {
+				hlist_for_each_entry(winfo, tmp, &ax->watches, node) {
+					if (winfo->watch == watch)
+						continue;
+				}
+				/* This watch wasn't found on ax's list, so
+				   pick up where we left off. */
+				goto restart;
+			}
+			/* We'd actually covered every watch that still exists */
+			break;
+		}
+		audit_watch_put(watch);
+	}
+	spin_unlock(&auditfs_lock);
+
+	if (context->in_syscall && !context->auditable &&
+		 AUDIT_DISABLED != audit_filter_syscall(current, context,
+							&audit_filter_list[AUDIT_FILTER_WATCH]))
+		 context->auditable = 1;
+
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
+	return;
+
+auditfs_attach_wdata_fail:
+	hlist_for_each_entry_safe(this, pos, tmp, &ax->watches, node) {
+		hlist_del(&this->node);
+		audit_watch_put(this->watch);
+		kfree(this);
+	}
+	kfree(ax);
+}
+
+#endif /* CONFIG_AUDITFILESYSTEM */
diff -Nurp linux-2.6.13-rc1-mm1/kernel/Makefile linux-2.6.13-rc1-mm1~auditfs/kernel/Makefile
--- linux-2.6.13-rc1-mm1/kernel/Makefile	2011-07-05 01:57:32.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/kernel/Makefile	2011-07-05 02:01:36.000000000 -0500
@@ -26,6 +26,7 @@ obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+obj-$(CONFIG_AUDITFILESYSTEM) += auditfs.o
 obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_DETECT_SOFTLOCKUP) += softlockup.o
diff -Nurp linux-2.6.13-rc1-mm1/security/selinux/nlmsgtab.c linux-2.6.13-rc1-mm1~auditfs/security/selinux/nlmsgtab.c
--- linux-2.6.13-rc1-mm1/security/selinux/nlmsgtab.c	2011-07-05 01:56:42.000000000 -0500
+++ linux-2.6.13-rc1-mm1~auditfs/security/selinux/nlmsgtab.c	2011-07-05 02:01:36.000000000 -0500
@@ -100,6 +100,9 @@ static struct nlmsg_perm nlmsg_audit_per
 	{ AUDIT_DEL,		NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
 	{ AUDIT_USER,		NETLINK_AUDIT_SOCKET__NLMSG_RELAY    },
 	{ AUDIT_SIGNAL_INFO,	NETLINK_AUDIT_SOCKET__NLMSG_READ     },
+	{ AUDIT_WATCH_INS,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
+	{ AUDIT_WATCH_REM,	NETLINK_AUDIT_SOCKET__NLMSG_WRITE    },
+	{ AUDIT_WATCH_LIST,	NETLINK_AUDIT_SOCKET__NLMSG_READPRIV },
 };
 


