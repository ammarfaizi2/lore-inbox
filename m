Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278625AbRJ1SBF>; Sun, 28 Oct 2001 13:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278629AbRJ1SAz>; Sun, 28 Oct 2001 13:00:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11529 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278625AbRJ1SAo>; Sun, 28 Oct 2001 13:00:44 -0500
Date: Sun, 28 Oct 2001 09:59:14 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Zlatko Calusic <zlatko.calusic@iskon.hr>, Jens Axboe <axboe@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <E15xu2b-0008QL-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110280945150.7360-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Oct 2001, Alan Cox wrote:
>
> > Does the -ac patches have any hpt366-specific stuff? Although I suspect
> > you're right, and that it's just the driver (or controller itself) being
>
> The IDE code matches between the two. It isnt a driver change

It might, of course, just be timing, but that sounds like a bit _too_ easy
an explanation. Even if it could easily be true.

The fact that -ac gets higher speeds, and -ac has a very different
request watermark strategy makes me suspect that that might be the cause.

In particular, the standard kernel _requires_ that in order to get good
performance you can merge many bh's onto one request. That's a very
reasonable assumption: it basically says that any high-performance driver
has to accept merging, because that in turn is required for the elevator
overhead to not grow without bounds. And if the driver doesn't accept big
requests, that driver cannot perform well because it won't have many
requests pending.

In contrast, the -ac logic says roughly "Who the hell cares if the driver
can merge requests or not, we can just give it thousands of small requests
instead, and cap the total number of _sectors_ instead of capping the
total number of requests earlier".

In my opinion, the -ac logic is really bad, but one thing it does allow is
for stupid drivers that look like high-performance drivers. Which may be
why it got implemented.

And it may be that the hpt366 IDE driver has always had this braindamage,
which the -ac code hides. Or something like this.

Does anybody know the hpt driver? Does it, for example, limit the maximum
number of sectors per merge somehow for some reason?

Jens?

		Linus

