Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422908AbWJPWki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422908AbWJPWki (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422910AbWJPWki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:40:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:52420 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422908AbWJPWkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:40:37 -0400
Message-ID: <45340A62.7050406@us.ibm.com>
Date: Mon, 16 Oct 2006 17:40:34 -0500
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [PATCH] libsas: support NCQ for SATA disks
References: <453027A9.3060606@us.ibm.com>
In-Reply-To: <453027A9.3060606@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> This patch adds SATAII NCQ support to libsas.  Both the use_ncq and the
> dma_xfer flags in ata_task must be set for NCQ to work correctly on the
> Adaptec SAS controller.  The rest of the patch adds ATA_FLAG_NCQ to
> sata_port_info and sets up ap->scsi_host so that ata_setup_ncq doesn't
> crash.  Please note that this patch is against the aic94xx-sas git tree,
> not scsi-misc.  Thanks also to James Bottomley for providing an earlier
> version of this patch from which to work.


> @@ -875,6 +881,7 @@ int sas_target_alloc(struct scsi_target 
>  
>  		ap->private_data = found_dev;
>  		ap->cbl = ATA_CBL_SATA;
> +		ap->scsi_host = shost;
>  		found_dev->sata_dev.ap = ap;
>  	}
>  

This doesn't look like the right fix for the oops you were seeing. The
SAS usage of libata has ap->scsi_host as NULL, which indicates that
libata does not own the associated scsi_host. I'm concerned you may
have broken some other code path by making this change. I think the correct
fix may require removing the dependence of ap->scsi_host from
ata_dev_config_ncq. 

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
