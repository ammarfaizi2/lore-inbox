Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265474AbSJaW4K>; Thu, 31 Oct 2002 17:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSJaW4K>; Thu, 31 Oct 2002 17:56:10 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:54706 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265474AbSJaW4I>;
	Thu, 31 Oct 2002 17:56:08 -0500
Date: Thu, 31 Oct 2002 23:02:15 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021031230215.GA29671@bjl1.asuk.net>
References: <20021031154112.GB27801@bjl1.asuk.net> <Pine.LNX.4.44.0210311211160.1562-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210311211160.1562-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide, I think you are right.  That's why I said epoll was _nearly_ perfect :)

Davide Libenzi wrote:
> Jamie, the fact that epoll supports a limited number of "objects" was an
> as-designed at that time. I see it quite easy to extend it to support
> other objects. Futexes are a matter of one line of code int :

Agreed - though I'd prefer if the overhead of creating a temporary fd
for each futex were eliminated, as well as the potentially large fd
table.  (In a threaded app, it's reasonable to have many more futexes
than sockets, and they are created and destroyed rapidly too.  No data
on how many of those futexes need to be registered, though).

In other words, add another op to sys_futex() called FUTEX_EPOLL which
directly registers the futex on an epoll interest list, and let epoll
report those events as futex events.

(I suspect that is quite easy too).

> Timer, as long as you access them through a file* interface ( like futexes )
> will become trivial too. Another line should be sufficent for dnotify :

Sorry (<humble/>), ignore timers.  Somehow I picked up the idea that
epoll_wait() didn't have a timeout from some example or other, which
was very silly of me.  I've read the patch properly now!  Of course
epoll supports timers - a timeout is quite enough for user space.

> void __inode_dir_notify(struct inode *inode, unsigned long event)

Agreed.  This is looking good :)

It's lucky that polling for readability on a directory is not useful
in any other way, though :)

The semantics for this are a bit confusing and inconsistent with
poll().  User gets POLL_RDNORM event which means something in the
directory has changed, not that the directory is now readable or that
poll() would return POLL_RDNORM.  It really should be a different
flag, made for the purpose.

> This is the result of a quite quick analysis, but I do not expect it to be
> much more difficult than that.

Someone suggested hooking into ->poll() as a less obtrusive way to
implement epoll.  You're probably right that it's quicker to hook
directly as you have done, although it would be great if epoll could
somehow "fall back" to using ->poll() in the cases where epoll isn't
directly supported by a file object.

I wrote quite a lot about futexes above.  That's because good futex
support, and fallback to ->poll() would pretty much make epoll
universal.  What do you think of these ideas?:

   1. Add FUTEX_EPOLL operation to futex.c, which registers a futex
      with an epoll interest list.  This would cause FUTEX_WAKE
      calls on that address to generate epoll events.  Some care is
      needed here to keep track of the exact number of events generated,
      because some rather subtle usages of futex depend on the
      return value from futex_wake being the _exact_ number of waiters
      that are woken.  It would have to correspond to the exact number
      of events counted by userspace.

   2. Add a check to EP_CTL_ADD which checks whether a file supports
      epoll notifications natively.  Perhaps a file_operations hook
      is in order here.  If it does, great.  If not, fall back to
      a generic mechanism that uses the file's ->poll() method.  (I
      haven't thought through for sure how plausible this is).
      Magically, every kind of fd works, including special devices,
      and the things that are most performance critical (sockets,
      pipes, futexes) are tuned.  Yum!

   3. Eliminate send_sigio() calls - pass all events to epoll, and let
      epoll dispatch signals where they have been registered.  In
      combination with (2), this magically provides SIGIO support for
      all fd types as well.

   4. Merge the aio and epoll event reporting functions: io_getevents
      and epoll_wait are remarkably similar, and should really be one
      function.  It would introduce binary incompatibility somewhere though.

There are a few cherries to go on top but I don't want to make this
email any longer.  Those are the essentials :)

-- Jamie

ps. Falling back to ->poll also means you can make trees of
notifications, like Alan suggested :)

pps. I much prefer epoll's use of an fd for the interest list than
aio's aio_context_t.
