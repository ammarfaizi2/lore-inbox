Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264634AbUDVTl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264634AbUDVTl4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUDVTl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:41:56 -0400
Received: from smtpout.mac.com ([17.250.248.85]:24541 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S264634AbUDVTls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:41:48 -0400
Subject: Re: [PATCH] coredump - as root not only if euid switched
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-Reply-To: <20040422025638.0bf86599.akpm@osdl.org>
References: <2899705.1082626850875.JavaMail.pwaechtler@mac.com>
	 <20040422025638.0bf86599.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-gG/30Y7yyF2X2gJN4bnZ"
Message-Id: <1082663036.2592.1.camel@picklock.adams.family>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 22 Apr 2004 21:43:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gG/30Y7yyF2X2gJN4bnZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Do, 2004-04-22 um 11.56 schrieb Andrew Morton:
> Peter Waechtler <pwaechtler@mac.com> wrote:
> >
> >  >(why are you trying to unlink the old file anyway?)
> >  >
> > 
> >  For security measure :O
> >  I tried on solaris: touch the core file as user, open it and wait, dump core
> >  as root -> nope, couldn't read the damn core - it was unlinked and created!
> 
> hm, OK.  There's a window in which someone can come in and recreate the
> file, but the open is using O_EXCL|O_CREATE so that seems safe enough.

So here is the updated patch with an open coded call to sys_unlink


--=-gG/30Y7yyF2X2gJN4bnZ
Content-Description: 
Content-Disposition: inline; filename=coredump-patch
Content-Type: text/x-patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -Nur -X dontdiff linux-2.6.5/fs/exec.c linux-2.6/fs/exec.c
--- linux-2.6.5/fs/exec.c	2004-04-08 22:06:32.000000000 +0200
+++ linux-2.6/fs/exec.c	2004-04-22 20:44:59.000000000 +0200
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

--=-gG/30Y7yyF2X2gJN4bnZ--

