Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUDIXBv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 19:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUDIXBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 19:01:51 -0400
Received: from sunsite.ms.mff.cuni.cz ([195.113.15.26]:60862 "EHLO
	sunsite.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261851AbUDIXBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 19:01:48 -0400
Date: Fri, 9 Apr 2004 22:30:48 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Only fail with invalid timespec if mq_timed{send,receive} needs to block
Message-ID: <20040409203048.GU514@sunsite.ms.mff.cuni.cz>
Reply-To: Jakub Jelinek <jakub@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

POSIX requires EINVAL to be set if:
"The process or thread would have blocked, and the abs_timeout parameter
specified a nanoseconds field value less than zero or greater than or equal
to 1000 million."
but 2.6.5-mm3 returns -EINVAL even if the process or thread would not block
(if the queue is not empty for timedreceive or not full for timedsend).

--- linux-2.6.5-mm3/mqueue.c.jj	2004-04-08 22:56:25.000000000 +0200
+++ linux-2.6.5-mm3/mqueue.c	2004-04-10 00:30:53.910430420 +0200
@@ -828,8 +828,7 @@ asmlinkage long sys_mq_timedsend(mqd_t m
 	if (unlikely(msg_prio >= (unsigned long) MQ_PRIO_MAX))
 		return -EINVAL;
 
-	if (unlikely((timeout = prepare_timeout(u_abs_timeout)) < 0))
-		return timeout;
+	timeout = prepare_timeout(u_abs_timeout);
 
 	ret = -EBADF;
 	filp = fget(mqdes);
@@ -865,6 +864,9 @@ asmlinkage long sys_mq_timedsend(mqd_t m
 		if (filp->f_flags & O_NONBLOCK) {
 			spin_unlock(&info->lock);
 			ret = -EAGAIN;
+		} else if (unlikely(timeout < 0)) {
+			spin_unlock(&info->lock);
+			ret = timeout;
 		} else {
 			wait.task = current;
 			wait.msg = (void *) msg_ptr;
@@ -905,9 +907,7 @@ asmlinkage ssize_t sys_mq_timedreceive(m
 	struct mqueue_inode_info *info;
 	struct ext_wait_queue wait;
 
-
-	if (unlikely((timeout = prepare_timeout(u_abs_timeout)) < 0))
-		return timeout;
+	timeout = prepare_timeout(u_abs_timeout);
 
 	ret = -EBADF;
 	filp = fget(mqdes);
@@ -934,6 +934,10 @@ asmlinkage ssize_t sys_mq_timedreceive(m
 			spin_unlock(&info->lock);
 			ret = -EAGAIN;
 			msg_ptr = NULL;
+		} else if (unlikely(timeout < 0)) {
+			spin_unlock(&info->lock);
+			ret = timeout;
+			msg_ptr = NULL;
 		} else {
 			wait.task = current;
 			wait.state = STATE_NONE;

	Jakub
