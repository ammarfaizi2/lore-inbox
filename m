Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030253AbWA0B5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbWA0B5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWA0B5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:57:11 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:49405 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030253AbWA0B5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:57:10 -0500
Subject: [RT] possible bug in trace_start_sched_wakeup
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 26 Jan 2006 20:57:02 -0500
Message-Id: <1138327022.7814.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I've been agonizing over the latency code, and have a question about
__trace_start_sched_wakup.

Here we have:

void __trace_start_sched_wakeup(struct task_struct *p)
{
	struct cpu_trace *tr;
	int cpu;

	if (trace_user_triggered || !wakeup_timing)
		return;

	spin_lock(&sch.trace_lock);
	if (sch.task && (sch.task->prio >= p->prio))
		goto out_unlock;


I don't get the sch.task->prio >= p->prio.  Here the lower the number
the greater the priority.  So this if statement is saying:

If sch.task is either NULL or if p is greater in priority than or equal
to the priority of sch.task then quit.

Then again later in  trace_stop_sched_switched:

		if (sch.task && (sch.task->prio >= p->prio))
			sch.task = NULL;

Again, if p is a higher priority than sch.task we set sch.task to NULL??


What am I missing here?

Thanks,

-- Steve

