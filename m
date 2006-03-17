Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWCQWW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWCQWW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWCQWW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 17:22:26 -0500
Received: from [82.153.166.94] ([82.153.166.94]:35777 "EHLO mail.inprovide.com")
	by vger.kernel.org with ESMTP id S932212AbWCQWWZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 17:22:25 -0500
To: Mike Galbraith <efault@gmx.de>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: can I bring Linux down by running "renice -20 cpu_intensive_process"?
References: <441180DD.3020206@wpkg.org>
	<Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>
	<yw1xbqwe2c2x.fsf@agrajag.inprovide.com>
	<1142135077.25358.47.camel@mindpipe>
	<yw1xk6azdgae.fsf@agrajag.inprovide.com> <4419D575.4080203@tmr.com>
	<yw1xbqw69f6j.fsf@agrajag.inprovide.com>
	<1142575550.8868.20.camel@homer>
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Fri, 17 Mar 2006 22:22:22 +0000
In-Reply-To: <1142575550.8868.20.camel@homer> (Mike Galbraith's message of "Fri, 17 Mar 2006 07:05:50 +0100")
Message-ID: <yw1x1wx090f5.fsf@agrajag.inprovide.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> writes:

> On Thu, 2006-03-16 at 22:51 +0000, Måns Rullgård wrote:
>> Bill Davidsen <davidsen@tmr.com> writes:
>> 
>> > Måns Rullgård wrote:
>> >> Maybe extending sysrq+n to lower the priority of -20 tasks would be a
>> >> good idea.
>> >>
>> > If it runs before the keyboard thread it doesn't matter...
>> 
>> Of course not, but that's not generally the case.
>> 
>> > But why should this hang anything, when there should be enough i/o
>> > to get out of the user process. There's a good fix for this, don't
>> > give this guy root any more ;-)
>> 
>> Ever heard of bugs?  Anyone developing a program can make a mistake.
>> If the program runs with realtime scheduling a bug that makes it enter
>> an infinite loop (or do something else that hogs the CPU) can be
>> difficult to find since it rather efficiently locks you out.
>
> Given that someone has already determined that installing a safety valve
> for RT tasks was worth while, and given that there is practically no
> difference between a nice -20 and the lowest RT priority, seems to me
> that extending that safety valve to cover reniced tasks is the
> obviously-correct thing to do.  I think you should submit a patch.

Something like this ought to do it (untested):

--- kernel/sched.c.orig 2006-02-09 23:41:57.000000000 +0000
+++ kernel/sched.c      2006-03-17 22:16:46.257298014 +0000
@@ -5681,21 +5681,22 @@
 
        read_lock_irq(&tasklist_lock);
        for_each_process (p) {
-               if (!rt_task(p))
-                       continue;
+               if (rt_task(p)) {
+                       rq = task_rq_lock(p, &flags);
 
-               rq = task_rq_lock(p, &flags);
-
-               array = p->array;
-               if (array)
-                       deactivate_task(p, task_rq(p));
-               __setscheduler(p, SCHED_NORMAL, 0);
-               if (array) {
-                       __activate_task(p, task_rq(p));
-                       resched_task(rq->curr);
+                       array = p->array;
+                       if (array)
+                               deactivate_task(p, task_rq(p));
+                       __setscheduler(p, SCHED_NORMAL, 0);
+                       if (array) {
+                               __activate_task(p, task_rq(p));
+                               resched_task(rq->curr);
+                       }
+
+                       task_rq_unlock(rq, &flags);
+               } else if (TASK_NICE(p) == -20) {
+                       set_user_nice(p, 0);
                }
-
-               task_rq_unlock(rq, &flags);
        }
        read_unlock_irq(&tasklist_lock);
 }


-- 
Måns Rullgård
mru@inprovide.com
