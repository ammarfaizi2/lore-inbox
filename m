Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUIKICs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUIKICs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUIKICs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:02:48 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23685 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267681AbUIKICe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:02:34 -0400
Date: Sat, 11 Sep 2004 01:01:20 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <simon.derr@bull.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpusets: alternative fix for possible race in
 cpuset_tasks_read()
Message-Id: <20040911010120.572595e3.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0409101632100.2891@daphne.frec.bull.fr>
References: <Pine.LNX.4.58.0409101632100.2891@daphne.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an alternative fix for the race condition on read that Simon
reports.

Andrew,

  Don't apply this one yet, until Simon Derr gets a chance to
  compare with his alternative patch, and render his analysis.

Move the code that sets up the character buffer of text to read out
when reading a "tasks" file from the read routine to the open routine.

Multiple cloned threads could be doing the first read on a shared
file descriptor open on a "tasks" file, resulting in confused
or leaked kernel memory as multiple threads initialized the same
file private_data at the same time.  Rather than add locks to the
initialization code, move it into the open(), where it belongs anyway.

Signed-off-by: Paul Jackson

Index: 2.6.9-rc1-mm4/kernel/cpuset.c
===================================================================
--- 2.6.9-rc1-mm4.orig/kernel/cpuset.c	2004-09-10 15:27:32.000000000 -0700
+++ 2.6.9-rc1-mm4/kernel/cpuset.c	2004-09-10 21:20:02.000000000 -0700
@@ -1034,7 +1034,7 @@ static int pid_array_to_buf(char *buf, i
 	return cnt;
 }
 
-static inline struct ctr_struct *cpuset_tasks_mkctr(struct file *file)
+static int cpuset_tasks_open(struct inode *unused, struct file *file)
 {
 	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
 	struct ctr_struct *ctr;
@@ -1069,14 +1069,14 @@ static inline struct ctr_struct *cpuset_
 
 	kfree(pidarray);
 	file->private_data = (void *)ctr;
-	return ctr;
+	return 0;
 
 err2:
 	kfree(pidarray);
 err1:
 	kfree(ctr);
 err0:
-	return NULL;
+	return -ENOMEM;
 }
 
 static ssize_t cpuset_tasks_read(struct file *file, char __user *buf,
@@ -1084,13 +1084,6 @@ static ssize_t cpuset_tasks_read(struct 
 {
 	struct ctr_struct *ctr = (struct ctr_struct *)file->private_data;
 
-	/* allocate buffer and fill it on first call to read() */
-	if (!ctr) {
-		ctr = cpuset_tasks_mkctr(file);
-		if (!ctr)
-			return -ENOMEM;
-	}
-
 	if (*ppos + nbytes > ctr->bufsz)
 		nbytes = ctr->bufsz - *ppos;
 	if (copy_to_user(buf, ctr->buf + *ppos, nbytes))
@@ -1121,6 +1114,7 @@ static int cpuset_tasks_release(struct i
 
 static struct cftype cft_tasks = {
 	.name = "tasks",
+	.open = cpuset_tasks_open,
 	.read = cpuset_tasks_read,
 	.release = cpuset_tasks_release,
 	.private = FILE_TASKLIST,


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
