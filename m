Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270452AbTGWRCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270454AbTGWRCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:02:31 -0400
Received: from ns.suse.de ([213.95.15.193]:56580 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S270452AbTGWRC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:02:28 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Labs, SuSE Linux AG
To: Marcelo Tossati <marcelo@conectiva.com.br>
Subject: [BUG] 2.4.22-pre7: unshare-files fix breaks file locks
Date: Wed, 23 Jul 2003 19:17:34 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alexander Viro <viro@math.psu.edu>, Olaf Kirch <okir@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_uMsH/Wqh7zjDCmH"
Message-Id: <200307231917.34028.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_uMsH/Wqh7zjDCmH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Marcelo,

as already mentioned in private mail, the unshare-files patch in 2.4.22-pre7 
breaks POSIX file lock semantics after an execve(2): unshare_files() gives 
the process a new task_struct->files struct. Existing POSIX file locks 
continue to refer to the old files struct. POSIX requires that the locks 
migrate to the exec'ed process. (The LSB checks that.)

The fix is to steal the locks from the old file struct after unshare_files(), 
when it is known that the new, unshared files struct will be used.

The fixes introduce changes in behavior for processes that share a common 
files struct, a case which can be constructed using clone(2). This use of 
clone is pathological. Before the unshare-files fix, the clones would still 
share the same files struct. With unshare files, the exec'ed process would 
lose the locks. We should ensure that the exec'ed process finally holds the 
locks.


Cheers,
Andreas.

------------------------------------------------------------------
 Andreas Gruenbacher                     SuSE Labs, SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany

--Boundary-00=_uMsH/Wqh7zjDCmH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="file-locking-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="file-locking-fix.diff"

Index: linux-2.4.22-pre7.orig/fs/binfmt_elf.c
===================================================================
--- linux-2.4.22-pre7.orig.orig/fs/binfmt_elf.c	2003-07-22 20:15:24.000000000 +0200
+++ linux-2.4.22-pre7.orig/fs/binfmt_elf.c	2003-07-23 18:27:40.000000000 +0200
@@ -798,6 +798,9 @@ static int load_elf_binary(struct linux_
 		send_sig(SIGTRAP, current, 0);
 	retval = 0;
 out:
+	if (!retval)
+		steal_locks(files, current->files);
+
 	return retval;
 
 	/* error cleanup */
Index: linux-2.4.22-pre7.orig/fs/exec.c
===================================================================
--- linux-2.4.22-pre7.orig.orig/fs/exec.c	2003-07-22 20:15:24.000000000 +0200
+++ linux-2.4.22-pre7.orig/fs/exec.c	2003-07-23 18:27:40.000000000 +0200
@@ -582,6 +582,7 @@ int flush_old_exec(struct linux_binprm *
 	retval = unshare_files();
 	if(retval)
 		goto flush_failed;
+	steal_locks(files, current->files);
 	put_files_struct(files);
 	
 	/* 
Index: linux-2.4.22-pre7.orig/fs/locks.c
===================================================================
--- linux-2.4.22-pre7.orig.orig/fs/locks.c	2003-07-22 20:15:24.000000000 +0200
+++ linux-2.4.22-pre7.orig/fs/locks.c	2003-07-23 18:41:52.000000000 +0200
@@ -1937,6 +1937,23 @@ done:
 	return length;
 }
 
+void steal_locks(fl_owner_t from, fl_owner_t to)
+{
+	struct list_head *tmp;
+
+	if (from == to)
+		return;
+
+	lock_kernel();
+	list_for_each(tmp, &file_lock_list) {
+		struct file_lock *fl = list_entry(tmp, struct file_lock,
+						  fl_link);
+		if (fl->fl_owner == from)
+			fl->fl_owner = to;
+	}
+	unlock_kernel();
+}
+
 #ifdef MSNFS
 /**
  *	lock_may_read - checks that the region is free of locks
Index: linux-2.4.22-pre7.orig/include/linux/fs.h
===================================================================
--- linux-2.4.22-pre7.orig.orig/include/linux/fs.h	2003-07-22 20:15:24.000000000 +0200
+++ linux-2.4.22-pre7.orig/include/linux/fs.h	2003-07-23 18:27:40.000000000 +0200
@@ -673,6 +673,7 @@ extern int __get_lease(struct inode *ino
 extern time_t lease_get_mtime(struct inode *);
 extern int lock_may_read(struct inode *, loff_t start, unsigned long count);
 extern int lock_may_write(struct inode *, loff_t start, unsigned long count);
+extern void steal_locks(fl_owner_t from, fl_owner_t to);
 
 struct fasync_struct {
 	int	magic;

--Boundary-00=_uMsH/Wqh7zjDCmH--

