Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263195AbREWSMo>; Wed, 23 May 2001 14:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263198AbREWSMe>; Wed, 23 May 2001 14:12:34 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44040 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263195AbREWSMT>; Wed, 23 May 2001 14:12:19 -0400
Date: Wed, 23 May 2001 11:12:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: DVD blockdevice buffers
In-Reply-To: <20010523183419.I27177@redhat.com>
Message-ID: <Pine.LNX.4.21.0105231104200.6320-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 23 May 2001, Stephen C. Tweedie wrote:
> 
> Right.  I'd like to see buffered IO able to work well --- apart from
> the VM issues, it's the easiest way to allow the application to take
> advantage of readahead.  However, there's one sticking point we
> encountered, which is applications which write to block devices in
> units smaller than a page.  Small block writes get magically
> transformed into read/modify/write cycles if you shift the block
> devices into the page cache.

No, you can actually do all the "prepare_write()"/"commit_write()" stuff
that the filesystems already do. And you can do it a lot _better_ than the
current buffer-cache-based approach. Done right, you can actually do all
IO in page-sized chunks, BUT fall down on sector-sized things for the
cases where you want to. 

This is exactly the same issue that filesystems had with writers of less
than a page - and the page cache interfaces allow for byte-granular writes
(as actually shown by things like NFS, which do exactly that. For a block
device, the granularity obviously tends to be at least 512 bytes).

> Of course, we could just say "then don't do that" and be done with it
> --- after all, we already have this behaviour when writing to regular
> files.

No, we really don't. When you write an aligned 1kB block to a 1kB ext2
filesystem, it will _not_ do a page-sized read-modify-write. It will just
create the proper 1kB buffers, and mark one of the dirty.

Now, admittedly it is _easier_ to just always consider things 4kB in
size. And faster too, for the common cases. So it might not be worth it to
do the extra work unless somebody can show a good reason for it.

		Linus

