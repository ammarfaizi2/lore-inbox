Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVAROP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVAROP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 09:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVAROP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 09:15:28 -0500
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:2959
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S261293AbVAROPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:15:03 -0500
Message-ID: <41ED19AF.6000508@winischhofer.net>
Date: Tue, 18 Jan 2005 15:14:07 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041124 Thunderbird/0.9 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert sis fb driver to compat_ioctl
References: <20050118123340.GC68224@muc.de>
In-Reply-To: <20050118123340.GC68224@muc.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Andi Kleen wrote:
| Convert the sis framebuffer driver to compat ioctl.
|
| Requires generic framebuffer compat_ioctl patch I posted
| earlier on l-k.
|
| Signed-off-by: Andi Kleen <ak@muc.de>

Signed-off-by: Thomas Winischhofer <thomas@winischhofer.net>

|
| diff -u linux-2.6.11-rc1-bk4/drivers/video/sis/sis.h-o
linux-2.6.11-rc1-bk4/drivers/video/sis/sis.h
| --- linux-2.6.11-rc1-bk4/drivers/video/sis/sis.h-o	2005-01-14
10:12:22.000000000 +0100
| +++ linux-2.6.11-rc1-bk4/drivers/video/sis/sis.h	2005-01-17
11:27:41.000000000 +0100
| @@ -527,10 +527,6 @@
|  	int  		newrom;
|  	int  		registered;
|  	int		warncount;
| -#ifdef SIS_CONFIG_COMPAT
| -	int		ioctl32registered;
| -	int		ioctl32vblankregistered;
| -#endif
|
|  	int 		sisvga_engine;
|  	int 		hwcursor_size;
| diff -u linux-2.6.11-rc1-bk4/drivers/video/sis/sis_main.c-o
linux-2.6.11-rc1-bk4/drivers/video/sis/sis_main.c
| --- linux-2.6.11-rc1-bk4/drivers/video/sis/sis_main.c-o	2005-01-14
10:12:22.000000000 +0100
| +++ linux-2.6.11-rc1-bk4/drivers/video/sis/sis_main.c	2005-01-18
05:27:29.000000000 +0100
| @@ -2192,11 +2192,22 @@
|  		break;
|
|  	   default:
| -		return -EINVAL;
| +		return -ENOIOCTLCMD;
|  	}
|  	return 0;
|  }
|
| +#ifdef CONFIG_COMPAT
| +static long sisfb_compat_ioctl(struct file *f, unsigned cmd, unsigned
long arg, struct fb_info *info)
| +{
| +	int ret;
| +	lock_kernel();
| +	ret = sisfb_ioctl(NULL, f, cmd, arg, info);
| +	unlock_kernel();
| +	return ret;
| +}
| +#endif
| +
|  static int
|  sisfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info
*info)
|  {
| @@ -2258,7 +2269,10 @@
|  	.fb_imageblit   = cfb_imageblit,
|  	.fb_cursor      = soft_cursor,
|  	.fb_sync        = fbcon_sis_sync,
| -	.fb_ioctl       = sisfb_ioctl
| +	.fb_ioctl       = sisfb_ioctl,
| +#ifdef CONFIG_COMPAT
| +	.fb_compat_ioctl = sisfb_compat_ioctl,
| +#endif
|  };
|  #endif
|
| @@ -4791,10 +4805,6 @@
|  	ivideo->pcifunc = PCI_FUNC(pdev->devfn);
|  	ivideo->subsysvendor = pdev->subsystem_vendor;
|  	ivideo->subsysdevice = pdev->subsystem_device;
| -#ifdef SIS_CONFIG_COMPAT
| -	ivideo->ioctl32registered = 0;
| -	ivideo->ioctl32vblankregistered = 0;
| -#endif
|
|  #ifndef MODULE
|  	if(sisfb_mode_idx == -1) {
| @@ -5594,30 +5604,6 @@
|  		ivideo->next = card_list;
|  		card_list = ivideo;
|
| -#ifdef SIS_CONFIG_COMPAT
| -		{
| -		int ret;
| -		/* Our ioctls are all "32/64bit compatible" */
| -		if(register_ioctl32_conversion(FBIOGET_VBLANK, NULL)) {
| -		   printk(KERN_ERR "sisfb: Error registering FBIOGET_VBLANK ioctl32
translation\n");
| -		} else {
| -		   ivideo->ioctl32vblankregistered = 1;
| -		}
| -		ret =  register_ioctl32_conversion(FBIO_ALLOC,             NULL);
| -		ret |= register_ioctl32_conversion(FBIO_FREE,              NULL);
| -		ret |= register_ioctl32_conversion(SISFB_GET_INFO_SIZE,    NULL);
| -		ret |= register_ioctl32_conversion(SISFB_GET_INFO,         NULL);
| -		ret |= register_ioctl32_conversion(SISFB_GET_TVPOSOFFSET,  NULL);
| -		ret |= register_ioctl32_conversion(SISFB_SET_TVPOSOFFSET,  NULL);
| -		ret |= register_ioctl32_conversion(SISFB_SET_LOCK,         NULL);
| -		ret |= register_ioctl32_conversion(SISFB_GET_VBRSTATUS,    NULL);
| -		ret |= register_ioctl32_conversion(SISFB_GET_AUTOMAXIMIZE, NULL);
| -		ret |= register_ioctl32_conversion(SISFB_SET_AUTOMAXIMIZE, NULL);
| -		if(ret)	printk(KERN_ERR "sisfb: Error registering ioctl32
translations\n");
| -		else    ivideo->ioctl32registered = 1;
| -		}
| -#endif
| -
|  		printk(KERN_INFO "sisfb: 2D acceleration is %s, y-panning %s\n",
|  		     ivideo->sisfb_accel ? "enabled" : "disabled",
|  		     ivideo->sisfb_ypan  ?
| @@ -5649,28 +5635,6 @@
|  	struct fb_info        *sis_fb_info = ivideo->memyselfandi;
|  	int                   registered = ivideo->registered;
|
| -#ifdef SIS_CONFIG_COMPAT
| -	if(ivideo->ioctl32vblankregistered) {
| -		if(unregister_ioctl32_conversion(FBIOGET_VBLANK)) {
| -			printk(KERN_ERR "sisfb: Error unregistering FBIOGET_VBLANK ioctl32
translation\n");
| -		}
| -	}
| -	if(ivideo->ioctl32registered) {
| -		int ret;
| -		ret =  unregister_ioctl32_conversion(FBIO_ALLOC);
| -		ret |= unregister_ioctl32_conversion(FBIO_FREE);
| -		ret |= unregister_ioctl32_conversion(SISFB_GET_INFO_SIZE);
| -		ret |= unregister_ioctl32_conversion(SISFB_GET_INFO);
| -		ret |= unregister_ioctl32_conversion(SISFB_GET_TVPOSOFFSET);
| -		ret |= unregister_ioctl32_conversion(SISFB_SET_TVPOSOFFSET);
| -		ret |= unregister_ioctl32_conversion(SISFB_SET_LOCK);
| -		ret |= unregister_ioctl32_conversion(SISFB_GET_VBRSTATUS);
| -		ret |= unregister_ioctl32_conversion(SISFB_GET_AUTOMAXIMIZE);
| -		ret |= unregister_ioctl32_conversion(SISFB_SET_AUTOMAXIMIZE);
| -		if(ret)	printk(KERN_ERR "sisfb: Error unregistering ioctl32
translations\n");
| -	}
| -#endif
| -
|  	/* Unmap */
|  	iounmap(ivideo->video_vbase);
|  	iounmap(ivideo->mmio_vbase);
|


- --
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net	       *** http://www.winischhofer.net
twini AT xfree86 DOT org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFB7RmvzydIRAktyUcRAlaNAJ9etKL0TfRslQksUG/vKX7qBrWRpACfZPNc
X6anvSzcBR0WsL+GRabzt7E=
=kZbG
-----END PGP SIGNATURE-----
