Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWFMKIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWFMKIn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 06:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWFMKIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 06:08:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:31559 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750901AbWFMKIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 06:08:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=j+1hYOvnZQyZrl4JPpEUnhvNISOkmcRbdBug0qw0RvFdsk+EOjMUo1833cB1YdAnR2SSwDxcDVNmP3NR5sVVattm34xCF3Mey+fBt0OiUG8+5krmPpgN8xh1FhCEH85FTb+wArdJTFH1MA23rGBmX+loPXAWBOvNOPufxL5EEdc=
Date: Tue, 13 Jun 2006 12:08:43 +0100 (BST)
X-X-Sender: simlo@localhost
To: Lee Revell <rlrevell@joe-job.com>
cc: Felix Oxley <lkml@oxley.org>, kernel@wolff-online.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Good performance (hard realtime ??) on 2.6.16 patched with
 patch-2.6.16-rt29 from Ingo Molnar
In-Reply-To: <1150125964.22720.40.camel@mindpipe>
Message-ID: <Pine.LNX.4.64.0606131002050.10690@localhost>
References: <20060612095008.21733.qmail@www.wolff-online.nl> 
 <FEBBD28D-B00D-42DB-A2EB-13A501D7FBC2@oxley.org> <1150125964.22720.40.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Lee Revell wrote:

> On Mon, 2006-06-12 at 11:12 +0100, Felix Oxley wrote:
>> (Regarding Hard Real Time, my understanding is that that depends on a
>> _guarantee_ that the system will always be able to produce the
>> 'result' within the required interval. Ingo's -rt patches may give
>> exceedingly good responsiveness but they offer no guarantees, so they
>> cannot be considered Hard Real Time)
>
> The -rt kernel is capable of hard realtime, modulo any bugs, but no one
> has yet done an analysis of the few non-preemptible code paths to
> determine what guarantees it can make.
>

For me a "hard real time system" is one where a missing a deadline is a 
bug just as well as having a stray pointer is a bug. Therefore any code 
running non-preemptible and not being bound is a bug. In fact you have to 
consider all code running at equal and higher priority than your RT 
application - and do remember that PI can move tasks up in priority as well!

One may ask: What is bounded? The plist is an examble where 
operations are "bounded" mathematically speaking, but in practise one 
will never come even close to that bound. It is therefore very unlikely 
that you hit the worst case behaviour in a lab test before deploying your 
system - and that is very unfortunate :-(
I have, in another place, made a real priority heap, which operates in 
O(log N), N being the number of elements. N can in  principle be very big 
- but it is limited to the amount of elements in the system (which was 
static for the given application) and that is certainly limited to the 
amount of memory of the system. And log 1G is still only 9 compared to 
log 100 which is 2. Thus _in practice_ something O(log N) is can be 
considered bounded and is more testabl, i.e. you can come closer to the 
worst case behaviour in a lab test.

Which OSes, by the way, makes these mathematically guarentees? The hard 
realtime OS I work with at work certainly does _not_ give such. Yes, they 
do in the sales material, and the core of the OS does have a certification 
for safety critical systems. But I can still find exambles of unbounded 
code. The mutexes, forinstance, does not use plists and thus adding a 
waiter on a mutex is not a bounded operation, _theoretically_ speaking. A 
lot of the drivers and platform specific code are really bad. But the 
worst is that it doesn't implement priority inheritance correctly: It 
leaves a thread boosted until it releases the last mutex held. Therefore, 
something you considered low priority, non-RT, code can suddenly run at 
high priority!

But then again: That is an _embedded_ OS. We should in principle have 
control over _all_ the code and therefore should be able to avoid the
almost theoretical pitfalls of unbounded code.
Linux is supposed to be a general perpose OS. I.e. not priviliged users 
can run whatever code they want with normal priority (SCHED_OTHER) and the 
system should still be hard realtime! Therefore Linux has to be implemented
even without the theoretical unbounded code.

When I compare the state of preempt-realtime and the RTOS used at work, I 
would say preempt-realtime does pretty well. Especially the better 
priority inheritance implementation and the MMU support makes it far 
better at shielding the RT application from the arbitrary non-RT code. 
With the RTOS you have to be sure that every piece of code running on the 
system behaves correctly. With preempt-realtime Linux you "only" have to 
thrust the kernel and your RT application itself.

Esben


> Lee
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
