Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWBORzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWBORzu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWBORzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:55:50 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:37270 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751190AbWBORzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:55:49 -0500
Message-ID: <43F37D54.4D0AAEFD@tv-sign.ru>
Date: Wed, 15 Feb 2006 22:13:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/2] fix kill_proc_info() vs CLONE_THREAD race
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a window after copy_process() unlocks ->sighand.siglock
and before it adds the new thread to the thread list.

In that window __group_complete_signal(SIGKILL) will not see the
new thread yet, so this thread will start running while the whole
thread group was supposed to exit.

I beleive we have another good reason to place attach_pid(PID/TGID)
under ->sighand.siglock. We can do the same for

	release_task()->__unhash_process()

	de_thread()->switch_exec_pids()

After that we don't need tasklist_lock to iterate over the thread
list, and we can simplify things, see for example do_sigaction()
or sys_times().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/fork.c~1_KILL	2006-02-15 22:52:07.000000000 +0300
+++ 2.6.16-rc3/kernel/fork.c	2006-02-15 23:21:51.000000000 +0300
@@ -1123,8 +1123,8 @@ static task_t *copy_process(unsigned lon
 		p->real_parent = current;
 	p->parent = p->real_parent;
 
+	spin_lock(&current->sighand->siglock);
 	if (clone_flags & CLONE_THREAD) {
-		spin_lock(&current->sighand->siglock);
 		/*
 		 * Important: if an exit-all has been started then
 		 * do not create this new thread - the whole thread
@@ -1162,8 +1162,6 @@ static task_t *copy_process(unsigned lon
 			 */
 			p->it_prof_expires = jiffies_to_cputime(1);
 		}
-
-		spin_unlock(&current->sighand->siglock);
 	}
 
 	/*
@@ -1189,6 +1187,7 @@ static task_t *copy_process(unsigned lon
 
 	nr_threads++;
 	total_forks++;
+	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	proc_fork_connector(p);
 	return p;
