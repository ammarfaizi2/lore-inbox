Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWIGUhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWIGUhW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 16:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWIGUhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 16:37:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751858AbWIGUhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 16:37:19 -0400
Date: Thu, 7 Sep 2006 13:27:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tejun Heo <htejun@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "J.A. Magallon" <jamagallon@ono.com>
Subject: Re: [PATCH libata-dev#upstream-fixes] libata: ignore CFA signature
 while sanity-checking an ATAPI device
Message-Id: <20060907132707.38e63155.akpm@osdl.org>
In-Reply-To: <20060907113224.GA21853@htj.dyndns.org>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060904013443.797ba40b@werewolf.auna.net>
	<20060903181226.58f9ea80.akpm@osdl.org>
	<44FB929B.7080405@gmail.com>
	<20060905002600.51c5e73b@werewolf.auna.net>
	<44FFE7AF.8010808@gmail.com>
	<20060907131327.494fd1c2@werewolf.auna.net>
	<20060907113224.GA21853@htj.dyndns.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 20:32:24 +0900
Tejun Heo <htejun@gmail.com> wrote:

> 0x848a in ID word 0 indicates CFA device iff the ID data is obtained
> from IDENTIFY DEVICE.  For ATAPI devices, 0x848a in ID work 0
> indicates valid ATAPI device.  Fix sanity check in ata_dev_read_id()
> such that ATAPI devices reporting 0x848a in ID word 0 is not handled
> as error.
> 
> The problem is identified by J.A. Magallon with HL-DT-ST DVDRAM
> GSA-4120B.
> 
> Signed-off-by: Tejun Helo <htejun@gmail.com>
> Cc: J.A. Magallon <jamagallon@ono.com>
> ---
> Jeff, this is a regression and thus should go into .19.

You mean 2.6.18, yes?

> diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
> index 73dd6c8..427b73a 100644
> --- a/drivers/scsi/libata-core.c
> +++ b/drivers/scsi/libata-core.c
> @@ -1256,10 +1256,15 @@ int ata_dev_read_id(struct ata_device *d
>  	swap_buf_le16(id, ATA_ID_WORDS);
>  
>  	/* sanity check */
> -	if ((class == ATA_DEV_ATA) != (ata_id_is_ata(id) | ata_id_is_cfa(id))) {
> -		rc = -EINVAL;
> -		reason = "device reports illegal type";
> -		goto err_out;
> +	rc = -EINVAL;
> +	reason = "device reports illegal type";
> +
> +	if (class == ATA_DEV_ATA) {
> +		if (!ata_id_is_ata(id) && !ata_id_is_cfa(id))
> +			goto err_out;
> +	} else {
> +		if (ata_id_is_ata(id))
> +			goto err_out;
>  	}
>  
>  	if (post_reset && class == ATA_DEV_ATA) {
