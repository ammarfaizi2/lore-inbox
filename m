Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267335AbUI0Uan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267335AbUI0Uan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUI0U3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:29:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36291 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267338AbUI0U0h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:26:37 -0400
Date: Mon, 27 Sep 2004 16:26:16 -0400
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Patch for comment: setuid core dumps
Message-ID: <20040927202616.GA22228@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One thing we get asked for as enterprise Linux vendors and thus shipped 
functionality for in RHEL3 was core dumps of stuff that would normally not
be dumpable, both for debugging systems and for sysadmins debugging stuff
that normally isn't easy to get dumps from.

This patch implements three modes of core dumping switchable via /proc/sys.

0:	Standard Linux behaviour
1:	Not very secure mode (everything just dumps cores as needed)
2:	Sane setuid core dumps. This is the mode you'd expect to use on
	production systems. Anything tainted is dumped as root with 
	user only access rights. O_EXCL is enforced on tainted dumps 
	to avoid overwrite attacks. (You would normally use it with a 
	/ based core dump path or a core dump partition but it is always
	good to be careful)

I'm not sure if this is the best implementation but it is nice and simple
and by usign suid_dumpable in assignments it still allows a security policy to
override the dumpability itself, which a single change in fs/exec.c would
not do.

Opinions, bugs, reviews, fan mail ?

Alan

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/Documentation/sysctl/kernel.txt linux-2.6.9rc2/Documentation/sysctl/kernel.txt
--- linux.vanilla-2.6.9rc2/Documentation/sysctl/kernel.txt	2004-09-14 14:22:52.000000000 +0100
+++ linux-2.6.9rc2/Documentation/sysctl/kernel.txt	2004-09-27 19:01:53.729513832 +0100
@@ -49,6 +49,7 @@
 - shmmax                      [ sysv ipc ]
 - shmmni
 - stop-a                      [ SPARC only ]
+- suid_dumpable
 - sysrq                       ==> Documentation/sysrq.txt
 - tainted
 - threads-max
@@ -300,6 +301,25 @@
 
 ==============================================================
 
+suid_dumpable:
+
+This value can be used to query and set the core dump mode for setuid
+or otherwise protected/tainted binaries. The modes are
+
+0 - (default) - traditional behaviour. Any process which has changed
+	privilege levels or is execute only will not be dumped
+1 - (debug) - all processes dump core when possible. The core dump is
+	owned by the current user and no security is applied. This is
+	intended for system debugging situations only.
+2 - (suidsafe) - any binary which normally not be dumped is dumped
+	readable by root only. This allows the end user to remove
+	such a dump but not access it directly. For security reasons
+	core dumps in this mode will not overwrite one another or 
+	other files. This mode is appropriate when adminstrators are
+	attempting to debug problems in a normal environment.
+
+==============================================================
+
 tainted: 
 
 Non-zero if the kernel has been tainted.  Numeric values, which
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/fs/exec.c linux-2.6.9rc2/fs/exec.c
--- linux.vanilla-2.6.9rc2/fs/exec.c	2004-09-14 14:22:54.000000000 +0100
+++ linux-2.6.9rc2/fs/exec.c	2004-09-27 18:57:17.531502312 +0100
@@ -56,6 +56,8 @@
 
 int core_uses_pid;
 char core_pattern[65] = "core";
+int suid_dumpable = 0;
+
 /* The maximal length of core_pattern is also specified in sysctl.c */
 
 static struct linux_binfmt *formats;
@@ -843,6 +845,9 @@
 
 	if (current->euid == current->uid && current->egid == current->gid)
 		current->mm->dumpable = 1;
+	else
+		current->mm->dumpable = suid_dumpable;
+		
 	name = bprm->filename;
 	for (i=0; (ch = *(name++)) != '\0';) {
 		if (ch == '/')
@@ -859,7 +864,7 @@
 	if (bprm->e_uid != current->euid || bprm->e_gid != current->egid || 
 	    permission(bprm->file->f_dentry->d_inode,MAY_READ, NULL) ||
 	    (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP))
-		current->mm->dumpable = 0;
+		current->mm->dumpable = suid_dumpable;
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
@@ -1158,7 +1163,6 @@
 	retval = search_binary_handler(&bprm,regs);
 	if (retval >= 0) {
 		free_arg_pages(&bprm);
-
 		/* execve success */
 		security_bprm_free(&bprm);
 		return retval;
@@ -1374,7 +1378,9 @@
 	struct inode * inode;
 	struct file * file;
 	int retval = 0;
-
+	int fsuid = current->fsuid;
+	int flag = 0;
+	
 	binfmt = current->binfmt;
 	if (!binfmt || !binfmt->core_dump)
 		goto fail;
@@ -1383,6 +1389,17 @@
 		up_write(&mm->mmap_sem);
 		goto fail;
 	}
+	
+	/*
+	 *	We cannot trust fsuid as being the "true" uid of the
+	 *	process nor do we know its entire history. We only know it
+	 *	was tainted so we dump it as root in mode 2.
+	 */
+	if (mm->dumpable == 2)		/* Setuid core dump mode */
+	{
+		flag = O_EXCL;		/* Stop rewrite attacks */
+		current->fsuid = 0;	/* Dump root private */
+	}
 	mm->dumpable = 0;
 	init_completion(&mm->core_done);
 	current->signal->group_exit = 1;
@@ -1399,7 +1416,7 @@
  	lock_kernel();
 	format_corename(corename, core_pattern, signr);
 	unlock_kernel();
-	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
+	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE | flag, 0600);
 	if (IS_ERR(file))
 		goto fail_unlock;
 	inode = file->f_dentry->d_inode;
@@ -1423,6 +1440,7 @@
 close_fail:
 	filp_close(file, NULL);
 fail_unlock:
+	current->fsuid = fsuid;
 	complete_all(&mm->core_done);
 fail:
 	return retval;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/include/linux/binfmts.h linux-2.6.9rc2/include/linux/binfmts.h
--- linux.vanilla-2.6.9rc2/include/linux/binfmts.h	2004-09-14 14:19:39.000000000 +0100
+++ linux-2.6.9rc2/include/linux/binfmts.h	2004-09-27 16:09:52.140633848 +0100
@@ -69,6 +69,8 @@
 extern int search_binary_handler(struct linux_binprm *,struct pt_regs *);
 extern int flush_old_exec(struct linux_binprm * bprm);
 
+extern int suid_dumpable;
+
 /* Stack area protections */
 #define EXSTACK_DEFAULT   0	/* Whatever the arch defaults to */
 #define EXSTACK_DISABLE_X 1	/* Disable executable stacks */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/include/linux/sched.h linux-2.6.9rc2/include/linux/sched.h
--- linux.vanilla-2.6.9rc2/include/linux/sched.h	2004-09-14 14:22:57.000000000 +0100
+++ linux-2.6.9rc2/include/linux/sched.h	2004-09-27 16:12:04.656488376 +0100
@@ -230,7 +230,7 @@
 
 	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
 
-	unsigned dumpable:1;
+	unsigned dumpable:2;
 	cpumask_t cpu_vm_mask;
 
 	/* Architecture-specific MM context */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/include/linux/sysctl.h linux-2.6.9rc2/include/linux/sysctl.h
--- linux.vanilla-2.6.9rc2/include/linux/sysctl.h	2004-09-14 14:22:57.000000000 +0100
+++ linux-2.6.9rc2/include/linux/sysctl.h	2004-09-27 16:05:39.889981776 +0100
@@ -134,6 +134,7 @@
 	KERN_SPARC_SCONS_PWROFF=64, /* int: serial console power-off halt */
 	KERN_HZ_TIMER=65,	/* int: hz timer on or off */
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
+	KERN_SETUID_DUMPABLE=67, /* int: unknown nmi panic flag */
 };
 
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/kernel/sys.c linux-2.6.9rc2/kernel/sys.c
--- linux.vanilla-2.6.9rc2/kernel/sys.c	2004-09-14 14:22:57.000000000 +0100
+++ linux-2.6.9rc2/kernel/sys.c	2004-09-27 16:10:24.786670896 +0100
@@ -589,7 +589,7 @@
 	}
 	if (new_egid != old_egid)
 	{
-		current->mm->dumpable = 0;
+		current->mm->dumpable = suid_dumpable;
 		wmb();
 	}
 	if (rgid != (gid_t) -1 ||
@@ -619,7 +619,7 @@
 	{
 		if(old_egid != gid)
 		{
-			current->mm->dumpable=0;
+			current->mm->dumpable = suid_dumpable;
 			wmb();
 		}
 		current->gid = current->egid = current->sgid = current->fsgid = gid;
@@ -628,7 +628,7 @@
 	{
 		if(old_egid != gid)
 		{
-			current->mm->dumpable=0;
+			current->mm->dumpable = suid_dumpable;
 			wmb();
 		}
 		current->egid = current->fsgid = gid;
@@ -657,7 +657,7 @@
 
 	if(dumpclear)
 	{
-		current->mm->dumpable = 0;
+		current->mm->dumpable = suid_dumpable;
 		wmb();
 	}
 	current->uid = new_ruid;
@@ -714,7 +714,7 @@
 
 	if (new_euid != old_euid)
 	{
-		current->mm->dumpable=0;
+		current->mm->dumpable = suid_dumpable;
 		wmb();
 	}
 	current->fsuid = current->euid = new_euid;
@@ -762,7 +762,7 @@
 
 	if (old_euid != uid)
 	{
-		current->mm->dumpable = 0;
+		current->mm->dumpable = suid_dumpable;
 		wmb();
 	}
 	current->fsuid = current->euid = uid;
@@ -805,7 +805,7 @@
 	if (euid != (uid_t) -1) {
 		if (euid != current->euid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dumpable = suid_dumpable;
 			wmb();
 		}
 		current->euid = euid;
@@ -853,7 +853,7 @@
 	if (egid != (gid_t) -1) {
 		if (egid != current->egid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dumpable = suid_dumpable;
 			wmb();
 		}
 		current->egid = egid;
@@ -898,7 +898,7 @@
 	{
 		if (uid != old_fsuid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dumpable = suid_dumpable;
 			wmb();
 		}
 		current->fsuid = uid;
@@ -926,7 +926,7 @@
 	{
 		if (gid != old_fsgid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dumpable = suid_dumpable;
 			wmb();
 		}
 		current->fsgid = gid;
@@ -1681,7 +1681,7 @@
 				error = 1;
 			break;
 		case PR_SET_DUMPABLE:
-			if (arg2 != 0 && arg2 != 1) {
+			if (arg2 < 0 || arg2 > 2) {
 				error = -EINVAL;
 				break;
 			}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/kernel/sysctl.c linux-2.6.9rc2/kernel/sysctl.c
--- linux.vanilla-2.6.9rc2/kernel/sysctl.c	2004-09-14 14:22:57.000000000 +0100
+++ linux-2.6.9rc2/kernel/sysctl.c	2004-09-27 17:20:55.008579416 +0100
@@ -58,6 +58,7 @@
 extern int max_threads;
 extern int sysrq_enabled;
 extern int core_uses_pid;
+extern int suid_dumpable;
 extern char core_pattern[];
 extern int cad_pid;
 extern int pid_max;
@@ -619,6 +620,14 @@
 		.proc_handler   = &proc_unknown_nmi_panic,
 	},
 #endif
+	{
+		.ctl_name	= KERN_SETUID_DUMPABLE,
+		.procname	= "suid_dumpable",
+		.data		= &suid_dumpable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/security/commoncap.c linux-2.6.9rc2/security/commoncap.c
--- linux.vanilla-2.6.9rc2/security/commoncap.c	2004-09-14 14:22:57.000000000 +0100
+++ linux-2.6.9rc2/security/commoncap.c	2004-09-27 18:46:09.477062024 +0100
@@ -127,7 +127,7 @@
 
 	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
 	    !cap_issubset (new_permitted, current->cap_permitted)) {
-		current->mm->dumpable = 0;
+		current->mm->dumpable = suid_dumpable;
 
 		if (unsafe & ~LSM_UNSAFE_PTRACE_CAP) {
 			if (!capable(CAP_SETUID)) {
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc2/security/dummy.c linux-2.6.9rc2/security/dummy.c
--- linux.vanilla-2.6.9rc2/security/dummy.c	2004-09-14 14:19:28.000000000 +0100
+++ linux-2.6.9rc2/security/dummy.c	2004-09-27 18:45:46.958485368 +0100
@@ -174,7 +174,7 @@
 static void dummy_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
 {
 	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid) {
-		current->mm->dumpable = 0;
+		current->mm->dumpable = suid_dumpable;
 
 		if ((unsafe & ~LSM_UNSAFE_PTRACE_CAP) && !capable(CAP_SETUID)) {
 			bprm->e_uid = current->uid;
