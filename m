Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbUKDWNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbUKDWNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUKDWNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:13:16 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:12728 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262456AbUKDV5q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:57:46 -0500
Subject: Re: [RFC] [PATCH] [2/6] LSM Stacking: Add stacker LSM
From: Serge Hallyn <serue@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1099609471.2096.10.camel@serge.austin.ibm.com>
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
Content-Type: text/plain
Message-Id: <1099609681.2096.16.camel@serge.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Nov 2004 17:08:01 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the stacker module, still required in order to
stack several LSMs.  In order to use this with SELinux, it must be
compiled into the kernel.  Otherwise, it can be loaded as a module.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

Index: linux-2.6.10-rc1-bk12-stack/security/Kconfig
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/security/Kconfig	2004-11-02
19:57:14.759722888 -0600
+++ linux-2.6.10-rc1-bk12-stack/security/Kconfig	2004-11-02
20:05:25.515116728 -0600
@@ -97,5 +97,11 @@
 
 source security/selinux/Kconfig
 
+config SECURITY_STACKER
+	boolean "LSM Stacking"
+	depends on SECURITY
+	help
+	  Stack multiple LSMs.
+
 endmenu
 
Index: linux-2.6.10-rc1-bk12-stack/security/Makefile
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/security/Makefile	2004-11-02
19:55:53.582063768 -0600
+++ linux-2.6.10-rc1-bk12-stack/security/Makefile	2004-11-02
20:05:25.514116880 -0600
@@ -2,6 +2,7 @@
 # Makefile for the kernel security code
 #
 
+obj-$(CONFIG_SECURITY_STACKER)		+= stacker.o
 obj-$(CONFIG_KEYS)			+= keys/
 subdir-$(CONFIG_SECURITY_SELINUX)	+= selinux
 
Index: linux-2.6.10-rc1-bk12-stack/security/stacker.c
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/security/stacker.c	2004-11-02
13:46:30.056668176 -0600
+++ linux-2.6.10-rc1-bk12-stack/security/stacker.c	2004-11-02
20:05:41.007761488 -0600
@@ -0,0 +1,1605 @@
+/* "Stacker" Linux security module (LSM).
+ *
+ * New version, being hacked by Serge Hallyn.  Serge, describe the
+ * changes.  (hooks update, sysfs, security blob)
+ *
+ * version 2002-09-04.
+ * Load this module first as the primary LSM module,
+ * and you can then stack (load) multiple additional LSM modules.
+ *
+ * Copyright (C) 2002 David A. Wheeler <dwheeler@dwheeler.com>.
+ *  This program is free software; you can redistribute it and/or
modify
+ *  it under the terms of the GNU General Public License as published
by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ * Below is administrator documentation, LSM module authoring
documentation,
+ * design documentation, and the code itself.
+ */
+
+/*
+ * Several of the ->security fields have no alloc/free pairs.  Huh?
+ * ipc and fown, in particular.
+ */
+
+#include "stacker.h"
+
+short sysfsfiles_registered;
+
+int num_stacked_modules;
+
+#ifdef CONSERVATIVE_STACKER_LOCKING
+
+/* Turn on "CONSERVATIVE_STACKER_LOCKING" to use an extremely
conservative,
+ * safe, and slow locking technique in the stacker.
+ *
+ * You MUST use this technique if you are dealing with a
+ * (nasty and rare!) computer architecture where aligned pointer writes
+ * are not atomic.
+ *
+ * This approach uses a multiple reader - one writer semaphor;
+ * whenever using/changing stacker state (in particular the linked list
+ * of modules, etc.), grab this lock.  Note that writing is VERY rare.
+ * This could switch to big-reader locks (brlocks), but using them
requires
+ * an allocation of an id.  Besides, if you want speed, the default
+ * approach is even faster.  In the future an RCU lock might be
appropriate,
+ * if they're ever added to Linux, but again, why bother since the
+ * default implementation is faster still.  For more info on Linux
locking,
+ * see: http://www.linuxjournal.com/article.php?sid=5833
+ *
+ */
+struct rwlock_t stacker_rwsem = RW_LOCK_UNLOCKED;
+
+#define INIT_STACKER_LOCKING
+#define LOCK_STACKER_FOR_READING read_lock(&stacker_rwsem)
+#define UNLOCK_STACKER_FOR_READING read_unlock(&stacker_rwsem)
+#define LOCK_STACKER_FOR_WRITING write_lock(&stacker_rwsem)
+#define UNLOCK_STACKER_FOR_WRITING write_unlock(&stacker_rwsem)
+
+#else /* ! CONSERVATIVE_STACKER_LOCKING */
+
+/* The default: non-conservative stacker locking.
+ * This approach uses aligned pointer writes (presuming they are
atomic)
+ * to completely avoid the need for read locks.
+ */
+
+struct semaphore stacker_sem;
+
+/* TODO: I'm using semaphore and down_interruptable. Are there
+   any hooks that can be called inside an interrupt where it is NOT
+   possible to sleep on a semaphore?
+*/
+
+#define INIT_STACKER_LOCKING  sema_init(&stacker_sem, 1)
+#define LOCK_STACKER_FOR_READING
+#define UNLOCK_STACKER_FOR_READING
+#define LOCK_STACKER_FOR_WRITING down_interruptible(&stacker_sem)
+#define UNLOCK_STACKER_FOR_WRITING up(&stacker_sem)
+#endif /* CONSERVATIVE_STACKER_LOCKING */
+
+
+/* Flag to keep track of how we were registered */
+static int short_circuit_restrictive;   /* = 0; if 1, short-circuit
restrictive
+					     hooks */
+static int short_circuit_capable;       /* = 0; if 1, short-circuit
capable() */
+
+static int forbid_stacker_register;     /* = 0; if 1, can't register */
+
+
+/* The set of LSM modules stacked by this "stacker" module
+   is stored as a singly linked list of module_entries whose head is
+   pointed to by stacked_modules. It's initially NULL (an empty list).
*/
+struct module_entry *stacked_modules;
+
+
+/* penultimate_stacked_module points to the next-to-last
+ * entry in the stacked list if there are 2+ entries, else it's NULL;
+ * this pointer is used to make modifying the end a constant time
operation.
+ *
+ * Here are a few invariants that may help you understand this:
+ * len(list)==0: stacked_modules==penultimate_stacked_module==NULL.
+ * len(list)==1: stacked_modules==x, x->next == NULL,
+ *               penultimate_stacked_module==NULL.
+ * len(list)==2: stacked_modules==penultimate_stacked_module==x,
+ *               x->next == y, y->next == NULL.
+ * len(list)==3: stacked_modules==x, x->next == y,
+ *               y->next == z, z->next == NULL,
+ *               penultimate_stacked_module==y.
+ * */
+static struct module_entry *penultimate_stacked_module;
+
+
+/* Maximum number of characters in a stacked LSM module name */
+#define MAX_MODULE_NAME_LEN 128
+
+/*
+ * find_lsm_module_by_name:
+ * Find a module by name.  Used only by getprocattr and setprocattr
+ */
+struct module_entry *find_lsm_module_by_name(char *s, char *e)
+{
+	struct module_entry *m;
+
+	for (m=stacked_modules; m; m = m->next) {
+		if (m->namelen == e-s && strncmp(m->module_name, s, e-s)==0)
+			break;
+	}
+	return m;
+}
+
+/* Walk through the linked list of modules in stacked_modules
+ * and ask each (in turn) for their results, then return the
+ * results.  If more than one module reports an error, return
+ * the FIRST error code.  Note that this ALWAYS calls ALL modules,
since
+ * some modules may change state when called.
+ * This is wrapped in do { .. } while(0), see
+ * http://www.kernelnewbies.org/faq/index.php3#dowhile for
+ * why this is a good idea.  */
+
+#define RETURN_ERROR_IF_ANY_ERROR(BASE_FUNC,FUNC_WITH_ARGS) do { \
+	int final_result = 0; \
+	int result; \
+	struct module_entry *m; \
+	LOCK_STACKER_FOR_READING; \
+	for (m = stacked_modules; m; m = m->next) { \
+		if (!m->module_operations.BASE_FUNC) \
+			continue; \
+		result = m->module_operations.FUNC_WITH_ARGS; \
+		if (result && !final_result) { \
+			final_result = result; \
+			if (short_circuit_restrictive) break; \
+		} \
+	} \
+	UNLOCK_STACKER_FOR_READING; \
+	return final_result; } while (0)
+
+
+
+/* Call all modules in stacked_modules' routine */
+#define CALL_ALL(BASE_FUNC,FUNC_WITH_ARGS) do { \
+	struct module_entry *m; \
+	LOCK_STACKER_FOR_READING; \
+	for (m = stacked_modules; m; m = m->next) { \
+		if (m->module_operations.BASE_FUNC) \
+			m->module_operations.FUNC_WITH_ARGS; \
+	} \
+	UNLOCK_STACKER_FOR_READING; } while (0)
+
+
+static void add_module_entry(struct module_entry *new_module_entry)
+{
+	printk(KERN_INFO "add_module_entry: starting\n");
+	if (!stacked_modules)
+		/* no module loaded yet */
+		stacked_modules = new_module_entry;
+	else {
+		if (!penultimate_stacked_module)
+			/* EXACTLY 1 */
+			penultimate_stacked_module = stacked_modules;
+		else
+			/* > 1 module already loaded */
+			penultimate_stacked_module = penultimate_stacked_module->next;
+
+		penultimate_stacked_module->next = new_module_entry;
+	}
+	printk(KERN_INFO "add_module_entry: done\n");
+}
+
+
+static int stacker_ptrace (struct task_struct *parent, struct
task_struct *child)
+{
+	RETURN_ERROR_IF_ANY_ERROR(ptrace,ptrace(parent, child));
+}
+
+static int stacker_capget (struct task_struct *target, kernel_cap_t *
effective,
+			 kernel_cap_t * inheritable, kernel_cap_t * permitted)
+{
+	RETURN_ERROR_IF_ANY_ERROR(capget,capget(target, effective,
inheritable, permitted));
+}
+
+static int stacker_capset_check (struct task_struct *target,
+			       kernel_cap_t * effective,
+			       kernel_cap_t * inheritable,
+			       kernel_cap_t * permitted)
+{
+	RETURN_ERROR_IF_ANY_ERROR(capset_check,capset_check(target, effective,
inheritable, permitted));
+}
+
+static void stacker_capset_set (struct task_struct *target,
+			      kernel_cap_t * effective,
+			      kernel_cap_t * inheritable,
+			      kernel_cap_t * permitted)
+{
+	CALL_ALL(capset_set,capset_set(target, effective, inheritable,
permitted));
+}
+
+static int stacker_acct (struct file *file)
+{
+	RETURN_ERROR_IF_ANY_ERROR(acct,acct(file));
+}
+
+static int stacker_capable (struct task_struct *tsk, int cap)
+{
+	/* This is an AUTHORITATIVE hook, so it needs to be
+	 * handled differently than the normal "restrictive" hooks.
+	 * Instead of returning a failure if any module fails,
+	 * we need to return a success if ANY module succeeds (returns 0).
+	 *
+	 * Unless short_circuit_capable is true, we'll call all of the
+	 * modules (even if an earlier one replies with a success).
+	 *
+	 * Returns 0 if allowed, -EPERM if not.
+	 * If a stacked module returns -EPIPE, _no_ later stacked modules
+	 * are consulted and -EPERM is returned.
+	 * If a stacked module returns -EACCES, it undoes any previous
+	 * permission (and resets the interim return value to be -EPERM);
+	 * only a still-later module can return 0.
+	 */
+
+	int final_result = -EPERM; 
+	int result; 
+	struct module_entry *m;
+
+/* If no modules are stacked, then we want to return 0 if uid==0 */
+	if (!stacked_modules) {
+		if (cap_is_fs_cap (cap) ? tsk->fsuid == 0 : tsk->euid == 0)
+			/* capability granted */
+			return 0;
+
+		/* capability denied */
+		return -EPERM;
+	}
+
+	LOCK_STACKER_FOR_READING; 
+	for (m = stacked_modules; m; m = m->next) { 
+		result = (m->module_operations).capable(tsk,cap); 
+		if (result == -EPIPE) {
+			final_result = -EPERM;
+			break;
+		} else if (result == -EACCES) {
+			final_result = -EPERM;
+		} else if (!result) {
+			final_result = 0; 
+			if (short_circuit_capable) break;
+		}
+	} 
+	UNLOCK_STACKER_FOR_READING;
+
+	return final_result;
+}
+
+
+static int stacker_sysctl (struct ctl_table * table, int op)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sysctl,sysctl(table, op));
+}
+
+static int stacker_quotactl (int cmds, int type, int id, struct
super_block *sb)
+{
+	RETURN_ERROR_IF_ANY_ERROR(quotactl,quotactl(cmds,type,id,sb));
+}
+
+static int stacker_quota_on (struct file *f)
+{
+	RETURN_ERROR_IF_ANY_ERROR(quota_on,quota_on(f));
+}
+
+static int stacker_syslog (int type)
+{
+	RETURN_ERROR_IF_ANY_ERROR(syslog,syslog(type));
+}
+
+static int stacker_vm_enough_memory(long pages)
+{
+	RETURN_ERROR_IF_ANY_ERROR(vm_enough_memory,vm_enough_memory(pages));
+}
+
+static int stacker_netlink_send (struct sock *sk, struct sk_buff *skb)
+{
+	/* NOTE: The dummy module does this:
+		if (current->euid == 0)
+			cap_raise (NETLINK_CB (skb).eff_cap, CAP_NET_ADMIN);
+		else
+			NETLINK_CB (skb).eff_cap = 0;
+	 * if this would be a problem with your module, then tell
+	 * your administrators what to do. */
+
+	RETURN_ERROR_IF_ANY_ERROR(netlink_send,netlink_send(sk,skb));
+}
+
+
+static int stacker_netlink_recv (struct sk_buff *skb)
+{
+	RETURN_ERROR_IF_ANY_ERROR(netlink_recv,netlink_recv(skb));
+}
+
+static int stacker_bprm_alloc_security (struct linux_binprm *bprm)
+{
+	RETURN_ERROR_IF_ANY_ERROR(bprm_alloc_security,bprm_alloc_security(bprm));
+}
+
+static void stacker_bprm_free_security (struct linux_binprm *bprm)
+{
+	CALL_ALL(bprm_free_security,bprm_free_security(bprm));
+}
+
+static void stacker_bprm_apply_creds (struct linux_binprm *bprm, int
unsafe)
+{
+	CALL_ALL(bprm_apply_creds,bprm_apply_creds(bprm, unsafe));
+}
+
+static int stacker_bprm_set_security (struct linux_binprm *bprm)
+{
+	RETURN_ERROR_IF_ANY_ERROR(bprm_set_security,bprm_set_security(bprm));
+}
+
+static int stacker_bprm_check_security (struct linux_binprm *bprm)
+{
+	RETURN_ERROR_IF_ANY_ERROR(bprm_check_security,bprm_check_security(bprm));
+}
+
+static int stacker_bprm_secureexec (struct linux_binprm *bprm)
+{
+	RETURN_ERROR_IF_ANY_ERROR(bprm_secureexec,bprm_secureexec(bprm));
+}
+
+static int stacker_sb_alloc_security (struct super_block *sb)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sb_alloc_security,sb_alloc_security(sb));
+}
+
+static void stacker_sb_free_security (struct super_block *sb)
+{
+	CALL_ALL(sb_free_security,sb_free_security(sb));
+}
+
+static int stacker_sb_copy_data (struct file_system_type *type,
+			void *orig, void *copy)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sb_copy_data,sb_copy_data(type,orig,copy));
+}
+
+static int stacker_sb_kern_mount (struct super_block *sb, void *data)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sb_kern_mount,sb_kern_mount(sb, data));
+}
+
+static int stacker_sb_statfs (struct super_block *sb)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sb_statfs,sb_statfs(sb));
+}
+
+static int stacker_mount (char *dev_name, struct nameidata *nd, char
*type,
+			unsigned long flags, void *data)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sb_mount,sb_mount(dev_name, nd, type, flags,
data));
+}
+
+static int stacker_check_sb (struct vfsmount *mnt, struct nameidata
*nd)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sb_check_sb,sb_check_sb(mnt, nd));
+}
+
+static int stacker_umount (struct vfsmount *mnt, int flags)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sb_umount,sb_umount(mnt, flags));
+}
+
+static void stacker_umount_close (struct vfsmount *mnt)
+{
+	CALL_ALL(sb_umount_close,sb_umount_close(mnt));
+}
+
+static void stacker_umount_busy (struct vfsmount *mnt)
+{
+	CALL_ALL(sb_umount_busy,sb_umount_busy(mnt));
+}
+
+static void stacker_post_remount (struct vfsmount *mnt, unsigned long
flags,
+				void *data)
+{
+	CALL_ALL(sb_post_remount,sb_post_remount(mnt, flags, data));
+}
+
+
+static void stacker_post_mountroot (void)
+{
+	CALL_ALL(sb_post_mountroot,sb_post_mountroot());
+}
+
+static void stacker_post_addmount (struct vfsmount *mnt, struct
nameidata *nd)
+{
+	CALL_ALL(sb_post_addmount,sb_post_addmount(mnt, nd));
+}
+
+static int stacker_pivotroot (struct nameidata *old_nd, struct
nameidata *new_nd)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sb_pivotroot,sb_pivotroot(old_nd, new_nd));
+}
+
+static void stacker_post_pivotroot (struct nameidata *old_nd, struct
nameidata *new_nd)
+{
+	CALL_ALL(sb_post_pivotroot,sb_post_pivotroot(old_nd, new_nd));
+}
+
+static int stacker_inode_alloc_security (struct inode *inode)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_alloc_security,inode_alloc_security(inode));
+}
+
+static void stacker_inode_free_security (struct inode *inode)
+{
+	CALL_ALL(inode_free_security,inode_free_security(inode));
+}
+
+static int stacker_inode_create (struct inode *inode, struct dentry
*dentry,
+			       int mask)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_create,inode_create(inode, dentry,
mask));
+}
+
+static void stacker_inode_post_create (struct inode *inode,
+	    struct dentry *dentry, int mask)
+{
+	CALL_ALL(inode_post_create,inode_post_create(inode, dentry, mask));
+}
+
+static int stacker_inode_link (struct dentry *old_dentry, struct inode
*inode,
+			     struct dentry *new_dentry)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_link,inode_link(old_dentry, inode,
new_dentry));
+}
+
+static void stacker_inode_post_link (struct dentry *old_dentry,
+				   struct inode *inode,
+				   struct dentry *new_dentry)
+{
+	CALL_ALL(inode_post_link,inode_post_link(old_dentry, inode,
new_dentry));
+}
+
+static int stacker_inode_unlink (struct inode *inode, struct dentry
*dentry)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_unlink,inode_unlink(inode, dentry));
+}
+
+static int stacker_inode_symlink (struct inode *inode, struct dentry
*dentry,
+				const char *name)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_symlink,inode_symlink(inode, dentry,
name));
+}
+
+static void stacker_inode_post_symlink (struct inode *inode,
+				      struct dentry *dentry, const char *name)
+{
+	CALL_ALL(inode_post_symlink,inode_post_symlink(inode, dentry, name));
+}
+
+static int stacker_inode_mkdir (struct inode *inode, struct dentry
*dentry,
+			      int mask)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_mkdir,inode_mkdir(inode, dentry,
mask));
+}
+
+static void stacker_inode_post_mkdir (struct inode *inode,
+	    	struct dentry *dentry, int mask)
+{
+	CALL_ALL(inode_post_mkdir,inode_post_mkdir(inode, dentry, mask));
+}
+
+static int stacker_inode_rmdir (struct inode *inode, struct dentry
*dentry)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_rmdir,inode_rmdir(inode, dentry));
+}
+
+static int stacker_inode_mknod (struct inode *inode, struct dentry
*dentry,
+			      int major, dev_t minor)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_mknod,inode_mknod(inode, dentry,
major, minor));
+}
+
+static void stacker_inode_post_mknod (struct inode *inode,
+	       	struct dentry *dentry, int major, dev_t minor)
+{
+	CALL_ALL(inode_post_mknod,inode_post_mknod(inode, dentry, major,
minor));
+}
+
+static int stacker_inode_rename (struct inode *old_inode,
+			       struct dentry *old_dentry,
+			       struct inode *new_inode,
+			       struct dentry *new_dentry)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_rename,inode_rename(old_inode,
old_dentry,
+				  new_inode, new_dentry));
+}
+
+static void stacker_inode_post_rename (struct inode *old_inode,
+				     struct dentry *old_dentry,
+				     struct inode *new_inode,
+				     struct dentry *new_dentry)
+{
+	CALL_ALL(inode_post_rename,inode_post_rename(old_inode, old_dentry,
+				  new_inode, new_dentry));
+}
+
+static int stacker_inode_readlink (struct dentry *dentry)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_readlink,inode_readlink(dentry));
+}
+
+static int stacker_inode_follow_link (struct dentry *dentry,
+				    struct nameidata *nameidata)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_follow_link,inode_follow_link(dentry,
nameidata));
+}
+
+static int stacker_inode_permission (struct inode *inode, int mask,
+		struct nameidata *nd)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_permission,inode_permission(inode,
mask, nd));
+}
+
+static int stacker_inode_setattr (struct dentry *dentry, struct iattr
*iattr)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_setattr,inode_setattr(dentry, iattr));
+}
+
+static int stacker_inode_getattr (struct vfsmount *mnt, struct dentry
*dentry)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_getattr,inode_getattr(mnt,dentry));
+}
+
+static void stacker_inode_delete (struct inode *ino)
+{
+	CALL_ALL(inode_delete,inode_delete(ino));
+}
+
+static int stacker_inode_setxattr (struct dentry *dentry, char *name,
+	        	void *value, size_t size, int flags)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_setxattr,inode_setxattr(dentry,name,value,size,flags));
+}
+
+static void stacker_inode_post_setxattr (struct dentry *dentry, char
*name, void *value,
+				       size_t size, int flags)
+{
+	CALL_ALL(inode_post_setxattr,inode_post_setxattr(dentry,name,value,size,flags));
+}
+
+static int stacker_inode_getxattr (struct dentry *dentry, char *name)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_getxattr,inode_getxattr(dentry,name));
+}
+
+static int stacker_inode_listxattr (struct dentry *dentry)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_listxattr,inode_listxattr(dentry));
+}
+
+static int stacker_inode_removexattr (struct dentry *dentry, char
*name)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_removexattr,inode_removexattr(dentry,name));
+}
+
+static int stacker_inode_getsecurity(struct inode *inode, const char
*name, void *buffer, size_t size)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_getsecurity,inode_getsecurity(inode,name,buffer,size));
+}
+
+static int stacker_inode_setsecurity(struct inode *inode, const char
*name, const void *value, size_t size, int flags) 
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_setsecurity,inode_setsecurity(inode,name,value,size,flags));
+}
+
+static int stacker_inode_listsecurity(struct inode *inode, char
*buffer, size_t buffer_size)
+{
+	RETURN_ERROR_IF_ANY_ERROR(inode_listsecurity,inode_listsecurity(inode,buffer,buffer_size));
+}
+
+static int stacker_file_permission (struct file *file, int mask)
+{
+	RETURN_ERROR_IF_ANY_ERROR(file_permission,file_permission(file,mask));
+}
+
+static int stacker_file_alloc_security (struct file *file)
+{
+	RETURN_ERROR_IF_ANY_ERROR(file_alloc_security,file_alloc_security(file));
+}
+
+static void stacker_file_free_security (struct file *file)
+{
+	CALL_ALL(file_free_security,file_free_security(file));
+}
+
+static int stacker_file_ioctl (struct file *file, unsigned int command,
+			     unsigned long arg)
+{
+	RETURN_ERROR_IF_ANY_ERROR(file_ioctl,file_ioctl(file,command,arg));
+}
+
+static int stacker_file_mmap (struct file *file, unsigned long prot,
+			    unsigned long flags)
+{
+	RETURN_ERROR_IF_ANY_ERROR(file_mmap,file_mmap(file, prot, flags));
+}
+
+static int stacker_file_mprotect (struct vm_area_struct *vma,
+	       	unsigned long prot)
+{
+	RETURN_ERROR_IF_ANY_ERROR(file_mprotect,file_mprotect(vma,prot));
+}
+
+static int stacker_file_lock (struct file *file, unsigned int cmd)
+{
+	RETURN_ERROR_IF_ANY_ERROR(file_lock,file_lock(file,cmd));
+}
+
+static int stacker_file_fcntl (struct file *file, unsigned int cmd,
+			     unsigned long arg)
+{
+	RETURN_ERROR_IF_ANY_ERROR(file_fcntl,file_fcntl(file,cmd,arg));
+}
+
+/* say - this is completely unused */
+/* If that changes, we'll need to set file->security? */
+static int stacker_file_set_fowner (struct file *file)
+{
+	RETURN_ERROR_IF_ANY_ERROR(file_set_fowner,file_set_fowner(file));
+}
+
+static int stacker_file_send_sigiotask (struct task_struct *tsk,
+				      struct fown_struct *fown,
+				      int sig)
+{
+	RETURN_ERROR_IF_ANY_ERROR(file_send_sigiotask,file_send_sigiotask(tsk,fown,sig));
+}
+
+static int stacker_file_receive (struct file *file)
+{
+	RETURN_ERROR_IF_ANY_ERROR(file_receive,file_receive(file));
+}
+
+static int stacker_task_create (unsigned long clone_flags)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_create,task_create(clone_flags));
+}
+
+static int stacker_task_alloc_security (struct task_struct *p)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_alloc_security,task_alloc_security(p));
+}
+
+static void stacker_task_free_security (struct task_struct *p)
+{
+	CALL_ALL(task_free_security,task_free_security(p));
+}
+
+static int stacker_task_setuid (uid_t id0, uid_t id1, uid_t id2, int
flags)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_setuid,task_setuid(id0,id1,id2,flags));
+}
+
+static int stacker_task_post_setuid (uid_t id0, uid_t id1, uid_t id2,
int flags)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_post_setuid,task_post_setuid(id0,id1,id2,flags));
+}
+
+static int stacker_task_setgid (gid_t id0, gid_t id1, gid_t id2, int
flags)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_setgid,task_setgid(id0,id1,id2,flags));
+}
+
+static int stacker_task_setpgid (struct task_struct *p, pid_t pgid)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_setpgid,task_setpgid(p,pgid));
+}
+
+static int stacker_task_getpgid (struct task_struct *p)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_getpgid,task_getpgid(p));
+}
+
+static int stacker_task_getsid (struct task_struct *p)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_getsid,task_getsid(p));
+}
+
+static int stacker_task_setgroups (struct group_info *group_info)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_setgroups,task_setgroups(group_info));
+}
+
+static int stacker_task_setnice (struct task_struct *p, int nice)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_setnice,task_setnice(p,nice));
+}
+
+static int stacker_task_setrlimit (unsigned int resource, struct rlimit
*new_rlim)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_setrlimit,task_setrlimit(resource,new_rlim));
+}
+
+static int stacker_task_setscheduler (struct task_struct *p, int
policy,
+				    struct sched_param *lp)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_setscheduler,task_setscheduler(p,policy,lp));
+}
+
+static int stacker_task_getscheduler (struct task_struct *p)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_getscheduler,task_getscheduler(p));
+}
+
+static int stacker_task_wait (struct task_struct *p)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_wait,task_wait(p));
+}
+
+static int stacker_task_kill (struct task_struct *p, struct siginfo
*info,
+			    int sig)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_kill,task_kill(p,info,sig));
+}
+
+static int stacker_task_prctl (int option, unsigned long arg2, unsigned
long arg3,
+			     unsigned long arg4, unsigned long arg5)
+{
+	RETURN_ERROR_IF_ANY_ERROR(task_prctl,task_prctl(option,arg2,arg3,arg4,arg5));
+}
+
+static void stacker_task_reparent_to_init (struct task_struct *p)
+{
+	/* Note that the dummy version of this hook would call:
+	 *	p->euid = p->fsuid = 0; */
+
+	CALL_ALL(task_reparent_to_init,task_reparent_to_init(p));
+}
+
+static void stacker_task_to_inode(struct task_struct *p, struct inode
*inode)
+{
+	CALL_ALL(task_to_inode,task_to_inode(p, inode));
+}
+
+#ifdef CONFIG_SECURITY_NETWORK
+static int stacker_socket_create (int family, int type, int protocol,
int kern)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_create,socket_create(family,type,protocol,kern));
+}
+
+static void stacker_socket_post_create (struct socket *sock, int
family,
+	       			int type, int protocol, int kern)
+{
+	CALL_ALL(socket_post_create,socket_post_create(sock,family,type,protocol,kern));
+}
+
+static int stacker_socket_bind (struct socket *sock, struct sockaddr
*address,
+			      int addrlen)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_bind,socket_bind(sock,address,addrlen));
+}
+
+static int stacker_socket_connect (struct socket *sock,
+	       	struct sockaddr *address, int addrlen)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_connect,socket_connect(sock,address,addrlen));
+}
+
+static int stacker_socket_listen (struct socket *sock, int backlog)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_listen,socket_listen(sock,backlog));
+}
+
+static int stacker_socket_accept (struct socket *sock, struct socket
*newsock)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_accept,socket_accept(sock,newsock));
+}
+
+static void stacker_socket_post_accept (struct socket *sock, 
+				      struct socket *newsock)
+{
+	CALL_ALL(socket_post_accept,socket_post_accept(sock,newsock));
+}
+
+static int stacker_socket_sendmsg (struct socket *sock, struct msghdr
*msg,
+				 int size)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_sendmsg,socket_sendmsg(sock,msg,size));
+}
+
+static int stacker_socket_recvmsg (struct socket *sock, struct msghdr
*msg,
+				 int size, int flags)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_recvmsg,socket_recvmsg(sock,msg,size,flags));
+}
+
+static int stacker_socket_getsockname (struct socket *sock)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_getsockname,socket_getsockname(sock));
+}
+
+static int stacker_socket_getpeername (struct socket *sock)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_getpeername,socket_getpeername(sock));
+}
+
+static int stacker_socket_setsockopt (struct socket *sock, int level,
int optname)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_setsockopt,socket_setsockopt(sock,level,optname));
+}
+
+static int stacker_socket_getsockopt (struct socket *sock, int level,
int optname)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_getsockopt,socket_getsockopt(sock,level,optname));
+}
+
+static int stacker_socket_shutdown (struct socket *sock, int how)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_shutdown,socket_shutdown(sock,how));
+}
+
+static int stacker_socket_sock_rcv_skb (struct sock *sk, struct sk_buff
*skb)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_sock_rcv_skb,socket_sock_rcv_skb(sk,skb));
+}
+
+static int stacker_unix_stream_connect (struct socket *sock,
+			     struct socket *other, struct sock *newsk)
+{
+	RETURN_ERROR_IF_ANY_ERROR(unix_stream_connect,unix_stream_connect(sock,other,newsk));
+}
+
+static int stacker_unix_may_send (struct socket *sock,
+				       struct socket *other)
+{
+	RETURN_ERROR_IF_ANY_ERROR(unix_may_send,unix_may_send(sock,other));
+}
+
+static int stacker_socket_getpeersec(struct socket *sock,
+	char __user *optval, int __user *optlen, unsigned len)
+{
+	RETURN_ERROR_IF_ANY_ERROR(socket_getpeersec,socket_getpeersec(sock,optval,optlen,len));
+}
+
+static int stacker_sk_alloc_security(struct sock *sk, int family,
+			int priority)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sk_alloc_security,sk_alloc_security(sk,family,priority));
+}
+
+static void stacker_sk_free_security (struct sock *sk)
+{
+	CALL_ALL(sk_free_security,sk_free_security(sk));
+}
+
+#endif
+
+static int stacker_ipc_permission (struct kern_ipc_perm *ipcp, short
flag)
+{
+	RETURN_ERROR_IF_ANY_ERROR(ipc_permission,ipc_permission(ipcp,flag));
+}
+
+static int stacker_msg_msg_alloc_security (struct msg_msg *msg)
+{
+	RETURN_ERROR_IF_ANY_ERROR(msg_msg_alloc_security,msg_msg_alloc_security(msg));
+}
+
+static void stacker_msg_msg_free_security (struct msg_msg *msg)
+{
+	CALL_ALL(msg_msg_free_security,msg_msg_free_security(msg));
+}
+
+static int stacker_msg_queue_alloc_security (struct msg_queue *msq)
+{
+	RETURN_ERROR_IF_ANY_ERROR(msg_queue_alloc_security,msg_queue_alloc_security(msq));
+}
+
+static void stacker_msg_queue_free_security (struct msg_queue *msq)
+{
+	CALL_ALL(msg_queue_free_security,msg_queue_free_security(msq));
+}
+
+static int stacker_msg_queue_associate (struct msg_queue *msq, int
msqflg)
+{
+	RETURN_ERROR_IF_ANY_ERROR(msg_queue_associate,msg_queue_associate(msq,msqflg));
+}
+
+static int stacker_msg_queue_msgctl (struct msg_queue *msq, int cmd)
+{
+	RETURN_ERROR_IF_ANY_ERROR(msg_queue_msgctl,msg_queue_msgctl(msq,cmd));
+}
+
+static int stacker_msg_queue_msgsnd (struct msg_queue *msq, struct
msg_msg *msg,
+				   int msgflg)
+{
+	RETURN_ERROR_IF_ANY_ERROR(msg_queue_msgsnd,msg_queue_msgsnd(msq,msg,msgflg));
+}
+
+static int stacker_msg_queue_msgrcv (struct msg_queue *msq, struct
msg_msg *msg,
+				   struct task_struct *target, long type,
+				   int mode)
+{
+	RETURN_ERROR_IF_ANY_ERROR(msg_queue_msgrcv,msg_queue_msgrcv(msq,msg,target,type,mode));
+}
+
+static int stacker_shm_alloc_security (struct shmid_kernel *shp)
+{
+	RETURN_ERROR_IF_ANY_ERROR(shm_alloc_security,shm_alloc_security(shp));
+}
+
+static void stacker_shm_free_security (struct shmid_kernel *shp)
+{
+	CALL_ALL(shm_free_security,shm_free_security(shp));
+}
+
+static int stacker_shm_associate (struct shmid_kernel *shp, int shmflg)
+{
+	RETURN_ERROR_IF_ANY_ERROR(shm_associate,shm_associate(shp,shmflg));
+}
+
+static int stacker_shm_shmctl (struct shmid_kernel *shp, int cmd)
+{
+	RETURN_ERROR_IF_ANY_ERROR(shm_shmctl,shm_shmctl(shp,cmd));
+}
+
+static int stacker_shm_shmat (struct shmid_kernel *shp, char *shmaddr,
+			    int shmflg)
+{
+	RETURN_ERROR_IF_ANY_ERROR(shm_shmat,shm_shmat(shp,shmaddr,shmflg));
+}
+
+static int stacker_sem_alloc_security (struct sem_array *sma)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sem_alloc_security,sem_alloc_security(sma));
+}
+
+static void stacker_sem_free_security (struct sem_array *sma)
+{
+	CALL_ALL(sem_free_security,sem_free_security(sma));
+}
+
+static int stacker_sem_associate (struct sem_array *sma, int semflg)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sem_associate,sem_associate(sma,semflg));
+}
+
+static int stacker_sem_semctl (struct sem_array *sma, int cmd)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sem_semctl,sem_semctl(sma,cmd));
+}
+
+static int stacker_sem_semop (struct sem_array *sma,
+			    struct sembuf *sops, unsigned nsops, int alter)
+{
+	RETURN_ERROR_IF_ANY_ERROR(sem_semop,sem_semop(sma,sops,nsops,alter));
+}
+
+static void stacker_d_instantiate (struct dentry *dentry, struct inode
*inode)
+{
+	CALL_ALL(d_instantiate,d_instantiate(dentry,inode));
+}
+
+static int
+stacker_getprocattr(struct task_struct *p, char *name, void *value,
size_t size)
+{
+	int ret = 0;
+	struct module_entry *m;
+
+	memset(value, 0, size);
+	for (m=stacked_modules; m && ret<size; m = m->next) {
+		if (m->module_operations.getprocattr) {
+			if (m->namelen+2+ret >= size)
+				continue;
+			ret += sprintf(value+ret, "%s:", m->module_name);
+			ret += m->module_operations.getprocattr(p,name,
+				value+ret, size-ret);
+			if (ret+1<size)
+				((char *)value)[ret++]='\n';
+		}
+	}
+	return ret;
+}
+
+static int stacker_setprocattr(struct task_struct *p, char *name, void
*value, size_t size)
+{
+	char *s, *e;
+	int len, ret;
+	struct module_entry *m;
+	char modname[50];
+
+	s = value;
+	e = strnchr(s, size, ':');
+	if (!e) {
+		printk(KERN_INFO "%s: couln't find module name end\n",
+			__FUNCTION__);
+		return -EINVAL;
+	}
+	m = find_lsm_module_by_name(s,e);
+	if (!m) {
+		strncpy(modname, s, 50);
+		modname[49] = '\0';
+		printk(KERN_INFO "%s: Bad module name, %s\n",
+			__FUNCTION__, modname);
+		return -EINVAL;
+	}
+	s = e+1;
+	while ((void *)s < value+size && *s == ' ')
+		s++;
+	if (s == value+size) {
+		printk(KERN_INFO "%s: no data after module name\n", __FUNCTION__);
+		return -EINVAL;
+	}
+	len = size - (int)((void *)s - value);
+	printk(KERN_INFO "%s: sending to module\n", __FUNCTION__);
+	ret = m->module_operations.setprocattr(p,name,s,len);
+	printk(KERN_INFO "%s: ret was %d, returning %d\n", __FUNCTION__, ret,
ret+(size-len));
+	if (ret < 0)
+		return ret;
+	return ret + (size-len);
+}
+
+static int stacker_register (const char *name, struct
security_operations *ops)
+{
+	/* This function is the primary reason for the stacker module.
+	   Add the stacked module (as specified by name and ops)
+	   according to the current ordering policy. */
+
+	char *new_module_name;
+	struct module_entry *new_module_entry;
+	int namelen;
+
+	num_stacked_modules++;
+
+	LOCK_STACKER_FOR_WRITING;
+	if (forbid_stacker_register) {
+		printk(KERN_INFO "%s: module stacking is forbidding.\n",
+			__FUNCTION__);
+		UNLOCK_STACKER_FOR_WRITING;
+		return -EINVAL;
+	}
+	/* TODO: What should I check on re: security?  Should I check
+	   for euid == 0? Has that already been checked?   (dwheeler)
+		Serge's comments:   XXX
+			1. We could force stacked modules to be
+		added through the sysfs interface instead of insmod.  That
+		way a stacked module (dte, selinux) could, once stacked,
+		control additional module stacking.
+			2. We could lobby for the reintroduction of the module
+		add/delete hooks.
+		   */
+
+	/* Allocate memory */
+	namelen = strnlen(name, MAX_MODULE_NAME_LEN);
+	new_module_name = kmalloc(namelen+1, GFP_KERNEL);
+	new_module_entry = kmalloc(sizeof(struct module_entry), GFP_KERNEL);
+	if (!new_module_name || !new_module_entry) {
+		UNLOCK_STACKER_FOR_WRITING;
+		printk (KERN_INFO
+			"%s: Failure registering module - out of memory\n",
+			__FUNCTION__);
+		return -ENOMEM;
+	}
+
+	memset(new_module_entry, 0, sizeof(struct module_entry));
+
+	/* Copy the data into the allocated memory. */
+	strncpy(new_module_name, name, namelen);
+	new_module_name[namelen] = '\0';
+
+	/*new_module_entry->module_operations = *ops;*/
+	memcpy(&new_module_entry->module_operations, ops,
+			sizeof(struct security_operations));
+
+	new_module_entry->module_name = new_module_name;
+	new_module_entry->namelen = namelen;
+
+	add_module_entry(new_module_entry);
+
+	/* One more write barrier; this one is to _ensure_ that the
+	 * inactive list is valid before releasing the locking. */
+	wmb();
+	UNLOCK_STACKER_FOR_WRITING;
+	printk(KERN_INFO "%s: registered %s module\n", __FUNCTION__,
+		new_module_entry->module_name);
+	return num_stacked_modules-1;
+}
+
+/* 
+ * Unregister a registered LSM.
+ * It would be nice if we could veto this, but we can't...
+ */
+static int stacker_unregister (const char *name, struct
security_operations *ops)
+{
+	struct module_entry *m, *b=NULL, *bb=NULL;
+	int len = strnlen(name, MAX_MODULE_NAME_LEN);
+	int ret = 0;
+
+	LOCK_STACKER_FOR_WRITING;
+	m = stacked_modules;
+	while (m) {
+		if (m->namelen == len && strncmp(m->module_name, name, len)==0)
+			break;
+		bb = b;
+		b = m;
+		m = m->next;
+	}
+	if (!m) {
+		printk(KERN_INFO "%s: could not find module %s.\n",
+			__FUNCTION__, name);
+		ret = -ENOENT;
+		goto out;
+	}
+	if (b)
+		b->next = m->next;
+	else
+		stacked_modules = m->next;
+
+	if (penultimate_stacked_module) {
+		if (penultimate_stacked_module == m)
+			penultimate_stacked_module = b;
+		else if (penultimate_stacked_module == b)
+			penultimate_stacked_module = bb;
+	}
+	num_stacked_modules--;
+	kfree(m->module_name);
+	kfree(m);
+out:
+	UNLOCK_STACKER_FOR_WRITING;
+
+	return ret;
+}
+
+
+#if 1
+struct security_operations stacker_ops = {
+	.ptrace =			stacker_ptrace,
+	.capget =			stacker_capget,
+	.capset_check =			stacker_capset_check,
+	.capset_set =			stacker_capset_set,
+	.acct =				stacker_acct,
+	.sysctl =			stacker_sysctl,
+	.capable =			stacker_capable,
+	.quotactl =			stacker_quotactl,
+	.quota_on =			stacker_quota_on,
+	.syslog =			stacker_syslog,
+	.vm_enough_memory = stacker_vm_enough_memory,
+
+	.bprm_alloc_security 	=	stacker_bprm_alloc_security,
+	.bprm_free_security 	=	stacker_bprm_free_security,
+	.bprm_apply_creds 	=	stacker_bprm_apply_creds,
+	.bprm_set_security 		=	stacker_bprm_set_security,
+	.bprm_check_security 	=	stacker_bprm_check_security,
+	.bprm_secureexec		=   stacker_bprm_secureexec,
+
+	.sb_alloc_security 		=	stacker_sb_alloc_security,
+	.sb_free_security 		=	stacker_sb_free_security,
+	.sb_copy_data			= stacker_sb_copy_data,
+	.sb_kern_mount			=	stacker_sb_kern_mount,
+	.sb_statfs =			stacker_sb_statfs,
+	.sb_mount =				stacker_mount,
+	.sb_check_sb =			stacker_check_sb,
+	.sb_umount =			stacker_umount,
+	.sb_umount_close =		stacker_umount_close,
+	.sb_umount_busy =		stacker_umount_busy,
+	.sb_post_remount =		stacker_post_remount,
+	.sb_post_mountroot =		stacker_post_mountroot,
+	.sb_post_addmount =		stacker_post_addmount,
+	.sb_pivotroot =			stacker_pivotroot,
+	.sb_post_pivotroot =		stacker_post_pivotroot,
+
+	.inode_alloc_security =		stacker_inode_alloc_security,
+	.inode_free_security =		stacker_inode_free_security,
+	.inode_create =			stacker_inode_create,
+	.inode_post_create =		stacker_inode_post_create,
+	.inode_link =			stacker_inode_link,
+	.inode_post_link =		stacker_inode_post_link,
+	.inode_unlink =			stacker_inode_unlink,
+	.inode_symlink =		stacker_inode_symlink,
+	.inode_post_symlink =		stacker_inode_post_symlink,
+	.inode_mkdir =			stacker_inode_mkdir,
+	.inode_post_mkdir =		stacker_inode_post_mkdir,
+	.inode_rmdir =			stacker_inode_rmdir,
+	.inode_mknod =			stacker_inode_mknod,
+	.inode_post_mknod =		stacker_inode_post_mknod,
+	.inode_rename =			stacker_inode_rename,
+	.inode_post_rename =		stacker_inode_post_rename,
+	.inode_readlink =		stacker_inode_readlink,
+	.inode_follow_link =		stacker_inode_follow_link,
+	.inode_permission =		stacker_inode_permission,
+
+	.inode_setattr			 = stacker_inode_setattr,
+	.inode_getattr 	 		 = stacker_inode_getattr,
+	.inode_delete 			 = stacker_inode_delete,
+	.inode_setxattr 		 = stacker_inode_setxattr,
+	.inode_post_setxattr 	 = stacker_inode_post_setxattr,
+	.inode_getxattr 		 = stacker_inode_getxattr,
+	.inode_listxattr 		 = stacker_inode_listxattr,
+	.inode_removexattr 		 = stacker_inode_removexattr,
+	.inode_getsecurity		 = stacker_inode_getsecurity,
+	.inode_setsecurity		 = stacker_inode_setsecurity,
+	.inode_listsecurity		 = stacker_inode_listsecurity,
+
+	.file_permission =		stacker_file_permission,
+	.file_alloc_security =		stacker_file_alloc_security,
+	.file_free_security =		stacker_file_free_security,
+	.file_ioctl =			stacker_file_ioctl,
+	.file_mmap =			stacker_file_mmap,
+	.file_mprotect =		stacker_file_mprotect,
+	.file_lock =			stacker_file_lock,
+	.file_fcntl =			stacker_file_fcntl,
+	.file_set_fowner =		stacker_file_set_fowner,
+	.file_send_sigiotask =		stacker_file_send_sigiotask,
+	.file_receive =			stacker_file_receive,
+
+	.task_create =			stacker_task_create,
+	.task_alloc_security =		stacker_task_alloc_security,
+	.task_free_security =		stacker_task_free_security,
+	.task_setuid =			stacker_task_setuid,
+	.task_post_setuid =		stacker_task_post_setuid,
+	.task_setgid =			stacker_task_setgid,
+	.task_setpgid =			stacker_task_setpgid,
+	.task_getpgid =			stacker_task_getpgid,
+	.task_getsid =			stacker_task_getsid,
+	.task_setgroups =		stacker_task_setgroups,
+	.task_setnice =			stacker_task_setnice,
+	.task_setrlimit =		stacker_task_setrlimit,
+	.task_setscheduler =		stacker_task_setscheduler,
+	.task_getscheduler =		stacker_task_getscheduler,
+	.task_kill =			stacker_task_kill,
+	.task_wait =			stacker_task_wait,
+	.task_prctl =			stacker_task_prctl,
+	.task_reparent_to_init =	stacker_task_reparent_to_init,
+	.task_to_inode =		stacker_task_to_inode,
+
+	.ipc_permission 		= stacker_ipc_permission,
+
+	.msg_msg_alloc_security =	stacker_msg_msg_alloc_security,
+	.msg_msg_free_security =	stacker_msg_msg_free_security,
+	.msg_queue_alloc_security =	stacker_msg_queue_alloc_security,
+	.msg_queue_free_security =	stacker_msg_queue_free_security,
+	.msg_queue_associate =		stacker_msg_queue_associate,
+	.msg_queue_msgctl =		stacker_msg_queue_msgctl,
+	.msg_queue_msgsnd =		stacker_msg_queue_msgsnd,
+	.msg_queue_msgrcv =		stacker_msg_queue_msgrcv,
+	.shm_alloc_security =		stacker_shm_alloc_security,
+	.shm_free_security =		stacker_shm_free_security,
+	.shm_associate =		stacker_shm_associate,
+	.shm_shmctl =			stacker_shm_shmctl,
+	.shm_shmat =			stacker_shm_shmat,
+
+	.sem_alloc_security =		stacker_sem_alloc_security,
+	.sem_free_security =		stacker_sem_free_security,
+	.sem_associate =		stacker_sem_associate,
+	.sem_semctl =			stacker_sem_semctl,
+	.sem_semop =			stacker_sem_semop,
+
+	.netlink_send 			= stacker_netlink_send,
+	.netlink_recv 			= stacker_netlink_recv,
+
+	.register_security =		stacker_register,
+	.unregister_security =		stacker_unregister,
+
+	.d_instantiate			 = stacker_d_instantiate,
+  	.getprocattr			 = stacker_getprocattr,
+  	.setprocattr			 = stacker_setprocattr,
+
+#ifdef CONFIG_SECURITY_NETWORK
+	.unix_stream_connect =		stacker_unix_stream_connect,
+	.unix_may_send =		stacker_unix_may_send,
+	.socket_create =		stacker_socket_create,
+	.socket_post_create =		stacker_socket_post_create,
+	.socket_bind =			stacker_socket_bind,
+	.socket_connect =		stacker_socket_connect,
+	.socket_listen =		stacker_socket_listen,
+	.socket_accept =		stacker_socket_accept,
+	.socket_post_accept =		stacker_socket_post_accept,
+	.socket_sendmsg =		stacker_socket_sendmsg,
+	.socket_recvmsg =		stacker_socket_recvmsg,
+	.socket_getsockname =		stacker_socket_getsockname,
+	.socket_getpeername =		stacker_socket_getpeername,
+	.socket_getsockopt =		stacker_socket_getsockopt,
+	.socket_setsockopt =		stacker_socket_setsockopt,
+	.socket_shutdown =		stacker_socket_shutdown,
+	.socket_sock_rcv_skb =		stacker_socket_sock_rcv_skb,
+	.socket_getpeersec =		stacker_socket_getpeersec,
+	.sk_alloc_security = 		stacker_sk_alloc_security,
+	.sk_free_security =		stacker_sk_free_security,
+#endif
+
+};
+#else
+struct security_operations stacker_ops = {
+	.register_security =		stacker_register,
+};
+#endif
+
+
+/*
+ * Functions to provide the sysfs interface
+ */
+
+/* A structure to pass into sysfs through kobjects */
+struct stacker_kobj {
+	struct list_head		slot_list;
+	struct kobject			kobj;
+};
+
+struct stacker_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct stacker_kobj *, char *);
+	ssize_t (*store)(struct stacker_kobj *, const char *, size_t);
+};
+
+/* variables to hold kobject/sysfs data */
+struct subsystem stacker_subsys;
+
+void unregister_sysfs_files(void);
+
+ssize_t stacker_attr_store(struct kobject *kobj,
+		struct attribute *attr, const char *buf, size_t len)
+{
+	struct stacker_kobj *obj = container_of(kobj,
+			struct stacker_kobj, kobj);
+	struct stacker_attribute *attribute = container_of(attr,
+			struct stacker_attribute, attr);
+	
+	return attribute->store ? attribute->store(obj, buf, len) : 0;
+}
+
+static ssize_t stacker_attr_show(struct kobject *kobj,
+		struct attribute *attr, char *buf)
+{
+	struct stacker_kobj *obj = container_of(kobj,
+			struct stacker_kobj, kobj);
+	struct stacker_attribute *attribute = container_of(attr,
+			struct stacker_attribute, attr);
+	
+	return attribute->show ? attribute->show(obj, buf) : 0;
+}
+
+struct sysfs_ops stacker_sysfs_ops = {
+	.show = stacker_attr_show,
+	.store = stacker_attr_store,
+};
+
+static struct kobj_type stacker_ktype = {
+	.sysfs_ops = &stacker_sysfs_ops
+};
+
+decl_subsys(stacker, &stacker_ktype, NULL);
+
+/* Set lockdown */
+static ssize_t lockdown_read (struct stacker_kobj *obj, char *buff)
+{
+	ssize_t len;
+
+	if (forbid_stacker_register)
+		len = sprintf(buff, "Locked down\n");
+	else
+		len = sprintf(buff, "Unlocked\n");
+
+	return len;
+}
+
+static ssize_t lockdown_write (struct stacker_kobj *obj, const char
*buff, size_t count)
+{
+	if (count>0)
+		forbid_stacker_register = 1;
+
+	return count;
+}
+
+static struct stacker_attribute stacker_attr_lockdown = {
+	.attr = {.name = "lockdown", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.show = lockdown_read,
+	.store = lockdown_write
+};
+
+/* list modules */
+static ssize_t listmodules_read (struct stacker_kobj *obj, char *buff)
+{
+	ssize_t len = 0;
+	struct module_entry *m;
+
+	LOCK_STACKER_FOR_READING;
+	for (m = stacked_modules; m; m = m->next)
+		len += snprintf(buff+len, PAGE_SIZE - len, "%s\n", m->module_name);
+	UNLOCK_STACKER_FOR_READING;
+
+	return len;
+}
+
+static ssize_t listmodules_write (struct stacker_kobj *obj, const char
*buff, size_t count)
+{
+	return count;
+}
+
+static struct stacker_attribute stacker_attr_listmodules = {
+	.attr = {.name = "list_modules", .mode = S_IFREG | S_IRUGO | S_IWUSR},
+	.show = listmodules_read,
+	.store = listmodules_write
+};
+
+/* stop responding to sysfs */
+static ssize_t stop_responding_read (struct stacker_kobj *obj, char
*buff)
+{
+	ssize_t len;
+
+	len = sprintf(buff, "Obviously not\n");
+
+	return len;
+}
+
+static ssize_t stop_responding_write (struct stacker_kobj *obj, const
char *buff, size_t count)
+{
+	if (count>0) {
+		unregister_sysfs_files();
+	}
+
+	return count;
+}
+
+static struct stacker_attribute stacker_attr_stop_responding = {
+	.attr = {.name = "stop_responding", .mode = S_IFREG | S_IRUGO |
S_IWUSR},
+	.show = stop_responding_read,
+	.store = stop_responding_write
+};
+
+/* short-circuit restrictive */
+static ssize_t shortcircuit_restrictive_read (struct stacker_kobj *obj,
char *buff)
+{
+	ssize_t len;
+
+	if (short_circuit_restrictive)
+		len = sprintf(buff, "Restrictive hooks are being
short-circuited.\n");
+	else
+		len = sprintf(buff, "Restrictive hooks are not being
short-circuited.\n");
+
+	return len;
+}
+
+static ssize_t shortcircuit_restrictive_write (struct stacker_kobj
*obj, const char *buff, size_t count)
+{
+	if (count==0)
+		short_circuit_restrictive = 0;
+	else
+		short_circuit_restrictive = 1;
+
+	return count;
+}
+
+static struct stacker_attribute stacker_attr_shortcircuit_restr = {
+	.attr = {.name = "shortcircuit_restrictive", .mode = S_IFREG | S_IRUGO
| S_IWUSR},
+	.show = shortcircuit_restrictive_read,
+	.store = shortcircuit_restrictive_write
+};
+
+/* short-circuit capable */
+static ssize_t shortcircuit_capable_read (struct stacker_kobj *obj,
char *buff)
+{
+	ssize_t len;
+
+	if (short_circuit_capable)
+		len = sprintf(buff, "Capable is being short-circuited.\n");
+	else
+		len = sprintf(buff, "Capable is not being short-circuited.\n");
+
+	return len;
+}
+
+static ssize_t shortcircuit_capable_write (struct stacker_kobj *obj,
const char *buff, size_t count)
+{
+	if (count==0)
+		short_circuit_capable = 0;
+	else
+		short_circuit_capable = 1;
+
+	return count;
+}
+
+static struct stacker_attribute stacker_attr_shortcircuit_cap = {
+	.attr = {.name = "shortcircuit_capable", .mode = S_IFREG | S_IRUGO |
S_IWUSR},
+	.show = shortcircuit_capable_read,
+	.store = shortcircuit_capable_write
+};
+
+void unregister_sysfs_files(void)
+{
+	struct kobject *kobj;
+
+	if (!sysfsfiles_registered)
+		return;
+
+	kobj = &stacker_subsys.kset.kobj;
+	sysfs_remove_file(kobj, &stacker_attr_lockdown.attr);
+	sysfs_remove_file(kobj, &stacker_attr_listmodules.attr);
+	sysfs_remove_file(kobj, &stacker_attr_stop_responding.attr);
+	sysfs_remove_file(kobj, &stacker_attr_shortcircuit_restr.attr);
+	sysfs_remove_file(kobj, &stacker_attr_shortcircuit_cap.attr);
+
+	sysfsfiles_registered = 0;
+}
+
+static int register_sysfs_files(void)
+{
+	int result;
+
+	result = subsystem_register(&stacker_subsys);
+	if (result) {
+		printk(KERN_NOTICE "Error (%d) registering stacker sysfssubsystem\n",
+				result);
+		return result;
+	}
+
+	sysfs_create_file(&stacker_subsys.kset.kobj, 
+			&stacker_attr_lockdown.attr);
+	sysfs_create_file(&stacker_subsys.kset.kobj, 
+			&stacker_attr_listmodules.attr);
+	sysfs_create_file(&stacker_subsys.kset.kobj, 
+			&stacker_attr_stop_responding.attr);
+	sysfs_create_file(&stacker_subsys.kset.kobj, 
+			&stacker_attr_shortcircuit_restr.attr);
+	sysfs_create_file(&stacker_subsys.kset.kobj, 
+			&stacker_attr_shortcircuit_cap.attr);
+	sysfsfiles_registered = 1;
+	printk(KERN_NOTICE "sysfs files registered\n");
+	return 0;
+}
+
+module_init(register_sysfs_files);
+
+/* 
+ * Structure sent back to security modules for getting and
+ * setting security blobs
+ */
+
+#if defined(CONFIG_SECURITY_stacker_MODULE)
+# define MY_NAME THIS_MODULE->name
+#else
+# define MY_NAME "stacker"
+#endif
+
+static int __init stacker_init (void)
+{
+	stacked_modules = NULL;
+	forbid_stacker_register = 0;
+	short_circuit_capable = 0;
+	short_circuit_restrictive = 0;
+	penultimate_stacked_module = NULL;
+	sysfsfiles_registered = 0;
+	num_stacked_modules = 0;
+
+	INIT_STACKER_LOCKING;
+
+	if (register_security (&stacker_ops)) {
+		/*
+		 * stacking stacker is just a stupid idea, so don't ask
+		 * the current module to load us.
+		 */
+		printk (KERN_INFO "Failure registering stacker module "
+			"with primary security module.\n");
+		return -EINVAL;
+	}
+	printk(KERN_INFO "Stacker LSM initialized\n");
+
+	return 0;
+}
+
+static void __exit stacker_exit (void)
+{
+	/*
+	 * Since we have no return value, we can't just say no.
+	 * Should probably force all child modules to exit somehow...
+	 */
+
+	unregister_sysfs_files();
+	if (unregister_security (&stacker_ops)) {
+		printk (KERN_INFO
+			"Failure unregistering stacker module with the kernel\n");
+	}
+}
+
+security_initcall (stacker_init);
+module_exit (stacker_exit);
+
+MODULE_DESCRIPTION("LSM Stacker - supports multiple simultaneous LSM
modules");
+MODULE_AUTHOR("David A. Wheeler, Serge Hallyn");
+MODULE_LICENSE("GPL");
Index: linux-2.6.10-rc1-bk12-stack/security/stacker.h
===================================================================
--- linux-2.6.10-rc1-bk12-stack.orig/security/stacker.h	2004-11-02
13:46:30.056668176 -0600
+++ linux-2.6.10-rc1-bk12-stack/security/stacker.h	2004-11-02
19:58:22.848371840 -0600
@@ -0,0 +1,33 @@
+#ifndef __STACKER_H
+#define __STACKER_H
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/security.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+#include <linux/capability.h>
+#include <linux/rwsem.h>
+#include <asm/semaphore.h>
+#include <asm/system.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/spinlock.h>
+#include <linux/netdevice.h>
+#include <linux/string.h>
+
+/* A "module entry" keeps track of one of the stacked modules
+ * Note that module_operations is aggregated instead of being pointed
to -
+ * it's one less allocation and one less pointer to follow. */
+
+struct module_entry {
+	struct module_entry *next; /* MUST BE FIRST for alignment */
+	struct module_entry *inactive_next; /* USE THIS for inactive list */
+	char *module_name;
+	int namelen;
+	struct security_operations module_operations;
+	int offset;  /* mainly used when we control obj->security structs */
+};
+#endif


