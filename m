Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262380AbTBONnT>; Sat, 15 Feb 2003 08:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTBONnT>; Sat, 15 Feb 2003 08:43:19 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:4074 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262380AbTBONnN>;
	Sat, 15 Feb 2003 08:43:13 -0500
Date: Sun, 16 Feb 2003 00:51:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, davem@redhat.com, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx
Subject: [PATCH][COMPAT] compat_sys_futex 1/3 generic, parisc, ppc64, s390x
 and x86_64
Message-Id: <20030216005159.16557e36.sfr@canb.auug.org.au>
In-Reply-To: <20030212154716.7c101942.sfr@canb.auug.org.au>
References: <20030212154716.7c101942.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Wed, 12 Feb 2003 15:47:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> This patch creates compat_sys_futex and changes the 64 bit architextures
> to use it.  This also changes sys_futex to take a "u32 *" as its first
> argument as discussed with Rusty and yourself.
> 
> There is no mip64 part as the mips port currently does not support
> sys_futex.

This is now against 2.5.61.

I should also mention that this patch actually gives ia64 a 32 bit
compatibility implimentation of sys_futex where one did not exist before.

And for parisc, ppc64, sparc64 this is a bug fix as previously they used
the 64 bit version for the 32 bit compatibility version.

This is the generic part of the patch and the architecture specific parts
I have been asked to forward directly to you.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.61-32bit.1/include/linux/futex.h 2.5.61-32bit.2/include/linux/futex.h
--- 2.5.61-32bit.1/include/linux/futex.h	2002-10-01 12:30:40.000000000 +1000
+++ 2.5.61-32bit.2/include/linux/futex.h	2003-02-16 00:16:19.000000000 +1100
@@ -6,6 +6,6 @@
 #define FUTEX_WAKE (1)
 #define FUTEX_FD (2)
 
-extern asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime);
+extern asmlinkage long sys_futex(u32 *uaddr, int op, int val, struct timespec *utime);
 
 #endif
diff -ruN 2.5.61-32bit.1/kernel/compat.c 2.5.61-32bit.2/kernel/compat.c
--- 2.5.61-32bit.1/kernel/compat.c	2003-01-17 14:01:08.000000000 +1100
+++ 2.5.61-32bit.2/kernel/compat.c	2003-02-15 23:39:48.000000000 +1100
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/time.h>
 #include <linux/signal.h>
+#include <linux/sched.h>	/* for MAX_SCHEDULE_TIMEOUT */
 
 #include <asm/uaccess.h>
 
@@ -208,3 +209,19 @@
 		ret = put_user(s, oset);
 	return ret;
 }
+
+extern long do_futex(u32 *, int, int, unsigned long);
+
+asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
+		struct compat_timespec *utime)
+{
+	struct timespec t;
+	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
+
+	if ((op == FUTEX_WAIT) && utime) {
+		if (get_compat_timespec(&t, utime))
+			return -EFAULT;
+		timeout = timespec_to_jiffies(t) + 1;
+	}
+	return do_futex((unsigned long)uaddr, op, val, timeout);
+}
diff -ruN 2.5.61-32bit.1/kernel/futex.c 2.5.61-32bit.2/kernel/futex.c
--- 2.5.61-32bit.1/kernel/futex.c	2002-11-28 10:34:59.000000000 +1100
+++ 2.5.61-32bit.2/kernel/futex.c	2003-02-15 23:39:48.000000000 +1100
@@ -315,23 +315,6 @@
 	return ret;
 }
 
-static inline int futex_wait_utime(unsigned long uaddr,
-		      int offset,
-		      int val,
-		      struct timespec* utime)
-{
-	unsigned long time = MAX_SCHEDULE_TIMEOUT;
-
-	if (utime) {
-		struct timespec t;
-		if (copy_from_user(&t, utime, sizeof(t)) != 0)
-			return -EFAULT;
-		time = timespec_to_jiffies(&t) + 1;
-	}
-
-	return futex_wait(uaddr, offset, val, time);
-}
-
 static int futex_close(struct inode *inode, struct file *filp)
 {
 	struct futex_q *q = filp->private_data;
@@ -437,7 +420,7 @@
 	return ret;
 }
 
-asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime)
+long do_futex(unsigned long uaddr, int op, int val, unsinged long timeout)
 {
 	unsigned long pos_in_page;
 	int ret;
@@ -445,12 +428,12 @@
 	pos_in_page = uaddr % PAGE_SIZE;
 
 	/* Must be "naturally" aligned */
-	if (pos_in_page % sizeof(int))
+	if (pos_in_page % sizeof(u32))
 		return -EINVAL;
 
 	switch (op) {
 	case FUTEX_WAIT:
-		ret = futex_wait_utime(uaddr, pos_in_page, val, utime);
+		ret = futex_wait(uaddr, pos_in_page, val, timeout);
 		break;
 	case FUTEX_WAKE:
 		ret = futex_wake(uaddr, pos_in_page, val);
@@ -465,6 +448,20 @@
 	return ret;
 }
 
+asmlinkage long sys_futex(u32 *uaddr, int op, int val, struct timespec *utime)
+{
+	struct timespec t;
+	unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
+
+
+	if ((op == FUTEX_WAIT) && utime) {
+		if (copy_from_user(&t, utime, sizeof(t)) != 0)
+			return -EFAULT;
+		timeout = timespec_to_jiffies(t) + 1;
+	}
+	return do_futex((unsigned long)uaddr, op, val, timeout);
+}
+
 static struct super_block *
 futexfs_get_sb(struct file_system_type *fs_type,
 	       int flags, char *dev_name, void *data)
diff -ruN 2.5.61-32bit.1/arch/parisc/kernel/syscall.S 2.5.61-32bit.2/arch/parisc/kernel/syscall.S
--- 2.5.61-32bit.1/arch/parisc/kernel/syscall.S	2003-02-11 09:39:14.000000000 +1100
+++ 2.5.61-32bit.2/arch/parisc/kernel/syscall.S	2003-02-15 23:39:48.000000000 +1100
@@ -320,7 +320,8 @@
 #ifdef __LP64__
 /* Use ENTRY_SAME for 32-bit syscalls which are the same on wide and
  * narrow palinux.  Use ENTRY_DIFF for those where a 32-bit specific
- * implementation is required on wide palinux.
+ * implementation is required on wide palinux.  Use ENTRY_COMP where
+ * the compatability layer has a useful 32-bit implementation.
  */
 #define ENTRY_SAME(_name_) .dword sys_##_name_
 #define ENTRY_DIFF(_name_) .dword sys32_##_name_
@@ -597,7 +598,7 @@
 	ENTRY_SAME(ni_syscall)		/* tkill */
 
 	ENTRY_SAME(sendfile64)
-	ENTRY_SAME(futex)		/* 210 */
+	ENTRY_COMP(futex)		/* 210 */
 	ENTRY_SAME(sched_setaffinity)
 	ENTRY_SAME(sched_getaffinity)
 	ENTRY_SAME(set_thread_area)
diff -ruN 2.5.61-32bit.1/arch/ppc64/kernel/misc.S 2.5.61-32bit.2/arch/ppc64/kernel/misc.S
--- 2.5.61-32bit.1/arch/ppc64/kernel/misc.S	2003-02-11 09:39:15.000000000 +1100
+++ 2.5.61-32bit.2/arch/ppc64/kernel/misc.S	2003-02-15 23:39:48.000000000 +1100
@@ -724,7 +724,7 @@
 	.llong .sys_removexattr
 	.llong .sys_lremovexattr
 	.llong .sys_fremovexattr	/* 220 */
-	.llong .sys_futex
+	.llong .compat_sys_futex
 	.llong .sys32_sched_setaffinity
 	.llong .sys32_sched_getaffinity
 	.llong .sys_ni_syscall
diff -ruN 2.5.61-32bit.1/arch/s390x/kernel/entry.S 2.5.61-32bit.2/arch/s390x/kernel/entry.S
--- 2.5.61-32bit.1/arch/s390x/kernel/entry.S	2003-01-17 14:01:01.000000000 +1100
+++ 2.5.61-32bit.2/arch/s390x/kernel/entry.S	2003-02-15 23:39:48.000000000 +1100
@@ -629,7 +629,7 @@
 	.long  SYSCALL(sys_fremovexattr,sys32_fremovexattr_wrapper) /* 235 */
 	.long  SYSCALL(sys_gettid,sys_gettid)
 	.long  SYSCALL(sys_tkill,sys_tkill)
-	.long  SYSCALL(sys_futex,sys32_futex_wrapper)
+	.long  SYSCALL(sys_futex,compat_sys_futex_wrapper)
 	.long  SYSCALL(sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
 	.long  SYSCALL(sys_sched_getaffinity,sys32_sched_getaffinity_wrapper) /* 240 */
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
diff -ruN 2.5.61-32bit.1/arch/s390x/kernel/linux32.c 2.5.61-32bit.2/arch/s390x/kernel/linux32.c
--- 2.5.61-32bit.1/arch/s390x/kernel/linux32.c	2003-02-15 23:19:37.000000000 +1100
+++ 2.5.61-32bit.2/arch/s390x/kernel/linux32.c	2003-02-15 23:39:48.000000000 +1100
@@ -4049,28 +4049,6 @@
 	return ret;
 }
 
-asmlinkage int 
-sys_futex(void *uaddr, int op, int val, struct timespec *utime);
-
-asmlinkage int
-sys32_futex(void *uaddr, int op, int val, 
-		 struct compat_timespec *timeout32)
-{
-	struct timespec tmp;
-	mm_segment_t old_fs;
-	int ret;
-
-	if (timeout32 && get_compat_timespec(&tmp, timeout32))
-		return -EINVAL;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_futex(uaddr, op, val, timeout32 ? &tmp : NULL);
-	set_fs(old_fs);
-
-	return ret;
-}
-
 asmlinkage ssize_t sys_read(unsigned int fd, char * buf, size_t count);
 
 asmlinkage compat_ssize_t sys32_read(unsigned int fd, char * buf, size_t count)
diff -ruN 2.5.61-32bit.1/arch/s390x/kernel/wrapper32.S 2.5.61-32bit.2/arch/s390x/kernel/wrapper32.S
--- 2.5.61-32bit.1/arch/s390x/kernel/wrapper32.S	2003-01-17 14:01:01.000000000 +1100
+++ 2.5.61-32bit.2/arch/s390x/kernel/wrapper32.S	2003-02-15 23:39:48.000000000 +1100
@@ -1088,13 +1088,13 @@
 	llgfr	%r4,%r4			# long
 	jg	sys32_fstat64		# branch to system call
 
-	.globl  sys32_futex_wrapper 
-sys32_futex_wrapper:
-	llgtr	%r2,%r2			# void *
+	.globl  compat_sys_futex_wrapper 
+compat_sys_futex_wrapper:
+	llgtr	%r2,%r2			# u32 *
 	lgfr	%r3,%r3			# int
 	lgfr	%r4,%r4			# int
-	llgtr	%r5,%r5			# struct timespec *
-	jg	sys32_futex		# branch to system call
+	llgtr	%r5,%r5			# struct compat_timespec *
+	jg	compat_sys_futex	# branch to system call
 
 	.globl	sys32_setxattr_wrapper
 sys32_setxattr_wrapper:
diff -ruN 2.5.61-32bit.1/arch/x86_64/ia32/ia32entry.S 2.5.61-32bit.2/arch/x86_64/ia32/ia32entry.S
--- 2.5.61-32bit.1/arch/x86_64/ia32/ia32entry.S	2003-02-15 23:19:38.000000000 +1100
+++ 2.5.61-32bit.2/arch/x86_64/ia32/ia32entry.S	2003-02-15 23:39:48.000000000 +1100
@@ -440,7 +440,7 @@
 	.quad sys_fremovexattr
 	.quad sys_tkill		/* 238 */ 
 	.quad sys_sendfile64 
-	.quad sys32_futex		/* 240 */
+	.quad compat_sys_futex		/* 240 */
         .quad sys32_sched_setaffinity
         .quad sys32_sched_getaffinity
 	.quad sys_set_thread_area
diff -ruN 2.5.61-32bit.1/arch/x86_64/ia32/sys_ia32.c 2.5.61-32bit.2/arch/x86_64/ia32/sys_ia32.c
--- 2.5.61-32bit.1/arch/x86_64/ia32/sys_ia32.c	2003-02-15 23:19:38.000000000 +1100
+++ 2.5.61-32bit.2/arch/x86_64/ia32/sys_ia32.c	2003-02-15 23:39:48.000000000 +1100
@@ -2199,26 +2199,6 @@
 	return err;
 }
 
-extern int sys_futex(unsigned long uaddr, int op, int val, struct timespec *t); 
-
-asmlinkage long
-sys32_futex(unsigned long uaddr, int op, int val, struct compat_timespec *utime32)
-{
-	struct timespec t;
-	mm_segment_t oldfs = get_fs(); 
-	int err;
-
-	if (utime32 && get_compat_timespec(&t, utime32))
-		return -EFAULT;
-
-	/* the set_fs is safe because futex doesn't use the seg limit 
-	   for valid page checking of uaddr. */ 
-	set_fs(KERNEL_DS); 
-	err = sys_futex(uaddr, op, val, utime32 ? &t : NULL);
-	set_fs(oldfs); 
-	return err; 
-}
-
 extern long sys_io_setup(unsigned nr_reqs, aio_context_t *ctx);
 
 long sys32_io_setup(unsigned nr_reqs, u32 *ctx32p)
