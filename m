Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286167AbRLTGQl>; Thu, 20 Dec 2001 01:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286171AbRLTGQ3>; Thu, 20 Dec 2001 01:16:29 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:55812 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S286167AbRLTGPw>; Thu, 20 Dec 2001 01:15:52 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] /proc/sys replacement code (in progress)
Date: Thu, 20 Dec 2001 17:15:40 +1100
Message-Id: <E16GwUW-0004xj-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After my last /proc patch (see "Replacement for current /proc of shit"
thread), it has become clear that my new "single value" proc code is
more appropriate in a new filesystem.  I have also removed the
(complex) dynamic directory support.

The patch against 2.5.1 is included below: it doesn't yet have the
glue layer to support the old sysctl code, which I'll work on when I
come back from Christmas holidays (early January).

For full details:
	http://www.kernel.org/pub/linux/kernel/people/rusty/

Comments *ON THE CODE* eagerly sought,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.16-uml/fs/sys/test.c working-2.4.16-uml-proc/fs/sys/test.c
--- linux-2.4.16-uml/fs/sys/test.c	Thu Jan  1 10:00:00 1970
+++ working-2.4.16-uml-proc/fs/sys/test.c	Thu Dec 20 15:34:27 2001
@@ -0,0 +1,54 @@
+/* Test stuff for new sys */
+#include <linux/sys_fs.h>
+#include <linux/spinlock.h>
+#include <asm/semaphore.h>
+
+static spinlock_t test_lock = SPIN_LOCK_UNLOCKED;
+static DECLARE_MUTEX(test_sem);
+
+unsigned int a, b, c;
+
+static int set_off(const char *dirname,
+		   const char *filename,
+		   const char *buffer,
+		   unsigned int size,
+		   void *arg)
+{
+	if (size < sizeof("REMOVE")-1)
+		return -1; /* FIXME: -EINVAL */
+	if (strncmp("REMOVE", buffer, sizeof("REMOVE")-1) == 0) {
+		/* Remove everything */
+		unsys("test", "a");
+		unsys("test", "b");
+		unsys("test", "c");
+		unsys("test", "off");
+	}
+	return 0;
+}
+
+static int get_off(const char *dirname,
+		   const char *filename,
+		   char *buffer,
+		   unsigned int size,
+		   void *arg)
+{
+	return snprintf(buffer, size, "Write REMOVE here to remove me\n");
+}
+
+static int __init init_test(void)
+{
+	if (sys("test", "a", a, uint, S_IWUSR|S_IRUGO) != 0)
+		printk("Failed: a");
+	if (sys_spinlock("test", "b", b, uint, &test_lock, S_IWUSR|S_IRUGO)
+	    != 0)
+		printk("Failed: b");
+	if (sys_sem("test", "c", c, uint, &test_sem, S_IWUSR|S_IRUGO) != 0)
+		printk("Failed: c");
+	if (sys_callfn("test", "off", get_off, set_off, NULL, S_IWUSR|S_IRUGO)
+	    != 0)
+		printk("Failed: off");
+
+	return 0;
+}
+
+module_init(init_test);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.16-uml/include/linux/sys_fs.h working-2.4.16-uml-proc/include/linux/sys_fs.h
--- linux-2.4.16-uml/include/linux/sys_fs.h	Thu Jan  1 10:00:00 1970
+++ working-2.4.16-uml-proc/include/linux/sys_fs.h	Thu Dec 20 13:58:21 2001
@@ -0,0 +1,127 @@
+#ifndef _LINUX_SYS_FS_H
+#define _LINUX_SYS_FS_H
+/* Kernel presentation interface.  Just be grateful I didn't call it
+   systables... */
+/* (C) 2001 Rusty Russell. */
+
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/stat.h>
+#include <linux/typecheck.h>
+
+/* Commit the contents of this (NUL-terminated) buffer if possible.
+   -errno indicates error. */
+typedef int (sys_commitfn_t)(const char *dirname,
+			     const char *filename,
+			     const char *buffer,
+			     unsigned int size,
+			     void *arg);
+/* Fetch the contents into buffer: return size used (or needed), or
+   -errno. */
+typedef int (sys_fetchfn_t)(const char *dirname,
+			    const char *filename,
+			    char *buffer,
+			    unsigned int size,
+			    void *arg);
+
+/* Register a sys entry of the given type. */
+#define sys(dir, fname, var, type, perms)				 \
+	__sys(dir, fname, S_IFREG|(perms),				 \
+	       __new_sys(&var,						 \
+			  ((perms)&S_IRUGO) ? sys_fetch_##type : NULL,	 \
+			  ((perms)&S_IWUGO) ? sys_commit_##type : NULL))
+
+/* Register a sys entry protected by a spinlock. */
+#define sys_spinlock(dir, fname, var, type, lock, p)			   \
+	__sys(dir, fname, S_IFREG|(p),					   \
+	       __new_sys_lock(&var, lock,				   \
+			       ((p)&S_IRUGO) ? sys_fetch_##type : NULL,   \
+			       ((p)&S_IWUGO) ? sys_commit_##type : NULL))
+
+/* Register a sys entry protected by a semaphore. */
+#define sys_sem(dir, fname, var, type, sem, p)				  \
+	__sys(dir, fname, S_IFREG|(p),					  \
+	       __new_sys_sem(&var, sem,					  \
+			      ((p)&S_IRUGO) ? sys_fetch_##type : NULL,	  \
+			      ((p)&S_IWUGO) ? sys_commit_##type : NULL))
+
+/* Generic sys interface. */
+#define sys_callfn(dir, fname, fetch, commit, datap, perms)		    \
+	__sys(dir, fname, S_IFREG|(perms), __new_sys(datap, fetch, commit))
+
+/* These exist, believe me */
+struct semaphore;
+struct sys_data;
+
+#ifdef CONFIG_SYS_FS
+/* Low level functions */
+int __sys(const char *dirname, const char *fname, int mode,
+	  struct sys_data *pdata);
+struct sys_data *__new_sys(void *arg, sys_fetchfn_t *, sys_commitfn_t *);
+struct sys_data *__new_sys_lock(void *arg, spinlock_t *lock,
+				sys_fetchfn_t *, sys_commitfn_t *);
+struct sys_data *__new_sys_sem(void *arg, struct semaphore *sem,
+			       sys_fetchfn_t *, sys_commitfn_t *);
+
+/* Release a sys entry */
+void unsys(const char *dir, const char *fname);
+
+#else
+static inline void unsys(const char *dir, const char *fname)
+{
+}
+
+static inline int __sys(const char *dirname, const char *fname, int mode,
+			struct sys_data *pdata)
+{
+	return 0;
+}
+
+static inline struct sys_data *__new_sys(void *arg,
+					 sys_fetchfn_t *fetch,
+					 sys_commitfn_t *commit)
+{
+	return (struct sys_data *)-1;
+}
+static inline struct sys_data *__new_sys_lock(void *arg, spinlock_t *lock,
+					      sys_fetchfn_t *fetch,
+					      sys_commitfn_t *commit)
+{
+	return (struct sys_data *)-1;
+}
+static inline struct sys_data *__new_sys_sem(void *arg, struct semaphore *sem,
+					     sys_fetchfn_t *fetch,
+					     sys_commitfn_t *commit)
+{
+	return (struct sys_data *)-1;
+}
+#endif /*CONFIG_SYS_FS*/
+
+/* Helper parsing routines.  You can write your own, too. */
+sys_fetchfn_t sys_fetch_short;
+sys_fetchfn_t sys_fetch_ushort;
+sys_fetchfn_t sys_fetch_int;
+sys_fetchfn_t sys_fetch_uint;
+sys_fetchfn_t sys_fetch_long;
+sys_fetchfn_t sys_fetch_ulong;
+sys_fetchfn_t sys_fetch_bool;
+
+sys_commitfn_t sys_commit_short;
+sys_commitfn_t sys_commit_ushort;
+sys_commitfn_t sys_commit_int;
+sys_commitfn_t sys_commit_uint;
+sys_commitfn_t sys_commit_long;
+sys_commitfn_t sys_commit_ulong;
+sys_commitfn_t sys_commit_bool;
+
+/* Internal use */
+struct sys_data
+{
+	/* User-defined argument for routines */
+	void *arg;
+
+	sys_commitfn_t *commit;
+	sys_fetchfn_t *fetch;
+};
+#endif /* _LINUX_SYS_FS_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.16-uml/fs/Config.in working-2.4.16-uml-proc/fs/Config.in
--- linux-2.4.16-uml/fs/Config.in	Thu Dec 13 17:00:55 2001
+++ working-2.4.16-uml-proc/fs/Config.in	Thu Dec 20 12:31:41 2001
@@ -61,6 +61,8 @@
 
 bool '/proc file system support' CONFIG_PROC_FS
 
+bool '/proc/sys file system support (EXPERIMENTAL)' CONFIG_SYS_FS $CONFIG_EXPERIMENTAL
+
 dep_bool '/dev file system support (EXPERIMENTAL)' CONFIG_DEVFS_FS $CONFIG_EXPERIMENTAL
 dep_bool '  Automatically mount at boot' CONFIG_DEVFS_MOUNT $CONFIG_DEVFS_FS
 dep_bool '  Debug devfs' CONFIG_DEVFS_DEBUG $CONFIG_DEVFS_FS
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.16-uml/fs/Makefile working-2.4.16-uml-proc/fs/Makefile
--- linux-2.4.16-uml/fs/Makefile	Thu Dec 13 17:00:55 2001
+++ working-2.4.16-uml-proc/fs/Makefile	Thu Dec 20 12:31:41 2001
@@ -23,6 +23,7 @@
 endif
 
 subdir-$(CONFIG_PROC_FS)	+= proc
+subdir-$(CONFIG_SYS_FS)		+= sys
 subdir-y			+= partitions
 
 # Do not add any filesystems before this line
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.16-uml/fs/sys/Makefile working-2.4.16-uml-proc/fs/sys/Makefile
--- linux-2.4.16-uml/fs/sys/Makefile	Thu Jan  1 10:00:00 1970
+++ working-2.4.16-uml-proc/fs/sys/Makefile	Thu Dec 20 12:31:41 2001
@@ -0,0 +1,9 @@
+# Makefile for the Linux sys filesystem routines.
+
+O_TARGET := sys.o
+
+export-objs := helper.o sys_core.o
+
+obj-y    := sys_core.o helper.o test.o
+
+include $(TOPDIR)/Rules.make
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.16-uml/fs/sys/helper.c working-2.4.16-uml-proc/fs/sys/helper.c
--- linux-2.4.16-uml/fs/sys/helper.c	Thu Jan  1 10:00:00 1970
+++ working-2.4.16-uml-proc/fs/sys/helper.c	Thu Dec 20 12:31:41 2001
@@ -0,0 +1,233 @@
+/* Copyright (C) 2001 Rusty Russell.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA */
+#include <linux/sys_fs.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/dcache.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+/* Wrapper for user's real sys functions */
+struct sdata_wrapper
+{
+	struct sys_data sdata;
+	sys_fetchfn_t *fetch;
+	sys_commitfn_t *commit;
+	void *lock;
+	void *userarg;
+};
+
+static struct sys_data *new_wrapper(sys_fetchfn_t *userfetch,
+				    sys_commitfn_t *usercommit,
+				    void *userarg,
+				    sys_fetchfn_t *wrapfetch,
+				    sys_commitfn_t *wrapcommit,
+				    void *lock)
+{
+	struct sdata_wrapper *swrap;
+
+	swrap = kmalloc(sizeof(*swrap), GFP_KERNEL);
+	if (swrap) {
+		swrap->sdata.arg = swrap;
+		swrap->sdata.fetch = wrapfetch;
+		swrap->sdata.commit = wrapcommit;
+		swrap->fetch = userfetch;
+		swrap->commit = usercommit;
+		swrap->lock = lock;
+		swrap->userarg = userarg;
+	}
+	return &swrap->sdata;
+}
+
+static int lock_fetch(const char *dirname, const char *fname,
+		      char *buffer, unsigned int size, void *arg)
+{
+	struct sdata_wrapper *swrap = arg;
+	int ret;
+
+	spin_lock_irq(swrap->lock);
+	ret = swrap->fetch(dirname, fname, swrap->userarg, size, buffer);
+	spin_unlock_irq(swrap->lock);
+
+	return ret;
+}
+
+static int lock_commit(const char *dirname, const char *fname,
+		       const char *buffer, unsigned int size, void *arg)
+{
+	struct sdata_wrapper *swrap = arg;
+	int ret;
+
+	spin_lock_irq(swrap->lock);
+	ret = swrap->commit(dirname, fname, buffer, size, swrap->userarg);
+	spin_unlock_irq(swrap->lock);
+
+	return ret;
+}
+
+struct sys_data *__new_sys_lock(void *arg, spinlock_t *lock,
+				sys_fetchfn_t *fetch,
+				sys_commitfn_t *commit)
+{
+	return new_wrapper(fetch, commit, arg, lock_fetch, lock_commit, lock);
+}
+
+static int sem_fetch(const char *dirname, const char *fname,
+		     char *buffer, unsigned int size, void *arg)
+{
+	struct sdata_wrapper *swrap = arg;
+	int ret;
+
+	if (down_interruptible(swrap->lock) != 0)
+		return -EINTR;
+	ret = swrap->fetch(dirname, fname, swrap->userarg, size, buffer);
+	up(swrap->lock);
+
+	return ret;
+}
+
+static int sem_commit(const char *dirname, const char *fname,
+		      const char *buffer, unsigned int size, void *arg)
+{
+	struct sdata_wrapper *swrap = arg;
+	int ret;
+
+	if (down_interruptible(swrap->lock) != 0)
+		return -EINTR;
+	ret = swrap->commit(dirname, fname, buffer, size, swrap->userarg);
+	up(swrap->lock);
+
+	return ret;
+}
+
+struct sys_data *__new_sys_sem(void *arg, struct semaphore *sem,
+			       sys_fetchfn_t *fetch,
+			       sys_commitfn_t *commit)
+{
+	return new_wrapper(fetch, commit, arg, sem_fetch, sem_commit, sem);
+}
+
+int sys_fetch_short(const char *dir, const char *fname,
+		    char *outbuf, unsigned int size, void *shortp)
+{
+	return snprintf(outbuf, size, "%hi\n", *(short *)shortp);
+}
+
+int sys_commit_short(const char *dir, const char *fname,
+		     const char *inbuf, unsigned int size, void *shortp)
+{
+	if (sscanf(inbuf, "%hi", (short *)shortp) != 1) return -EINVAL;
+	return 0;
+}
+
+int sys_fetch_ushort(const char *dir, const char *fname,
+		     char *outbuf, unsigned int size, void *ushortp)
+{
+	return snprintf(outbuf, size, "%hu\n", *(unsigned short *)ushortp);
+}
+
+int sys_commit_ushort(const char *dir, const char *fname,
+		      const char *inbuf, unsigned int size, void *ushortp)
+{
+	if (sscanf(inbuf, "%hu", (unsigned short *)ushortp) != 1)
+		return -EINVAL;
+	return 0;
+}
+
+int sys_fetch_int(const char *dir, const char *fname,
+		  char *outbuf, unsigned int size, void *intp)
+{
+	return snprintf(outbuf, size, "%i\n", *(int *)intp);
+}
+
+int sys_commit_int(const char *dir, const char *fname,
+		   const char *inbuf, unsigned int size, void *intp)
+{
+	if (sscanf(inbuf, "%i", (int *)intp) != 1) return -EINVAL;
+	return 0;
+}
+
+int sys_fetch_uint(const char *dir, const char *fname,
+		   char *outbuf, unsigned int size, void *uintp)
+{
+	return snprintf(outbuf, size, "%u\n", *(unsigned int *)uintp);
+}
+
+int sys_commit_uint(const char *dir, const char *fname,
+		    const char *inbuf, unsigned int size, void *uintp)
+{
+	if (sscanf(inbuf, "%u", (unsigned int *)uintp) != 1) return -EINVAL;
+	return 0;
+}
+
+int sys_fetch_long(const char *dir, const char *fname,
+		   char *outbuf, unsigned int size, void *longp)
+{
+	return snprintf(outbuf, size, "%li\n", *(long *)longp);
+}
+
+int sys_commit_long(const char *dir, const char *fname,
+		    const char *inbuf, unsigned int size, void *longp)
+{
+	if (sscanf(inbuf, "%li", (long *)longp) != 1) return -EINVAL;
+	return 0;
+}
+
+int sys_fetch_ulong(const char *dir, const char *fname,
+		    char *outbuf, unsigned int size, void *ulongp)
+{
+	return snprintf(outbuf, size, "%lu\n", *(long *)ulongp);
+}
+
+int sys_commit_ulong(const char *dir, const char *fname,
+		     const char *inbuf, unsigned int size, void *ulongp)
+{
+	if (sscanf(inbuf, "%lu", (unsigned long *)ulongp) != 1) return -EINVAL;
+	return 0;
+}
+
+int sys_fetch_bool(const char *dir, const char *fname,
+		   char *outbuf, unsigned int size, void *boolp)
+{
+	if (*(int *)boolp) return snprintf(outbuf, size, "y\n");
+	else return snprintf(outbuf, size, "n\n");
+}
+
+int sys_commit_bool(const char *dir, const char *fname,
+		    const char *inbuf, unsigned int size, void *boolp)
+{
+	if (inbuf[0] == 'y' || inbuf[0] == 'Y')
+		*(int *)boolp = 1;
+	else if (inbuf[0] == 'n' || inbuf[0] == 'N')
+		*(int *)boolp = 0;
+	else return sys_commit_int(dir, fname, inbuf, size, boolp);
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(sys_fetch_short);
+EXPORT_SYMBOL_GPL(sys_commit_short);
+EXPORT_SYMBOL_GPL(sys_fetch_ushort);
+EXPORT_SYMBOL_GPL(sys_commit_ushort);
+EXPORT_SYMBOL_GPL(sys_fetch_int);
+EXPORT_SYMBOL_GPL(sys_commit_int);
+EXPORT_SYMBOL_GPL(sys_fetch_uint);
+EXPORT_SYMBOL_GPL(sys_commit_uint);
+EXPORT_SYMBOL_GPL(sys_fetch_long);
+EXPORT_SYMBOL_GPL(sys_commit_long);
+EXPORT_SYMBOL_GPL(sys_fetch_ulong);
+EXPORT_SYMBOL_GPL(sys_commit_ulong);
+EXPORT_SYMBOL_GPL(sys_fetch_bool);
+EXPORT_SYMBOL_GPL(sys_commit_bool);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.16-uml/fs/sys/sys_core.c working-2.4.16-uml-proc/fs/sys/sys_core.c
--- linux-2.4.16-uml/fs/sys/sys_core.c	Thu Jan  1 10:00:00 1970
+++ working-2.4.16-uml-proc/fs/sys/sys_core.c	Thu Dec 20 15:34:02 2001
@@ -0,0 +1,550 @@
+/* Copyright (C) 2001 Rusty Russell.
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA */
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/stat.h>
+#include <linux/slab.h>
+#include <linux/pagemap.h>
+#include <linux/sys_fs.h>
+#include <linux/module.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+/* Sys mount point */
+static struct vfsmount *sys_mnt;
+
+/* Serialize insert/delete and mounts */
+static DECLARE_MUTEX(sys_semaphore);
+
+#define SIMPLE_SYSFS_MAGIC	0x62121174
+
+/* Approximate upper ceiling for memory usage per fs */
+#define SYSFS_MAX_SIZE		(1024 - sizeof(unsigned int))
+
+/* TBD */
+static struct dentry_operations sys_dentry_ops;
+static struct file_operations sys_dirops, sys_fileops;
+static struct inode_operations sys_inodeops;
+static struct super_operations sys_super_ops;
+
+struct sys_buffer
+{
+	unsigned int len;
+	/* One is for the nul terminator */
+	char buffer[1];
+};
+
+struct sys_dirinfo
+{
+	/* When it drops to zero, unlink it */
+	unsigned int usage;
+	/* Full nul-terminated path name */
+	char dirname[0];
+};
+
+struct sys_data *__new_sys(void *arg,
+			   sys_fetchfn_t *fetch,
+			   sys_commitfn_t *commit)
+{
+	struct sys_data *pdata;
+
+	pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
+	if (pdata) {
+		pdata->arg = arg;
+		pdata->fetch = fetch;
+		pdata->commit = commit;
+	}
+	return pdata;
+}
+
+/* Convenience routine to make an inode */
+static struct inode *
+new_sys_inode(struct super_block *sb, int mode,
+	      struct inode_operations *op,
+	      struct file_operations *fop)
+{
+	struct inode *inode = new_inode(sb);
+
+	if (!inode)
+		return NULL;
+
+	inode->i_mode = mode;
+	inode->i_uid = 0;
+	inode->i_gid = 0;
+	inode->i_blksize = PAGE_CACHE_SIZE;
+	inode->i_blocks = 0;
+	inode->i_rdev = NODEV;
+	inode->i_mapping->a_ops = NULL;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	switch (mode & S_IFMT) {
+	case S_IFREG:
+		inode->i_fop = fop;
+		break;
+	case S_IFDIR:
+		inode->i_fop = fop;
+		inode->i_op = op;
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	return inode;
+}
+
+/* Make a new sys entry in this directory. */
+static int make_sys_entry(struct dentry *dir,
+			  const char *fname,
+			  int mode,
+			  void *data,
+			  struct inode_operations *op,
+			  struct file_operations *fop)
+{
+	struct inode *inode;
+	struct dentry *dentry;
+	struct qstr qstr;
+
+	/* Create qstr for this entry */
+	qstr.name = fname;
+	qstr.len = strlen(fname);
+	qstr.hash = full_name_hash(qstr.name, qstr.len);
+
+	down(&sys_semaphore);
+	/* Does it already exist? */
+	dentry = d_lookup(dir, &qstr);
+	if (dentry) {
+		dput(dentry);
+		up(&sys_semaphore);
+		return -EEXIST;
+	}
+
+	/* Doesn't exist: create inode */
+	inode = new_sys_inode(dir->d_sb, mode, op, fop);
+	if (!inode) {
+		up(&sys_semaphore);
+		return -ENOMEM;
+	}
+
+	/* Create dentry */
+	dentry = d_alloc(dir, &qstr);
+	if (!dentry) {
+		iput(inode);
+		up(&sys_semaphore);
+		return -ENOMEM;
+	}
+	dentry->d_op = &sys_dentry_ops;
+	dentry->d_fsdata = data;
+	d_add(dentry, inode);
+
+	/* Pin the dentry here, so it doesn't get pruned */
+	dget(dentry);
+	up(&sys_semaphore);
+	return 0;
+}
+
+/* Create (static) sys directory if neccessary. */
+static struct dentry *get_sys_dir(const char *dirname)
+{
+	struct dentry *dentry;
+	struct qstr qstr;
+	const char *delim;
+	struct sys_dirinfo *dinfo;
+
+	/* FIXME: Definitely need a better way --RR */
+	dentry = dget(sys_mnt->mnt_sb->s_root);
+	delim = dirname;
+
+	for (;;) {
+		struct dentry *newdentry;
+
+		/* Ignore multiple slashes */ 
+		while (*delim == '/') delim++;
+		qstr.name = delim;
+		delim = strchr(qstr.name, '/');
+		if (!delim) delim = qstr.name + strlen(qstr.name);
+		qstr.len = delim-(char *)qstr.name;
+		qstr.hash = full_name_hash(qstr.name, qstr.len);
+
+		if (qstr.len == 0)
+			break;
+
+		/* If entry doesn't exist, create it */
+		newdentry = d_lookup(dentry, &qstr);
+		if (!newdentry) {
+			char fname[qstr.len+1];
+			int ret;
+
+			dinfo = kmalloc(sizeof(*dinfo) + strlen(dirname) + 1,
+					GFP_KERNEL);
+			if (!dinfo) {
+				dput(dentry);
+				return ERR_PTR(-ENOMEM);
+			}
+			strcpy(dinfo->dirname, dirname);
+			dinfo->usage = 0;
+
+			strncpy(fname, qstr.name, qstr.len);
+			fname[qstr.len] = '\0';
+			ret = make_sys_entry(dentry, fname, S_IFDIR|0555,
+					     dinfo, &sys_inodeops,&sys_dirops);
+			if (ret < 0) {
+				dput(dentry);
+				return ERR_PTR(ret);
+			}
+			newdentry = d_lookup(dentry, &qstr);
+			if (!newdentry)
+				BUG();
+		}
+		dput(dentry);
+		dentry = newdentry;
+		dinfo = dentry->d_fsdata;
+		dinfo->usage++;
+	}
+	return dentry;
+}
+
+/* Actually add a static sys file */
+int __sys(const char *dirname,
+	  const char *fname,
+	  int mode,
+	  struct sys_data *pdata)
+{
+	struct dentry *dir;
+	int ret;
+
+	if (!pdata)
+		return -ENOMEM;
+
+	dir = get_sys_dir(dirname);
+	if (IS_ERR(dir)) {
+		kfree(pdata);
+		return PTR_ERR(dir);
+	}
+
+	ret = make_sys_entry(dir, fname, mode, pdata,
+			     &sys_inodeops, &sys_fileops);
+	dput(dir);
+	if (ret != 0)
+		kfree(pdata);
+	return ret;
+}
+
+/* See if /sys entry exists (entries registered in directory). */
+static struct dentry *sys_lookup(struct inode *dir, struct dentry *dentry)
+{
+	/* Since we place new static entries in the dcache, if we get
+	   here, we know the entry does not exist.  Create a negative
+	   dentry, and return NULL */
+	d_add(dentry, NULL);
+	return NULL;
+}
+
+/* On open, we grab contents if we're readable... */
+static int sys_file_snapshot(struct inode *inode, struct file *filp)
+{
+	struct sys_buffer *buf;
+	struct sys_data *pdata;
+	struct sys_dirinfo *dirdata;
+	int used;
+
+	buf = kmalloc(sizeof(*buf) + SYSFS_MAX_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	buf->len = 0;
+	filp->private_data = buf;
+
+	if (!(filp->f_mode & FMODE_READ))
+		return 0;
+
+	/* Grab the snapshot */
+	pdata = filp->f_dentry->d_fsdata;
+	dirdata = filp->f_dentry->d_parent->d_fsdata;
+
+	used = pdata->fetch(dirdata->dirname,
+			    filp->f_dentry->d_name.name,
+			    buf->buffer,
+			    SYSFS_MAX_SIZE,
+			    pdata->arg);
+	if (used < 0) {
+		kfree(buf);
+		return used;
+	}
+	if (used > SYSFS_MAX_SIZE)
+		BUG();
+
+	/* Nul terminate */
+	buf->len = used;
+	return 0;
+}
+
+/* On close, we commit contents if we've been written to... */
+static int sys_file_commit(struct inode *inode, struct file *filp)
+{
+	int ret = 0;
+	struct sys_data *pdata;
+	struct sys_dirinfo *dinfo;
+	struct sys_buffer *buf;
+
+	if (!(filp->f_mode & FMODE_WRITE))
+		goto out;
+
+	pdata = filp->f_dentry->d_fsdata;
+	dinfo = filp->f_dentry->d_parent->d_fsdata;
+	buf = filp->private_data;
+	/* nul-terminate buffer for commit's convenience */
+	buf->buffer[buf->len] = '\0';
+	ret = pdata->commit(dinfo->dirname, filp->f_dentry->d_name.name,
+			    buf->buffer, buf->len, pdata->arg);
+
+ out:
+	kfree(filp->private_data);
+	return ret;
+}
+
+/* Copy from buffer */
+static ssize_t sys_file_read(struct file *filp,
+			     char *ubuf,
+			     size_t size,
+			     loff_t *off)
+{
+	struct sys_buffer *buf;
+
+	if (down_interruptible(&sys_semaphore) != 0)
+		return -EINTR;
+
+	buf = filp->private_data;
+	if (size + *off > buf->len)
+		size = buf->len - *off;
+
+	/* Copy from static buffer */
+	if (copy_to_user(ubuf, buf->buffer, size) != 0) {
+		up(&sys_semaphore);
+		return -EFAULT;
+	}
+	up(&sys_semaphore);
+
+	*off += size;
+	return (ssize_t)size;
+}
+
+/* Copy to buffer */
+static ssize_t sys_file_write(struct file *filp,
+			      const char *ubuf,
+			      size_t size,
+			      loff_t *off)
+{
+	struct sys_buffer *buf;
+	struct sys_data *pdata;
+
+	if (down_interruptible(&sys_semaphore) != 0)
+		return -EINTR;
+
+	pdata = filp->f_dentry->d_fsdata;
+
+	buf = filp->private_data;
+	if (*off + size > SYSFS_MAX_SIZE) {
+		up(&sys_semaphore);
+		return -ENOSPC;
+	}
+
+	/* Do actual copy */
+	if (copy_from_user(buf->buffer + *off, ubuf, size) != 0) {
+		up(&sys_semaphore);
+		return -EFAULT;
+	}
+	up(&sys_semaphore);
+	buf->len += size;
+	*off += size;
+
+	return size;
+}
+
+static int sys_nofetch(const char *dirname, const char *fname,
+		       char *outbuf, unsigned int len, void *arg)
+{
+	return -ENOENT;
+}
+
+static int sys_nocommit(const char *dirname, const char *fname,
+			const char *inbuf, unsigned int len, void *arg)
+{
+	return -ENOENT;
+}
+
+/* Release a sys entry */
+void unsys(const char *dir, const char *fname)
+{
+	struct dentry *dentry, *parent;
+	const char *delim;
+	struct qstr qstr;
+	struct sys_data *pdata;
+
+	down(&sys_semaphore);
+
+	/* FIXME: There's a better way, right? --RR */
+	dentry = dget(sys_mnt->mnt_sb->s_root);
+	delim = dir;
+	for (;;) {
+		/* Ignore multiple slashes */ 
+		while (*delim == '/') delim++;
+		qstr.name = delim;
+		delim = strchr(qstr.name, '/');
+		if (!delim) delim = qstr.name + strlen(qstr.name);
+		qstr.len = delim-(char *)qstr.name;
+		qstr.hash = full_name_hash(qstr.name, qstr.len);
+
+		if (qstr.len == 0)
+			break;
+
+		dentry = d_lookup(dentry, &qstr);
+		if (!dentry)
+			BUG();
+		dput(dentry->d_parent);
+	}
+
+	qstr.name = fname;
+	qstr.len = strlen(fname);
+	qstr.hash = full_name_hash(qstr.name, qstr.len);
+	dentry = d_lookup(dentry, &qstr);
+	if (!dentry)
+		BUG();
+	dput(dentry->d_parent);
+
+	/* We have the dentry: change the private area so it doesn't
+           enter the caller any more. */
+	pdata = dentry->d_fsdata;
+	pdata->commit = sys_nocommit;
+	pdata->fetch = sys_nofetch;
+
+	/* Save parent */
+	parent = dentry->d_parent;
+
+	/* First unpin, then delete */
+	dput(dentry);
+	d_delete(dentry);
+
+	/* Now clean up parents. */
+	for (dentry = parent; parent != sys_mnt->mnt_root; dentry = parent) {
+		struct sys_dirinfo *dinfo = dentry->d_fsdata;
+
+		/* Grab parent first... */
+		parent = dentry->d_parent;
+		if (--dinfo->usage == 0) {
+			dput(dentry);
+			d_delete(dentry);
+		}
+	}
+
+	up(&sys_semaphore);
+}
+
+/* FIXME: I have no idea what all this does: stolen from old /proc --RR */
+static int sys_statfs(struct super_block *sb, struct statfs *buf)
+{
+	buf->f_type = SIMPLE_SYSFS_MAGIC;
+	buf->f_bsize = PAGE_SIZE/sizeof(long);
+	buf->f_bfree = 0;
+	buf->f_bavail = 0;
+	buf->f_ffree = 0;
+	buf->f_namelen = NAME_MAX;
+	return 0;
+}
+
+static struct super_block *sys_read_super(struct super_block *s,
+					  void *data, 
+					  int silent)
+{
+	struct inode * root_inode;
+
+	s->s_blocksize = 1024;
+	s->s_blocksize_bits = 10;
+	s->s_magic = SIMPLE_SYSFS_MAGIC;
+	s->s_op = &sys_super_ops;
+
+	root_inode = new_sys_inode(s, S_IFDIR|0555, &sys_inodeops,&sys_dirops);
+	if (!root_inode) return NULL;
+
+	/* Block concurrent mounts */
+	down(&sys_semaphore);
+
+	s->s_root = d_alloc_root(root_inode);
+	if (!s->s_root) {
+		iput(root_inode);
+		up(&sys_semaphore);
+		return NULL;
+	}
+	up(&sys_semaphore);
+	return s;
+}
+
+/* Free the private area when dentry is freed. */
+static void sys_release(struct dentry *dentry)
+{
+	kfree(dentry->d_fsdata);
+}
+
+static struct inode_operations sys_inodeops = {
+	lookup:		sys_lookup,
+};
+
+static struct file_operations sys_dirops = {
+	read:		generic_read_dir,
+	readdir:	dcache_readdir,
+};
+
+static struct dentry_operations sys_dentry_ops = {
+	d_release:	sys_release,
+};
+
+static struct super_operations sys_super_ops = {
+	statfs:		sys_statfs,
+	put_inode:	force_delete,
+};
+
+static struct file_operations sys_fileops = {
+	open:		sys_file_snapshot,
+	release:	sys_file_commit,
+	read:		sys_file_read,
+	write:		sys_file_write,
+};
+
+static DECLARE_FSTYPE(sys_fs_type, "sys", sys_read_super, FS_SINGLE);
+
+static struct {
+	struct sys_dirinfo info;
+	char name[2];
+} root_fsdata = { { 1 }, "/" };
+
+static int __init init_sys_fs(void)
+{
+	register_filesystem(&sys_fs_type);
+	sys_mnt = kern_mount(&sys_fs_type);
+	sys_mnt->mnt_root->d_fsdata = &root_fsdata;
+	return 0;
+}
+
+static void __exit exit_sys_fs(void)
+{
+	unregister_filesystem(&sys_fs_type);
+}
+
+module_init(init_sys_fs);
+module_exit(exit_sys_fs);
+
+EXPORT_SYMBOL(__sys);
+EXPORT_SYMBOL(__new_sys);
+EXPORT_SYMBOL(unsys);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.16-uml/include/linux/sysctl.h working-2.4.16-uml-proc/include/linux/sysctl.h
--- linux-2.4.16-uml/include/linux/sysctl.h	Thu Dec 13 17:01:04 2001
+++ working-2.4.16-uml-proc/include/linux/sysctl.h	Thu Dec 20 13:54:36 2001
@@ -1,3 +1,4 @@
+/* Obsolete: use sys_fs.h -- Rusty Russell. */
 /*
  * sysctl.h: General linux system control interface
  *
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.16-uml/include/linux/typecheck.h working-2.4.16-uml-proc/include/linux/typecheck.h
--- linux-2.4.16-uml/include/linux/typecheck.h	Thu Jan  1 10:00:00 1970
+++ working-2.4.16-uml-proc/include/linux/typecheck.h	Thu Dec 20 12:31:41 2001
@@ -0,0 +1,29 @@
+#ifndef _LINUX_TYPECHECK_H
+#define _LINUX_TYPECHECK_H
+/* Simple macros to do compile-time type checking.  IIRC, Jakub
+   Jelinek came up with this idea for the 2.4 module init code. */
+/* (C) 2001 Rusty Russell */
+
+#define __CHECK_byte(name, p) /* Yeah, whatever */
+#define __CHECK_short(name, p) \
+	extern inline short *__CHECK_##name(void) { return(p); }
+#define __CHECK_ushort(name, p) \
+	extern inline unsigned short *__CHECK_##name(void) { return(p); }
+#define __CHECK_int(name, p) \
+	extern inline int *__CHECK_##name(void) { return(p); }
+#define __CHECK_uint(name, p) \
+	extern inline unsigned int *__CHECK_##name(void) { return(p); }
+#define __CHECK_long(name, p) \
+	extern inline long *__CHECK_##name(void) { return(p); }
+#define __CHECK_ulong(name, p) \
+	extern inline unsigned long *__CHECK_##name(void) { return(p); }
+#define __CHECK_charp(name, p) \
+	extern inline char **__CHECK_##name(void) { return(p); }
+#define __CHECK_bool(name, p) \
+	extern inline int *__CHECK_##name(void) { return(p); }
+#define __CHECK_invbool(name, p) \
+	extern inline int *__CHECK_##name(void) { return(p); }
+#define __CHECK_string(name, p) \
+	extern inline char *__CHECK_##name(void) { return(p); }
+
+#endif /* _LINUX_TYPECHECK_H */
