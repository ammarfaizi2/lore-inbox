Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVCUC4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVCUC4N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 21:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVCUC4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 21:56:13 -0500
Received: from mail.shareable.org ([81.29.64.88]:35476 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261477AbVCUC4J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 21:56:09 -0500
Date: Mon, 21 Mar 2005 02:55:45 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jakub Jelinek <jakub@redhat.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, ahu@ds9a.nl, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>, Scott Snyder <snyder@fnal.gov>
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20050321025545.GB15198@mail.shareable.org>
References: <20041115020148.GA17979@mail.shareable.org> <41981D4D.9030505@jp.fujitsu.com> <20041115132218.GB25502@mail.shareable.org> <20041117084703.GL10340@devserv.devel.redhat.com> <20041118072058.GA19965@mail.shareable.org> <20041118194726.GX10340@devserv.devel.redhat.com> <20050317102619.GA23494@devserv.devel.redhat.com> <20050317152031.GB16743@mail.shareable.org> <20050317155539.GF853@devserv.devel.redhat.com> <20050318170005.GA27077@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318170005.GA27077@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> * Jakub Jelinek <jakub@redhat.com> wrote:
> 
> > The futex man pages that have been around for years (certainly since
> > mid 2002) certainly don't document FUTEX_WAIT as token passing
> > operation, but as atomic operation:
> > 
> > Say http://www.icewalkers.com/Linux/ManPages/futex-2.html
> 
> besides this documented-behavior argument, i dont think futexes should
> be degraded into waitqueues

I give in...

Depending on atomicity makes it impossible for an application, which
is linked with NPTL and Glibc, to write an NPTL-compatible "wait on
two locks" function.

I'm not saying that's a very clean thing to want, but it's a
conceptual loss and I'm disappointed I seem to be the only one
noticing it.

On the other hand, I was mistaken to think it makes it impossible to
write an emulation of synchronous futex() in terms of asynchronous
futex().* In fact it makes it impossible to do so using the existing
FUTEX_FD, but it would be possible if there were a FUTEX_FD2 added
somewhere down the line.

* - The reason you would do this is if you were writing userspace-threading
    for any reason, and you had to include an emulation of synchronous
    futex() in terms of async futex because there are some libraries
    which might run on top of the userspace-threading which use futex
    in an application-dependent way.

> - in fact, to solve some of the known
> performance problems the opposite will have to happen: e.g. i believe
> that in the future we'll need to enable the kernel-side futex code to
> actually modify the futex variable. I.e. atomicity of the read in
> FUTEX_WAIT is an absolute must, and is only the first step.

Some of those performance problems can be solved already by better use
of FUTEX_REQUEUE instead of FUTEX_WAKE.

> [ the double-context-switch problem in cond_signal() that Jamie
>   mentioned is precisely one such case: pthread semantics force us that
>   the wakeup of the wakee _must_ happen while still holding the internal
>   lock. So we cannot just delay the wakeup to outside the glibc critical
>   section. This double context-switch could be avoided if the 'release
>   internal lock and wake up wakee' operation could be done atomically
>   within the kernel. (A sane default 'userspace unlock' operation on a
>   machine word could be defined .. e.g. decrement-to-zero.) ]

Did you not see the solution I gave last November, using FUTEX_REQUEUE?

See:

    http://lkml.org/lkml/2004/11/29/201

I spent a _lot_ of time figuring it out but everyone was too busy to
confirm that it worked.  It would improve performance in a number of cases.

I hope that it does not get ignored yet again.

There _may_ be cases where more complex futex operations are needed,
but we should try the better algorithms that use the existing futex
operations before adding new ones.

-- Jamie
