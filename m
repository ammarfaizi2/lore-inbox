Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWC0FQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWC0FQR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 00:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWC0FQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 00:16:17 -0500
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:1517 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S1750707AbWC0FQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 00:16:16 -0500
Subject: Re: [PATCH 8/8] zoran: Init cleanups
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060313213651.e983de01.khali@linux-fr.org>
References: <20060313210933.88a42375.khali@linux-fr.org>
	 <20060313213651.e983de01.khali@linux-fr.org>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 00:09:59 -0500
Message-Id: <1143436200.2691.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, 2006-03-13 at 21:36 +0100, Jean Delvare wrote:
> Cleanups to the zr36057 initialization:
> * Drop intermediate local variables.
> * Single error path.
> Also drop a needless cast on kfree.

Please take this patch into your tree, it looks good. Jean, thanks for
contributing (again!).

Cheers,
Ronald

> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/media/video/zoran_card.c |   38 +++++++++++++++++---------------------
>  1 file changed, 17 insertions(+), 21 deletions(-)
> 
> --- linux-2.6.15-git.orig/drivers/media/video/zoran_card.c	2006-01-12 21:08:57.000000000 +0100
> +++ linux-2.6.15-git/drivers/media/video/zoran_card.c	2006-01-12 21:12:05.000000000 +0100
> @@ -995,10 +995,7 @@
>  static int __devinit
>  zr36057_init (struct zoran *zr)
>  {
> -	u32 *mem;
> -	void *vdev;
> -	unsigned mem_needed;
> -	int j;
> +	int j, err;
>  	int two = 2;
>  	int zero = 0;
>  
> @@ -1049,19 +1046,16 @@
>  
>  	/* allocate memory *before* doing anything to the hardware
>  	 * in case allocation fails */
> -	mem_needed = BUZ_NUM_STAT_COM * 4;
> -	mem = kzalloc(mem_needed, GFP_KERNEL);
> -	vdev = (void *) kmalloc(sizeof(struct video_device), GFP_KERNEL);
> -	if (!mem || !vdev) {
> +	zr->stat_com = kzalloc(BUZ_NUM_STAT_COM * 4, GFP_KERNEL);
> +	zr->video_dev = kmalloc(sizeof(struct video_device), GFP_KERNEL);
> +	if (!zr->stat_com || !zr->video_dev) {
>  		dprintk(1,
>  			KERN_ERR
>  			"%s: zr36057_init() - kmalloc (STAT_COM) failed\n",
>  			ZR_DEVNAME(zr));
> -		kfree(vdev);
> -		kfree(mem);
> -		return -ENOMEM;
> +		err = -ENOMEM;
> +		goto exit_free;
>  	}
> -	zr->stat_com = mem;
>  	for (j = 0; j < BUZ_NUM_STAT_COM; j++) {
>  		zr->stat_com[j] = 1;	/* mark as unavailable to zr36057 */
>  	}
> @@ -1069,16 +1063,11 @@
>  	/*
>  	 *   Now add the template and register the device unit.
>  	 */
> -	zr->video_dev = vdev;
>  	memcpy(zr->video_dev, &zoran_template, sizeof(zoran_template));
>  	strcpy(zr->video_dev->name, ZR_DEVNAME(zr));
> -	if (video_register_device(zr->video_dev, VFL_TYPE_GRABBER,
> -				  video_nr) < 0) {
> -		zoran_unregister_i2c(zr);
> -		kfree((void *) zr->stat_com);
> -		kfree(vdev);
> -		return -1;
> -	}
> +	err = video_register_device(zr->video_dev, VFL_TYPE_GRABBER, video_nr);
> +	if (err < 0)
> +		goto exit_unregister;
>  
>  	zoran_init_hardware(zr);
>  	if (*zr_debug > 2)
> @@ -1092,6 +1081,13 @@
>  	zr->zoran_proc = NULL;
>  	zr->initialized = 1;
>  	return 0;
> +
> +exit_unregister:
> +	zoran_unregister_i2c(zr);
> +exit_free:
> +	kfree(zr->stat_com);
> +	kfree(zr->video_dev);
> +	return err;
>  }
>  
>  static void
> @@ -1121,7 +1117,7 @@
>  	btwrite(0, ZR36057_SPGPPCR);
>  	free_irq(zr->pci_dev->irq, zr);
>  	/* unmap and free memory */
> -	kfree((void *) zr->stat_com);
> +	kfree(zr->stat_com);
>  	zoran_proc_cleanup(zr);
>  	iounmap(zr->zr36057_mem);
>  	pci_disable_device(zr->pci_dev);
> 

