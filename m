Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWJVP5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWJVP5u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 11:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWJVP5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 11:57:50 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:4241 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1751106AbWJVP5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 11:57:49 -0400
Date: Sun, 22 Oct 2006 19:57:35 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] do_task_stat: don't take tty_mutex
Message-ID: <20061022155735.GA10491@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on
	tty-signal-tty-locking.patch

->signal->tty is protected by ->siglock, no need to take the global tty_mutex.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc2-mm2/fs/proc/array.c~	2006-10-22 19:28:17.000000000 +0400
+++ rc2-mm2/fs/proc/array.c	2006-10-22 19:45:52.000000000 +0400
@@ -346,20 +346,13 @@ static int do_task_stat(struct task_stru
 	sigemptyset(&sigcatch);
 	cutime = cstime = utime = stime = cputime_zero;
 
-	mutex_lock(&tty_mutex);
 	rcu_read_lock();
 	if (lock_task_sighand(task, &flags)) {
 		struct signal_struct *sig = task->signal;
-		struct tty_struct *tty = sig->tty;
 
-		if (tty) {
-			/*
-			 * sig->tty is not stable, but tty_mutex
-			 * protects us from release_dev(tty)
-			 */
-			barrier();
-			tty_pgrp = tty->pgrp;
-			tty_nr = new_encode_dev(tty_devnum(tty));
+		if (sig->tty) {
+			tty_pgrp = sig->tty->pgrp;
+			tty_nr = new_encode_dev(tty_devnum(sig->tty));
 		}
 
 		num_threads = atomic_read(&sig->count);
@@ -395,7 +388,6 @@ static int do_task_stat(struct task_stru
 		unlock_task_sighand(task, &flags);
 	}
 	rcu_read_unlock();
-	mutex_unlock(&tty_mutex);
 
 	if (!whole || num_threads<2)
 		wchan = get_wchan(task);

