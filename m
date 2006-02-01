Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWBARGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWBARGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 12:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWBARGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 12:06:25 -0500
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:6382 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S932425AbWBARGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 12:06:24 -0500
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP
	slow)
From: Lee Schermerhorn <lee.schermerhorn@hp.com>
Reply-To: lee.schermerhorn@hp.com
To: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: LOSL, Nashua
Date: Wed, 01 Feb 2006 12:06:06 -0500
Message-Id: <1138813566.5211.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nick, All:

It is with some trepedation that I jump into this already looong thread...

I spent ~6 years as secretary of the Posix.4/.4a [realtime and threads]
working group where we discussed this stuff ad nauseum.  I was also
"technical reviewer" of a few chapters of the .4 drafts [Posix.1a spec].
I only bring this up to point out where my "understanding" of the
"intent" of the spec, such as it is, comes from.  A caveat:  my
involvement was with IEEE/Posix.  The Open Group has adopted the Posix
specs into the SUS and has, rightfully so, imposed additional
interpretation and requirements on it.  E.g., the SUS can require that
certain features that are optional in Posix.

There are ambiguities in the spec.  We tried to avoid these.  One reason
for some of the ambiguities is that this is the best that we could get
the various factions, corporations, ... represented in the working
groups and the balloting groups [not necessarily the same folks] to
agree upon.

The drafts went through a couple of years [maybe longer] of balloting
where folks would object to the wording based on all sorts of real and
imagined scenarios.  Still, when all is said and done, the spec says
what it says.  I've been told that any interpretation that meets the
letter of the specification [and English is notorious for it's
ambiguity, leaving the field wide open, here] is valid, intentions of
the authors notwithstanding.

Also, note that, for Posix, at least, there are 2 parts of the spec:
The main body of the spec--so called "normative" text or mandatory
requirements--and the rationale that attempts to explain some of the
background and, well, rationale.  The rationale is non-normative/non-
binding.

With that background:

[note:  the single '>' indents are from Nick.  I grabbed this from the
archive.  sorry].

>> Back to the scenario:
>> 
>>> A realtime system with tasks A and B, A has an RT scheduling priority of
>>> 1, and B is 2. A and B are both runnable, so A is running. A takes a 
>>> mutex
>>> then sleeps, B runs and ends up blocked on the mutex. A wakes up and at
>>> some point it drops the mutex and then tries to take it again.
>>>
>>> What happens?
>> 
>> 
>> As I understand the spec, A must block because B has acquired the mutex. 
>> Once again, the SUS discussion of priority inheritance would never need 
>> to have been written if this were not the case:
>> 
>>  >>>
>> In a priority-driven environment, a direct use of traditional primitives 
>> like mutexes and condition variables can lead to unbounded priority 
>> inversion, where a higher priority thread can be blocked by a lower 
>> priority thread, or set of threads, for an unbounded duration of time. 
>> As a result, it becomes impossible to guarantee thread deadlines. 
>> Priority inversion can be bounded and minimized by the use of priority 
>> inheritance protocols. This allows thread deadlines to be guaranteed 
>> even in the presence of synchronization requirements.
>> <<<
>> 
>> The very first sentence indicates that a higher priority thread can be 
>> blocked by a lower priority thread. If your interpretation of the spec 
>> were correct, then such an instance would never occur. Since your 
>
>Wrong. It will obviously occur if the lower priority process is able
>to take a lock before a higher priority process.
>
>The situation will not exist in "the scenario" though, if we follow
>my reading of the spec, because *the scheduler* determines the next
>process to gain the mutex. This makes perfect sense to me.

My copy of the Posix spec and the on-line SUSv2 say *the scheduling
policy* determines the next process/thread.  I.e, the scheduler, per se,
isn't required to get involved--the selected waiter doesn't need to run
to obtain the mutex.

The intention of the authors [again, not binding] was that for
SCHED_OTHER, all bets are off; and for RT/FIFO policies, the highest
priority, longest waiting thread would be chosen.  Think of the queue of
waiters being ordered the same way as the run queue for the policy in
effect.  Then, the selection of the next thread to get the mutex is
simply the head of the list of waiters.  Presumably the scheduling
policy determined how the waiters were queued--paying the price at wait
time, when you're going to suffer a context switch anyway.  However, one
could queue in any order at wait time and pay the price to scan the
queue at unlock time.  

Now, this harks back to Howard Chu's [I think?] discussion of
[paraphrasing] "what is the eligible set of threads from which the
system selects."  The spec is ambiguous here.

One consideration that I haven't heard discussed in this thread [and I
might have missed it] is the notion of "forward progress".  I checked my
copy and the spec seems to be silent on this topic.  Most
implementations that I've worked with work hard to guarantee forward
progress through the mutex.  Generally, I've seen this implemented by
handing off the lock to the "most eligible" thread [as determined by the
scheduling policy].  This is, in my reading of the spec and based on my
understanding of intent, a perfectly conforming implementation.  It also
avoids the "thundering herd" phenomenon.

>
>> scenario is using realtime threads, then we can assume that the Priority 
>> Ceiling feature is present and you can use it if needed. ( 
>> http://www.opengroup.org/onlinepubs/000095399/xrat/xsh_chap02.html#tag_03_02_09_06 
>> Realtime Threads option group )
>> 
>
>Any kind of priority boost / inherentance like this is orthogonal to
>the issue. They still do not prevent B from acquiring the mutex and
>thereby blocking the execution of the higher priority A. I think this
>is against the spirit of the spec, especially the part where it says
>*the scheduler* will choose which process to gain the lock.
>

I don't agree.  Priority inheritance and priority ceiling options were
provided for just this purpose.  Some of the "hard real-time" working
group members insisted on this feature to avoid the dreaded priority
inversion.  However, the non-real-time folks interested in threads for
concurrent programming, didn't need nor want the associated overhead.
Thus, the options.  If, in the absence of priority inheritance, a lower
priority thread [B] gains a mutex [e.g., because of direct hand-off at
unlock time] and a higher priority thread [A] must then wait for the
mutex, that's allowed.  [Disclaimer:  the priority inheritance and other
mutex options were added in a later version of the spec, after I ended
my involvement in the working grou.  However, they were discussed at
length in the original .4/.4a working groups and deferred to the later
update.]

The scenario that most of the real time folks [that I've talked to or
heard discuss it] worry about is when a 3rd process, C, with priority
between A and B, preempts B while it's holding the mutex.   C can run
for an unbounded time [*unbounded* priority inversion is the big
bugaboo], as long as it doesn't try to obtain the mutex, effectively
preventing B from finishing its use and allowing A to proceed.  This is
what priority inheritance is supposed to prevent.

With priority inheritance, when A attempts to take the mutex held by B,
B inherits A's priority such that any C [between A and B in priority]
can't preempt B.  When, B releases the the mutex, it's priority is
dropped [to the lower of it's native priority or the highest priority of
any waiters on any other mutexes that B or any of those aforementioned
waiters might hold, yada, yada, yada--an ugly requirement, no?  more
rationale for making it optional!] and now A, if it's the highest
priority waiter, can grab the mutex.  In a uniprocessor, it probably
doesn't matter whether we hand the mutex off directly to A or just wake
up A, let it preempt B and grab the mutex.  In an SMP, some other thread
of lower priority that A could sneak in, requiring another heavy-weight
priority inheritance transaction if we don't hand off.

So, ....

The current implementation, that apparently doesn't hand off, but
requires a waiter to run to grab the mutex is probably conforming, in a
strict sense.  But, to say that this is the intent of the spec is, IMO,
a stretch.  I suspect it violates the "Principle of Least Astonishment"
for a lot of practioners.  I know is does for me, but I've learned that
my vote doesn't count for much in any venue...

Trying to be helpful, but probably just muddying the water...,
Lee

