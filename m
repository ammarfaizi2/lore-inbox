Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbTBKT5Z>; Tue, 11 Feb 2003 14:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265787AbTBKT5Y>; Tue, 11 Feb 2003 14:57:24 -0500
Received: from magic.adaptec.com ([208.236.45.80]:63968 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S265773AbTBKT5X>; Tue, 11 Feb 2003 14:57:23 -0500
Date: Tue, 11 Feb 2003 13:06:41 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: ISHIKAWA Mutsumi <ishikawa@linux.or.jp>, jejb@steeleye.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.60 aic79xx] aic79xx build and lun detect problem fix
Message-ID: <3729142704.1044994000@aslan.btc.adaptec.com>
In-Reply-To: <20030211182558.DED278DC14@master.hanzubon.jp>
References: <20030211182558.DED278DC14@master.hanzubon.jp>
X-Mailer: Mulberry/3.0.0b12 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  This patch will fix two problems.
> 
>   fix build problem related scsi_cmnd changes

The aic7xxx driver has one place that missed the conversion too.
Since the cmd->lun field is no longer filled in, why hasn't the
field been removed from the cmd structure?  That would make it
easy to catch these kinds of bugs.

Thanks for the report.  We're close to doing another aic79xx
driver drop and I'll incorporate the change then.

--
Justin
> 
>   http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/scsi/aic7xxx/aic79xx_osm.c@1.16?nav=index.html|src/|src/drivers|src/drivers/scsi|src/drivers/scsi/aic7xxx|hist/drivers/scsi/aic7xxx/aic79xx_osm.c
> 
>     This change(latest aic79xx driver and scsi_cmnd changes merging)
>     is dropped `hscb->lun = cmd->device->lun;' (in aic79xx_osm.c line
>     4272). This change cause lun detect problem. I believe it is still
>     needed.
> 
> 
> --- linux-2.5/drivers/scsi/aic7xxx/aic79xx_osm.c.orig	2003-02-11 14:58:01.000000000 +0900
> +++ linux-2.5/drivers/scsi/aic7xxx/aic79xx_osm.c	2003-02-11 16:08:00.000000000 +0900
> @@ -1560,7 +1560,7 @@
>  	hscb = scb->hscb;
>  	hscb->control = 0;
>  	hscb->scsiid = BUILD_SCSIID(ahd, cmd);
> -	hscb->lun = cmd->lun;
> +	hscb->lun = cmd->device->lun;
>  	hscb->cdb_len = 0;
>  	hscb->task_management = SIU_TASKMGMT_LUN_RESET;
>  	scb->flags |= SCB_DEVICE_RESET|SCB_RECOVERY_SCB|SCB_ACTIVE;
> @@ -4269,6 +4269,7 @@
>  		 */
>  		hscb->control = 0;
>  		hscb->scsiid = BUILD_SCSIID(ahd, cmd);
> +		hscb->lun = cmd->device->lun;
>  		scb->hscb->task_management = 0;
>  		mask = SCB_GET_TARGET_MASK(ahd, scb);
>  
> 
> -- 
> ISHIKAWA Mutsumi
>  <ishikawa@linux.or.jp>, <ishikawa@debian.org>, <ishikawa@netvillage.co.jp>


