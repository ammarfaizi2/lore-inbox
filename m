Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263969AbTLOVIC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 16:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbTLOVIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 16:08:02 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:2288 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263969AbTLOVH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 16:07:58 -0500
Message-ID: <3FDE22AB.8020806@mvista.com>
Date: Mon, 15 Dec 2003 14:07:55 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.20 /proc returns EINVAL when ENOENT is appropriate
Content-Type: multipart/mixed;
 boundary="------------020709000405050505010203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020709000405050505010203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch fixes a problem in /proc that was seen in 2.4.20 but 
seems applicable to 2.4.x. It is possible for a process to be scanning 
/proc for processes and to access a cached task_struct pointer (via the 
/proc list entry) even though the associated process is dying/dead - and 
the /proc list entry has not yet been removed. The /proc code detects 
this (via task PID equal to zero) and currently returns EINVAL which is 
confusing at best.

Since it is entirely possible for a /proc user to encounter ENOENT on 
lookup/traverse at any time this patch changes the returned status to 
ENOENT when the task PID is zero. Adding locking seemed like overkill.

mark

P.S.

One could argue that the EINVAL should really be ENOMEM in this case. 
Perhaps this should also be discussed?

--------------020709000405050505010203
Content-Type: text/plain;
 name="proc-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc-patch"

Index: base.c
===================================================================
RCS file: /cvsdev/mvl-kernel/linux/fs/proc/base.c,v
retrieving revision 1.3.34.4.6.1
diff -a -u -r1.3.34.4.6.1 base.c
--- base.c	29 Oct 2003 05:09:35 -0000	1.3.34.4.6.1
+++ base.c	15 Dec 2003 20:00:12 -0000
@@ -882,22 +882,23 @@
 	struct task_struct *task = dir->u.proc_i.task;
 	struct pid_entry *p;
 
-	error = -ENOENT;
-	inode = NULL;
-
 	for (p = base_stuff; p->name; p++) {
 		if (p->len != dentry->d_name.len)
 			continue;
 		if (!memcmp(dentry->d_name.name, p->name, p->len))
 			break;
 	}
-	if (!p->name)
+
+	if (!p->name) {
+		error = -ENOENT;
 		goto out;
+	}
 
-	error = -EINVAL;
 	inode = proc_pid_make_inode(dir->i_sb, task, p->type);
-	if (!inode)
+	if (!inode) {
+		error = task->pid ? -EINVAL : -ENOENT;
 		goto out;
+	}
 
 	inode->i_mode = p->mode;
 	/*

--------------020709000405050505010203--

