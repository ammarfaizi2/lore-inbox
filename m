Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWG2RFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWG2RFG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 13:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWG2RFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 13:05:06 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:59677 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751394AbWG2RFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 13:05:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=DCDUjaVToHky/5SfwcHl4AdLwuFaBwo1nEuocFCbZUh0BV67JOg9kqfkZkB8eXqc0zB17XWtr0k5qsCkUB7qY9L/rGAJGRJ2sTwW6GK4RI+kKT3W5k047oVajxU9uQQ4xoI3p2najaq9qFAilb9LXMB54QEqZlC0DGWwEStODnU=
Date: Sat, 29 Jul 2006 19:04:02 +0200
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: via sata oops on init
Message-ID: <20060729170402.GA20649@leiferikson.dystopia.lan>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060728233950.GD3217@redhat.com> <20060729144528.GD28712@leiferikson.dystopia.lan> <20060729164115.GA16946@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20060729164115.GA16946@redhat.com>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sat, Jul 29, 2006 at 12:41:15PM -0400, Dave Jones wrote:
> --- linux-2.6/drivers/scsi/libata-core.c~	2006-07-29 12:35:32.000000000 -0400
> +++ linux-2.6/drivers/scsi/libata-core.c	2006-07-29 12:39:08.000000000 -0400
> @@ -5419,10 +5419,10 @@ int ata_device_add(const struct ata_prob
>  		unsigned long xfer_mode_mask;
>  
>  		ap = ata_host_add(ent, host_set, i);
> +		host_set->ports[i] = ap;
>  		if (!ap)
>  			goto err_out;
>  
> -		host_set->ports[i] = ap;
>  		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
>  				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
>  				(ap->pio_mask << ATA_SHIFT_PIO);
> @@ -5532,6 +5532,8 @@ int ata_device_add(const struct ata_prob
>  
>  err_out:
>  	for (i = 0; i < count; i++) {
> +		if (!host_set->ports[i])
> +			break;
>  		ata_host_remove(host_set->ports[i], 1);
>  		scsi_host_put(host_set->ports[i]->host);
>  	}

You jump into loop just to skip it.

Signed-off-by: Johannes Weiner <hanzfoo@gmail.com>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="libata-core.goto.patch"

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 386e5f2..064ee85 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -5420,7 +5420,7 @@ int ata_device_add(const struct ata_prob
 
 		ap = ata_host_add(ent, host_set, i);
 		if (!ap)
-			goto err_out;
+			goto err_free_ret;
 
 		host_set->ports[i] = ap;
 		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |

--SLDf9lqlvOQaIe6s--
