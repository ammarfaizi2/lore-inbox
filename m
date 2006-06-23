Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932996AbWFWKXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932996AbWFWKXj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932997AbWFWKXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:23:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:40743 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932996AbWFWKXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:23:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=MYO0Z2rV45yG4RPOihRMPz+zwWB1uBYUNTthTeayDm/rgZnay7RaqmUJvSf6QcG7aKoZqP2Iy83nnv+eGd4TN/Am3QOnXwVmrloZIBnaCo0qMFCYKarzcq5WAxpR5l2Pl7/sJf62IinvDVJt41dL7X4pkdA6920yZsTH9EJ6jTg=
Date: Fri, 23 Jun 2006 12:23:44 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Thomas Gleixner <tglx@linutronix.de>
cc: Esben Nielsen <nielsen.esben@googlemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
In-Reply-To: <1150999517.25491.151.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0606230055390.13514@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>  <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
  <1150816429.6780.222.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain> 
 <1150824092.6780.255.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain> 
 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com> 
 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain> 
 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain> 
 <1150907165.25491.4.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0606220936290.15236@gandalf.stny.rr.com> 
 <1150986041.25491.53.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0606221021410.15236@gandalf.stny.rr.com> 
 <1150986396.25491.56.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0606221902560.10511@localhost.localdomain>
 <1150999517.25491.151.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Thomas Gleixner wrote:

> On Thu, 2006-06-22 at 19:06 +0100, Esben Nielsen wrote:
>>>
>>> Thats a seperate issue. Though you are right.
>>
>> Why not use my original patch and solve both issues?
>> I have even updated it to avoid the double traversal. It also removes
>> one other traversal which shouldn't be needed. (I have not had time
>> to boot the kernel with it, though, but it does compile...:-)
>

Let me comment on your last sentence first:

> We want an immidate propagation.
There is no such thing as "immidiate". The most you can say is that when 
you  return from setscheduler() everything is taken care off. I agree - it 
has to be like that. But I just want to add _effectively_ taken care off. I.e. 
when the within the time setscheduler() has returned _and_ the the 
relevant priorities have time to run things get fixed. No, the users 
should not have to worry about the priorities hanging around, but the 
system can wait with fixing them it is relavant.

> Simply because it does not solve following scenario:
>
> High prio task is blocked on lock and boosts 3 other tasks. Now the
> higher prrio watchdog detects that the high prio task is stuck and
> lowers the priority. You can wake it up as long as you want, the boosted
> task is still busy looping.

Yes, you are right. I have thought about how to fix it, but it will be 
rather ugly. I'll try to see what I can do though, but I am afraid the 
patch might get too big. :-(

(
The same problem may actually always have been present in another corner 
situation:
    A boosts B whichs is blocked interruptible on a lock a boosts C, which 
again boosts D (etc.). A and B are signalled roughly at the same time. A 
wakes up first a decrease the priority of B but not C, because the B runs 
on another CPU, but with lower priority and fixes C. A then stops because C is
fixed. but D still have the A's priority and preempts B, which should fix 
it, but has it's low priority back.
  This situation is not bad because A has already been in the and 
therefore the designer has to think that C D etc already got it's 
priority. That A is later on interrupted shouldn't matter.
)

May I suggest a compromise:

if (in_interrupt() ||
     ( increasing priority && current->prio < prio ) )
            do it Esben's way;
else
            do it Thomas's way;

Then will have fixed most of the problems. We still have the problem of a 
the high priority watchdog task being unbound in setscheduler(), though. 
And if it is called from interrupt and used to descrease the priority, it 
wont work correctly. But it will work for the use in hrtimers, where the 
priority is increased from interrupt.


> And I do not like the idea of invoking the scheduler to do those
> propagations. setscheduler is a synchronous effect in all other cases.
> So it has to be synchronous in the propagation case too.

See my note above about being "immediate". Syncronous is more precise but 
the same argument holds.

>
> Preempt-RT and the dynamic priority adjustment of high resolution timers
> is a different playground and we have to think about that seperately.

*nod*
I agree, although we deffinitely don't want to have too many #ifdef 
CONFIG_PREEMPT_RT around in the code. That makes it far harder to get into 
the mainline tree.

I was bonked for using the other thread for preempt-realtime stuff, so I 
assume this thread is for preempt-realtime stuff only :-)

>
> 	tglx
>
>
