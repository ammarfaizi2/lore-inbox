Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSKKW4Q>; Mon, 11 Nov 2002 17:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSKKW4Q>; Mon, 11 Nov 2002 17:56:16 -0500
Received: from findaloan-online.cc ([216.209.85.42]:6411 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261573AbSKKW4O>;
	Mon, 11 Nov 2002 17:56:14 -0500
Date: Mon, 11 Nov 2002 18:08:18 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROT_SEM + FUTEX
Message-ID: <20021111230818.GA1978@mark.mielke.cc>
References: <A46BBDB345A7D5118EC90002A5072C7806CAC91C@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CAC91C@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 02:31:28PM -0800, Perez-Gonzalez, Inaky wrote:
> > As long as the person attempting to manipulate the FUTEX word succeeds
> > (i.e. 0 -> 1, or 0 -> -1, or whatever), futex_wait() need not 
> > be issued. futex_wake() only pins the page for a brief period of time.
> Define brief - remember that if the futex is locked, the page is already
> pinned, futex_wake() is just making sure it is there while it uses it - and
> again, as you said before, this is completely application specific; the
> kernel cannot count on any specific behaviour on the user side.

I am defining "brief" as the length of time that futex_wake() takes to
pin and unpin the page, which I hope is quite short as the internal
futex locks are also held during this time.

I might be doing something wrong -- but it seems to me that using inc,
dec, xchg or cmpxchg (depending on the object being implemented) is
all that is necessary for IA-32. futex_wait() should only be executed
by threads which decides that they need to wait, which on an
application with a well designed thread architecture, should not occur
frequently. I would find any application that needed to actively wait
on 4000 futex objects to be either incorrectly designed, or under
enough load that I think an investment in a few more CPU's would be
worthwhile... :-)

> > same cache line. Also, if the memory word is used to synchronize
> > access to a smaller data structure (<128 bytes), it is actually
> > optimal to include the memory word used to synchronize access to the
> > data, and the data itself, in the same cache line.
> Sure, this makes full sense; if you are using the futexes straight off from
> the kernel for synchronization; however, when used by something like NGPT's
> mutex system, the story changes, because you cannot assume anything, you
> have to be generic - and there is my bias. 
> Lucky you that don't need to worry about that :)

In this case it isn't luck -- although I am certain that NGPT, and the
other recent projects to improve the speed of threads and thread
synchronization on Linux are doing very well, I have been dabbing with
purposefully avoiding 'pthreads-like' libraries for synchronization
primitives. Originally my goal was to reduce the overhead of a
MUTEX-like object and a RWLOCK-like object to be a single word. The
increased efficiency, and reduced storage requirement for these
storage primitives would allow me to use them at more granular levels,
which reduces the potential for contention.

At some point, the need to be absolutely general and portable gets in
the way of being efficient. You seem to be trying to accomplish all
three goals (NGPT), a task that I can appreciate, but one that I
cannot envy... :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

