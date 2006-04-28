Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbWD1BlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbWD1BlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 21:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWD1BiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 21:38:13 -0400
Received: from compunauta.com ([69.36.170.169]:16011 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S1030256AbWD1BiH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 21:38:07 -0400
From: Gustavo Guillermo =?utf-8?q?P=C3=A9rez?= <gustavo@compunauta.com>
Organization: www.compunauta.com
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI trow USB-STORAGE or SBP2 Debug for buggy device Kernels 2.6.X
User-Agent: KMail/1.8.2
References: <200604241029.14932.gustavo@compunauta.com> <200604251641.54084.gustavo@compunauta.com> <1146001711.3529.58.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1146001711.3529.58.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Disposition: inline
Date: Thu, 27 Apr 2006 20:38:06 -0500
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200604272038.06167.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Martes, 25 de Abril de 2006 16:48, James Bottomley escribió:
> OK ... My best guess has to be that this device accepted and completed
> the command but is still processing it on the medium, hence the return.
> Try the attached; I think it makes for these cases.  I could be
> persuaded to drop format and reconstruction in progress, because those
> can be *very* long operations.
Let me see, the patch of course does not apply, but I can figure out how to 
proceed on kernel 2.6.16.

But guess who, not Device busy as error, of course and NO BAD SECTORS With 
pktcdvd UDF.

:)

Txs, do you think this modification I can use without care on Sata o other 
devices going trow SCSI?, cause I be wonder if this could be into main kernel 
line.

Regards!!!!

> James
>
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 7b0f9a3..764a8b3 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1067,16 +1067,29 @@ void scsi_io_completion(struct scsi_cmnd
>  			break;
>  		case NOT_READY:
>  			/*
> -			 * If the device is in the process of becoming ready,
> -			 * retry.
> +			 * If the device is in the process of becoming
> +			 * ready, or has a temporary blockage, retry.
>  			 */
> -			if (sshdr.asc == 0x04 && sshdr.ascq == 0x01) {
> -				scsi_requeue_command(q, cmd);
> -				return;
> +			if (sshdr.asc == 0x04) {
> +				switch (sshdr.ascq) {
> +				case 0x01: /* becoming ready */
> +				case 0x04: /* format in progress */
> +				case 0x05: /* rebuild in progress */
> +				case 0x06: /* recalculation in progress */
> +				case 0x07: /* operation in progress */
> +				case 0x08: /* Long write in progress */
> +				case 0x09: /* self test in progress */
> +					scsi_requeue_command(q, cmd);
> +					return;
> +				default:
> +					break;
> +				}
>  			}
> -			if (!(req->flags & REQ_QUIET))
> +			if (!(req->flags & REQ_QUIET)) {
>  				scmd_printk(KERN_INFO, cmd,
> -					   "Device not ready.\n");
> +					   "Device not ready: ");
> +				scsi_print_sense_hdr("", &sshdr);
> +			}
>  			scsi_end_request(cmd, 0, this_count, 1);
>  			return;
>  		case VOLUME_OVERFLOW:

-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.compunauta.com
