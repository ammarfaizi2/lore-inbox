Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWETUOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWETUOB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 16:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWETUOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 16:14:01 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:17342 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751482AbWETUOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 16:14:00 -0400
Date: Sat, 20 May 2006 13:13:57 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] i386: kill CONFIG_REGPARM completely
Message-ID: <20060520201357.GA32010@taniwha.stupidest.org>
References: <20060520025353.GE9486@taniwha.stupidest.org> <20060520090614.GA9630@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520090614.GA9630@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 10:06:14AM +0100, Christoph Hellwig wrote:

> Just kill the option completely.  It works nicely, generates better
> code and we've stopped support for the old, broken compilers not
> handling it.

Well, I'm not against that personally but I think more people should
comment given the number of prevent_tail_call(...) presently used.

Anyhow, how does this look for a first pass at this?



diff --git a/Documentation/stable_api_nonsense.txt b/Documentation/stable_api_nonsense.txt
index f39c9d7..ac11b81 100644
--- a/Documentation/stable_api_nonsense.txt
+++ b/Documentation/stable_api_nonsense.txt
@@ -62,9 +62,8 @@ consider the following facts about the L
       - different structures can contain different fields
       - Some functions may not be implemented at all, (i.e. some locks
 	compile away to nothing for non-SMP builds.)
-      - Parameter passing of variables from function to function can be
-	done in different ways (the CONFIG_REGPARM option controls
-	this.)
+      - Parameter passing of variables from function to function can
+	be done in different ways.
       - Memory within the kernel can be aligned in different ways,
 	depending on the build options.
   - Linux runs on a wide range of different processor architectures.
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8dfa305..71f1355 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -677,20 +677,6 @@ config BOOT_IOREMAP
 	depends on (((X86_SUMMIT || X86_GENERICARCH) && NUMA) || (X86 && EFI))
 	default y
 
-config REGPARM
-	bool "Use register arguments"
-	default y
-	help
-	Compile the kernel with -mregparm=3. This instructs gcc to use
-	a more efficient function call ABI which passes the first three
-	arguments of a function call via registers, which results in denser
-	and faster code.
-
-	If this option is disabled, then the default ABI of passing
-	arguments via the stack is used.
-
-	If unsure, say Y.
-
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index 3e4adb1..263a3b8 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -29,7 +29,7 @@ OBJCOPYFLAGS	:= -O binary -R .note -R .c
 LDFLAGS_vmlinux :=
 CHECKFLAGS	+= -D__i386__
 
-CFLAGS += -pipe -msoft-float
+CFLAGS += -pipe -msoft-float -mregparm-3
 
 # prevent gcc from keeping the stack 16 byte aligned
 CFLAGS += $(call cc-option,-mpreferred-stack-boundary=2)
@@ -37,8 +37,6 @@ CFLAGS += $(call cc-option,-mpreferred-s
 # CPU-specific tuning. Anything which can be shared with UML should go here.
 include $(srctree)/arch/i386/Makefile.cpu
 
-cflags-$(CONFIG_REGPARM) += -mregparm=3
-
 # temporary until string.h is fixed
 cflags-y += -ffreestanding
 
diff --git a/arch/i386/defconfig b/arch/i386/defconfig
index 1629c3a..ca00ff0 100644
--- a/arch/i386/defconfig
+++ b/arch/i386/defconfig
@@ -1,4 +1,4 @@
-#
+
 # Automatically generated make config: don't edit
 #
 CONFIG_X86_32=y
@@ -180,7 +180,6 @@ CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_MATH_EMULATION is not set
 CONFIG_MTRR=y
 # CONFIG_EFI is not set
-CONFIG_REGPARM=y
 # CONFIG_SECCOMP is not set
 CONFIG_HZ_100=y
 # CONFIG_HZ_250 is not set
diff --git a/arch/i386/kernel/ptrace.c b/arch/i386/kernel/ptrace.c
index fd7eaf7..9ab9eb6 100644
--- a/arch/i386/kernel/ptrace.c
+++ b/arch/i386/kernel/ptrace.c
@@ -654,7 +654,6 @@ void send_sigtrap(struct task_struct *ts
 /* notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
-__attribute__((regparm(3)))
 int do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
 	int is_sysemu = test_thread_flag(TIF_SYSCALL_EMU);
diff --git a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
index 5c352c3..9176407 100644
--- a/arch/i386/kernel/signal.c
+++ b/arch/i386/kernel/signal.c
@@ -641,7 +641,6 @@ static void fastcall do_signal(struct pt
  * notification of userspace execution resumption
  * - triggered by the TIF_WORK_MASK flags
  */
-__attribute__((regparm(3)))
 void do_notify_resume(struct pt_regs *regs, void *_unused,
 		      __u32 thread_info_flags)
 {
diff --git a/fs/open.c b/fs/open.c
index 317b7c7..e61bfce 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -332,7 +332,7 @@ out:
 asmlinkage long sys_ftruncate(unsigned int fd, unsigned long length)
 {
 	long ret = do_sys_ftruncate(fd, length, 1);
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -347,7 +347,7 @@ asmlinkage long sys_truncate64(const cha
 asmlinkage long sys_ftruncate64(unsigned int fd, loff_t length)
 {
 	long ret = do_sys_ftruncate(fd, length, 0);
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -1105,7 +1105,7 @@ asmlinkage long sys_open(const char __us
 		flags |= O_LARGEFILE;
 
 	ret = do_sys_open(AT_FDCWD, filename, flags, mode);
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -1120,7 +1120,7 @@ asmlinkage long sys_openat(int dfd, cons
 		flags |= O_LARGEFILE;
 
 	ret = do_sys_open(dfd, filename, flags, mode);
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
diff --git a/include/asm-i386/linkage.h b/include/asm-i386/linkage.h
index f4a6eba..7362dfa 100644
--- a/include/asm-i386/linkage.h
+++ b/include/asm-i386/linkage.h
@@ -2,8 +2,10 @@ #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H
 
 #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
-#define FASTCALL(x)	x __attribute__((regparm(3)))
-#define fastcall	__attribute__((regparm(3)))
+/* FASTCALL and fastcall used to be __attribute__((regparm(3))) but
+ * that is now the default for i386 so these become no-ops. */
+#define FASTCALL(x)	x
+#define fastcall
 
 #define prevent_tail_call(ret) __asm__ ("" : "=r" (ret) : "0" (ret))
 
diff --git a/include/asm-i386/module.h b/include/asm-i386/module.h
index 424661d..968a690 100644
--- a/include/asm-i386/module.h
+++ b/include/asm-i386/module.h
@@ -60,18 +60,12 @@ #else
 #error unknown processor family
 #endif
 
-#ifdef CONFIG_REGPARM
-#define MODULE_REGPARM "REGPARM "
-#else
-#define MODULE_REGPARM ""
-#endif
-
 #ifdef CONFIG_4KSTACKS
 #define MODULE_STACKSIZE "4KSTACKS "
 #else
 #define MODULE_STACKSIZE ""
 #endif
 
-#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_REGPARM MODULE_STACKSIZE
+#define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY MODULE_STACKSIZE
 
 #endif /* _ASM_I386_MODULE_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index e95b932..ed5e704 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1613,7 +1613,7 @@ asmlinkage long sys_waitid(int which, pi
 
 	ret = do_wait(pid, options, infop, NULL, ru);
 
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -1628,7 +1628,7 @@ asmlinkage long sys_wait4(pid_t pid, int
 		return -EINVAL;
 	ret = do_wait(pid, options | WEXITED, NULL, stat_addr, ru);
 
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
diff --git a/kernel/uid16.c b/kernel/uid16.c
index 187e2a4..8ba4535 100644
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -21,7 +21,7 @@ #include <asm/uaccess.h>
 asmlinkage long sys_chown16(const char __user * filename, old_uid_t user, old_gid_t group)
 {
 	long ret = sys_chown(filename, low2highuid(user), low2highgid(group));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -29,7 +29,7 @@ asmlinkage long sys_chown16(const char _
 asmlinkage long sys_lchown16(const char __user * filename, old_uid_t user, old_gid_t group)
 {
 	long ret = sys_lchown(filename, low2highuid(user), low2highgid(group));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -37,7 +37,7 @@ asmlinkage long sys_lchown16(const char 
 asmlinkage long sys_fchown16(unsigned int fd, old_uid_t user, old_gid_t group)
 {
 	long ret = sys_fchown(fd, low2highuid(user), low2highgid(group));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -45,7 +45,7 @@ asmlinkage long sys_fchown16(unsigned in
 asmlinkage long sys_setregid16(old_gid_t rgid, old_gid_t egid)
 {
 	long ret = sys_setregid(low2highgid(rgid), low2highgid(egid));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -53,7 +53,7 @@ asmlinkage long sys_setregid16(old_gid_t
 asmlinkage long sys_setgid16(old_gid_t gid)
 {
 	long ret = sys_setgid(low2highgid(gid));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -61,7 +61,7 @@ asmlinkage long sys_setgid16(old_gid_t g
 asmlinkage long sys_setreuid16(old_uid_t ruid, old_uid_t euid)
 {
 	long ret = sys_setreuid(low2highuid(ruid), low2highuid(euid));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -69,7 +69,7 @@ asmlinkage long sys_setreuid16(old_uid_t
 asmlinkage long sys_setuid16(old_uid_t uid)
 {
 	long ret = sys_setuid(low2highuid(uid));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -78,7 +78,7 @@ asmlinkage long sys_setresuid16(old_uid_
 {
 	long ret = sys_setresuid(low2highuid(ruid), low2highuid(euid),
 				 low2highuid(suid));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -98,7 +98,7 @@ asmlinkage long sys_setresgid16(old_gid_
 {
 	long ret = sys_setresgid(low2highgid(rgid), low2highgid(egid),
 				 low2highgid(sgid));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -117,7 +117,7 @@ asmlinkage long sys_getresgid16(old_gid_
 asmlinkage long sys_setfsuid16(old_uid_t uid)
 {
 	long ret = sys_setfsuid(low2highuid(uid));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
@@ -125,7 +125,7 @@ asmlinkage long sys_setfsuid16(old_uid_t
 asmlinkage long sys_setfsgid16(old_gid_t gid)
 {
 	long ret = sys_setfsgid(low2highgid(gid));
-	/* avoid REGPARM breakage on x86: */
+	/* avoid 'regparm' breakage on i386 */
 	prevent_tail_call(ret);
 	return ret;
 }
