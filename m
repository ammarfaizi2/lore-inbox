Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbTKTQmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 11:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTKTQmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 11:42:55 -0500
Received: from users.ccur.com ([208.248.32.211]:54903 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S261988AbTKTQmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 11:42:20 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200311201641.QAA05566@rudolph.ccur.com>
Subject: Re: [PATCH resend] Opteron support for mqueues-4.00 +bug fixes
To: ak@suse.de (Andi Kleen)
Date: Thu, 20 Nov 2003 11:41:33 -0500 (EST)
Cc: linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <p73fzgjozfi.fsf@oldwotan.suse.de> from "Andi Kleen" at Nov 20, 2003 04:02:57 PM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> jak@rudolph.ccur.com (Joe Korty) writes:
> >  __SYSCALL(__NR_vserver, sys_ni_syscall)
> > +#define __NR_mq_open			274
> > +__SYSCALL(__NR_mq_open, sys_mq_open)
> 
> The patch is buggy. You cannot add any unmapped holes into the x86-64 
> system call table, it adds an oopsable hole to the entry.

Indeed.  Thanks for looking this over.  Repaired patch attached.


> In general you cannot add any system calls without coordinating with
> Linus and the architecture maintainers first. And the list is not sparse.

When Linus et all assign numbers I am sure Michal & Krzysztof will
use them.  Until then these are informal patches for people to play
with and tweak as they please.

Joe

Patchname: mqueues-4.00-kernel-a1.patch

diff -ura 4.00/arch/x86_64/ia32/ia32entry.S new/arch/x86_64/ia32/ia32entry.S
--- 4.00/arch/x86_64/ia32/ia32entry.S	2003-10-25 14:43:32.000000000 -0400
+++ new/arch/x86_64/ia32/ia32entry.S	2003-11-20 10:41:50.000000000 -0500
@@ -476,6 +476,16 @@
 	.quad sys_tgkill
 	.quad compat_sys_utimes
 	.quad sys32_fadvise64_64
+	.quad ni_syscall
+
+	.quad compat_sys_mq_open
+	.quad sys_mq_unlink
+	.quad compat_sys_mq_timedsend
+	.quad compat_sys_mq_timedreceive
+	.quad compat_sys_mq_notify
+	.quad compat_sys_mq_getattr
+	.quad compat_sys_mq_setattr
+
 	/* don't forget to change IA32_NR_syscalls */
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
diff -ura 4.00/include/asm-x86_64/ia32_unistd.h new/include/asm-x86_64/ia32_unistd.h
--- 4.00/include/asm-x86_64/ia32_unistd.h	2003-10-25 14:43:59.000000000 -0400
+++ new/include/asm-x86_64/ia32_unistd.h	2003-11-20 10:41:50.000000000 -0500
@@ -279,6 +279,14 @@
 #define __NR_ia32_utimes		271
 #define __NR_ia32_fadvise64_64		272
 
-#define IA32_NR_syscalls 275	/* must be > than biggest syscall! */	
+#define __NR_ia32_mq_open 		274
+#define __NR_ia32_mq_unlink		(__NR_ia32_mqopen+1)
+#define __NR_ia32_mq_timedsend		(__NR_ia32_mqopen+2)
+#define __NR_ia32_mq_timedreceive	(__NR_ia32_mqopen+3)
+#define __NR_ia32_mq_notify		(__NR_ia32_mqopen+4)
+#define __NR_ia32_mq_getattr		(__NR_ia32_mqopen+5)
+#define __NR_ia32_mq_setattr		(__NR_ia32_mqopen+6)
+
+#define IA32_NR_syscalls 281	/* must be > than biggest syscall! */	
 
 #endif /* _ASM_X86_64_IA32_UNISTD_H_ */
diff -ura 4.00/include/asm-x86_64/unistd.h new/include/asm-x86_64/unistd.h
--- 4.00/include/asm-x86_64/unistd.h	2003-10-25 14:44:03.000000000 -0400
+++ new/include/asm-x86_64/unistd.h	2003-11-20 10:44:00.000000000 -0500
@@ -532,8 +532,23 @@
 __SYSCALL(__NR_utimes, sys_utimes)
 #define __NR_vserver		236
 __SYSCALL(__NR_vserver, sys_ni_syscall)
+#define __NR_mq_open		237
+__SYSCALL(__NR_mq_open, sys_mq_open)
+#define __NR_mq_unlink		238
+__SYSCALL(__NR_mq_unlink, sys_mq_unlink)
+#define __NR_mq_timedsend	239
+__SYSCALL(__NR_mq_timedsend, sys_mq_timedsend)
+#define __NR_mq_timedreceive	240
+__SYSCALL(__NR_mq_timedreceive, sys_mq_timedreceive)
+#define __NR_mq_notify		241
+__SYSCALL(__NR_mq_notify, sys_mq_notify)
+#define __NR_mq_getattr		242
+__SYSCALL(__NR_mq_getattr, sys_mq_getattr)
+#define __NR_mq_setattr		243
+__SYSCALL(__NR_mq_setattr, sys_mq_setattr)
 
-#define __NR_syscall_max __NR_vserver
+#undef __NR_syscall_max
+#define __NR_syscall_max __NR_mq_setattr
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
diff -ura 4.00/include/linux/compat.h new/include/linux/compat.h
--- 4.00/include/linux/compat.h	2003-10-25 14:43:34.000000000 -0400
+++ new/include/linux/compat.h	2003-11-20 10:41:50.000000000 -0500
@@ -44,8 +44,8 @@
 } compat_sigset_t;
 
 extern int cp_compat_stat(struct kstat *, struct compat_stat *);
-extern int get_compat_timespec(struct timespec *, struct compat_timespec *);
-extern int put_compat_timespec(struct timespec *, struct compat_timespec *);
+extern int get_compat_timespec(struct timespec *, const struct compat_timespec *);
+extern int put_compat_timespec(struct timespec *, const struct compat_timespec *);
 
 struct compat_iovec {
 	compat_uptr_t	iov_base;
diff -ura 4.00/include/linux/mqueue.h new/include/linux/mqueue.h
--- 4.00/include/linux/mqueue.h	2003-11-20 10:41:39.000000000 -0500
+++ new/include/linux/mqueue.h	2003-11-20 10:41:50.000000000 -0500
@@ -21,12 +21,14 @@
 	long mq_curmsgs;	/* number of messages currently queued */
 };
 
-asmlinkage mqd_t sys_mq_open(const char __user *name, int oflag, mode_t mode, struct mq_attr __user *attr);
-asmlinkage int sys_mq_unlink(const char __user *name);
-asmlinkage int mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec __user *abs_timeout);
+#ifdef __KERNEL__
+asmlinkage long sys_mq_open(const char __user *name, int oflag, mode_t mode, struct mq_attr __user *attr);
+asmlinkage long sys_mq_unlink(const char __user *name);
+asmlinkage long mq_timedsend(mqd_t mqdes, const char __user *msg_ptr, size_t msg_len, unsigned int msg_prio, const struct timespec __user *abs_timeout);
 asmlinkage ssize_t mq_timedreceive(mqd_t mqdes, char __user *msg_ptr, size_t msg_len, unsigned int __user *msg_prio, const struct timespec __user *abs_timeout);
-asmlinkage int mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
-asmlinkage int mq_getattr(mqd_t mqdes, struct mq_attr __user *mqstat);
-asmlinkage int mq_setattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);
+asmlinkage long mq_notify(mqd_t mqdes, const struct sigevent __user *notification);
+asmlinkage long mq_getattr(mqd_t mqdes, struct mq_attr __user *mqstat);
+asmlinkage long mq_setattr(mqd_t mqdes, const struct mq_attr __user *mqstat, struct mq_attr __user *omqstat);
+#endif
 
 #endif
diff -ura 4.00/ipc/mqueue.c new/ipc/mqueue.c
--- 4.00/ipc/mqueue.c	2003-11-20 10:41:39.000000000 -0500
+++ new/ipc/mqueue.c	2003-11-20 10:41:50.000000000 -0500
@@ -724,6 +724,9 @@
 	struct file *filp;
 	static int oflag2acc[O_ACCMODE] = { MAY_READ, MAY_WRITE, MAY_READ | MAY_WRITE };
 
+	if ((oflag & O_ACCMODE) == 3)
+		return ERR_PTR(-EINVAL);
+
 	if (permission(dentry->d_inode, oflag2acc[oflag & O_ACCMODE], NULL))
 		return ERR_PTR(-EACCES);
 
@@ -735,7 +738,7 @@
 	return filp;
 }
 
-asmlinkage mqd_t sys_mq_open(const char __user *u_name, int oflag, mode_t mode,
+asmlinkage long sys_mq_open(const char __user *u_name, int oflag, mode_t mode,
 	struct mq_attr __user *attr)
 {
 	struct dentry *dentry;
@@ -790,7 +793,7 @@
 }
 
 
-asmlinkage int sys_mq_unlink(const char __user *u_name)
+asmlinkage long sys_mq_unlink(const char __user *u_name)
 {
 	int err;
 	char *name;
@@ -807,6 +810,11 @@
 		err = PTR_ERR(dentry);
 		goto out_unlock;
 	}
+	if (!dentry->d_inode) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+
 	if (permission(dentry->d_inode, MAY_WRITE, NULL))
 	{	
 		err = -EACCES;
@@ -829,23 +837,18 @@
 	return err;
 }
 
-
-asmlinkage int sys_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr, 
-	size_t msg_len, unsigned int msg_prio, const struct timespec __user *u_abs_timeout)
+static asmlinkage long do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr, 
+	size_t msg_len, unsigned int msg_prio, const long timeout)
 {
 	struct file *filp;
 	struct inode *ino;
 	struct ext_wait_queue *wq_ptr;
 	struct msg_msg *msg_ptr;
-	long timeout;
 	int ret;
 	struct mqueue_inode_info *info = MQUEUE_I(ino);
 
 	if (msg_prio >= (unsigned long) MQ_PRIO_MAX)
 		return -EINVAL;
-
-	if ((timeout = prepare_timeout(u_abs_timeout)) < 0)
-		return timeout;
 	
 	ret = -EBADF;
 	filp = fget(mqdes);
@@ -944,10 +947,19 @@
 	return ret;
 }
 
-asmlinkage ssize_t sys_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr, 
-	size_t msg_len, unsigned int __user *u_msg_prio, const struct timespec __user *u_abs_timeout)
+asmlinkage long sys_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr, 
+	size_t msg_len, unsigned int msg_prio, const struct timespec __user *u_abs_timeout)
 {
 	long timeout;
+
+	if ((timeout = prepare_timeout(u_abs_timeout)) < 0)
+		return timeout;
+	return do_mq_timedsend(mqdes, u_msg_ptr, msg_len, msg_prio, timeout);
+}
+
+static asmlinkage ssize_t do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr, 
+	size_t msg_len, unsigned int __user *u_msg_prio, const long timeout)
+{
 	ssize_t ret;
 	struct msg_msg *msg_ptr;
 	struct file *filp;
@@ -955,9 +967,6 @@
 	struct mqueue_inode_info *info;
 	struct ext_wait_queue *wq_ptr;
 	
-	if ((timeout = prepare_timeout(u_abs_timeout)) < 0)
-		return timeout;	
-	
 	ret = -EBADF;
 	filp = fget(mqdes);
 	if (!filp)
@@ -1040,12 +1049,23 @@
 	return ret;
 }
 
+asmlinkage ssize_t sys_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr, 
+	size_t msg_len, unsigned int __user *u_msg_prio,
+	const struct timespec __user *u_abs_timeout)
+{
+	long timeout;
+	
+	if ((timeout = prepare_timeout(u_abs_timeout)) < 0)
+		return timeout;	
+	return do_mq_timedreceive(mqdes, u_msg_ptr, msg_len, u_msg_prio, timeout);
+}
+
 
 /* Notes: the case when user wants us to deregister (with NULL as pointer or SIGEV_NONE)
  * and he isn't currently owner of notification will be silently discarded. 
  * It isn't explicitly defined in the POSIX. 
  */
-asmlinkage int sys_mq_notify(mqd_t mqdes, const struct sigevent __user *u_notification)
+asmlinkage long sys_mq_notify(mqd_t mqdes, const struct sigevent __user *u_notification)
 {
 	int ret;
 	struct file *filp;
@@ -1105,7 +1125,7 @@
 	return ret;
 }
 
-asmlinkage int sys_mq_getattr(mqd_t mqdes, struct mq_attr __user *u_mqstat)
+asmlinkage long sys_mq_getattr(mqd_t mqdes, struct mq_attr __user *u_mqstat)
 {
 	int ret;
 	struct mq_attr attr;
@@ -1143,7 +1163,7 @@
 	return ret;
 }
 
-asmlinkage int sys_mq_setattr(mqd_t mqdes, const struct mq_attr __user *u_mqstat,
+asmlinkage long sys_mq_setattr(mqd_t mqdes, const struct mq_attr __user *u_mqstat,
 	struct mq_attr __user *u_omqstat)
 {
 	int ret;
@@ -1192,6 +1212,220 @@
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+
+#include <linux/compat.h>
+
+struct compat_mq_attr {
+	u32	mq_flags;
+	s32	mq_maxmsg;
+	s32	mq_msgsize;
+	s32	mq_curmsgs;
+};
+
+static asmlinkage long load_mq_attr(struct mq_attr *attrp,
+		const struct compat_mq_attr __user *compat_attrp_user)
+{
+	struct compat_mq_attr compat_attr;
+
+	if (copy_from_user(&compat_attr, compat_attrp_user, sizeof(compat_attr))) {
+		return -EFAULT;
+	}
+	attrp->mq_flags = compat_attr.mq_flags;
+	attrp->mq_maxmsg = compat_attr.mq_maxmsg;
+	attrp->mq_msgsize = compat_attr.mq_msgsize;
+	attrp->mq_curmsgs = compat_attr.mq_curmsgs;
+	return 0;
+}
+
+static asmlinkage long store_mq_attr(struct compat_mq_attr __user *compat_attrp_user,
+		const struct mq_attr *attrp)
+{
+	struct compat_mq_attr compat_attr;
+
+	compat_attr.mq_flags = attrp->mq_flags;
+	compat_attr.mq_maxmsg = attrp->mq_maxmsg;
+	compat_attr.mq_msgsize = attrp->mq_msgsize;
+	compat_attr.mq_curmsgs = attrp->mq_curmsgs;
+
+	if (copy_to_user(compat_attrp_user, &compat_attr, sizeof(compat_attr))) {
+		return -EFAULT;
+	}
+	return 0;
+}
+
+asmlinkage long compat_sys_mq_open(const char __user *name_user, int oflag, mode_t mode,
+		struct compat_mq_attr __user *compat_attrp_user)
+{
+	char *name = NULL;
+	struct mq_attr attr, *attrp = NULL;
+	mm_segment_t oldfs;
+	long stat;
+
+	if (compat_attrp_user) {
+		attrp = &attr;
+		if (load_mq_attr(attrp, compat_attrp_user))
+			return -EFAULT;
+	}
+	if (name_user) {
+		name = getname(name_user);
+		if (IS_ERR(name)) {
+			return PTR_ERR(name);
+		}
+	}
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	stat = sys_mq_open(name, oflag, mode, attrp);
+	set_fs(oldfs);
+
+	if (name)
+		putname(name);
+	return stat;
+}
+
+asmlinkage long compat_sys_mq_getattr(mqd_t mqdes, struct compat_mq_attr __user *compat_attrp_user)
+{
+	struct mq_attr attr, *attrp = NULL;
+	mm_segment_t oldfs;
+	long stat;
+
+	if (compat_attrp_user) {
+		attrp = &attr;
+	}
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	stat = sys_mq_getattr(mqdes, attrp);
+	set_fs(oldfs);
+
+	if (!stat && compat_attrp_user) {
+		stat = store_mq_attr(compat_attrp_user, attrp);
+	}
+	return stat;
+}
+
+asmlinkage long compat_sys_mq_setattr(mqd_t mqdes,
+		const struct compat_mq_attr __user *compat_attrp_user,
+		struct compat_mq_attr __user *compat_oattrp_user)
+
+{
+	struct mq_attr attr, *attrp = NULL;
+	struct mq_attr oattr, *oattrp = NULL;
+	mm_segment_t oldfs;
+	long stat;
+
+	if (compat_attrp_user) {
+		attrp = &attr;
+		if (load_mq_attr(attrp, compat_attrp_user))
+			return -EFAULT;
+	}
+	if (compat_oattrp_user) {
+		oattrp = &oattr;
+	}
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	stat = sys_mq_setattr(mqdes, attrp, oattrp);
+	set_fs(oldfs);
+
+	if (!stat && compat_oattrp_user) {
+		stat = store_mq_attr(compat_oattrp_user, oattrp);
+	}
+	return stat;
+}
+
+asmlinkage long compat_sys_mq_timedsend(mqd_t mqdes, char __user *msgp_user, 
+		size_t msg_len, unsigned int msg_prio,
+		const struct compat_timespec __user *compat_abs_timeoutp_user)
+{
+	mm_segment_t oldfs;
+	struct timespec abs_timeout, *abs_timeoutp = NULL;
+	long timeout;
+
+	if (compat_abs_timeoutp_user) {
+		abs_timeoutp = &abs_timeout;
+		if (get_compat_timespec(&abs_timeout, compat_abs_timeoutp_user))
+			return -EFAULT;
+	}
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	timeout = prepare_timeout(abs_timeoutp);
+	set_fs(oldfs);
+
+	if (timeout < 0)
+		return timeout;
+
+	return do_mq_timedsend(mqdes, msgp_user, msg_len, msg_prio, timeout);
+}
+
+asmlinkage ssize_t compat_sys_mq_timedreceive(mqd_t mqdes, char __user *msgp_user, 
+		size_t msg_len, unsigned int __user *msg_priop_user,
+		const struct compat_timespec __user *compat_abs_timeoutp_user)
+{
+	mm_segment_t oldfs;
+	struct timespec abs_timeout, *abs_timeoutp = NULL;
+	long timeout;
+
+	if (compat_abs_timeoutp_user) {
+		abs_timeoutp = &abs_timeout;
+		if (get_compat_timespec(abs_timeoutp, compat_abs_timeoutp_user))
+			return -EFAULT;
+	}
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	timeout = prepare_timeout(abs_timeoutp);
+	set_fs(oldfs);
+
+	if (timeout < 0)
+		return timeout;
+
+	return do_mq_timedreceive(mqdes, msgp_user, msg_len, msg_priop_user, timeout);
+}
+
+struct compat_sigevent_partial {
+	s32	sigev_value;
+	u32	sigev_signo;
+	u32	sigev_notify;
+};
+
+static asmlinkage long get_sigevent_partial(struct sigevent *attrp,
+		const struct compat_sigevent_partial __user *compat_sigevent_partialp_user)
+{
+	struct compat_sigevent_partial compat_sigevent_partial;
+
+	if (copy_from_user(&compat_sigevent_partial, compat_sigevent_partialp_user,
+			sizeof(compat_sigevent_partial))) {
+		return -EFAULT;
+	}
+	attrp->sigev_value.sival_ptr = NULL; /* zero unused bits in union */
+	attrp->sigev_value.sival_int = compat_sigevent_partial.sigev_value;
+	attrp->sigev_signo = compat_sigevent_partial.sigev_signo;
+	attrp->sigev_notify = compat_sigevent_partial.sigev_notify;
+	return 0;
+}
+
+asmlinkage long compat_sys_mq_notify(mqd_t mqdes,
+		const struct compat_sigevent_partial __user *notifyp_user)
+{
+	long stat;
+	struct sigevent notify, *notifyp = NULL;
+	mm_segment_t oldfs;
+
+	if (notifyp_user) {
+		notifyp = &notify;
+		if (get_sigevent_partial(notifyp, notifyp_user))
+			return -EFAULT;
+	}
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	stat = sys_mq_notify(mqdes, notifyp);
+	set_fs(oldfs);
+
+	return stat;
+}
+
+#endif
 
 static struct inode_operations mqueue_dir_inode_operations = {
 	.lookup = mqueue_lookup,
diff -ura 4.00/kernel/compat.c new/kernel/compat.c
--- 4.00/kernel/compat.c	2003-10-25 14:43:40.000000000 -0400
+++ new/kernel/compat.c	2003-11-20 10:41:50.000000000 -0500
@@ -22,14 +22,14 @@
 
 #include <asm/uaccess.h>
 
-int get_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
+int get_compat_timespec(struct timespec *ts, const struct compat_timespec *cts)
 {
 	return (verify_area(VERIFY_READ, cts, sizeof(*cts)) ||
 			__get_user(ts->tv_sec, &cts->tv_sec) ||
 			__get_user(ts->tv_nsec, &cts->tv_nsec)) ? -EFAULT : 0;
 }
 
-int put_compat_timespec(struct timespec *ts, struct compat_timespec *cts)
+int put_compat_timespec(struct timespec *ts, const struct compat_timespec *cts)
 {
 	return (verify_area(VERIFY_WRITE, cts, sizeof(*cts)) ||
 			__put_user(ts->tv_sec, &cts->tv_sec) ||
