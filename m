Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbVJKIFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbVJKIFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 04:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVJKIFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 04:05:48 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:38843 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751412AbVJKIFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 04:05:47 -0400
Date: Tue, 11 Oct 2005 04:05:33 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: liyu <liyu@ccoss.com.cn>
cc: linux-kernel@vger.kernel.org
Subject: Re: [Question] Some question about Ingo scheduler.
In-Reply-To: <434B6F0D.4040808@ccoss.com.cn>
Message-ID: <Pine.LNX.4.58.0510110357560.1044@localhost.localdomain>
References: <434732DA.20701@ccoss.com.cn> <Pine.LNX.4.58.0510090955160.19961@localhost.localdomain>
 <434B1FBD.3000803@ccoss.com.cn> <Pine.LNX.4.58.0510110147370.30989@localhost.localdomain>
 <434B6F0D.4040808@ccoss.com.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Oct 2005, liyu wrote:

> Hi, Steve:
>
>     Thanks for so detailed explain.
>
>     It seem I am not understand what is sleep and wakeup truly.
>
>     What's your mean of "in runqueue"? I think you mean the
> task_struct is in one priority array (active or expired)
> of one queue. the schedule() only can process task in runqueue.
> In deactivate_task(), it will reset task_struct->array to NULL,
> After call it, we can not wake up that task.

Correct.  The active/expired arrays _are_ the run queue.

>
>     However, I read try_to_wake_up(), and found it can handle that case
> which task_struct->array is NULL, it will be call activate_task()
> to insert task to one runqueue. and default_wake_function() will
> call try_to_wake_up(), so we still can wake up it.

Exactly! :-)   try_to_wake_up _is_ what wakes up the task.  Now the
problem is _who_ calls try_to_wake_up.  My example is about some task that
initiates something that will happen and waits for it.  Like something
writing to disk and waiting for the write to finish.  It waits for an
interrupt or some service handler to do something.  The problem is that
the logic that I showed, has to handle the case where the event happens
before it goes to sleep (calls schedule).  Since the service provider is
the one that wakes it up, if the event happens before it goes to sleep and
the sevice provider already woke up the task (although it wasn't sleeping)
it wont wake it up again.

So, if the task is preempted in the TASK_UNINTERRUPTIBLE state and taken
off the run queue (active/expired arrays), and since the event had already
happened, _no_one_ will call try_to_wake_up on this task that is sleeping.
And the task will stay sleeping and never wake up.

>
>     I am confused again. this quesion is more interesting and more.

You're getting closer to understanding.  I can tell by your later
questions ;-)

>
>     Wait for reply.
>
>     Good luck.
>
>
> --liyu
>

-- Steve

