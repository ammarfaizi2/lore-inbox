Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265449AbSKABzd>; Thu, 31 Oct 2002 20:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265451AbSKABzc>; Thu, 31 Oct 2002 20:55:32 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:36531 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S265449AbSKABz2>;
	Thu, 31 Oct 2002 20:55:28 -0500
Date: Fri, 1 Nov 2002 02:01:19 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
Message-ID: <20021101020119.GC30865@bjl1.asuk.net>
References: <20021031230215.GA29671@bjl1.asuk.net> <Pine.LNX.4.44.0210311642300.1562-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210311642300.1562-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> Jamie, the futex support can be easily done with one line of code patch. I
> still prefer the one-to-one mapping between futexes and files. It makes
> everything easier.

I do agree it is very simple and hence good.

> I don't really see futex creation/destroy as an high frequency event
> that might be suitable for optimization. Usually you have your own
> set of resources to be "protected" and in 95% of cases you know
> those resources from the beginning.

Well, I'll disagree but stay mostly quiet.  I think it is reasonable
to have a futex per _object_ in certain language run-times.
Allocation rate: 10,000,000 per second in some examples (f.e. certain
kinds of threaded simulator).

Hardly any of those will need associated fds, and I have no figures on
how many or how often, but you can see that futexes are sometimes used
in a very dynamic way because they are so cheap until contention.

That's the cool thing about futexes: there's absolutely zero kernel
overhead until contention, and only one "long" of overhead in user
space.

At contention, two syscalls resolves it synchronously: futex_wait,
futex_wake.  The async method using an fd with epoll takes five:
futex_fd, epoll_ctl, poll, futex_wake, futex_close.  That works, but
lacks the _cool_ factor that futexes have IMHO.  It should be:
futex_wait_async, futex_wake.

I realise my argument is a weak one though :)

> > > Timer, as long as you access them through a file* interface ( like futexes )
> > > will become trivial too. Another line should be sufficent for dnotify :
> >
> > Sorry (<humble/>), ignore timers.  Somehow I picked up the idea that
> > epoll_wait() didn't have a timeout from some example or other, which
> > was very silly of me.  I've read the patch properly now!  Of course
> > epoll supports timers - a timeout is quite enough for user space.
> 
> If you want to timeout I/O operations you can easily put a timer routine
> in your main event scheduler loop. But I still like the idea of timers
> easily accessible through a file* interface.

Sure, but using file * interface implies entering the kernel - that
can sometimes be skipped* if your timer queue is in user space.

* - it happens under heavy load, conveniently.

> > > void __inode_dir_notify(struct inode *inode, unsigned long event)
> >
> > Agreed.  This is looking good :)
> 
> I asked Linus what he thinks about this one-line patch.

I have no objections to it.  Generally, I'd like epoll to be able to
report _what_ the event was (not just POLL_RDNORM, but what kind of
dnotify event), but as I don't get to run on an ideal kernel [;)] I'll
be happy with POLL_RDNORM.

> I still believe that the 1:1 mapping is sufficent and with that in place (
> and the one line patch to kernel/futex.c ) futex support comes nicely.

It does work - actually, with ->poll() you don't need any lines in futex.c :)

Even if a specialised futex hook is added someday, the fd support will
continue to be useful.

> >    2. Add a check to EP_CTL_ADD which checks whether a file supports
> >       epoll notifications natively.  Perhaps a file_operations hook
> >       is in order here.  If it does, great.  If not, fall back to
> >       a generic mechanism that uses the file's ->poll() method.  (I
> >       haven't thought through for sure how plausible this is).
> >       Magically, every kind of fd works, including special devices,
> >       and the things that are most performance critical (sockets,
> >       pipes, futexes) are tuned.  Yum!
> 
> Yes, kind of. The hook for an efficent edge triggered event notification
> should be something like the socket one where you have a ->data_ready()
> and ->write_space(), where the caller of these callbacks know that signals
> has to be delivered on 0->1 transactions. With the poll hook you have the
> drawback that the wakeup list is invoked each time data arrives and this
> might generate a little bit too many events. This is no a problem since
> epoll collapse them, but still collapsing do cost CPU cycles.

You avoid the extra CPU cycles like this:

    1. EP_CTL_ADD adds the listener to the file's wait queue using
       ->poll(), and gets a free test of the object readiness [;)]

    2. When the transition happens, the wakeup will call your function,
       epoll_wakeup_function.  That removes the listener from the file's
       wait queue.  Note, you won't see any more wakeups from that file.

    3. When you report the event user space, _then_ you automatically
       add the listener back to the file's wait queue by calling ->poll().

This way, there are no spurious wakeups, and nothing to collapse.  I
would not be surprised if this is quite fast - perhaps as fast as the
special epoll hooks.

The nice feature that makes this possible is that waitqueues don't
wake up tasks any more: they simply call your choice of callback
function.  It was changed for aio, and it's a good change.

-- Jamie
