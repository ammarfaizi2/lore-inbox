Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286274AbRLJOl1>; Mon, 10 Dec 2001 09:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286275AbRLJOlQ>; Mon, 10 Dec 2001 09:41:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:40785 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S286274AbRLJOlJ>; Mon, 10 Dec 2001 09:41:09 -0500
Date: Mon, 10 Dec 2001 15:40:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: GOTO Masanori <gotom@debian.org>
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] direct IO breaks root filesystem
Message-ID: <20011210154057.J4801@athlon.random>
In-Reply-To: <w534rmzendn.wl@megaela.fe.dis.titech.ac.jp> <Pine.LNX.4.33.0112092154060.13692-100000@penguin.transmeta.com> <w53d71n1c6g.wl@megaela.fe.dis.titech.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <w53d71n1c6g.wl@megaela.fe.dis.titech.ac.jp>; from gotom@debian.org on Mon, Dec 10, 2001 at 09:39:51PM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 09:39:51PM +0900, GOTO Masanori wrote:
> At Sun, 9 Dec 2001 21:55:57 -0800 (PST),
> Linus Torvalds <torvalds@transmeta.com> wrote:
> > On Mon, 10 Dec 2001, GOTO Masanori wrote:
> > >
> > > The reason is that when kernel accesses /dev/sda with O_DIRECT,
> > > blkdev_direct_IO() is called. But, it calls generic_direct_IO(),
> > > and generic_direct_IO() calls brw_kiovec(..., inode->i_dev, ...).
> > 
> > That's a bad bug, yes.
> 
> Yes, dangerous bug...

at least it's not security related :)

> 
> > However, the bug is really in "generic_direct_IO()", and you should fix it
> > there, instead of avoiding to use it altogether.
> > 
> > "generic_direct_IO()" should just get the device from "bh->b_dev (which is
> > filled in correctly by "get_block()".
> 
> Oh, that's right, the patch becomes more simple (and works well).
> Is this patch OK?

yes it is.

Thanks and sorry for your troubles. BTW, if you read back my first post
about the blkdev-pagecache you'll notice I got bitten by the same bug
too and I had to reinstall the test-machine from scratch :). 2.4.10
didn't had such bug, but after integrating the direct-io with the blkdev
inode physical address space the bug seen the light again. I should have
fixed the below way since the first place, at that time there were two
functions anyways and so it was less obvious the below was the right fix
(previously I just did a one liner to fix it (s/dev/rdev/)).

> --- linux.vanilla/fs/buffer.c	Mon Dec 10 21:13:10 2001
> +++ linux/fs/buffer.c	Mon Dec 10 20:59:34 2001
> @@ -2003,12 +2003,12 @@
>  {
>  	int i, nr_blocks, retval;
>  	unsigned long * blocks = iobuf->blocks;
> +	struct buffer_head bh;
>  
> +	bh.b_dev = inode->i_dev;
>  	nr_blocks = iobuf->length / blocksize;
>  	/* build the blocklist */
>  	for (i = 0; i < nr_blocks; i++, blocknr++) {
> -		struct buffer_head bh;
> -
>  		bh.b_state = 0;
>  		bh.b_dev = inode->i_dev;
>  		bh.b_size = blocksize;
> @@ -2034,7 +2034,7 @@
>  		blocks[i] = bh.b_blocknr;
>  	}
>  
> -	retval = brw_kiovec(rw, 1, &iobuf, inode->i_dev, iobuf->blocks, blocksize);
> +	retval = brw_kiovec(rw, 1, &iobuf, bh.b_dev, iobuf->blocks, blocksize);
>  
>   out:
>  	return retval;
> 
> 
> -- gotom


Andrea
