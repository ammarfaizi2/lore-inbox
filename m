Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262543AbVBBS6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbVBBS6W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbVBBS4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:56:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45000 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262553AbVBBSvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:51:24 -0500
Date: Wed, 2 Feb 2005 19:51:22 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, andyw@pobox.com,
       jgarzik@pobox.com
Subject: Re: [patch libata-dev-2.6 1/1] libata: sync SMART ioctls with ATA pass thru spec (T10/04-262r7)
Message-ID: <20050202185121.GX11484@suse.de>
References: <20050202183753.GB17450@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202183753.GB17450@tuxdriver.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02 2005, John W. Linville wrote:
> Update libata's SMART-related ioctl handlers to match the current
> ATA command pass-through specification (T10/04-262r7).  Also change
> related SCSI op-code definition to match current spec.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> Contact w/ spec author (Curtis Stevens @ Western Digital) indicates
> that while a revision 8 of the spec is expected, that it is really
> only a re-formatting of the text to match T10 requirements.  According
> to Stevens, revision 8 is expected to be the last version of the spec.
> 
>  drivers/scsi/libata-scsi.c |    6 ++++--
>  include/scsi/scsi.h        |    6 +++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> --- sata-smart-2.6/drivers/scsi/libata-scsi.c.orig	2005-02-01 16:24:01.687622085 -0500
> +++ sata-smart-2.6/drivers/scsi/libata-scsi.c	2005-02-01 16:49:18.213876086 -0500
> @@ -109,14 +109,16 @@ int ata_cmd_ioctl(struct scsi_device *sc
>  			return -ENOMEM;
>  
>  		scsi_cmd[1]  = (4 << 1); /* PIO Data-in */
> +		scsi_cmd[2]  = 0x0e;     /* no off.line or cc, read from dev,
> +		                            block count in sector count field */
>  		sreq->sr_data_direction = DMA_FROM_DEVICE;
>  	} else {
>  		scsi_cmd[1]  = (3 << 1); /* Non-data */
> +		/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
>  		sreq->sr_data_direction = DMA_NONE;
>  	}
>  
>  	scsi_cmd[0] = ATA_16;
> -	scsi_cmd[2] = 0x1f;     /* no off.line or cc, yes all registers */
>  
>  	scsi_cmd[4] = args[2];
>  	if (args[0] == WIN_SMART) { /* hack -- ide driver does this too... */
> @@ -179,7 +181,7 @@ int ata_task_ioctl(struct scsi_device *s
>  	memset(scsi_cmd, 0, sizeof(scsi_cmd));
>  	scsi_cmd[0]  = ATA_16;
>  	scsi_cmd[1]  = (3 << 1); /* Non-data */
> -	scsi_cmd[2]  = 0x1f;     /* no off.line or cc, yes all registers */
> +	/* scsi_cmd[2] is already 0 -- no off.line, cc, or data xfer */
>  	scsi_cmd[4]  = args[1];
>  	scsi_cmd[6]  = args[2];
>  	scsi_cmd[8]  = args[3];
> --- sata-smart-2.6/include/scsi/scsi.h.orig	2005-02-01 16:22:12.390234346 -0500
> +++ sata-smart-2.6/include/scsi/scsi.h	2005-02-01 16:23:02.828491161 -0500
> @@ -113,9 +113,9 @@ extern const char *const scsi_device_typ
>  /* values for service action in */
>  #define	SAI_READ_CAPACITY_16  0x10
>  
> -/* Temporary values for T10/04-262 until official values are allocated */
> -#define	ATA_16		      0x85	/* 16-byte pass-thru [0x85 == unused]*/
> -#define	ATA_12		      0xb3	/* 12-byte pass-thru [0xb3 == obsolete set limits command] */
> +/* Values for T10/04-262r7 */
> +#define	ATA_16		      0x85	/* 16-byte pass-thru */
> +#define	ATA_12		      0xa1	/* 12-byte pass-thru */

Ehh are you sure that is correct? 0xa1 is the BLANK command, I would
hate to think there would be a collision like that.

-- 
Jens Axboe

