Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVJMQiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVJMQiK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 12:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbVJMQiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 12:38:09 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:35557 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932088AbVJMQiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 12:38:08 -0400
Message-ID: <434E906E.85BD86BF@tv-sign.ru>
Date: Thu, 13 Oct 2005 20:50:54 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Michael Kerrisk <mtk-lkml@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix de_thread() vs do_coredump() deadlock
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

de_thread() sends SIGKILL to all sub-threads and
waits them to die in 'D' state. It is possible that
one of the threads already dequeued coredump signal.
When de_thread() unlocks ->sighand->lock that thread
can enter do_coredump()->coredump_wait() and cause a
deadlock.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc4/fs/exec.c~	2005-09-21 21:08:33.000000000 +0400
+++ 2.6.14-rc4/fs/exec.c	2005-10-14 00:19:19.000000000 +0400
@@ -1468,11 +1468,21 @@ int do_coredump(long signr, int exit_cod
 		current->fsuid = 0;	/* Dump root private */
 	}
 	mm->dumpable = 0;
-	init_completion(&mm->core_done);
+
+	retval = -EAGAIN;
 	spin_lock_irq(&current->sighand->siglock);
-	current->signal->flags = SIGNAL_GROUP_EXIT;
-	current->signal->group_exit_code = exit_code;
+	if (!(current->signal->flags & SIGNAL_GROUP_EXIT)) {
+		current->signal->flags = SIGNAL_GROUP_EXIT;
+		current->signal->group_exit_code = exit_code;
+		retval = 0;
+	}
 	spin_unlock_irq(&current->sighand->siglock);
+	if (retval) {
+		up_write(&mm->mmap_sem);
+		goto fail;
+	}
+
+	init_completion(&mm->core_done);
 	coredump_wait(mm);
 
 	/*
