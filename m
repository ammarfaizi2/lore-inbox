Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVHSTJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVHSTJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 15:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbVHSTJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 15:09:56 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:39690 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965051AbVHSTJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 15:09:55 -0400
Date: Fri, 19 Aug 2005 15:06:27 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jon Escombe <lists@dresco.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [patch] libata passthrough - return register data from HDIO_* commands
Message-ID: <20050819190625.GB2736@tuxdriver.com>
Mail-Followup-To: Jon Escombe <lists@dresco.co.uk>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	jgarzik@pobox.com
References: <42FE2FBA.3000605@dresco.co.uk> <430112F6.3090906@dresco.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <430112F6.3090906@dresco.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 11:11:02PM +0100, Jon Escombe wrote:
> 
> >Here is a first attempt at a patch to return register data from the 
> >libata passthrough HDIO ioctl handlers, I needed this as the ATA 
> >'unload immediate' command returns the success in the lbal register. 

> Haven't had any feedback on the patch itself - but this now does what I 
> wanted it do to.  (I can't find a way to make Thunderbird retain tabs in 
> the message body, so sending as an attachment).

Grumble...this is why patches as attachments suck...grumble...manually
copied the patch below...

Overall, I like the patch.  I trust your assertion that it actually
works... :-)

I have a few comments...

> --- a/drivers/scsi/libata-scsi.c
> +++ b/drivers/scsi/libata-scsi.c

<snip>

> @@ -100,6 +101,9 @@
>  	if (!sreq)
>  		return -EINTR;
>  
> +	sb = sreq->sr_sense_buffer;
> +	desc = sb + 8;
> +
>  	memset(scsi_cmd, 0, sizeof(scsi_cmd));
>  
>  	if (args[3]) {

Can we move this hunk closer to where desc is actually used?  It seems
like that would be easier to read.  I'd put those new lines just
before the "Retrieve data from check condition" comment.

<snip>

> @@ -135,16 +139,24 @@
>  	   from scsi_ioctl_send_command() for default case... */
>  	scsi_wait_req(sreq, scsi_cmd, argbuf, argsize, (10*HZ), 5);
>  
> -	if (sreq->sr_result) {
> +	if (!sreq->sr_result == ((DRIVER_SENSE << 24) + SAM_STAT_CHECK_CONDITION)) {
>  		rc = -EIO;
>  		goto error;
>  	}
 
scsi_debug.c has a definition like this:

static const int check_condition_result =
                (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;

Perhaps we could add something like that to the top of libata-scsi.c,
(or some appropriate header file?) changing the if to read as:

@@ -135,16 +139,24 @@
 	   from scsi_ioctl_send_command() for default case... */
 	scsi_wait_req(sreq, scsi_cmd, argbuf, argsize, (10*HZ), 5);
 
-	if (sreq->sr_result) {
+	if (sreq->sr_result != check_condition_result) {
 		rc = -EIO;
 		goto error;
 	}

> -	/* Need code to retrieve data from check condition? */
> +	/* Retrieve data from check condition */
> +	args[1] = desc[3];
> +	args[2] = desc[5];
> +	args[3] = desc[7];
> +	args[4] = desc[9];
> +	args[5] = desc[11];
> +	args[0] = desc[13];
>  
>  	if ((argbuf)
>  	 && copy_to_user((void *)(arg + sizeof(args)), argbuf, argsize))
>  		rc = -EFAULT;
> +	if (copy_to_user(arg, args, sizeof(args)))
> +		rc = -EFAULT;
 
It seems more natural to put these lines _before_ the "if ((argbuf)"
line.  It's probably more likely to be nice to the cache that way
as well.

> @@ -195,18 +208,29 @@
>  		goto error;
>  	}
>  
> +	sb = sreq->sr_sense_buffer;
> +	desc = sb + 8;
> +

Same comment as above about moving these closer to the "Retrieve data
from check condition" comment.

>  	   from scsi_ioctl_send_command() for default case... */
>  	scsi_wait_req(sreq, scsi_cmd, NULL, 0, (10*HZ), 5);
>  
> -	if (sreq->sr_result) {
> +	if (!sreq->sr_result == ((DRIVER_SENSE << 24) + SAM_STAT_CHECK_CONDITION)) {
>  		rc = -EIO;
>  		goto error;
>  	}
 
Same comment as before regarding check_condition_result static
const int.

I'd be happy to ACK the patch with the changes outlined above.

Thanks!

John
-- 
John W. Linville
linville@tuxdriver.com
