Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUDWTDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUDWTDk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbUDWTDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:03:40 -0400
Received: from smtpout.mac.com ([17.250.248.46]:58334 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S263295AbUDWTDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:03:32 -0400
Subject: Re: [PATCH] coredump - as root not only if euid switched
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <20040423101025.J21045@build.pdx.osdl.net>
References: <10159129.1082704563424.JavaMail.pwaechtler@mac.com>
	 <20040423101025.J21045@build.pdx.osdl.net>
Content-Type: multipart/mixed; boundary="=-o83n7I7huObIpJ9iR1rB"
Message-Id: <1082747153.2713.91.camel@picklock.adams.family>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 23 Apr 2004 21:05:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-o83n7I7huObIpJ9iR1rB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Fr, 2004-04-23 um 19.10 schrieb Chris Wright:
> * Peter Waechtler (pwaechtler@mac.com) wrote:
> > On Thursday, April 22, 2004, at 09:53PM, Chris Wright <chrisw@osdl.org> wrote:
> > >This patch breaks various ptrace() checks.
> > 
> > Care to share your wisdom? No? Then please don't reply
> 
> -		current->mm->dumpable = 0;
> +		current->mm->dump_as_root = 1;
> 
> Changes like that break ptrace authentication checks.  Look more closely
> at what mm->dumpable is used for, you'll see checks like:
> 
> 	if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
> 		goto out;


added checks like

	if ((task->mm->dump_as_root || !task->mm->dumpable)
			&& !capable(CAP_SYS_PTRACE))

in kernel/ptrace.c and fs/proc/base.c

I guess the checks will get more and more complicated, perhaps
we should invent a special flag dont_ptrace or so



--=-o83n7I7huObIpJ9iR1rB
Content-Disposition: attachment; filename=coredump-patch
Content-Type: text/x-patch; name=coredump-patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -Nur -X dontdiff linux-2.6.5/fs/exec.c linux-2.6/fs/exec.c
--- linux-2.6.5/fs/exec.c	2004-04-08 22:06:32.000000000 +0200
+++ linux-2.6/fs/exec.c	2004-04-22 21:17:42.000000000 +0200
@@ -1378,6 +1378,10 @@
 		goto fail;
 	}
 	mm->dumpable = 0;
+	if (mm->dump_as_root){
+		current->fsuid = 0;
+		current->fsgid = 0;
+	}
 	init_completion(&mm->core_done);
 	current->signal->group_exit = 1;
 	current->signal->group_exit_code = exit_code;
@@ -1387,9 +1391,23 @@
 		goto fail_unlock;
 
  	format_corename(corename, core_pattern, signr);
-	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
-	if (IS_ERR(file))
-		goto fail_unlock;
+	file = filp_open(corename, O_CREAT | O_EXCL | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
+	if (IS_ERR(file)){
+        long error;
+        mm_segment_t old_fs = get_fs();
+
+        set_fs(KERNEL_DS);
+        error = sys_unlink(corename);
+        set_fs(old_fs);
+        if (error)
+			goto fail_unlock;
+		file = filp_open(corename, O_CREAT | O_EXCL | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
+		if (IS_ERR(file)){
+			printk(KERN_WARNING "pid %d doesn't dump core to %s because of creation race\n",
+				current->pid, corename);
+			goto fail_unlock;
+		}
+	}
 	inode = file->f_dentry->d_inode;
 	if (inode->i_nlink > 1)
 		goto close_fail;	/* multiple links - don't dump */
diff -Nur -X dontdiff linux-2.6.5/fs/proc/base.c linux-2.6/fs/proc/base.c
--- linux-2.6.5/fs/proc/base.c	2004-04-08 22:06:33.000000000 +0200
+++ linux-2.6/fs/proc/base.c	2004-04-23 19:41:57.000000000 +0200
@@ -299,7 +299,8 @@
 	     (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
 		goto out;
 	rmb();
-	if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
+	if ((task->mm->dump_as_root || !task->mm->dumpable)
+			&& !capable(CAP_SYS_PTRACE))
 		goto out;
 	if (security_ptrace(current, task))
 		goto out;
@@ -924,7 +925,7 @@
 	task_lock(task);
 	mm = task->mm;
 	if (mm)
-		dumpable = mm->dumpable;
+		dumpable = !mm->dump_as_root || mm->dumpable;
 	task_unlock(task);
 	return dumpable;
 }
diff -Nur -X dontdiff linux-2.6.5/include/linux/sched.h linux-2.6/include/linux/sched.h
--- linux-2.6.5/include/linux/sched.h	2004-04-08 22:07:23.000000000 +0200
+++ linux-2.6/include/linux/sched.h	2004-04-08 19:14:17.000000000 +0200
@@ -211,6 +211,7 @@
 	unsigned long saved_auxv[40]; /* for /proc/PID/auxv */
 
 	unsigned dumpable:1;
+	unsigned dump_as_root:1;
 #ifdef CONFIG_HUGETLB_PAGE
 	int used_hugetlb;
 #endif
diff -Nur -X dontdiff linux-2.6.5/kernel/ptrace.c linux-2.6/kernel/ptrace.c
--- linux-2.6.5/kernel/ptrace.c	2004-04-08 22:07:24.000000000 +0200
+++ linux-2.6/kernel/ptrace.c	2004-04-23 19:38:45.000000000 +0200
@@ -97,7 +97,8 @@
  	    (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE))
 		goto bad;
 	rmb();
-	if (!task->mm->dumpable && !capable(CAP_SYS_PTRACE))
+	if ((task->mm->dump_as_root || !task->mm->dumpable) 
+			&& !capable(CAP_SYS_PTRACE))
 		goto bad;
 	/* the same process cannot be attached many times */
 	if (task->ptrace & PT_PTRACED)
diff -Nur -X dontdiff linux-2.6.5/kernel/sys.c linux-2.6/kernel/sys.c
--- linux-2.6.5/kernel/sys.c	2004-04-08 22:06:37.000000000 +0200
+++ linux-2.6/kernel/sys.c	2004-04-08 19:22:10.000000000 +0200
@@ -573,7 +573,7 @@
 	}
 	if (new_egid != old_egid)
 	{
-		current->mm->dumpable = 0;
+		current->mm->dump_as_root = 1;
 		wmb();
 	}
 	if (rgid != (gid_t) -1 ||
@@ -603,7 +603,7 @@
 	{
 		if(old_egid != gid)
 		{
-			current->mm->dumpable=0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->gid = current->egid = current->sgid = current->fsgid = gid;
@@ -612,7 +612,7 @@
 	{
 		if(old_egid != gid)
 		{
-			current->mm->dumpable=0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->egid = current->fsgid = gid;
@@ -641,7 +641,7 @@
 
 	if(dumpclear)
 	{
-		current->mm->dumpable = 0;
+		current->mm->dump_as_root = 1;
 		wmb();
 	}
 	current->uid = new_ruid;
@@ -698,7 +698,7 @@
 
 	if (new_euid != old_euid)
 	{
-		current->mm->dumpable=0;
+		current->mm->dump_as_root = 1;
 		wmb();
 	}
 	current->fsuid = current->euid = new_euid;
@@ -746,7 +746,7 @@
 
 	if (old_euid != uid)
 	{
-		current->mm->dumpable = 0;
+		current->mm->dump_as_root = 1;
 		wmb();
 	}
 	current->fsuid = current->euid = uid;
@@ -789,7 +789,7 @@
 	if (euid != (uid_t) -1) {
 		if (euid != current->euid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->euid = euid;
@@ -837,7 +837,7 @@
 	if (egid != (gid_t) -1) {
 		if (egid != current->egid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->egid = egid;
@@ -882,7 +882,7 @@
 	{
 		if (uid != old_fsuid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->fsuid = uid;
@@ -910,7 +910,7 @@
 	{
 		if (gid != old_fsgid)
 		{
-			current->mm->dumpable = 0;
+			current->mm->dump_as_root = 1;
 			wmb();
 		}
 		current->fsgid = gid;

--=-o83n7I7huObIpJ9iR1rB--

