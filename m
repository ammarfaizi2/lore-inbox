Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135477AbRECRWB>; Thu, 3 May 2001 13:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135735AbRECRVw>; Thu, 3 May 2001 13:21:52 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33553 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135477AbRECRVg>; Thu, 3 May 2001 13:21:36 -0400
Date: Thu, 3 May 2001 10:21:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: volodya@mindspring.com, Alexander Viro <viro@math.psu.edu>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <E14vFQf-0005Ej-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105031017460.30346-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 3 May 2001, Alan Cox wrote:
>
> > > discussion in itself), and there really are no valid uses for opening a
> > > block device that is already mounted. More importantly, I don't think
> > > anybody actually does.
> > 
> > Actually I did. I might do it again :) The point was to get the kernel to
> > cache certain blocks in the RAM. 
> 
> Ditto for some CD based stuff. You burn the important binaries to the front
> of the CD, then at boot dd 64Mb to /dev/null to prime the libraries and
> avoid a lot of seeking during boot up from the CD-ROM.
> 
> However I could do that from an initrd before mounting

Ehh. Doing that would be extremely stupid, and would slow down your boot
and nothing more.

The page cache is _not_ coherent with the buffer cache. Any filesystem
that uses the page cache for data caching (which pretty much all of them
do, because it's the only way to get sane mmap semantics, and it's a lot
faster than the ol dbuffer cache ever was), the above will do _nothing_
but spend time doing IO that the page cache will just end up doing again.

Currently it can help to pre-load the meta-data, but quite frankly, even
that is suspect, and won't work in 2.5.x when Al's metadata page-cache
stuff is merged (at least directories, and likely inodes too).

In short, don't do it. It doesn't work reliably (and hasn't since 2.0.x),
and it will only get more and more unreliable.

		Linus

