Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWJ2Vjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWJ2Vjx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 16:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWJ2Vjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 16:39:53 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:49255 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1030334AbWJ2Vjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 16:39:52 -0500
Date: Sun, 29 Oct 2006 22:39:22 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [patch 5/5] scsi: fix uaccess handling
Message-ID: <20061029213922.GA8494@osiris.ibm.com>
References: <20061026130010.GA7127@osiris.boeblingen.de.ibm.com> <20061026130452.GF7127@osiris.boeblingen.de.ibm.com> <20061028113143.GB14785@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028113143.GB14785@infradead.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While not your fault I'd suggest to fix the __put_user abuse at the same
> time, as in the untested patch below for scsi_ioctl.c:

Makes sense. Even though the whole SCSI_IOCTL_GET_IDLUN ioctl interface
is pretty pointless.
It supports only up to 255 different ids and luns and might return the
same 'dev_id' for two different devices...
Any user space utility that depends on this interface would do the wrong
thing (whatever that would be).

> Index: linux-2.6/drivers/scsi/scsi_ioctl.c
> ===================================================================
> --- linux-2.6.orig/drivers/scsi/scsi_ioctl.c	2006-10-28 13:24:18.000000000 +0200
> +++ linux-2.6/drivers/scsi/scsi_ioctl.c	2006-10-28 13:30:17.000000000 +0200
> @@ -173,6 +173,21 @@
>          return copy_to_user(arg, dev->bus_id, sizeof(dev->bus_id))? -EFAULT: 0;
>  }
>  
> +static int scsi_get_idlun(struct scsi_device *sdev,
> +		struct scsi_idlun __user *arg)
> +{
> +	struct scsi_idlun karg = {
> +		.dev_id		= (sdev->id & 0xff) +
> +			          ((sdev->lun & 0xff) << 8) +
> +				  ((sdev->channel & 0xff) << 16) +
> +				  ((sdev->host->host_no & 0xff) << 24),
> +		.host_unique_id	= sdev->host->unique_id
> +	};
> +
> +	if (copy_to_user(arg, &karg, sizeof(struct scsi_idlun)))
> +		return -EFAULT;
> +	return 0;
> +}
>  
>  /*
>   * the scsi_ioctl() function differs from most ioctls in that it does
> @@ -214,17 +229,7 @@
>  
>  	switch (cmd) {
>  	case SCSI_IOCTL_GET_IDLUN:
> -		if (!access_ok(VERIFY_WRITE, arg, sizeof(struct scsi_idlun)))
> -			return -EFAULT;
> -
> -		__put_user((sdev->id & 0xff)
> -			 + ((sdev->lun & 0xff) << 8)
> -			 + ((sdev->channel & 0xff) << 16)
> -			 + ((sdev->host->host_no & 0xff) << 24),
> -			 &((struct scsi_idlun __user *)arg)->dev_id);
> -		__put_user(sdev->host->unique_id,
> -			 &((struct scsi_idlun __user *)arg)->host_unique_id);
> -		return 0;
> +		return scsi_get_idlun(sdev, arg);
>  	case SCSI_IOCTL_GET_BUS_NUMBER:
>  		return put_user(sdev->host->host_no, (int __user *)arg);
>  	case SCSI_IOCTL_PROBE_HOST:
