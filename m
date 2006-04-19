Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWDSRxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWDSRxw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 13:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWDSRxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 13:53:52 -0400
Received: from ns2.suse.de ([195.135.220.15]:60061 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751037AbWDSRxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 13:53:46 -0400
From: Tony Jones <tonyj@suse.de>
To: linux-kernel@vger.kernel.org
Cc: chrisw@sous-sol.org, Tony Jones <tonyj@suse.de>,
       linux-security-module@vger.kernel.org
Date: Wed, 19 Apr 2006 10:49:21 -0700
Message-Id: <20060419174921.29149.80148.sendpatchset@ermintrude.int.wirex.com>
In-Reply-To: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
Subject: [RFC][PATCH 2/11] security: AppArmor - Core headers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the various common headerfiles used by the AppArmor module.

apparmor.h contains the core data structures.
shared.h contains definitions that are common to the userspace policy loader.
inline.h implements various inline utility functions


Signed-off-by: Tony Jones <tonyj@suse.de>

---
 security/apparmor/apparmor.h |  325 +++++++++++++++++++++++++++++++++++++++++
 security/apparmor/inline.h   |  333 +++++++++++++++++++++++++++++++++++++++++++
 security/apparmor/shared.h   |   41 +++++
 3 files changed, 699 insertions(+)

--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/apparmor.h
@@ -0,0 +1,325 @@
+/*
+ *	Copyright (C) 1998-2005 Novell/SUSE
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2 of the
+ *	License.
+ *
+ *	AppArmor internal prototypes
+ */
+
+#ifndef __SUBDOMAIN_H
+#define __SUBDOMAIN_H
+
+#include <linux/fs.h>	/* Include for defn of iattr */
+#include <linux/rcupdate.h>
+
+#include "shared.h"
+
+/* Control parameters (0 or 1), settable thru module/boot flags or
+ * via /sys/kernel/security/apparmor/control */
+extern int apparmor_complain;
+extern int apparmor_debug;
+extern int apparmor_audit;
+extern int apparmor_logsyscall;
+
+/* PIPEFS_MAGIC */
+#include <linux/pipe_fs_i.h>
+/* from net/socket.c */
+#define SOCKFS_MAGIC 0x534F434B
+/* from inotify.c  */
+#define INOTIFYFS_MAGIC 0xBAD1DEA
+
+#define VALID_FSTYPE(inode) ((inode)->i_sb->s_magic != PIPEFS_MAGIC && \
+                             (inode)->i_sb->s_magic != SOCKFS_MAGIC && \
+                             (inode)->i_sb->s_magic != INOTIFYFS_MAGIC)
+
+#define PROFILE_COMPLAIN(_profile) \
+	(apparmor_complain == 1 || ((_profile) && (_profile)->flags.complain))
+
+#define SUBDOMAIN_COMPLAIN(_sd) \
+	(apparmor_complain == 1 || \
+	 ((_sd) && (_sd)->active && (_sd)->active->flags.complain))
+
+#define PROFILE_AUDIT(_profile) \
+	(apparmor_audit == 1 || ((_profile) && (_profile)->flags.audit))
+
+#define SUBDOMAIN_AUDIT(_sd) \
+	(apparmor_audit == 1 || \
+	 ((_sd) && (_sd)->active && (_sd)->active->flags.audit))
+
+/*
+ * DEBUG remains global (no per profile flag) since it is mostly used in sysctl
+ * which is not related to profile accesses.
+ */
+
+#define AA_DEBUG(fmt, args...)						\
+	do {								\
+		if (apparmor_debug)					\
+			printk(KERN_DEBUG "AppArmor: " fmt, ##args);	\
+	} while (0)
+#define AA_INFO(fmt, args...)	printk(KERN_INFO "AppArmor: " fmt, ##args)
+#define AA_WARN(fmt, args...)	printk(KERN_WARNING "AppArmor: " fmt, ##args)
+#define AA_ERROR(fmt, args...)	printk(KERN_ERR "AppArmor: " fmt, ##args)
+
+/* basic AppArmor data structures */
+
+struct flagval {
+	int debug;
+	int complain;
+	int audit;
+};
+
+enum entry_match_type {
+	aa_entry_literal,
+	aa_entry_tailglob,
+	aa_entry_pattern,
+	aa_entry_invalid
+};
+
+/* struct aa_entry - file ACL *
+ * @filename: filename controlled by this ACL
+ * @mode: permissions granted by ACL
+ * @type: type of match to perform against @filename
+ * @extradata: any extra data needed by an extended matching type
+ * @list: list the ACL is on
+ * @listp: permission partitioned lists this ACL is on.
+ *
+ * Each entry describes a file and an allowed access mode.
+ */
+struct aa_entry {
+	char *filename;
+	int mode;		/* mode is 'or' of READ, WRITE, EXECUTE,
+				 * INHERIT, UNCONSTRAINED, and LIBRARY
+				 * (meaning don't prefetch). */
+
+	enum entry_match_type type;
+	void *extradata;
+
+	struct list_head list;
+	struct list_head listp[POS_AA_FILE_MAX + 1];
+};
+
+#define AA_EXEC_MODIFIER_MASK(mask) ((mask) & (AA_EXEC_UNCONSTRAINED |\
+		      		    AA_EXEC_INHERIT |\
+		      		    AA_EXEC_PROFILE))
+
+#define AA_EXEC_MASK(mask) ((mask) & (AA_MAY_EXEC |\
+		      		    AA_EXEC_UNCONSTRAINED |\
+		      		    AA_EXEC_INHERIT |\
+		      		    AA_EXEC_PROFILE))
+
+
+/* struct aaprofile - basic confinement data
+ * @parent: non refcounted pointer to parent profile
+ * @name: the profiles name
+ * @file_entry: file ACL
+ * @file_entryp: vector of file ACL by permission granted
+ * @list: list this profile is on
+ * @sub: profiles list of subprofiles (HATS)
+ * @flags: flags controlling profile behavior
+ * @null_profile: if needed per profile learning and null confinement profile
+ * @isstale: flag to indicate the profile is stale
+ * @num_file_entries: number of file entries the profile contains
+ * @num_file_pentries: number of file entries for each partitioned list
+ * @capabilities: capabilities granted by the process
+ * @rcu: rcu head used when freeing the profile
+ * @count: reference count of the profile
+ *
+ * The AppArmor profile contains the basic confinement data.  Each profile
+ * has a name and potentially a list of profile entries. The profiles are
+ * connected in a list
+ */
+struct aaprofile {
+	struct aaprofile *parent;
+	char *name;
+
+	struct list_head file_entry;
+	struct list_head file_entryp[POS_AA_FILE_MAX + 1];
+	struct list_head list;
+	struct list_head sub;
+	struct flagval flags;
+	struct aaprofile *null_profile;
+	int isstale;
+
+	int num_file_entries;
+	int num_file_pentries[POS_AA_FILE_MAX + 1];
+
+	kernel_cap_t capabilities;
+
+	struct rcu_head rcu;
+
+	struct kref count;
+};
+
+/**
+ * struct subdomain - primary label for confined tasks
+ * @active: the current active profile
+ * @hat_magic: the magic token controling the ability to leave a hat
+ * @list: list this subdomain is on
+ * @task: task that the subdomain confines
+ *
+ * Contains the tasks current active profile (which could change due to
+ * change_hat).  Plus the hat_magic needed during change_hat.
+ *
+ * N.B AppArmor's previous product name SubDomain was derived from the name
+ * of this structure/concept (changehat reducing a task into a sub-domain).
+ */
+struct subdomain {
+	struct aaprofile *active;	/* The current active profile */
+	u32 hat_magic;			/* used with change_hat */
+	struct list_head list;		/* list of subdomains */
+	struct task_struct *task;
+};
+
+typedef int (*aa_iter) (struct subdomain *, void *);
+
+/* aa_path_data
+ * temp (cookie) data used by aa_path_* functions, see inline.h
+ */
+struct aa_path_data {
+	struct dentry *root, *dentry;
+	struct namespace *namespace;
+	struct list_head *head, *pos;
+	int errno;
+};
+
+#define AA_SUBDOMAIN(sec)	((struct subdomain*)(sec))
+#define AA_PROFILE(sec)		((struct aaprofile*)(sec))
+
+/* Lock protecting access to 'struct subdomain' accesses */
+extern spinlock_t sd_lock;
+
+extern struct aaprofile *null_complain_profile;
+
+/* aa_audit - AppArmor auditing structure
+ * Structure is populated by access control code and passed to aa_audit which
+ * provides for a single point of logging.
+ */
+
+struct aa_audit {
+	unsigned short type, flags;
+	unsigned int result;
+	unsigned int gfp_mask;
+	int error_code;
+
+	const char *name;
+	unsigned int ival;
+	union {
+		const void *pval;
+		va_list vaval;
+	};
+};
+
+/* audit types */
+#define AA_AUDITTYPE_FILE	1
+#define AA_AUDITTYPE_DIR	2
+#define AA_AUDITTYPE_ATTR	3
+#define AA_AUDITTYPE_XATTR	4
+#define AA_AUDITTYPE_LINK	5
+#define AA_AUDITTYPE_CAP	6
+#define AA_AUDITTYPE_MSG	7
+#define AA_AUDITTYPE_SYSCALL	8
+#define AA_AUDITTYPE__END	9
+
+/* audit flags */
+#define AA_AUDITFLAG_AUDITSS_SYSCALL 1 /* log syscall context */
+#define AA_AUDITFLAG_LOGERR	     2 /* log operations that failed due to
+					   non permission errors  */
+
+#define HINT_UNKNOWN_HAT "unknown_hat"
+#define HINT_FORK "fork"
+#define HINT_MANDPROF "missing_mandatory_profile"
+#define HINT_CHGPROF "changing_profile"
+
+#define LOG_HINT(p, gfp, hint, fmt, args...) \
+	do {\
+		aa_audit_message(p, gfp, 0, \
+			"LOGPROF-HINT " hint " " fmt, ##args);\
+	} while(0)
+
+/* directory op type, for aa_perm_dir */
+enum aa_diroptype {
+	aa_dir_mkdir,
+	aa_dir_rmdir
+};
+
+/* xattr op type, for aa_xattr */
+enum aa_xattroptype {
+	aa_xattr_get,
+	aa_xattr_set,
+	aa_xattr_list,
+	aa_xattr_remove
+};
+
+#define BASE_PROFILE(p) ((p)->parent ? (p)->parent : (p))
+#define IN_SUBPROFILE(p) ((p)->parent)
+
+/* main.c */
+extern int alloc_null_complain_profile(void);
+extern void free_null_complain_profile(void);
+extern int attach_nullprofile(struct aaprofile *profile);
+extern int aa_audit_message(struct aaprofile *active, unsigned int gfp, int,
+			    const char *, ...);
+extern int aa_audit_syscallreject(struct aaprofile *active, unsigned int gfp,
+				  const char *);
+extern int aa_audit(struct aaprofile *active, const struct aa_audit *);
+extern char *aa_get_name(struct dentry *dentry, struct vfsmount *mnt);
+
+extern int aa_attr(struct aaprofile *active, struct dentry *dentry,
+		   struct iattr *iattr);
+extern int aa_xattr(struct aaprofile *active, struct dentry *dentry,
+		    const char *xattr, enum aa_xattroptype xattroptype);
+extern int aa_capability(struct aaprofile *active, int cap);
+extern int aa_perm(struct aaprofile *active, struct dentry *dentry,
+		   struct vfsmount *mnt, int mask);
+extern int aa_perm_nameidata(struct aaprofile *active, struct nameidata *nd,
+			     int mask);
+extern int aa_perm_dentry(struct aaprofile *active, struct dentry *dentry,
+			  int mask);
+extern int aa_perm_dir(struct aaprofile *active, struct dentry *dentry,
+		       enum aa_diroptype diroptype);
+extern int aa_link(struct aaprofile *active,
+		   struct dentry *link, struct dentry *target);
+extern int aa_fork(struct task_struct *p);
+extern int aa_register(struct file *file);
+extern void aa_release(struct task_struct *p);
+extern int aa_change_hat(const char *id, u32 hat_magic);
+extern int aa_associate_filp(struct file *filp);
+
+/* list.c */
+extern struct aaprofile *aa_profilelist_find(const char *name);
+extern int aa_profilelist_add(struct aaprofile *profile);
+extern struct aaprofile *aa_profilelist_remove(const char *name);
+extern void aa_profilelist_release(void);
+extern struct aaprofile *aa_profilelist_replace(struct aaprofile *profile);
+extern void aa_profile_dump(struct aaprofile *);
+extern void aa_profilelist_dump(void);
+extern void aa_subdomainlist_add(struct subdomain *);
+extern void aa_subdomainlist_remove(struct subdomain *);
+extern void aa_subdomainlist_iterate(aa_iter, void *);
+extern void aa_subdomainlist_iterateremove(aa_iter, void *);
+extern void aa_subdomainlist_release(void);
+
+/* module_interface.c */
+extern ssize_t aa_file_prof_add(void *, size_t);
+extern ssize_t aa_file_prof_repl(void *, size_t);
+extern ssize_t aa_file_prof_remove(const char *, size_t);
+extern void free_aaprofile(struct aaprofile *profile);
+extern void free_aaprofile_kref(struct kref *kref);
+
+/* procattr.c */
+extern size_t aa_getprocattr(struct aaprofile *active, char *str, size_t size);
+extern int aa_setprocattr_changehat(char *hatinfo, size_t infosize);
+extern int aa_setprocattr_setprofile(struct task_struct *p, char *profilename,
+				     size_t profilesize);
+
+/* apparmorfs.c */
+extern int create_apparmorfs(void);
+extern void destroy_apparmorfs(void);
+
+/* capabilities.c */
+extern const char *capability_to_name(unsigned int cap);
+
+#endif				/* __SUBDOMAIN_H */
--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/inline.h
@@ -0,0 +1,333 @@
+/*
+ *	Copyright (C) 2005 Novell/SUSE
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2 of the
+ *	License.
+ */
+
+#ifndef __INLINE_H
+#define __INLINE_H
+
+#include <linux/namespace.h>
+
+static inline int __aa_is_confined(struct subdomain *sd)
+{
+	return (sd && sd->active);
+}
+
+/**
+ *  aa_is_confined
+ *  Determine whether current task contains a valid profile (confined).
+ *  Return %1 if confined, %0 otherwise.
+ */
+static inline int aa_is_confined(void)
+{
+	struct subdomain *sd = AA_SUBDOMAIN(current->security);
+	return __aa_is_confined(sd);
+}
+
+static inline int __aa_sub_defined(struct subdomain *sd)
+{
+	return __aa_is_confined(sd) && !list_empty(&BASE_PROFILE(sd->active)->sub);
+}
+
+/**
+ * aa_sub_defined - check to see if current task has any subprofiles
+ * Return 1 if true, 0 otherwise
+ */
+static inline int aa_sub_defined(void)
+{
+	struct subdomain *sd = AA_SUBDOMAIN(current->security);
+	return __aa_sub_defined(sd);
+}
+
+/**
+ * get_aaprofile - increment refcount on profile @p
+ * @p: profile
+ */
+static inline struct aaprofile *get_aaprofile(struct aaprofile *p)
+{
+	if (p)
+		kref_get(&(BASE_PROFILE(p)->count));
+
+	return p;
+}
+
+/**
+ * put_aaprofile - decrement refcount on profile @p
+ * @p: profile
+ */
+static inline void put_aaprofile(struct aaprofile *p)
+{
+	if (p)
+		kref_put(&BASE_PROFILE(p)->count, free_aaprofile_kref);
+}
+
+/**
+ * get_task_activeptr_rcu - get pointer to @tsk's active profile.
+ * @tsk: task to get active profile from
+ *
+ * Requires rcu_read_lock is held
+ */
+static inline struct aaprofile *get_task_activeptr_rcu(struct task_struct *tsk)
+{
+	struct subdomain *sd = AA_SUBDOMAIN(tsk->security);
+	struct aaprofile *active = NULL;
+
+	if (sd)
+		active = (struct aaprofile *) rcu_dereference(sd->active);
+
+	return active;
+}
+
+/**
+ * get_activeptr_rcu - get pointer to current task's active profile
+ * Requires rcu_read_lock is held
+ */
+static inline struct aaprofile *get_activeptr_rcu(void)
+{
+	return get_task_activeptr_rcu(current);
+}
+
+/**
+ * get_task_active_aaprofile - get a reference to tsk's active profile.
+ * @tsk: the task to get the active profile reference for
+ */
+static inline struct aaprofile *get_task_active_aaprofile(struct task_struct *tsk)
+{
+	struct aaprofile *active;
+
+	rcu_read_lock();
+	active = get_aaprofile(get_task_activeptr_rcu(tsk));
+	rcu_read_unlock();
+
+	return active;
+}
+
+/**
+ * get_active_aaprofile - get a reference to the current tasks active profile
+ */
+static inline struct aaprofile *get_active_aaprofile(void)
+{
+	return get_task_active_aaprofile(current);
+}
+
+/**
+ * aa_switch - change subdomain to use a new profile
+ * @sd: subdomain to switch the active profile on
+ * @newactive: new active profile
+ *
+ * aa_switch handles the changing of a subdomain's active profile.  The
+ * sd_lock must be held to ensure consistency against other writers.
+ * Some write paths (ex. aa_register) require sd->active not to change
+ * over several operations, so the calling function is responsible
+ * for grabing the sd_lock to meet its consistency constraints before
+ * calling aa_switch
+ */
+static inline void aa_switch(struct subdomain *sd, struct aaprofile *newactive)
+{
+	struct aaprofile *oldactive = sd->active;
+
+	/* noop if NULL */
+	rcu_assign_pointer(sd->active, get_aaprofile(newactive));
+	put_aaprofile(oldactive);
+}
+
+/**
+ * aa_switch_unconfined - change subdomain to be unconfined (no profile)
+ * @sd: subdomain to switch
+ *
+ * aa_switch_unconfined handles the removal of a subdomain's active profile.
+ * The sd_lock must be held to ensure consistency against other writers.
+ * Like aa_switch the sd_lock is used to maintain consistency.
+ */
+static inline void aa_switch_unconfined(struct subdomain *sd)
+{
+	aa_switch(sd, NULL);
+
+	/* reset magic in case we were in a subhat before */
+	sd->hat_magic = 0;
+}
+
+/**
+ * alloc_subdomain - allocate a new subdomain
+ * @tsk: task struct
+ *
+ * Allocate a new subdomain including a backpointer to it's referring task.
+ */
+static inline struct subdomain *alloc_subdomain(struct task_struct *tsk)
+{
+	struct subdomain *sd;
+
+	sd = kzalloc(sizeof(struct subdomain), GFP_KERNEL);
+	if (!sd)
+		goto out;
+
+	/* back pointer to task */
+	sd->task = tsk;
+
+	/* any readers of the list must make sure that they can handle
+	 * case where sd->active is not yet set (null)
+	 */
+	aa_subdomainlist_add(sd);
+
+out:
+	return sd;
+}
+
+/**
+ * free_subdomain - Free a subdomain previously allocated by alloc_subdomain
+ * @sd: subdomain
+ */
+static inline void free_subdomain(struct subdomain *sd)
+{
+	aa_subdomainlist_remove(sd);
+	kfree(sd);
+}
+
+/**
+ * alloc_aaprofile - Allocate, initialize and return a new zeroed profile.
+ * Returns NULL on failure.
+ */
+static inline struct aaprofile *alloc_aaprofile(void)
+{
+	struct aaprofile *profile;
+
+	profile = (struct aaprofile *)kzalloc(sizeof(struct aaprofile),
+					      GFP_KERNEL);
+	AA_DEBUG("%s(%p)\n", __FUNCTION__, profile);
+	if (profile) {
+		int i;
+
+		INIT_LIST_HEAD(&profile->list);
+		INIT_LIST_HEAD(&profile->sub);
+		INIT_LIST_HEAD(&profile->file_entry);
+		for (i = 0; i <= POS_AA_FILE_MAX; i++) {
+			INIT_LIST_HEAD(&profile->file_entryp[i]);
+		}
+		INIT_RCU_HEAD(&profile->rcu);
+		kref_init(&profile->count);
+	}
+	return profile;
+}
+
+/**
+ * aa_put_name
+ * @name: name to release.
+ *
+ * Release space (free_page) allocated to hold pathname
+ * name may be NULL (checked for by free_page)
+ */
+static inline void aa_put_name(const char *name)
+{
+	free_page((unsigned long)name);
+}
+
+/** __aa_find_profile
+ * @name: name of profile to find
+ * @head: list to search
+ *
+ * Return reference counted copy of profile. NULL if not found
+ * Caller must hold any necessary locks
+ */
+static inline struct aaprofile *__aa_find_profile(const char *name,
+						  struct list_head *head)
+{
+	struct aaprofile *p;
+
+	if (!name || !head)
+		return NULL;
+
+	AA_DEBUG("%s: finding profile %s\n", __FUNCTION__, name);
+	list_for_each_entry(p, head, list) {
+		if (!strcmp(p->name, name)) {
+			/* return refcounted object */
+			p = get_aaprofile(p);
+			return p;
+		} else {
+			AA_DEBUG("%s: skipping %s\n", __FUNCTION__, p->name);
+		}
+	}
+	return NULL;
+}
+
+/** __aa_path_begin
+ * @rdentry: filesystem root dentry (searching for vfsmnts matching this)
+ * @dentry: dentry object to obtain pathname from (relative to matched vfsmnt)
+ *
+ * Setup data for iterating over vfsmounts (in current tasks namespace).
+ */
+static inline void __aa_path_begin(struct dentry *rdentry,
+				   struct dentry *dentry,
+				   struct aa_path_data *data)
+{
+	data->dentry = dentry;
+	data->root = dget(rdentry->d_sb->s_root);
+	data->namespace = current->namespace;
+	data->head = &data->namespace->list;
+	data->pos = data->head->next;
+	prefetch(data->pos->next);
+	data->errno = 0;
+
+	down_read(&namespace_sem);
+}
+
+/** aa_path_begin
+ * @dentry: filesystem root dentry and object to obtain pathname from
+ *
+ * Utility function for calling _aa_path_begin for when the dentry we are
+ * looking for and the root are the same (this is the usual case).
+ */
+static inline void aa_path_begin(struct dentry *dentry,
+				     struct aa_path_data *data)
+{
+	__aa_path_begin(dentry, dentry, data);
+}
+
+/** aa_path_end
+ * @data: data object previously initialized by aa_path_begin
+ *
+ * End iterating over vfsmounts.
+ * If an error occured in begin or get, it is returned. Otherwise 0.
+ */
+static inline int aa_path_end(struct aa_path_data *data)
+{
+	up_read(&namespace_sem);
+	dput(data->root);
+
+	return data->errno;
+}
+
+/** aa_path_getname
+ * @data: data object previously initialized by aa_path_begin
+ *
+ * Return the next mountpoint which has the same root dentry as data->root.
+ * If no more mount points exist (or in case of error) NULL is returned
+ * (caller should call aa_path_end() and inspect return code to differentiate)
+ */
+static inline char *aa_path_getname(struct aa_path_data *data)
+{
+	char *name = NULL;
+	struct vfsmount *mnt;
+
+	while (data->pos != data->head) {
+		mnt = list_entry(data->pos, struct vfsmount, mnt_list);
+
+		/* advance to next -- so that it is done before we break */
+		data->pos = data->pos->next;
+		prefetch(data->pos->next);
+
+		if (mnt->mnt_root == data->root) {
+			name = aa_get_name(data->dentry, mnt);
+			if (!name)
+				data->errno = -ENOMEM;
+			break;
+		}
+	}
+
+	return name;
+}
+
+#endif /* __INLINE_H__ */
--- /dev/null
+++ linux-2.6.17-rc1/security/apparmor/shared.h
@@ -0,0 +1,41 @@
+/*
+ *	Copyright (C) 2000, 2001, 2004, 2005 Novell/SUSE
+ *
+ *	Immunix AppArmor LSM
+ *
+ *	This program is free software; you can redistribute it and/or
+ *	modify it under the terms of the GNU General Public License as
+ *	published by the Free Software Foundation, version 2 of the
+ *	License.
+ */
+
+#ifndef _SHARED_H
+#define _SHARED_H
+
+/* start of system offsets */
+#define POS_AA_FILE_MIN			0
+#define POS_AA_MAY_EXEC			POS_AA_FILE_MIN
+#define POS_AA_MAY_WRITE		(POS_AA_MAY_EXEC + 1)
+#define POS_AA_MAY_READ			(POS_AA_MAY_WRITE + 1)
+#define POS_AA_MAY_APPEND		(POS_AA_MAY_READ + 1)
+/* end of system offsets */
+
+#define POS_AA_MAY_LINK			(POS_AA_MAY_APPEND + 1)
+#define POS_AA_EXEC_INHERIT		(POS_AA_MAY_LINK + 1)
+#define POS_AA_EXEC_UNCONSTRAINED	(POS_AA_EXEC_INHERIT + 1)
+#define POS_AA_EXEC_PROFILE		(POS_AA_EXEC_UNCONSTRAINED + 1)
+#define POS_AA_FILE_MAX			POS_AA_EXEC_PROFILE
+
+/* Modeled after MAY_READ, MAY_WRITE, MAY_EXEC def'ns */
+#define AA_MAY_EXEC			(0x01 << POS_AA_MAY_EXEC)
+#define AA_MAY_WRITE			(0x01 << POS_AA_MAY_WRITE)
+#define AA_MAY_READ			(0x01 << POS_AA_MAY_READ)
+#define AA_MAY_LINK			(0x01 << POS_AA_MAY_LINK)
+#define AA_EXEC_INHERIT			(0x01 << POS_AA_EXEC_INHERIT)
+#define AA_EXEC_UNCONSTRAINED		(0x01 << POS_AA_EXEC_UNCONSTRAINED)
+#define AA_EXEC_PROFILE			(0x01 << POS_AA_EXEC_PROFILE)
+#define AA_EXEC_MODIFIERS(X)		(X & (AA_EXEC_INHERIT | \
+					 A_EXEC_UNCONSTRAINED | \
+					 AA_EXEC_PROFILE))
+
+#endif /* _SHARED_H */
