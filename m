Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUJHUZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUJHUZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUJHUZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:25:17 -0400
Received: from users.ccur.com ([208.248.32.211]:61488 "EHLO mig.iccur.com")
	by vger.kernel.org with ESMTP id S264530AbUJHUYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:24:55 -0400
Date: Fri, 8 Oct 2004 16:24:52 -0400
From: Joe Korty <joe.korty@ccur.com>
To: john_fodor@mitel.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: wait_event and preemption in 2.6
Message-ID: <20041008202452.GA4894@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20041008174510.GJ30977@e-smith.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041008174510.GJ30977@e-smith.com>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 08 Oct 2004 20:24:52.0938 (UTC) FILETIME=[DE3A22A0:01C4AD74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2004 at 01:45:10PM -0400, michael_soulier@mitel.com wrote:
> I'm writing a device driver for PPC Linux and I'm using wait_event. It
> seems to me that there is a potential race condition in wait_event when
> preemption is turned on (2.6 kernel).
> 
> The scenario goes something like this: After the waiting process is
> woken up and returns from schedule it goes to the top of the loop and
> prepares to wait again (despite the condition being true). Then it will
> check the condition and break out of the loop. But what if in-kernel
> preemption occurs while it's doing that and another process is
> immediately scheduled to run? Does the process sleep forever? Assume
> that the event (say interrupt) that caused the original wakeup is a one
> shot.
> 
> I'm probably missing something. I've googled for an answer and asked
> some of my Linux friends but it's not clear. Thanks for any replies.
> Please cc me.


Hi Mike,
Here is the answer Robert Love gave me to that very same question,
over a year ago.......

> On Mon, 2003-04-14 at 17:54, Joe Korty wrote:
>> Is this analysis correct?  If it is, perhaps there is an alternative
>> to fixing these cases individually: make the TASK_INTERRUPTIBLE/
>> TASK_UNINTERRUPTIBLE states block preemption.  In which case the
>> 'set_current_state(TASK_RUNNING)' macro would need to include the
>> same preemption check as 'preemption_enable'.

> Thankfully you are wrong or we would have some serious problems :)
>
> See kernel/sched.c :: preempt_schedule() where we set p->preempt_count
> to PREEMPT_ACTIVE.
>
> Then see kernel/sched.c :: schedule() where we short-circuit the
> remove-from-runqueue code if PREEMPT_ACTIVE is set.
>
> Thus, it is safe to preempt regardless of the task's state.  It will
> eventually reschedule.
>
>        Robert Love
