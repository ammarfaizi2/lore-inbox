Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265730AbSKAUOK>; Fri, 1 Nov 2002 15:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265732AbSKAUOK>; Fri, 1 Nov 2002 15:14:10 -0500
Received: from mark.mielke.cc ([216.209.85.42]:23819 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265730AbSKAUOI>;
	Fri, 1 Nov 2002 15:14:08 -0500
Date: Fri, 1 Nov 2002 15:22:49 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Dan Kegel <dank@kegel.com>, Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021101202249.GA18304@mark.mielke.cc>
References: <Pine.LNX.4.44.0210311043380.1562-100000@blue1.dev.mcafeelabs.com> <3DC2BCF5.5010607@kegel.com> <20021101191643.GA1471@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101191643.GA1471@bjl1.asuk.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 07:16:43PM +0000, Jamie Lokier wrote:
> > Depends on the workload.  Where I work, the http client I'm writing
> > has to perform extremely well even on 1 byte files with HTTP 1.0.
> > Minimizing system calls is suprisingly important - even
> > a gettimeofday hurts.
> For this sort of thing, I would like to see an option to automatically
> set the non-blocking flag on accept().  To really squeeze the system
> calls, you could also automatically epoll-register on accept(), and
> for super bonus automatically do the accept() at event delivery time.
> But it's getting very silly at that point.

Not really... isn't accept() automatically performed ahead of time anyways,
as long as the listen queue isn't full?

Another issue for the 'unified event notification model':

    How does epoll interact with signals, specifically the race
    condition between determining the timeout that should be passed
    to epoll_wait(), and epoll_wait() itself? (see pselect() for info)
    For example: it is very regular for priority to be given to a fd
    callback before a signal callback, meaning that epoll_wait() would
    be called with timeout=0 if a received signal did not have its
    callback executed yet, or something greater, otherwise.

I would like to see at least of the following (suggestions made by
other people) in the final version:

    1) Userspace data pointer to allow more efficient userspace dispatching
       when epoll_wait() returns. (Something about scanning array structures
       for matching fd arguments rubs me the wrong way -- it shouldn't be
       necessary)

    2) Reduced requirements to issue system calls such as read() when EAGAIN
       is the expected return value. The whole 'do a quick poll() or similar
       at registration time upon request' issue - for obscure cases that would
       require complex code, or code that cannot yet be agreed upon, this
       could temporarily mark events ready at registration without checking,
       with a goal of eliminating this behaviour one type of file at a time.

Although the ability to wait on futex or timeout objects seems clever,
I'm not sure that we are at a point that we know how they would be
commonly used yet. Right now people need a poll() replacement for file
descriptors. Timeouts can be handled by manipulating the argument
to epoll_wait() and performing userspace analysis (same as poll()).

Futex objects have not (to my knowledge) yet been used in great
numbers at the same time (i.e. wait for 100 futexes to be obtained)
probably because the routines necessary to perform this operation
do not yet exist. It might be nice to fit this into epoll later, but
it doesn't need to yet.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

