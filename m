Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262767AbVCDPpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbVCDPpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 10:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbVCDPpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 10:45:31 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:63482 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262767AbVCDPpT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 10:45:19 -0500
Message-ID: <42288289.5070004@mvista.com>
Date: Fri, 04 Mar 2005 07:45:13 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eugeny S. Mints" <emints@ru.mvista.com>
CC: Esben Nielsen <simlo@phys.au.dk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, deactivate() scheduling issue
References: <Pine.OSF.4.05.10503032311510.22011-100000@da410.phys.au.dk> <42284CDB.5010309@ru.mvista.com>
In-Reply-To: <42284CDB.5010309@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugeny S. Mints wrote:
> Esben Nielsen wrote:
> 
>> As I read the code the driver task (A) should _not_ be removed from the
>> runqueue. It has to be waken up to call schedule_timeout() such it gets
>> back on the runqueue after 10 ms. If it is taken out of the runqueue at
>> line 76 it will stay off the runqueue forever in the TASK_UNINTERRUBTIBLE
>> state!
> 
> Exactly. This is definilty the bug in the driver code - a developer just
> didn;t care about proper utilization of set_current_state(). The driver 
> works
> just because as you have described - his fortune
> that scheduler doesn't remove task in not TASK_RUNNING state from a run 
> queue.
> And my main question was - does everybody think it's ok have task in not 
> TASK_RUNNING state in run queue. My current feeling is that this should 
> not be allowed.

This is the normal and specified way to handle this sort of thing.  There is a 
race issue that coding in this way avoids.  The coding sequence is:
a) set the task state to some state other than TASK_RUNNING.
b) do what ever triggers the wake up.  This may be several things, for example, 
an interrupt from some device OR a timeout.
c) call schedule to wait.

The race is getting to the schedule call before the wake up happens.  If, for 
some reason, the wake up condition happens prior to the schedule call, it will 
set the task state back to TASK_RUNNING so that when the schedule() call is made 
the scheduler will just return which is the right thing (tm) to do as the 
condition being waited on has happened.  We also note that disabling interrupts 
or preemption will NOT avoid the race unless you disable interrupts on ALL cpus, 
which is a VERY expensive cross cpu call.
> 
>> As I read the use PREEMPT_ACTIVE, it is there to test on whether this
>> rescheduling is voluntary or forced (a preemption). If it is forced the
>> task shall of course not go off the runqueue but stay there to run again
>> when it gets the highest priority. That is why PREEMPT_ACTIVE is set in
>> preempt_schedule() and preempt_schedule_irq(). On the other hand if the
>> task itself has called schedule() or schedule_timeout() it has to go out
>> of the runqueue and wait for some event to wake it up.
> 
> You right - it works perfectly - but not for  my test case - I believe 
> task in not TASK_RUNNING state should be removed from a run queue by the 
> first (any - voluntary or forced) execution of the schedule() which 
> detects the task state is not TASK_RUNNIG.

This would cause the task to loose control prior to its setting up the needed 
wakeup events.
> 
>>
>> Yes there will be tasks in state other that TASK_RUNNING on the runqueue.
>> The "bug" as I see it is in the scheduler interface: There is no way to
>> set the task state and call schedule() or schedule_timeout() atomicly.
>> Therefore you can be preempted while the state is not TASK_RUNNING.
> 
> Exactly. IMO this interface is weird and needs rework. I don;t understand 
> what the reason to set task state before schedule_timeout() call but not 
> inside, right before the schedule(). The actual task state may be passed 
> as a parameter.

You are assuming that the task ONLY wants to do a timeout.  Most of the time the 
timeout indicates an error condition.   The timeout bounds the wait for what is 
really desired, i.e. a device interrupt, some other task signaling, or some such.

Surly this is covered in the various driver writing guides...
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

