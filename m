Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbSLGSEt>; Sat, 7 Dec 2002 13:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSLGSEt>; Sat, 7 Dec 2002 13:04:49 -0500
Received: from gull.mail.pas.earthlink.net ([207.217.120.84]:5563 "EHLO
	gull.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S264610AbSLGSEs>; Sat, 7 Dec 2002 13:04:48 -0500
Date: Sat, 7 Dec 2002 11:05:23 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Antonino Daplas <adaplas@pol.net>
cc: Tobias Rittweiler <inkognito.anonym@uni.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: Re[2]: [STATUS] fbdev api.
In-Reply-To: <1039256356.1066.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0212071058230.8383-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff -Naur linux-2.5.50-js/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
> --- linux-2.5.50-js/drivers/video/console/fbcon.c	2002-12-07 10:10:40.000000000 +0000
> +++ linux/drivers/video/console/fbcon.c	2002-12-07 10:12:11.000000000 +0000
> @@ -357,7 +357,7 @@
>  	area.dx = dx * vc->vc_font.width;
>  	area.dy = dy * vc->vc_font.height;
>  	area.height = height * vc->vc_font.height;
> -	area.width = width * vc->vc_font.height;
> +	area.width = width * vc->vc_font.width;
>
>  	info->fbops->fb_copyarea(info, &area);
>  }

Ug!!! A nasty typo. Thanks.

> @@ -1987,12 +1993,9 @@
>  		else
>  			update_screen(vc->vc_num);
>  		return 0;
> -	} else {
> -		/* Tell console.c that it has to restore the screen itself */
> -		return 1;
> -	}
> -	fb_blank(blank, info);
> -	return 0;
> +	}
> +	else
> +		return info->fbops->fb_blank(blank, info);
>  }

Hm. I have something similiar. That code needs to be cleaned up.

> Tony
>
> PS: James, can you also apply the following riva cleanup patch.  It
> fixes compile failures as well as removal of unused defines and
> declarations.

Most of those fixes I already have in BK. I think yres_virtual being
set to -1 is wrong. Also do we really need to call check var? The default
mode is "trusted". Also fb_find_mode when we use it calls check_var.
default_var already has the correct virtual res info. We do need to set
fix tho :-)  Thanks for the fixes.

@@ -1566,6 +1540,16 @@
                fb_find_mode(&info->var, info, mode_option,
                             NULL, 0, NULL, 8);
 #endif
+
+       info->var.yres_virtual = -1;
+       info->var.xres_virtual = info->var.xres;
+       if (rivafb_check_var(&info->var, info))
+               return 1;
+
+       info->fix.line_length = (info->var.xres_virtual * (info->var.bits_per_pi
+       info->fix.visual = (info->var.bits_per_pixel == 8) ?
+                               FB_VISUAL_PSEUDOCOLOR :
FB_VISUAL_DIRECTCOLOR;
+
        return 0;


MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net


