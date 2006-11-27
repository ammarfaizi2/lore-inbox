Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933257AbWK0TNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933257AbWK0TNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 14:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933268AbWK0TNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 14:13:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16073 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933257AbWK0TNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 14:13:18 -0500
Message-ID: <456B3895.9090207@redhat.com>
Date: Mon, 27 Nov 2006 11:12:21 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
References: <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <20061121095302.GA15210@2ka.mipt.ru> <45633049.2000209@redhat.com> <20061121174334.GA25518@2ka.mipt.ru> <4563FD53.7030307@redhat.com> <20061122103828.GA11480@2ka.mipt.ru> <4564CD97.20909@redhat.com> <20061123121838.GC20294@2ka.mipt.ru> <45661F50.9020007@redhat.com> <20061124105725.GD13600@2ka.mipt.ru>
In-Reply-To: <20061124105725.GD13600@2ka.mipt.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov wrote:
> It just sets hrtimer with abs time and sleeps - it can achieve the same
> goals using similar to wait_event() mechanism.

I don't follow.  Of course it is somehow possible to wait until an 
absolute deadline.  But it's not part of the parameter list and hence 
easily and _quickly_ usable.


>>> Btw, do you propose to change all users of wait_event()?
>> Which users?
> 
> Any users which use wait_event() or schedule_timeout(). Futex for
> example - it perfectly ok lives with relative timeouts provided to
> schedule_timeout() - the same (roughly saying of course) is done in kevent.

No, it does not live perfectly OK with relative timeouts.  The userlevel 
implementation is actually wrong because of this in subtle ways.  Some 
futex interfaces take absolute timeouts and they have to be interrupted 
if the realtime clock is set forward.

Also, the calls are complicated and slow because the userlevel wrapper 
has to call clock_gettime/gettimeofday before each futex syscall.  If 
the kernel would accept absolute timeouts as well we would save a 
syscall and have actually a correct implementation.


> I think I said already several times that absolute timeouts are not
> related to syscall execution process. But you seems to not hear me and
> insist.

Because you're wrong.  For your use cases it might not be but it's not 
true in general.  And your interface is preventing it from being 
implemented forever.


> Ok, I will change waiting syscalls to have 'flags' parameter and 'struct
> timespec' as timeout parameter. Special bit in flags will result in
> additional timer setup which will fire after absolute timeout and will
> wake up those who wait...

Thanks a lot.


>>> kevent signal registering is atomic with respect to other kevent
>>> syscalls: control syscalls are protected by mutex and waiting syscalls
>>> work with queue, which is protected by appropriate lock.
>> It is about atomicity wrt to the signal mask manipulation which would 
>> have to precede the kevent_wait call and the call itself (and 
>> registering a signal for kevent delivery).  This is not atomic.
> 
> If signal mask is updated from userspace it should be done through
> kevent - add/remove different kevent signals.

Indeed, this is what I've been saying and why ppoll/pselect/epoll_pwait 
take the sigset_t parameter.

Adding the signal mask to the queued events (e.g., the signal events) 
does not work.  First of all it's slow, you'd have to find and combine 
all mask at least every time a signal event is added/removed.  Then how 
do you combine them, OR or AND?  Not all threads might want/need the 
same signal mask.

These are just some of the usability problems.  The only clean and 
usable solution is really to OPTIONALLY pass in the signal mask.  Nobody 
forces anybody to use this feature.  Pass a NULL pointer and nothing 
happens, this is how the other syscalls also work.


> The whole signal mask was added by POSXI exactly for that single
> practical race in the event dispatching mechanism, which can not handle
> other types of events like signals.

No.  How should this argument make sense ?  Signals cannot be used in 
the current event handling and are therefore used for something 
completely different.  And they will have to be used like this for many 
applications (.e., thread cancellation, setuid/setgid implementation, etc).

That fact that the new event handling can handle signals is orthogonal 
(and good).  But it does not supersede the old signal use, it's 
something new.  The old uses are still valid.

BTW: there is a little design decision which has to be made: if a signal 
is registered with kevent and this signal is sent to a specific thread 
instead of the process (tkill and tgkill), what should happen?  I'm 
currently leaning toward failing the tkill/tgkill syscall if delivery of 
the signal requires posting to an event queue.


> There is major contradiction here - you say that programmers will use
> old-style signal delivery and want me to add signal mask to prevent that
> delivery, so signals would be in blocked mask,

That's one thing you can do.  You also can unblock signals.


> when I say that current kevent 
> signal delivery does not update pending signal mask, which is the same as
> putting signals into blocked mask, you say that it is not what is
> required.

First, what is "pending signal mask"?  There is one signal mask per 
thread.  And "pending" refers to thread delivery (either per-process or 
per-thread) which is not the signal mask (well, for non-RT signals it 
can be a bitmap but this still is no mask).

Second, I'm not talking about signal delivery.  Yes, sigaction allows to 
specify how the signal mask is to be changed when a signal is delivered. 
  But this is not what I'm talk about.  I'm talking about the signal 
mask used for the duration of the kevent_wait syscall, regardless of 
whether signals are waited for or delivered.



> Signal queue is replaced with kevent queue, and it is in sync with all
> other kevents.

But the signal mask is something completely different and completely 
independent from the signal queue.  There is nothing in the kevent 
interface to replace that functionality.  Nor should this be possible 
with the events; only a sigset_t parameter to kevent_wait makes sense.


> Having sigmask parameter is the same as creating kevent signal delivery.

No, no, no.  Not at all.

>> Surely you don't suggest keeping your original timer patch?
> 
> Of course not - kevent timers are more scalable than posix timers (the 
> latter uses idr, which is slower than balanced binary tree, since it
> looks like it uses similar to radix tree algo), POSIX interface is 
> much-much-much more unconvenient to use than simple add/wait.

I assume you misread the question.  You agree to drop the patch and then 
  go on listing things why you think it's better to keep them.  I don't 
think these arguments are in any way sufficient.  The interface is 
already too big and this is 100% duplicate functionality.  If there are 
performance problems with the POSIX timer implementation (and I have yet 
to see indications) it should be fixed instead of worked around.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
