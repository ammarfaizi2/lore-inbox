Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbUKDAQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbUKDAQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 19:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUKDAMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 19:12:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:2720 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261997AbUKDAKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 19:10:41 -0500
Date: Wed, 3 Nov 2004 16:10:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] avoid semi-infinite loop when mounting bad ext2
In-Reply-To: <20041103232744.GA10325@apps.cwi.nl>
Message-ID: <Pine.LNX.4.58.0411031608380.2187@ppc970.osdl.org>
References: <20041103232744.GA10325@apps.cwi.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Nov 2004, Andries Brouwer wrote:
> 
> [no doubt a similar patch is appropriate for ext3]

ext3 is different here, and uses the old-style buffer cache rather than
page cache. It has the equivalent case for a hole and/or IO error, and 
like ext2, it just continues with the next block.

I _think_ that case should be updated to do the same thing you did for 
ext2, but I'll leave it up to Andrew, since he is the ext3 master anyway.

Andrew?

		Linus

> diff -uprN -X /linux/dontdiff a/fs/ext2/dir.c b/fs/ext2/dir.c
> --- a/fs/ext2/dir.c	2004-10-30 21:44:02.000000000 +0200
> +++ b/fs/ext2/dir.c	2004-11-04 00:14:14.000000000 +0100
> @@ -275,7 +275,8 @@ ext2_readdir (struct file * filp, void *
>  				   "bad page in #%lu",
>  				   inode->i_ino);
>  			filp->f_pos += PAGE_CACHE_SIZE - offset;
> -			continue;
> +			ret = -EIO;
> +			goto done;
>  		}
>  		kaddr = page_address(page);
>  		if (need_revalidate) {
> 
