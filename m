Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVDBUEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVDBUEJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 15:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVDBUEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 15:04:09 -0500
Received: from smtpout16.mailhost.ntl.com ([212.250.162.16]:22771 "EHLO
	mta08-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261244AbVDBUEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 15:04:01 -0500
Message-ID: <424EFA8A.9000401@gentoo.org>
Date: Sat, 02 Apr 2005 21:03:22 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] procfs: Fix hardlink counts for /proc/<PID>/task
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030904090905030305030609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030904090905030305030609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[ Sorry, sent in the wrong patch. This one should apply with the usual -p1 
option. ]

The current logic assumes that a /proc/<PID>/task directory should have a 
hardlink count of 3, probably counting ".", "..", and a directory for a single 
child task.

It's fairly obvious that this doesn't work out correctly when a PID has more 
than one child task, which is quite often the case.

This should fix it up.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------030904090905030305030609
Content-Type: text/x-patch;
 name="procfs-task-hardlinks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="procfs-task-hardlinks.patch"

--- linux-2.6.11-gentoo-r5/fs/proc/base.c.orig	2005-04-02 20:47:10.000000000 +0100
+++ linux-2.6.11-gentoo-r5/fs/proc/base.c	2005-04-02 20:51:43.000000000 +0100
@@ -1337,6 +1337,8 @@ static struct file_operations proc_tgid_
 static struct inode_operations proc_tgid_attr_inode_operations;
 #endif
 
+static int get_tid_list(int index, unsigned int *tids, struct inode *dir);
+
 /* SMP-safe */
 static struct dentry *proc_pident_lookup(struct inode *dir, 
 					 struct dentry *dentry,
@@ -1376,7 +1378,7 @@ static struct dentry *proc_pident_lookup
 	 */
 	switch(p->type) {
 		case PROC_TGID_TASK:
-			inode->i_nlink = 3;
+			inode->i_nlink = 2 + get_tid_list(2, NULL, dir);
 			inode->i_op = &proc_task_inode_operations;
 			inode->i_fop = &proc_task_operations;
 			break;
@@ -1845,7 +1847,8 @@ static int get_tid_list(int index, unsig
 
 		if (--index >= 0)
 			continue;
-		tids[nr_tids] = tid;
+		if (tids != NULL)
+			tids[nr_tids] = tid;
 		nr_tids++;
 		if (nr_tids >= PROC_MAXPIDS)
 			break;
@@ -1945,6 +1948,7 @@ static int proc_task_readdir(struct file
 	}
 
 	nr_tids = get_tid_list(pos, tid_array, inode);
+	inode->i_nlink = pos + nr_tids;
 
 	for (i = 0; i < nr_tids; i++) {
 		unsigned long j = PROC_NUMBUF;

--------------030904090905030305030609--
