Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267056AbUKBI4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267056AbUKBI4A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S455343AbUKBIzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:55:22 -0500
Received: from fmr12.intel.com ([134.134.136.15]:27575 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S291690AbUKBIr6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:47:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: [PATCH x86_64]: Setup PER_LINUX32 on x86_64
Date: Tue, 2 Nov 2004 16:47:52 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E84BBECA2@pdsmsx404>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH x86_64]: Setup PER_LINUX32 on x86_64
Thread-Index: AcTAuKOU32iYMuOgR+meBVLy86RD8A==
From: "Jin, Gordon" <gordon.jin@intel.com>
To: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 02 Nov 2004 08:47:54.0093 (UTC) FILETIME=[A49489D0:01C4C0B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64, PER_LINUX32 is not setup but used by syscall personality and uname.
This patch sets PER_LINUX32 when x86 binary loaded so it can be used correctly.
- Set personality to PER_LINUX32 when x86 binary loaded.
- Set personality to PER_LINUX when x86_64 binary loaded.
- Use sys32_personality instead of sys_personality.
- Add sys32_newuname() for syscall newuname.
- Remove the unnecessary check for PER_LINUX32 in sys_uname().

Signed-off-by: Gordon Jin <gordon.jin@intel.com>

Index: linux-2.6.9/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.9/arch/x86_64/kernel/process.c	(revision 1)
+++ linux-2.6.9/arch/x86_64/kernel/process.c	(revision 3)
@@ -550,7 +550,7 @@ long sys_execve(char __user *name, char 
 
 void set_personality_64bit(void)
 {
-	/* inherit personality from parent */
+	set_personality(PER_LINUX);
 
 	/* Make sure to be in 64bit mode */
 	clear_thread_flag(TIF_IA32); 
Index: linux-2.6.9/arch/x86_64/kernel/sys_x86_64.c
===================================================================
--- linux-2.6.9/arch/x86_64/kernel/sys_x86_64.c	(revision 1)
+++ linux-2.6.9/arch/x86_64/kernel/sys_x86_64.c	(revision 3)
@@ -148,8 +148,6 @@ asmlinkage long sys_uname(struct new_uts
 	down_read(&uts_sem);
 	err = copy_to_user(name, &system_utsname, sizeof (*name));
 	up_read(&uts_sem);
-	if (personality(current->personality) == PER_LINUX32) 
-		err |= copy_to_user(&name->machine, "i686", 5); 		
 	return err ? -EFAULT : 0;
 }
 
Index: linux-2.6.9/arch/x86_64/ia32/ia32entry.S
===================================================================
--- linux-2.6.9/arch/x86_64/ia32/ia32entry.S	(revision 1)
+++ linux-2.6.9/arch/x86_64/ia32/ia32entry.S	(revision 3)
@@ -424,7 +424,7 @@ ia32_sys_call_table:
 	.quad stub32_sigreturn
 	.quad stub32_clone		/* 120 */
 	.quad sys_setdomainname
-	.quad sys_uname
+	.quad sys32_newuname
 	.quad sys_modify_ldt
 	.quad sys32_adjtimex
 	.quad sys32_mprotect		/* 125 */
@@ -438,7 +438,7 @@ ia32_sys_call_table:
 	.quad sys_fchdir
 	.quad quiet_ni_syscall	/* bdflush */
 	.quad sys_sysfs		/* 135 */
-	.quad sys_personality
+	.quad sys32_personality
 	.quad quiet_ni_syscall	/* for afs_syscall */
 	.quad sys_setfsuid16
 	.quad sys_setfsgid16
Index: linux-2.6.9/arch/x86_64/ia32/ia32_aout.c
===================================================================
--- linux-2.6.9/arch/x86_64/ia32/ia32_aout.c	(revision 1)
+++ linux-2.6.9/arch/x86_64/ia32/ia32_aout.c	(revision 3)
@@ -297,7 +297,7 @@ static int load_aout_binary(struct linux
 		regs->r13 = regs->r14 = regs->r15 = 0;
 
 	/* OK, This is the point of no return */
-	set_personality(PER_LINUX);
+	set_personality(PER_LINUX32);
 	set_thread_flag(TIF_IA32); 
 	clear_thread_flag(TIF_ABI_PENDING);
 
Index: linux-2.6.9/arch/x86_64/ia32/sys_ia32.c
===================================================================
--- linux-2.6.9/arch/x86_64/ia32/sys_ia32.c	(revision 1)
+++ linux-2.6.9/arch/x86_64/ia32/sys_ia32.c	(revision 3)
@@ -1103,6 +1103,16 @@ long sys32_uname(struct old_utsname __us
 	return err?-EFAULT:0;
 }
 
+asmlinkage long sys32_newuname (struct new_utsname __user *name)
+{
+	int ret = sys_newuname(name);
+
+	if (!ret)
+		if (copy_to_user(name->machine, "i686", 5))
+			ret = -EFAULT;
+	return ret;
+}
+
 long sys32_ustat(unsigned dev, struct ustat32 __user *u32p)
 {
 	struct ustat u;
Index: linux-2.6.9/arch/x86_64/ia32/ia32_binfmt.c
===================================================================
--- linux-2.6.9/arch/x86_64/ia32/ia32_binfmt.c	(revision 1)
+++ linux-2.6.9/arch/x86_64/ia32/ia32_binfmt.c	(revision 3)
@@ -254,8 +254,10 @@ elf_core_copy_task_xfpregs(struct task_s
 #define SET_PERSONALITY(ex, ibcs2)			\
 do {							\
 	unsigned long new_flags = 0;				\
-	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
+	if ((ex).e_ident[EI_CLASS] == ELFCLASS32) {		\
+		set_personality(PER_LINUX32);			\
 		new_flags = _TIF_IA32;				\
+	}							\
 	if ((current_thread_info()->flags & _TIF_IA32)		\
 	    != new_flags)					\
 		set_thread_flag(TIF_ABI_PENDING);		\

Thanks,
Gordon 
