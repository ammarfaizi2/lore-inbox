Return-Path: <linux-kernel-owner+w=401wt.eu-S1751633AbXAUVVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbXAUVVA (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 16:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbXAUVVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 16:21:00 -0500
Received: from guri.is.scarlet.be ([193.74.71.22]:58620 "EHLO
	guri.is.scarlet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbXAUVU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 16:20:59 -0500
X-Greylist: delayed 6608 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jan 2007 16:20:59 EST
Message-ID: <45B3F7A5.2050708@joow.be>
Date: Sun, 21 Jan 2007 20:30:45 -0300
From: Pieter Palmers <pieterp@joow.be>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: status of: tasklet_unlock_wait() causes soft lockup with -rt and
 ieee1394	audio
References: <1152371924.4736.169.camel@mindpipe>
In-Reply-To: <1152371924.4736.169.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC-scarlet.be-Metrics: guri 20001; Body=5 Fuz1=5 Fuz2=5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

What is the status with respect to this problem? I see that in the 
current -rt patch the problematic code piece is different. I personally 
haven't tried to reproduce this myself on a more recent kernel, but I 
just got a report from one of our users who experienced the same problem 
with 2.6.19-rt15 and RT preemption (desktop preemption works fine).

Should the latest -rt patches be fixed with respect to this issue? If so 
I'll try and test them, otherwise I omit the effort.

Thanks,

Pieter

Lee Revell wrote:
> Pieter has found this bug in -rt:
> 
> We are experiencing 'soft' deadlocks when running our code (Freebob, 
> i.e. userspace lib for firewire audio) on RT kernels. After a few 
> seconds of system freeze, I get a kernel panic message that signals a soft lockup.
> 
> I've uploaded the photo's of the panic here:
> http://freebob.sourceforge.net/old/img_3378.jpg (without flash)
> http://freebob.sourceforge.net/old/img_3377.jpg (with flash)
> both are of suboptimal quality unfortunately, but all info is readable 
> on one or the other.
> 
> The problems occur when an ISO stream (receive and/or transmit) is shut 
> down in a SCHED_FIFO thread. More precisely when running the freebob 
> jackd backend in real-time mode. And even more precise: they only seem 
> to occur when jackd is shut down. There are no problems when jackd is 
> started without RT scheduling.
> 
> I havent been able to reproduce this with other test programs that are 
> shutting down streams in a SCHED_FIFO thread.
> 
> The problem is not reproducible on non-RT kernels, and it only occurs on those configured for 
> PREEMPT_RT. If I use PREEMPT_DESKTOP, there is no problem. The PREEMPT_DESKTOP setting was the only change between the two tests, all other kernel settings (threaded irq's etc...) were unchanged.
> 
> My tests are performed on 2.6.17-rt1, but the lockups are confirmed for 
> PREEMPT_RT configured kernels 2.6.14 and 2.6.16.
> 
> Some extra information:
> 
> Lee Revell wrote:
> 
>> <...>
>>
>> It seems that the -rt patch changes tasklet_kill:
>>
>> Unpatched 2.6.17:
>>
>> void tasklet_kill(struct tasklet_struct *t)
>> {
>>         if (in_interrupt())
>>                 printk("Attempt to kill tasklet from interrupt\n");
>>
>>         while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
>>                 do
>>                         yield();
>>                 while (test_bit(TASKLET_STATE_SCHED, &t->state));
>>         }
>>         tasklet_unlock_wait(t);
>>         clear_bit(TASKLET_STATE_SCHED, &t->state);
>> }
>>
>> 2.6.17-rt:
>>
>> void tasklet_kill(struct tasklet_struct *t)
>> {
>>         if (in_interrupt())
>>                 printk("Attempt to kill tasklet from interrupt\n");
>>
>>         while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
>>                 do                              msleep(1);
>>                 while (test_bit(TASKLET_STATE_SCHED, &t->state));
>>         }
>>         tasklet_unlock_wait(t);
>>         clear_bit(TASKLET_STATE_SCHED, &t->state);
>> }
>>
>> You should ask Ingo & the other -rt developers what the intent of this
>> change was.  Obviously it loops forever waiting for the state bit to
>> change.
> 
> On Thu, 2006-07-06 at 22:14 +0200, Pieter Palmers wrote:
> 
>>> I've put the debugging printk's into tasklet_kill. One interesting 
>>> remark is that now that they are in place, I had to start/stop jackd 
>>> multiple times before deadlock occurs. Without the printk's the machine 
>>> always locked up on the first pass. However I stopped after the first 
>>> lockup, so maybe this is not really significant.
>>>
>>> Anyway, the new tasklet_kill looks like this:
>>>
>>> void tasklet_kill(struct tasklet_struct *t)
>>> {
>>> 	printk("enter tasklet_kill\n");
>>> 	if (in_interrupt())
>>> 		printk("Attempt to kill tasklet from interrupt\n");
>>> 	
>>> 	printk("passed interrupt check\n");
>>>
>>> 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
>>> 		do
>>> 			msleep(1);
>>> 		while (test_bit(TASKLET_STATE_SCHED, &t->state));
>>> 	}
>>> 	printk("passed test_and_set_bit\n");
>>> 	
>>> 	tasklet_unlock_wait(t);
>>> 	printk("passed tasklet_unlock_wait\n");
>>> 	
>>> 	clear_bit(TASKLET_STATE_SCHED, &t->state);
>>> }
>>>
>>> And the last line printed before lockup is:
>>> "passed test_and_set_bit"
>>   
> This makes the change in tasklet_unlock_wait() as the prime suspect for this problem.
> 
> 
> 
> 
> 
> 
> 

