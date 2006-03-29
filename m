Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWC2LqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWC2LqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 06:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWC2LqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 06:46:05 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:56881 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750754AbWC2LqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 06:46:04 -0500
Date: Wed, 29 Mar 2006 13:46:07 +0200
From: Jens Axboe <axboe@suse.de>
To: Alex Tomas <alex@clusterfs.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC] support for large I/O requests
Message-ID: <20060329114607.GA8186@suse.de>
References: <m31wwljyff.fsf@bzzz.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m31wwljyff.fsf@bzzz.home.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Alex Tomas wrote:
> 
> On some system (DDN, for example), we've observed noticable
> performance improvement using large I/O requests (1,2,4 MBs).
> please, review the patch for inclusion.
> 
> thanks, Alex
> 
> 
> Signed-off-by: Johann Lombardi <johann.lombardi@bull.net>
> 
> Index: linux-2.6.16/include/linux/blkdev.h
> ===================================================================
> --- linux-2.6.16.orig/include/linux/blkdev.h	2006-02-07 14:27:53.000000000 +0100
> +++ linux-2.6.16/include/linux/blkdev.h	2006-02-07 15:21:48.000000000 +0100
> @@ -667,10 +667,29 @@ extern long blk_congestion_wait(int rw, 
>  extern void blk_rq_bio_prep(request_queue_t *, struct request *, struct bio *);
>  extern int blkdev_issue_flush(struct block_device *, sector_t *);
>  
> -#define MAX_PHYS_SEGMENTS 128
> -#define MAX_HW_SEGMENTS 128
>  #define SAFE_MAX_SECTORS 255
>  #define BLK_DEF_MAX_SECTORS 1024
> +#ifdef CONFIG_LARGE_IO_SIZE_512K
> +#define MAX_PHYS_SEGMENTS (1 << (19 - PAGE_CACHE_SHIFT))
> +#define MAX_HW_SEGMENTS (1 << (19 - PAGE_CACHE_SHIFT))
> +#elif CONFIG_LARGE_IO_SIZE_1M
> +#define MAX_PHYS_SEGMENTS (1 << (20 - PAGE_CACHE_SHIFT))
> +#define MAX_HW_SEGMENTS (1 << (20 - PAGE_CACHE_SHIFT))
> +#elif CONFIG_LARGE_IO_SIZE_2M
> +#define MAX_PHYS_SEGMENTS (1 << (21 - PAGE_CACHE_SHIFT))
> +#define MAX_HW_SEGMENTS (1 << (21 - PAGE_CACHE_SHIFT))
> +#elif CONFIG_LARGE_IO_SIZE_4M
> +#define MAX_PHYS_SEGMENTS (1 << (22 - PAGE_CACHE_SHIFT))
> +#define MAX_HW_SEGMENTS (1 << (22 - PAGE_CACHE_SHIFT))
> +#elif CONFIG_LARGE_IO_SIZE_8M
> +#define MAX_PHYS_SEGMENTS (1 << (23 - PAGE_CACHE_SHIFT))
> +#define MAX_HW_SEGMENTS (1 << (23 - PAGE_CACHE_SHIFT))
> +#elif CONFIG_LARGE_IO_SIZE_16M
> +#define MAX_PHYS_SEGMENTS (1 << (24 - PAGE_CACHE_SHIFT))
> +#define MAX_HW_SEGMENTS (1 << (24 - PAGE_CACHE_SHIFT))
> +#else
> +#error "unknown size, check .config"
> +#endif

These are defaults, don't change them. They don't actually limit
anything, the drive is free to set it higher.

> Index: linux-2.6.16/include/linux/bio.h
> ===================================================================
> --- linux-2.6.16.orig/include/linux/bio.h	2006-02-07 14:27:53.000000000 +0100
> +++ linux-2.6.16/include/linux/bio.h	2006-02-07 15:22:35.000000000 +0100
> @@ -46,7 +46,22 @@
>  #define BIO_BUG_ON
>  #endif
>  
> -#define BIO_MAX_PAGES		(256)
> +#ifdef CONFIG_LARGE_IO_SIZE_512K
> +#define BIO_MAX_PAGES		(1 << (19 - PAGE_CACHE_SHIFT))
> +#elif CONFIG_LARGE_IO_SIZE_1M
> +#define BIO_MAX_PAGES		(1 << (20 - PAGE_CACHE_SHIFT))
> +#elif CONFIG_LARGE_IO_SIZE_2M
> +#define BIO_MAX_PAGES		(1 << (21 - PAGE_CACHE_SHIFT))
> +#elif CONFIG_LARGE_IO_SIZE_4M
> +#define BIO_MAX_PAGES		(1 << (22 - PAGE_CACHE_SHIFT))
> +#elif CONFIG_LARGE_IO_SIZE_8M
> +#define BIO_MAX_PAGES		(1 << (23 - PAGE_CACHE_SHIFT))
> +#elif CONFIG_LARGE_IO_SIZE_16M
> +#define BIO_MAX_PAGES		(1 << (24 - PAGE_CACHE_SHIFT))
> +#else
> +#error "unknown size, check .config"
> +#endif

This one is different, it does cap the max indidivual bio size. However,
you can string bio's together inside a struct request for a larger io.

In general, I don't think we need to do anything. You can increase the
max request sizes through sysfs. If you want to do something useful in
this area, go over all block drivers and make sure they set the correct
max_sectors/max_segments limits instead. A config option is a bad idea
imo.

-- 
Jens Axboe

