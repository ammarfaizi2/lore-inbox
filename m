Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030365AbVI3QjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030365AbVI3QjA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 12:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030366AbVI3QjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 12:39:00 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:16534 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030365AbVI3QjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 12:39:00 -0400
Message-ID: <433D6CFB.C1BA3F1F@tv-sign.ru>
Date: Fri, 30 Sep 2005 20:51:07 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix TASK_STOPPED vs TASK_NONINTERACTIVE interaction
References: <20050929215442.74EE0180E20@magilla.sf.frob.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland, could you please explain this code in wait_task_stopped()

	if (!exit_code || p->state > TASK_STOPPED)
		goto bail_ref;

It looks like "WSTOPPED | WNOWAIT is illegal for TASK_TRACED child"
to me. Is this correct? I think no.

Actually, I don't understand why we are checking p->state at all, we
already dropped tasklist_lock, the state can change at any monent.

Also, wait_task_stopped() calculates ->si_code outside tasklist, is
it correct?

In other words, could you explain why this (untested) patch incorrect ?

Thanks in advance,
Oleg.

--- 2.6.14-rc2/kernel/exit.c~	2005-09-24 18:33:35.000000000 +0400
+++ 2.6.14-rc2/kernel/exit.c	2005-10-01 00:45:06.000000000 +0400
@@ -1174,10 +1174,13 @@ static int wait_task_stopped(task_t *p, 
 			     struct siginfo __user *infop,
 			     int __user *stat_addr, struct rusage __user *ru)
 {
-	int retval, exit_code;
+	int retval, why, exit_code = p->exit_code;
 
-	if (!p->exit_code)
+	if (!exit_code)
 		return 0;
+
+	why = (p->ptrace & PT_PTRACED) ? CLD_TRAPPED : CLD_STOPPED;
+
 	if (delayed_group_leader && !(p->ptrace & PT_PTRACED) &&
 	    p->signal && p->signal->group_stop_count > 0)
 		/*
@@ -1196,19 +1199,10 @@ static int wait_task_stopped(task_t *p, 
 	get_task_struct(p);
 	read_unlock(&tasklist_lock);
 
-	if (unlikely(noreap)) {
-		pid_t pid = p->pid;
-		uid_t uid = p->uid;
-		int why = (p->ptrace & PT_PTRACED) ? CLD_TRAPPED : CLD_STOPPED;
-
-		exit_code = p->exit_code;
-		if (unlikely(!exit_code) ||
-		    unlikely(p->state > TASK_STOPPED))
-			goto bail_ref;
-		return wait_noreap_copyout(p, pid, uid,
+	if (unlikely(noreap))
+		return wait_noreap_copyout(p, p->pid, p->uid,
 					   why, (exit_code << 8) | 0x7f,
 					   infop, ru);
-	}
 
 	write_lock_irq(&tasklist_lock);
 
@@ -1235,7 +1229,6 @@ static int wait_task_stopped(task_t *p, 
 		 * resumed, or it resumed and then died.
 		 */
 		write_unlock_irq(&tasklist_lock);
-bail_ref:
 		put_task_struct(p);
 		/*
 		 * We are returning to the wait loop without having successfully
@@ -1252,6 +1245,7 @@ bail_ref:
 	remove_parent(p);
 	add_parent(p, p->parent);
 
+	why = (p->ptrace & PT_PTRACED) ? CLD_TRAPPED : CLD_STOPPED;
 	write_unlock_irq(&tasklist_lock);
 
 	retval = ru ? getrusage(p, RUSAGE_BOTH, ru) : 0;
@@ -1262,9 +1256,7 @@ bail_ref:
 	if (!retval && infop)
 		retval = put_user(0, &infop->si_errno);
 	if (!retval && infop)
-		retval = put_user((short)((p->ptrace & PT_PTRACED)
-					  ? CLD_TRAPPED : CLD_STOPPED),
-				  &infop->si_code);
+		retval = put_user((short)why, &infop->si_code);
 	if (!retval && infop)
 		retval = put_user(exit_code, &infop->si_status);
 	if (!retval && infop)
