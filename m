Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbTCMXEb>; Thu, 13 Mar 2003 18:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbTCMXEb>; Thu, 13 Mar 2003 18:04:31 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38845 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262584AbTCMXE0>;
	Thu, 13 Mar 2003 18:04:26 -0500
Subject: Re: Problem with aacraid driver in 2.5.63-bk-latest
From: Mark Haverkamp <markh@osdl.org>
To: Mike Anderson <andmike@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dougg@torque.net,
       Christoffer Hall-Frederiksen <hall@jiffies.dk>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux aacraid devel <linux-aacraid-devel@dell.com>
In-Reply-To: <20030313005046.GB14373@beaverton.ibm.com>
References: <20030228133037.GB7473@jiffies.dk>
	 <1047510381.12193.28.camel@markh1.pdx.osdl.net>
	 <1047514681.23725.35.camel@irongate.swansea.linux.org.uk>
	 <3E6FC8D6.7090005@torque.net>
	 <1047517604.23902.39.camel@irongate.swansea.linux.org.uk>
	 <20030313005046.GB14373@beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047597199.30090.373.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 13 Mar 2003 15:13:20 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 16:50, Mike Anderson wrote:
> Alan Cox [alan@lxorguk.ukuu.org.uk] wrote:
> > On Wed, 2003-03-12 at 23:55, Douglas Gilbert wrote:
> > >          /*
> > >           * Limit max queue depth on a single lun to 256 for now.  Remember,
> > >           * we allocate a struct scsi_command for each of these and keep it
> > >           * around forever.  Too deep of a depth just wastes memory.
> > >           */
> > >          if(tags > 256)
> > >                  return;
> > > ....
> > 
> > I can see the memory consideration. However the thing can really handle big
> > queues well. Possibly we should be setting the queue to 512 / somefunction(volumes)
> > though to avoid the worst case overcommit here
> 
> I agree with Doug that the previous comment is out of date and we could
> raise the value, but we also should never leave the function with the
> possibility that the queue_depth is 0.
> 
> The patch below is something Patrick and I where discussing though I
> believe he indicated that I should print out the value we where setting
> the queue_depth to. It was only compiled and not tested on any devices.
> 
> -andmike
> --
> Michael Anderson
> andmike@us.ibm.com
> 
>  scsi.c |   32 +++++++++++++++++++++++---------
>  1 files changed, 23 insertions(+), 9 deletions(-)
> 
> ------
> 
> --- 1.96/drivers/scsi/scsi.c	Fri Feb 21 13:46:58 2003
> +++ edited/drivers/scsi/scsi.c	Wed Mar 12 16:05:42 2003
> @@ -926,15 +926,28 @@
>  	/*
>  	 * refuse to set tagged depth to an unworkable size
>  	 */
> -	if(tags <= 0)
> -		return;
> +	if(tags <= 0) {
> +			printk(KERN_WARNING "(scsi%d:%d:%d:%d) "
> +				"%s, tag value to small\n"
> +				"disabled\n", SDpnt->host->host_no,
> +				SDpnt->channel, SDpnt->id, SDpnt->lun,
> +				__FUNCTION__); 
> +
> +		SDpnt->queue_depth = 1;
> +	}
>  	/*
> -	 * Limit max queue depth on a single lun to 256 for now.  Remember,
> -	 * we allocate a struct scsi_command for each of these and keep it
> -	 * around forever.  Too deep of a depth just wastes memory.
> +	 * Limit max queue depth on a single lun to 256 for now.
> +	 * Too deep of a depth just wastes memory.
>  	 */
> -	if(tags > 256)
> -		return;
> +	if(tags > 256) {
> +			printk(KERN_WARNING "(scsi%d:%d:%d:%d) "
> +				"%s, tag value to big\n"
> +				"disabled\n", SDpnt->host->host_no,
> +				SDpnt->channel, SDpnt->id, SDpnt->lun,
> +				__FUNCTION__); 
> +
> +		SDpnt->queue_depth = 256;
> +	}
>  
>  	spin_lock_irqsave(&device_request_lock, flags);
>  	SDpnt->queue_depth = tags;
> @@ -949,9 +962,10 @@
>  			break;
>  		default:
>  			printk(KERN_WARNING "(scsi%d:%d:%d:%d) "
> -				"scsi_adjust_queue_depth, bad queue type, "
> +				"%s, bad queue type, "
>  				"disabled\n", SDpnt->host->host_no,
> -				SDpnt->channel, SDpnt->id, SDpnt->lun); 
> +				SDpnt->channel, SDpnt->id, SDpnt->lun,
> +				__FUNCTION__); 
>  		case 0:
>  			SDpnt->ordered_tags = SDpnt->simple_tags = 0;
>  			SDpnt->queue_depth = tags;
> 
> 

This looks like a good idea.  This is better than a hung system and no
indication why.

Mark.

-- 
Mark Haverkamp <markh@osdl.org>

