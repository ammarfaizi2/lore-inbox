Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130038AbRDZPj4>; Thu, 26 Apr 2001 11:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131472AbRDZPjq>; Thu, 26 Apr 2001 11:39:46 -0400
Received: from www.wen-online.de ([212.223.88.39]:22791 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130038AbRDZPje>;
	Thu, 26 Apr 2001 11:39:34 -0400
Date: Thu, 26 Apr 2001 17:38:57 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.33.0104261608460.334-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.33.0104261727470.222-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Mike Galbraith wrote:

> On Thu, 26 Apr 2001, Rik van Riel wrote:
>
> > On Thu, 26 Apr 2001, Mike Galbraith wrote:
> >
> > > 1. pagecache is becoming swapcache and must be aged before anything is
> > > done.  Meanwhile we're calling refill_inactive_scan() so fast that noone
> > > has a chance to touch a page.   Age becomes a simple counter.. I think.
> > > When you hit a big surge, swap pages are at the back of all lists, so all
> > > of your valuable cache gets reclaimed before we write even one swap page.
> >
> > Does the patch I sent to linux-mm@kvack.org last night help in
> > this ?
> >
> > I found that the way refill_inactive_scan() and swap_out() are being
> > called from the main loop in refill_inactive() aren't equal and have
> > fixed that in a way which (IMHO) also beautifies the code a bit.
> >
> > (and makes sure background aging doesn't get out of hand with a few
> > simple checks)
>
> That patch livelocked my box with only ~1000 pages on any list.
>
> I can go back and test some more if you want.

I put it back in, the livelock is 100% repeatable (10 repeats).  It's
deactivating/laundering itself to death.  :) 3mb for my 386-20/0.96.9
would have been enough to frolic (slowly) in.. this box can't live.

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 ...
37  3  0    988   1940   1912  32368   0   0    40    49  117   293  90  10   0
47  0  0   1348   1940   1320  26816   0   0    80    17  121   415  86  14   0
39  1  0   1364   1972   1076  20728   0   0   184     0  124   294  84  16   0
39  3  2   1456   1940    232  14720   0 572    67   638  159  2225  85  15   0
29 10  2   1456   1612    416   6908   0   0   252    72  235  2253  84  16   0
17 18  2   1292   1420    608   4216   0  60   340   454  279  3289  29  20  51
33  1  2   1296   1408    488   3464   0   4   317   752  295  2432  11  47  42
locked here

