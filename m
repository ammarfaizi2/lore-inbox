Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129278AbRBBTYw>; Fri, 2 Feb 2001 14:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbRBBTYm>; Fri, 2 Feb 2001 14:24:42 -0500
Received: from www.wen-online.de ([212.223.88.39]:17935 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129155AbRBBTYa>;
	Fri, 2 Feb 2001 14:24:30 -0500
Date: Fri, 2 Feb 2001 20:24:19 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: RAMFS
In-Reply-To: <20010202185709.A753@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.Linu.4.10.10102022022300.623-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Ingo Oeser wrote:

> No, so have to unlock it also, if you return -ENOSPC.
> 
> So the correct fix seems to be:
> 
> --- linux/fs/ramfs/inode.c~	Wed Jan 31 22:02:16 2001
> +++ linux/fs/ramfs/inode.c	Fri Feb  2 14:51:47 2001
> @@ -174,7 +174,6 @@
>  		inode->i_blocks += IBLOCKS_PER_PAGE;
>  		rsb->free_pages--;
>  		SetPageDirty(page);
> -		UnlockPage(page);
>  	} else {
>  		ClearPageUptodate(page);
>  		ret = 0;
> @@ -264,6 +263,9 @@
>  
> - 	if (! ramfs_alloc_page(inode, page))
> + 	if (! ramfs_alloc_page(inode, page)) {
> +		UnlockPage(page);
>  		return -ENOSPC;
> +	}
> +	UnlockPage(page);
>  	return 0;
>  }
> 
> This currently works for me (but using 2.4.0 + dwg-ramfs.patch + this patch)

Have you stressed it?  (I see leakiness)

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
