Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262259AbVFSQEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbVFSQEU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 12:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVFSQEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 12:04:20 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:443 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262259AbVFSQEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 12:04:13 -0400
Message-ID: <42B59992.3EFD4C73@tv-sign.ru>
Date: Sun, 19 Jun 2005 20:13:06 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] de_thread: eliminate unneccessary sighand locking
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while switching current->sighand de_thread does:

	write_lock_irq(&tasklist_lock);
	spin_lock(&oldsighand->siglock);
	spin_lock(&newsighand->siglock);

	current->sighand = newsighand;
	recalc_sigpending();

Is these 2 sighand locks are really needed?

At this moment we already zapped other threads, so nobody
can access newsighand via current->. And we are holding
tasklist_lock, so other processes can't send signals to us
or use our ->sighand in any way.

oldsighand can be seen from CLONE_SIGHAND processes, but
we are not using oldsighand in any way, so this lock seems
to be unneeded too.

The only possibility that I can imagine is that some process
does:
	read_lock(tasklist_lock);
	task = find_task();
	spin_lock(task->sighand->siglock);
	read_unlock(tasklist_lock);
	play with task->signal

Is this possible/allowed?

And why do we need recalc_sigpending() ? We are not changing
->pending or ->blocked, just ->sighand.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.12/fs/exec.c~	2005-05-09 16:37:16.000000000 +0400
+++ 2.6.12/fs/exec.c	2005-06-20 00:03:24.000000000 +0400
@@ -758,14 +758,7 @@ no_thread_group:
 		       sizeof(newsighand->action));
 
 		write_lock_irq(&tasklist_lock);
-		spin_lock(&oldsighand->siglock);
-		spin_lock(&newsighand->siglock);
-
 		current->sighand = newsighand;
-		recalc_sigpending();
-
-		spin_unlock(&newsighand->siglock);
-		spin_unlock(&oldsighand->siglock);
 		write_unlock_irq(&tasklist_lock);
 
 		if (atomic_dec_and_test(&oldsighand->count))
