Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWFISB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWFISB2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbWFISB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:01:28 -0400
Received: from mtaout2.012.net.il ([84.95.2.4]:58186 "EHLO mtaout2.012.net.il")
	by vger.kernel.org with ESMTP id S1030333AbWFISB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:01:27 -0400
Date: Fri, 09 Jun 2006 17:32:02 +0300
From: Andrey Gelman <agelman@012.net.il>
Subject: Assumably a BUG in Linux Kernel (scheduler part)
X-012-Sender: agelman@012.net.il
To: linux-kernel@vger.kernel.org
Message-id: <200606091732.02943.agelman@012.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.8.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there !
Assumably, I've discovered a bug in Linux kernel (version 2.6.16), at:
kernel\sched.c   function set_user_nice()

Problem description:
After you execute nice() system call, the dynamic priority is set to the new 
value of the static priority, instead of being adjusted by a difference 
between new and old nice values.
In other words:
What you have before you execute nice():  p->prio == static_prio - bonus
After you execute nice():  p->prio == "a new" static_prio  (no bonus)

BUG Fix:
Here I paste the whole of function set_user_nice() (thanks god, it's short) 
with the BUG highlighted and fixed:

void set_user_nice(task_t *p, long nice)
{
        unsigned long flags;
        prio_array_t *array;
        runqueue_t *rq;
        int old_prio, new_prio, delta;

        if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
                return;
        /*
         * We have to be careful, if called from sys_setpriority(),
         * the task might be in the middle of scheduling on another CPU.
         */
        rq = task_rq_lock(p, &flags);
        /*
         * The RT priorities are set via sched_setscheduler(), but we still
         * allow the 'normal' nice value to be set - but as expected
         * it wont have any effect on scheduling until the task is
         * not SCHED_NORMAL/SCHED_BATCH:
         */
        if (rt_task(p)) {
                p->static_prio = NICE_TO_PRIO(nice);
                goto out_unlock;
        }
        array = p->array;
        if (array)
                dequeue_task(p, array);
//-------------------------------------------------
/*
	//BUGGED FORMULA : 5 lines
        old_prio = p->prio;
        new_prio = NICE_TO_PRIO(nice);
        delta = new_prio - old_prio;
        p->static_prio = NICE_TO_PRIO(nice);
        p->prio += delta;
*/
    //BUG FIX : 5 lines
    old_prio = p->static_prio;
    new_prio = NICE_TO_PRIO(nice);
    delta = new_prio - old_prio;
    p->static_prio = new_prio;
    p->prio += delta;
//-------------------------------------------------
        if (array) {
                enqueue_task(p, array);
                /*
                 * If the task increased its priority or is running and
                 * lowered its priority, then reschedule its CPU:
                 */
                if (delta < 0 || (delta > 0 && task_running(rq, p)))
                        resched_task(rq->curr);
        }
out_unlock:
        task_rq_unlock(rq, &flags);
}



Thank you,
Andrey Gelman,
Haifa, ISRAEL
9-Jun-2006
