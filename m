Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWG1KOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWG1KOD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbWG1KOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:14:03 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:44404 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932610AbWG1KOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:14:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=BiALsN1pUni2GF4g0KQFLUSCKdaDP6P/cfjgb37Z5fE/8hwh7C9z7QTWMk8KukH/n7a6vKSqj2vGbyUugf0H42voovlpgd+7UHwfoCG00hosWO/drOn5hQ2h3C200vwGnask16TRb/u0bPJCuhqcXIbX2lVpnIZTmdms6hovWIo=
Date: Fri, 28 Jul 2006 12:14:18 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Bill Huey <billh@gnuppy.monkey.org>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       linux-kernel@vger.kernel.org, compudj@krystal.dyndns.org,
       rostedt@goodmis.org, tglx@linutronix.de, mingo@elte.hu,
       dipankar@in.ibm.com, rusty@au1.ibm.com
Subject: Re: [RFC, PATCH -rt] NMI-safe mb- and atomic-free RT RCU
In-Reply-To: <20060728045619.GE1288@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0607281154410.10047@localhost.localdomain>
References: <20060726001733.GA1953@us.ibm.com>
 <Pine.LNX.4.64.0607262202560.15681@localhost.localdomain>
 <20060727013943.GE4338@us.ibm.com> <Pine.LNX.4.64.0607270946030.10276@localhost.localdomain>
 <20060727154637.GA1288@us.ibm.com> <20060727195355.GA2887@gnuppy.monkey.org>
 <20060728000231.GB1288@us.ibm.com> <20060728004857.GA5096@gnuppy.monkey.org>
 <20060728045619.GE1288@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jul 2006, Paul E. McKenney wrote:

> On Thu, Jul 27, 2006 at 05:48:57PM -0700, Bill Huey wrote:
>> On Thu, Jul 27, 2006 at 05:02:31PM -0700, Paul E. McKenney wrote:
>>> On Thu, Jul 27, 2006 at 12:53:56PM -0700, Bill Huey wrote:
>>>> On Thu, Jul 27, 2006 at 08:46:37AM -0700, Paul E. McKenney wrote:
>>>>> A possible elaboration would be to keep a linked list of tasks preempted
>>>>> in their RCU read-side critical sections so that they can be further
>>>>> boosted to the highest possible priority (numerical value of zero,
>>>>> not sure what the proper symbol is) if the grace period takes too many
>>>>> jiffies to complete.  Another piece is priority boosting when blocking
>>>>> on a mutex from within an RCU read-side critical section.
>>>>
>>>> I'm not sure how folks feel about putting something like that in the
>>>> scheduler path since it's such a specialized cases. Some of the scheduler
>>>> folks might come out against this.
>>>
>>> They might well.  And the resulting discussion might reveal a better
>>> way.  Or it might well turn out that the simple approach of boosting
>>> to an intermediate level without the list will suffice.
>>
>> Another thing. What you mention above is really just having a set of owners
>> for the read side and not really a preemption list tracking thing with RCU
>> and special scheduler path. The more RCU does this kind of thing the more
>> it's just like a traditional read/write lock but with more parallelism since
>> it's holding on to read side owners on a per CPU basis.
>
> There are certainly some similarities between a priority-boosted RCU
> read-side critical section and a priority-boosted read-side rwlock.
> In theory, the crucial difference is that as long as one has sufficient
> memory, one can delay priority-boosting the RCU read-side critical
> sections without hurting update-side latency (aside from the grace period
> delays, of course).
>
> So I will no doubt be regretting my long-standing advice to use
> synchronize_rcu() over call_rcu().  Sooner or later someone will care
> deeply about the grace-period latency.  In fact, I already got some
> questions about that at this past OLS.  ;-)

Yick!! Do people really expect these things to finish in a predictable 
amount of time?
This reminds me of C++ hackers starting to code Java. They want to use the 
finalizer to close files etc. just as they use the destructor in C++, but 
can't understand that they have to wait until the garbage collector has 
run.
RCU is a primitive kind of garbage collector. You should never depend on 
how long it is about doing it's work, just that it will get done at some 
point.

Esben

>
>> This was close to the idea I had for extending read/write locks to be more
>> parallel friendly for live CPUs, per CPU owner bins on individual cache lines
>> (I'll clarify if somebody asks), but the use of read/write locks is seldom
>> and in non-critical places, so just moving the code fully to RCU would be a
>> better solution. The biggest problem is to scan or denote to some central
>> structure (task struct, lock struct) when you were either in or out of the
>> reader section without costly atomic operations. That's a really huge cost
>> as you know already (OLS slides).
>
> Yep -- create something sort of like brlock, permitting limited read-side
> parallelism, and also permitting the current exclusive-lock priority
> inheritance to operate naturally.
>
> Easy enough to do with per-CPU variables if warranted.  Although the
> write-side lock-acquisition latency can get a bit ugly, since you have
> to acquire N locks.
>
> I expect that we all (myself included) have a bit of learning left to
> work out the optimal locking strategy so as to provide both realtime
> latency and performance/scalability.  ;-)
>
> 							Thanx, Paul
>
