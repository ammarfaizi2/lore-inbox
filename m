Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133109AbRDZFRr>; Thu, 26 Apr 2001 01:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133110AbRDZFRh>; Thu, 26 Apr 2001 01:17:37 -0400
Received: from www.wen-online.de ([212.223.88.39]:64266 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S133109AbRDZFRZ>;
	Thu, 26 Apr 2001 01:17:25 -0400
Date: Thu, 26 Apr 2001 07:16:31 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] swap-speedup-2.4.3-B3 (fwd)
In-Reply-To: <Pine.LNX.4.21.0104252352430.1101-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0104260644430.672-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Marcelo Tosatti wrote:

> On Thu, 26 Apr 2001, Mike Galbraith wrote:
>
> > > Comments?
> >
> > More of a question.  Neither Ingo's nor your patch makes any difference
> > on my UP box (128mb PIII/500) doing make -j30.
>
> Well, my patch incorporates Ingo's patch.
>
> It is now integrated into pre7, btw.
>
> >  It is taking me 11 1/2
> >  minutes to do this test (that's horrible).  Any idea why?~
>
> Not really.

(darn)

> If you have concurrent swapping activity, pre7 should improve the
> performance since all swap IO is asynchronous now. Only paths which really
> need to stop and wait for the swap data are doing it. (eg do_swap_page)

I'll grab virgin pre7 in a few.

> > (I can get it to under 9 with MUCH extremely ugly tinkering.  I've done
> > this enough to know that I _should_ be able to do 8 1/2 minutes ~easily)
>
> Which kind of changes you're doing to get better performance on this test?

Prevent cache collapse at all cost is #one.  Matching deactivation rate
to launder/reclaim.. et al.  Trying HARD to give PG_referenced a chance
to happen between aging scans [1].

	-Mike

1. pagecache is becoming swapcache and must be aged before anything is
done.  Meanwhile we're calling refill_inactive_scan() so fast that noone
has a chance to touch a page.   Age becomes a simple counter.. I think.
When you hit a big surge, swap pages are at the back of all lists, so all
of your valuable cache gets reclaimed before we write even one swap page.

