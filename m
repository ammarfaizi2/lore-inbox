Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265533AbSKAAtb>; Thu, 31 Oct 2002 19:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265522AbSKAAtb>; Thu, 31 Oct 2002 19:49:31 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:47499 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265533AbSKAAtZ>; Thu, 31 Oct 2002 19:49:25 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 31 Oct 2002 17:01:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>, <lse-tech@lists.sourceforge.net>,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
In-Reply-To: <20021031230215.GA29671@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0210311642300.1562-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Jamie Lokier wrote:

> Davide, I think you are right.  That's why I said epoll was _nearly_ perfect :)
>
> Davide Libenzi wrote:
> > Jamie, the fact that epoll supports a limited number of "objects" was an
> > as-designed at that time. I see it quite easy to extend it to support
> > other objects. Futexes are a matter of one line of code int :
>
> Agreed - though I'd prefer if the overhead of creating a temporary fd
> for each futex were eliminated, as well as the potentially large fd
> table.  (In a threaded app, it's reasonable to have many more futexes
> than sockets, and they are created and destroyed rapidly too.  No data
> on how many of those futexes need to be registered, though).
>
> In other words, add another op to sys_futex() called FUTEX_EPOLL which
> directly registers the futex on an epoll interest list, and let epoll
> report those events as futex events.

Jamie, the futex support can be easily done with one line of code patch. I
still prefer the one-to-one mapping between futexes and files. It makes
everything easier. I don't really see futex creation/destroy as an high
frequency event that might be suitable for optimization. Usually you have
your own set of resources to be "protected" and in 95% of cases you know
those resources from the beginning.



> > Timer, as long as you access them through a file* interface ( like futexes )
> > will become trivial too. Another line should be sufficent for dnotify :
>
> Sorry (<humble/>), ignore timers.  Somehow I picked up the idea that
> epoll_wait() didn't have a timeout from some example or other, which
> was very silly of me.  I've read the patch properly now!  Of course
> epoll supports timers - a timeout is quite enough for user space.

If you want to timeout I/O operations you can easily put a timer routine
in your main event scheduler loop. But I still like the idea of timers
easily accessible through a file* interface.



> > void __inode_dir_notify(struct inode *inode, unsigned long event)
>
> Agreed.  This is looking good :)

I asked Linus what he thinks about this one-line patch.



> Someone suggested hooking into ->poll() as a less obtrusive way to
> implement epoll.  You're probably right that it's quicker to hook
> directly as you have done, although it would be great if epoll could
> somehow "fall back" to using ->poll() in the cases where epoll isn't
> directly supported by a file object.

I'm currently investigating this ... looks like an easy way to support
"alien" files :)



> I wrote quite a lot about futexes above.  That's because good futex
> support, and fallback to ->poll() would pretty much make epoll
> universal.  What do you think of these ideas?:
>
>    1. Add FUTEX_EPOLL operation to futex.c, which registers a futex
>       with an epoll interest list.  This would cause FUTEX_WAKE
>       calls on that address to generate epoll events.  Some care is
>       needed here to keep track of the exact number of events generated,
>       because some rather subtle usages of futex depend on the
>       return value from futex_wake being the _exact_ number of waiters
>       that are woken.  It would have to correspond to the exact number
>       of events counted by userspace.

I still believe that the 1:1 mapping is sufficent and with that in place (
and the one line patch to kernel/futex.c ) futex support comes nicely.



>    2. Add a check to EP_CTL_ADD which checks whether a file supports
>       epoll notifications natively.  Perhaps a file_operations hook
>       is in order here.  If it does, great.  If not, fall back to
>       a generic mechanism that uses the file's ->poll() method.  (I
>       haven't thought through for sure how plausible this is).
>       Magically, every kind of fd works, including special devices,
>       and the things that are most performance critical (sockets,
>       pipes, futexes) are tuned.  Yum!

Yes, kind of. The hook for an efficent edge triggered event notification
should be something like the socket one where you have a ->data_ready()
and ->write_space(), where the caller of these callbacks know that signals
has to be delivered on 0->1 transactions. With the poll hook you have the
drawback that the wakeup list is invoked each time data arrives and this
might generate a little bit too many events. This is no a problem since
epoll collapse them, but still collapsing do cost CPU cycles.



>    3. Eliminate send_sigio() calls - pass all events to epoll, and let
>       epoll dispatch signals where they have been registered.  In
>       combination with (2), this magically provides SIGIO support for
>       all fd types as well.

I would leave as a next cleanup operation, eventually.




- Davide





