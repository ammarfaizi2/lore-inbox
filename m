Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTBJDds>; Sun, 9 Feb 2003 22:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbTBJDds>; Sun, 9 Feb 2003 22:33:48 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:20181 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S261451AbTBJDdd>;
	Sun, 9 Feb 2003 22:33:33 -0500
Date: Mon, 10 Feb 2003 14:41:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, matthew@wil.cx,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][COMPAT] compat_sys_futex
Message-Id: <20030210144140.1f7cba27.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch adds compat_sys_futex.  It also changes the first paramter
of sys_sutex to "u32 *" after discussions with Rusty and yourself.

I have put all the architecture changes in this same patch as they
are both obvious and small.  MIPS64 is absent because 32 bit MIPS does
not implement sys_futex.

This is relative to my previous patches but applies to recent 2.5.59 BK
trees - except for arch/x86_64/ia32/sys_ia32.c, but this part of the
patch is merely removing the current sys32_futex code.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.59-200302101308-32bit.1/arch/ia64/ia32/ia32_entry.S 2.5.59-200302101308-32bit.2/arch/ia64/ia32/ia32_entry.S
--- 2.5.59-200302101308-32bit.1/arch/ia64/ia32/ia32_entry.S	2003-02-10 13:35:50.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/arch/ia64/ia32/ia32_entry.S	2003-02-10 14:17:36.000000000 +1100
@@ -428,6 +428,26 @@
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
+	data8 sys_ni_syscall	/* 230 */
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall	/* 235 */
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 compat_sys_futex	/* 240 */
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall	/* 245 */
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
+	data8 sys_ni_syscall
 	/*
 	 *  CAUTION: If any system calls are added beyond this point
 	 *	then the check in `arch/ia64/kernel/ivt.S' will have
diff -ruN 2.5.59-200302101308-32bit.1/arch/ia64/kernel/ivt.S 2.5.59-200302101308-32bit.2/arch/ia64/kernel/ivt.S
--- 2.5.59-200302101308-32bit.1/arch/ia64/kernel/ivt.S	2003-02-10 13:35:51.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/arch/ia64/kernel/ivt.S	2003-02-10 14:18:47.000000000 +1100
@@ -848,7 +848,7 @@
 	alloc r15=ar.pfs,0,0,6,0	// must first in an insn group
 	;;
 	ld4 r8=[r14],8		// r8 == eax (syscall number)
-	mov r15=230		// number of entries in ia32 system call table
+	mov r15=250		// number of entries in ia32 system call table
 	;;
 	cmp.ltu.unc p6,p7=r8,r15
 	ld4 out1=[r14],8	// r9 == ecx
diff -ruN 2.5.59-200302101308-32bit.1/arch/parisc/kernel/syscall.S 2.5.59-200302101308-32bit.2/arch/parisc/kernel/syscall.S
--- 2.5.59-200302101308-32bit.1/arch/parisc/kernel/syscall.S	2003-02-10 13:35:53.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/arch/parisc/kernel/syscall.S	2003-02-05 17:51:22.000000000 +1100
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
diff -ruN 2.5.59-200302101308-32bit.1/arch/ppc64/kernel/misc.S 2.5.59-200302101308-32bit.2/arch/ppc64/kernel/misc.S
--- 2.5.59-200302101308-32bit.1/arch/ppc64/kernel/misc.S	2003-02-10 13:35:53.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/arch/ppc64/kernel/misc.S	2003-02-10 14:29:05.000000000 +1100
@@ -724,7 +724,7 @@
 	.llong .sys_removexattr
 	.llong .sys_lremovexattr
 	.llong .sys_fremovexattr	/* 220 */
-	.llong .sys_futex
+	.llong .compat_sys_futex
 	.llong .sys32_sched_setaffinity
 	.llong .sys32_sched_getaffinity
 	.llong .sys_ni_syscall
diff -ruN 2.5.59-200302101308-32bit.1/arch/s390x/kernel/entry.S 2.5.59-200302101308-32bit.2/arch/s390x/kernel/entry.S
--- 2.5.59-200302101308-32bit.1/arch/s390x/kernel/entry.S	2003-01-17 14:01:01.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/arch/s390x/kernel/entry.S	2003-01-30 14:02:09.000000000 +1100
@@ -629,7 +629,7 @@
 	.long  SYSCALL(sys_fremovexattr,sys32_fremovexattr_wrapper) /* 235 */
 	.long  SYSCALL(sys_gettid,sys_gettid)
 	.long  SYSCALL(sys_tkill,sys_tkill)
-	.long  SYSCALL(sys_futex,sys32_futex_wrapper)
+	.long  SYSCALL(sys_futex,compat_sys_futex_wrapper)
 	.long  SYSCALL(sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
 	.long  SYSCALL(sys_sched_getaffinity,sys32_sched_getaffinity_wrapper) /* 240 */
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
diff -ruN 2.5.59-200302101308-32bit.1/arch/s390x/kernel/linux32.c 2.5.59-200302101308-32bit.2/arch/s390x/kernel/linux32.c
--- 2.5.59-200302101308-32bit.1/arch/s390x/kernel/linux32.c	2003-02-10 13:35:54.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/arch/s390x/kernel/linux32.c	2003-02-10 14:19:54.000000000 +1100
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
diff -ruN 2.5.59-200302101308-32bit.1/arch/s390x/kernel/wrapper32.S 2.5.59-200302101308-32bit.2/arch/s390x/kernel/wrapper32.S
--- 2.5.59-200302101308-32bit.1/arch/s390x/kernel/wrapper32.S	2003-01-17 14:01:01.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/arch/s390x/kernel/wrapper32.S	2003-02-10 14:25:22.000000000 +1100
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
diff -ruN 2.5.59-200302101308-32bit.1/arch/sparc64/kernel/systbls.S 2.5.59-200302101308-32bit.2/arch/sparc64/kernel/systbls.S
--- 2.5.59-200302101308-32bit.1/arch/sparc64/kernel/systbls.S	2003-02-05 17:31:26.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/arch/sparc64/kernel/systbls.S	2003-02-10 14:31:13.000000000 +1100
@@ -47,7 +47,7 @@
 	.word sys_nis_syscall, sys32_setreuid16, sys32_setregid16, sys_rename, sys_truncate
 /*130*/	.word sys_ftruncate, sys_flock, sys_lstat64, sys_nis_syscall, sys_nis_syscall
 	.word sys_nis_syscall, sys_mkdir, sys_rmdir, sys32_utimes, sys_stat64
-/*140*/	.word sys32_sendfile64, sys_nis_syscall, sys_futex, sys_gettid, sys32_getrlimit
+/*140*/	.word sys32_sendfile64, sys_nis_syscall, compat_sys_futex, sys_gettid, sys32_getrlimit
 	.word sys32_setrlimit, sys_pivot_root, sys32_prctl, sys32_pciconfig_read, sys32_pciconfig_write
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
 	.word sys32_fcntl64, sys_ni_syscall, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
diff -ruN 2.5.59-200302101308-32bit.1/arch/x86_64/ia32/ia32entry.S 2.5.59-200302101308-32bit.2/arch/x86_64/ia32/ia32entry.S
--- 2.5.59-200302101308-32bit.1/arch/x86_64/ia32/ia32entry.S	2003-01-17 14:15:58.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/arch/x86_64/ia32/ia32entry.S	2003-01-30 14:03:39.000000000 +1100
@@ -440,7 +440,7 @@
 	.quad sys_fremovexattr
 	.quad sys_tkill		/* 238 */ 
 	.quad sys_sendfile64 
-	.quad sys32_futex		/* 240 */
+	.quad compay_sys_futex		/* 240 */
         .quad sys32_sched_setaffinity
         .quad sys32_sched_getaffinity
 	.quad sys_set_thread_area
diff -ruN 2.5.59-200302101308-32bit.1/arch/x86_64/ia32/sys_ia32.c 2.5.59-200302101308-32bit.2/arch/x86_64/ia32/sys_ia32.c
--- 2.5.59-200302101308-32bit.1/arch/x86_64/ia32/sys_ia32.c	2003-01-17 14:15:58.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/arch/x86_64/ia32/sys_ia32.c	2003-01-30 14:04:43.000000000 +1100
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
diff -ruN 2.5.59-200302101308-32bit.1/kernel/compat.c 2.5.59-200302101308-32bit.2/kernel/compat.c
--- 2.5.59-200302101308-32bit.1/kernel/compat.c	2003-01-17 14:01:08.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/kernel/compat.c	2003-02-07 14:32:54.000000000 +1100
@@ -208,3 +208,19 @@
 		ret = put_user(s, oset);
 	return ret;
 }
+
+extern long do_futex(u32 *, int, int, struct timespec *);
+
+asmlinkage long compat_sys_futex(u32 *uaddr, int op, int val,
+		struct compat_timespec *ct)
+{
+	struct timespec *ts = NULL;
+	struct timespec t;
+
+	if ((op == FUTEX_WAIT) && ct) {
+		if (get_compat_timespec(&t, ct))
+			return -EFAULT;
+		ts = &t;
+	}
+	return do_futex((unsigned long)uaddr, op, val, ts);
+}
diff -ruN 2.5.59-200302101308-32bit.1/kernel/futex.c 2.5.59-200302101308-32bit.2/kernel/futex.c
--- 2.5.59-200302101308-32bit.1/kernel/futex.c	2002-11-28 10:34:59.000000000 +1100
+++ 2.5.59-200302101308-32bit.2/kernel/futex.c	2003-02-07 14:32:46.000000000 +1100
@@ -318,17 +318,12 @@
 static inline int futex_wait_utime(unsigned long uaddr,
 		      int offset,
 		      int val,
-		      struct timespec* utime)
+		      struct timespec* ts)
 {
 	unsigned long time = MAX_SCHEDULE_TIMEOUT;
 
-	if (utime) {
-		struct timespec t;
-		if (copy_from_user(&t, utime, sizeof(t)) != 0)
-			return -EFAULT;
-		time = timespec_to_jiffies(&t) + 1;
-	}
-
+	if (ts)
+		time = timespec_to_jiffies(ts) + 1;
 	return futex_wait(uaddr, offset, val, time);
 }
 
@@ -437,7 +432,7 @@
 	return ret;
 }
 
-asmlinkage int sys_futex(unsigned long uaddr, int op, int val, struct timespec *utime)
+long do_futex(unsigned long uaddr, int op, int val, struct timespec *ts)
 {
 	unsigned long pos_in_page;
 	int ret;
@@ -445,12 +440,12 @@
 	pos_in_page = uaddr % PAGE_SIZE;
 
 	/* Must be "naturally" aligned */
-	if (pos_in_page % sizeof(int))
+	if (pos_in_page % sizeof(u32))
 		return -EINVAL;
 
 	switch (op) {
 	case FUTEX_WAIT:
-		ret = futex_wait_utime(uaddr, pos_in_page, val, utime);
+		ret = futex_wait_utime(uaddr, pos_in_page, val, ts);
 		break;
 	case FUTEX_WAKE:
 		ret = futex_wake(uaddr, pos_in_page, val);
@@ -465,6 +460,19 @@
 	return ret;
 }
 
+asmlinkage long sys_futex(u32 *uaddr, int op, int val, struct timespec *utime)
+{
+	struct timespec *ts = NULL;
+	struct timespec t;
+
+	if ((op == FUTEX_WAIT) && utime) {
+		if (copy_from_user(&t, utime, sizeof(t)) != 0)
+			return -EFAULT;
+		ts = &t;
+	}
+	return do_futex((unsigned long)uaddr, op, val, ts);
+}
+
 static struct super_block *
 futexfs_get_sb(struct file_system_type *fs_type,
 	       int flags, char *dev_name, void *data)
