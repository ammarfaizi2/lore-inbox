Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131167AbQLMXyY>; Wed, 13 Dec 2000 18:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132054AbQLMXyP>; Wed, 13 Dec 2000 18:54:15 -0500
Received: from laxmls02.socal.rr.com ([24.30.163.11]:30642 "EHLO
	laxmls02.socal.rr.com") by vger.kernel.org with ESMTP
	id <S131167AbQLMXyA>; Wed, 13 Dec 2000 18:54:00 -0500
From: Shane Nay <shane@agendacomputing.com>
Reply-To: shane@agendacomputing.com
Organization: Agenda Computing
To: Daniel Quinlan <quinlan@transmeta.com>
Subject: Re: cramfs filesystem patch
Date: Wed, 13 Dec 2000 12:22:37 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200012132204.OAA20616@magnesium.transmeta.com>
In-Reply-To: <200012132204.OAA20616@magnesium.transmeta.com>
MIME-Version: 1.0
Message-Id: <0012131222372I.01011@www.easysolutions.net>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

> Have you done a comparison of LZO against zlib (decompression
> speed/size vs. compression ratio)?  It uses less RAM/CPU to decompress
> at the cost of wasting storage space, but it's hard to make a decision
> without real numbers.

I can't do a test on speed because I haven't had time to get it to work in 
the kernel.  But it does take no memory during decompression.  The resulting 
size of the romdisk is increased by 5% over zlib's lightest compression.  So 
it does create a larger cramfs partition, but the lower (read none) memory 
overhead is a big plus, and decompression speed is a big plus.

> Actually, my most major concern is that LZO may not be legally
> unencumbered.  There's no mention of any patent search in the LZO
> site.  zlib has been very well researched in this regard.

Yes..., this is my major concern as well.  It's why I sort of opted not to 
pour tons more time on it when I was working on it.   (I was having a byte 
alignment problem)

> Do you want to implement more than one type of compression per cramfs
> filesystem or are the compression flags in the inode only needed to
> distinguish between uncompressed (XIP) and compressed data?  I assume
> you wouldn't use both LZO and zlib code, except perhaps for backward
> compatibility with your own products.
>
> If you're using XIP and uncompressed binaries, you may want to think
> about using romfs for them.

Yes, that's where it's being implemented right now is in romfs.  But I want 
to cross it over into cramfs to be able to support more than one type of file 
compression type..., one being zlib, the other being not compressed and 
aligned for XIP usage.

> Also regarding leaving binaries/libraries uncompressed, they tend to
> be about 50% of a small (uncompressed) filesystem in my experience.
> Is the ratio much different in the Agenda?

More like 72% :-).  But we're not planning on having all the libraries and 
executables running XIP, just a few key ones..., X, Xlibs, etc.  That's why 
integration with cramfs is sort of key, one other reason too being that we 
want their to be only one flash to put all our s/w on.  If we pull them out 
as seperate pieces, then we've got three seperate flashes for our users to 
deal with when they do a full upgrade.  (Kernel, cramfs, romfs)  We'd like to 
avoid that if possible.


> I want to be careful about increasing the size of the inode.
> Increasing it a small amount may have some benefits, but I've been
> trying really hard to avoid it.  I have been considering a version 2
> inode that would change the allocation of bits in the inode (to allow
> larger files at the expense of uid/gid space).
>
> I think it would be better to put the type of compression at the
> beginning of each data block.  zlib has flags for this sort of thing
> and there's already a header on each zlib data block in cramfs.

Hmm..., maybe.  But that's a little hacky probably..., I don't know, it seems 
like that info should go into the inode to me.  I suppose we could pull it 
out and put it in a header, or make our own version of cramfs that does less 
gids/uids and use some of those bits as flags for filetypes.  But I'd rather 
not fork things up like that.

> BTW, how many uids/gids do you need cramfs to support?  My belief is
> that 16 (or 256 at most) uids/gids is more than enough embedded system.

In the cramfs partition..., we probably only need 4 really.  The users can 
create their own accounts, etc., but they exist on another partition type 
(JFFS) which can support as many gids, uids, etc. as ext2fs.

Thanks,
Shane.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
