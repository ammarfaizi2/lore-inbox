Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSGHWlW>; Mon, 8 Jul 2002 18:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317209AbSGHWlV>; Mon, 8 Jul 2002 18:41:21 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:59153 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317215AbSGHWlV>;
	Mon, 8 Jul 2002 18:41:21 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal 
In-reply-to: Your message of "Mon, 08 Jul 2002 20:13:31 +0200."
             <20020708181331.GD28335@atrey.karlin.mff.cuni.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 08:43:50 +1000
Message-ID: <21009.1026168230@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jul 2002 20:13:31 +0200, 
Pavel Machek <pavel@ucw.cz> wrote:
>Keith Owens wrote
>> BTW, freeze_processes() silently ignores zombie processes.  The test is
>> not obvious, it is hidden in the INTERESTING macro which has an
>> embedded 'continue' to break out of the loop.  Easy to miss.
>
>Is there problems? Zombie processes are basically dead, not
>interesting, processes.

I have had reports of module threads being shut down by the cleanup
routine, the module was removed then the zombie threads were reaped and
got an oops because the module code that spawned them no longer
existed.  It is not clear why this is a problem, I will follow up with
the reporter.

>> freeze_processes()
>>   signal_wake_up() - sets TIF_SIGPENDING for other task
>>     kick_if_running()
>>       resched_task() - calls preempt_disable() for this cpu
>>         smp_send_reschedule()
>>           smp_reschedule_interrupt() - now on another cpu
>>             ret_from_intr
>>               resume_kernel - on other cpu
>> 
>> With CONFIG_PREEMPT, a process running on another cpu without a lock
>> when freeze_processes() is called should immediately end up in
>> schedule.  I don't see anything in that code path that disables
>> preemption on other cpus.  If I am right, then a second cpu could be in
>> this window when freeze_processes is called
>> 
>>   if (xxx->func)
>>     xxx->func()
>
>okay, so we have
>
>	if (xxx->func)
>		interrupt
>			schedule()
>
>but schedule at this point is certainly not going to enter signal
>handling code

With preempt it will.  The interrupt drops back through ret_from_intr
-> resume_kernel.  The preempt count is 0, preemption has only been
disabled on the sending cpu, not the receiving cpu.  need_resched is
entered immediately.

