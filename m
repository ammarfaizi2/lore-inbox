Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265169AbUD3SCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbUD3SCf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265171AbUD3SCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:02:34 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:39441 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265169AbUD3SCa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:02:30 -0400
Message-ID: <409295D1.6070609@techsource.com>
Date: Fri, 30 Apr 2004 14:07:13 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Douglas Mayle <douglas@mayle.org>
CC: linux-kernel@vger.kernel.org, jsimmons@infradead.org, geert@linux-m68k.org,
       ajoshi@shell.unixbox.com, benh@kernel.crashing.org
Subject: Re: [PATCH] Framebuffer Layer - Radeonfb, kernel 2.6.5
References: <1083340507.8830.16.camel@doug64.sophia.metrixsystems.com>
In-Reply-To: <1083340507.8830.16.camel@doug64.sophia.metrixsystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One bug I've noticed with the 2.4 radeonfb driver is this:

If you specify a resolution different from what EDID reports, what you 
get on screen is the resolution reported by EDID physically, but 
virtually the resolution requested.  That is, if I ask for 1280x1024, 
but EDID says 1024x768, I see the upper left 1024x768 of the 1280x1024 
screen that the console is being displayed on.



Douglas Mayle wrote:
> I've written two small modifications, one to the frame buffer code, and
> one to the radeonfb driver.
> 
> In fbmem.c, I've added an error message for people who specify a video=
> line with an invalid device name to help users save on troubleshooting
> time.
> 
> In radeonfb_monitor.c the bpp attribute is completely ignored, and 8 is
> hardcoded in as a default.  I've changed the code to read the default
> bpp from the default mode.  (Most users will never notice the
> difference, but I changed the default mode, and was baffled as to why
> the color depth didn't change.)
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.5/drivers/video/fbmem.c	2004-04-30 15:02:10.000000000 +0200
> +++ patch/drivers/video/fbmem.c	2004-04-30 15:09:03.560390512 +0200
> @@ -1470,6 +1470,18 @@
>  	 * If we get here no fb was specified.
>  	 * We consider the argument to be a global video mode option.
>  	 */
> +
> +	if (strchr(options, ':') != NULL) {
> +		/*
> +		 * If a colon is in the string, then the user entered
> +		 * the wrong name for the fb device.  We'll inform them
> +		 * of this.
> +		 */
> +		int fbnamelen = strchr(options, ':') - options;
> +		options[fbnamelen] = '\0';
> +		printk ("Requested framebuffer device '%s' not found\n", options);
> +		options[fbnamelen] = ':';
> +	}
>  	global_mode_option = options;
>  	return 0;
>  }
> --- linux-2.6.5/drivers/video/aty/radeon_monitor.c	2004-04-30 15:02:10.000000000 +0200
> +++ patch/drivers/video/aty/radeon_monitor.c	2004-04-30 15:09:03.559390664 +0200
> @@ -854,12 +854,15 @@
>  	 */
>  	if (!has_default_mode || mode_option) {
>  		struct fb_videomode default_mode;
> +		unsigned int default_bpp = 8;
>  		if (has_default_mode)
>  			radeon_var_to_videomode(&default_mode, &rinfo->info->var);
> -		else
> +		else {
>  			radeon_var_to_videomode(&default_mode, &radeonfb_default_var);
> + 			default_bpp = radeonfb_default_var.bits_per_pixel;
> +		}
>  		if (fb_find_mode(&rinfo->info->var, rinfo->info, mode_option,
> -				 rinfo->mon1_modedb, rinfo->mon1_dbsize, &default_mode, 8) == 0)
> +				 rinfo->mon1_modedb, rinfo->mon1_dbsize, &default_mode, default_bpp) == 0)
>  			rinfo->info->var = radeonfb_default_var;
>  	}
>  

