Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270775AbUJUSVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270775AbUJUSVR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270781AbUJUSH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:07:29 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:21654 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S270782AbUJUSGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:06:06 -0400
From: Aleksey Makarov <amakarov@ru.mvista.com>
To: rml@ximian.com
Subject: [BUG] MAX_RT_PRIO != MAX_USER_RT_PRIO
Date: Thu, 21 Oct 2004 22:07:29 +0400
User-Agent: KMail/1.6.2
Cc: ext-rt-dev@mvista.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410212207.29923.amakarov@ru.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

After debugging some strange memory corruptions in 
SMP kernel I discovered this bug.

First, some excerpts from linux 2.6.9:

Documentation/sched-coding.txt:60:
--8<-------------------------------8<----------------
MAX_PRIO
        The maximum priority of the system, stored in the task as task->prio.
        Lower priorities are higher.  Normal (non-RT) priorities range from
        MAX_RT_PRIO to (MAX_PRIO - 1).
MAX_RT_PRIO
        The maximum real-time priority of the system.  Valid RT priorities
        range from 0 to (MAX_RT_PRIO - 1).
MAX_USER_RT_PRIO
        The maximum real-time priority that is exported to user-space.  Should
        always be equal to or less than MAX_RT_PRIO.  Setting it less allows
        kernel threads to have higher priorities than any user-space task.
--8<-------------------------------8<----------------

kernel/sched.c:4130:
--8<-------------------------------8<----------------
_setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);
--8<-------------------------------8<----------------

kernel/sched.c:3169
--8<-------------------------------8<----------------
static void __setscheduler(struct task_struct *p, int policy, int prio)
{
        BUG_ON(p->array);
        p->policy = policy;
        p->rt_priority = prio;
        if (policy != SCHED_NORMAL)
                p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
        else
                p->prio = p->static_prio;
}
--8<-------------------------------8<----------------

Let MAX_RT_PRIO = 120, MAX_USER_RT_PRIO = 100, CONFIG_SMP = y.

Then, after __setscheduler() call in kernel/sched.c:4130, 
value of p->prio will be -20.

p->prio is used, for example, in kernel/sched.c:707:
_set_bit(p->prio, array->bitmap);
So, instead of setting a bit in bitmap array of struct prio, 
it changes the nr_active field.

Aleksey Makarov

