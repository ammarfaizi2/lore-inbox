Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264532AbRFJPhB>; Sun, 10 Jun 2001 11:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264533AbRFJPgu>; Sun, 10 Jun 2001 11:36:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:50374 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264532AbRFJPgm>;
	Sun, 10 Jun 2001 11:36:42 -0400
Date: Sun, 10 Jun 2001 11:36:35 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, Alois Treindl <alois@astro.ch>,
        "'Bryce'" <bryce@redhat.com>
Subject: [PATCH] Re: Oops with kernel 2.4.5 on heavy disk traffic
In-Reply-To: <Pine.HPX.4.21.0106101259250.9434-100000@as73.astro.ch>
Message-ID: <Pine.GSO.4.21.0106101122570.22838-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Please, apply. What's happing here is simple - we set i_ino by
PID and get something out of range of per-process inode. Confusion
follows... Fix: move initializing ->u.proc_i.task past the check.
Then proc_delete_inode() will be happy with it.
	Alois, Bryce - that ought to fix the oopsen you see.

--- linux/fs/proc/base.c.old	Sun Jun 10 11:15:55 2001
+++ linux/fs/proc/base.c	Sun Jun 10 11:21:51 2001
@@ -635,15 +635,14 @@
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_ino = fake_ino(task->pid, ino);
 
-	inode->u.proc_i.file = NULL;
+	if (!task->pid)
+		goto out_unlock;
+
 	/*
 	 * grab the reference to task.
 	 */
-	inode->u.proc_i.task = task;
 	get_task_struct(task);
-	if (!task->pid)
-		goto out_unlock;
-
+	inode->u.proc_i.task = task;
 	inode->i_uid = 0;
 	inode->i_gid = 0;
 	if (ino == PROC_PID_INO || task->dumpable) {


