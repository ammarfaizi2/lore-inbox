Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVKVHbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVKVHbz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 02:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVKVHbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 02:31:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47022 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932192AbVKVHbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 02:31:53 -0500
Date: Mon, 21 Nov 2005 23:31:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jon Masters <jonathan@jonmasters.org>
Cc: cp@absolutedigital.net, linux-kernel@vger.kernel.org, jcm@jonmasters.org,
       torvalds@osdl.org, viro@ftp.linux.org.uk, hch@lst.de
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct
 ..."
Message-Id: <20051121233131.793f0d04.akpm@osdl.org>
In-Reply-To: <20051119034456.GA10526@apogee.jonmasters.org>
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
	<20051116005958.25adcd4a.akpm@osdl.org>
	<20051119034456.GA10526@apogee.jonmasters.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Masters <jonathan@jonmasters.org> wrote:
>
>  -	if (!UDRS->fd_ref)
>  +	if (!UDRS->fd_ref) {
>  +		opened_bdev[drive]->bd_disk->policy = 0;
>   		opened_bdev[drive] = NULL;
>  +	}
>   	floppy_release_irq_and_dma();
>  +
>   	up(&open_lock);
>   	return 0;
>   }
>  @@ -3714,6 +3719,13 @@
>   		USETF(FD_VERIFY);
>   	}
>   
>  +	/* set underlying gendisk policy to reflect device ro/rw status */
>  +	if (UDRS->first_read_date && !(UTESTF(FD_DISK_WRITABLE))) {
>  +		inode->i_bdev->bd_disk->policy = 1;
>  +	} else {
>  +		inode->i_bdev->bd_disk->policy = 0;
>  +	}
>  +	

That still does the wrong thing.  Put in a write-protected floppy, try to
write to it and it says -EROFS.  Then pop the WP switch and try to write to
it again and it wrongly claims EPERM.  A second attempt to write will
succeed.

