Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278660AbRKAKdg>; Thu, 1 Nov 2001 05:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278662AbRKAKdY>; Thu, 1 Nov 2001 05:33:24 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:22286 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S278660AbRKAKdA>; Thu, 1 Nov 2001 05:33:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Thu, 01 Nov 2001 21:32:35 +1100
Message-Id: <E15zF9H-0000NL-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry: been wanting to use that phrase here for the longest time]

	This proof-of-concept implementation is pretty poor but the
principle (and interface) is simple:

	int my_foo;

	static int __init initfn(void)
	{
		return proc("net", "foo", my_foo, int, 0644);
	}

	static void __exit exitfn(void)
	{
		unproc("net", "foo");
	}

No kernel-formatted tables: use a directory.  (eg. kernel symbols
become a directory of symbol names, each containing the symbol value).

For cases when you don't want to take the overhead of creating a new
proc entry (eg. tcp socket creation), you can create directories on
demand when a user reads them using:

	proc_dir("net", "subdir", dirfunc, NULL);
	unproc_dir("net", "subdir");

Note that with kbuild 2.5, you can do something like:

	proc(KBUILD_OBJECT, "foo", my_foo, int, 0644);

And with my previous parameter patch:
	PARAM(foo, int, 0444);

declares a boot time parameter "KBUILD_OBJECT.foo=", or a module
parameter "foo=", and places it as readable in
/proc/KBUILD_OBJECT/foo.

I believe that rewriting /proc (and /proc/sys should simply die) is a
better solution than extending the interface, or avoiding it
altogether by using a new filesystem.

Of course, I don't care if it's *NOT* under /proc...
Rusty.
--
Premature optmztion is rt of all evl. --DK

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.13-uml/include/linux/simpleproc.h working-2.4.13-uml-proc/include/linux/simpleproc.h
--- linux-2.4.13-uml/include/linux/simpleproc.h	Thu Jan  1 10:00:00 1970
+++ working-2.4.13-uml-proc/include/linux/simpleproc.h	Thu Nov  1 20:17:42 2001
@@ -0,0 +1,206 @@
+/* Dynamic proc filesystem that doesn't suck.  (C) 2001 Rusty Russell. */
+#ifndef _LINUX_SIMPLE_PROC_H
+#define _LINUX_SIMPLE_PROC_H
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/stat.h>
+
+/* Commit the contents of this (NUL-terminated) buffer if possible.
+   -errno indicates error. */
+typedef int (proc_commitfn_t)(const char *dirname,
+			      const char *filename,
+			      const char *buffer,
+			      unsigned int size,
+			      void *arg);
+/* Fetch the contents into buffer: return size used (or needed), or
+   -errno. */
+typedef int (proc_fetchfn_t)(const char *dirname,
+			     const char *filename,
+			     char *buffer,
+			     unsigned int size,
+			     void *arg);
+
+/* If we're a dynamic directory, this routine gets dir contents:
+   returns size used (or needed), or -errno. */
+struct proc_dircontents;
+typedef int (proc_dirfn_t)(const char *dirname,
+			   const char *filename,
+			   struct proc_dircontents *buffer,
+			   unsigned int maxlen,
+			   void *arg);
+
+/* Register a proc entry of the given type. */
+#define proc(dir, fname, var, type, perms)				 \
+	__proc(dir, fname, S_IFREG|(perms),				 \
+	       __new_proc(&var,						 \
+			  ((perms)&S_IRUGO) ? proc_fetch_##type : NULL,	 \
+			  ((perms)&S_IWUGO) ? proc_commit_##type : NULL, \
+			  NULL))
+
+/* Register a proc entry protected by a spinlock. */
+#define proc_spinlock(dir, fname, var, type, lock, p)			   \
+	__proc(dir, fname, S_IFREG|(p),					   \
+	       __new_proc_lock(&var, lock,				   \
+			       ((p)&S_IRUGO) ? proc_fetch_##type : NULL,   \
+			       ((p)&S_IWUGO) ? proc_commit_##type : NULL))
+
+/* Register a proc entry protected by a semaphore. */
+#define proc_sem(dir, fname, var, type, sem, p)				  \
+	__proc(dir, fname, S_IFREG|(p),					  \
+	       __new_proc_sem(&var, sem,				  \
+			      ((p)&S_IRUGO) ? proc_fetch_##type : NULL,	  \
+			      ((p)&S_IWUGO) ? proc_commit_##type : NULL))
+
+/* These exist, believe me */
+struct semaphore;
+struct proc_data;
+
+#ifdef CONFIG_SIMPLE_PROC_FS
+/* Low level functions */
+int __proc(const char *dirname, const char *fname, int mode,
+	   struct proc_data *pdata);
+struct proc_data *__new_proc(void *arg, proc_fetchfn_t *, proc_commitfn_t *,
+			     proc_dirfn_t *);
+struct proc_data *__new_proc_lock(void *arg, spinlock_t *lock,
+				  proc_fetchfn_t *, proc_commitfn_t *);
+struct proc_data *__new_proc_sem(void *arg, struct semaphore *sem,
+				 proc_fetchfn_t *, proc_commitfn_t *);
+
+/* Register a whole dynamic directory */
+static inline int proc_dir(const char *dir, const char *dirname,
+			   proc_dirfn_t *dirfunc, void *arg)
+{
+	return __proc(dir, dirname, S_IFDIR|0555, 
+		      __new_proc(arg, NULL, NULL, dirfunc));
+}
+
+/* Release a dynamic proc directory */
+void unproc_dir(const char *dir, const char *fname);
+
+/* Release a proc entry */
+void unproc(const char *dir, const char *fname);
+
+#else
+static inline int proc_dir(const char *dir, const char *dirname,
+			   proc_dirfn_t *dirfunc, void *arg)
+{
+	return 0;
+}
+
+static inline void unproc(const char *dir, const char *fname)
+{
+}
+
+static inline void unproc_dir(const char *dir, const char *fname)
+{
+}
+
+static inline int __proc(const char *dirname, const char *fname, int mode,
+			 struct proc_data *pdata)
+{
+	return 0;
+}
+
+struct proc_data *__new_proc(void *arg,
+			     proc_fetchfn_t *fetch,
+			     proc_commitfn_t *commit,
+			     proc_dirfn_t *dir)
+{
+	return (struct proc_data *)-1;
+}
+struct proc_data *__new_proc_lock(void *arg, spinlock_t *lock,
+				  proc_fetchfn_t *fetch,
+				  proc_commitfn_t *commit)
+{
+	return (struct proc_data *)-1;
+}
+struct proc_data *__new_proc_sem(void *arg, struct semaphore *sem,
+				 proc_fetchfn_t *fetch,
+				 proc_commitfn_t *commit)
+{
+	return (struct proc_data *)-1;
+}
+#endif /*CONFIG_PROC_FS*/
+
+/* Helper parsing routines.  You can write your own, too. */
+proc_fetchfn_t proc_fetch_short;
+proc_fetchfn_t proc_fetch_ushort;
+proc_fetchfn_t proc_fetch_int;
+proc_fetchfn_t proc_fetch_uint;
+proc_fetchfn_t proc_fetch_long;
+proc_fetchfn_t proc_fetch_ulong;
+proc_fetchfn_t proc_fetch_bool;
+
+proc_commitfn_t proc_commit_short;
+proc_commitfn_t proc_commit_ushort;
+proc_commitfn_t proc_commit_int;
+proc_commitfn_t proc_commit_uint;
+proc_commitfn_t proc_commit_long;
+proc_commitfn_t proc_commit_ulong;
+proc_commitfn_t proc_commit_bool;
+
+/* Filled in by dir functions */
+struct proc_dircontents
+{
+	/* Mode of file.  0 terminates list. */
+	int mode;
+
+	/* Fetch, commit and dir functions for entry. */
+	proc_fetchfn_t *fetch;
+	proc_commitfn_t *commit;
+	proc_dirfn_t *dir;
+
+	/* Arg */
+	void *arg;
+
+	/* Name is nul-terminated, and padded to alignof this struct */
+	char name[0];
+};
+
+/* Helper to add another dircontents to the list, return updated "used" */
+static inline unsigned int proc_add_dircontents(struct proc_dircontents *pd,
+						unsigned int used,
+						unsigned int maxlen,
+						int mode,
+						proc_fetchfn_t *fetch,
+						proc_commitfn_t *commit,
+						proc_dirfn_t *dir,
+						void *arg,
+						const char *name)
+{
+	unsigned int thislen;
+
+	thislen = sizeof(*pd) + strlen(name) + 1;
+	thislen = (thislen + __alignof__(*pd) - 1) & ~(__alignof__(*pd) - 1);
+	if (used + thislen <= maxlen) {
+		pd = (void *)pd + used;
+		pd->mode = mode;
+		pd->fetch = fetch;
+		pd->commit = commit;
+		pd->dir = dir;
+		pd->arg = arg;
+		strcpy(pd->name, name);
+	}
+	return used + thislen;
+}
+
+static inline unsigned int proc_end_dircontents(struct proc_dircontents *pd,
+						unsigned int used,
+						unsigned int maxlen)
+{
+	return proc_add_dircontents(pd, used, maxlen, 0,
+				    NULL, NULL, NULL, NULL, "");
+}
+
+/* Internal use */
+struct proc_data
+{
+	/* User-defined argument for routines */
+	void *arg;
+
+	proc_dirfn_t *dir;
+	proc_commitfn_t *commit;
+	proc_fetchfn_t *fetch;
+};
+#endif /* _LINUX_SIMPLE_PROC_H */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.13-uml/fs/Config.in working-2.4.13-uml-proc/fs/Config.in
--- linux-2.4.13-uml/fs/Config.in	Thu Oct 25 11:29:49 2001
+++ working-2.4.13-uml-proc/fs/Config.in	Tue Oct 30 12:47:11 2001
@@ -50,7 +50,10 @@
 
 tristate 'OS/2 HPFS file system support' CONFIG_HPFS_FS
 
-bool '/proc file system support' CONFIG_PROC_FS
+bool 'Simple /proc file system support (EXPERIMENTAL)' CONFIG_SIMPLE_PROC_FS
+if [ "$CONFIG_SIMPLE_PROC_FS" != y ]; then
+   bool '/proc file system support' CONFIG_PROC_FS
+fi
 
 dep_bool '/dev file system support (EXPERIMENTAL)' CONFIG_DEVFS_FS $CONFIG_EXPERIMENTAL
 dep_bool '  Automatically mount at boot' CONFIG_DEVFS_MOUNT $CONFIG_DEVFS_FS
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.13-uml/fs/Makefile working-2.4.13-uml-proc/fs/Makefile
--- linux-2.4.13-uml/fs/Makefile	Thu Oct 25 11:29:49 2001
+++ working-2.4.13-uml-proc/fs/Makefile	Tue Oct 30 12:47:11 2001
@@ -23,6 +23,7 @@
 endif
 
 subdir-$(CONFIG_PROC_FS)	+= proc
+subdir-$(CONFIG_SIMPLE_PROC_FS)	+= simpleproc
 subdir-y			+= partitions
 
 # Do not add any filesystems before this line
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.13-uml/fs/proc/simple_proc.c working-2.4.13-uml-proc/fs/proc/simple_proc.c
--- linux-2.4.13-uml/fs/proc/simple_proc.c	Thu Jan  1 10:00:00 1970
+++ working-2.4.13-uml-proc/fs/proc/simple_proc.c	Tue Oct 30 12:47:11 2001
@@ -0,0 +1,517 @@
+/* Those of you who read this, give quiet thanks that you did not
+   suffer the endless frustration of dealing with the old /proc
+   interface.
+
+   Copyright (C) 2001 Rusty Russell.
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
+#include <linux/proc.h>
+#include <linux/proc_fs.h>
+#include <asm/uaccess.h>
+
+/* Simplistic approach: semaphore protects all proc accesses. */
+static DECLARE_MUTEX(simple_proc_sem);
+
+/* FIXME: Use reference counts and "dead" marker to return -ENOENT if
+   unregistered while open -RR */
+struct proc_data
+{
+	void *arg;
+	int (*get)(void *, char *, int);
+	int (*set)(void *, const char *);
+
+	/* FIXME: Belongs in struct file --RR */
+	int readlen, maxreadlen, writelen, maxwritelen;
+	char *readdata, *writedata;
+};
+
+static int fill_buffer(char **buffer,
+			int *maxlen,
+			struct proc_data *pdata)
+{
+	int len;
+
+	for (;;) {
+		len = pdata->get(pdata->arg, *buffer, *maxlen);
+		/* Need more room? */
+		if (len > *maxlen) {
+			/* We need some restriction here, to avoid
+			   DoS.  fs/proc/generic.c wants this, but we
+			   should make one or two pages eventually. */
+			if (len > PAGE_SIZE - 1024)
+				BUG();
+			kfree(*buffer);
+			*buffer = kmalloc(len, GFP_KERNEL);
+			if (!*buffer) return -ENOMEM;
+			*maxlen = len;
+		} else
+			return len;
+	}
+}
+
+/* FIXME: Get the struct file, and we can use ->private_data to store
+   this per file descriptor, rather than per file --RR */
+static int simple_read(char *page, char **start, off_t off, int count, 
+		       int *eof, void *data)
+{
+	struct proc_data *pdata = data;
+	int ret;
+
+	/* Start of read?  Get fresh buffer */
+	if (off == 0) {
+		int readlen, maxreadlen;
+		char *buffer;
+
+		maxreadlen = pdata->maxreadlen;
+		buffer = kmalloc(maxreadlen, GFP_KERNEL);
+		if (!buffer) {
+			*eof = 1;
+			return -ENOMEM;
+		}
+		readlen = fill_buffer(&buffer, &maxreadlen, pdata);
+		if (readlen < 0) {
+			*eof = 1;
+			kfree(buffer);
+			return readlen;
+		}
+
+		/* Substitute buffer */
+		if (down_interruptible(&simple_proc_sem) != 0) {
+			*eof = 1;
+			kfree(buffer);
+			return -EINTR;
+		}
+		kfree(pdata->readdata);
+		pdata->maxreadlen = maxreadlen;
+		pdata->readlen = readlen;
+		pdata->readdata = buffer;
+		up(&simple_proc_sem);
+	}
+
+	/* Serve from buffer */
+	if (down_interruptible(&simple_proc_sem) != 0) {
+		*eof = 1;
+		return -EINTR;
+	}
+
+	if (off <= pdata->readlen) {
+		ret = pdata->readlen - off;
+		memcpy(page + off, pdata->readdata + off, ret);
+	} else {
+		*eof = 1;
+		ret = 0;
+	}
+	up(&simple_proc_sem);
+
+	return ret;
+}
+
+/* FIXME: Don't share the write buffer: use file->private_data */
+static int simple_write(struct file *file,
+			const char *userbuffer,
+			unsigned long count, 
+			void *data)
+{
+	struct proc_data *pdata = data;
+
+	/* FIXME: commit the write(s) on close or seek.  We don't have
+	   that control under the current proc system, so simply
+	   terminate on \n. --RR */
+	if (file->f_pos + count > pdata->maxwritelen) {
+		char *newbuffer;
+		int newmax = file->f_pos + count;
+
+		/* As in read, we need some limit, and this is from
+                   fs/proc/generic.c */
+		if (newmax > PAGE_SIZE - 1024)
+			return -ENOSPC;
+
+		newbuffer = kmalloc(newmax, GFP_KERNEL);
+		if (!newbuffer)
+			return -ENOMEM;
+
+		/* Substitute buffer */
+		if (down_interruptible(&simple_proc_sem) != 0) {
+			kfree(newbuffer);
+			return -EINTR;
+		}
+		memcpy(newbuffer, pdata->writedata, pdata->writelen);
+		kfree(pdata->writedata);
+		pdata->maxwritelen = newmax;
+		pdata->writedata = newbuffer;
+		up(&simple_proc_sem);
+	}
+
+	/* Copy into buffer */
+	if (down_interruptible(&simple_proc_sem) != 0)
+		return -EINTR;
+
+	if (copy_from_user(pdata->writedata+file->f_pos, userbuffer, count)
+	    != 0) {
+		up(&simple_proc_sem);
+		return -EFAULT;
+	}
+
+	file->f_pos += count;
+
+	/* If there is now a '\n' at the end of the buffer, commit */
+	if (file->f_pos > 0 && pdata->writedata[file->f_pos-1] == '\n') {
+		int set;
+		pdata->writedata[file->f_pos-1] = '\0';
+		set = pdata->set(pdata->arg, pdata->writedata);
+
+		if (set < 0) {
+			up(&simple_proc_sem);
+			return set;
+		}
+	}
+	up(&simple_proc_sem);
+	return count;
+}
+
+/* This implementation serves only as a demonstration. --RR */
+static int do_register(const char *dir,
+		       const char *fname,
+		       int perms,
+		       struct proc_data *pdata)
+{
+	struct proc_dir_entry *entry;
+	char fullpath[strlen(dir) + 1 + strlen(fname) + 1];
+
+	sprintf(fullpath, "%s/%s", dir, fname);
+	entry = create_proc_entry(fullpath, perms, NULL);
+	if (!entry) return -EINVAL; /* -ERANDOM */
+
+	/* Populate data */
+	entry->data = pdata;
+
+	/* Set up read and write callbacks */
+	if (pdata->set) entry->read_proc = &simple_read;
+	if (pdata->get) entry->write_proc = &simple_write;
+	return 0;
+}
+
+int __register_proc(const char *dir,
+		    const char *fname,
+		    void *arg,
+		    unsigned int perms,
+		    int (*get)(void *arg, char *, int),
+		    int (*set)(void *arg, const char *))
+{
+	struct proc_data *pdata;
+	int ret;
+
+	pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+	
+	pdata->arg = arg;
+	pdata->get = get;
+	pdata->set = set;
+	pdata->writelen = pdata->readlen = 0;
+	pdata->readdata = pdata->writedata = NULL;
+
+	ret = do_register(dir, fname, perms, pdata);
+	if (ret < 0)
+		kfree(pdata);
+	return ret;
+}
+
+/* Wrapper for user's real proc functions */
+struct pdata_wrapper
+{
+	struct proc_data pdata;
+	int (*get)(void *, char *, int);
+	int (*set)(void *, const char *);
+	void *lock;
+	void *userarg;
+};
+
+static struct pdata_wrapper *
+new_pdata_wrapper(void *arg,
+		  int (*userget)(void *, char *, int),
+		  int (*userset)(void *, const char *),
+		  int (*wrapperget)(void *, char *, int),
+		  int (*wrapperset)(void *, const char *),
+		  void *lock)
+{
+	struct pdata_wrapper *pwrap;
+
+	pwrap = kmalloc(sizeof(*pwrap), GFP_KERNEL);
+	if (pwrap) {
+		pwrap->pdata.arg = pwrap;
+		pwrap->pdata.writelen = pwrap->pdata.readlen = 0;
+		pwrap->pdata.readdata = pwrap->pdata.writedata = NULL;
+		pwrap->pdata.get = wrapperget;
+		pwrap->pdata.set = wrapperset;
+		pwrap->lock = lock;
+		pwrap->userarg = arg;
+		pwrap->get = userget;
+		pwrap->set = userset;
+	}
+	return pwrap;
+}
+
+static int do_register_wrap(const char *dir,
+			    const char *fname,
+			    int perms,
+			    void *arg,
+			    int (*userget)(void *, char *, int),
+			    int (*userset)(void *, const char *),
+			    int (*wrapperget)(void *, char *, int),
+			    int (*wrapperset)(void *, const char *),
+			    void *lock)
+{
+	struct pdata_wrapper *pwrap;
+	int ret;
+
+	pwrap = new_pdata_wrapper(arg, userget, userset, wrapperget,
+				  wrapperset, lock);
+	if (!pwrap)
+		return -ENOMEM;
+	ret = do_register(dir, fname, perms, &pwrap->pdata);
+	if (ret < 0)
+		kfree(pwrap);
+	return ret;
+}
+
+static int spinlock_get(void *arg, char *buffer, int size)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	spin_lock_irq(pwrap->lock);
+	ret = pwrap->get(pwrap->userarg, buffer, size);
+	spin_unlock_irq(pwrap->lock);
+
+	return ret;
+}
+
+static int spinlock_set(void *arg, const char *buffer)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	spin_lock_irq(pwrap->lock);
+	ret = pwrap->set(pwrap->userarg, buffer);
+	spin_unlock_irq(pwrap->lock);
+
+	return ret;
+}
+
+int __register_proc_spinlock(const char *dir,
+			     const char *fname,
+			     void *arg,
+			     unsigned int perms,
+			     spinlock_t *lock,
+			     int (*get)(void *arg, char *, int),
+			     int (*set)(void *arg, const char *))
+{
+	return do_register_wrap(dir, fname, perms, arg, get, set,
+				spinlock_get, spinlock_set, lock);
+}
+
+static int rwlock_get(void *arg, char *buffer, int size)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	read_lock_irq(pwrap->lock);
+	ret = pwrap->get(pwrap->userarg, buffer, size);
+	read_unlock_irq(pwrap->lock);
+
+	return ret;
+}
+
+static int rwlock_set(void *arg, const char *buffer)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	write_lock_irq(pwrap->lock);
+	ret = pwrap->set(pwrap->userarg, buffer);
+	write_unlock_irq(pwrap->lock);
+
+	return ret;
+}
+
+int __register_proc_rwlock(const char *dir,
+			   const char *fname,
+			   void *arg,
+			   unsigned int perms,
+			   rwlock_t *lock,
+			   int (*get)(void *arg, char *, int),
+			   int (*set)(void *arg, const char *))
+{
+	return do_register_wrap(dir, fname, perms, arg, get, set,
+				rwlock_get, rwlock_set, lock);
+}
+
+static int semaphore_get(void *arg, char *buffer, int size)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	if (down_interruptible(pwrap->lock) != 0)
+		return -EINTR;
+	ret = pwrap->get(pwrap->userarg, buffer, size);
+	up(pwrap->lock);
+
+	return ret;
+}
+
+static int semaphore_set(void *arg, const char *buffer)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	if (down_interruptible(pwrap->lock) != 0)
+		return -EINTR;
+	ret = pwrap->set(pwrap->userarg, buffer);
+	up(pwrap->lock);
+
+	return ret;
+}
+
+int __register_proc_semaphore(const char *dir,
+			      const char *fname,
+			      void *arg,
+			      unsigned int perms,
+			      struct semaphore *lock,
+			      int (*get)(void *arg, char *, int),
+			      int (*set)(void *arg, const char *))
+{
+	return do_register_wrap(dir, fname, perms, arg, get, set,
+				semaphore_get, semaphore_set, lock);
+}
+	
+static int rwsemaphore_get(void *arg, char *buffer, int size)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	down_read(pwrap->lock);
+	ret = pwrap->get(pwrap->userarg, buffer, size);
+	up_read(pwrap->lock);
+
+	return ret;
+}
+
+static int rwsemaphore_set(void *arg, const char *buffer)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	down_write(pwrap->lock);
+	ret = pwrap->set(pwrap->userarg, buffer);
+	up_write(pwrap->lock);
+
+	return ret;
+}
+
+int __register_proc_rwsemaphore(const char *dir,
+				const char *fname,
+				void *arg,
+				unsigned int perms,
+				struct rw_semaphore *lock,
+				int (*get)(void *arg, char *, int),
+				int (*set)(void *arg, const char *))
+{
+	return do_register_wrap(dir, fname, perms, arg, get, set,
+				rwsemaphore_get, rwsemaphore_set, lock);
+}
+
+int __proc_read_short(void *shortp, char *outbuf, int len)
+{
+	return snprintf(outbuf, len, "%hi", *(short *)shortp);
+}
+
+int __proc_write_short(void *shortp, const char *inbuf)
+{
+	if (sscanf(inbuf, "%hi", (short *)shortp) != 1) return -EINVAL;
+	return 0;
+}
+
+int __proc_read_ushort(void *ushortp, char *outbuf, int len)
+{
+	return snprintf(outbuf, len, "%hu", *(unsigned short *)ushortp);
+}
+
+int __proc_write_ushort(void *ushortp, const char *inbuf)
+{
+	if (sscanf(inbuf, "%hu", (unsigned short *)ushortp) != 1)
+		return -EINVAL;
+	return 0;
+}
+
+int __proc_read_int(void *intp, char *outbuf, int len)
+{
+	return snprintf(outbuf, len, "%i", *(int *)intp);
+}
+
+int __proc_write_int(void *intp, const char *inbuf)
+{
+	if (sscanf(inbuf, "%i", (int *)intp) != 1) return -EINVAL;
+	return 0;
+}
+
+int __proc_read_uint(void *uintp, char *outbuf, int len)
+{
+	return snprintf(outbuf, len, "%u", *(unsigned int *)uintp);
+}
+
+int __proc_write_uint(void *uintp, const char *inbuf)
+{
+	if (sscanf(inbuf, "%u", (unsigned int *)uintp) != 1) return -EINVAL;
+	return 0;
+}
+
+int __proc_read_long(void *longp, char *outbuf, int len)
+{
+	return snprintf(outbuf, len, "%li", *(long *)longp);
+}
+
+int __proc_write_long(void *longp, const char *inbuf)
+{
+	if (sscanf(inbuf, "%li", (long *)longp) != 1) return -EINVAL;
+	return 0;
+}
+
+int __proc_read_ulong(void *ulongp, char *outbuf, int len)
+{
+	return snprintf(outbuf, len, "%lu", *(long *)ulongp);
+}
+
+int __proc_write_ulong(void *ulongp, const char *inbuf)
+{
+	if (sscanf(inbuf, "%lu", (unsigned long *)ulongp) != 1) return -EINVAL;
+	return 0;
+}
+
+int __proc_read_bool(void *boolp, char *outbuf, int len)
+{
+	if (*(int *)boolp) return snprintf(outbuf, len, "y");
+	else return snprintf(outbuf, len, "n");
+}
+
+int __proc_write_bool(void *boolp, const char *inbuf)
+{
+	if (inbuf[0] == 'y' || inbuf[0] == 'Y')
+		*(int *)boolp = 1;
+	else if (inbuf[0] == 'n' || inbuf[0] == 'N')
+		*(int *)boolp = 0;
+	else return __proc_write_int(boolp, inbuf);
+	return 0;
+}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.13-uml/fs/simpleproc/Makefile working-2.4.13-uml-proc/fs/simpleproc/Makefile
--- linux-2.4.13-uml/fs/simpleproc/Makefile	Thu Jan  1 10:00:00 1970
+++ working-2.4.13-uml-proc/fs/simpleproc/Makefile	Tue Oct 30 12:47:11 2001
@@ -0,0 +1,14 @@
+#
+# Makefile for the Linux proc filesystem routines.
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (not a .c file).
+#
+# Note 2! The CFLAGS definitions are now in the main makefile.
+
+O_TARGET := simpleproc.o
+
+obj-y    := inode.o helper.o
+
+include $(TOPDIR)/Rules.make
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.13-uml/fs/simpleproc/helper.c working-2.4.13-uml-proc/fs/simpleproc/helper.c
--- linux-2.4.13-uml/fs/simpleproc/helper.c	Thu Jan  1 10:00:00 1970
+++ working-2.4.13-uml-proc/fs/simpleproc/helper.c	Thu Nov  1 20:58:13 2001
@@ -0,0 +1,277 @@
+/* Those of you who read this, give quiet thanks that you did not
+   suffer the endless frustration of dealing with the old /proc
+   interface.
+
+   Copyright (C) 2001 Rusty Russell.
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
+#include <linux/simpleproc.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/dcache.h>
+#include <linux/init.h>
+
+/* Wrapper for user's real proc functions */
+struct pdata_wrapper
+{
+	struct proc_data pdata;
+	proc_fetchfn_t *fetch;
+	proc_commitfn_t *commit;
+	void *lock;
+	void *userarg;
+};
+
+static struct proc_data *new_wrapper(proc_fetchfn_t *userfetch,
+				     proc_commitfn_t *usercommit,
+				     void *userarg,
+				     proc_fetchfn_t *wrapfetch,
+				     proc_commitfn_t *wrapcommit,
+				     void *lock)
+{
+	struct pdata_wrapper *pwrap;
+
+	pwrap = kmalloc(sizeof(*pwrap), GFP_KERNEL);
+	if (pwrap) {
+		pwrap->pdata.arg = pwrap;
+		pwrap->pdata.fetch = wrapfetch;
+		pwrap->pdata.commit = wrapcommit;
+		pwrap->pdata.dir = NULL;
+		pwrap->fetch = userfetch;
+		pwrap->commit = usercommit;
+		pwrap->lock = lock;
+		pwrap->userarg = userarg;
+	}
+	return &pwrap->pdata;
+}
+
+static int lock_fetch(const char *dirname, const char *fname,
+		      char *buffer, unsigned int size, void *arg)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	spin_lock_irq(pwrap->lock);
+	ret = pwrap->fetch(dirname, fname, pwrap->userarg, size, buffer);
+	spin_unlock_irq(pwrap->lock);
+
+	return ret;
+}
+
+static int lock_commit(const char *dirname, const char *fname,
+		       const char *buffer, unsigned int size, void *arg)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	spin_lock_irq(pwrap->lock);
+	ret = pwrap->commit(dirname, fname, buffer, size, pwrap->userarg);
+	spin_unlock_irq(pwrap->lock);
+
+	return ret;
+}
+
+struct proc_data *__new_proc_lock(void *arg, spinlock_t *lock,
+				  proc_fetchfn_t *fetch,
+				  proc_commitfn_t *commit)
+{
+	return new_wrapper(fetch, commit, arg, lock_fetch, lock_commit, lock);
+}
+
+static int sem_fetch(const char *dirname, const char *fname,
+		     char *buffer, unsigned int size, void *arg)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	if (down_interruptible(pwrap->lock) != 0)
+		return -EINTR;
+	ret = pwrap->fetch(dirname, fname, pwrap->userarg, size, buffer);
+	up(pwrap->lock);
+
+	return ret;
+}
+
+static int sem_commit(const char *dirname, const char *fname,
+		      const char *buffer, unsigned int size, void *arg)
+{
+	struct pdata_wrapper *pwrap = arg;
+	int ret;
+
+	if (down_interruptible(pwrap->lock) != 0)
+		return -EINTR;
+	ret = pwrap->commit(dirname, fname, buffer, size, pwrap->userarg);
+	up(pwrap->lock);
+
+	return ret;
+}
+
+struct proc_data *__new_proc_sem(void *arg, struct semaphore *sem,
+				 proc_fetchfn_t *fetch,
+				 proc_commitfn_t *commit)
+{
+	return new_wrapper(fetch, commit, arg, sem_fetch, sem_commit, sem);
+}
+
+int proc_fetch_short(const char *dir, const char *fname,
+		     char *outbuf, unsigned int size, void *shortp)
+{
+	return snprintf(outbuf, size, "%hi\n", *(short *)shortp);
+}
+
+int proc_commit_short(const char *dir, const char *fname,
+		      const char *inbuf, unsigned int size, void *shortp)
+{
+	if (sscanf(inbuf, "%hi", (short *)shortp) != 1) return -EINVAL;
+	return 0;
+}
+
+int proc_fetch_ushort(const char *dir, const char *fname,
+		      char *outbuf, unsigned int size, void *ushortp)
+{
+	return snprintf(outbuf, size, "%hu\n", *(unsigned short *)ushortp);
+}
+
+int proc_commit_ushort(const char *dir, const char *fname,
+		       const char *inbuf, unsigned int size, void *ushortp)
+{
+	if (sscanf(inbuf, "%hu", (unsigned short *)ushortp) != 1)
+		return -EINVAL;
+	return 0;
+}
+
+int proc_fetch_int(const char *dir, const char *fname,
+		    char *outbuf, unsigned int size, void *intp)
+{
+	return snprintf(outbuf, size, "%i\n", *(int *)intp);
+}
+
+int proc_commit_int(const char *dir, const char *fname,
+		    const char *inbuf, unsigned int size, void *intp)
+{
+	if (sscanf(inbuf, "%i", (int *)intp) != 1) return -EINVAL;
+	return 0;
+}
+
+int proc_fetch_uint(const char *dir, const char *fname,
+		    char *outbuf, unsigned int size, void *uintp)
+{
+	return snprintf(outbuf, size, "%u\n", *(unsigned int *)uintp);
+}
+
+int proc_commit_uint(const char *dir, const char *fname,
+		     const char *inbuf, unsigned int size, void *uintp)
+{
+	if (sscanf(inbuf, "%u", (unsigned int *)uintp) != 1) return -EINVAL;
+	return 0;
+}
+
+int proc_fetch_long(const char *dir, const char *fname,
+		    char *outbuf, unsigned int size, void *longp)
+{
+	return snprintf(outbuf, size, "%li\n", *(long *)longp);
+}
+
+int proc_commit_long(const char *dir, const char *fname,
+		     const char *inbuf, unsigned int size, void *longp)
+{
+	if (sscanf(inbuf, "%li", (long *)longp) != 1) return -EINVAL;
+	return 0;
+}
+
+int proc_fetch_ulong(const char *dir, const char *fname,
+		     char *outbuf, unsigned int size, void *ulongp)
+{
+	return snprintf(outbuf, size, "%lu\n", *(long *)ulongp);
+}
+
+int proc_commit_ulong(const char *dir, const char *fname,
+		      const char *inbuf, unsigned int size, void *ulongp)
+{
+	if (sscanf(inbuf, "%lu", (unsigned long *)ulongp) != 1) return -EINVAL;
+	return 0;
+}
+
+int proc_fetch_bool(const char *dir, const char *fname,
+		    char *outbuf, unsigned int size, void *boolp)
+{
+	if (*(int *)boolp) return snprintf(outbuf, size, "y\n");
+	else return snprintf(outbuf, size, "n\n");
+}
+
+int proc_commit_bool(const char *dir, const char *fname,
+		     const char *inbuf, unsigned int size, void *boolp)
+{
+	if (inbuf[0] == 'y' || inbuf[0] == 'Y')
+		*(int *)boolp = 1;
+	else if (inbuf[0] == 'n' || inbuf[0] == 'N')
+		*(int *)boolp = 0;
+	else return proc_commit_int(dir, fname, inbuf, size, boolp);
+	return 0;
+}
+
+/* Test code: delete me */
+static int number = 7;
+
+static int testfetch(const char *dirname,
+		     const char *filename,
+		     char *buffer,
+		     unsigned int size,
+		     void *arg)
+{
+	/* As an example, each one holds its own name */
+	return snprintf(buffer, size, "%s/%s\n", dirname, filename);
+}
+
+static int dirfunc(const char *dirname,
+		   const char *filename,
+		   struct proc_dircontents *buffer,
+		   unsigned int maxlen,
+		   void *arg)
+{
+	unsigned int used = 0;
+	char name[100];
+	unsigned int i;
+
+	for (i = 0; i < 10; i++) {
+		sprintf(name, "file-%u", i);
+		used = proc_add_dircontents(buffer, used, maxlen,
+					    S_IFREG|0400, testfetch,
+					    NULL, NULL, NULL, name);
+	}
+	/* And one infinite subdirectory example */
+	used = proc_add_dircontents(buffer, used, maxlen,
+				    S_IFDIR|0555, NULL, NULL, dirfunc, NULL,
+				    "subdir");
+	return proc_end_dircontents(buffer, used, maxlen);
+}
+
+static int __init init_test(void)
+{
+	int ret;
+	ret = proc("testdir", "number", number, int, 0644);
+	if (ret)
+		printk("Proc registration failed: %i\n", ret);
+	proc_dir("testdir", "subdir", dirfunc, NULL);
+	return 0;
+}
+
+static void __exit exit_test(void)
+{
+	unproc("testdir", "number");
+	unproc_dir("testdir", "subdir");
+}
+
+module_init(init_test);
+module_exit(exit_test);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.4.13-uml/fs/simpleproc/inode.c working-2.4.13-uml-proc/fs/simpleproc/inode.c
--- linux-2.4.13-uml/fs/simpleproc/inode.c	Thu Jan  1 10:00:00 1970
+++ working-2.4.13-uml-proc/fs/simpleproc/inode.c	Thu Nov  1 21:29:14 2001
@@ -0,0 +1,790 @@
+/*
+ * Simple /proc filesystem for Linux.
+ *
+ * Conceptually, there are two types of directories here: static
+ * (entries are created and deleted using
+ * register_proc/unregister_proc), and dynamic (contents are created
+ * on demand using a callback).
+ *
+ *   Copyright (C) 2001 Rusty Russell.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA 
+ */
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/stat.h>
+#include <linux/slab.h>
+#include <linux/pagemap.h>
+#include <linux/simpleproc.h>
+#include <asm/semaphore.h>
+
+#include <asm/uaccess.h>
+
+/* Proc mount point */
+struct vfsmount *proc_mnt;
+
+/* Serialize insert/delete and mounts */
+static DECLARE_MUTEX(proc_semaphore);
+
+#define SIMPLE_PROCFS_MAGIC	0x62121174
+
+/* Start with this many bytes allocated for file read */
+#define PROCFS_START_FILE	64
+/* Start with this many bytes allocated for directory read */
+#define PROCFS_START_DIR	PAGE_SIZE
+/* Approximate upper ceiling for memory usage per fs */
+#define PROCFS_MAX_SIZE		PAGE_SIZE
+
+/* Pre-decls for assigning */
+static struct inode_operations proc_punt_inodeops;
+static struct file_operations proc_helper_fileops;
+static struct file_operations proc_helper_dirops;
+static struct file_operations proc_punt_dirops;
+static struct inode_operations proc_helper_inodeops;
+static struct super_operations proc_ops;
+static struct dentry_operations proc_dentry_ops;
+
+struct proc_buffer
+{
+	unsigned int maxlen;
+	unsigned int len;
+	/* One is for the nul terminator */
+	char buffer[1];
+};
+
+struct proc_data *__new_proc(void *arg,
+			     proc_fetchfn_t *fetch,
+			     proc_commitfn_t *commit,
+			     proc_dirfn_t *dir)
+{
+	struct proc_data *pdata;
+
+	pdata = kmalloc(sizeof(*pdata), GFP_KERNEL);
+	if (pdata) {
+		pdata->arg = arg;
+		pdata->fetch = fetch;
+		pdata->commit = commit;
+		pdata->dir = dir;
+	}
+	return pdata;
+}
+
+/* FIXME: I have no idea what all this does: stolen from old /proc --RR */
+static int proc_statfs(struct super_block *sb, struct statfs *buf)
+{
+	buf->f_type = SIMPLE_PROCFS_MAGIC;
+	buf->f_bsize = PAGE_SIZE/sizeof(long);
+	buf->f_bfree = 0;
+	buf->f_bavail = 0;
+	buf->f_ffree = 0;
+	buf->f_namelen = NAME_MAX;
+	return 0;
+}
+
+/* Convenience routine to make an inode */
+static struct inode *
+new_proc_inode(struct super_block *sb, int mode, int is_dynamic)
+{
+	struct inode * inode = new_inode(sb);
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
+		inode->i_fop = &proc_helper_fileops;
+		break;
+	case S_IFDIR:
+		if (is_dynamic) {
+			inode->i_fop = &proc_punt_dirops;
+			inode->i_op = &proc_punt_inodeops;
+		} else {
+			inode->i_fop = &proc_helper_dirops;
+			inode->i_op = &proc_helper_inodeops;
+		}
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	return inode;
+}
+
+/* Make a new proc entry in this directory: must be holding proc_semapore */
+static int make_proc_entry(struct dentry *dir,
+			   const char *fname,
+			   int mode,
+			   struct proc_data *pdata,
+			   int is_dynamic)
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
+	/* You can't put a static proc entry in a dynamic dir */
+	if (dir->d_inode->i_op == &proc_punt_inodeops)
+		BUG();
+
+	/* Does it already exist? */
+	dentry = d_lookup(dir, &qstr);
+	if (dentry) {
+		dput(dentry);
+		return -EEXIST;
+	}
+
+	/* Doesn't exist: create inode */
+	inode = new_proc_inode(dir->d_sb, mode, is_dynamic);
+	if (!inode)
+		return -ENOMEM;
+
+	/* Create dentry */
+	dentry = d_alloc(dir, &qstr);
+	if (!dentry) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	dentry->d_op = &proc_dentry_ops;
+	dentry->d_fsdata = pdata;
+	d_add(dentry, inode);
+
+	/* Pin the dentry here, so it doesn't get pruned */
+	dget(dentry);
+	return 0;
+}
+
+/* Create (static) proc directory if neccessary. */
+/* FIXME: Keep refcnt, so we can delete when no more users */
+static struct dentry *get_proc_dir(const char *dirname)
+{
+	struct dentry *dentry;
+	struct qstr qstr;
+	const char *delim;
+
+	/* FIXME: Definitely need a better way --RR */
+	dentry = dget(proc_mnt->mnt_sb->s_root);
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
+		while (!(newdentry = d_lookup(dentry, &qstr))) {
+			char fname[qstr.len+1];
+			int ret;
+
+			strncpy(fname, qstr.name, qstr.len);
+			fname[qstr.len] = '\0';
+			down(&proc_semaphore);
+			ret = make_proc_entry(dentry, fname, S_IFDIR|0555,
+					       NULL, 0);
+			up(&proc_semaphore);
+
+			if (ret < 0) {
+				dput(dentry);
+				return ERR_PTR(ret);
+			}
+		}
+		dput(dentry);
+		dentry = newdentry;
+	}
+	return dentry;
+}
+
+/* Actually add a proc file or dynamic directory */
+int __proc(const char *dirname, const char *fname, int mode,
+	   struct proc_data *pdata)
+{
+	struct dentry *dir;
+	int ret;
+
+	if (!pdata)
+		return -ENOMEM;
+
+	dir = get_proc_dir(dirname);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	ret = make_proc_entry(dir, fname, mode, pdata, S_ISDIR(mode) ? 1 : 0);
+	dput(dir);
+	return ret;
+}
+
+static int proc_nofetch(const char *dirname, const char *fname,
+			char *outbuf, unsigned int len, void *arg)
+{
+	return -ENOENT;
+}
+
+static int proc_nocommit(const char *dirname, const char *fname,
+			 const char *inbuf, unsigned int len, void *arg)
+{
+	return -ENOENT;
+}
+
+static int proc_nodir(const char *dirname,
+		      const char *filename,
+		      struct proc_dircontents *buffer,
+		      unsigned int size,
+		      void *arg)
+{
+	return -ENOENT;
+}
+
+/* Release a proc entry */
+void unproc(const char *dir, const char *fname)
+{
+	struct dentry *dentry;
+	const char *delim;
+	struct qstr qstr;
+	struct proc_data *pdata;
+
+	/* FIXME: There's a better way, right? --RR */
+	dentry = dget(proc_mnt->mnt_sb->s_root);
+
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
+	pdata->commit = proc_nocommit;
+	pdata->fetch = proc_nofetch;
+	pdata->dir = proc_nodir;
+
+	/* This will probably free the dentry immediately, but if not,
+           too bad. */
+	dput(dentry);
+	dput(dentry);
+}
+
+void unproc_dir(const char *dir, const char *fname)
+{
+	unproc(dir, fname);
+}
+
+/* See if /proc entry exists (entries registered in directory). */
+static struct dentry *proc_lookup(struct inode *dir,
+					 struct dentry *dentry)
+{
+	/* Since we place new staticn entries in the dcache, if we get
+	   here, we know the entry does not exist.  Create a negative
+	   dentry, and return NULL */
+	d_add(dentry, NULL);
+	return NULL;
+}
+
+/* Call callback to get directory contents */
+static struct proc_dircontents *get_dir_contents(const char *dirname,
+						 const char *filename,
+						 struct proc_data *pdata)
+{
+	struct proc_dircontents *ret;
+	unsigned int size = PROCFS_START_DIR;
+
+	ret = kmalloc(size, GFP_KERNEL);
+	while (ret) {
+		int used;
+		used = pdata->dir(dirname, filename, ret, size, pdata->arg);
+		if (used < 0) {
+			kfree(ret);
+			return ERR_PTR(used);
+		}
+		if (used <= size)
+			return ret;
+
+		/* Realloc larger and loop */
+		kfree(ret);
+		size = used;
+		ret = kmalloc(size, GFP_KERNEL);
+	}
+	return ERR_PTR(-ENOMEM);
+}
+
+/* Incrementing is a little tricky: round up to alignment */
+static struct proc_dircontents *next_dcont(struct proc_dircontents *dcontents)
+{
+	unsigned int len;
+
+	len = ((sizeof(*dcontents) + strlen(dcontents->name) + 1
+		+ __alignof__(*dcontents) - 1)
+	       & ~(__alignof__(*dcontents) - 1));
+	return (void *)dcontents + len;
+}
+
+/* Search results from callback for this name, and if found create inode */
+static struct proc_dircontents *
+find_dcontents(struct proc_dircontents *dir_contents,
+	       struct dentry *dentry)
+{
+	while (dir_contents->mode) {
+		if (strcmp(dentry->d_name.name, dir_contents->name) == 0)
+			return dir_contents;
+		dir_contents = next_dcont(dir_contents);
+	}
+	/* Not found... */
+	return NULL;
+}
+
+/* Since there are no hard links in this filesystem, we can simply map
+   inodes to dentries.  This is not possibly in general! */
+static struct dentry *inode_to_dentry(struct inode *inode)
+{
+	if (inode->i_dentry.next->next != &inode->i_dentry)
+		BUG();
+	return list_entry(inode->i_dentry.next, struct dentry, d_alias);
+}
+
+/* See if /proc entry exists (user controls contents of directory). */
+static struct dentry *proc_punt_lookup(struct inode *dir,
+				       struct dentry *dentry)
+{
+	/* We do the whole callback on every lookup. */
+	struct proc_data *pdata;
+	struct proc_dircontents *dir_contents, *dc;
+	struct inode *inode;
+	struct dentry *parent;
+
+	/* Since we know the inode is a directory, there is only one
+           inode in the dentry alias list, so mapping inode -> dentry
+           is easy */
+	parent = inode_to_dentry(dir);
+	dir_contents = get_dir_contents(parent->d_name.name,
+					dentry->d_name.name,
+					parent->d_fsdata);
+	if (!dir_contents || IS_ERR(dir_contents))
+		return (struct dentry *)dir_contents;
+
+	/* Looks through callback-supplied list for this dentry */ 
+	dc = find_dcontents(dir_contents, dentry);
+	if (!dc) {
+		kfree(dir_contents);
+		return NULL;
+	}
+	inode = new_proc_inode(dentry->d_sb, dc->mode, 1);
+	if (!inode) {
+		kfree(dir_contents);
+		return ERR_PTR(-ENOMEM);
+	}
+	pdata = __new_proc(dc->arg, dc->fetch, dc->commit, dc->dir);
+	if (!pdata) {
+		iput(inode);
+		kfree(dir_contents);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dentry->d_op = &proc_dentry_ops;
+	dentry->d_fsdata = pdata;
+	d_add(dentry, inode);
+	kfree(dir_contents);
+	return NULL;
+}
+
+/* On open, we grab contents if we're readable... */
+static int proc_file_snapshot(struct inode *inode, struct file *filp)
+{
+	unsigned int size;
+	struct proc_buffer *buf;
+	struct proc_data *pdata;
+	char *dirname;
+	unsigned long page;
+
+	pdata = filp->f_dentry->d_fsdata;
+	/* Start at this, and work up */
+	size = PROCFS_START_FILE;
+
+	if (!(filp->f_mode & FMODE_READ)) {
+		/* Allocate write buffer: */
+		buf = kmalloc(sizeof(*buf) + size, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
+		buf->maxlen = size;
+		buf->len = 0;
+		filp->private_data = buf;
+		return 0;
+	}
+
+	/* For the moment, you can't open for read & write.  Later,
+           when seek resets snapshot/commit, we should allow this. */
+	if (filp->f_mode & FMODE_WRITE)
+		return -EINVAL;
+
+	page = __get_free_page(GFP_USER);
+	if (!page)
+		return -ENOMEM;
+
+	/* FIXME: This is not right: the callbacks don't care what the
+	   process's idea of root is, it only wants path after proc/. */
+	dirname = d_path(filp->f_dentry, filp->f_vfsmnt,
+			 (char *)page, PAGE_SIZE);
+	if (dirname < (char *)page)
+		BUG();
+
+	/* buf[0] holds the size */
+	buf = kmalloc(sizeof(*buf)+size, GFP_KERNEL);
+	while (buf) {
+		int used;
+		used = pdata->fetch(dirname, filp->f_dentry->d_name.name,
+				    buf->buffer, size, pdata->arg);
+		if (used < 0) {
+			kfree(buf);
+			free_page(page);
+			/* FIXME: if used == -ENOENT, destroy dcache entry */
+			return used;
+		}
+		if (used <= size) {
+			free_page(page);
+			filp->private_data = buf;
+			/* Nul terminate and save size */
+			buf->maxlen = size;
+			buf->len = used;
+			buf->buffer[used] = '\0';
+			return 0;
+		}
+
+		/* Realloc larger and loop */
+		kfree(buf);
+		size = used;
+		if (size > PROCFS_MAX_SIZE)
+			break;
+		buf = kmalloc(sizeof(*buf)+size, GFP_KERNEL);
+	}
+	free_page(page);
+	return -ENOMEM;
+}
+
+/* On close, we commit contents if we've been written to... */
+static int proc_file_commit(struct inode *inode, struct file *filp)
+{
+	int ret;
+	struct proc_data *pdata;
+	struct proc_buffer *buf;
+	char *dirname;
+	unsigned long page;
+
+	pdata = filp->f_dentry->d_fsdata;
+	if (!(filp->f_mode & FMODE_WRITE)) {
+		kfree(filp->private_data);
+		return 0;
+	}
+
+	page = __get_free_page(GFP_USER);
+	if (!page) {
+		kfree(filp->private_data);
+		return -ENOMEM;
+	}
+
+	/* FIXME: This is not right: the callbacks don't care what the
+	   process's idea of root is, it only wants path after proc/. */
+	dirname = d_path(filp->f_dentry, filp->f_vfsmnt,
+			 (char *)page, PAGE_SIZE);
+	if (dirname < (char *)page)
+		BUG();
+
+	/* nul-terminate buffer */
+	buf = filp->private_data;
+	buf->buffer[buf->len] = '\0';
+	ret = pdata->commit(dirname, filp->f_dentry->d_name.name,
+			    buf->buffer, buf->len, pdata->arg);
+	
+	kfree(filp->private_data);
+	free_page(page);
+	return ret;
+}
+
+/* Copy from buffer */
+static ssize_t proc_file_read(struct file *filp, char *ubuf, size_t size,
+			      loff_t *off)
+{
+	struct proc_buffer *buf;
+	struct inode *inode;
+
+	/* Use inode semaphore to serialize against writes. */
+	inode = filp->f_dentry->d_inode;
+	if (down_interruptible(&inode->i_sem) != 0)
+		return -EINTR;
+
+	buf = filp->private_data;
+	if (size + *off > buf->len)
+		size = buf->len - *off;
+
+	/* Copy from static buffer */
+	if (copy_to_user(ubuf, buf->buffer, size) != 0) {
+		up(&inode->i_sem);
+		return -EFAULT;
+	}
+	up(&inode->i_sem);
+
+	*off += size;
+	return (ssize_t)size;
+}
+
+/* Copy to buffer */
+static ssize_t proc_file_write(struct file *filp,
+			       const char *ubuf,
+			       size_t size,
+			       loff_t *off)
+{
+	struct inode *inode;
+	struct proc_buffer *buf;
+	struct proc_data *pdata;
+
+	pdata = filp->f_dentry->d_fsdata;
+
+	/* Use inode semaphore to serialize writes & reads. */
+	inode = filp->f_dentry->d_inode;
+	if (down_interruptible(&inode->i_sem) != 0)
+		return -EINTR;
+
+	buf = filp->private_data;
+	if (*off + size > buf->maxlen) {
+		struct proc_buffer *newbuffer;
+		/* Prevent them using too much memory */
+		if (*off + size > PROCFS_MAX_SIZE) {
+			up(&inode->i_sem);
+			return -ENOSPC;
+		}
+		/* Room for count at head */
+		newbuffer = kmalloc(sizeof(*newbuffer) + *off + size,
+				    GFP_USER);
+		if (!newbuffer) {
+			up(&inode->i_sem);
+			return -ENOMEM;
+		}
+		memcpy(newbuffer, buf, sizeof(*buf) + buf->len);
+		kfree(filp->private_data);
+		filp->private_data = buf = newbuffer;
+	}
+
+	/* Do actual copy */
+	if (copy_from_user(buf->buffer + *off, ubuf, size) != 0) {
+		up(&inode->i_sem);
+		return -EFAULT;
+	}
+	up(&inode->i_sem);
+	buf->len += size;
+	*off += size;
+
+	return size;
+}
+
+/* Call the user's callback to get contents of this directory.
+   Generate . and .. automagically. */
+static int proc_dynamic_readdir(struct file *filp,
+				void *dirent,
+				filldir_t filldir)
+{
+	int i;
+	struct proc_dircontents *dcontents, *dp;
+	char *dirname;
+	unsigned long page;
+	struct proc_data *pdata;
+	struct dentry *dentry = filp->f_dentry;
+
+	pdata = filp->f_dentry->d_fsdata;
+
+	i = filp->f_pos;
+	switch (i) {
+	case 0:
+		if (filldir(dirent, ".", 1, 0, dentry->d_inode->i_ino, DT_DIR)
+		    < 0)
+			break;
+		i++;
+		filp->f_pos++;
+		/* fallthrough */
+	case 1:
+		if (filldir(dirent, "..", 2, 0,
+			    dentry->d_parent->d_inode->i_ino, DT_DIR) < 0)
+			break;
+		i++;
+		filp->f_pos++;
+	}
+
+	page = __get_free_page(GFP_USER);
+	if (!page) return -ENOMEM;
+
+	/* FIXME: This is not right: the callbacks don't care what the
+	   process's idea of root is, it only wants path after proc/. */
+	dirname = d_path(filp->f_dentry, filp->f_vfsmnt,
+			 (char *)page, PAGE_SIZE);
+	if (dirname < (char *)page)
+		BUG();
+
+	/* Call user callback to get directory */
+	dcontents = get_dir_contents(dirname,
+				     dentry->d_name.name,
+				     pdata);
+	if (IS_ERR(dcontents)) {
+		free_page(page);
+		return PTR_ERR(dcontents);
+	}
+
+	/* Skip any already-read entries... */
+	for (dp = dcontents, i -= 2; dp->mode && i; dp = next_dcont(dp), i++);
+
+	for (; dp->mode; dp = next_dcont(dp)) {
+		/* FIXME: Use non-zero inode numbers */
+		if (filldir(dirent, dp->name, strlen(dp->name),
+			    filp->f_pos,
+			    filp->f_pos,
+			    S_ISDIR(dp->mode) ? DT_DIR : DT_REG) < 0)
+			break;
+		filp->f_pos++;
+	}
+	free_page(page);
+	kfree(dcontents);
+	return 0;
+}
+
+/* Free the private area when dentry is freed. */
+static void proc_release(struct dentry *dentry)
+{
+	kfree(dentry->d_fsdata);
+}
+
+static struct super_block *proc_read_super(struct super_block *s,
+					   void *data, 
+					   int silent)
+{
+	struct inode * root_inode;
+
+	s->s_blocksize = 1024;
+	s->s_blocksize_bits = 10;
+	s->s_magic = SIMPLE_PROCFS_MAGIC;
+	s->s_op = &proc_ops;
+
+	root_inode = new_proc_inode(s, S_IFDIR|0555, 0);
+	if (!root_inode) return NULL;
+
+	/* Block concurrent mounts */
+	down(&proc_semaphore);
+
+	s->s_root = d_alloc_root(root_inode);
+	if (!s->s_root) {
+		iput(root_inode);
+		up(&proc_semaphore);
+		return NULL;
+	}
+	up(&proc_semaphore);
+	return s;
+}
+
+/* Proc files use these wrappers */
+static struct file_operations proc_helper_fileops = {
+	open:		proc_file_snapshot,
+	release:	proc_file_commit,
+	read:		proc_file_read,
+	write:		proc_file_write,
+};
+
+/* Directories which use normal registration mechanism, which sit in
+   the dcache */
+static struct file_operations proc_helper_dirops = {
+	read:		generic_read_dir,
+	readdir:	dcache_readdir,
+};
+
+/* Directories which have their own dynamic content */
+static struct file_operations proc_punt_dirops = {
+	read:		generic_read_dir,
+	readdir:	proc_dynamic_readdir,
+};
+
+/* You can only do lookups through these dirs: dynamic ones do callbacks... */
+static struct inode_operations proc_punt_inodeops = {
+	lookup:		proc_punt_lookup,
+};
+
+/* ... static ones look up registrations */
+static struct inode_operations proc_helper_inodeops = {
+	lookup:		proc_lookup,
+};
+
+static struct super_operations proc_ops = {
+	statfs:		proc_statfs,
+	put_inode:	force_delete,
+};
+
+static struct dentry_operations proc_dentry_ops = {
+	d_release:	proc_release,
+};
+
+static DECLARE_FSTYPE(proc_fs_type, "proc", proc_read_super, FS_SINGLE);
+
+static int __init init_proc_fs(void)
+{
+	register_filesystem(&proc_fs_type);
+	proc_mnt = kern_mount(&proc_fs_type);
+	return 0;
+}
+
+static void __exit exit_proc_fs(void)
+{
+	unregister_filesystem(&proc_fs_type);
+}
+
+module_init(init_proc_fs);
+module_exit(exit_proc_fs);
+
