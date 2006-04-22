Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWDVVS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWDVVS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWDVVS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:18:57 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:16859 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751237AbWDVVSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:18:55 -0400
Date: Fri, 21 Apr 2006 19:39:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <acahalan@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc stack problem
In-Reply-To: <Pine.LNX.4.64.0604211823160.3701@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0604211932420.3701@g5.osdl.org>
References: <787b0d920604211807l2b08dd31h8bcc36bdea1e4379@mail.gmail.com>
 <Pine.LNX.4.64.0604211823160.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Apr 2006, Linus Torvalds wrote:
>
> For example, I've considered replacing the ugly "prevent_tail_call()" with 
> a slightly different macro that talks less about tailcalls, and talks 
> more about the ABI we want:

Here's a (untested!) patch to illustrate what I'm talking about.

Now, this is still the same old hacky "force gcc to do what we want", just 
more geared towards _why_ why want that particular effect. And the reason 
I don't like it all that much is that while it should generate the code we 
want, we don't want to do this for all system calls - because some system 
calls don't need it!

As mentioned, tailcalls are fine per se, it's only really a problem when 
gcc generates them so that they put crud in the stack. That, in turn, 
happens only when the tailcall needs more arguments than fit in registers. 
And THAT only happens for some system calls, and depends on the calling 
convention used inside the kernel (ie regparm-3 for normal non-asmlinkage 
functions).

So if gcc had a "caller_arguments" attribute, we could just add it to the 
definition of 'asmlinkage', and automatically cover all system calls. AND 
it would allow tailcalls when they are appropriate and work fine. In 
contrast, when we have to force it, we have to use this kind of stupid 
"nail just the particular system calls".

This is why it's nice to tell the compiler about the true calling 
convention. Because that leaves the compiler able to DTRT.

		Linus

---
diff --git a/include/asm-i386/linkage.h b/include/asm-i386/linkage.h
index f4a6eba..a6068ac 100644
--- a/include/asm-i386/linkage.h
+++ b/include/asm-i386/linkage.h
@@ -5,7 +5,24 @@ #define asmlinkage CPP_ASMLINKAGE __attr
 #define FASTCALL(x)	x __attribute__((regparm(3)))
 #define fastcall	__attribute__((regparm(3)))
 
-#define prevent_tail_call(ret) __asm__ ("" : "=r" (ret) : "0" (ret))
+struct dummy { int regs[6]; };
+
+/*
+ * On x86, the caller owns the system call arguments.
+ *
+ * We tell that to gcc by telling that we still want them
+ * in memory just before the final return.
+ *
+ * Other systems might want to set error flags or
+ * something.
+ */
+#define system_call_return(ret,arg1) do {	\
+	long syscall_ret_value = (ret);		\
+	asm("":"=r" (syscall_ret_value),	\
+	       "+m" (*(struct dummy *)&(arg1))	\
+	      :"0" (syscall_ret_value));	\
+	return syscall_ret_value;		\
+} while (0)
 
 #ifdef CONFIG_X86_ALIGNMENT_16
 #define __ALIGN .align 16,0x90
diff --git a/include/linux/linkage.h b/include/linux/linkage.h
index c08c998..ba51ba7 100644
--- a/include/linux/linkage.h
+++ b/include/linux/linkage.h
@@ -14,8 +14,8 @@ #ifndef asmlinkage
 #define asmlinkage CPP_ASMLINKAGE
 #endif
 
-#ifndef prevent_tail_call
-# define prevent_tail_call(ret) do { } while (0)
+#ifndef system_call_return
+# define system_call_return(ret,arg1)	return (ret)
 #endif
 
 #ifndef __ALIGN
diff --git a/fs/open.c b/fs/open.c
index 53ec28c..e07d8c4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -331,25 +331,25 @@ out:
 
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length)
 {
-	long ret = do_sys_ftruncate(fd, length, 1);
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		do_sys_ftruncate(fd, length, 1),
+		fd);
 }
 
 /* LFS versions of truncate are only needed on 32 bit machines */
 #if BITS_PER_LONG == 32
 asmlinkage long sys_truncate64(const char __user * path, loff_t length)
 {
-	return do_sys_truncate(path, length);
+	system_call_return(
+		do_sys_truncate(path, length),
+		path);
 }
 
 asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length)
 {
-	long ret = do_sys_ftruncate(fd, length, 0);
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		do_sys_ftruncate(fd, length, 0),
+		fd);
 }
 #endif
 
@@ -1099,30 +1099,24 @@ long do_sys_open(int dfd, const char __u
 
 asmlinkage long sys_open(const char __user *filename, int flags, int mode)
 {
-	long ret;
-
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
 
-	ret = do_sys_open(AT_FDCWD, filename, flags, mode);
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		do_sys_open(AT_FDCWD, filename, flags, mode),
+		filename);
 }
 EXPORT_SYMBOL_GPL(sys_open);
 
 asmlinkage long sys_openat(int dfd, const char __user *filename, int flags,
 			   int mode)
 {
-	long ret;
-
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
 
-	ret = do_sys_open(dfd, filename, flags, mode);
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		do_sys_open(dfd, filename, flags, mode),
+		dfd);
 }
 EXPORT_SYMBOL_GPL(sys_openat);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index f86434d..3bbc37d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1584,8 +1584,6 @@ asmlinkage long sys_waitid(int which, pi
 			   struct siginfo __user *infop, int options,
 			   struct rusage __user *ru)
 {
-	long ret;
-
 	if (options & ~(WNOHANG|WNOWAIT|WEXITED|WSTOPPED|WCONTINUED))
 		return -EINVAL;
 	if (!(options & (WEXITED|WSTOPPED|WCONTINUED)))
@@ -1608,26 +1606,20 @@ asmlinkage long sys_waitid(int which, pi
 		return -EINVAL;
 	}
 
-	ret = do_wait(pid, options, infop, NULL, ru);
-
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		do_wait(pid, options, infop, NULL, ru),
+		which);
 }
 
 asmlinkage long sys_wait4(pid_t pid, int __user *stat_addr,
 			  int options, struct rusage __user *ru)
 {
-	long ret;
-
 	if (options & ~(WNOHANG|WUNTRACED|WCONTINUED|
 			__WNOTHREAD|__WCLONE|__WALL))
 		return -EINVAL;
-	ret = do_wait(pid, options | WEXITED, NULL, stat_addr, ru);
-
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		do_wait(pid, options | WEXITED, NULL, stat_addr, ru),
+		pid);
 }
 
 #ifdef __ARCH_WANT_SYS_WAITPID
diff --git a/kernel/uid16.c b/kernel/uid16.c
index 187e2a4..c09b8dd 100644
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -20,67 +20,58 @@ #include <asm/uaccess.h>
 
 asmlinkage long sys_chown16(const char __user * filename, old_uid_t user, old_gid_t group)
 {
-	long ret = sys_chown(filename, low2highuid(user), low2highgid(group));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_chown(filename, low2highuid(user), low2highgid(group)),
+		filename);
 }
 
 asmlinkage long sys_lchown16(const char __user * filename, old_uid_t user, old_gid_t group)
 {
-	long ret = sys_lchown(filename, low2highuid(user), low2highgid(group));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_lchown(filename, low2highuid(user), low2highgid(group)),
+		filename);
 }
 
 asmlinkage long sys_fchown16(unsigned int fd, old_uid_t user, old_gid_t group)
 {
-	long ret = sys_fchown(fd, low2highuid(user), low2highgid(group));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_fchown(fd, low2highuid(user), low2highgid(group)),
+		fd);
 }
 
 asmlinkage long sys_setregid16(old_gid_t rgid, old_gid_t egid)
 {
-	long ret = sys_setregid(low2highgid(rgid), low2highgid(egid));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_setregid(low2highgid(rgid), low2highgid(egid)),
+		rgid);
 }
 
 asmlinkage long sys_setgid16(old_gid_t gid)
 {
-	long ret = sys_setgid(low2highgid(gid));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_setgid(low2highgid(gid)),
+		gid);
 }
 
 asmlinkage long sys_setreuid16(old_uid_t ruid, old_uid_t euid)
 {
-	long ret = sys_setreuid(low2highuid(ruid), low2highuid(euid));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_setreuid(low2highuid(ruid), low2highuid(euid)),
+		ruid);
 }
 
 asmlinkage long sys_setuid16(old_uid_t uid)
 {
-	long ret = sys_setuid(low2highuid(uid));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_setuid(low2highuid(uid)),
+		uid);
 }
 
 asmlinkage long sys_setresuid16(old_uid_t ruid, old_uid_t euid, old_uid_t suid)
 {
-	long ret = sys_setresuid(low2highuid(ruid), low2highuid(euid),
-				 low2highuid(suid));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_setresuid(low2highuid(ruid), low2highuid(euid), low2highuid(suid)),
+		ruid);
 }
 
 asmlinkage long sys_getresuid16(old_uid_t __user *ruid, old_uid_t __user *euid, old_uid_t __user *suid)
@@ -96,11 +87,9 @@ asmlinkage long sys_getresuid16(old_uid_
 
 asmlinkage long sys_setresgid16(old_gid_t rgid, old_gid_t egid, old_gid_t sgid)
 {
-	long ret = sys_setresgid(low2highgid(rgid), low2highgid(egid),
-				 low2highgid(sgid));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_setresgid(low2highgid(rgid), low2highgid(egid), low2highgid(sgid)),
+		rgid);
 }
 
 asmlinkage long sys_getresgid16(old_gid_t __user *rgid, old_gid_t __user *egid, old_gid_t __user *sgid)
@@ -116,18 +105,16 @@ asmlinkage long sys_getresgid16(old_gid_
 
 asmlinkage long sys_setfsuid16(old_uid_t uid)
 {
-	long ret = sys_setfsuid(low2highuid(uid));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_setfsuid(low2highuid(uid)),
+		uid);
 }
 
 asmlinkage long sys_setfsgid16(old_gid_t gid)
 {
-	long ret = sys_setfsgid(low2highgid(gid));
-	/* avoid REGPARM breakage on x86: */
-	prevent_tail_call(ret);
-	return ret;
+	system_call_return(
+		sys_setfsgid(low2highgid(gid)),
+		gid);
 }
 
 static int groups16_to_user(old_gid_t __user *grouplist,
