Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277781AbRJIPkJ>; Tue, 9 Oct 2001 11:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277784AbRJIPkA>; Tue, 9 Oct 2001 11:40:00 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:7739 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277781AbRJIPjs>; Tue, 9 Oct 2001 11:39:48 -0400
Date: Tue, 9 Oct 2001 17:39:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
Message-ID: <20011009173937.M15943@athlon.random>
In-Reply-To: <20011009165002.H15943@athlon.random> <Pine.LNX.4.21.0110091129260.5604-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110091129260.5604-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Oct 09, 2001 at 11:34:47AM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 11:34:47AM -0200, Marcelo Tosatti wrote:
> The problem may well be in the memory balancing Andrea, but I'm not trying
> to hide it with the infinite loop.

I assumed fixing the oom faliures with highmem was the main reason of
the infinite loop.

> The infinite loop is just a guarantee that we'll have a reliable way of
> throttling the allocators which can block. Not doing the infinite loop is

Throttling have nothing to do with the infinite loop.

> just way too fragile IMO and it is _prone_ to fail in intensive
> loads. 

It is too fragile if the vm is doing the wrong actions and so we must
loop over and over again before it finally does the right thing.

If allocation fails that's a nice feedback that tell us "the memory
balancing is at least inefficient in doing the right thing, looping
would only waste more cache and more time for the allocation".

Think a list where pages can be only freeable or unfreeable.  Now scan
_all_ the pages and free all the freeable ones. Finished. If it failed
and it couldn't free anything it means there was nothing to free so
we're oom. How can that be "fragile"?

In real life it isn't as simple as that, there's some "race" effect
caming from the schedules in between, there are multiple lists, there's
swapout etc... so it's a little more complex than just "freeable" and
"unfreeable" and a single list, but it can be done, 2.2 does that too,
if we loop over and over again and we do no progress in the right
direction I prefer to know about that via an allocation faliure rather
than by just getting sucking performance. Also an allocation faliure is
a minor problem compared to a deadlock that the infinite loop cannot
prevent.

> If the problem is the highmem balancing, I'll love to get your fixes and
> integrate with the infinite loop logic, which is a separated (related,
> yes, but separate) thing.

The infinite loop shouldn't do anything except introducing the deadlock
after that (otherwise it means I failed :), but you're free to go in
your direction if you think it's the right one of course (like I'm free
to go in my direction since I think it's the right one).

Andrea
