Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937037AbWLFSYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937037AbWLFSYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937025AbWLFSYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:24:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35116 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937006AbWLFSYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:24:12 -0500
Date: Wed, 6 Dec 2006 18:24:08 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Miguel Ojeda <maxextreme@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       linux-acpi@vger.kernel.org, kernel-discuss@handhelds.org
Subject: Re: Display class
In-Reply-To: <20061206101434.8acb229a.randy.dunlap@oracle.com>
Message-ID: <Pine.LNX.4.64.0612061818540.28745@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
 <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
 <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
 <Pine.LNX.4.64.0612051740250.2925@pentafluge.infradead.org>
 <20061205171401.fd11160d.randy.dunlap@oracle.com>
 <Pine.LNX.4.64.0612061443180.28745@pentafluge.infradead.org>
 <20061206101434.8acb229a.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > That patch was rought draft for feedback. I applied your comments. This 
> > patch actually works. It includes my backlight fix as well.
> 
> Glad to hear it.  I had to make the following changes
> in order for it to build.
> However, I still have build errors for aty.

Ug. I see another problem. I had backlight completly compiled as a 
module! Thus it hid these compile errors. So we need also a 
CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE check as well. Can sysfs handle this 
well or would it be better the the backlight class be a boolean instead?

 
> ---
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Replace CONFIG_FB_BACKLIGHT with CONFIG_BACKLIGHT_CLASS_DEVICE
> in include/linux/fb.h and drivers/video/fbsysfs.c
> to match Kconfig changes.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  drivers/video/fbsysfs.c |    8 ++++----
>  include/linux/fb.h      |    4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> --- linux-2.6.19-git7.orig/include/linux/fb.h
> +++ linux-2.6.19-git7/include/linux/fb.h
> @@ -367,7 +367,7 @@ struct fb_cursor {
>  	struct fb_image	image;	/* Cursor image */
>  };
>  
> -#ifdef CONFIG_FB_BACKLIGHT
> +#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
>  /* Settings for the generic backlight code */
>  #define FB_BACKLIGHT_LEVELS	128
>  #define FB_BACKLIGHT_MAX	0xFF
> @@ -759,7 +759,7 @@ struct fb_info {
>  	struct list_head modelist;      /* mode list */
>  	struct fb_videomode *mode;	/* current mode */
>  
> -#ifdef CONFIG_FB_BACKLIGHT
> +#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
>  	/* Lock ordering:
>  	 * bl_mutex (protects bl_dev and bl_curve)
>  	 *   bl_dev->sem (backlight class)
> --- linux-2.6.19-git7.orig/drivers/video/fbsysfs.c
> +++ linux-2.6.19-git7/drivers/video/fbsysfs.c
> @@ -58,7 +58,7 @@ struct fb_info *framebuffer_alloc(size_t
>  
>  	info->device = dev;
>  
> -#ifdef CONFIG_FB_BACKLIGHT
> +#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
>  	mutex_init(&info->bl_mutex);
>  #endif
>  
> @@ -411,7 +411,7 @@ static ssize_t show_fbstate(struct devic
>  	return snprintf(buf, PAGE_SIZE, "%d\n", fb_info->state);
>  }
>  
> -#ifdef CONFIG_FB_BACKLIGHT
> +#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
>  static ssize_t store_bl_curve(struct device *device,
>  			      struct device_attribute *attr,
>  			      const char *buf, size_t count)
> @@ -500,7 +500,7 @@ static struct device_attribute device_at
>  	__ATTR(stride, S_IRUGO, show_stride, NULL),
>  	__ATTR(rotate, S_IRUGO|S_IWUSR, show_rotate, store_rotate),
>  	__ATTR(state, S_IRUGO|S_IWUSR, show_fbstate, store_fbstate),
> -#ifdef CONFIG_FB_BACKLIGHT
> +#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
>  	__ATTR(bl_curve, S_IRUGO|S_IWUSR, show_bl_curve, store_bl_curve),
>  #endif
>  };
> @@ -541,7 +541,7 @@ void fb_cleanup_device(struct fb_info *f
>  	}
>  }
>  
> -#ifdef CONFIG_FB_BACKLIGHT
> +#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
>  /* This function generates a linear backlight curve
>   *
>   *     0: off
> 
