Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130511AbRAHRpC>; Mon, 8 Jan 2001 12:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131086AbRAHRow>; Mon, 8 Jan 2001 12:44:52 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:55537 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130511AbRAHRoe>; Mon, 8 Jan 2001 12:44:34 -0500
Date: Mon, 8 Jan 2001 15:44:11 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
In-Reply-To: <93bl8k$sb3$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101081518530.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2001, Linus Torvalds wrote:

> That doesn't resolve the "2.4.x behaves badly" thing, though.
> 
> I've seen that one myself, and it seems to be simply due to the
> fact that we're usually so good at gettign memory from
> page_launder() that we never bother to try to swap stuff out.
> And when we _do_ start swapping stuff out it just moves to the
> dirty list, and page_launder() will take care of it.
> 
> So far so good. The problem appears to be that we don't swap
> stuff out smoothly: we start doing the VM scanning, but when we
> get enough dirty pages, we'll let it be, and go back to
> page_launder() again. Which means that we don't walk theough the
> whole VM space, we just do some "spot cleaning".

You are right in that we need to refill the inactive list
before calling page_launder(), but we'll also need a few
other modifications:

1. adopt the latest FreeBSD tactic in page_launder()
	- mark dirty pages we see but don't flush
	- in the first loop, flush up to maxlaunder of the
	  already seen dirty pages
	- in the second loop, flush as many pages as we
	  need to refill the free&inactive_clean list

2. go back to having a _static_ free target, at
   max(freepages.high, SUM(zone->pages_high) ... this
   means free_shortage() will never be very big

3. keep track of how many pages we need to free in
   page_launder() and substract one from the target
   when we submit a page for IO ... no need to flush
   20MB of dirty pages when we only need 1MB pages
   cleaned

I have these things in my local tree and it seems to smooth
out the load quite well for a very large haskell run and for
the fillmem program from Juan Quintela's memtest suite.

When combined with your idea of refilling the freelist _first_,
we should be able to get the VM quite a bit smoother under loads
with lots of dirty pages.

I will work on this while travelling to and being in Australia.
Expect a clean patch to fix this problem once the 2.4 bugfix-only
period is over.

Other people on this list are invited to apply the VM patches from
my home page and give them a good beating. I want to be able to
submit a well-tested, known-good patch to Linus once 2.4 is out of
the bugfix-only period...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
