Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130172AbQK1MHK>; Tue, 28 Nov 2000 07:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130559AbQK1MGu>; Tue, 28 Nov 2000 07:06:50 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19072 "EHLO pizda.ninka.net")
        by vger.kernel.org with ESMTP id <S130172AbQK1MGn>;
        Tue, 28 Nov 2000 07:06:43 -0500
Date: Tue, 28 Nov 2000 03:21:01 -0800
Message-Id: <200011281121.DAA01404@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: bsg@uniyar.ac.ru
CC: linux-kernel@vger.kernel.org, andy@lysaker.kvaerner.no
In-Reply-To: <Pine.GSO.3.96.SK.1001124163030.25896C-100000@univ.uniyar.ac.ru>
        (bsg@uniyar.ac.ru)
Subject: Re: Kernel Oops on locking sockets via fcntl()
In-Reply-To: <Pine.GSO.3.96.SK.1001124163030.25896C-100000@univ.uniyar.ac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This should fix the bug, there were some cases outside
of file locking (bonus points to anyone who can craft
an exploit for the ELF interpreter case :-):

--- ./fs/binfmt_elf.c.~1~	Mon Oct 30 11:34:25 2000
+++ ./fs/binfmt_elf.c	Tue Nov 28 03:03:43 2000
@@ -247,7 +247,7 @@
 		goto out;
 	if (!elf_check_arch(interp_elf_ex))
 		goto out;
-	if (!interpreter->f_op->mmap)
+	if (!interpreter->f_op || !interpreter->f_op->mmap)
 		goto out;
 
 	/*
@@ -364,7 +364,7 @@
 
 	do_brk(0, text_data);
 	retval = -ENOEXEC;
-	if (!interpreter->f_op->read)
+	if (!interpreter->f_op || !interpreter->f_op->read)
 		goto out;
 	retval = interpreter->f_op->read(interpreter, addr, text_data, &offset);
 	if (retval < 0)
@@ -789,7 +789,7 @@
 
 	/* First of all, some simple consistency checks */
 	if (elf_ex.e_type != ET_EXEC || elf_ex.e_phnum > 2 ||
-	   !elf_check_arch(&elf_ex) || !file->f_op->mmap)
+	   !elf_check_arch(&elf_ex) || !file->f_op || !file->f_op->mmap)
 		goto out;
 
 	/* Now read in all of the header information */
--- ./fs/dquot.c.~1~	Fri Nov 17 17:24:03 2000
+++ ./fs/dquot.c	Tue Nov 28 03:05:43 2000
@@ -1474,7 +1474,7 @@
 	if (IS_ERR(f))
 		goto out_lock;
 	error = -EIO;
-	if (!f->f_op->read && !f->f_op->write)
+	if (!f->f_op || (!f->f_op->read && !f->f_op->write))
 		goto out_f;
 	inode = f->f_dentry->d_inode;
 	error = -EACCES;
--- ./fs/exec.c.~1~	Thu Nov  9 20:44:59 2000
+++ ./fs/exec.c	Tue Nov 28 03:15:42 2000
@@ -604,6 +604,8 @@
 	/* Huh? We had already checked for MAY_EXEC, WTF do we check this? */
 	if (!(mode & 0111))	/* with at least _one_ execute bit set */
 		return -EACCES;
+	if (bprm->file->f_op == NULL)
+		return -EACCES;
 
 	bprm->e_uid = current->euid;
 	bprm->e_gid = current->egid;
--- ./fs/locks.c.~1~	Tue Nov  7 21:04:51 2000
+++ ./fs/locks.c	Tue Nov 28 03:13:34 2000
@@ -511,7 +511,8 @@
 	struct file_lock *fl = *thisfl_p;
 	int (*lock)(struct file *, int, struct file_lock *);
 
-	if ((lock = fl->fl_file->f_op->lock) != NULL) {
+	if (fl->fl_file->f_op &&
+	    (lock = fl->fl_file->f_op->lock) != NULL) {
 		fl->fl_type = F_UNLCK;
 		lock(fl->fl_file, F_SETLK, fl);
 	}
@@ -1355,7 +1356,7 @@
 	if (!flock_to_posix_lock(filp, &file_lock, &flock))
 		goto out_putf;
 
-	if (filp->f_op->lock) {
+	if (filp->f_op && filp->f_op->lock) {
 		error = filp->f_op->lock(filp, F_GETLK, &file_lock);
 		if (error < 0)
 			goto out_putf;
@@ -1479,7 +1480,7 @@
 		goto out_putf;
 	}
 
-	if (filp->f_op->lock != NULL) {
+	if (filp->f_op && filp->f_op->lock != NULL) {
 		error = filp->f_op->lock(filp, cmd, file_lock);
 		if (error < 0)
 			goto out_putf;
@@ -1520,7 +1521,7 @@
 	if (!flock64_to_posix_lock(filp, &file_lock, &flock))
 		goto out_putf;
 
-	if (filp->f_op->lock) {
+	if (filp->f_op && filp->f_op->lock) {
 		error = filp->f_op->lock(filp, F_GETLK, &file_lock);
 		if (error < 0)
 			goto out_putf;
@@ -1617,7 +1618,7 @@
 		goto out_putf;
 	}
 
-	if (filp->f_op->lock != NULL) {
+	if (filp->f_op && filp->f_op->lock != NULL) {
 		error = filp->f_op->lock(filp, cmd, file_lock);
 		if (error < 0)
 			goto out_putf;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
