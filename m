Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbRGAQMO>; Sun, 1 Jul 2001 12:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265205AbRGAQME>; Sun, 1 Jul 2001 12:12:04 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:35214 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S265201AbRGAQLv>; Sun, 1 Jul 2001 12:11:51 -0400
Message-ID: <3B3F4BAD.806038AF@uow.edu.au>
Date: Mon, 02 Jul 2001 02:11:25 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: execve strangeness
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try this, as root:

[root@mnm akpm]# /var/log/messages
bash: /var/log/messages: Text file busy

Strange return value, that.

It happens because vfs_permission() sees CAP_DAC_OVERRIDE
and returns "yes" on a file which has no `x' bits set.
Then open_exec() falls through to deny_write_access() which
sees that the file is open for writing.

If the file is _not_ open for writing then the "WTF" test in
prepare_binprm() is what stops us from executing the file.  So
the test there is definitely needed.

Moving the "WTF" test into open_exec() definitely fixes things
up, but I think the real bug is in vfs_permission().



--- linux-2.4.6-pre6/fs/exec.c	Wed May  2 22:00:06 2001
+++ lk-ext3/fs/exec.c	Mon Jul  2 02:01:52 2001
@@ -349,6 +349,8 @@
 		file = ERR_PTR(-EACCES);
 		if (!IS_NOEXEC(inode) && S_ISREG(inode->i_mode)) {
 			int err = permission(inode, MAY_EXEC);
+			if (!err && !(inode->i_mode & 0111))
+				err = -EACCES;
 			file = ERR_PTR(err);
 			if (!err) {
 				file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
@@ -606,7 +608,10 @@
 	struct inode * inode = bprm->file->f_dentry->d_inode;
 
 	mode = inode->i_mode;
-	/* Huh? We had already checked for MAY_EXEC, WTF do we check this? */
+	/*
+	 * Check execute perms again - if the caller has CAP_DAC_OVERRIDE,
+	 * vfs_permission lets a non-executable through
+	 */
 	if (!(mode & 0111))	/* with at least _one_ execute bit set */
 		return -EACCES;
 	if (bprm->file->f_op == NULL)
