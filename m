Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272231AbTHIA6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 20:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272226AbTHIA5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 20:57:07 -0400
Received: from mail.suse.de ([213.95.15.193]:19208 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S272161AbTHIAcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 20:32:43 -0400
Subject: [PATCH] 2.4.22-rc2 steal_locks and load_elf_binary cleanups
From: Andreas Gruenbacher <agruen@suse.de>
To: Marcelo Tossati <marcelo@conectiva.com.br>,
       Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-4en1ulshZMHp/2OToNMZ"
Organization: SuSE Labs, SuSE Linux AG
Message-Id: <1060389162.1795.33.camel@bree.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 Aug 2003 02:32:42 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4en1ulshZMHp/2OToNMZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

please find attached some cleanups. The unwind code of load_elf_binary
caused a nasty regression in combination with 00_binfmt-elf-checks-2
from
ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/kernels/2.4.22pre6aa1/, so with that patch it's actually a fix.


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SuSE Labs, SuSE Linux AG <http://www.suse.de/>


--=-4en1ulshZMHp/2OToNMZ
Content-Disposition: attachment; filename=steal-locks-cleanup.diff
Content-Type: text/plain; name=steal-locks-cleanup.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

steal_locks cleanup

Remove the unneeded second parameter of steal_locks. Move
steal_locks call right above put_files_struct in load_elf_binary.

Index: linux-2.4.22-rc2.orig/include/linux/fs.h
===================================================================
--- linux-2.4.22-rc2.orig.orig/include/linux/fs.h	2003-08-09 01:53:16.000000000 +0200
+++ linux-2.4.22-rc2.orig/include/linux/fs.h	2003-08-09 01:53:19.000000000 +0200
@@ -674,7 +674,7 @@ extern int __get_lease(struct inode *ino
 extern time_t lease_get_mtime(struct inode *);
 extern int lock_may_read(struct inode *, loff_t start, unsigned long count);
 extern int lock_may_write(struct inode *, loff_t start, unsigned long count);
-extern void steal_locks(fl_owner_t from, fl_owner_t to);
+extern void steal_locks(fl_owner_t from);
 
 struct fasync_struct {
 	int	magic;
Index: linux-2.4.22-rc2.orig/fs/exec.c
===================================================================
--- linux-2.4.22-rc2.orig.orig/fs/exec.c	2003-08-09 01:53:16.000000000 +0200
+++ linux-2.4.22-rc2.orig/fs/exec.c	2003-08-09 01:53:19.000000000 +0200
@@ -582,7 +582,7 @@ int flush_old_exec(struct linux_binprm *
 	retval = unshare_files();
 	if(retval)
 		goto flush_failed;
-	steal_locks(files, current->files);
+	steal_locks(files);
 	put_files_struct(files);
 	
 	/* 
Index: linux-2.4.22-rc2.orig/fs/locks.c
===================================================================
--- linux-2.4.22-rc2.orig.orig/fs/locks.c	2003-08-09 01:53:16.000000000 +0200
+++ linux-2.4.22-rc2.orig/fs/locks.c	2003-08-09 01:53:19.000000000 +0200
@@ -1937,11 +1937,11 @@ done:
 	return length;
 }
 
-void steal_locks(fl_owner_t from, fl_owner_t to)
+void steal_locks(fl_owner_t from)
 {
 	struct list_head *tmp;
 
-	if (from == to)
+	if (from == current->files)
 		return;
 
 	lock_kernel();
@@ -1949,7 +1949,7 @@ void steal_locks(fl_owner_t from, fl_own
 		struct file_lock *fl = list_entry(tmp, struct file_lock,
 						  fl_link);
 		if (fl->fl_owner == from)
-			fl->fl_owner = to;
+			fl->fl_owner = current->files;
 	}
 	unlock_kernel();
 }
Index: linux-2.4.22-rc2.orig/fs/binfmt_elf.c
===================================================================
--- linux-2.4.22-rc2.orig.orig/fs/binfmt_elf.c	2003-08-09 01:53:16.000000000 +0200
+++ linux-2.4.22-rc2.orig/fs/binfmt_elf.c	2003-08-09 01:53:38.000000000 +0200
@@ -480,7 +480,6 @@ static int load_elf_binary(struct linux_
 	files = current->files;		/* Refcounted so ok */
 	if(unshare_files() < 0)
 		goto out_free_ph;
-	steal_locks(files, current->files);
 
 	/* exec will make our files private anyway, but for the a.out
 	   loader stuff we need to do it earlier */
@@ -603,6 +602,7 @@ static int load_elf_binary(struct linux_
 		goto out_free_dentry;
 
 	/* Discard our unneeded old files struct */
+	steal_locks(files);
 	put_files_struct(files);
 
 	/* OK, This is the point of no return */
@@ -813,7 +813,6 @@ out_free_file:
 out_free_fh:
 	ftmp = current->files;
 	current->files = files;
-	steal_locks(ftmp, current->files);
 	put_files_struct(ftmp);
 out_free_ph:
 	kfree(elf_phdata);

--=-4en1ulshZMHp/2OToNMZ
Content-Disposition: attachment; filename=load_elf_binary-unwind1.diff
Content-Type: text/plain; name=load_elf_binary-unwind1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Clean up load_elf_binary unwind code (1)

To prevent from reusing a deallocated files struct in load_elf_binary(),
simplify the function's unwind code. Bailing out to the unwind code
below the `point of no return' would be incorrect without this.

Index: linux-2.4.22-rc2.orig/fs/binfmt_elf.c
===================================================================
--- linux-2.4.22-rc2.orig.orig/fs/binfmt_elf.c	2003-08-09 01:52:16.000000000 +0200
+++ linux-2.4.22-rc2.orig/fs/binfmt_elf.c	2003-08-09 01:52:46.000000000 +0200
@@ -604,6 +604,7 @@ static int load_elf_binary(struct linux_
 	/* Discard our unneeded old files struct */
 	steal_locks(files);
 	put_files_struct(files);
+	files = NULL;
 
 	/* OK, This is the point of no return */
 	current->mm->start_data = 0;
@@ -811,9 +812,11 @@ out_free_interp:
 out_free_file:
 	sys_close(elf_exec_fileno);
 out_free_fh:
-	ftmp = current->files;
-	current->files = files;
-	put_files_struct(ftmp);
+	if (files) {
+		ftmp = current->files;
+		current->files = files;
+		put_files_struct(ftmp);
+	}
 out_free_ph:
 	kfree(elf_phdata);
 	goto out;

--=-4en1ulshZMHp/2OToNMZ
Content-Disposition: attachment; filename=load_elf_binary-unwind2.diff
Content-Type: text/plain; name=load_elf_binary-unwind2.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Clean up load_elf_binary unwind code (2)

Jump to unwind code instead of cleaning up by hand in load_elf_binary.
This is only correct in combination with load_elf_binary-unwind1.diff.

Index: linux-2.4.22-rc2.orig/fs/binfmt_elf.c
===================================================================
--- linux-2.4.22-rc2.orig.orig/fs/binfmt_elf.c	2003-08-09 01:50:50.000000000 +0200
+++ linux-2.4.22-rc2.orig/fs/binfmt_elf.c	2003-08-09 01:46:40.000000000 +0200
@@ -715,18 +715,16 @@ static int load_elf_binary(struct linux_
 			elf_entry = load_elf_interp(&interp_elf_ex,
 						    interpreter,
 						    &interp_load_addr);
-
-		allow_write_access(interpreter);
-		fput(interpreter);
-		kfree(elf_interpreter);
-
 		if (BAD_ADDR(elf_entry)) {
 			printk(KERN_ERR "Unable to load interpreter\n");
-			kfree(elf_phdata);
 			send_sig(SIGSEGV, current, 0);
 			retval = -ENOEXEC; /* Nobody gets to see this, but.. */
-			goto out;
+			goto out_free_dentry;
 		}
+
+		allow_write_access(interpreter);
+		fput(interpreter);
+		kfree(elf_interpreter);
 	}
 
 	kfree(elf_phdata);

--=-4en1ulshZMHp/2OToNMZ--

