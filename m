Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265879AbUAKMgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbUAKMgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:36:39 -0500
Received: from chello212017098056.surfer.at ([212.17.98.56]:21521 "EHLO
	hofr.at") by vger.kernel.org with ESMTP id S265879AbUAKMgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:36:37 -0500
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200401101235.i0ACZUS12298@hofr.at>
Subject: 2.6.0 schedule_tick question
To: linux-kernel@vger.kernel.org
Date: Sat, 10 Jan 2004 13:35:30 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI !

 in 2.6.0 kernel/sched.c scheduler_tick currently the 
 case of rt_tasks for SCHED_RR is doing

	if ((p->policy == SCHED_RR) && !--p->time_slice) {
			...
                        dequeue_task(p, rq->active);
                        enqueue_task(p, rq->active);

 which is:

static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
{
        array->nr_active--;
        list_del(&p->run_list);
        if (list_empty(array->queue + p->prio))
                __clear_bit(p->prio, array->bitmap);
}

static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
{
        list_add_tail(&p->run_list, array->queue + p->prio);
        __set_bit(p->prio, array->bitmap);
        array->nr_active++;
        p->array = array;
}

 looking at these two functions this looks like quite some overhead as it
 actually could be reduced to:

        list_del(&p->run_list);
	list_add_tail(&p->run_list, array->queue + p->prio);

 for the rest I don't see any effect it would have ?

hofrat
