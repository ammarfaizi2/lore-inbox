Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287204AbSASUVc>; Sat, 19 Jan 2002 15:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287244AbSASUVW>; Sat, 19 Jan 2002 15:21:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:10076 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287204AbSASUVH>; Sat, 19 Jan 2002 15:21:07 -0500
Date: Sat, 19 Jan 2002 21:21:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Ken Brownfield <brownfld@irridia.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH *] rmap VM 11c (RMAP IS A WINNER!)
Message-ID: <20020119212134.G21279@athlon.random>
In-Reply-To: <Pine.LNX.4.33L.0201171721230.32617-100000@imladris.surriel.com> <012d01c19fb7$ba1cb680$02c8a8c0@kroptech.com> <20020118182837.D31076@asooo.flowerfire.com> <02f801c1a0a7$5643a1a0$02c8a8c0@kroptech.com> <20020119185016.F21279@athlon.random> <03c501c1a118$9d0dd120$02c8a8c0@kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <03c501c1a118$9d0dd120$02c8a8c0@kroptech.com>; from akropel1@rochester.rr.com on Sat, Jan 19, 2002 at 01:39:22PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 01:39:22PM -0500, Adam Kropelin wrote:
> Andrea Arcangeli:
> > On Sat, Jan 19, 2002 at 12:08:30AM -0500, Adam Kropelin wrote:
> > > /bin/echo "10 0 0 0 500 3000 30 0 0" > /proc/sys/vm/bdflush
> >   ^
> >
> > you cannot set the underlined one to zero (way too low, insane) or to
> > left it to its default (20) in -aa, or it will be misconfigured setup
> > that can lead to anything. the rule is:
> >
> > nfract_stop_bdflush <= nfract <= nfract_sync
> 
> <snip>
> 
> > so nfract_stop_bdflush cannot be 20.
> 
> Ok, thanks for straightening me out on that. I figured there might be some
> consequence of  the additional knobs in -aa which I didn't know about.
> 
> > Furthmore you set ndirty to 0, that also is an invalid setup.
> 
> I didn't. That was one of the "additional parameters" that I left at the default
> on -aa (500, it seems). Sorry, I should have been clearer about exactly what
> settings I used on -aa; the quoted settings were for -rmap only. For reference,
> the exact command I tried on -aa was:
> 
> /bin/echo "10 500 0 0 500 3000 30 20 0" > /proc/sys/vm/bdflush
> 
> > With -aa something sane along the above lines is:
> >
> > /bin/echo "10 2000 0 0 500 3000 30 5 0" > /proc/sys/vm/bdflush
> 
> Unfortunately, those adjustments on top of 2.4.18-pre2aa2 set a new record for
> worst performance: 7:19.

then please try to decrease the nfract variable again, the above set it
to 2000, if you've a slow harddisk maybe that's too much, so you can try
to set it to 500 again.

I'd also give a try with the below settings:

	/bin/echo "10 500 0 0 500 3000 80 8 0" > /proc/sys/vm/bdflush

(500 may vary, you may try with 200 or 1000 instead etc.., but a large
ndirty_sync should allow your program to keep getting data)

> An additional datapoint: The quoted bdflush settings which make 2.4.17-rmap11c a
> winner do not do well at all on 2.4.17-rmap11a. Rik's initial reaction to the
> issue was that there was a bug and I know he made some changes in rmap11c to
> address it. The fact that 11c definitely performs better for me than 11a seems
> to support this. Perhaps this bug or a variant thereof also exists in aa?

AFIK there are no known bugs at the moment (things that can be called
bugs I mean). I cannot consider this special speed variation a bug. And
this buffer flushing thing matters only with a few function in buffer.c,
I don't see how the rmap design can make any difference to this
benchmark (if there's some true change that makes difference then it's
completly orthogonal with rmap).

I benchmarked in my hardware that writes as as fast as reads, and
personally I'm fine with the current behaviour of the async flushing for
2.4, so I don't care much about this (async flushing points are an
heuristic and so it's hard to get every single case faster than before,
that's why it's tuanable, and what you are hitting could be a
timing loopback), I basically care to find exactly what makes the
difference for you, just to be sure it's nothing serious as expected
(just different async flushing wakeup points).

Also just in case, I'd suggest to try to repeat each benchmark three
times, so we know we are not bitten by random variations in the numbers.

Andrea
