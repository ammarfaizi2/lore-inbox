Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVBODDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVBODDA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 22:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVBODCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 22:02:50 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:13440 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261599AbVBODCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 22:02:06 -0500
Date: Tue, 15 Feb 2005 14:01:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: paulus@samba.org, anton@samba.org, davem@davemloft.net,
       ralf@linux-mips.org, tony.luck@intel.com, ak@suse.de, willy@debian.org,
       schwidefsky@de.ibm.com
Subject: [PATCH] Consolidate compat_sys_waitid
Message-Id: <20050215140149.0b06c96b.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch does:
	- consolidate the three implementations of compat_sys_waitid
	  (some were called sys32_waitid).
	- adds sys_waitid syscall to ppc
	- adds sys_waitid and compat_sys_waitid syscalls to ppc64

Parisc seemed to assume th existance of compat_sys_waitid.  The MIPS
syscall tables have me confused and may need updating.  I have arbitrarily
chosen the next available syscall number on ppc and ppc64, I hope this is
correct.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Comments?

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruNp linus-bk/arch/ia64/ia32/ia32_entry.S linus-bk-waitid.1/arch/ia64/ia32/ia32_entry.S
--- linus-bk/arch/ia64/ia32/ia32_entry.S	2005-01-16 07:07:51.000000000 +1100
+++ linus-bk-waitid.1/arch/ia64/ia32/ia32_entry.S	2005-02-15 12:12:21.000000000 +1100
@@ -494,7 +494,7 @@ ia32_syscall_table:
   	data8 compat_sys_mq_notify
   	data8 compat_sys_mq_getsetattr
 	data8 sys_ni_syscall		/* reserved for kexec */
-	data8 sys32_waitid
+	data8 compat_sys_waitid
 
 	// guard against failures to increase IA32_NR_syscalls
 	.org ia32_syscall_table + 8*IA32_NR_syscalls
diff -ruNp linus-bk/arch/ia64/ia32/sys_ia32.c linus-bk-waitid.1/arch/ia64/ia32/sys_ia32.c
--- linus-bk/arch/ia64/ia32/sys_ia32.c	2005-02-11 13:05:29.000000000 +1100
+++ linus-bk-waitid.1/arch/ia64/ia32/sys_ia32.c	2005-02-15 12:16:35.000000000 +1100
@@ -2633,32 +2633,6 @@ long sys32_fadvise64_64(int fd, __u32 of
 			       advice); 
 } 
 
-asmlinkage long sys32_waitid(int which, compat_pid_t pid,
-			     compat_siginfo_t __user *uinfo, int options,
-			     struct compat_rusage __user *uru)
-{
-	siginfo_t info;
-	struct rusage ru;
-	long ret;
-	mm_segment_t old_fs = get_fs();
-
-	info.si_signo = 0;
-	set_fs (KERNEL_DS);
-	ret = sys_waitid(which, pid, (siginfo_t __user *) &info, options,
-			 uru ? (struct rusage __user *) &ru : NULL);
-	set_fs (old_fs);
-
-	if (ret < 0 || info.si_signo == 0)
-		return ret;
-
-	if (uru && (ret = put_compat_rusage(&ru, uru)))
-		return ret;
-
-	BUG_ON(info.si_code & __SI_MASK);
-	info.si_code |= __SI_CHLD;
-	return copy_siginfo_to_user32(uinfo, &info);
-}
-
 #ifdef	NOTYET  /* UNTESTED FOR IA64 FROM HERE DOWN */
 
 asmlinkage long sys32_setreuid(compat_uid_t ruid, compat_uid_t euid)
diff -ruNp linus-bk/arch/ppc/kernel/misc.S linus-bk-waitid.1/arch/ppc/kernel/misc.S
--- linus-bk/arch/ppc/kernel/misc.S	2005-01-04 17:05:28.000000000 +1100
+++ linus-bk-waitid.1/arch/ppc/kernel/misc.S	2005-02-15 13:12:01.000000000 +1100
@@ -1450,3 +1450,4 @@ _GLOBAL(sys_call_table)
 	.long sys_add_key
 	.long sys_request_key		/* 270 */
 	.long sys_keyctl
+	.long sys_waitid
diff -ruNp linus-bk/arch/ppc64/kernel/misc.S linus-bk-waitid.1/arch/ppc64/kernel/misc.S
--- linus-bk/arch/ppc64/kernel/misc.S	2005-01-16 07:07:51.000000000 +1100
+++ linus-bk-waitid.1/arch/ppc64/kernel/misc.S	2005-02-15 13:13:51.000000000 +1100
@@ -939,6 +939,7 @@ _GLOBAL(sys_call_table32)
 	.llong .sys32_add_key
 	.llong .sys32_request_key
 	.llong .compat_sys_keyctl
+	.llong .compat_sys_waitid
 
 	.balign 8
 _GLOBAL(sys_call_table)
@@ -1214,3 +1215,4 @@ _GLOBAL(sys_call_table)
 	.llong .sys_add_key
 	.llong .sys_request_key		/* 270 */
 	.llong .sys_keyctl
+	.llong .sys_waitid
diff -ruNp linus-bk/arch/sparc64/kernel/sys_sparc32.c linus-bk-waitid.1/arch/sparc64/kernel/sys_sparc32.c
--- linus-bk/arch/sparc64/kernel/sys_sparc32.c	2005-02-11 13:05:29.000000000 +1100
+++ linus-bk-waitid.1/arch/sparc64/kernel/sys_sparc32.c	2005-02-15 12:01:55.000000000 +1100
@@ -1653,34 +1653,3 @@ sys32_timer_create(u32 clock, struct sig
 
 	return err;
 }
-
-asmlinkage long compat_sys_waitid(u32 which, u32 pid,
-				  struct compat_siginfo __user *uinfo,
-				  u32 options, struct compat_rusage __user *uru)
-{
-	siginfo_t info;
-	struct rusage ru;
-	long ret;
-	mm_segment_t old_fs = get_fs();
-
-	memset(&info, 0, sizeof(info));
-
-	set_fs (KERNEL_DS);
-	ret = sys_waitid(which, pid, (siginfo_t __user *) &info,
-			 options,
-			 uru ? (struct rusage __user *) &ru : NULL);
-	set_fs (old_fs);
-
-	if (ret < 0 || info.si_signo == 0)
-		return ret;
-
-	if (uru) {
-		ret = put_compat_rusage(&ru, uru);
-		if (ret)
-			return ret;
-	}
-
-	BUG_ON(info.si_code & __SI_MASK);
-	info.si_code |= __SI_CHLD;
-	return copy_siginfo_to_user32(uinfo, &info);
-}
diff -ruNp linus-bk/arch/x86_64/ia32/ia32entry.S linus-bk-waitid.1/arch/x86_64/ia32/ia32entry.S
--- linus-bk/arch/x86_64/ia32/ia32entry.S	2005-01-16 11:05:29.000000000 +1100
+++ linus-bk-waitid.1/arch/x86_64/ia32/ia32entry.S	2005-02-15 12:11:52.000000000 +1100
@@ -590,7 +590,7 @@ ia32_sys_call_table:
 	.quad compat_sys_mq_notify
 	.quad compat_sys_mq_getsetattr
 	.quad quiet_ni_syscall		/* reserved for kexec */
-	.quad sys32_waitid
+	.quad compat_sys_waitid
 	.quad quiet_ni_syscall		/* sys_altroot */
 	.quad sys_add_key
 	.quad sys_request_key
diff -ruNp linus-bk/arch/x86_64/ia32/sys_ia32.c linus-bk-waitid.1/arch/x86_64/ia32/sys_ia32.c
--- linus-bk/arch/x86_64/ia32/sys_ia32.c	2005-02-04 04:10:36.000000000 +1100
+++ linus-bk-waitid.1/arch/x86_64/ia32/sys_ia32.c	2005-02-15 12:17:04.000000000 +1100
@@ -955,32 +955,6 @@ asmlinkage long sys32_clone(unsigned int
         return do_fork(clone_flags, newsp, regs, 0, parent_tid, child_tid);
 }
 
-asmlinkage long sys32_waitid(int which, compat_pid_t pid,
-			     compat_siginfo_t __user *uinfo, int options,
-			     struct compat_rusage __user *uru)
-{
-	siginfo_t info;
-	struct rusage ru;
-	long ret;
-	mm_segment_t old_fs = get_fs();
-
-	info.si_signo = 0;
-	set_fs (KERNEL_DS);
-	ret = sys_waitid(which, pid, (siginfo_t __user *) &info, options,
-			 uru ? &ru : NULL);
-	set_fs (old_fs);
-
-	if (ret < 0 || info.si_signo == 0)
-		return ret;
-
-	if (uru && (ret = put_compat_rusage(&ru, uru)))
-		return ret;
-
-	BUG_ON(info.si_code & __SI_MASK);
-	info.si_code |= __SI_CHLD;
-	return copy_siginfo_to_user32(uinfo, &info);
-}
-
 /*
  * Some system calls that need sign extended arguments. This could be done by a generic wrapper.
  */ 
diff -ruNp linus-bk/include/asm-ppc/unistd.h linus-bk-waitid.1/include/asm-ppc/unistd.h
--- linus-bk/include/asm-ppc/unistd.h	2005-01-04 17:05:28.000000000 +1100
+++ linus-bk-waitid.1/include/asm-ppc/unistd.h	2005-02-15 13:08:22.000000000 +1100
@@ -276,8 +276,9 @@
 #define __NR_add_key		269
 #define __NR_request_key	270
 #define __NR_keyctl		271
+#define __NR_waitid		272
 
-#define __NR_syscalls		272
+#define __NR_syscalls		273
 
 #define __NR(n)	#n
 
diff -ruNp linus-bk/include/asm-ppc64/unistd.h linus-bk-waitid.1/include/asm-ppc64/unistd.h
--- linus-bk/include/asm-ppc64/unistd.h	2005-01-05 17:06:08.000000000 +1100
+++ linus-bk-waitid.1/include/asm-ppc64/unistd.h	2005-02-15 13:07:33.000000000 +1100
@@ -282,8 +282,9 @@
 #define __NR_add_key		269
 #define __NR_request_key	270
 #define __NR_keyctl		271
+#define __NR_waitid		272
 
-#define __NR_syscalls		272
+#define __NR_syscalls		273
 #ifdef __KERNEL__
 #define NR_syscalls	__NR_syscalls
 #endif
diff -ruNp linus-bk/include/linux/compat.h linus-bk-waitid.1/include/linux/compat.h
--- linus-bk/include/linux/compat.h	2005-01-05 17:06:08.000000000 +1100
+++ linus-bk-waitid.1/include/linux/compat.h	2005-02-15 13:22:13.000000000 +1100
@@ -81,6 +81,12 @@ struct compat_rusage {
 
 extern int put_compat_rusage(const struct rusage *, struct compat_rusage __user *);
 
+struct compat_siginfo;
+
+extern asmlinkage long compat_sys_waitid(u32, u32,
+		struct compat_siginfo __user *, u32,
+		struct compat_rusage __user *);
+
 struct compat_dirent {
 	u32		d_ino;
 	compat_off_t	d_off;
@@ -143,7 +149,6 @@ long compat_get_bitmap(unsigned long *ma
 		       unsigned long bitmap_size);
 long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
 		       unsigned long bitmap_size);
-struct compat_siginfo;
 int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from);
 int copy_siginfo_to_user32(struct compat_siginfo __user *to, siginfo_t *from);
 #endif /* CONFIG_COMPAT */
diff -ruNp linus-bk/kernel/compat.c linus-bk-waitid.1/kernel/compat.c
--- linus-bk/kernel/compat.c	2005-01-16 07:07:51.000000000 +1100
+++ linus-bk-waitid.1/kernel/compat.c	2005-02-15 12:09:46.000000000 +1100
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 
 #include <asm/uaccess.h>
+#include <asm/bug.h>
 
 int get_compat_timespec(struct timespec *ts, const struct compat_timespec __user *cts)
 {
@@ -413,6 +414,36 @@ compat_sys_wait4(compat_pid_t pid, compa
 	}
 }
 
+asmlinkage long compat_sys_waitid(u32 which, u32 pid,
+		struct compat_siginfo __user *uinfo, u32 options,
+		struct compat_rusage __user *uru)
+{
+	siginfo_t info;
+	struct rusage ru;
+	long ret;
+	mm_segment_t old_fs = get_fs();
+
+	memset(&info, 0, sizeof(info));
+
+	set_fs(KERNEL_DS);
+	ret = sys_waitid(which, pid, (siginfo_t __user *)&info, options,
+			 uru ? (struct rusage __user *)&ru : NULL);
+	set_fs(old_fs);
+
+	if ((ret < 0) || (info.si_signo == 0))
+		return ret;
+
+	if (uru) {
+		ret = put_compat_rusage(&ru, uru);
+		if (ret)
+			return ret;
+	}
+
+	BUG_ON(info.si_code & __SI_MASK);
+	info.si_code |= __SI_CHLD;
+	return copy_siginfo_to_user32(uinfo, &info);
+}
+
 static int compat_get_user_cpu_mask(compat_ulong_t __user *user_mask_ptr,
 				    unsigned len, cpumask_t *new_mask)
 {
