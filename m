Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTBDMtP>; Tue, 4 Feb 2003 07:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267259AbTBDMtP>; Tue, 4 Feb 2003 07:49:15 -0500
Received: from ag5.mpi-sb.mpg.de ([139.19.1.1]:12735 "EHLO
	interferon.mpi-sb.mpg.de") by vger.kernel.org with ESMTP
	id <S267256AbTBDMtN>; Tue, 4 Feb 2003 07:49:13 -0500
Date: Tue, 4 Feb 2003 13:58:33 +0100 (CET)
From: Roman Dementiev <rdementi@mpi-sb.mpg.de>
X-X-Sender: rdementi@mpiat1200
To: Andrew Morton <akpm@digeo.com>
cc: dementiev@mpi-sb.mpg.de, <linux-kernel@vger.kernel.org>
Subject: Re: buffer leakage in kernel?
In-Reply-To: <20030127125138.5dc35b1d.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302041350270.17390-100000@mpiat1200>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Jan 2003, Andrew Morton wrote:

>
> I suspect what is happening is that you've managed to find a code path in
> which the kernel is allocating lots of memory in a mode in which it cannot
> run effective page reclaim.  This would be more likely to be true if you only
> see the failures when writing.
>
> It would help if you could change mm/vmscan.c:try_to_free_pages_zone()
> thusly:
>
>         /*
>          * Hmm.. Cache shrink failed - time to kill something?
>          * Mhwahahhaha! This is the part I really like. Giggle.
>          */
> +	show_stack(0);
>         out_of_memory();
>         return 0;
>  }
>
> and pass the resulting log output through ksyoops.
>
> And here's a protopatch to teach the kernel to make sure that there's a
> decent amount of free memory before it goes and performs GFP_NOFS pagecache
> allocations:
>
> diff -puN fs/buffer.c~a fs/buffer.c
> --- 24/fs/buffer.c~a	2003-01-27 12:28:02.000000000 -0800
> +++ 24-akpm/fs/buffer.c	2003-01-27 12:28:23.000000000 -0800
> @@ -2112,6 +2112,8 @@ int generic_direct_IO(int rw, struct ino
>  	for (i = 0; i < nr_blocks; i++, blocknr++) {
>  		struct buffer_head bh;
>
> +		try_to_free_pages(GFP_KERNEL);
> +
>  		bh.b_state = 0;
>  		bh.b_dev = inode->i_dev;
>  		bh.b_size = blocksize;
>
>
> If that sheds no light, please send me the app and I'll see if I can
> reproduce it.  Thanks.
>
>

I have not yet tried that because of the lack of time. Instead I installed
2.4.21-pre4. The problem seems to be fixed there.


Roman

