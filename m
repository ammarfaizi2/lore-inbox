Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVDBUBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVDBUBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 15:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVDBUBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 15:01:23 -0500
Received: from smtpout15.mailhost.ntl.com ([212.250.162.15]:62738 "EHLO
	mta05-winn.mailhost.ntl.com") by vger.kernel.org with ESMTP
	id S261242AbVDBUBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 15:01:20 -0500
Message-ID: <424EF9E8.8010302@gentoo.org>
Date: Sat, 02 Apr 2005 21:00:40 +0100
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
 boundary="------------050505050906030505030109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050505050906030505030109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The current logic assumes that a /proc/<PID>/task directory should have a 
hardlink count of 3, probably counting ".", "..", and a directory for a single 
child task.

It's fairly obvious that this doesn't work out correctly when a PID has more 
than one child task, which is quite often the case.

This should fix it up.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

--------------050505050906030505030109
Content-Type: text/x-patch;
 name="procfs-task-hardlinks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="procfs-task-hardlinks.patch"

--- base.c.orig	2005-04-02 20:47:10.000000000 +0100
+++ base.c	2005-04-02 20:51:43.000000000 +0100
@@ -1337,6 +1337,8 @@
 static struct inode_operations proc_tgid_attr_inode_operations;
 #endif
 
+static int get_tid_list(int index, unsigned int *tids, struct inode *dir);
+
 /* SMP-safe */
 static struct dentry *proc_pident_lookup(struct inode *dir, 
 					 struct dentry *dentry,
@@ -1376,7 +1378,7 @@
 	 */
 	switch(p->type) {
 		case PROC_TGID_TASK:
-			inode->i_nlink = 3;
+			inode->i_nlink = 2 + get_tid_list(2, NULL, dir);
 			inode->i_op = &proc_task_inode_operations;
 			inode->i_fop = &proc_task_operations;
 			break;
@@ -1845,7 +1847,8 @@
 
 		if (--index >= 0)
 			continue;
-		tids[nr_tids] = tid;
+		if (tids != NULL)
+			tids[nr_tids] = tid;
 		nr_tids++;
 		if (nr_tids >= PROC_MAXPIDS)
 			break;
@@ -1945,6 +1948,7 @@
 	}
 
 	nr_tids = get_tid_list(pos, tid_array, inode);
+	inode->i_nlink = pos + nr_tids;
 
 	for (i = 0; i < nr_tids; i++) {
 		unsigned long j = PROC_NUMBUF;

--------------050505050906030505030109--
