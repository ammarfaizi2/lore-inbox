Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161263AbWASEPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbWASEPX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161285AbWASEPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:15:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62388 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161221AbWASEPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:15:20 -0500
Date: Wed, 18 Jan 2006 20:15:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       horst.hummel@de.ibm.com
Subject: Re: [PATCH 6/7] s390: dasd open counter.
Message-Id: <20060118201500.1e1deafa.akpm@osdl.org>
In-Reply-To: <20060118165745.GF29266@osiris.boeblingen.de.ibm.com>
References: <20060118165745.GF29266@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
>
> From: Horst Hummel <horst.hummel@de.ibm.com>
> 
> The open_count is increased for every opener, that includes the
> blkdev_get in dasd_scan_partitions. This tampers the open_count
> in BIODASDINFO. Hide the internal open from user-space.
> 
> Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
> 
>  drivers/s390/block/dasd_ioctl.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
> --- linux-2.6/drivers/s390/block/dasd_ioctl.c	2006-01-18 17:25:49.000000000 +0100
> +++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2006-01-18 17:25:53.000000000 +0100
> @@ -421,8 +421,15 @@ dasd_ioctl_information(struct block_devi
>  	dasd_info->cu_model = cdev->id.cu_model;
>  	dasd_info->dev_type = cdev->id.dev_type;
>  	dasd_info->dev_model = cdev->id.dev_model;
> -	dasd_info->open_count = atomic_read(&device->open_count);
>  	dasd_info->status = device->state;
> +	/*
> +	 * The open_count is increased for every opener, that includes
> +	 * the blkdev_get in dasd_scan_partitions.
> +	 * This must be hidden from user-space.
> +	 */
> +	dasd_info->open_count = atomic_read(&device->open_count);
> +	if (!device->bdev)
> +		dasd_info->open_count++;

I'll change the above to atomic_inc().
