Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276047AbRJGRkI>; Sun, 7 Oct 2001 13:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276483AbRJGRj6>; Sun, 7 Oct 2001 13:39:58 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30728 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276047AbRJGRjp>; Sun, 7 Oct 2001 13:39:45 -0400
Date: Sun, 7 Oct 2001 10:39:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Tobias Ringstrom <tori@ringstrom.mine.nu>
cc: Simon Kirby <sim@netnation.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.11pre4 swapping out all over the place
In-Reply-To: <Pine.LNX.4.33.0110070906020.30872-100000@boris.prodako.se>
Message-ID: <Pine.LNX.4.33.0110071031160.7151-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Oct 2001, Tobias Ringstrom wrote:
>
> On Sat, 6 Oct 2001, Linus Torvalds wrote:
> >
> > Ok, can you try this slightly more involved patch instead? It basically
> > keeps the old try_to_free_pages() (it _looks_ different, but the logic is
> > the same), but also should honour the OOM-killer.
>
> Yes, this patch also solves the problem.

Good.

> I just noticed that when reading from an umounted block device, the pages
> are not cached between runs, i.e. the cache is dropped on close().  If the
> block device contains a mounted filesystem, the pages are not dropped.
> Is this intentional?

It's intentional, although something that can probably be discussed. The
reasons for it are:
 - devices with broken or unreliable disk change mechanisms
 - the current dynamic [de-]allocation of block device data structures.
 - historical coherency reasons.

None of the reasons for it are very strong - the block device data
structure one is a _current_ implementation detail that has a lot of
reasons going for it, but it's not something that is inherent in any real
major design (we could reasonably easily delay the block device data
structure release for some time).

> I was also thinking about Simon's CD-burning case, and the fact that the
> used-once logic really does not work very well for such cases.  You
> usually first run mkisofs to create the image, and then read the image
> when writing the CD.  This is similar to running
>
> 	dd if=/dev/zero of=/tmp/cd bs=1M count=300
> 	dd if=/tmp/cd of=/dev/null

Well, I actually champion not considering writes accesses _at_all_, but I
was overruled by Marcelo Tosatti. However, I bet that a good example would
change his mind - and a benchmark.

This is easy to test: remove the "SetPageReferenced(page);" from the
generic_file_write() function (note how the current code is a mix between
my "writes aren't references" and Marcelo's "writes are accesses like
reads" - it only marks a page referenced, it never actually activates it).

Are there other valid points in this discussion? I'd love to have a strong
reason for doing what we're doing (which we don't have right now).

> In this case, the pages are activated.  That is not too bad, since the
> system now seems to be able to free even active cache pages before paging
> out stuff.  (BTW, does it always free all cache before paging out?
> That would most likely be very bad for many scenarios.)

No, activating the pages only makes them slightly harder to get rid of,
they don't become "pinned".

		Linus

