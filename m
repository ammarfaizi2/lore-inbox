Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRAEVDK>; Fri, 5 Jan 2001 16:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130112AbRAEVDA>; Fri, 5 Jan 2001 16:03:00 -0500
Received: from [24.65.192.120] ([24.65.192.120]:37112 "EHLO webber.adilger.net")
	by vger.kernel.org with ESMTP id <S129561AbRAEVCm>;
	Fri, 5 Jan 2001 16:02:42 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200101052102.f05L2T420212@webber.adilger.net>
Subject: Re: swapin readahead pre-patch (what about the code?)
In-Reply-To: <Pine.LNX.4.21.0101051432270.2823-100000@freak.distro.conectiva>
 "from Marcelo Tosatti at Jan 5, 2001 02:34:04 pm"
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Date: Fri, 5 Jan 2001 14:02:29 -0700 (MST)
CC: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:
> The following patch does this, and it also changes the readahead code to
> readaround. I'm not sure if readaround is better than readahead for the
> swapin case, and I'll have to test this more to make sure.

No comment on the code itself, but in general I would think that swapin
is relatively non-deterministic, unlike reading from a file which is often
sequential.  Even if a program is swapped out linearly to the swap space,
it may well be that the working set is a bunch discontiguous pages, so
readahead of any sort may be a net loss.  This is especially true with
swapin, because you need to evict another page to pre-read a swap page.

I suppose we need to find a good benchmark for a system under swap load
and test the current readahead, your new code, and no swap read-ahead at all.

I suppose the other area to look at is how pages are layed out when
they are swapped to disk.  If you go from medium memory pressure (where
unused pages have been swapped already) to thrashing, then if you can
put the remaining pages of each program to swap contiguously, then swap
read-ahead will be a net win, because you are likely to need all of them
again to run the program.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
