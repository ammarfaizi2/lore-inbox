Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129878AbRB0XCZ>; Tue, 27 Feb 2001 18:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129886AbRB0XCP>; Tue, 27 Feb 2001 18:02:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:27154 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129878AbRB0XB6>; Tue, 27 Feb 2001 18:01:58 -0500
Date: Tue, 27 Feb 2001 18:15:48 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0102272050280.1114-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0102271808340.6958-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Feb 2001, Mike Galbraith wrote:

> On Tue, 27 Feb 2001, Rik van Riel wrote:
> 
> > On Tue, 27 Feb 2001, Mike Galbraith wrote:
> >
> > > Attempting to avoid doing I/O has been harmful to throughput here
> > > ever since the queueing/elevator woes were fixed. Ever since then,
> > > tossing attempts at avoidance has improved throughput markedly.
> > >
> > > IMHO, any patch which claims to improve throughput via code deletion
> > > should be worth a little eyeball time.. and maybe even a test run ;-)
> > >
> > > Comments welcome.
> >
> > Before even thinking about testing this thing, I'd like to
> > see some (detailed?) explanation from you why exactly you
> > think the changes in this patch are good and how + why they
> > work.
> 
> Ok.. quite reasonable ;-)
> 
> First and foremost:  What does refill_inactive_scan do?  It places
> work to do on a list.. and nothing more.  It frees no memory in and
> of itself.. none (but we count it as freed.. that's important). It
> is the amount of memory we want desperately to free in the immediate
> future.  We count on it getting freed.  The only way to free I/O bound
> memory is to do the I/O.. as fast as the I/O subsystem can sync it.
> 
> This is the nut.. scan/deactivate percentages are fairly meaningless
> unless we do something about these pages.
> 
> What the patch does is simply to push I/O as fast as we can.. we're
> by definition I/O bound and _can't_ defer it under any circumstance,
> for in this direction lies constipation.  The only thing in the world
> which will make it better is pushing I/O.

In your I/O bound case, yes. But not in all cases.

> If you test the patch, you'll notice one very important thing.  The
> system no longer over-reacts.. as badly.  That's a diagnostic point.
> (On my system under my favorite page turnover rate load, I see my box
> drowning in a pool of dirty pages.. which it's not allowed to drain)
> 
> What we do right now (as kswapd) is scan a tiny portion of the active
> page list, and then push an arbitrary amount of swap because we can't
> possibly deactivate enough pages if our shortage is larger than the
> search area (nr_active_pages >> 6).. repeat until give-up time.  In
> practice here (test load, but still..), that leads to pushing soon
> to be unneeded [supposition!] pages into swap a full 3/4 of the time.

Have you tried to use SWAP_SHIFT as 4 instead of 5 on a stock 2.4.2-ac5 to
see if the system still swaps out too much?

