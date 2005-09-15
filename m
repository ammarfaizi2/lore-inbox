Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965283AbVIOXF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbVIOXF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 19:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbVIOXF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 19:05:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7931 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965283AbVIOXF0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 19:05:26 -0400
Message-ID: <4329FDF7.7080300@mvista.com>
Date: Thu, 15 Sep 2005 16:04:23 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.13-rt6, ktimer subsystem
References: <20050913100040.GA13103@elte.hu> <43287C52.7050002@mvista.com> <20050915092008.GA17915@elte.hu>
In-Reply-To: <20050915092008.GA17915@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * George Anzinger <george@mvista.com> wrote:
> 
> 
>>>the end-effect of ktimers is a much more deterministic HRT engine.  
>>>The original merging of HR timers into the stock timer wheel was a 
>>>Bad Idea (tm). We intend to push the ktimer subsystem upstream as 
>>>well.
>>
>>Well, having spent a bit of time looking at the code it appears that a 
>>lot of the ideas we looked at and discarded (see 
>>high-res-timers-discourse@lists.sourceforge.net) are in this.  Shame 
>>it was all done with out reference or comment to that list, anyone on 
>>it or even the lkml.
> 
> 
> this was done in the time frame of 2 days, and was posted ASAP - with you 
> Cc:-ed for the specific purpose of getting feedback from you.

Possibly your involvement was that short.  I rather doubt the code was 
written that quickly...  I first found out about it on the 12th from the 
rt5 patch you posted about 2pm.  Was there an earlier email?
> 
> given the very good performance results of ktimers, and the 
> simplification effect on the original HRT code:
> 
>    36 files changed, 2016 insertions(+), 3094 deletions(-)
> 
> it was a no-brainer to put it into the -rt tree.
> 
> 
>>I DO agree that it _looks_ nicer, cleaner and so on. But there are a 
>>lot of things we rejected in here and they really do need, at least, a 
>>hard look.
>>
>>A few of the top issues:
>>
>>time in nanoseconds 64-bits, requires a divide to do much of anything 
>>with it.  Divides are slow and should be avoided if possible.  This is 
>>especially true in the embedded market.
> 
> 
> Wrong. Divides are slow _on the micro micro level_. They make zero, nil, 
> nada difference in reality. The cleanliness difference between having a 
> flat nanosec scale and having some artificial 2x 32-bit structure are 
> significant.

Cleanliness can easily be obtained with a CPP macro.  I am not sure what 
the right answer is here.  I have heard complaints on the 64-bit thing 
on lkml WRT the work John Stultz is doing.  Also, it is real easy to 
abstract all the operations into CPP macros and choose 64 bit or 
timespec at compile time.
> 
> _By far_ the biggest problem of the HRT code is cleanliness (or the lack 
> of it), and the resulting maintenance overhead, and the resulting gut 
> reaction from upstream: "oh, yuck, bleh!". [Similar problems are true 
> for the timer code in general - by far the biggest issues are 
> organization and cleanliness, not micro-issues.]

I agree, the ktimers code looks clean.  I am concerned that all the 
issues be addressed, but time will shake that out.
> 
> Micro-level optimizations like 64-bit vs. 32-bit variables is the very 
> very last issue to consider - and this statement comes from me, an 
> admitted performance extremist. If the HRT code ever wants to go 
> upstream then it _must get much much cleaner_. Thomas has been doing 
> great work in this area.

Agreed, I just wish we could see it a bit earlier...
> 
> 
>>The rbtree is a high overhead tree. I suspect performance problems 
>>here. [...]
> 
> 
> Wrong. rbtrees are used for some of the most performance-critical areas 
> of the kernel: the VMA tree, the new ext3 reservations code [a 
> performance feature], access keys.
> 
> 
>>[...] If it is the right answer here, then why not use it for normal 
>>timers? [...]
> 
> 
> I'd like to remind you that the code is less than a week old.
> 
> But, i don't think we want to make the majority of normal timeouts 
> tree-based. There are in essence two fundamental time related objects in 
> the kernel: timeouts and timers. Timeouts never expire in 99% of the 
> cases - so they must be optimized for the 'fast insert+remove' code path.  
> Timers on the other hand expire in 99% of the cases, so they must be 
> optimized for the 'fast insert+expire' code path.

Timers do, but I am not so sure of sleeps.  Seems a lot of them are 
interrupted.  Still, as I said in the note to Thomas, I don't have a 
real answer here.  The hashed tree I used in HRT instead of the cascade, 
did eliminate the cascade.  The hashed tree is faster for small N and, 
by changing the hash bucket size, we can easily make N<4k or so small. 
For larger N, the rbtree or some such seems right.  As I said in the 
note to Thomas, I am NO fan of the cascade.
> 
> Also, for timers, since they are often used by time-deterministic code, 
> it does not hurt to have a fundamentally deterministic design. The 
> current upstream timer(timeout) wheel is fundamentally non-deterministic 
> with an increasing number of timers, due to the cascading design.

Interested in a hashed list.  It is rather easy to do and does NOT 
cascade.  It is an O(N/M) list for inserts, same as what there now for 
deletes and nearly the same for the run timer code.  It takes away all 
the cascade stuff so it will eliminate a all of that code.  Oh, "M" is 
the number of buckets and can easily be configured at compile time.
> 
> hence the separation of timers and timeouts. I think that this 
> distinction might as well stay for the long run.
> 
> and we'be been through a number of design variants during the past 
> couple of weeks in the -rt tree: we tried the original HRT patch, a 
> combo method with partly split HR timers, and now a completely separated 
> design. From what I've seen ktimers are the best solution so far.
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
