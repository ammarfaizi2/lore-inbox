Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264482AbRFITCx>; Sat, 9 Jun 2001 15:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264481AbRFITCn>; Sat, 9 Jun 2001 15:02:43 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:35087 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264480AbRFITCi>; Sat, 9 Jun 2001 15:02:38 -0400
Date: Sat, 9 Jun 2001 12:01:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org, Dawson Engler <engler@csl.Stanford.EDU>
Subject: Re: [CHECKER] a couple potential deadlocks in 2.4.5-ac8
In-Reply-To: <Pine.GSO.4.21.0106091341440.19361-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0106091148380.26187-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Jun 2001, Alexander Viro wrote:
> 
> Another difference from spinlocks is that BKL is recursive. I'm
> actually surprised that it didn't show up first.

Good point. Spinlocks (with the exception of read-read locks, of course)
and semaphores will deadlock on recursive use, while the BKL has this
"process usage counter" recursion protection.

I'm not THAT suprised that it didn't show up first - I suspect we are
getting close to the point where we could actually start to remove it. The
big kernel lock is not used that much any more, and there aren't that many
things that are recursively invoced any more. 

The big reason for having a recursive lock for the BKL was because things
like page faults had to nest with other users of the BKL, but since the VM
should be pretty much entirely BKL-free the only real remaining part is
probably small parts of the low-level filesystems (notably things like
"readpage()" calling down to the get_block() functions).

And I suspect that the current checker doesn't realize that any user mode
access is equivalent to calling "do_page_fault()" from a call-chain
standpoint.

Dawson - the user-mode access part is probably _the_ most interesting from
a lock checking standpoint, could you check doing the page fault case?

Anyway, in a 2.5.x timeframe we should probably make sure that we do not
have the need for a recursive BKL any more. That shouldn't be that hard to
fix, especially with help from CHECKER to verify that we didn't forget
some case.

(Even if we were to not need the recursiveness of the BKL, I doubt it
would mean that we'd change the implementation. The "release BKL on
schedule" semantic still means that we'd have to maintain one bit of
"counter", and then we might as well do the full thing. But considering
recursion to be a bug would probably make it easier to continue the
removal of the BKL).

			Linus

