Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVHWPIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVHWPIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVHWPIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:08:20 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:23439 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932186AbVHWPIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:08:19 -0400
Subject: [PATCH] futex: remove duplicate code
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jamie@shareable.org, mingo@elte.hu,
       rusty@rustcorp.com.au
Date: Tue, 23 Aug 2005 18:07:40 +0300
Message-Id: <1124809660.9051.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch cleans up the error path of futex_fd() by removing duplicate
code.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 futex.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

Index: 2.6-mm/kernel/futex.c
===================================================================
--- 2.6-mm.orig/kernel/futex.c
+++ 2.6-mm/kernel/futex.c
@@ -673,23 +673,17 @@ static int futex_fd(unsigned long uaddr,
 	filp->f_mapping = filp->f_dentry->d_inode->i_mapping;
 
 	if (signal) {
-		int err;
 		err = f_setown(filp, current->pid, 1);
 		if (err < 0) {
-			put_unused_fd(ret);
-			put_filp(filp);
-			ret = err;
-			goto out;
+			goto error;
 		}
 		filp->f_owner.signum = signal;
 	}
 
 	q = kmalloc(sizeof(*q), GFP_KERNEL);
 	if (!q) {
-		put_unused_fd(ret);
-		put_filp(filp);
-		ret = -ENOMEM;
-		goto out;
+		err = -ENOMEM;
+		goto error;
 	}
 
 	down_read(&current->mm->mmap_sem);
@@ -697,10 +691,8 @@ static int futex_fd(unsigned long uaddr,
 
 	if (unlikely(err != 0)) {
 		up_read(&current->mm->mmap_sem);
-		put_unused_fd(ret);
-		put_filp(filp);
 		kfree(q);
-		return err;
+		goto error;
 	}
 
 	/*
@@ -716,6 +708,11 @@ static int futex_fd(unsigned long uaddr,
 	fd_install(ret, filp);
 out:
 	return ret;
+error:
+	put_unused_fd(ret);
+	put_filp(filp);
+	ret = err;
+	goto out;
 }
 
 long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,


