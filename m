Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268996AbRIDUnL>; Tue, 4 Sep 2001 16:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRIDUnB>; Tue, 4 Sep 2001 16:43:01 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:41106 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S268996AbRIDUmz>; Tue, 4 Sep 2001 16:42:55 -0400
Date: Tue, 4 Sep 2001 16:43:07 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010904164306.A1387@cs.cmu.edu>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010904112629.A27988@cs.cmu.edu> <Pine.LNX.4.33L.0109041320271.7626-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109041320271.7626-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 01:27:50PM -0300, Rik van Riel wrote:
> I've been working on a CPU and memory efficient reverse
> mapping patch for Linux, one which will allow us to do
> a bunch of optimisations for later on (infrastructure)
> and has as its short-term benefit the potential for
> better page aging.
> 
> It seems the balancing FreeBSD does (up aging +3, down
> aging -1, inactive list in LRU order as extra stage) is
> working nicely on my laptop now, but I don't think I'll
> be releasing that as part of the patch ...
> 
> 	http://www.surriel.com/patches/2.4/2.4.8-ac12-pmap3

I like the fact that it completely removes the vm crawling swap_out
path. It also does aging more sanely because it now can take everything
into account. It also works around the problems of anonymous pages that
aren't aged until they are added to the swap cache.

It should also minimize unnecessary minor page faults because the
unmapping is done for all pte's once the page->age hits zero, and
frequently used pages should not grabbing and lock down swapspace that
they won't be able to give up (until the process exits).

The pte_chain allocation stuff looks a bit scary, where did you want to
reclaim them from when memory runs out, unmap existing pte's?

One thing that might be nice, and showed a lot of promise here is to
either age down by subtracting instead of dividing to make it less
aggressive. It is already hard enough for pages to get referenced enough
to move up the scale.

Or use a similar approach as I have in my patch, age up periodically,
but only age down when there is memory shortage, This gives a slight
advantage to processes that were running when there was not much VM
pressure. When something starts hogging memory, it is penalized a bit
for disturbing the peace, but the agressive down aging will quickly
rebalance, typically within about 3 calls to do_try_to_free_pages.

I might port your patch over to Linus's 2.4.10-pre tree to play with it.
It could very well be a significant improvement because it does address
many of the issues that I ran into.

Jan

