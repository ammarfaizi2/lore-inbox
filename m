Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313827AbSDUUXN>; Sun, 21 Apr 2002 16:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313830AbSDUUXM>; Sun, 21 Apr 2002 16:23:12 -0400
Received: from rrcs-sw-24-242-143-126.biz.rr.com ([24.242.143.126]:26377 "HELO
	nawilson.com") by vger.kernel.org with SMTP id <S313827AbSDUUXJ>;
	Sun, 21 Apr 2002 16:23:09 -0400
Date: 21 Apr 2002 20:23:03 -0000
Message-ID: <20020421202303.1884.qmail@nawilson.com>
From: "Neil A. Wilson" <nawilson@nawilson.com>
To: linux-kernel@vger.kernel.org
Cc: "Willy Tarreau" <wtarreau@free.fr>
Subject: Re: [PATCH] Allow setuid/setgid core files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for no subject on the first one.

On Sun, 2002-04-21 at 09:10, Neil A. Wilson wrote:
> Thanks for the feedback.  You bring up a good point here.  Currently the
> dump is owned by the effective uid.  I'll look into writing it as root.

I've created an updated version of the allow setid core patch that
writes the core file as root if the process has had superuser privileges
at some point in its life (based on the PF_SUPERPRIV process flag).  The
new patch is below.

Neil



diff -urN linux-2.4.18/fs/exec.c linux-2.4.18.patch/fs/exec.c
--- linux-2.4.18/fs/exec.c	Fri Dec 21 11:41:55 2001
+++ linux-2.4.18.patch/fs/exec.c	Sun Apr 21 06:19:40 2002
@@ -47,6 +47,7 @@
 #endif

 int core_uses_pid;
+int allow_setid_core;

 static struct linux_binfmt *formats;
 static rwlock_t binfmt_lock = RW_LOCK_UNLOCKED;
@@ -552,7 +553,7 @@

 	current->sas_ss_sp = current->sas_ss_size = 0;

-	if (current->euid == current->uid && current->egid == current->gid)
+	if (allow_setid_core || (current->euid == current->uid && current->egid == current->gid))
 		current->mm->dumpable = 1;
 	name = bprm->filename;
 	for (i=0; (ch = *(name++)) != '\0';) {
@@ -568,7 +569,7 @@

 	de_thread(current);

-	if (bprm->e_uid != current->euid || bprm->e_gid != current->egid ||
+	if ((!allow_setid_core && (bprm->e_uid != current->euid || bprm->e_gid != current->egid)) ||
 	    permission(bprm->file->f_dentry->d_inode,MAY_READ))
 		current->mm->dumpable = 0;

@@ -690,7 +691,7 @@
 				current->cap_inheritable);
 	new_permitted = cap_combine(new_permitted, working);

-	if (bprm->e_uid != current->uid || bprm->e_gid != current->gid ||
+	if ((!allow_setid_core && (bprm->e_uid != current->uid || bprm->e_gid != current->gid)) ||
 	    !cap_issubset(new_permitted, current->cap_permitted)) {
                 current->mm->dumpable = 0;

@@ -940,6 +941,9 @@
 	struct file * file;
 	struct inode * inode;
 	int retval = 0;
+	kernel_cap_t saved_ecap = current->cap_effective;
+	uid_t saved_fsuid = current->fsuid;
+	gid_t saved_fsgid = current->fsgid;

 	lock_kernel();
 	binfmt = current->binfmt;
@@ -955,6 +959,14 @@
 	corename[4] = '\0';
  	if (core_uses_pid || atomic_read(&current->mm->mm_users) != 1)
  		sprintf(&corename[4], ".%d", current->pid);
+
+	/* If superuser privs were used, then write core as root */
+	if (current->flags & PF_SUPERPRIV) {
+		current->cap_effective |= CAP_FULL_SET;
+		current->fsuid = 0;
+		current->fsgid = 0;
+	}
+
 	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
 	if (IS_ERR(file))
 		goto fail;
@@ -978,6 +990,11 @@
 close_fail:
 	filp_close(file, NULL);
 fail:
+	if (current->flags & PF_SUPERPRIV) {
+		current->cap_effective = saved_ecap;
+		current->fsuid = saved_fsuid;
+		current->fsgid = saved_fsgid;
+	}
 	unlock_kernel();
 	return retval;
 }
diff -urN linux-2.4.18/include/linux/sysctl.h linux-2.4.18.patch/include/linux/sysctl.h
--- linux-2.4.18/include/linux/sysctl.h	Sat Apr 20 05:44:06 2002
+++ linux-2.4.18.patch/include/linux/sysctl.h	Sat Apr 20 06:06:33 2002
@@ -124,6 +124,7 @@
 	KERN_CORE_USES_PID=52,		/* int: use core or core.%pid */
 	KERN_TAINTED=53,	/* int: various kernel tainted flags */
 	KERN_CADPID=54,		/* int: PID of the process to notify on CAD */
+	KERN_ALLOW_SETID_CORE=55,	/* int: dump core from setid processes */
 };


diff -urN linux-2.4.18/kernel/sys.c linux-2.4.18.patch/kernel/sys.c
--- linux-2.4.18/kernel/sys.c	Mon Feb 25 13:38:13 2002
+++ linux-2.4.18.patch/kernel/sys.c	Sat Apr 20 06:34:51 2002
@@ -18,6 +18,8 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>

+extern int allow_setid_core;
+
 /*
  * this is where the system-wide overflow UID and GID are defined, for
  * architectures that now have 32-bit UID/GID but didn't in the past
@@ -398,7 +400,7 @@
 			return -EPERM;
 		}
 	}
-	if (new_egid != old_egid)
+	if (!allow_setid_core && new_egid != old_egid)
 	{
 		current->mm->dumpable = 0;
 		wmb();
@@ -423,7 +425,7 @@

 	if (capable(CAP_SETGID))
 	{
-		if(old_egid != gid)
+		if(!allow_setid_core && old_egid != gid)
 		{
 			current->mm->dumpable=0;
 			wmb();
@@ -432,7 +434,7 @@
 	}
 	else if ((gid == current->gid) || (gid == current->sgid))
 	{
-		if(old_egid != gid)
+		if(!allow_setid_core && old_egid != gid)
 		{
 			current->mm->dumpable=0;
 			wmb();
@@ -557,10 +559,10 @@
 			return -EPERM;
 	}

-	if (new_ruid != old_ruid && set_user(new_ruid, new_euid != old_euid) < 0)
+	if (new_ruid != old_ruid && set_user(new_ruid, !allow_setid_core && new_euid != old_euid) < 0)
 		return -EAGAIN;

-	if (new_euid != old_euid)
+	if (!allow_setid_core && new_euid != old_euid)
 	{
 		current->mm->dumpable=0;
 		wmb();
@@ -601,13 +603,13 @@
 	new_suid = old_suid;

 	if (capable(CAP_SETUID)) {
-		if (uid != old_ruid && set_user(uid, old_euid != uid) < 0)
+		if (uid != old_ruid && set_user(uid, !allow_setid_core && old_euid != uid) < 0)
 			return -EAGAIN;
 		new_suid = uid;
 	} else if ((uid != current->uid) && (uid != new_suid))
 		return -EPERM;

-	if (old_euid != uid)
+	if (!allow_setid_core && old_euid != uid)
 	{
 		current->mm->dumpable = 0;
 		wmb();
@@ -645,11 +647,11 @@
 			return -EPERM;
 	}
 	if (ruid != (uid_t) -1) {
-		if (ruid != current->uid && set_user(ruid, euid != current->euid) < 0)
+		if (ruid != current->uid && set_user(ruid, !allow_setid_core && euid != current->euid) < 0)
 			return -EAGAIN;
 	}
 	if (euid != (uid_t) -1) {
-		if (euid != current->euid)
+		if (!allow_setid_core && euid != current->euid)
 		{
 			current->mm->dumpable = 0;
 			wmb();
@@ -695,7 +697,7 @@
 			return -EPERM;
 	}
 	if (egid != (gid_t) -1) {
-		if (egid != current->egid)
+		if (!allow_setid_core && egid != current->egid)
 		{
 			current->mm->dumpable = 0;
 			wmb();
@@ -737,7 +739,7 @@
 	    uid == current->suid || uid == current->fsuid ||
 	    capable(CAP_SETUID))
 	{
-		if (uid != old_fsuid)
+		if (!allow_setid_core && uid != old_fsuid)
 		{
 			current->mm->dumpable = 0;
 			wmb();
@@ -779,7 +781,7 @@
 	    gid == current->sgid || gid == current->fsgid ||
 	    capable(CAP_SETGID))
 	{
-		if (gid != old_fsgid)
+		if (!allow_setid_core && gid != old_fsgid)
 		{
 			current->mm->dumpable = 0;
 			wmb();
diff -urN linux-2.4.18/kernel/sysctl.c linux-2.4.18.patch/kernel/sysctl.c
--- linux-2.4.18/kernel/sysctl.c	Fri Dec 21 11:42:04 2001
+++ linux-2.4.18.patch/kernel/sysctl.c	Sat Apr 20 06:27:17 2002
@@ -50,6 +50,7 @@
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern int cad_pid;
+extern int allow_setid_core;

 /* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
 static int maxolduid = 65535;
@@ -175,6 +176,8 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_CAP_BSET, "cap-bound", &cap_bset, sizeof(kernel_cap_t),
 	 0600, NULL, &proc_dointvec_bset},
+	{KERN_ALLOW_SETID_CORE, "allow_setid_core", &allow_setid_core, sizeof(int),
+	 0600, NULL, &proc_dointvec},
 #ifdef CONFIG_BLK_DEV_INITRD
 	{KERN_REALROOTDEV, "real-root-dev", &real_root_dev, sizeof(int),
 	 0644, NULL, &proc_dointvec},
