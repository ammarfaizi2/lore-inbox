Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262788AbTDATfL>; Tue, 1 Apr 2003 14:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTDATfL>; Tue, 1 Apr 2003 14:35:11 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:59080 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262788AbTDATfK>; Tue, 1 Apr 2003 14:35:10 -0500
Date: Tue, 01 Apr 2003 11:36:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: colpatch@us.ibm.com
cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (2.5.66-mm2) War on warnings
Message-ID: <135490000.1049225789@flay>
In-Reply-To: <3E89E94C.4040004@us.ibm.com>
References: <19200000.1049210557@[10.10.2.4]> <20030401152703.GA21986@gtf.org> <25070000.1049213622@[10.10.2.4]> <3E89E94C.4040004@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.66-vanilla/drivers/char/drm/r128_cce.c linux-2.5.66-warnings/drivers/char/drm/r128_cce.c
> --- linux-2.5.66-vanilla/drivers/char/drm/r128_cce.c	Mon Mar 24 14:00:07 2003
> +++ linux-2.5.66-warnings/drivers/char/drm/r128_cce.c	Mon Mar 31 11:55:16 2003
> @@ -352,7 +352,7 @@
>       			    entry->busaddr[page_ofs]);
>  		DRM_DEBUG( "ring rptr: offset=0x%08x handle=0x%08lx\n",
>  			   entry->busaddr[page_ofs],
> -     			   entry->handle + tmp_ofs );
> +     			   (unsigned long)entry->handle + tmp_ofs );
>  	}
>  
>  	/* Set watermark control */

These sort of things really need to be typecast to u64 if that's
the dma_addr_t printk problem ... otherwise you silently lose data,
which is most confusing.

linux-2.5.66-vanilla/drivers/scsi/scsi_sysfs.c linux-2.5.66-warnings/drivers/scsi/scsi_sysfs.c
> --- linux-2.5.66-vanilla/drivers/scsi/scsi_sysfs.c	Mon Mar 24 14:00:08 2003
> +++ linux-2.5.66-warnings/drivers/scsi/scsi_sysfs.c	Mon Mar 31 11:56:02 2003
> @@ -272,14 +272,17 @@
>  	return 0; 
>  }
>  
> +void scsi_rescan_device(struct scsi_device *);
>  static ssize_t
>  store_rescan_field (struct device *dev, const char *buf, size_t count) 
>  {
>  	int ret = ENODEV;
>  	struct scsi_device *sdev;
>  	sdev = to_scsi_device(dev);
> -	if (sdev)
> -		ret = scsi_rescan_device(sdev);
> +	if (sdev){
> +		ret = 0;
> +		scsi_rescan_device(sdev);
> +	}
>  	return ret;
>  }


That's pretty much what I did, but apparently Christoph had a better fix
posted to linux-scsi somewhere. I lost it though ...

M.

