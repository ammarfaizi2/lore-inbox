Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129645AbRBESe6>; Mon, 5 Feb 2001 13:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbRBESes>; Mon, 5 Feb 2001 13:34:48 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:17135 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129645AbRBESed>; Mon, 5 Feb 2001 13:34:33 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200102051833.f15IXhv21604@webber.adilger.net>
Subject: Re: [patch] make tmpfs_statfs more user friendly
In-Reply-To: <m31ytemq7u.fsf@linux.local> from Christoph Rohland at "Feb 4, 2001
 04:37:26 pm"
To: Christoph Rohland <cr@sap.com>
Date: Mon, 5 Feb 2001 11:33:43 -0700 (MST)
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Mathias.Froehlich@gmx.net
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Rohland writes:
> The following patch make shmem_statfs report some sensible size
> estimates in the case that the user does not give a size limit.
> 
> This should make it more error prone when used as /tmp
                      ^^^^ less?

> diff -uNr 2.4.1-tmpfs/mm/shmem.c 2.4.1-tmpfs-fstat/mm/shmem.c
> --- 2.4.1-tmpfs/mm/shmem.c	Sun Feb  4 16:08:57 2001
> +++ 2.4.1-tmpfs-fstat/mm/shmem.c	Sun Feb  4 16:09:50 2001
> @@ -696,13 +696,20 @@
>  	buf->f_type = TMPFS_MAGIC;
>  	buf->f_bsize = PAGE_CACHE_SIZE;
>  	spin_lock (&sb->u.shmem_sb.stat_lock);
> -	if (sb->u.shmem_sb.max_blocks != ULONG_MAX || 
> -	    sb->u.shmem_sb.max_inodes != ULONG_MAX) {
> +	if (sb->u.shmem_sb.max_blocks == ULONG_MAX) {
> +		/*
> +		 * This is only a guestimate and not honoured.
> +		 * We need it to make some programs happy which like to
> +		 * test the free space of a file system.
> +		 */
> +		buf->f_bavail = buf->f_bfree = nr_free_pages() + nr_swap_pages + atomic_read(&buffermem_pages);

Should f_bavail be reduced by freepages.min or freepages.low?

> +		buf->f_blocks = buf->f_bfree + ULONG_MAX - sb->u.shmem_sb.free_blocks;

It's not really clear what you are trying to calculate here...  Since f_blocks
is a long, adding ULONG_MAX == subtracting 1.  Maybe it should just hold
the total amount of VM in the system, (i.e. totalram_pages)?

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
