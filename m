Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261371AbTBJDnD>; Sun, 9 Feb 2003 22:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbTBJDnD>; Sun, 9 Feb 2003 22:43:03 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:37251 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261371AbTBJDnC>; Sun, 9 Feb 2003 22:43:02 -0500
Date: Mon, 10 Feb 2003 01:52:35 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Nick Piggin <piggin@cyberone.com.au>
cc: Andrea Arcangeli <andrea@suse.de>, Con Kolivas <ckolivas@yahoo.com.au>,
       lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK]
 2.4.20-ck3 / aa / rmap with contest]
In-Reply-To: <3E4718D9.4030805@cyberone.com.au>
Message-ID: <Pine.LNX.4.50L.0302100143000.12742-100000@imladris.surriel.com>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com>
 <20030209144622.GB31401@dualathlon.random> <3E4718D9.4030805@cyberone.com.au>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2003, Nick Piggin wrote:
> Andrea Arcangeli wrote:
>
> >The only way to get the minimal possible latency and maximal fariness is
> >my new stochastic fair queueing idea.
>
> Sounds nice. I would like to see per process disk distribution.

Sounds like the easiest way to get that fair, indeed.  Manage
every disk as a separately scheduled resource...

> However dependant reads can not merge with each other obviously so
> you could end up say submitting 4K reads per process.

Considering that one medium/far disk seek counts for about 400 kB
of data read/write, I suspect we'll just want to merge requests or
put adjacant requests next to each other into the elevator up to
a fairly large size. Probably about 1 MB for a hard disk or a cdrom,
but much less for floppies, opticals, etc...

> But your solution also does nothing for sequential IO throughput in
> the presence of more than one submitter.

> I think you should be giving each process a timeslice,

That is the anticipatory scheduler.  A good complement to the SFQ
part of the IO scheduler.  I'd really like to see both ideas together
in one scheduler, they sound like a winning pair.

> For reads, anticipatory scheduling can be very helpful in theory
> however it remains to be seen if I can make it work without adding
> too much complexity. Your fair queueing should go nicely on top
> if I can make it work. I do like your idea though!

The anticipatory scheduler can just remain "on" while the priority
difference of the requests of the current process aren't too big
when compared to the priority of the other requests.  Once the SFQ
part of the scheduler sends down requests with a really big priority
difference the anticipatory scheduler can "skip a beat" and switch
to another process.

Note that Andrea's distinction between synchronous and asynchronous
requests may be more appropriate than the distinction between read
and write requests ...

The only remaining question is how do we know which requests are
synchronous and which are asynchronous ?   Ie. which requests have
a process waiting on their completion and which requests don't have
a process waiting on their completion ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
