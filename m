Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266937AbRGHRNJ>; Sun, 8 Jul 2001 13:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbRGHRMt>; Sun, 8 Jul 2001 13:12:49 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:4103 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266932AbRGHRMp>; Sun, 8 Jul 2001 13:12:45 -0400
Date: Sun, 8 Jul 2001 10:11:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33L.0107071710180.1389-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107081002490.7044-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jul 2001, Rik van Riel wrote:
>
> Not quite. The more a page has been used, the higher the
> page->age will be. This means the system has a way to
> distinguish between anonymous pages which were used once
> and anonymous pages which are used lots of times.

Wrong.

We already _have_ that aging: it's called "do not add anonymous pages to
the page cache unless they are old".

Pages that are used lots of time won't ever _get_ to the point where they
get added to the swap cache, because they are always marked young.

So by the time we get to this point, we _know_ what the age should be. I
tried to explain this to you earlier. We should NOT use the old
"page->age", because that one is 100% and totally bogus. It has _nothing_
to do with the page age. It's ben randomly incremented, without ever
having been on any of the aging lists, and as such it is a totally bogus
number.

In comparison, just setting page->age to PAGE_AGE_START is _not_ a random
number. It's a reasonable number that depends on the _knowledge_ that

 (a) _had_ the page been on any of the aging lists, it would have been
     aged down every time we passed it, and
 (b) it's obviously been aged up every time we passed it in the VM so far
     (because it hadn't been added to the swap cache earlier).

Are you with me?

Now, add to the above two _facts_, the knowledge that the aging of the VM
space is done roughly at the same rate as the aging of the active lists
(we call "swap_out()" every time we age the active list when under memory
pressure, and they go through similar percentages of their respective
address spaces), and you get

 - an anonymous page, by the time we add it to the swap cache, would have
   been aged down and up roughly the same number of times.

Ergo, it's age _should_ be the same as PAGE_AGE_START.

> > That would certainly help explain why aging doesn't work for some people.
>
> As would your patch ;)

No. Do the math. My patch gives the age the _right_ age. Previously, it
had a completely random age that had _nothing_ to do with any other page
age.

		Linus

