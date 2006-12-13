Return-Path: <linux-kernel-owner+w=401wt.eu-S965048AbWLMS4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWLMS4r (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWLMS4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:56:47 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:41389 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965061AbWLMS4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:56:45 -0500
Date: Wed, 13 Dec 2006 10:56:27 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
Message-ID: <20061213185627.GA21535@us.ibm.com>
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org> <4574B004.6030606@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4574B004.6030606@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 03:32:20PM -0800, Darrick J. Wong wrote:
> The Quantum GoVault SATAPI removable disk device returns ATA_ERR in
> response to a REPORT LUNS packet.  If this happens to an ATAPI device
> that is attached to a SAS controller (this is the case with sas_ata),
> the device does not load because SCSI won't touch a "SCSI device"
> that won't report its LUNs.  Since most ATAPI devices don't support
> multiple LUNs anyway, we might as well fake a response like we do for
> ATA devices.

If the REPORT LUNS fails, we should fall back to a sequential scan.

Is (or why isn't) the error propagated back to scsi?

> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  drivers/ata/libata-scsi.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 47ea111..5ecf260 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2833,8 +2833,13 @@ static inline int __ata_scsi_queuecmd(st
>  			rc = ata_scsi_translate(dev, cmd, done, xlat_func);
>  		else
>  			ata_scsi_simulate(dev, cmd, done);
> -	} else
> -		rc = ata_scsi_translate(dev, cmd, done, atapi_xlat);
> +	} else {
> +		/* Simulate REPORT LUNS for ATAPI devices */
> +		if (cmd->cmnd[0] == REPORT_LUNS)
> +			ata_scsi_simulate(dev, cmd, done);
> +		else
> +			rc = ata_scsi_translate(dev, cmd, done, atapi_xlat);
> +	}
> 
>  	return rc;
>  }

-- Patrick Mansfield
