Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTFJQSW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTFJQSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:18:22 -0400
Received: from [213.229.38.66] ([213.229.38.66]:29910 "HELO mail.falke.at")
	by vger.kernel.org with SMTP id S263376AbTFJQSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:18:18 -0400
Message-ID: <3EE607EE.9010605@winischhofer.net>
Date: Tue, 10 Jun 2003 18:31:42 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: cp-user-sisfb
References: <20030610100527.GA2194@in.ibm.com> <20030610100643.GB2194@in.ibm.com> <20030610100746.GC2194@in.ibm.com> <20030610100905.GD2194@in.ibm.com> <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com> <20030610101121.GG2194@in.ibm.com> <20030610101318.GH2194@in.ibm.com> <20030610101503.GI2194@in.ibm.com> <20030610101801.GJ2194@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, but this was already fixed in my latest version. I really should 
commit more often...

Thomas

Dipankar Sarma wrote:
> 
> Fix sisfb_ioctl() to use copy_to/from routines. There may be some
> some changes in this patch that are ifdefed out in 2.5. Maintainers
> to rescue.
> 
> 
>  drivers/video/sis/sis_main.c |   91 +++++++++++++++++++++++++------------------
>  1 files changed, 55 insertions(+), 36 deletions(-)
> 
> diff -puN drivers/video/sis/sis_main.c~cp-user-sisfb drivers/video/sis/sis_main.c
> --- linux-2.5.70-ds/drivers/video/sis/sis_main.c~cp-user-sisfb	2003-06-08 04:34:39.000000000 +0530
> +++ linux-2.5.70-ds-dipankar/drivers/video/sis/sis_main.c	2003-06-08 12:27:49.000000000 +0530
> @@ -1461,44 +1461,57 @@ static int sisfb_ioctl(struct inode *ino
>  		       struct fb_info *info)
>  {
>  	TWDEBUG("inside ioctl");
> +	struct sis_memreq req;
> +	struct ap_data ap;
> +	unsigned long a;
>  	switch (cmd) {
>  	   case FBIO_ALLOC:
>  		if (!capable(CAP_SYS_RAWIO))
>  			return -EPERM;
> -		sis_malloc((struct sis_memreq *) arg);
> +		if (copy_from_user(&req, (void *)arg, sizeof(req)))
> +			return -EFAULT;
> +		sis_malloc(&req);
> +		if (copy_to_user((void *)arg, &req, sizeof(req)))
> +			return -EFAULT;
>  		break;
>  	   case FBIO_FREE:
>  		if (!capable(CAP_SYS_RAWIO))
>  			return -EPERM;
> -		sis_free(*(unsigned long *) arg);
> +		if(get_user(a, (unsigned long *) arg))
> +			return -EFAULT;
> +		sis_free(a);
>  		break;
>  	   case FBIOGET_GLYPH:
> +		/* Not in 2.5 ???? */
>                  sis_get_glyph(info,(SIS_GLYINFO *) arg);
>  		break;	
>  	   case FBIOGET_HWCINFO:
>  		{
>  			unsigned long *hwc_offset = (unsigned long *) arg;
>  
> -			if (sisfb_caps & HW_CURSOR_CAP)
> -				*hwc_offset = sisfb_hwcursor_vbase -
> -				    (unsigned long) ivideo.video_vbase;
> -			else
> -				*hwc_offset = 0;
> -
> +			if (sisfb_caps & HW_CURSOR_CAP) {
> +				if (put_user(sisfb_hwcursor_vbase -
> +				    (unsigned long) ivideo.video_vbase,
> +					hwc_offset))
> +					return -EFAULT;
> +			} else if (put_user(0UL, hwc_offset))
> +					return -EFAULT;
>  			break;
>  		}
>  	   case FBIOPUT_MODEINFO:
>  		{
> -			struct mode_info *x = (struct mode_info *)arg;
> +			struct mode_info x;
>  
> -			ivideo.video_bpp        = x->bpp;
> -			ivideo.video_width      = x->xres;
> -			ivideo.video_height     = x->yres;
> -			ivideo.video_vwidth     = x->v_xres;
> -			ivideo.video_vheight    = x->v_yres;
> -			ivideo.org_x            = x->org_x;
> -			ivideo.org_y            = x->org_y;
> -			ivideo.refresh_rate     = x->vrate;
> +			if (copy_from_user(&x, (void *)arg, sizeof(x)))
> +				return -EFAULT;
> +			ivideo.video_bpp        = x.bpp;
> +			ivideo.video_width      = x.xres;
> +			ivideo.video_height     = x.yres;
> +			ivideo.video_vwidth     = x.v_xres;
> +			ivideo.video_vheight    = x.v_yres;
> +			ivideo.org_x            = x.org_x;
> +			ivideo.org_y            = x.org_y;
> +			ivideo.refresh_rate     = x.vrate;
>  			ivideo.video_linelength = ivideo.video_vwidth * (ivideo.video_bpp >> 3);
>  			switch(ivideo.video_bpp) {
>          		case 8:
> @@ -1526,34 +1539,40 @@ static int sisfb_ioctl(struct inode *ino
>  			break;
>  		}
>  	   case FBIOGET_DISPINFO:
> -		sis_dispinfo((struct ap_data *)arg);
> +		sis_dispinfo(&ap);
> +		if (copy_to_user((void *)arg, &ap, sizeof(ap)))
> +			return -EFAULT;
>  		break;
>  	   case SISFB_GET_INFO:  /* TW: New for communication with X driver */
>  	        {
> -			sisfb_info *x = (sisfb_info *)arg;
> +			sisfb_info x;
>  
> -			x->sisfb_id = SISFB_ID;
> -			x->sisfb_version = VER_MAJOR;
> -			x->sisfb_revision = VER_MINOR;
> -			x->sisfb_patchlevel = VER_LEVEL;
> -			x->chip_id = ivideo.chip_id;
> -			x->memory = ivideo.video_size / 1024;
> -			x->heapstart = ivideo.heapstart / 1024;
> -			x->fbvidmode = sisfb_mode_no;
> -			x->sisfb_caps = sisfb_caps;
> -			x->sisfb_tqlen = 512; /* yet unused */
> -			x->sisfb_pcibus = ivideo.pcibus;
> -			x->sisfb_pcislot = ivideo.pcislot;
> -			x->sisfb_pcifunc = ivideo.pcifunc;
> -			x->sisfb_lcdpdc = sisfb_detectedpdc;
> -			x->sisfb_lcda = sisfb_detectedlcda;
> +			x.sisfb_id = SISFB_ID;
> +			x.sisfb_version = VER_MAJOR;
> +			x.sisfb_revision = VER_MINOR;
> +			x.sisfb_patchlevel = VER_LEVEL;
> +			x.chip_id = ivideo.chip_id;
> +			x.memory = ivideo.video_size / 1024;
> +			x.heapstart = ivideo.heapstart / 1024;
> +			x.fbvidmode = sisfb_mode_no;
> +			x.sisfb_caps = sisfb_caps;
> +			x.sisfb_tqlen = 512; /* yet unused */
> +			x.sisfb_pcibus = ivideo.pcibus;
> +			x.sisfb_pcislot = ivideo.pcislot;
> +			x.sisfb_pcifunc = ivideo.pcifunc;
> +			x.sisfb_lcdpdc = sisfb_detectedpdc;
> +			x.sisfb_lcda = sisfb_detectedlcda;
> +			if (copy_to_user((void *)arg, &x, sizeof(x)))
> +				return -EFAULT;
>  	                break;
>  		}
>  	   case SISFB_GET_VBRSTATUS:
>  	        {
>  			unsigned long *vbrstatus = (unsigned long *) arg;
> -			if(sisfb_CheckVBRetrace()) *vbrstatus = 1;
> -			else		           *vbrstatus = 0;
> +			if(sisfb_CheckVBRetrace())  {
> +				return put_user(1UL, vbrstatus);
> +			else		           
> +				return put_user(0UL, vbrstatus);
>  		}
>  	   default:
>  		return -EINVAL;
> 
> _
> 


-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org



