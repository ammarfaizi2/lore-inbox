Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292817AbSCOP3Z>; Fri, 15 Mar 2002 10:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292836AbSCOP3P>; Fri, 15 Mar 2002 10:29:15 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:27544 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292817AbSCOP26>; Fri, 15 Mar 2002 10:28:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Martin Wirth <martin.wirth@dlr.de>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: Fri, 15 Mar 2002 10:29:40 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        babt@us.ibm.com
In-Reply-To: <E16lmBj-0003v4-00@wagner.rustcorp.com.au> <3C91B3A1.7030709@dlr.de>
In-Reply-To: <3C91B3A1.7030709@dlr.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020315152845.483B73FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 March 2002 03:41 am, Martin Wirth wrote:
> Rusty Russell wrote:
> >Discussions with Ulrich have reaffirmed my opinion that pthreads are
> >crap.  Hence I'm not all that tempted to warp the (nice, clean,
> >usable) futex code too far to meet pthreads' wierd needs.
>
> Crap or not, there are tons of software based on pthreads and at least
> the NGPT team says that Linus
> agreed to implement for necessary kernel-infrastructure for a full, fast
> pthread implementation.
>
> Now, if you want to implement mutexes and condition variables with the
> attribute PTHREAD_PROCESS_SHARED then you need some functionality like the
> futexes. Or NGPT will add his own syscalls to handle these things, which is
> simply unnecessary double functionality.
>
> >However, it's not too hard to implement condition variables using an
> >unavailable mutex, if we go for "full" semaphores: ie. not just
> >mutexes.  It requires a bit more of a stretch for kernel atomic ops...
>
> A full semaphore is nice, but not a full replacement for a waitqueue (or
> a pthread condition variable brr..).
> For the semaphore you always have to assure that the ups and downs are
> balanced, what is not the case
> for the condition variable.
>
> Martin
>

Folks, its not that simple as "use futex for PTHREAD_PROCESS_SHARED".
First, you must realize that conceptually, the N kernel threads utilized in a 
M:N thread model like NGPT are virtual processors. Hence you can't simply
wait in the kernel as you would block your v-proc. Hence the current
futex interface of up and down kernel calls in not sufficient.

What is required is an asynchronous mechanism that lets a v-proc 
leave a notification object <nobj> in the kernel that get's enqueued just 
like every other waiting task. <nobj> ::= <v-proc, struct *futex>
When the futex is signaled and <nobj> is woken up, a scheduling event is send 
to the <v-proc> or its task or its process (this has to be thought through).
This can be done through a signal or through an shared event queue or a 
combination of such. 

Under no circumstances can you block the <v-proc> == task on a futex !!!

I talked with Bill Abt of the NGPT team about it and he conceptually agrees 
with this approach, but since the regular interface is still not hammered out 
and stable, no point going after more sophisticated stuff yet.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
