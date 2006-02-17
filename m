Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030638AbWBQPBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030638AbWBQPBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030640AbWBQPBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:01:10 -0500
Received: from lucidpixels.com ([66.45.37.187]:9858 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030638AbWBQPBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:01:08 -0500
Date: Fri, 17 Feb 2006 10:00:54 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <lkml@rtr.ca>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <200602170959.40286.lkml@rtr.ca>
Message-ID: <Pine.LNX.4.64.0602171000180.22450@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca>
 <43F58D29.3040608@pobox.com> <200602170959.40286.lkml@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have patched the kernel and rebooted it with your patch, but, of course, 
with my luck it has not given me any errors since, even when repeating 
major file copies, bonnie++ and iozone!! :(


On Fri, 17 Feb 2006, Mark Lord wrote:

> On Friday 17 February 2006 03:45, Jeff Garzik wrote:
>> Submit a patch...
>
> You mean, something like this one?
> Untested at present, as I was hoping to hear
> back from one of the original problem reporters
> after they tested it.
>
> Cheers!
>
>
>
> -------- Original Message --------
> Subject: Re: LibPATA code issues / 2.6.15.4
> Date: Tue, 14 Feb 2006 13:00:36 -0500
> From: Mark Lord <lkml@rtr.ca>
> To: Justin Piszcz <jpiszcz@lucidpixels.com>
> CC: David Greaves <david@dgreaves.com>,	Jeff Garzik <jgarzik@pobox.com>,
> linux-kernel@vger.kernel.org,	IDE/ATA development list
> <linux-ide@vger.kernel.org>
> References: <Pine.LNX.4.64.0602140439580.3567@p34>
> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34>
>
> On Tuesday 14 February 2006 12:12, Justin Piszcz wrote:
>> I would like to try the patch too, if available.
>
> Something like this:  (for 2.6.16-rc3-git2, but should be okay on 2.6.15
> also).
>
> Untested:  include the original SCSI opcode in printk's for libata SCSI
> errors,
> to help understand where the errors are coming from.
>
> Signed-Off-By:  Mark Lord <mlord@pobox.com>
>
> --- linux/drivers/scsi/libata-scsi.c.orig	2006-02-12 19:27:25.000000000 -0500
> +++ linux/drivers/scsi/libata-scsi.c	2006-02-14 12:54:17.000000000 -0500
> @@ -420,6 +420,7 @@
>  *	@sk: the sense key we'll fill out
>  *	@asc: the additional sense code we'll fill out
>  *	@ascq: the additional sense code qualifier we'll fill out
> + *	@opcode: the original SCSI command opcode byte
>  *
>  *	Converts an ATA error into a SCSI error.  Fill out pointers to
>  *	SK, ASC, and ASCQ bytes for later use in fixed or descriptor
> @@ -429,7 +430,7 @@
>  *	spin_lock_irqsave(host_set lock)
>  */
> void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk, u8
> *asc,
> -			u8 *ascq)
> +			u8 *ascq, u8 opcode)
> {
> 	int i;
>
> @@ -508,8 +509,8 @@
> 		}
> 	}
> 	/* No error?  Undecoded? */
> -	printk(KERN_WARNING "ata%u: no sense translation for status: 0x%02x\n",
> -	       id, drv_stat);
> +	printk(KERN_WARNING "ata%u: no sense translation for op=0x%02x status:
> 0x%02x\n",
> +	       id, opcode, drv_stat);
>
> 	/* For our last chance pick, use medium read error because
> 	 * it's much more common than an ATA drive telling you a write
> @@ -520,8 +521,8 @@
> 	*ascq = 0x04; /*  "auto-reallocation failed" */
>
>  translate_done:
> -	printk(KERN_ERR "ata%u: translated ATA stat/err 0x%02x/%02x to "
> -	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, drv_stat, drv_err,
> +	printk(KERN_ERR "ata%u: translated op=0x%02x ATA stat/err 0x%02x/%02x to "
> +	       "SCSI SK/ASC/ASCQ 0x%x/%02x/%02x\n", id, opcode, drv_stat, drv_err,
> 	       *sk, *asc, *ascq);
> 	return;
> }
> @@ -562,7 +563,7 @@
> 	 */
> 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
> -				   &sb[1], &sb[2], &sb[3]);
> +				   &sb[1], &sb[2], &sb[3], cmd->cmnd[0]);
> 		sb[1] &= 0x0f;
> 	}
>
> @@ -637,7 +638,7 @@
> 	 */
> 	if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
> 		ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
> -				   &sb[2], &sb[12], &sb[13]);
> +				   &sb[2], &sb[12], &sb[13], cmd->cmnd[0]);
> 		sb[2] &= 0x0f;
> 	}
>
> -
>
