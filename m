Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129803AbQLZSsT>; Tue, 26 Dec 2000 13:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbQLZSsK>; Tue, 26 Dec 2000 13:48:10 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:17426 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129803AbQLZSr5>; Tue, 26 Dec 2000 13:47:57 -0500
Date: Tue, 26 Dec 2000 10:17:25 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Marco d'Itri" <md@Linux.IT>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <E14Ag3n-0000Me-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012261014080.8122-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Dec 2000, Alan Cox wrote:
>
> > The simple fix is along the lines of adding code to fsync() that walks the
> > inode page list and writes out dirty pages.
> > 
> > The clever and clean fix is to split the inode page list into two lists,
> > one for dirty and one for clean pages, and only walk the dirty list.
> 
> Like the patches that were floating around on the list for the past 
> few months to make O_SYNC work. Could those be used for it ?

I haven't seen the patches, but I suspect strongly that they clash with
the ext2 smart buffer sync code.

For example, the old generic_fdatasync() function already walks the list
of pages and could trivially be extended to handle dirty pages in addition
to just dirty blocks. But ext2 uses the faster and more clever "walk just
the dirty buffers of this inode" thing, which never even looks at any
pages.

This is high-level enough that the low-level filesystems should not even
see this functionality, and it doesn't look very hard to do. It's just all
these holidays in the way (and if you think you can skip christmas with a
4-year-old in the house, think AGAIN. This is a sacred time.).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
