Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136526AbREDVvd>; Fri, 4 May 2001 17:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136527AbREDVvP>; Fri, 4 May 2001 17:51:15 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:15116 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136526AbREDVux>; Fri, 4 May 2001 17:50:53 -0400
Date: Fri, 4 May 2001 14:50:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, <volodya@mindspring.com>,
        Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <E14vmrD-00082F-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0105041446390.1059-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 May 2001, Alan Cox wrote:
>
> iso9660 alas doesn't allow you to do that. You can speed it up by reading
> the entire file into memory rather than paging it in (or reading it in and
> then executing it). iso9660 layout is pretty constrained and designed for
> linear file reads

Note that this you can do for any filesystem, including ext2. If you
instead of trying to remember what _blocks_ the bootup process reads, you
keep the trace at a higher level, and then sort the _high_level_ trace and
re-do that with some program, then you can obviously populate the virtual
caches properly with any filesystem.

The advantage of that approach is that it will continue to work forever,
because there will  never be any cache aliasing issues. You're always
"pre-caching" using the same operation that you'll actually use when you
do the real reads..

Now, that still leaves the question on how to sort the virtual cache
accesses, and you might want to know what the low-level layout of the
filesystem is to actually create the "sort". You might not want to sort
alphabetically on the file-name, but use a "where on the disk is this
file", and use _that_ as the sort oder function.

That's easy to do, actually. Just use the "bmap()" ioctl.

Now, you won't be able to use "dd" to populate the caches: you'd have to
have your own program that walks your sorted action list and populates the
caches that way (and you might want to take kernel read-ahead etc
heuristics into account).

SMOP.

		Linus

