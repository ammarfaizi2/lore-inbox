Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287381AbRL3L25>; Sun, 30 Dec 2001 06:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287383AbRL3L2r>; Sun, 30 Dec 2001 06:28:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2059 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287381AbRL3L2i>;
	Sun, 30 Dec 2001 06:28:38 -0500
Date: Sun, 30 Dec 2001 12:27:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Greg KH <greg@kroah.com>, mdharm-usb@one-eyed-alien.net,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: "sr: unaligned transfer" in 2.5.2-pre1
Message-ID: <20011230122756.L1821@suse.de>
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com> <m23d1trr4w.fsf@pengo.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m23d1trr4w.fsf@pengo.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 30 2001, Peter Osterlund wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Sun, Dec 23, 2001 at 06:44:43PM +0100, Peter Osterlund wrote:
> > > 
> > > So, what changes are needed to make CD support work?
> > 
> > The usb-storage driver needs some changes to get it to work properly in
> > the 2.5.1 kernel due to the changes in the SCSI and bio layer.  I've
> > gotten a few other reports of problems, so you aren't alone :)
> > 
> > As for when the changes will be done, any volunteers?
> 
> This patch seems to work for me. I hope it is correct. The ide-scsi
> driver is basically doing the same thing already.
> 
> --- linux-2.5-packet/drivers/usb/storage/scsiglue.c.old	Sun Dec 30 02:10:01 2001
> +++ linux-2.5-packet/drivers/usb/storage/scsiglue.c	Sun Dec 30 02:09:05 2001
> @@ -145,9 +145,19 @@
>  static int queuecommand( Scsi_Cmnd *srb , void (*done)(Scsi_Cmnd *))
>  {
>  	struct us_data *us = (struct us_data *)srb->host->hostdata[0];
> +	struct scatterlist *sg;
> +	int i;
>  
>  	US_DEBUGP("queuecommand() called\n");
>  	srb->host_scribble = (unsigned char *)us;
> +
> +	/* Set up address field in the scatterlist. HighMem pages have
> +	 * already been bounced at this point. */
> +	sg = (struct scatterlist *) srb->request_buffer;
> +	for (i = 0; i < srb->use_sg; i++) {
> +		BUG_ON(PageHighMem(sg[i].page));
> +		sg[i].address = page_address(sg[i].page) + sg[i].offset;
> +	}
>  
>  	/* get exclusive access to the structures we want */
>  	down(&(us->queue_exclusion));

That's not right, you shouldn't be using .address at all.

-- 
Jens Axboe

