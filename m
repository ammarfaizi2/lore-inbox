Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbTEADFH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 23:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbTEADFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 23:05:06 -0400
Received: from pop.gmx.de ([213.165.64.20]:29154 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262139AbTEADFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 23:05:05 -0400
Message-Id: <5.2.0.9.2.20030501035717.00ca26c8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Thu, 01 May 2003 05:21:59 +0200
To: Andrew Morton <akpm@digeo.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: must-fix list for 2.6.0
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
In-Reply-To: <20030430121105.454daee1.akpm@digeo.com>
References: <Pine.LNX.4.51.0304301212130.1728@dns.toxicfilms.tv>
 <20030429155731.07811707.akpm@digeo.com>
 <Pine.LNX.4.51.0304301212130.1728@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:11 PM 4/30/2003 -0700, Andrew Morton wrote:
>Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:
> >
> >
> > Also there is one issue, i am not sure if this may be a kernel issue,
> > but with setiathome running in a X desktop environment all apps work fine,
> > but when i run openoffice, openoffice responds with 5 second delay.
>
>That'll be the changed sched_yield() semantics.
>
>The below patch should fix that up, but we need to decide whether the (rather
>unclear) advantages of the sched_yield() change outweigh the breakage which
>it caused linuxthreads applications.
>
>
>diff -puN kernel/sched.c~sched_yield-hack kernel/sched.c
>--- 25/kernel/sched.c~sched_yield-hack  2003-04-30 12:08:51.000000000 -0700
>+++ 25-akpm/kernel/sched.c      2003-04-30 12:09:11.000000000 -0700
>@@ -1992,7 +1992,7 @@ asmlinkage long sys_sched_yield(void)
>         */
>         if (likely(!rt_task(current))) {
>                 dequeue_task(current, array);
>-               enqueue_task(current, rq->expired);
>+               enqueue_task(current, array);
>         } else {
>                 list_del(&current->run_list);
>                 list_add_tail(&current->run_list, array->queue + 
> current->prio);
>
>_

That won't work, because the scheduler will keep re-selecting the yielding 
task if it's interactive.  I tried this yesterday.  (besides, don't you 
need to set_tsk_need_resched(current) there?)  An easy way to see it not 
work as expected, is to change CHILD_PENALTY to 99, and add 
current->sleep_avg=MAX_SLEEP_AVG  to sched_init() before 
wake_up_forked_process().  Your next boot will 100% guaranteed hang while 
starting ksoftirqd until the parent gets expired.  You'll read "POSIX 
conformance testing by UNIFIX" until then :)

         -Mike 

