Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUETQA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUETQA4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 12:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUETQAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 12:00:55 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:49932 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265137AbUETQAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 12:00:11 -0400
Date: Thu, 20 May 2004 17:00:01 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: David Eger <eger@havoc.gtf.org>
cc: Andrew Morton <akpm@osdl.org>, David Eger <eger@theboonies.us>,
       <linux-fbdev-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] James' fbcon init and con2fb cleanup
In-Reply-To: <20040520155439.GA17330@havoc.gtf.org>
Message-ID: <Pine.LNX.4.44.0405201659210.9364-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm going to be sending these patch's very shortly to Andrew. I'm 
preparing the tree for him still.


On Thu, 20 May 2004, David Eger wrote:

> 
> James' patch to fix up the fbcon initialization sequence:
>  fixes con2fb initialization
> 
> 
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2004/05/15 21:42:23+02:00 eger@rosencrantz.theboonies.us 
> #   fbcon initialization cleanup; No more calling fb_console_init twice. 
> #   - James Simmons
> # 
> # drivers/video/fbmem.c
> #   2004/05/15 21:36:32+02:00 eger@rosencrantz.theboonies.us +2 -2
> #   fb con init cleanup
> # 
> # drivers/video/console/fbcon.h
> #   2004/05/15 21:36:32+02:00 eger@rosencrantz.theboonies.us +1 -1
> #   fix con2fb API
> # 
> # drivers/video/console/fbcon.c
> #   2004/05/15 21:36:31+02:00 eger@rosencrantz.theboonies.us +21 -28
> #   fbcon init cleanup:
> #    factor out retrieving the vc_data from the fbcon_event_notify path
> #    remove fbcon_event_notifier_registered cruft
> #    cleanup/fix con2fb code
> # 
> diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
> --- a/drivers/video/console/fbcon.c	Sat May 15 22:54:19 2004
> +++ b/drivers/video/console/fbcon.c	Sat May 15 22:54:19 2004
> @@ -296,15 +296,17 @@
>   *	Maps a virtual console @unit to a frame buffer device
>   *	@newidx.
>   */
> -int set_con2fb_map(int unit, int newidx)
> +int set_con2fb_map(int start, int end, int newidx)
>  {
> -	struct vc_data *vc = vc_cons[unit].d;
> +	struct vc_data *vc = vc_cons[start].d;
> +	int i;
>  
>  	if (!vc)
>  		return -ENODEV;
> -	con2fb_map[unit] = newidx;
> +	for (i = start; i < end; i++)
> +		con2fb_map[i] = newidx;
>  	fbcon_is_default = (vc->vc_sw == &fb_con) ? 1 : 0;
> -	return take_over_console(&fb_con, unit, unit, fbcon_is_default);
> +	return take_over_console(&fb_con, start, end, fbcon_is_default);
>  }
>  
>  /*
> @@ -2203,34 +2205,32 @@
>  	return 0;
>  }
>  
> -static void fbcon_suspended(struct fb_info *info)
> +static void fbcon_suspended(struct fb_info *info, struct vc_data *vc)
>  {
>  	/* Clear cursor, restore saved data */
> -	info->cursor.enable = 0;
> -	info->fbops->fb_cursor(info, &info->cursor);
> +	fbcon_cursor(vc, CM_ERASE);
>  }
>  
> -static void fbcon_resumed(struct fb_info *info)
> +static void fbcon_resumed(struct fb_info *info, struct vc_data *vc)
>  {
> -	struct vc_data *vc;
> -
> -	if (info->currcon < 0)
> -		return;
> -	vc = vc_cons[info->currcon].d;
> -
>  	update_screen(vc->vc_num);
>  }
>  static int fbcon_event_notify(struct notifier_block *self, 
>  			      unsigned long action, void *data)
>  {
>  	struct fb_info *info = (struct fb_info *) data;
> +	struct vc_data *vc;
> +
> +	if (info->currcon < 0)
> +		return 0;
> +	vc = vc_cons[info->currcon].d;
>  
>  	switch(action) {
>  	case FB_EVENT_SUSPEND:
> -		fbcon_suspended(info);
> +		fbcon_suspended(info, vc);
>  		break;
>  	case FB_EVENT_RESUME:
> -		fbcon_resumed(info);
> +		fbcon_resumed(info, vc);
>  		break;
>  	}
>  	return 0;
> @@ -2265,12 +2265,14 @@
>  	.notifier_call	= fbcon_event_notify,
>  };
>  
> -static int fbcon_event_notifier_registered;
> -
>  int __init fb_console_init(void)
>  {
>  	int err;
>  
> +	acquire_console_sem();
> +	fb_register_client(&fbcon_event_notifer);
> +	release_console_sem();
> +
>  	if (!num_registered_fb)
>  		return -ENODEV;
>  
> @@ -2281,12 +2283,6 @@
>  	if (err)
>  		return err;
>  
> -	acquire_console_sem();
> -	if (!fbcon_event_notifier_registered) {
> -		fb_register_client(&fbcon_event_notifer);
> -		fbcon_event_notifier_registered = 1;
> -	} 
> -	release_console_sem();
>  	return 0;
>  }
>  
> @@ -2289,10 +2285,7 @@
>  void __exit fb_console_exit(void)
>  {
>  	acquire_console_sem();
> -	if (fbcon_event_notifier_registered) {
> -		fb_unregister_client(&fbcon_event_notifer);
> -		fbcon_event_notifier_registered = 0;
> -	}
> +	fb_unregister_client(&fbcon_event_notifer);
>  	release_console_sem();
>  	give_up_console(&fb_con);
>  }	
> diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
> --- a/drivers/video/console/fbcon.h	Sat May 15 22:54:19 2004
> +++ b/drivers/video/console/fbcon.h	Sat May 15 22:54:19 2004
> @@ -38,7 +38,7 @@
>  
>  /* drivers/video/console/fbcon.c */
>  extern char con2fb_map[MAX_NR_CONSOLES];
> -extern int set_con2fb_map(int unit, int newidx);
> +extern int set_con2fb_map(int start, int end, int newidx);
>  
>      /*
>       *  Attribute Decoding
> diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> --- a/drivers/video/fbmem.c	Sat May 15 22:54:19 2004
> +++ b/drivers/video/fbmem.c	Sat May 15 22:54:19 2004
> @@ -1096,9 +1096,9 @@
>  		if (!registered_fb[con2fb.framebuffer])
>  		    return -EINVAL;
>  		if (con2fb.console != 0)
> -			set_con2fb_map(con2fb.console-1, con2fb.framebuffer);
> +			set_con2fb_map(con2fb.console-1, con2fb.console-1, con2fb.framebuffer);
>  		else
> -			fb_console_init();		
> +			set_con2fb_map(0, MAX_NR_CONSOLES, con2fb.framebuffer);
>  		return 0;
>  #endif	/* CONFIG_FRAMEBUFFER_CONSOLE */
>  	case FBIOBLANK:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

