Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317352AbSGOGYw>; Mon, 15 Jul 2002 02:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317354AbSGOGYw>; Mon, 15 Jul 2002 02:24:52 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:4841 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S317352AbSGOGYt>; Mon, 15 Jul 2002 02:24:49 -0400
Date: Mon, 15 Jul 2002 11:57:39 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: [PATCH, 2.5] : Adding counters to BSD process accounting
Message-ID: <Pine.GSO.4.44.0207151154460.23890-100000@cbin2-xdm1.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This  patch  keeps account of the number of bytes read/written by a
process in it's lifetime.

This may be a  good estimate of how IO bound a process is.
This change is integrated with the BSD process accounting feature. Please
review the changes and if you're ok with it, please apply to the 2.5 tree.

thanks,
Manik


diff -u -U 6 -r --show-c-function -H linux-2.5.24/fs/read_write.c work/fs/read_write.c
--- linux-2.5.24/fs/read_write.c	Fri Jun 21 04:23:54 2002
+++ work/fs/read_write.c	Tue Jul  9 15:10:55 2002
@@ -8,12 +8,13 @@
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/uio.h>
 #include <linux/smp_lock.h>
 #include <linux/dnotify.h>
+#include <linux/acct.h>

 #include <asm/uaccess.h>

 struct file_operations generic_ro_fops = {
 	llseek:		generic_file_llseek,
 	read:		generic_file_read,
@@ -214,12 +215,14 @@ asmlinkage ssize_t sys_read(unsigned int
 	file = fget(fd);
 	if (file) {
 		ret = vfs_read(file, buf, count, &file->f_pos);
 		fput(file);
 	}

+	acct_read_add(ret);
+
 	return ret;
 }

 asmlinkage ssize_t sys_write(unsigned int fd, const char * buf, size_t count)
 {
 	struct file *file;
@@ -227,12 +230,14 @@ asmlinkage ssize_t sys_write(unsigned in

 	file = fget(fd);
 	if (file) {
 		ret = vfs_write(file, buf, count, &file->f_pos);
 		fput(file);
 	}
+
+	acct_write_add(ret);

 	return ret;
 }

 asmlinkage ssize_t sys_pread(unsigned int fd, char *buf,
 			     size_t count, loff_t pos)
diff -u -U 6 -r --show-c-function -H linux-2.5.24/include/linux/acct.h work/include/linux/acct.h
--- linux-2.5.24/include/linux/acct.h	Fri Jun 21 04:23:46 2002
+++ work/include/linux/acct.h	Tue Jul  9 15:13:08 2002
@@ -54,12 +54,14 @@ struct acct
 	comp_t		ac_minflt;		/* Accounting Minor Pagefaults */
 	comp_t		ac_majflt;		/* Accounting Major Pagefaults */
 	comp_t		ac_swaps;		/* Accounting Number of Swaps */
 	__u32		ac_exitcode;		/* Accounting Exitcode */
 	char		ac_comm[ACCT_COMM + 1];	/* Accounting Command Name */
 	char		ac_pad[10];		/* Accounting Padding Bytes */
+	__u64           ac_read;                /* Accounting bytes read */
+	__u64           ac_write;               /* Accountind bytes written */
 };

 /*
  *  accounting flags
  */
 				/* bit set when the process ... */
@@ -75,14 +77,26 @@ struct acct

 #include <linux/config.h>

 #ifdef CONFIG_BSD_PROCESS_ACCT
 extern void acct_auto_close(struct super_block *sb);
 extern int acct_process(long exitcode);
+
+static inline void acct_read_add (ssize_t count)
+{
+	if (count) current->read += count;
+}
+
+static inline void acct_write_add (ssize_t count)
+{
+	if (count) current->write += count;
+}
 #else
 #define acct_auto_close(x)	do { } while (0)
 #define acct_process(x)		do { } while (0)
+#define acct_read_add(x)        do { } while (0)
+#define acct_write_add(x)       do { } while (0)
 #endif

 #endif	/* __KERNEL */

 #endif	/* _LINUX_ACCT_H */
diff -u -U 6 -r --show-c-function -H linux-2.5.24/include/linux/sched.h work/include/linux/sched.h
--- linux-2.5.24/include/linux/sched.h	Fri Jun 21 04:23:44 2002
+++ work/include/linux/sched.h	Tue Jul  9 14:18:14 2002
@@ -361,12 +361,17 @@ struct task_struct {
 /* Protection of (de-)allocation: mm, files, fs, tty */
 	spinlock_t alloc_lock;

 /* journalling filesystem info */
 	void *journal_info;
 	struct dentry *proc_dentry;
+
+#ifdef    CONFIG_BSD_PROCESS_ACCT
+/* process accounting info */
+	u64  read, write;
+#endif  /* CONFIG_BSD_PROCESS_ACCT */
 };

 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 #define put_task_struct(tsk) \
 do { if (atomic_dec_and_test(&(tsk)->usage)) __put_task_struct(tsk); } while(0)
diff -u -U 6 -r --show-c-function -H linux-2.5.24/kernel/acct.c work/kernel/acct.c
--- linux-2.5.24/kernel/acct.c	Fri Jun 21 04:23:53 2002
+++ work/kernel/acct.c	Tue Jul  9 15:04:41 2002
@@ -38,12 +38,15 @@
  *  OK, that's better. ANOTHER race and leak in BSD variant. There always
  *  is one more bug... 10/11/98, AV.
  *
  *	Oh, fsck... Oopsable SMP race in do_process_acct() - we must hold
  * ->mmap_sem to walk the vma list of current->mm. Nasty, since it leaks
  * a struct file opened for write. Fixed. 2/6/2000, AV.
+ *
+ *  Added support for number of bytes read/written per process.
+ *                                              - Manik Raina
  */

 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/acct.h>
@@ -351,13 +354,14 @@ static void do_acct_process(long exitcod
 	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
 	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
 	ac.ac_minflt = encode_comp_t(current->min_flt);
 	ac.ac_majflt = encode_comp_t(current->maj_flt);
 	ac.ac_swaps = encode_comp_t(current->nswap);
 	ac.ac_exitcode = exitcode;
-
+	ac.ac_read = current->read;
+	ac.ac_write = current->write;
 	/*
          * Kernel segment override to datasegment and write it
          * to the accounting file.
          */
 	fs = get_fs();
 	set_fs(KERNEL_DS);

