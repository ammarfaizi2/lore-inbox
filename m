Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267427AbUIJOiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267427AbUIJOiy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267433AbUIJOiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:38:54 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:22968 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S267427AbUIJOiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:38:50 -0400
Date: Fri, 10 Sep 2004 16:38:23 +0200 (CEST)
From: Simon Derr <simon.derr@bull.net>
X-X-Sender: derr@daphne.frec.bull.fr
To: pj@sgi.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpusets: fix possible race in cpuset_tasks_read()
Message-ID: <Pine.LNX.4.58.0409101632100.2891@daphne.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

this patch fixes a possible race between two threads of a single process
in cpuset_tasks_read().

It is mostly the same issue as the one that was in sysfs.

This patch is against 2.6.9-rc1-mm4.


Signed-Off-By: Simon Derr <simon.derr@bull.net>

Index: mm4/kernel/cpuset.c
===================================================================
--- mm4.orig/kernel/cpuset.c	2004-09-07 11:36:18.000000000 +0200
+++ mm4/kernel/cpuset.c	2004-09-10 15:10:01.657243216 +0200
@@ -1100,20 +1100,27 @@
 static ssize_t cpuset_tasks_read(struct file *file, char __user *buf,
 						size_t nbytes, loff_t *ppos)
 {
-	struct ctr_struct *ctr = (struct ctr_struct *)file->private_data;
+	struct ctr_struct *ctr;

+	down(&cpuset_sem);
+	ctr = (struct ctr_struct *)file->private_data;
 	/* allocate buffer and fill it on first call to read() */
 	if (!ctr) {
 		ctr = cpuset_tasks_mkctr(file);
-		if (!ctr)
+		if (!ctr) {
+			up(&cpuset_sem);
 			return -ENOMEM;
+		}
 	}

 	if (*ppos + nbytes > ctr->bufsz)
 		nbytes = ctr->bufsz - *ppos;
-	if (copy_to_user(buf, ctr->buf + *ppos, nbytes))
+	if (copy_to_user(buf, ctr->buf + *ppos, nbytes)) {
+		up(&cpuset_sem);
 		return -EFAULT;
+	}
 	*ppos += nbytes;
+	up(&cpuset_sem);
 	return nbytes;
 }

