Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbWBORzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWBORzz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWBORzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:55:55 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:37526 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751183AbWBORzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:55:54 -0500
Message-ID: <43F37D56.2D7AB32F@tv-sign.ru>
Date: Wed, 15 Feb 2006 22:13:26 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/2] fix kill_proc_info() vs fork() theoretical race
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

copy_process:

	attach_pid(p, PIDTYPE_PID, p->pid);
	attach_pid(p, PIDTYPE_TGID, p->tgid);

What if kill_proc_info(p->pid) happens in between?

copy_process() holds current->sighand.siglock, so we are safe
in CLONE_THREAD case, because current->sighand == p->sighand.

Otherwise, p->sighand is unlocked, the new process is already
visible to the find_task_by_pid(), but have a copy of parent's
'struct pid' in ->pids[PIDTYPE_TGID].

This means that __group_complete_signal() may hang while doing

	do ... while (next_thread() != p)

We can solve this problem if we reverse these 2 attach_pid()s:

	attach_pid() does wmb()

	group_send_sig_info() calls spin_lock(), which
	provides a read barrier. // Yes ?

I don't think we can hit this race in practice, but still.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.16-rc3/kernel/fork.c~2_HANG	2006-02-15 23:21:51.000000000 +0300
+++ 2.6.16-rc3/kernel/fork.c	2006-02-16 00:03:20.000000000 +0300
@@ -1173,8 +1173,6 @@ static task_t *copy_process(unsigned lon
 	if (unlikely(p->ptrace & PT_PTRACED))
 		__ptrace_link(p, current->parent);
 
-	attach_pid(p, PIDTYPE_PID, p->pid);
-	attach_pid(p, PIDTYPE_TGID, p->tgid);
 	if (thread_group_leader(p)) {
 		p->signal->tty = current->signal->tty;
 		p->signal->pgrp = process_group(current);
@@ -1184,6 +1182,8 @@ static task_t *copy_process(unsigned lon
 		if (p->pid)
 			__get_cpu_var(process_counts)++;
 	}
+	attach_pid(p, PIDTYPE_TGID, p->tgid);
+	attach_pid(p, PIDTYPE_PID, p->pid);
 
 	nr_threads++;
 	total_forks++;
