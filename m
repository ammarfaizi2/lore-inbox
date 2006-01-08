Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbWAHRRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbWAHRRG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 12:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752639AbWAHRRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 12:17:05 -0500
Received: from as2.cineca.com ([130.186.84.242]:62889 "EHLO as2.cineca.com")
	by vger.kernel.org with ESMTP id S1751432AbWAHRRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 12:17:00 -0500
Date: Sun, 8 Jan 2006 18:20:57 +0000
From: Luca Risolia <luca.risolia@studio.unibo.it>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/media/w9968cf.c: remove hooks for the vpp module
Message-ID: <20060108182057.GA4430@studio.unibo.it>
Reply-To: luca.risolia@studio.unibo.it
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linux-kernel@vger.kernel.org
References: <20060106023000.GX12313@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106023000.GX12313@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 03:30:00AM +0100, Adrian Bunk wrote:
> - the w9968cf-vpp module is not intended for inclusion into the kernel
> - the upstream w9968cf package shipping the w9968cf-vpp module suggests
>   to simply replace the w9968cf module shipped with the kernel
> 
> Therefore, there seems to be no good reason spending some bytes of 
> kernel memory for hooks for the w9968cf-vpp module.

It's okay, but could you complete the patch by updating the 
documentation w9968cf.txt as well?

Thanks
Luca Risolia

> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Luca Risolia <luca.risolia@studio.unibo.it>

> 
> ---
> 
>  drivers/usb/media/w9968cf.c     |  128 --------------------------------
>  drivers/usb/media/w9968cf.h     |    1 
>  drivers/usb/media/w9968cf_vpp.h |    3 
>  3 files changed, 1 insertion(+), 131 deletions(-)
> 
> --- linux-2.6.15-mm1-full/drivers/usb/media/w9968cf_vpp.h.old	2006-01-06 02:26:01.000000000 +0100
> +++ linux-2.6.15-mm1-full/drivers/usb/media/w9968cf_vpp.h	2006-01-06 02:26:08.000000000 +0100
> @@ -37,7 +37,4 @@
>  	u8 busy; /* read-only flag: module is/is not in use */
>  };
>  
> -extern int w9968cf_vppmod_register(struct w9968cf_vpp_t*);
> -extern int w9968cf_vppmod_deregister(struct w9968cf_vpp_t*);
> -
>  #endif /* _W9968CF_VPP_H_ */
> --- linux-2.6.15-mm1-full/drivers/usb/media/w9968cf.h.old	2006-01-06 02:52:03.000000000 +0100
> +++ linux-2.6.15-mm1-full/drivers/usb/media/w9968cf.h	2006-01-06 02:52:08.000000000 +0100
> @@ -195,7 +195,6 @@
>  };
>  
>  static struct w9968cf_vpp_t* w9968cf_vpp;
> -static DECLARE_MUTEX(w9968cf_vppmod_lock);
>  static DECLARE_WAIT_QUEUE_HEAD(w9968cf_vppmod_wait);
>  
>  static LIST_HEAD(w9968cf_dev_list); /* head of V4L registered cameras list */
> --- linux-2.6.15-mm1-full/drivers/usb/media/w9968cf.c.old	2006-01-06 02:26:15.000000000 +0100
> +++ linux-2.6.15-mm1-full/drivers/usb/media/w9968cf.c	2006-01-06 03:01:55.000000000 +0100
> @@ -62,7 +62,6 @@
>  MODULE_SUPPORTED_DEVICE("Video");
>  
>  static int ovmod_load = W9968CF_OVMOD_LOAD;
> -static int vppmod_load = W9968CF_VPPMOD_LOAD;
>  static unsigned short simcams = W9968CF_SIMCAMS;
>  static short video_nr[]={[0 ... W9968CF_MAX_DEVICES-1] = -1}; /*-1=first free*/
>  static unsigned int packet_size[] = {[0 ... W9968CF_MAX_DEVICES-1] = 
> @@ -107,7 +106,6 @@
>  
>  #ifdef CONFIG_KMOD
>  module_param(ovmod_load, bool, 0644);
> -module_param(vppmod_load, bool, 0444);
>  #endif
>  module_param(simcams, ushort, 0644);
>  module_param_array(video_nr, short, &param_nv[0], 0444);
> @@ -150,18 +148,6 @@
>                   "\ninto memory."
>                   "\nDefault value is "__MODULE_STRING(W9968CF_OVMOD_LOAD)"."
>                   "\n");
> -MODULE_PARM_DESC(vppmod_load, 
> -                 "\n<0|1> Automatic 'w9968cf-vpp' module loading."
> -                 "\n0 disabled, 1 enabled."
> -                 "\nIf enabled, every time an application attempts to open a"
> -                 "\ncamera, 'insmod' searches for the video post-processing"
> -                 "\nmodule in the system and loads it automatically (if"
> -                 "\npresent). The optional 'w9968cf-vpp' module adds extra"
> -                 "\n image manipulation functions to the 'w9968cf' module,like"
> -                 "\nsoftware up-scaling,colour conversions and video decoding"
> -                 "\nfor very high frame rates."
> -                 "\nDefault value is "__MODULE_STRING(W9968CF_VPPMOD_LOAD)"."
> -                 "\n");
>  #endif
>  MODULE_PARM_DESC(simcams, 
>                   "\n<n> Number of cameras allowed to stream simultaneously."
> @@ -492,10 +478,6 @@
>  static void w9968cf_pop_frame(struct w9968cf_device*,struct w9968cf_frame_t**);
>  static void w9968cf_release_resources(struct w9968cf_device*);
>  
> -/* Intermodule communication */
> -static int w9968cf_vppmod_detect(struct w9968cf_device*);
> -static void w9968cf_vppmod_release(struct w9968cf_device*);
> -
>  
>  
>  /****************************************************************************
> @@ -2737,9 +2719,7 @@
>  	cam->streaming = 0;
>  	cam->misconfigured = 0;
>  
> -	if (!w9968cf_vpp)
> -		if ((err = w9968cf_vppmod_detect(cam)))
> -			goto out;
> +	w9968cf_adjust_configuration(cam);
>  
>  	if ((err = w9968cf_allocate_memory(cam)))
>  		goto deallocate_memory;
> @@ -2766,7 +2746,6 @@
>  
>  deallocate_memory:
>  	w9968cf_deallocate_memory(cam);
> -out:
>  	DBG(2, "Failed to open the video device")
>  	up(&cam->dev_sem);
>  	up_read(&w9968cf_disconnect);
> @@ -2784,8 +2763,6 @@
>  
>  	w9968cf_stop_transfer(cam);
>  
> -	w9968cf_vppmod_release(cam);
> -
>  	if (cam->disconnected) {
>  		w9968cf_release_resources(cam);
>  		up(&cam->dev_sem);
> @@ -3681,106 +3658,6 @@
>   * Module init, exit and intermodule communication                          *
>   ****************************************************************************/
>  
> -static int w9968cf_vppmod_detect(struct w9968cf_device* cam)
> -{
> -	if (!w9968cf_vpp)
> -		if (vppmod_load)
> -			request_module("w9968cf-vpp");
> -
> -	down(&w9968cf_vppmod_lock);
> -
> -	if (!w9968cf_vpp) {
> -		DBG(4, "Video post-processing module not detected")
> -		w9968cf_adjust_configuration(cam);
> -		goto out;
> -	}
> -
> -	if (!try_module_get(w9968cf_vpp->owner)) {
> -		DBG(1, "Couldn't increment the reference count of "
> -		       "the video post-processing module")
> -		up(&w9968cf_vppmod_lock);
> -		return -ENOSYS;
> -	}
> -
> -	w9968cf_vpp->busy++;
> -
> -	DBG(5, "Video post-processing module detected")
> -
> -out:
> -	up(&w9968cf_vppmod_lock);
> -	return 0;
> -}
> -
> -
> -static void w9968cf_vppmod_release(struct w9968cf_device* cam)
> -{
> -	down(&w9968cf_vppmod_lock);
> -
> -	if (w9968cf_vpp && w9968cf_vpp->busy) {
> -		module_put(w9968cf_vpp->owner);
> -		w9968cf_vpp->busy--;
> -		wake_up(&w9968cf_vppmod_wait);
> -		DBG(5, "Video post-processing module released")
> -	}
> -
> -	up(&w9968cf_vppmod_lock);
> -}
> -
> -
> -int w9968cf_vppmod_register(struct w9968cf_vpp_t* vpp)
> -{
> -	down(&w9968cf_vppmod_lock);
> -
> -	if (w9968cf_vpp) {
> -		KDBG(1, "Video post-processing module already registered")
> -		up(&w9968cf_vppmod_lock);
> -		return -EINVAL;
> -	}
> -
> -	w9968cf_vpp = vpp;
> -	w9968cf_vpp->busy = 0;
> -
> -	KDBG(2, "Video post-processing module registered")
> -	up(&w9968cf_vppmod_lock);
> -	return 0;
> -}
> -
> -
> -int w9968cf_vppmod_deregister(struct w9968cf_vpp_t* vpp)
> -{
> -	down(&w9968cf_vppmod_lock);
> -
> -	if (!w9968cf_vpp) {
> -		up(&w9968cf_vppmod_lock);
> -		return -EINVAL;
> -	}
> -
> -	if (w9968cf_vpp != vpp) {
> -		KDBG(1, "Only the owner can unregister the video "
> -		        "post-processing module")
> -		up(&w9968cf_vppmod_lock);
> -		return -EINVAL;
> -	}
> -
> -	if (w9968cf_vpp->busy) {
> -		KDBG(2, "Video post-processing module busy. Wait for it to be "
> -		        "released...")
> -		up(&w9968cf_vppmod_lock);
> -		wait_event(w9968cf_vppmod_wait, !w9968cf_vpp->busy);
> -		w9968cf_vpp = NULL;
> -		goto out;
> -	}
> -
> -	w9968cf_vpp = NULL;
> -
> -	up(&w9968cf_vppmod_lock);
> -
> -out:
> -	KDBG(2, "Video post-processing module unregistered")
> -	return 0;
> -}
> -
> -
>  static int __init w9968cf_module_init(void)
>  {
>  	int err;
> @@ -3810,6 +3687,3 @@
>  module_init(w9968cf_module_init);
>  module_exit(w9968cf_module_exit);
>  
> -
> -EXPORT_SYMBOL(w9968cf_vppmod_register);
> -EXPORT_SYMBOL(w9968cf_vppmod_deregister);
> 
