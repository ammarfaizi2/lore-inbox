Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRCWBmd>; Thu, 22 Mar 2001 20:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129143AbRCWBmY>; Thu, 22 Mar 2001 20:42:24 -0500
Received: from zeus.kernel.org ([209.10.41.242]:12739 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129051AbRCWBmE>;
	Thu, 22 Mar 2001 20:42:04 -0500
Date: Fri, 23 Mar 2001 01:39:14 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>,
        Linux FS development list <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [linux-lvm] EXT2-fs panic (device lvm(58,0)):
Message-ID: <20010323013914.M7756@redhat.com>
In-Reply-To: <200103072035.f27KZ5V20201@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200103072035.f27KZ5V20201@webber.adilger.net>; from adilger@turbolinux.com on Wed, Mar 07, 2001 at 01:35:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 07, 2001 at 01:35:05PM -0700, Andreas Dilger wrote:

> The only remote possibility is in ext2_free_blocks() if block+count
> overflows a 32-bit unsigned value.  Only 2 places call ext2_free_blocks()
> with a count != 1, and ext2_free_data() looks to be OK.  The other
> possibility is that i_prealloc_count is bogus - that is it!  Nowhere
> is i_prealloc_count initialized to zero AFAICS.
> 
Did you ever push this to Alan and/or Linus?  This looks pretty
important!

Cheers,
 Stephen

> ==========================================================================
> diff -ru linux/fs/ext2/ialloc.c.orig linux/fs/ext2/ialloc.c
> --- linux/fs/ext2/ialloc.c.orig	Fri Dec  8 18:35:54 2000
> +++ linux/fs/ext2/ialloc.c	Wed Mar  7 12:22:11 2001
> @@ -432,6 +444,8 @@
>  	inode->u.ext2_i.i_file_acl = 0;
>  	inode->u.ext2_i.i_dir_acl = 0;
>  	inode->u.ext2_i.i_dtime = 0;
> +	inode->u.ext2_i.i_prealloc_count = 0;
>  	inode->u.ext2_i.i_block_group = i;
>  	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
>  		inode->i_flags |= S_SYNC;
> diff -ru linux/fs/ext2/inode.c.orig linux/fs/ext2/inode.c
> --- linux/fs/ext2/inode.c.orig	Tue Jan 16 01:29:29 2001
> +++ linux/fs/ext2/inode.c	Wed Mar  7 12:05:47 2001
> @@ -1048,6 +1038,8 @@
>  			(((__u64)le32_to_cpu(raw_inode->i_size_high)) << 32);
> 	}
>  	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
> +	inode->u.ext2_i.i_prealloc_count = 0;
>  	inode->u.ext2_i.i_block_group = block_group;
>  
>  	/*
