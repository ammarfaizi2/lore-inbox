Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315726AbSECVrn>; Fri, 3 May 2002 17:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315727AbSECVrm>; Fri, 3 May 2002 17:47:42 -0400
Received: from www.transvirtual.com ([206.14.214.140]:2057 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S315726AbSECVrl>; Fri, 3 May 2002 17:47:41 -0400
Date: Fri, 3 May 2002 14:47:14 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Antonino Daplas <adaplas@pol.net>
cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] Comments on fbgen.c and fbcon-accel.c
In-Reply-To: <1020419481.724.0.camel@daplas>
Message-ID: <Pine.LNX.4.10.10205031444260.9732-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a few observations on fbgen and fbcon-accel.

Don't mix fbgen with fbcon-accel. The new gen_* stuff in fbgen.c is meant
to replace the old fbgen_* stuff. That is why the below doesn't work.
 
> 1.  fbcon_accel_clear_margins may not work correctly with fbgen since
> fbcon_accel will use the xoffset and yoffset values from info->var.  
> 
>     void fbcon_accel_clear_margins(struct vc_data *vc, struct display
>     *p,
>     			       int bottom_only)
>     {
>     	<<<snip>>> 
>     
>     	if (bh) {
>     		region.dx = info->var.xoffset;
>                     region.dy = info->var.yoffset + bs;
>                     region.width  = rs;
>                     region.height = bh;
>     		info->fbops->fb_fillrect(info, &region);
>     	}
>     }
> 
> However fbgen_pan_display updates the xoffset and yoffset in
> fb_display[con].var. So margins don't get cleared if the driver supports
> y-panning or y-wrapping.
> 
>     int fbgen_pan_display(struct fb_var_screeninfo *var, int con,
>     		      struct fb_info *info)
>     {
>     	<<< snip >>>
>     
>         if (con == info->currcon) {
>     	if (fbhw->pan_display) {
>     	    if ((err = fbhw->pan_display(var, info2)))
>     		return err;
>     	} else
>     	    return -EINVAL;
>         }
>         fb_display[con].var.xoffset = var->xoffset;
>         fb_display[con].var.yoffset = var->yoffset;
>     
>     	<<< snip >>>
>     }

> 2. Also, fbgen_switch basically just do an fbgen_do_set_var()
> (decode_var(), followed by set_par()).  This is okay most times, but
> it's probably better if fbgen_switch also does an encode_fix() since
> fbcon's drawing functions also rely on fix->line_length.

Most likely that is also broken. I haven't thought about it since I plan
to make all the old fbgen_* functions go away.

> If an fb_fix_screeninfo is not updated, display corruption occurs when
> switching to another display with a different pixelformat.

Correct. That is why I require info->fix to be updated when set_par is
called.


