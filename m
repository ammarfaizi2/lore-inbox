Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932245AbWFDUxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWFDUxW (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWFDUxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:53:22 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:10504 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932245AbWFDUxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:53:22 -0400
Date: Sun, 4 Jun 2006 22:52:58 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Andrew Morton <akpm@osdl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arjan Van de Ven <arjan@infradead.org>
Subject: Re: [patch] epoll use unlocked wqueue operations ...
Message-ID: <20060604205258.GA311@w.ods.org>
References: <Pine.LNX.4.64.0606021600001.5402@alien.or.mcafeemobile.com> <20060603060438.GB30150@w.ods.org> <Pine.LNX.4.64.0606031031030.17149@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606031031030.17149@alien.or.mcafeemobile.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davide,

On Sat, Jun 03, 2006 at 10:35:52AM -0700, Davide Libenzi wrote:
> On Sat, 3 Jun 2006, Willy Tarreau wrote:
> 
> >Hi Davide,
> >
> >On Fri, Jun 02, 2006 at 04:28:25PM -0700, Davide Libenzi wrote:
> >>
> >>A few days ago Arjan signaled a lockdep red flag on epoll locks, and
> >>precisely between the epoll's device structure lock (->lock) and the 
> >>wait
> >>queue head lock (->lock). Like I explained in another email, and 
> >>directly
> >>to Arjan, this can't happen in reality because of the explicit check at
> >>eventpoll.c:592, that does not allow to drop an epoll fd inside the same
> >>epoll fd. Since lockdep is working on per-structure locks, it will never
> >>be able to know of policies enforced in other parts of the code. It was
> >>decided time ago of having the ability to drop epoll fds inside other
> >>epoll fds, that triggers a very trick wakeup operations (due to possibly
> >>reentrant callback-driven wakeups) handled by the ep_poll_safewake()
> >>function.
> >>While looking again at the code though, I noticed that all the 
> >>operations
> >>done on the epoll's main structure wait queue head (->wq) are already
> >>protected by the epoll lock (->lock), so that locked-style functions can
> >>be used to manipulate the ->wq member. This makes both a lock-acquire
> >>save, and lockdep happy.
> >>Running totalmess on my dual opteron for a while did not reveal any
> >>problem so far:
> >>
> >>http://www.xmailserver.org/totalmess.c
> >
> >Shouldn't we notice a tiny performance boost by avoiding those useless
> >locks, or do you consider they are not located in the fast path anyway ?
> 
> Well, we take a lock less but I can't say if it'll be measureable. The 
> test program above is not a performance thing though, just some code to 
> verify multiple threads doing waits on the same epoll fd.

OK, so I ported your patch to 2.4 (+epoll-lt-0.22) because I have some
code using it right there. At first, I thought I was observing measuring
errors, but after about 6 reboots, I seem to observe a consistent 6.5%
increase in the number of sessions/s on my fake web server on my dual
athlon. It jumps from 14350 hits/s with epoll-lt-0.22 alone to 15300 with
your patch. It seems much to me, but I'm sure I'm not dreaming (yet).

I'll send you (offlist) an update to 2.4-epoll-lt-0.22 which incorporates
this patch.

> - Davide

Cheers,
Willy

