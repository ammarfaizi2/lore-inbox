Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265807AbUFDPJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265807AbUFDPJQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 11:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265790AbUFDPJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 11:09:16 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:47821 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S265807AbUFDPJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 11:09:06 -0400
Message-ID: <40C090DE.55A6C699@nospam.org>
Date: Fri, 04 Jun 2004 17:10:22 +0200
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Reply-To: Zoltan.Menyhart@bull.net
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Scheduler questions
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to understand which task structure elements are protected by
which locks (as far as scheduling is concerned). Is there somewhere a
paper summarizing the mutual exclusion rules ?

Let's take some code e.g. from the 2.6.5 kernel:

set_cpus_allowed(task_t *p, cpumask_t new_mask):

	rq = task_rq_lock(p, &flags)
	__set_cpus_allowed(p, new_mask, &req):

		p->cpus_allowed = new_mask
		/*
		 * If the task is not on a runqueue (and not running), then
		 * it is sufficient to simply update the task's cpu field.
		 */
		if (!p->array && !task_running(rq, p))
			set_task_cpu(p, any_online_cpu(p->cpus_allowed))
		/* ... */

	task_rq_unlock(rq, &flags)

Apparently, the "p->cpus_allowed" and the "p->thread_info->cpu" fields
are protected by the "(&per_cpu(runqueues, (p->thread_info->cpu)))->lock".

Which are the other task structure elements protected by the same lock ?

Let's take an example:

- I've got a sleeping task that ran on the CPU #3 previously
- I want to set its CPU mask equal to {1, 2}
- I take the lock of the run queue #3
- I do set the CPU mask of the task
- It's not running (BTW when can happen that "p->array" is NULL and the
  task is still running ?)
- I do set the task's CPU e.g. equal to 2. As a consequence, the task
  falls out of the protection provided by the lock of the run queue #3.
- Someone else deciding to play with the same task, s/he takes the
  lock of the run queue #2 !!!
- Me, I have not arrived yet to the unlock. There are stuffs to do before.
- Both of us think to have the exclusive access right to the task...

Can someone explain me, please, why I have to take a run queue lock
to protect a not running task, and why we do not use "proc_lock"
instead ?

Thanks,

Zoltán Menyhárt
