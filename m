Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292764AbSCDXyU>; Mon, 4 Mar 2002 18:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293014AbSCDXyA>; Mon, 4 Mar 2002 18:54:00 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27744 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292764AbSCDXx6>; Mon, 4 Mar 2002 18:53:58 -0500
Date: Tue, 5 Mar 2002 00:52:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305005215.U20606@dualathlon.random>
In-Reply-To: <20020305000102.S20606@dualathlon.random> <Pine.LNX.4.44L.0203042007240.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203042007240.2181-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 08:11:21PM -0300, Rik van Riel wrote:
> You'll have one CPU starting to allocate from zone A, falling
> back to zone B and then further down.

what is zone A/B, I guess you mean node A/B etc.. Zones are called
NORMAL/DMA/HIGHMEM so I'm confused.

> Another CPU starts allocating at zone B, falling back to A
> and then further down.
> 
> How would you express this in classzone ?  I've looked at it

I don't see the problem you're raising. classzone is an information that
you pass the memory balancing, that tells it "what kind of ram you need".
That's all. This ensure it does the right work and that it puts the result into
the per-process local_pages structure, so the result isn't stolen before
we can notice it (fairness). That's completly unrelated to NUMA, I think
I said that many times. classzone and numa are disconnected concepts.

> As for kswapd going crazy, that is nicely fixed by having
> per zone lru lists... ;)

I don't see how per-zone lru lists are related to the kswapd deadlock.
as soon as the ZONE_DMA will be filled with filedescriptors or with
pagetables (or whatever non pageable/shrinkable kernel datastructure you
prefer) kswapd will go mad without classzone, period.

Check l-k and see how many kswapd-crazy reports there are been since
classzone is been introduced into the kernel, and incidentally we just
seen new kswapd report for the rmap patch without swap (it's hard to
trigger I know without swap, with swap such behaviour will happen
trivially because without swap every single page of anonymous ram will
become unpageable just like the kernel data, but the very same
kswapd-crazy problem would happen if swap was there too, it would only
take more time to reproduce like in the 2.4.x series with x < 10). it's
the same problem you told me at the kernel summit, remember? classzone
has the advantage of being very low cost and it also increases the
fairness of the allocations, compared to a system where you may end
working for others rather than for yourself like with the "plenty" stuff.
It not only fixes kswapd.

Andrea
