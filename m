Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276215AbRJGHnL>; Sun, 7 Oct 2001 03:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276211AbRJGHnC>; Sun, 7 Oct 2001 03:43:02 -0400
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:33292 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S276215AbRJGHmo>;
	Sun, 7 Oct 2001 03:42:44 -0400
Date: Sun, 7 Oct 2001 09:43:10 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Simon Kirby <sim@netnation.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11pre4 swapping out all over the place
In-Reply-To: <Pine.LNX.4.33.0110061457570.1454-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110070906020.30872-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Oct 2001, Linus Torvalds wrote:
>
> Ok, can you try this slightly more involved patch instead? It basically
> keeps the old try_to_free_pages() (it _looks_ different, but the logic is
> the same), but also should honour the OOM-killer.

Yes, this patch also solves the problem.

I just noticed that when reading from an umounted block device, the pages
are not cached between runs, i.e. the cache is dropped on close().  If the
block device contains a mounted filesystem, the pages are not dropped.
Is this intentional?

I was also thinking about Simon's CD-burning case, and the fact that the
used-once logic really does not work very well for such cases.  You
usually first run mkisofs to create the image, and then read the image
when writing the CD.  This is similar to running

	dd if=/dev/zero of=/tmp/cd bs=1M count=300
	dd if=/tmp/cd of=/dev/null

In this case, the pages are activated.  That is not too bad, since the
system now seems to be able to free even active cache pages before paging
out stuff.  (BTW, does it always free all cache before paging out?
That would most likely be very bad for many scenarios.)

So, for the CD-burning case, a used-twice algorithm would probably perform
better.  Or perhaps the pages should be activated after having been _read_
more than once, not counting the writes.  I wish I had the time to try
this out... :-(

This should only matter if the file is smaller than the amount of
available RAM, which is not too common for CD images.

/Tobias

