Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSJOWhl>; Tue, 15 Oct 2002 18:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265075AbSJOW3K>; Tue, 15 Oct 2002 18:29:10 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:47627 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265036AbSJOW1G>; Tue, 15 Oct 2002 18:27:06 -0400
Date: Tue, 15 Oct 2002 23:32:55 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [2/7] oprofile - dcookies
Message-ID: <20021015223255.GB41906@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *181aFD-000DFA-00*PqY73Jc18Fk* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[2/7] dcookies

This implements the persistent path-to-dcookies mapping, and adds a
system call for the user-space profiler to look up the profile data,
so it can tag profiles to specific binaries.


diff -Naur -X dontdiff linux-linus/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-linus/arch/i386/kernel/entry.S	Sun Oct 13 19:51:03 2002
+++ linux/arch/i386/kernel/entry.S	Tue Oct 15 21:45:51 2002
@@ -736,6 +736,7 @@
 	.long sys_alloc_hugepages /* 250 */
 	.long sys_free_hugepages
 	.long sys_exit_group
+	.long sys_lookup_dcookie
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -Naur -X dontdiff linux-linus/fs/Makefile linux/fs/Makefile
--- linux-linus/fs/Makefile	Tue Oct 15 21:47:20 2002
+++ linux/fs/Makefile	Tue Oct 15 21:45:51 2002
@@ -6,7 +6,7 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o
+                fcntl.o read_write.o dcookies.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
@@ -40,6 +40,8 @@
 obj-y				+= driverfs/
 obj-y				+= devpts/
 
+obj-$(CONFIG_PROFILING)		+= dcookies.o
+ 
 # Do not add any filesystems before this line
 obj-$(CONFIG_EXT3_FS)		+= ext3/ # Before ext2 so root fs can be ext3
 obj-$(CONFIG_JBD)		+= jbd/
diff -Naur -X dontdiff linux-linus/fs/dcache.c linux/fs/dcache.c
--- linux-linus/fs/dcache.c	Tue Oct 15 21:47:20 2002
+++ linux/fs/dcache.c	Tue Oct 15 21:45:51 2002
@@ -637,6 +637,7 @@
 	dentry->d_op = NULL;
 	dentry->d_fsdata = NULL;
 	dentry->d_mounted = 0;
+	dentry->d_cookie = NULL;
 	INIT_LIST_HEAD(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_LIST_HEAD(&dentry->d_subdirs);
diff -Naur -X dontdiff linux-linus/fs/dcookies.c linux/fs/dcookies.c
--- linux-linus/fs/dcookies.c	Thu Jan  1 01:00:00 1970
+++ linux/fs/dcookies.c	Tue Oct 15 21:45:51 2002
@@ -0,0 +1,323 @@
+/*
+ * dcookies.c
+ *
+ * Copyright 2002 John Levon <levon@movementarian.org>
+ *
+ * Persistent cookie-path mappings. These are used by
+ * profilers to convert a per-task EIP value into something
+ * non-transitory that can be processed at a later date.
+ * This is done by locking the dentry/vfsmnt pair in the
+ * kernel until released by the tasks needing the persistent
+ * objects. The tag is simply an unsigned long that refers
+ * to the pair and can be looked up from userspace.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/mount.h>
+#include <linux/dcache.h>
+#include <linux/mm.h>
+#include <linux/errno.h>
+#include <linux/dcookies.h>
+#include <asm/uaccess.h>
+
+/* The dcookies are allocated from a kmem_cache and
+ * hashed onto a small number of lists. None of the
+ * code here is particularly performance critical
+ */
+struct dcookie_struct {
+	struct dentry * dentry;
+	struct vfsmount * vfsmnt;
+	struct list_head hash_list;
+};
+
+static LIST_HEAD(dcookie_users);
+static DECLARE_MUTEX(dcookie_sem);
+static kmem_cache_t * dcookie_cache;
+static struct list_head * dcookie_hashtable;
+static size_t hash_size;
+
+static inline int is_live(void)
+{
+	return !(list_empty(&dcookie_users));
+}
+
+
+/* The dentry is locked, its address will do for the cookie */
+static inline unsigned long dcookie_value(struct dcookie_struct * dcs)
+{
+	return (unsigned long)dcs->dentry;
+}
+
+
+static size_t dcookie_hash(unsigned long dcookie)
+{
+	return (dcookie >> 2) & (hash_size - 1);
+}
+
+
+static struct dcookie_struct * find_dcookie(unsigned long dcookie)
+{
+	struct dcookie_struct * found = 0;
+	struct dcookie_struct * dcs;
+	struct list_head * pos;
+	struct list_head * list;
+
+	list = dcookie_hashtable + dcookie_hash(dcookie);
+
+	list_for_each(pos, list) {
+		dcs = list_entry(pos, struct dcookie_struct, hash_list);
+		if (dcookie_value(dcs) == dcookie) {
+			found = dcs;
+			break;
+		}
+	}
+
+	return found;
+}
+
+
+static void hash_dcookie(struct dcookie_struct * dcs)
+{
+	struct list_head * list = dcookie_hashtable + dcookie_hash(dcookie_value(dcs));
+	list_add(&dcs->hash_list, list);
+}
+
+
+static struct dcookie_struct * alloc_dcookie(struct dentry * dentry,
+	struct vfsmount * vfsmnt)
+{
+	struct dcookie_struct * dcs = kmem_cache_alloc(dcookie_cache, GFP_KERNEL);
+	if (!dcs)
+		return NULL;
+
+	atomic_inc(&dentry->d_count);
+	atomic_inc(&vfsmnt->mnt_count);
+	dentry->d_cookie = dcs;
+
+	dcs->dentry = dentry;
+	dcs->vfsmnt = vfsmnt;
+	hash_dcookie(dcs);
+
+	return dcs;
+}
+
+
+/* This is the main kernel-side routine that retrieves the cookie
+ * value for a dentry/vfsmnt pair.
+ */
+int get_dcookie(struct dentry * dentry, struct vfsmount * vfsmnt,
+	unsigned long * cookie)
+{
+	int err = 0;
+	struct dcookie_struct * dcs;
+
+	down(&dcookie_sem);
+
+	if (!is_live()) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	dcs = dentry->d_cookie;
+
+	if (!dcs)
+		dcs = alloc_dcookie(dentry, vfsmnt);
+
+	if (!dcs) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	*cookie = dcookie_value(dcs);
+
+out:
+	up(&dcookie_sem);
+	return err;
+}
+
+
+/* And here is where the userspace process can look up the cookie value
+ * to retrieve the path.
+ */
+asmlinkage int sys_lookup_dcookie(unsigned long cookie, char * buf, size_t len)
+{
+	char * kbuf;
+	char * path;
+	int err = -EINVAL;
+	size_t pathlen;
+	struct dcookie_struct * dcs;
+
+	/* we could leak path information to users
+	 * without dir read permission without this
+	 */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	down(&dcookie_sem);
+
+	if (!is_live()) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	if (!(dcs = find_dcookie(cookie)))
+		goto out;
+
+	err = -ENOMEM;
+	kbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!kbuf)
+		goto out;
+	memset(kbuf, 0, PAGE_SIZE);
+
+	/* FIXME: (deleted) ? */
+	path = d_path(dcs->dentry, dcs->vfsmnt, kbuf, PAGE_SIZE);
+
+	err = 0;
+
+	pathlen = kbuf + PAGE_SIZE - path;
+	if (len > pathlen)
+		len = pathlen;
+
+	if (copy_to_user(buf, path, len))
+		err = -EFAULT;
+
+	kfree(kbuf);
+out:
+	up(&dcookie_sem);
+	return err;
+}
+
+
+static int dcookie_init(void)
+{
+	struct list_head * d;
+	unsigned int i, hash_bits;
+	int err = -ENOMEM;
+
+	dcookie_cache = kmem_cache_create("dcookie_cache",
+		sizeof(struct dcookie_struct),
+		0, 0, NULL, NULL);
+
+	if (!dcookie_cache)
+		goto out;
+
+	dcookie_hashtable = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!dcookie_hashtable)
+		goto out_kmem;
+
+	err = 0;
+
+	/*
+	 * Find the power-of-two list-heads that can fit into the allocation..
+	 * We don't guarantee that "sizeof(struct list_head)" is necessarily
+	 * a power-of-two.
+	 */
+	hash_size = PAGE_SIZE / sizeof(struct list_head);
+	hash_bits = 0;
+	do {
+		hash_bits++;
+	} while ((hash_size >> hash_bits) != 0);
+	hash_bits--;
+
+	/*
+	 * Re-calculate the actual number of entries and the mask
+	 * from the number of bits we can fit.
+	 */
+	hash_size = 1UL << hash_bits;
+
+	/* And initialize the newly allocated array */
+	d = dcookie_hashtable;
+	i = hash_size;
+	do {
+		INIT_LIST_HEAD(d);
+		d++;
+		i--;
+	} while (i);
+
+out:
+	return err;
+out_kmem:
+	kmem_cache_destroy(dcookie_cache);
+	goto out;
+}
+
+
+static void free_dcookie(struct dcookie_struct * dcs)
+{
+	dcs->dentry->d_cookie = NULL;
+	dput(dcs->dentry);
+	mntput(dcs->vfsmnt);
+	kmem_cache_free(dcookie_cache, dcs);
+}
+
+
+static void dcookie_exit(void)
+{
+	struct list_head * list;
+	struct list_head * pos;
+	struct list_head * pos2;
+	struct dcookie_struct * dcs;
+	size_t i;
+
+	for (i = 0; i < hash_size; ++i) {
+		list = dcookie_hashtable + i;
+		list_for_each_safe(pos, pos2, list) {
+			dcs = list_entry(pos, struct dcookie_struct, hash_list);
+			list_del(&dcs->hash_list);
+			free_dcookie(dcs);
+		}
+	}
+
+	kfree(dcookie_hashtable);
+	kmem_cache_destroy(dcookie_cache);
+}
+
+
+struct dcookie_user {
+	struct list_head next;
+};
+ 
+struct dcookie_user * dcookie_register(void)
+{
+	struct dcookie_user * user;
+
+	down(&dcookie_sem);
+
+	user = kmalloc(sizeof(struct dcookie_user), GFP_KERNEL);
+	if (!user)
+		goto out;
+
+	if (!is_live() && dcookie_init())
+		goto out_free;
+
+	list_add(&user->next, &dcookie_users);
+
+out:
+	up(&dcookie_sem);
+	return user;
+out_free:
+	kfree(user);
+	user = NULL;
+	goto out;
+}
+
+
+void dcookie_unregister(struct dcookie_user * user)
+{
+	down(&dcookie_sem);
+
+	list_del(&user->next);
+	kfree(user);
+
+	if (!is_live())
+		dcookie_exit();
+
+	up(&dcookie_sem);
+}
+
+EXPORT_SYMBOL_GPL(dcookie_register);
+EXPORT_SYMBOL_GPL(dcookie_unregister);
+EXPORT_SYMBOL_GPL(get_dcookie);
diff -Naur -X dontdiff linux-linus/include/asm-i386/unistd.h linux/include/asm-i386/unistd.h
--- linux-linus/include/asm-i386/unistd.h	Sun Oct 13 19:51:03 2002
+++ linux/include/asm-i386/unistd.h	Tue Oct 15 21:45:52 2002
@@ -257,6 +257,8 @@
 #define __NR_alloc_hugepages	250
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
+#define __NR_lookup_dcookie	253
+  
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Naur -X dontdiff linux-linus/include/linux/dcache.h linux/include/linux/dcache.h
--- linux-linus/include/linux/dcache.h	Tue Oct 15 21:47:21 2002
+++ linux/include/linux/dcache.h	Tue Oct 15 21:45:52 2002
@@ -66,6 +66,8 @@
 
 #define DNAME_INLINE_LEN 16
 
+struct dcookie_struct;
+ 
 struct dentry {
 	atomic_t d_count;
 	unsigned int d_flags;
@@ -84,6 +86,7 @@
 	unsigned long d_vfs_flags;
 	void * d_fsdata;		/* fs-specific data */
 	unsigned char d_iname[DNAME_INLINE_LEN]; /* small names */
+	struct dcookie_struct * d_cookie; /* cookie, if any */
 };
 
 struct dentry_operations {
diff -Naur -X dontdiff linux-linus/include/linux/dcookies.h linux/include/linux/dcookies.h
--- linux-linus/include/linux/dcookies.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/dcookies.h	Tue Oct 15 21:45:52 2002
@@ -0,0 +1,69 @@
+/*
+ * dcookies.h
+ *
+ * Persistent cookie-path mappings
+ *
+ * Copyright 2002 John Levon <levon@movementarian.org>
+ */
+
+#ifndef DCOOKIES_H
+#define DCOOKIES_H
+ 
+#include <linux/config.h>
+
+#ifdef CONFIG_PROFILING
+ 
+#include <linux/types.h>
+ 
+struct dcookie_user;
+ 
+/**
+ * dcookie_register - register a user of dcookies
+ *
+ * Register as a dcookie user. Returns %NULL on failure.
+ */
+struct dcookie_user * dcookie_register(void);
+
+/**
+ * dcookie_unregister - unregister a user of dcookies
+ *
+ * Unregister as a dcookie user. This may invalidate
+ * any dcookie values returned from get_dcookie().
+ */
+void dcookie_unregister(struct dcookie_user * user);
+  
+/**
+ * get_dcookie - acquire a dcookie
+ *
+ * Convert the given dentry/vfsmount pair into
+ * a cookie value.
+ *
+ * Returns -EINVAL if no living task has registered as a
+ * dcookie user.
+ *
+ * Returns 0 on success, with *cookie filled in
+ */
+int get_dcookie(struct dentry * dentry, struct vfsmount * vfsmnt,
+	unsigned long * cookie);
+
+#else
+
+struct dcookie_user * dcookie_register(void)
+{
+	return 0;
+}
+
+void dcookie_unregister(struct dcookie_user * user)
+{
+	return;
+}
+ 
+static inline int get_dcookie(struct dentry * dentry,
+	struct vfsmount * vfsmnt, unsigned long * cookie)
+{
+	return -ENOSYS;
+} 
+ 
+#endif /* CONFIG_PROFILING */
+ 
+#endif /* DCOOKIES_H */
diff -Naur -X dontdiff linux-linus/kernel/sys.c linux/kernel/sys.c
--- linux-linus/kernel/sys.c	Sun Oct 13 19:51:03 2002
+++ linux/kernel/sys.c	Tue Oct 15 21:45:52 2002
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 #include <linux/times.h>
 #include <linux/security.h>
+#include <linux/dcookies.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -202,6 +203,7 @@
 cond_syscall(sys_nfsservctl)
 cond_syscall(sys_quotactl)
 cond_syscall(sys_acct)
+cond_syscall(sys_lookup_dcookie)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
