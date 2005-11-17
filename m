Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVKQJ7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVKQJ7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 04:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVKQJ7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 04:59:00 -0500
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:54166 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750727AbVKQJ67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 04:58:59 -0500
From: Con Kolivas <kernel@kolivas.org>
To: liyu@ccoss.com.cn
Subject: Re: [Question]How to restrict some kind of task?
Date: Thu, 17 Nov 2005 20:57:32 +1100
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4379B5EB.40709@ccoss.com.cn> <437A8867.8080809@ccoss.com.cn> <437C2133.2030103@ccoss.com.cn>
In-Reply-To: <437C2133.2030103@ccoss.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511172057.33131.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2005 17:20, liyu wrote:
> I fixed it. we should insert code start of enqueue_task():
>
> static void enqueue_task(struct task_struct *p, prio_array_t *array)
> {
>              unsigned long flags;
>
>              spin_lock_irqsave(&(task_rq(p)->keep_lock), flags);
>              if (p->flags & PF_KEEPOVER) {
>                      list_del(&p->run_list);
>                      p->state = TASK_RUNNING;
>                      p->flags &= ~PF_KEEPOVER;
>              }
>              spin_unlock_irqrestore(&(task_rq(p)->keep_lock), flags);
>
> ....
> }
> However, this patch still have problem, it may lock entire system.
>
> I am trying to catch this bug~.

The obvious bug is that there are places that expect a task to be added to the 
run list after it has called enqueue_task and you've broken that expectation. 
The locking in the rest of your patch did not look too robust, but I don't 
have time to review it sorry.

Cheers,
Con
