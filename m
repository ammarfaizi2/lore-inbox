Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbVKUDgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbVKUDgo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 22:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVKUDgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 22:36:43 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:33512 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S1750854AbVKUDgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 22:36:43 -0500
Date: Sun, 20 Nov 2005 22:36:23 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Jon Masters <jonathan@jonmasters.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jcm@jonmasters.org, torvalds@osdl.org, viro@ftp.linux.org.uk,
       hch@lst.de
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct
 ..."
In-Reply-To: <20051119034456.GA10526@apogee.jonmasters.org>
Message-ID: <Pine.LNX.4.61.0511202225480.20017@lancer.cnet.absolutedigital.net>
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
 <20051116005958.25adcd4a.akpm@osdl.org> <20051119034456.GA10526@apogee.jonmasters.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Nov 2005, Jon Masters wrote:

> On Wed, Nov 16, 2005 at 12:59:58AM -0800, Andrew Morton wrote:
> 
> > hmm, yes, when floppy_open() does its test we haven't yet gone and
> > determined the state of FD_DISK_WRITABLE.  On later opens, we have done, so
> > things work OK.
> 
> I stuck a test in for first use and had floppy_release free up policy
> too. But there are a bunch of problems in the floppy driver I've noticed
> in going through it tonight (and there's only so much of that I can take
> at 03:43 on a Saturday morning). I'll hopefully followup again.

This patch fixes it for me. If you cook up anything else I'll give it a go 
as well. Thanks Jon.

> diff -urN linux-2.6.14/drivers/block/floppy.c linux-2.6.14_new/drivers/block/floppy.c
> --- linux-2.6.14/drivers/block/floppy.c	2005-10-28 01:02:08.000000000 +0100
> +++ linux-2.6.14_new/drivers/block/floppy.c	2005-11-19 03:17:08.000000000 +0000
> @@ -1610,10 +1610,11 @@
>  			DPRINT("wp=%x\n", ST3 & 0x40);
>  		}
>  #endif
> -		if (!(ST3 & 0x40))
> +		if (!(ST3 & 0x40)) {
>  			SETF(FD_DISK_WRITABLE);
> -		else
> +		} else {
>  			CLEARF(FD_DISK_WRITABLE);
> +		}
>  	}
>  }
>  
> @@ -3677,15 +3678,19 @@
>  	int drive = (long)inode->i_bdev->bd_disk->private_data;
>  
>  	down(&open_lock);
> +
>  	if (UDRS->fd_ref < 0)
>  		UDRS->fd_ref = 0;
>  	else if (!UDRS->fd_ref--) {
>  		DPRINT("floppy_release with fd_ref == 0");
>  		UDRS->fd_ref = 0;
>  	}
> -	if (!UDRS->fd_ref)
> +	if (!UDRS->fd_ref) {
> +		opened_bdev[drive]->bd_disk->policy = 0;
>  		opened_bdev[drive] = NULL;
> +	}
>  	floppy_release_irq_and_dma();
> +
>  	up(&open_lock);
>  	return 0;
>  }
> @@ -3714,6 +3719,13 @@
>  		USETF(FD_VERIFY);
>  	}
>  
> +	/* set underlying gendisk policy to reflect device ro/rw status */
> +	if (UDRS->first_read_date && !(UTESTF(FD_DISK_WRITABLE))) {
> +		inode->i_bdev->bd_disk->policy = 1;
> +	} else {
> +		inode->i_bdev->bd_disk->policy = 0;
> +	}
> +	
>  	if (UDRS->fd_ref == -1 || (UDRS->fd_ref && (filp->f_flags & O_EXCL)))
>  		goto out2;
>  
> @@ -3788,6 +3800,7 @@
>  		if ((filp->f_mode & 2) && !(UTESTF(FD_DISK_WRITABLE)))
>  			goto out;
>  	}
> +
>  	up(&open_lock);
>  	return 0;
>  out:
> 

-- 
Phishing, pharming; n.: Ways to obtain phood. -- The Devil's Infosec Dictionary

