Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264438AbRFOQWH>; Fri, 15 Jun 2001 12:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264446AbRFOQV5>; Fri, 15 Jun 2001 12:21:57 -0400
Received: from www.wen-online.de ([212.223.88.39]:34053 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264438AbRFOQVu>;
	Fri, 15 Jun 2001 12:21:50 -0400
Date: Fri, 15 Jun 2001 18:21:13 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFT][PATCH] even out background aging
In-Reply-To: <Pine.LNX.4.33.0106151211360.2262-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106151800130.312-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2001, Rik van Riel wrote:

> [Request For Testers:  please test this on your system...]
>
> Hi,
>
> the following patch makes use of the fact that refill_inactive()
> now calls swap_out() before calling refill_inactive_scan() and
> the fact that the inactive_dirty list is now reclaimed in a fair
> LRU order.
>
> Background scanning can now be replaced by a simple call to
> refill_inactive(), instead of the refill_inactive_scan(), which
> gave mapped pages an unfair advantage over unmapped ones.

Hi Rik,

While I was testing this suggestion (still actually) prior to your
RFT, the first thing I did was the straight substitution, but under
heavy load, the additional swap/aging when there is a ~persistant
shortage hurt ~fairly badly.  What I did instead, and shows no ill
effects under any load I've tried so far was...

		/* If needed, try to free some memory. */
		if (inactive_shortage() || free_shortage())
			do_try_to_free_pages(GFP_KSWAPD, 0);
		else {
			/* Do background page aging. */
			swap_out(DEF_PRIORITY, GFP_KSWAPD);
			refill_inactive_scan(DEF_PRIORITY, 0);
		}

I still had the benefit of idle pages being pushed to disk quickly
and staying there :)  IMHO, this is the first real candidate for a
sysctl tunable, as it's possibly not good for everyone.  As indicated
privately, I like the effect of this suggestion a lot, but laptop
people may not because of the infrequent and miniscule swapin (which
_might_ be an irritant _if_ they are doing enough work etc etc).

	-Mike

(this report would have landed in your mailbox tomorrow.. I was too
slow.  sending it to lkml lest someone sees the same high load thing
I did and determine it's a loss unfairly)

