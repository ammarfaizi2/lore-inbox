Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbRGLGQN>; Thu, 12 Jul 2001 02:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267441AbRGLGQD>; Thu, 12 Jul 2001 02:16:03 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:14020 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S267440AbRGLGPr>; Thu, 12 Jul 2001 02:15:47 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Date: Wed, 11 Jul 2001 22:00:44 -0700 (PDT)
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33L.0107081521510.4598-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0107112152500.2796-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this sounds similar to a problem I am attempting to duplicate in my lab
(or will be when I get back into the office on monday anyway :-)

a box that over time starts to have more and more CPU eaten up by the
system while processing the same load, lots of memory available (>100MB
free) and no swap allocated (at least as reported by top)

in my case the machine would be writing lots of log entries (via syslog)
as well as forking frequently (dozens of times/sec)

the loadave would start at <1 for a freshly booted box but would climb to
~12-14 around the time it collapsed, rebooting the box (under the same
load) would clear things up.

no swapping was involved on my machine, but is it possible that similar
effects could happen with writes/reads to unix sockets or syslog writing
to the disk? (~200MB of logs per min, logs rotated every hour)

David Lang



 On Sun, 8 Jul 2001, Rik van Riel wrote:

> Date: Sun, 8 Jul 2001 15:23:53 -0300 (BRST)
> From: Rik van Riel <riel@conectiva.com.br>
> To: Linus Torvalds <torvalds@transmeta.com>
> Cc: Mike Galbraith <mikeg@wen-online.de>,
>      Jeff Garzik <jgarzik@mandrakesoft.com>,
>      Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
> Subject: Re: VM in 2.4.7-pre hurts...
>
> On Sun, 8 Jul 2001, Linus Torvalds wrote:
> > On Sun, 8 Jul 2001, Rik van Riel wrote:
> > >
> > > ... Bingo.  You hit the infamous __wait_on_buffer / ___wait_on_page
> > > bug. I've seen this for quite a while now on our quad xeon test
> > > machine, with some kernel versions it can be reproduced in minutes,
> > > with others it won't trigger at all.
> >
> > Hmm.. That would explain why the "tar" gets stuck, but why does the whole
> > machine grind to a halt with all other processes being marked runnable?
>
> If __wait_on_buffer and ___wait_on_page get stuck, this could
> mean a page doesn't get unlocked.  When this is happening, we
> may well be running into a dozens of pages which aren't getting
> properly unlocked on IO completion.
>
> This in turn would get the rest of the system stuck in the
> pageout code path, eating CPU like crazy.
>
> regards,
>
> Rik
> --
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
>
> http://www.surriel.com/		http://distro.conectiva.com/
>
> Send all your spam to aardvark@nl.linux.org (spam digging piggy)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
