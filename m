Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWFTQds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWFTQds (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWFTQds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:33:48 -0400
Received: from www.osadl.org ([213.239.205.134]:24766 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751029AbWFTQdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:33:47 -0400
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>
	 <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
	 <1150816429.6780.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 18:35:11 +0200
Message-Id: <1150821311.6780.240.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-20 at 18:09 +0100, Esben Nielsen wrote:
> The only question I have is why the priority of the callback is set to
> priority of the task calling hrtimer_start() (current->normal_prio). That 
> seems like an odd binding to me. Shouldn't the finding of the priority be moved over to the 
> posix-timer code, where it is needed, and be given as a parameter to 
> hrtimer_start()?

Was the simplest way to do.

> In rtmutex.c, where a hrtimer is used as a timeout on a mutex, wouldn't it 
> make more sense to use current->prio than current->normal_prio if the task 
> is boosted when it starts to wait on a mutex.

Not sure about that.

> Let say you have a bunch of callback running at priority 1 and then the 
> next hrt timer with priority 99 expires. Then the callback which 
> is running will be boosted to priority 99. So the overall latency at 
> priority 99 will at least the latency of the worst hrtimer callback.
> And worse: What if the callback running is blocked on a mutex? Will the 
> owner of the mutex be boosted as well? Not according to the code in 
> sched.c. Therefore you get priority inversion to priority 1. That is the 
> worst case hrtimer latency is that of priority 1.
> 
> Therefore, a simpler and more robust design would be to give the thread 
> priority 99 as a default - just as the posix_cpu_timer thread. Then the 
> system designer can move it around with chrt when needed.
> In fact you can say the current design have both the worst cases of having 
> it running as priority 99 and at priority 1!

We had this before and it is horrible.

> Another complicated design would be to make a task for each priority. 
> Then the interrupt wakes the highest priority one, which handles the first 
> callback and awakes the next one etc.

Uurgh. Thats not a serious proposal ?

A nice solution would be to enqueue the timer into the task struct of
the thread which is target of the signal, wake that thread in a special
state which only runs the callback and then does the signal delivery.
The scary thing on this is to get the locking straight, but it might
well worth to try it. That way we would burden the softirq delivery to
the thread and maybe save a couple of task switches.

	tglx


