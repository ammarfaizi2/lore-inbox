Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbUAKQ50 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUAKQ50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:57:26 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:64673 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265918AbUAKQ5Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:57:24 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 11 Jan 2004 08:57:28 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Der Herr Hofrat <der.herr@hofr.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 schedule_tick question
In-Reply-To: <200401101235.i0ACZUS12298@hofr.at>
Message-ID: <Pine.LNX.4.44.0401110855420.19685-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jan 2004, Der Herr Hofrat wrote:

>  in 2.6.0 kernel/sched.c scheduler_tick currently the 
>  case of rt_tasks for SCHED_RR is doing
> 
> 	if ((p->policy == SCHED_RR) && !--p->time_slice) {
> 			...
>                         dequeue_task(p, rq->active);
>                         enqueue_task(p, rq->active);
> 
>  which is:
> 
> static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
> {
>         array->nr_active--;
>         list_del(&p->run_list);
>         if (list_empty(array->queue + p->prio))
>                 __clear_bit(p->prio, array->bitmap);
> }
> 
> static inline void enqueue_task(struct task_struct *p, prio_array_t *array)
> {
>         list_add_tail(&p->run_list, array->queue + p->prio);
>         __set_bit(p->prio, array->bitmap);
>         array->nr_active++;
>         p->array = array;
> }
> 
>  looking at these two functions this looks like quite some overhead as it
>  actually could be reduced to:
> 
>         list_del(&p->run_list);
> 	list_add_tail(&p->run_list, array->queue + p->prio);
> 
>  for the rest I don't see any effect it would have ?

Yes, we could have a rotate_task() function but the impact is basically 
zero because of the little overhead compared to the frequency of the 
operation.



- Davide


