Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWJPHXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWJPHXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 03:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWJPHXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 03:23:47 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:21121 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751484AbWJPHXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 03:23:46 -0400
Date: Mon, 16 Oct 2006 11:23:22 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ulrich Drepper <drepper@gmail.com>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-ID: <20061016072321.GA17735@2ka.mipt.ru>
References: <20060927150957.GA18116@2ka.mipt.ru> <a36005b50610032150x8233feqe556fd93bcb5dc73@mail.gmail.com> <20061004045527.GB32267@2ka.mipt.ru> <452363C5.1020505@redhat.com> <20061004074821.GA22688@2ka.mipt.ru> <4523ED6C.9080902@redhat.com> <20061005090214.GB1015@2ka.mipt.ru> <45251A83.9060901@redhat.com> <20061006083620.GA28009@2ka.mipt.ru> <4532B99B.9030403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4532B99B.9030403@redhat.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 16 Oct 2006 11:23:23 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2006 at 03:43:39PM -0700, Ulrich Drepper (drepper@redhat.com) wrote:
> Evgeniy Polyakov wrote:
> >In context you have cut, one updated signal mask between calls to event
> >delivery mechanism (using for example signal()), so it has exactly the
> >same price.
> 
> No, it does not.  If the signal mask is recomputed by the program for 
> each new wait call then you have a lot more work to do when the signal 
> mask is implicitly specified.

One can set number of events before the syscall and do not remove them
after syscall. It can be updated if there is need for that.
 
> >I created it just because I think that POSIX workaround to add signals
> >into the syscall parameters is not good enough.
> 
> Not good enough?  It does exactly what it is supposed to do.  What can 
> there be "not good enough"?

Not to move signals into special case of events. If poll() can not work
with them it does not mean, that they need to be specified as additional
syscall parameter, instead change poll() to work with them, which can be
easily done with kevents.
 
> >You again cut my explanation on why just pure timeout is used.
> >We start a syscall, which can block forever, so we want to limit it's
> >time, and we add special parameter to show how long this syscall should
> >run. Timeout is not about how long we should sleep (which indeed can be
> >absolute), but how long syscall should run - which is related to the 
> >time syscall started.
> 
> I know very well what a timeout is.  But the way the timeout can be 
> specified can vary.  It is often useful (as for select, poll) to specify 
> relative timeouts.
> 
> But there are equally useful uses where the timeout is needed at a 
> specific point in time.  Without a syscall interface which can have a 
> absolute timeout parameter we'd have to write as a poor approximation at 
> userlever
> 
>     clock_gettime (CLOCK_REALTIME, &ts);
>     struct timespec rel;
>     rel.tv_sec = abstmo.tv_sec - ts.tv_sec;
>     rel.tv_nsec = abstmo.tv_sec - ts.tv_nsec;
>     if (rel.tv_nsec < 0) {
>       rel.tv_nsec += 1000000000;
>       --rel.tv_sec;
>     }
>     if (rel.tv_sec < 0)
>       inttmo = -1;  // or whatever is used for return immediately
>     else
>       inttmo = rel.tv_sec * UINT64_C(1000000000) + rel.tv_nsec;
> 
>      wait(..., inttmo, ...)

Do not mix warm and soft - waiting for some period is not equal to
syscall timeout. Waiting is possible with timer kevent user (although
only relative timeout, can be changed to support both, not a big
problem).

> Not only is this much more expensive to do at userlevel, it is also 
> inadequate because calls to settimeofday() do  not cause a recomputation 
> of the timeout.
> 
> See Ingo's RT futex stuff as an example for a kernel interface which 
> does it right.

I'm quite sure that absolute timeouts are very usefull, but not as in
the case of waiting for syscall completeness. In any way, kevent can be
extended to support absolute timeouts in it's timer notifications.

> -- 
> ➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, 
> CA ❖

-- 
	Evgeniy Polyakov
