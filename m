Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272313AbRHXULb>; Fri, 24 Aug 2001 16:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272311AbRHXULV>; Fri, 24 Aug 2001 16:11:21 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:31249 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272315AbRHXULO>; Fri, 24 Aug 2001 16:11:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>,
        Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Fri, 24 Aug 2001 22:18:00 +0200
X-Mailer: KMail [version 1.3.1]
Cc: "Marc A. Lehmann" <pcg@goof.com>, <linux-kernel@vger.kernel.org>,
        <oesi@plan9.de>
In-Reply-To: <Pine.LNX.4.33L.0108241433130.31410-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108241433130.31410-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010824201125Z16096-32383+1213@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 24, 2001 07:43 pm, Rik van Riel wrote:
> On Fri, 24 Aug 2001, Roger Larsson wrote:
> 
> > I earlier questioned this too...
> > And I found out that read ahead was too short for modern disks.
> > This is a patch I did it does also enable the profiling, the only needed
> > line is the
> > -#define MAX_READAHEAD  31
> > +#define MAX_READAHEAD  511
> > I have not tried to push it further up since this resulted in virtually
> > equal total throughput for read two files than for read one.
> 
> Note that this can have HORRIBLE effects if the total
> size of all the readahead windows combined doesn't fit
> in your memory.
> 
> If you have 100 IO streams going on and you have space
> for 50 of them, you'll find yourself with 100 threads
> continuously pushing each other's read-ahead data out
> of RAM.
> 
> 100 threads may sound much, but 100 clients really isn't
> that special for an ftp server...
> 
> This effect is made a lot worse with the use-once
> strategy used in recent Linus kernels because:
> 
> 1) under memory pressure, the inactive_dirty list is
>    only as large as 1 second of pageout IO, meaning
		      ^^^^^^^^
This is the problem.  In the absense of competition and truly active pages, 
the inactive queue should just grow until it is much larger than the active 
ring.  Then the replacement policy will naturally become fifo, which is 
exactly what you want in your example.

Anyway, this is a theoretical problem, we haven't seen it in the wild yet, or 
a test load that demonstrates it.

>    the sum of the readahead windows is smaller than
>    with a kernel which doesn't do the use-once thing
>    (eg. Alan's kernel)
> 
> 2) the drop-behind strategy makes it much more likely
>    that we'll replace the data we already used, instead
>    of the read-ahead data we haven't used yet ... this
>    means the data we are about to use has a better chance
>    to be in memory

--
Daniel
