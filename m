Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbUCCLpe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 06:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbUCCLpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 06:45:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22763 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262443AbUCCLpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 06:45:32 -0500
Date: Wed, 3 Mar 2004 12:45:31 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6 ide-cd DMA ripping
Message-ID: <20040303114531.GR9196@suse.de>
References: <20040303113756.GQ9196@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303113756.GQ9196@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03 2004, Jens Axboe wrote:
> +static int cdrom_read_cdda(struct cdrom_device_info *cdi, __u8 __user *ubuf,
> +			   int lba, int nframes)
> +{
> +	int ret;
> +
> +	if (cdi->cdda_method == CDDA_OLD)
> +		return cdrom_read_cdda_old(cdi, ubuf, lba, nframes);
> +
> +	do {
> +		ret = cdrom_read_cdda_bpc(cdi, ubuf, lba, nframes);
> +
> +		if (!ret)
> +			break;
> +
> +		/*
> +		 * I've seen drives get sense 4/8/3 udma crc errors, so
> +		 * drop to single frame dma if we need to
> +		 */
> +		if (cdi->cdda_method == CDDA_BPC_FULL && nframes > 1) {
> +			printk("cdrom: dropping to single frame dma\n");
> +			cdi->cdda_method = CDDA_BPC_SINGLE;
> +			continue;
> +		}
> +
> +		printk("cdrom: dropping to old style cdda\n");
> +		cdi->cdda_method = CDDA_OLD;
> +		ret = cdrom_read_cdda_old(cdi, ubuf, lba, nframes);	
> +	} while (0);

Irk, that should have been a while (1) of course, and a break after the
last cdrom_read_cdda_old();

-- 
Jens Axboe

