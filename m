Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWFTQJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWFTQJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWFTQJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:09:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:14477 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751382AbWFTQJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:09:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=Mq4tmawm5L8Edri06N3lzfMp9Q3x/Pwh4IP2EZZW2J0YeAFy2EL1dLriAMz5tAnwkVd9caQspfw5R7P68iIFeb1HFAevVGvzoeSFFgnJLC1XE4R0uPp0zbX07lxk68MBl8Q/FNrRaGRP99R+davBej48/baj/68u/204Q0Ip0NY=
Date: Tue, 20 Jun 2006 18:09:44 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <1150816429.6780.222.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
 <1150816429.6780.222.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Thomas Gleixner wrote:

> On Tue, 2006-06-20 at 17:01 +0100, Esben Nielsen wrote:
>> Hi,
>>   I wanted to run some tests with RTExec and I wanted to play around with
>> the priorities, but I could not set the priorities of softirq-hrtXXXX.
>> I looked a bit in the code and found that hrtimer_adjust_softirq_prio() is
>> called every loop, setting it back to priority 1.
>>
>> Why is that? Can it be fixed so it behaves as any other task you can use
>> chrt on?
>
> No, please see
>
> http://www.linutronix.de/index.php?mact=News,cntnt01,detail,0&cntnt01articleid=8&cntnt01dateformat=%25b%20%25d%2C%20%25Y&cntnt01returnid=31
>
> Dynamic priority support for high resolution timers
>

I am sorry. I should have read some more of the code before asking.

The only question I have is why the priority of the callback is set to
priority of the task calling hrtimer_start() (current->normal_prio). That 
seems like an odd binding to me. Shouldn't the finding of the priority be moved over to the 
posix-timer code, where it is needed, and be given as a parameter to 
hrtimer_start()?
In rtmutex.c, where a hrtimer is used as a timeout on a mutex, wouldn't it 
make more sense to use current->prio than current->normal_prio if the task 
is boosted when it starts to wait on a mutex.


But I am not sure I like the design at all:

Let say you have a bunch of callback running at priority 1 and then the 
next hrt timer with priority 99 expires. Then the callback which 
is running will be boosted to priority 99. So the overall latency at 
priority 99 will at least the latency of the worst hrtimer callback.
And worse: What if the callback running is blocked on a mutex? Will the 
owner of the mutex be boosted as well? Not according to the code in 
sched.c. Therefore you get priority inversion to priority 1. That is the 
worst case hrtimer latency is that of priority 1.

Therefore, a simpler and more robust design would be to give the thread 
priority 99 as a default - just as the posix_cpu_timer thread. Then the 
system designer can move it around with chrt when needed.
In fact you can say the current design have both the worst cases of having 
it running as priority 99 and at priority 1!

Another complicated design would be to make a task for each priority. 
Then the interrupt wakes the highest priority one, which handles the first 
callback and awakes the next one etc.


Esben


> 	tglx
>
>
