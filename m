Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280114AbRKVR0k>; Thu, 22 Nov 2001 12:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280126AbRKVR03>; Thu, 22 Nov 2001 12:26:29 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:9321 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280114AbRKVR0T>; Thu, 22 Nov 2001 12:26:19 -0500
Date: Thu, 22 Nov 2001 18:26:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: Re: [PATCH] block_dev.c: fsync() on close() considered harmful
Message-ID: <20011122182616.D1338@athlon.random>
In-Reply-To: <20011122143450.A28020@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011122143450.A28020@cistron.nl>; from miquels@cistron.nl on Thu, Nov 22, 2001 at 02:34:50PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2001 at 02:34:50PM +0100, Miquel van Smoorenburg wrote:
> I'm running an INN usenet news server that uses raw partitions for
> storage. I.e. it opens /dev/sda7 etc. and mmap()s [which finally
> works in 2.4, hurray]

:)

> Even though the server is keeping those devices open, when a utility
> program (sm) opens that file/device and closes() it the close() causes
> a fsync() on the device, something that is not wanted.
> 
> I applied the following patch which fixes it for me, it prevents
> the sync-after-close if it was close() calling blkdev_put()
> and we're not the last one to call blkdev_put().
> 
> That means fsync() will still be done on unmounts or when the
> last user of the device closes it, but not otherwise.
> 
> Is this correct or am I overlooking something?

it's correct, thanks.

> 
> --- linux-2.4.15-pre8/fs/block_dev.c.orig	Thu Oct 25 22:58:35 2001
> +++ linux-2.4.15-pre8/fs/block_dev.c	Wed Nov 21 13:32:16 2001
> @@ -603,7 +603,7 @@
>  
> 	down(&bdev->bd_sem);
> 	lock_kernel();
> -	if (kind == BDEV_FILE)
> +	if (kind == BDEV_FILE && bdev->bd_openers == 1)
> 		__block_fsync(bd_inode);
> 	else if (kind == BDEV_FS)
> 		fsync_no_super(rdev);
> 
> 
> Mike.
> -- 
> "Only two things are infinite, the universe and human stupidity,
>  and I'm not sure about the former" -- Albert Einstein.


Andrea
