Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUBFOyO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 09:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbUBFOyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 09:54:14 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:41952 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S265477AbUBFOyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 09:54:11 -0500
Date: Fri, 6 Feb 2004 15:54:07 +0100 (MET)
From: Mattias Wadenstein <maswan@acc.umu.se>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Performance issue with 2.6 md raid0
In-Reply-To: <16418.64825.5919.694924@notabene.cse.unsw.edu.au>
Message-ID: <Pine.A41.4.58.0402061535260.28218@lenin.acc.umu.se>
References: <Pine.A41.4.58.0402051304410.28218@lenin.acc.umu.se>
 <402263E7.6010903@cyberone.com.au> <Pine.A41.4.58.0402051647460.28218@lenin.acc.umu.se>
 <4022F94C.30605@cyberone.com.au> <16418.64825.5919.694924@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, Neil Brown wrote:

> On Friday February 6, piggin@cyberone.com.au wrote:
> > Mattias Wadenstein wrote:
> > >On Fri, 6 Feb 2004, Nick Piggin wrote:
> > >>Mattias Wadenstein wrote:
> > >>>
> > >>>While testing a file server to store a couple of TB in resonably large
> > >>>files (>1G), I noticed an odd performance behaviour with the md raid0 in a
> > >>>pristine 2.6.2 kernel as compared to a 2.4.24 kernel.
> > >>>
> > >>>When striping two md raid5:s, instead of going from about 160-200MB/s for
> > >>>a single raid5 to 300M/s for the raid0 in 2.4.24, the 2.6.2 kernel gave
> > >>>135M/s in single stream read performance.
> > >>>
> > >>Can you try booting with elevator=deadline please?
> > >
> > >Ok, then I get 253267 kB/s write and 153187 kB/s read from the raid0. A
> > >bit better, but still nowhere near the 2.4.24 numbers.
> > >
> > >For a single raid5, 158028 kB/s write and 162944 kB/s read.
> >
> > Any idea what is holding back performance? Is it IO or CPU bound?

The CPU usage is not significant for the lower numbers (<30%) and seems
linear to the delivered bandwidth for the faster configurations (up to
80% or so when approaching 250M/s write and 360M/s read).

> > Can you get a profile of each kernel while doing a read please?
>
> Possibly the read-ahead size isn't getting set correctly.
>
> What chunksize are you using on the raid0?

I was only using 32k, but when I tried changing this to 4 megs I got no
improvement, leading me to guess that this wasn't it. Unfortunately I
changed it to "4M", something which mkraid happily accepted but
interpreted as "4k".

I didn't verify this against /proc/mdstat then, just noticed this now.

> Are you free to rebuild the raid0 array?

Yeah, the raid5s too if needed, but those take a while to resync before
benchmarking.

> If so, please rebuild it with a chunksize that is 2 or 4 times the
> size of a raid5 stripe (i.e. raid5-chunksize * (raid5-drives - 1) ).

Yes, this is much better. I have a 64k raid5 chunksize. A chunksize of
4096k gives 265313kB/s write and 368228kB/s for a single stream, 512k
chunksize also gives decent performance (slightly better read and rewrite
performance, somewhat lower read performance).

I'll continue tweaking and testing some, please respond (and Cc: me) if
you want to know anything more or if I should try something special.

/Mattias Wadenstein
