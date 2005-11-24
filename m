Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbVKXIuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbVKXIuO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 03:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbVKXIuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 03:50:13 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:61770 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161055AbVKXIuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 03:50:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OR0d7t3AsedDV6C/5Ri2KkiMKyWtUCUWibhynFiT8kY5hnrIYR5M9oXVQlPbi1rgSvm/YwEKcZ/fiZqIsPAnOruoSWQaAoliLDcrkj7A1SHpuZF6W5WLPbHXpwluN3Uu39LIgSSI3MkkV9uIi7O/unkRQBcfOddBHdLE/YpnbI0=
Message-ID: <43857E8B.4090004@gmail.com>
Date: Thu, 24 Nov 2005 16:49:15 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Nathan Cline <nathan.cline@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch to framebuffer
References: <656113ee0511232208n6948c364ke6103b3ef0a54f@mail.gmail.com>
In-Reply-To: <656113ee0511232208n6948c364ke6103b3ef0a54f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Cline wrote:
> --- fbcon.c	2005-11-23 23:49:10.000000000 -0600
> +++ fbcon.c.mine	2005-11-23 23:12:16.000000000 -0600
> @@ -390,12 +390,15 @@
>  	int mode;
>  
>  	if (ops->currcon != -1)
> -		vc = vc_cons[ops->currcon].d;
> +		vc = ops->currcon_ptr; 

As mentioned in the other thread, you don't need ops->currcon_ptr.
vc_cons[ops->currcon].d should give you the same results.

>  
> -	if (!vc || !CON_IS_VISIBLE(vc) ||
> +	if (!vc)
> +		return;
> +
> +	if (!CON_IS_VISIBLE(vc) ||
>  	    fbcon_is_inactive(vc, info) ||
>   	    registered_fb[con2fb_map[vc->vc_num]] != info ||
> -	    vc_cons[ops->currcon].d->vc_deccm != 1)
> +	    vc->vc_deccm != 1)
>  		return;
>  	acquire_console_sem();
>  	p = &fb_display[vc->vc_num];
> @@ -753,6 +756,7 @@
>  	struct fbcon_ops *ops = info->fbcon_par;
>  
>  	ops->currcon = fg_console;
> +	ops->currcon_ptr = vc_cons[fg_console].d;

no need

>  
>  	if (info->fbops->fb_set_par && !(ops->flags & FBCON_FLAGS_INIT))
>  		info->fbops->fb_set_par(info);
> @@ -766,7 +770,7 @@
>  		fbcon_preset_disp(info, &info->var, unit);
>  
>  	if (show_logo) {
> -		struct vc_data *fg_vc = vc_cons[fg_console].d;
> +		struct vc_data *fg_vc = ops->currcon_ptr;

or *fg_vc = vc_cons[ops->currcon].d

>  		struct fb_info *fg_info =
>  			registered_fb[con2fb_map[fg_console]];
>  
> @@ -775,7 +779,7 @@
>  				   fg_vc->vc_rows);
>  	}
>  
> -	update_screen(vc_cons[fg_console].d);
> +	update_screen(ops->currcon_ptr);

similarly, update_screen(vc_cons[ops->currcon].d);

>  }
>  
>  /**
> @@ -929,6 +933,7 @@
>  
>  	memset(ops, 0, sizeof(struct fbcon_ops));
>  	ops->currcon = -1;
> +	ops->currcon_ptr = NULL;

no need.

>  	ops->graphics = 1;
>  	ops->cur_rotate = -1;
>  	info->fbcon_par = ops;
> @@ -1055,6 +1060,15 @@
>  	    return;
>  
>  	cap = info->flags;
> +	ops = info->fbcon_par;
> +
> +	if (ops->currcon == -1)
> +	{
> +		ops->currcon = vc->vc_num;
> +		ops->currcon_ptr = vc;

no need for the last line.

> +	}
> +
> +	vc->vc_display_fg = &(ops->currcon_ptr);
>  
>  	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
>  	    (info->fix.type == FB_TYPE_TEXT))
> @@ -1091,7 +1105,6 @@
>  	if (!*vc->vc_uni_pagedir_loc)
>  		con_copy_unimap(vc, svc);
>  
> -	ops = info->fbcon_par;
>  	p->con_rotate = rotate;
>  	set_blitting_type(vc, info, NULL);
>  
> @@ -1296,6 +1309,8 @@
>  	struct fbcon_ops *ops = info->fbcon_par;
>  	int rows, cols, charcnt = 256;
>  
> +	vc->vc_display_fg = &(ops->currcon_ptr);
> +	

or vc->vc_display_fg = &vc_cons[ops->currcon].d;

>  	if (var_to_display(p, var, info))
>  		return;
>  	t = &fb_display[svc->vc_num];
> @@ -2048,7 +2063,7 @@
>  	struct fbcon_ops *ops;
>  	struct display *p = &fb_display[vc->vc_num];
>  	struct fb_var_screeninfo var;
> -	int i, prev_console;
> +	int prev_console;
>  
>  	info = registered_fb[con2fb_map[vc->vc_num]];
>  	ops = info->fbcon_par;
> @@ -2073,21 +2088,10 @@
>  	prev_console = ops->currcon;
>  	if (prev_console != -1)
>  		old_info = registered_fb[con2fb_map[prev_console]];
> -	/*
> -	 * FIXME: If we have multiple fbdev's loaded, we need to
> -	 * update all info->currcon.  Perhaps, we can place this
> -	 * in a centralized structure, but this might break some
> -	 * drivers.
> -	 *
> -	 * info->currcon = vc->vc_num;
> -	 */
> -	for (i = 0; i < FB_MAX; i++) {
> -		if (registered_fb[i] != NULL && registered_fb[i]->fbcon_par) {
> -			struct fbcon_ops *o = registered_fb[i]->fbcon_par;
>  
> -			o->currcon = vc->vc_num;
> -		}
> -	}

This hunk is the actual culprit why fbcon is behaving like it is :-)

> +	ops->currcon = vc->vc_num;
> +	ops->currcon_ptr = vc;
> +	
>  	memset(&var, 0, sizeof(struct fb_var_screeninfo));
>  	display_to_var(&var, p);
>  	var.activate = FB_ACTIVATE_NOW;
> @@ -2103,13 +2107,6 @@
>  	fb_set_var(info, &var);
>  	ops->var = info->var;
>  
> -	if (old_info != NULL && old_info != info) {
> -		if (info->fbops->fb_set_par)
> -			info->fbops->fb_set_par(info);

Don't remove the above hunk.  It's possible to have multiple fb_info's
(ie vga16fb, vesafb, xxxfb) driving the same hardware.  This gives
the driver a chance to initialize the hardware when it's their turn
to take over.
 
> -		fbcon_del_cursor_timer(old_info);
> -		fbcon_add_cursor_timer(info);
> -	}
> -

The above is safe to remove.

>  	set_blitting_type(vc, info, p);
>  	ops->cursor_reset = 1;
>  
> @@ -2691,7 +2688,7 @@
>  
>  	if (!ops || ops->currcon < 0)
>  		return;
> -	vc = vc_cons[ops->currcon].d;
> +	vc = ops->currcon_ptr;

Again, equivalent.

>  
>  	/* Clear cursor, restore saved data */
>  	fbcon_cursor(vc, CM_ERASE);
> @@ -2704,7 +2701,7 @@
>  
>  	if (!ops || ops->currcon < 0)
>  		return;
> -	vc = vc_cons[ops->currcon].d;
> +	vc = ops->currcon_ptr; 

equivalent

>  
>  	update_screen(vc);
>  }
> @@ -2718,7 +2715,7 @@
>  
>  	if (!ops || ops->currcon < 0)
>  		return;
> -	vc = vc_cons[ops->currcon].d;
> +	vc = ops->currcon_ptr; 

equivalent

>  	if (vc->vc_mode != KD_TEXT ||
>  	    registered_fb[con2fb_map[ops->currcon]] != info)
>  		return;
> @@ -2841,7 +2838,7 @@
>  	if (!ops || ops->currcon < 0)
>  		return;
>  
> -	vc = vc_cons[ops->currcon].d;
> +	vc = ops->currcon_ptr; 

equivalent

>  	if (vc->vc_mode != KD_TEXT ||
>  			registered_fb[con2fb_map[ops->currcon]] != info)
>  		return;
> 
> 
> ------------------------------------------------------------------------
> 
> --- fbcon.h	2005-11-23 23:49:10.000000000 -0600
> +++ fbcon.h.mine	2005-11-23 23:46:07.000000000 -0600
> @@ -73,6 +73,7 @@
>  	struct fb_cursor cursor_state;
>  	struct display *p;
>          int    currcon;	                /* Current VC. */
> +	struct vc_data *currcon_ptr;

No need for currcon_ptr.

Tony
