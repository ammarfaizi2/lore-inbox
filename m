Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUIMJ1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUIMJ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 05:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266485AbUIMJ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 05:27:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34437 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266486AbUIMJ0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 05:26:42 -0400
Date: Mon, 13 Sep 2004 02:25:24 -0700
From: Paul Jackson <pj@sgi.com>
To: "Simon.Derr" <derrs@openx3.frec.bull.fr>
Cc: simon.derr@bull.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets: alternative fix for possible race in
 cpuset_tasks_read()
Message-Id: <20040913022524.6d3b711e.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0409131012010.18437@openx3.frec.bull.fr>
References: <Pine.LNX.4.58.0409101632100.2891@daphne.frec.bull.fr>
	<20040911010120.572595e3.pj@sgi.com>
	<Pine.LNX.4.61.0409131012010.18437@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This is ready to go in with the cpuset patches in *-mm.  Simon's latest
changes to buffer only when reading are good - thanks, Simon.  I fixed up
the diff formatting - Simon's latest patch had botched leading space chars.

==

Move the code that sets up the character buffer of text to read out
when reading a "tasks" file from the read routine to the open routine.

Multiple cloned threads could be doing the first read on a shared
file descriptor open on a "tasks" file, resulting in confused
or leaked kernel memory as multiple threads initialized the same
file private_data at the same time.  Rather than add locks to the
initialization code, move it into the open(), where it belongs anyway.

Only do buffer allocation in open() when the file is opened for reading.

Signed-off-by: Paul Jackson <pj@sgi.com>
Signed-off-by: Simon Derr <simon.derr@bull.net>

Index: 2.6.9-rc1-mm4/kernel/cpuset.c
===================================================================
--- 2.6.9-rc1-mm4.orig/kernel/cpuset.c	2004-09-13 02:00:56.000000000 -0700
+++ 2.6.9-rc1-mm4/kernel/cpuset.c	2004-09-13 02:14:28.000000000 -0700
@@ -1017,7 +1017,7 @@ static int cpuset_add_file(struct dentry
  * but we cannot guarantee that the information we produce is correct
  * unless we produce it entirely atomically.
  *
- * Upon first file read(), a struct ctr_struct is allocated, that
+ * Upon tasks file open(), a struct ctr_struct is allocated, that
  * will have a pointer to an array (also allocated here).  The struct
  * ctr_struct * is stored in file->private_data.  Its resources will
  * be freed by release() when the file is closed.  The array is used
@@ -1087,7 +1087,7 @@ static int pid_array_to_buf(char *buf, i
 	return cnt;
 }
 
-static inline struct ctr_struct *cpuset_tasks_mkctr(struct file *file)
+static int cpuset_tasks_open(struct inode *unused, struct file *file)
 {
 	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
 	struct ctr_struct *ctr;
@@ -1095,6 +1095,9 @@ static inline struct ctr_struct *cpuset_
 	int npids;
 	char c;
 
+	if (!(file->f_mode & FMODE_READ))
+		return 0;
+
 	ctr = kmalloc(sizeof(*ctr), GFP_KERNEL);
 	if (!ctr)
 		goto err0;
@@ -1122,14 +1125,14 @@ static inline struct ctr_struct *cpuset_
 
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
@@ -1137,13 +1140,6 @@ static ssize_t cpuset_tasks_read(struct 
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
@@ -1156,12 +1152,8 @@ static int cpuset_tasks_release(struct i
 {
 	struct ctr_struct *ctr;
 
-	/* we have nothing to do if no read-access is needed */
-	if (!(file->f_mode & FMODE_READ))
-		return 0;
-
-	ctr = (struct ctr_struct *)file->private_data;
-	if (ctr) {
+	if (file->f_mode & FMODE_READ) {
+		ctr = (struct ctr_struct *)file->private_data;
 		kfree(ctr->buf);
 		kfree(ctr);
 	}
@@ -1174,6 +1166,7 @@ static int cpuset_tasks_release(struct i
 
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
