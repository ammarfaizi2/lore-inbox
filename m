Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291836AbSBTNLx>; Wed, 20 Feb 2002 08:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291841AbSBTNLo>; Wed, 20 Feb 2002 08:11:44 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:14054 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S291836AbSBTNL2>;
	Wed, 20 Feb 2002 08:11:28 -0500
Date: Wed, 20 Feb 2002 08:11:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sb_read problem in hpfs
In-Reply-To: <143960000.1014210030@tiny>
Message-ID: <Pine.GSO.4.21.0202200809030.12139-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Feb 2002, Chris Mason wrote:

> 
> Hi guys,
> 
> hpfs_read_super triggers calls to sb_bread (through hpfs_map_sector) 
> before setting s_blocksize.  This leads to a BUG() in grow_buffers.

Fsck.  Merge problems when backporting to 2.4 - thanks for spotting.
Yes, patch is correct.  I'll look through the rest of thing and see
what else is missing.
 
> This patch was tested lightly, hpfs_read_super completes
> properly when an hpfs FS is not present.
> 
> -chris
> 
> --- suse.4/fs/hpfs/super.c Tue, 19 Feb 2002 08:55:47 -0500 
> +++ suse.4(w)/fs/hpfs/super.c Tue, 19 Feb 2002 22:28:37 -0500 
> @@ -410,6 +410,8 @@
>  	/*s->s_hpfs_mounting = 1;*/
>  	dev = s->s_dev;
>  	set_blocksize(dev, 512);
> +	s->s_blocksize = 512;
> +	s->s_blocksize_bits = 9;
>  	s->s_hpfs_fs_size = -1;
>  	if (!(bootblock = hpfs_map_sector(s, 0, &bh0, 0))) goto bail1;
>  	if (!(superblock = hpfs_map_sector(s, 16, &bh1, 1))) goto bail2;
> @@ -436,8 +438,6 @@
>  
>  	/* Fill superblock stuff */
>  	s->s_magic = HPFS_SUPER_MAGIC;
> -	s->s_blocksize = 512;
> -	s->s_blocksize_bits = 9;
>  	s->s_op = &hpfs_sops;
>  
>  	s->s_hpfs_root = superblock->root;
> 
> 

