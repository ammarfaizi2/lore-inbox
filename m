Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWH0Mav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWH0Mav (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 08:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWH0Mav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 08:30:51 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:13710 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S932093AbWH0Mav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 08:30:51 -0400
Date: Sun, 27 Aug 2006 20:54:44 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <npiggin@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] select_bad_process: kill a bogus PF_DEAD/TASK_DEAD check
Message-ID: <20060827165444.GA1162@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Compile tested, on top of introduce-task_dead-state.patch)

The only one usage of TASK_DEAD outside of last schedule path,

select_bad_process:

	for_each_task(p) {

		if (!p->mm)
			continue;
		...
			if (p->state == TASK_DEAD)
				continue;
		...

TASK_DEAD state is set at the end of do_exit(), this means that p->mm
was already set == NULL by exit_mm(), so this task was already rejected
by 'if (!p->mm)' above.

Note also that the caller holds tasklist_lock, this means that p can't
pass exit_notify() and then set TASK_DEAD when p->mm != NULL.

Also, remove open-coded is_init().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/mm/oom_kill.c~	2006-08-27 19:49:27.000000000 +0400
+++ 2.6.18-rc4/mm/oom_kill.c	2006-08-27 20:16:28.000000000 +0400
@@ -207,11 +207,14 @@ static struct task_struct *select_bad_pr
 		unsigned long points;
 		int releasing;
 
-		/* skip kernel threads */
+		/*
+		 * skip kernel threads and tasks which have already released
+		 * their mm.
+		 */
 		if (!p->mm)
 			continue;
-		/* skip the init task with pid == 1 */
-		if (p->pid == 1)
+		/* skip the init task */
+		if (is_init(p))
 			continue;
 
 		/*
@@ -227,9 +230,6 @@ static struct task_struct *select_bad_pr
 		releasing = test_tsk_thread_flag(p, TIF_MEMDIE) ||
 						p->flags & PF_EXITING;
 		if (releasing) {
-			/* TASK_DEAD tasks have already released their mm */
-			if (p->state == TASK_DEAD)
-				continue;
 			if (p->flags & PF_EXITING && p == current) {
 				chosen = p;
 				*ppoints = ULONG_MAX;

