Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129475AbRBBR5c>; Fri, 2 Feb 2001 12:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129699AbRBBR5X>; Fri, 2 Feb 2001 12:57:23 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:22240 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129475AbRBBR5M>; Fri, 2 Feb 2001 12:57:12 -0500
Date: Fri, 2 Feb 2001 18:57:09 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RAMFS
Message-ID: <20010202185709.A753@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <E14OiV8-0006hH-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E14OiV8-0006hH-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 02, 2001 at 03:51:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 03:51:53PM +0000, Alan Cox wrote:
> Does this fix the ramfs problem in -ac ?
> 
> --- fs/ramfs/inode.c~	Wed Jan 31 22:02:16 2001
> +++ fs/ramfs/inode.c	Fri Feb  2 14:51:47 2001
> @@ -174,7 +174,6 @@
>  		inode->i_blocks += IBLOCKS_PER_PAGE;
>  		rsb->free_pages--;
>  		SetPageDirty(page);
> -		UnlockPage(page);
>  	} else {
>  		ClearPageUptodate(page);
>  		ret = 0;
> @@ -264,6 +263,7 @@
>  
>  	if (! ramfs_alloc_page(inode, page))
>  		return -ENOSPC;
> +	UnlockPage(page);
>  	return 0;
>  }

No, so have to unlock it also, if you return -ENOSPC.

So the correct fix seems to be:

--- linux/fs/ramfs/inode.c~	Wed Jan 31 22:02:16 2001
+++ linux/fs/ramfs/inode.c	Fri Feb  2 14:51:47 2001
@@ -174,7 +174,6 @@
 		inode->i_blocks += IBLOCKS_PER_PAGE;
 		rsb->free_pages--;
 		SetPageDirty(page);
-		UnlockPage(page);
 	} else {
 		ClearPageUptodate(page);
 		ret = 0;
@@ -264,6 +263,9 @@
 
- 	if (! ramfs_alloc_page(inode, page))
+ 	if (! ramfs_alloc_page(inode, page)) {
+		UnlockPage(page);
 		return -ENOSPC;
+	}
+	UnlockPage(page);
 	return 0;
 }

This currently works for me (but using 2.4.0 + dwg-ramfs.patch + this patch)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<       come and join the fun       >>>>>>>>>>>>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
