Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbTD3S6T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 14:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbTD3S6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 14:58:19 -0400
Received: from [12.47.58.20] ([12.47.58.20]:50751 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262322AbTD3S6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 14:58:05 -0400
Date: Wed, 30 Apr 2003 12:11:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
Message-Id: <20030430121105.454daee1.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.51.0304301212130.1728@dns.toxicfilms.tv>
References: <20030429155731.07811707.akpm@digeo.com>
	<Pine.LNX.4.51.0304301212130.1728@dns.toxicfilms.tv>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2003 19:10:19.0169 (UTC) FILETIME=[23F4E910:01C30F4C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:
>
> > kernel/
> > -------
> >
> > - O(1) scheduler starvation, poor behaviour seems unresolved.
> >
> >   Jens: "I've been running 2.5.67-mm3 on my workstation for two days, and
> >   it still doesn't feel as good as 2.4.  It's not a disaster like some
> >   revisisons ago, but it still has occasional CPU "stalls" where it feels
> >   like a process waits for half a second of so for CPU time.  That's is very
> >   noticable."
> Well, i had similar problems with 2.5 stalling, but now that i disabled
> preemtible kernel, it is better now. Are there no complaints about preemt?

I have not heard of any, apart from yours.

> Also there is one issue, i am not sure if this may be a kernel issue,
> but with setiathome running in a X desktop environment all apps work fine,
> but when i run openoffice, openoffice responds with 5 second delay.

That'll be the changed sched_yield() semantics.

The below patch should fix that up, but we need to decide whether the (rather
unclear) advantages of the sched_yield() change outweigh the breakage which
it caused linuxthreads applications.


diff -puN kernel/sched.c~sched_yield-hack kernel/sched.c
--- 25/kernel/sched.c~sched_yield-hack	2003-04-30 12:08:51.000000000 -0700
+++ 25-akpm/kernel/sched.c	2003-04-30 12:09:11.000000000 -0700
@@ -1992,7 +1992,7 @@ asmlinkage long sys_sched_yield(void)
 	 */
 	if (likely(!rt_task(current))) {
 		dequeue_task(current, array);
-		enqueue_task(current, rq->expired);
+		enqueue_task(current, array);
 	} else {
 		list_del(&current->run_list);
 		list_add_tail(&current->run_list, array->queue + current->prio);

_

