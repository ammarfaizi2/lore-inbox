Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265487AbUIMIYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265487AbUIMIYf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 04:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUIMIYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 04:24:35 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:15600 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S265487AbUIMIY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 04:24:29 -0400
Date: Mon, 13 Sep 2004 10:24:09 +0200 (CEST)
From: "Simon.Derr" <derrs@openx3.frec.bull.fr>
To: Paul Jackson <pj@sgi.com>
cc: Simon Derr <simon.derr@bull.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets: alternative fix for possible race in
 cpuset_tasks_read()
In-Reply-To: <20040911010120.572595e3.pj@sgi.com>
Message-ID: <Pine.LNX.4.61.0409131012010.18437@openx3.frec.bull.fr>
References: <Pine.LNX.4.58.0409101632100.2891@daphne.frec.bull.fr>
 <20040911010120.572595e3.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Sep 2004, Paul Jackson wrote:

> Here's an alternative fix for the race condition on read that Simon
> reports.
>
> Andrew,
>
>  Don't apply this one yet, until Simon Derr gets a chance to
>  compare with his alternative patch, and render his analysis.
>
> Move the code that sets up the character buffer of text to read out
> when reading a "tasks" file from the read routine to the open routine.
>
> Multiple cloned threads could be doing the first read on a shared
> file descriptor open on a "tasks" file, resulting in confused
> or leaked kernel memory as multiple threads initialized the same
> file private_data at the same time.  Rather than add locks to the
> initialization code, move it into the open(), where it belongs anyway.

Indeed, this code belongs to open(). It was in read() for foolish reasons.

Your patch looks good, but I polished it a bit, so we do the buffer 
allocation in open() only when the file is opened for reading.

Signed-off-by: Paul Jackson
Signed-off-by: Simon Derr <simon.derr@bull.net>

Index: mm4/kernel/cpuset.c
===================================================================
--- mm4.orig/kernel/cpuset.c	2004-09-07 11:36:18.000000000 +0200
+++ mm4/kernel/cpuset.c	2004-09-13 09:43:02.282327670 +0200
@@ -1052,13 +1052,16 @@ static int pid_array_to_buf(char *buf, i
  	return cnt;
  }

-static inline struct ctr_struct *cpuset_tasks_mkctr(struct file *file)
+static int cpuset_tasks_open(struct inode *unused, struct file *file)
  {
  	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
  	struct ctr_struct *ctr;
  	pid_t *pidarray;
  	int npids;
  	char c;
+ 
+	if (!(file->f_mode & FMODE_READ))
+		return 0;

  	ctr = kmalloc(sizeof(*ctr), GFP_KERNEL);
  	if (!ctr)
@@ -1087,14 +1090,14 @@ static inline struct ctr_struct *cpuset_

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
@@ -1102,13 +1105,6 @@ static ssize_t cpuset_tasks_read(struct
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
@@ -1121,12 +1117,8 @@ static int cpuset_tasks_release(struct i
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
@@ -1139,6 +1131,7 @@ static int cpuset_tasks_release(struct i

  static struct cftype cft_tasks = {
  	.name = "tasks",
+	.open = cpuset_tasks_open,
  	.read = cpuset_tasks_read,
  	.release = cpuset_tasks_release,
  	.private = FILE_TASKLIST,
