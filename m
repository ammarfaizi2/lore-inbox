Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTDLWqI (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 18:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTDLWqI (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 18:46:08 -0400
Received: from gandalf.tausq.org ([64.81.244.94]:16018 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S261427AbTDLWqA (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 18:46:00 -0400
Date: Sat, 12 Apr 2003 15:56:38 -0700
From: Randolph Chung <randolph@tausq.org>
To: Anton Blanchard <anton@samba.org>
Cc: Randolph Chung <tausq@parisc-linux.org>, Linus <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][COMPAT] {get,set}affinity unification
Message-ID: <20030412225638.GA20090@tausq.org>
Reply-To: Randolph Chung <randolph@tausq.org>
References: <20030411062110.GS12993@tausq.org> <20030411171506.GA657@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411171506.GA657@krispykreme>
X-PGP: for PGP key, see http://www.tausq.org/pgp.txt
X-GPG: for GPG key, see http://www.tausq.org/gpg.txt
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We should really return sizeof(compat_ulong_t) here. Can you check over
> the ppc64 and sparc64 versions of these, I think there are some other
> problems (getaffinity returns > 0 on success but you check for 0).

Here's an updated patch. Thanks for catching these errors....  I had
three sys32_* implementations to choose from and i picked the wrong one
:-)

randolph
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/


Index: arch/ia64/ia32/ia32_entry.S
===================================================================
RCS file: /var/cvs/linux-2.5/arch/ia64/ia32/ia32_entry.S,v
retrieving revision 1.5
diff -u -p -r1.5 ia32_entry.S
--- linux-2.5.67/arch/ia64/ia32/ia32_entry.S	18 Mar 2003 00:56:28 -0000	1.5
+++ linux-new/arch/ia64/ia32/ia32_entry.S	11 Apr 2003 06:06:36 -0000
@@ -439,8 +439,8 @@ ia32_syscall_table:
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 compat_sys_futex	/* 240 */
-	data8 sys_ni_syscall
-	data8 sys_ni_syscall
+	data8 compat_sys_setaffinity
+	data8 compat_sys_getaffinity
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall
 	data8 sys_ni_syscall	/* 245 */
Index: arch/parisc/kernel/syscall.S
===================================================================
RCS file: /var/cvs/linux-2.5/arch/parisc/kernel/syscall.S,v
retrieving revision 1.28
diff -u -p -r1.28 syscall.S
--- linux-2.5.67/arch/parisc/kernel/syscall.S	11 Apr 2003 05:29:34 -0000	1.28
+++ linux-new/arch/parisc/kernel/syscall.S	11 Apr 2003 06:06:37 -0000
@@ -598,8 +598,8 @@ sys_call_table:
 
 	ENTRY_SAME(sendfile64)
 	ENTRY_COMP(futex)		/* 210 */
-	ENTRY_SAME(sched_setaffinity)
-	ENTRY_SAME(sched_getaffinity)
+	ENTRY_COMP(sched_setaffinity)
+	ENTRY_COMP(sched_getaffinity)
 	ENTRY_SAME(ni_syscall)
 	ENTRY_SAME(ni_syscall)
 	ENTRY_SAME(io_setup)		/* 215 */
Index: arch/ppc64/kernel/misc.S
===================================================================
RCS file: /var/cvs/linux-2.5/arch/ppc64/kernel/misc.S,v
retrieving revision 1.16
diff -u -p -r1.16 misc.S
--- linux-2.5.67/arch/ppc64/kernel/misc.S	11 Apr 2003 05:29:34 -0000	1.16
+++ linux-new/arch/ppc64/kernel/misc.S	11 Apr 2003 06:06:37 -0000
@@ -724,8 +724,8 @@ _GLOBAL(sys_call_table32)
 	.llong .sys_lremovexattr
 	.llong .sys_fremovexattr	/* 220 */
 	.llong .compat_sys_futex
-	.llong .sys32_sched_setaffinity
-	.llong .sys32_sched_getaffinity
+	.llong .compat_sys_sched_setaffinity
+	.llong .compat_sys_sched_getaffinity
 	.llong .sys_ni_syscall
 	.llong .sys_ni_syscall		/* 225 - reserved for tux */
 	.llong .sys32_sendfile64
Index: arch/ppc64/kernel/sys_ppc32.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/ppc64/kernel/sys_ppc32.c,v
retrieving revision 1.17
diff -u -p -r1.17 sys_ppc32.c
--- linux-2.5.67/arch/ppc64/kernel/sys_ppc32.c	11 Apr 2003 05:29:34 -0000	1.17
+++ linux-new/arch/ppc64/kernel/sys_ppc32.c	11 Apr 2003 06:06:37 -0000
@@ -2606,56 +2606,6 @@ asmlinkage long sys32_time(compat_time_t
 	return secs;
 }
 
-extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
-					    unsigned long *user_mask_ptr);
-
-asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
-				       u32 *user_mask_ptr)
-{
-	unsigned long kernel_mask;
-	mm_segment_t old_fs;
-	int ret;
-
-	if (get_user(kernel_mask, user_mask_ptr))
-		return -EFAULT;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_sched_setaffinity(pid,
-				    /* XXX Nice api... */
-				    sizeof(kernel_mask),
-				    &kernel_mask);
-	set_fs(old_fs);
-
-	return ret;
-}
-
-extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
-					    unsigned long *user_mask_ptr);
-
-asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
-				       u32 *user_mask_ptr)
-{
-	unsigned long kernel_mask;
-	mm_segment_t old_fs;
-	int ret;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_sched_getaffinity(pid,
-				    /* XXX Nice api... */
-				    sizeof(kernel_mask),
-				    &kernel_mask);
-	set_fs(old_fs);
-
-	if (ret > 0) {
-		if (put_user(kernel_mask, user_mask_ptr))
-			ret = -EFAULT;
-	}
-
-	return ret;
-}
-
 int sys32_olduname(struct oldold_utsname * name)
 {
 	int error;
Index: arch/s390x/kernel/entry.S
===================================================================
RCS file: /var/cvs/linux-2.5/arch/s390x/kernel/entry.S,v
retrieving revision 1.13
diff -u -p -r1.13 entry.S
--- linux-2.5.67/arch/s390x/kernel/entry.S	11 Apr 2003 05:29:34 -0000	1.13
+++ linux-new/arch/s390x/kernel/entry.S	11 Apr 2003 06:06:37 -0000
@@ -636,8 +636,8 @@ sys_call_table:
 	.long  SYSCALL(sys_gettid,sys_gettid)
 	.long  SYSCALL(sys_tkill,sys_tkill)
 	.long  SYSCALL(sys_futex,compat_sys_futex_wrapper)
-	.long  SYSCALL(sys_sched_setaffinity,sys32_sched_setaffinity_wrapper)
-	.long  SYSCALL(sys_sched_getaffinity,sys32_sched_getaffinity_wrapper) /* 240 */
+	.long  SYSCALL(sys_sched_setaffinity,compat_sys_sched_setaffinity_wrapper)
+	.long  SYSCALL(sys_sched_getaffinity,compat_sys_sched_getaffinity_wrapper) /* 240 */
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall)
 	.long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* reserved for TUX */
 	.long  SYSCALL(sys_io_setup,sys_ni_syscall)
Index: arch/s390x/kernel/linux32.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/s390x/kernel/linux32.c,v
retrieving revision 1.18
diff -u -p -r1.18 linux32.c
--- linux-2.5.67/arch/s390x/kernel/linux32.c	11 Apr 2003 05:29:34 -0000	1.18
+++ linux-new/arch/s390x/kernel/linux32.c	11 Apr 2003 06:06:37 -0000
@@ -2674,56 +2674,6 @@ out:
 	return error;
 }
 
-extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
-					    unsigned long *user_mask_ptr);
-
-asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
-				       u32 *user_mask_ptr)
-{
-	unsigned long kernel_mask;
-	mm_segment_t old_fs;
-	int ret;
-
-	if (get_user(kernel_mask, user_mask_ptr))
-		return -EFAULT;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_sched_setaffinity(pid,
-				    /* XXX Nice api... */
-				    sizeof(kernel_mask),
-				    &kernel_mask);
-	set_fs(old_fs);
-
-	return ret;
-}
-
-extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
-					    unsigned long *user_mask_ptr);
-
-asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
-				       u32 *user_mask_ptr)
-{
-	unsigned long kernel_mask;
-	mm_segment_t old_fs;
-	int ret;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_sched_getaffinity(pid,
-				    /* XXX Nice api... */
-				    sizeof(kernel_mask),
-				    &kernel_mask);
-	set_fs(old_fs);
-
-	if (ret == 0) {
-		if (put_user(kernel_mask, user_mask_ptr))
-			ret = -EFAULT;
-	}
-
-	return ret;
-}
-
 asmlinkage ssize_t sys_read(unsigned int fd, char * buf, size_t count);
 
 asmlinkage compat_ssize_t sys32_read(unsigned int fd, char * buf, size_t count)
Index: arch/s390x/kernel/wrapper32.S
===================================================================
RCS file: /var/cvs/linux-2.5/arch/s390x/kernel/wrapper32.S,v
retrieving revision 1.11
diff -u -p -r1.11 wrapper32.S
--- linux-2.5.67/arch/s390x/kernel/wrapper32.S	11 Apr 2003 05:29:34 -0000	1.11
+++ linux-new/arch/s390x/kernel/wrapper32.S	11 Apr 2003 06:06:37 -0000
@@ -1186,19 +1186,19 @@ sys32_fremovexattr_wrapper:
 	llgtr	%r3,%r3			# char *
 	jg	sys_fremovexattr
 
-	.globl	sys32_sched_setaffinity_wrapper
-sys32_sched_setaffinity_wrapper:
+	.globl	compat_sys_sched_setaffinity_wrapper
+compat_sys_sched_setaffinity_wrapper:
 	lgfr	%r2,%r2			# int
 	llgfr	%r3,%r3			# unsigned int
 	llgtr	%r4,%r4			# unsigned long *
-	jg	sys32_sched_setaffinity
+	jg	compat_sys_sched_setaffinity
 
-	.globl	sys32_sched_getaffinity_wrapper
-sys32_sched_getaffinity_wrapper:
+	.globl	compat_sys_sched_getaffinity_wrapper
+compat_sys_sched_getaffinity_wrapper:
 	lgfr	%r2,%r2			# int
 	llgfr	%r3,%r3			# unsigned int
 	llgtr	%r4,%r4			# unsigned long *
-	jg	sys32_sched_getaffinity
+	jg	compat_sys_sched_getaffinity
 
 	.globl  sys32_exit_group_wrapper
 sys32_exit_group_wrapper:
Index: arch/sparc64/kernel/sys_sparc32.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/sparc64/kernel/sys_sparc32.c,v
retrieving revision 1.21
diff -u -p -r1.21 sys_sparc32.c
--- linux-2.5.67/arch/sparc64/kernel/sys_sparc32.c	11 Apr 2003 05:29:34 -0000	1.21
+++ linux-new/arch/sparc64/kernel/sys_sparc32.c	11 Apr 2003 06:06:37 -0000
@@ -2704,56 +2704,6 @@ asmlinkage long sys32_sysctl(struct __sy
 	return error;
 }
 
-extern asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
-					    unsigned long *user_mask_ptr);
-
-asmlinkage int sys32_sched_setaffinity(compat_pid_t pid, unsigned int len,
-				       u32 *user_mask_ptr)
-{
-	unsigned long kernel_mask;
-	mm_segment_t old_fs;
-	int ret;
-
-	if (get_user(kernel_mask, user_mask_ptr))
-		return -EFAULT;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_sched_setaffinity(pid,
-				    /* XXX Nice api... */
-				    sizeof(kernel_mask),
-				    &kernel_mask);
-	set_fs(old_fs);
-
-	return ret;
-}
-
-extern asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
-					    unsigned long *user_mask_ptr);
-
-asmlinkage int sys32_sched_getaffinity(compat_pid_t pid, unsigned int len,
-				       u32 *user_mask_ptr)
-{
-	unsigned long kernel_mask;
-	mm_segment_t old_fs;
-	int ret;
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_sched_getaffinity(pid,
-				    /* XXX Nice api... */
-				    sizeof(kernel_mask),
-				    &kernel_mask);
-	set_fs(old_fs);
-
-	if (ret > 0) {
-		if (put_user(kernel_mask, user_mask_ptr))
-			ret = -EFAULT;
-	}
-
-	return ret;
-}
-
 extern int sys_lookup_dcookie(u64 cookie64, char *buf, size_t len);
 
 int sys32_lookup_dcookie(u32 cookie_high, u32 cookie_low, char *buf, size_t len)
Index: arch/sparc64/kernel/systbls.S
===================================================================
RCS file: /var/cvs/linux-2.5/arch/sparc64/kernel/systbls.S,v
retrieving revision 1.16
diff -u -p -r1.16 systbls.S
--- linux-2.5.67/arch/sparc64/kernel/systbls.S	11 Apr 2003 05:29:34 -0000	1.16
+++ linux-new/arch/sparc64/kernel/systbls.S	11 Apr 2003 06:06:37 -0000
@@ -51,7 +51,7 @@ sys_call_table32:
 	.word compat_sys_setrlimit, sys_pivot_root, sys32_prctl, sys32_pciconfig_read, sys32_pciconfig_write
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
 	.word compat_sys_fcntl64, sys_ni_syscall, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
-/*160*/	.word sys32_sched_setaffinity, sys32_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
+/*160*/	.word compat_sys_sched_setaffinity, compat_sys_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
 	.word sys_quotactl, sys_set_tid_address, sys32_mount, sys_ustat, sys_setxattr
 /*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys32_getdents
 	.word sys_setsid, sys_fchdir, sys_fgetxattr, sys_listxattr, sys_llistxattr
Index: arch/x86_64/ia32/ia32entry.S
===================================================================
RCS file: /var/cvs/linux-2.5/arch/x86_64/ia32/ia32entry.S,v
retrieving revision 1.13
diff -u -p -r1.13 ia32entry.S
--- linux-2.5.67/arch/x86_64/ia32/ia32entry.S	11 Apr 2003 05:29:34 -0000	1.13
+++ linux-new/arch/x86_64/ia32/ia32entry.S	11 Apr 2003 06:06:37 -0000
@@ -445,8 +445,8 @@ ia32_sys_call_table:
 	.quad sys_tkill		/* 238 */ 
 	.quad sys_sendfile64 
 	.quad compat_sys_futex		/* 240 */
-        .quad sys32_sched_setaffinity
-        .quad sys32_sched_getaffinity
+        .quad compat_sys_sched_setaffinity
+        .quad compat_sys_sched_getaffinity
 	.quad sys32_set_thread_area
 	.quad sys32_get_thread_area
 	.quad sys32_io_setup
Index: arch/x86_64/ia32/sys_ia32.c
===================================================================
RCS file: /var/cvs/linux-2.5/arch/x86_64/ia32/sys_ia32.c,v
retrieving revision 1.17
diff -u -p -r1.17 sys_ia32.c
--- linux-2.5.67/arch/x86_64/ia32/sys_ia32.c	11 Apr 2003 05:29:35 -0000	1.17
+++ linux-new/arch/x86_64/ia32/sys_ia32.c	11 Apr 2003 06:06:38 -0000
@@ -1892,41 +1892,6 @@ long sys32_module_warning(void)
 	return -ENOSYS ;
 } 
 
-long sys_sched_getaffinity(pid_t pid, unsigned int len, unsigned long *new_mask_ptr); 
-long sys_sched_setaffinity(pid_t pid, unsigned int len, unsigned long *new_mask_ptr); 
-
-/* only works on LE */
-long sys32_sched_setaffinity(pid_t pid, unsigned int len,
-			    unsigned int *new_mask_ptr)
-{
-	mm_segment_t oldfs = get_fs(); 
-	unsigned long mask; 
-	int err;
-	if (get_user(mask, new_mask_ptr)) 
-		return -EFAULT;	
-	set_fs(KERNEL_DS); 
-	err = sys_sched_setaffinity(pid,sizeof(mask),&mask); 	
-	set_fs(oldfs); 
-	return err;
-}
-
-/* only works on LE */ 
-long sys32_sched_getaffinity(pid_t pid, unsigned int len,
-			    unsigned int *new_mask_ptr)
-{
-	mm_segment_t oldfs = get_fs(); 
-	unsigned long mask; 
-	int err;
-	mask = 0; 
-	set_fs(KERNEL_DS); 
-	err = sys_sched_getaffinity(pid,sizeof(mask),&mask); 	
-	set_fs(oldfs); 
-	if (err > 0) 
-		err = put_user((u32)mask, new_mask_ptr); 
-	return err;
-}
-
-
 extern long sys_io_setup(unsigned nr_reqs, aio_context_t *ctx);
 
 long sys32_io_setup(unsigned nr_reqs, u32 *ctx32p)
Index: kernel/compat.c
===================================================================
RCS file: /var/cvs/linux-2.5/kernel/compat.c,v
retrieving revision 1.7
diff -u -p -r1.7 compat.c
--- linux-2.5.67/kernel/compat.c	11 Apr 2003 05:29:35 -0000	1.7
+++ linux-new/kernel/compat.c	11 Apr 2003 06:06:40 -0000
@@ -373,3 +373,53 @@ compat_sys_wait4(compat_pid_t pid, compa
 	}
 }
 
+extern asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
+					    unsigned long *user_mask_ptr);
+
+asmlinkage long compat_sys_sched_setaffinity(compat_pid_t pid, 
+					     unsigned int len,
+					     compat_ulong_t *user_mask_ptr)
+{
+	unsigned long kernel_mask;
+	mm_segment_t old_fs;
+	int ret;
+
+	if (get_user(kernel_mask, user_mask_ptr))
+		return -EFAULT;
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sys_sched_setaffinity(pid,
+				    sizeof(kernel_mask),
+				    &kernel_mask);
+	set_fs(old_fs);
+
+	return ret;
+}
+
+extern asmlinkage long sys_sched_getaffinity(pid_t pid, unsigned int len,
+					    unsigned long *user_mask_ptr);
+
+asmlinkage int compat_sys_sched_getaffinity(compat_pid_t pid, unsigned int len,
+					    compat_ulong_t *user_mask_ptr)
+{
+	unsigned long kernel_mask;
+	mm_segment_t old_fs;
+	int ret;
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sys_sched_getaffinity(pid,
+				    sizeof(kernel_mask),
+				    &kernel_mask);
+	set_fs(old_fs);
+
+	if (ret > 0) {
+		if (put_user(kernel_mask, user_mask_ptr))
+			ret = -EFAULT;
+		ret = sizeof(compat_ulong_t);
+	}
+
+	return ret;
+}
+
