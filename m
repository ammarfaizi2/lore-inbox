Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268747AbTCCTw7>; Mon, 3 Mar 2003 14:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268750AbTCCTw7>; Mon, 3 Mar 2003 14:52:59 -0500
Received: from mail2.mail.iol.ie ([194.125.2.193]:48800 "EHLO
	mail2.mail.iol.ie") by vger.kernel.org with ESMTP
	id <S268747AbTCCTw6>; Mon, 3 Mar 2003 14:52:58 -0500
Date: Mon, 3 Mar 2003 20:03:23 +0000
From: Kenn Humborg <kenn@linux.ie>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make f_pos accessible via /proc/PID/fd/N
Message-ID: <20030303200323.A12223@excalibur.research.wombat.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch sets the "size" for the /proc/PID/fd/N entries
to the current file position (file->f_pos).

In proc_lookupfd(), I fill inode->i_size with file->f_pos.  Then
in pid_fd_revalidate(), I refresh it again.

I would find this useful to be able to tell, for example, how far
a large outgoing SMTP transfer has got (so I can avoid rebooting
if it's almost finished), or how far a customer download from our
FTP server has got to.

Was there any particular reason for fixing the "size" of these
files at 64?  Are there any tools that depend on this?

Patch is against 2.5.63.

Later,
Kenn


--- /home/kenn/linux-vax/lxr/2.5.63/src/fs/proc/base.c	Tue Feb 18 00:25:22 2003
+++ base.c	Mon Mar  3 19:55:15 2003
@@ -819,8 +819,11 @@
 		atomic_inc(&files->count);
 	task_unlock(task);
 	if (files) {
+		struct file *f;
 		read_lock(&files->file_lock);
-		if (fcheck_files(files, fd)) {
+		f = fcheck_files(files, fd);
+		if (f) {
+			dentry->d_inode->i_size = f->f_pos;
 			read_unlock(&files->file_lock);
 			put_files_struct(files);
 			return 1;
@@ -926,7 +929,7 @@
 	read_unlock(&files->file_lock);
 	put_files_struct(files);
 	inode->i_op = &proc_pid_link_inode_operations;
-	inode->i_size = 64;
+	inode->i_size = file->f_pos;
 	ei->op.proc_get_link = proc_fd_link;
 	dentry->d_op = &pid_fd_dentry_operations;
 	d_add(dentry, inode);
