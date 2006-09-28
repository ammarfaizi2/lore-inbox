Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031321AbWI1Bpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031321AbWI1Bpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWI1Bpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:45:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:3234 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965083AbWI1Bpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:45:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=sCmP3Ie/P/1EKMsGRcD0A3KFLmGqXjyO/lCjDyIi7X8QqT4ewFxzLeclA/KN30VVNlUyy+DuWhZqpEW1pR+Ryq+n6P69HSEqv4kK4U24UDr9vKvWPAwLK5n5Ih+JAccvkG0ELMy0Ud5R01La0iu2xLDoOgguElbbz3Kw1rKOFyA=
Date: Thu, 28 Sep 2006 10:45:29 +0900
From: Tejun Heo <htejun@gmail.com>
To: Eran Tromer <eran@tromer.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Mark Lord <mlord@pobox.com>
Subject: Re: [patch] libata: return sense data in HDIO_DRIVE_CMD ioctl
Message-ID: <20060928014529.GF25800@htj.dyndns.org>
References: <451AA16F.1080704@tromer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451AA16F.1080704@tromer.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Eran Tromer.

On Wed, Sep 27, 2006 at 07:06:07PM +0300, Eran Tromer wrote:
> > hdparm -C says the same thing for my drive.  I think it's safe to
> > ignore.  Hmmm... it needs to be tracked down.  Maybe some problem in
> > HDIO ioctl implementation in libata.
> 
> Yes, and fixed by this patch.

Great.  Things look good at the first glance.  Just a few comments.

> @@ -210,18 +214,46 @@ int ata_cmd_ioctl(struct scsi_device *sc
> 
>  	/* Good values for timeout and retries?  Values below
>  	   from scsi_ioctl_send_command() for default case... */
> -	if (scsi_execute_req(scsidev, scsi_cmd, data_dir, argbuf, argsize,
> -			     &sshdr, (10*HZ), 5)) {
> +	cmd_result = scsi_execute(scsidev, scsi_cmd, data_dir, argbuf, argsize,
> +	                          sensebuf, (10*HZ), 5, 0);
> +
> +	if ((cmd_result>>24) == DRIVER_SENSE) {   /* sense data available */

driver_byte() seems more appropriate.

> +		u8 *desc = sensebuf + 8;
> +		cmd_result &= ~(0xFF<<24); /* DRIVER_SENSE is not an error */
> +
> +		/* If we set cc then ATA pass-through will cause a
> +		 * check condition even if no error. Filter that. */
> +		if (cmd_result & SAM_STAT_CHECK_CONDITION) {
> +			struct scsi_sense_hdr sshdr;
> +			scsi_normalize_sense(sensebuf, SCSI_SENSE_BUFFERSIZE,
> +			                      &sshdr);
> +			if (sshdr.sense_key==0 &&
> +			    sshdr.asc==0 && sshdr.ascq==0)
> +				cmd_result &= ~SAM_STAT_CHECK_CONDITION;
> +		}
> +
> +		/* Send userspace a few ATA registers (same as drivers/ide) */
> +		if (sensebuf[0] == 0x72 &&     /* format is "descriptor" */
> +		    desc[0] == 0x09 ) {        /* code is "ATA Descriptor" */
> +			args[0] = desc[13];    /* status */
> +			args[1] = desc[3];     /* error */
> +			args[2] = desc[5];     /* sector count (0:7) */
> +			if (copy_to_user(arg, args, sizeof(args)))
> +				rc = -EFAULT;
> +		}
> +	}
> +
> +
> +	if (cmd_result) {

I wonder whether we need to fake default error ATA regsiters here.
Anyways, it's unrelated to this patch.

>  		rc = -EIO;
>  		goto error;
>  	}
> 
> -	/* Need code to retrieve data from check condition? */
> -
>  	if ((argbuf)
>  	 && copy_to_user(arg + sizeof(args), argbuf, argsize))
>  		rc = -EFAULT;
>  error:
> +	kfree(sensebuf);
>  	kfree(argbuf);
>  	return rc;

Acked-by: Tejun Heo <htejun@gmail.com>

-- 
tejun
