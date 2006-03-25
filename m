Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751610AbWCYBte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbWCYBte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 20:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbWCYBte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 20:49:34 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:61916 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751610AbWCYBtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 20:49:33 -0500
Date: Sat, 25 Mar 2006 02:49:32 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [PATCH] loop: potential kernel hang waiting for kthread
Message-ID: <20060325014932.GA16485@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew! Folks!

just stumbled over the following issue with loop_set_fd()
calling kernel_thread(loop_thread), ignoring the return
value, even if it is an error, then doing wait_for_completion()
on the device, which, in beforementioned error case, would
wait forever (keeping a process stuck in 'D' state)

I can imagine at least three other solutions, but this
one seemed quite organic to me, YMMV ...

best,
Herbert

Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>
---
--- linux/drivers/block/loop.c	2006-03-24 03:37:07 +0100
+++ linux/drivers/block/loop.c	2006-03-25 02:30:37 +0100
@@ -747,6 +747,7 @@ static int loop_set_fd(struct loop_devic
 	int		lo_flags = 0;
 	int		error;
 	loff_t		size;
+	pid_t		pid;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
@@ -839,10 +840,14 @@ static int loop_set_fd(struct loop_devic
 
 	set_blocksize(bdev, lo_blocksize);
 
-	kernel_thread(loop_thread, lo, CLONE_KERNEL);
+	pid = kernel_thread(loop_thread, lo, CLONE_KERNEL);
+	if (pid < 0)
+		goto out_err;
 	wait_for_completion(&lo->lo_done);
 	return 0;
 
+ out_err:
+	error = (int)pid;
  out_putf:
 	fput(file);
  out:
