Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbVLJG1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbVLJG1b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 01:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbVLJG1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 01:27:31 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:2742 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932331AbVLJG1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 01:27:30 -0500
Message-ID: <439A7585.6050600@t-online.de>
Date: Sat, 10 Dec 2005 07:28:21 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Knut Petersen <Knut_Petersen@t-online.de>
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/1 2.6.15-rc4-git1] Fix switching to KD_TEXT
References: <4398B888.50005@t-online.de>
In-Reply-To: <4398B888.50005@t-online.de>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bKbWhsZJ8e87oTpL8HRGCxMm15JZvzhe-YrpJMPSOcQPXVIV7qA24r@t-dialin.net
X-TOI-MSGID: c76bc1c5-c1ce-44d6-83cb-6971134b2c56
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please do forget about that patch I sent to you some days ago. An 
enhanced version
will follow soon.

cu,
 knut

Knut Petersen schrieb:

>  Every framebuffer driver relies on the assumption that the set_par() 
> function
> of the driver is called before drawing functions and other functions 
> dependent
> on the hardware state are executed.
>
> This assumption is false in two cases, and one is a genuine linux
> bug:
>
>    1: Whenever you switch from X to a framebuffer console for the very
>        first time, there is a chance that a broken X system has _not_ set
>        the mode to KD_GRAPHICS, thus the vt and framebuffer code
>        executes a screen redraw and several other functions before a
>        set_par() is executed. This is believed to be not a bug of linux
>        but a bug of X/xdm.
>
>    2: Whenever a switch from X to a framebuffer console occures,
>         the pan_display() function of the driver is called once before
>         the set_par() function of the driver is called. Code path:
>         complete_change_console -> redraw_screen -> fbcon_switch ->
>         bit_update_start-> fb_pan_display -> xyz_pan_display.
>         This is clearly a bug of linux.
>
> Although our primary goal must be to fix linux bugs and not to work
> around bugs of X, the patch fixes both of the cases.
>
> The advantage and correctness of this patch should be obvious. Yes, it
> does add a possibly slow call to the fb_set_par() function, but at this
> point it is necessary.
>
> Signed-off-by: Knut Petersen <Knut_Petersen@t-online.de>
>
>
> diff -uprN -X linux/Documentation/dontdiff -x '*.bak' -x '*.ctx' 
> linuxorig/drivers/video/console/fbcon.c 
> linux/drivers/video/console/fbcon.c
> --- linuxorig/drivers/video/console/fbcon.c    2005-12-02 
> 12:18:04.000000000 +0100
> +++ linux/drivers/video/console/fbcon.c    2005-12-06 
> 09:06:56.000000000 +0100
> @@ -2103,10 +2103,11 @@ static int fbcon_switch(struct vc_data *
>     fb_set_var(info, &var);
>     ops->var = info->var;
>
> -    if (old_info != NULL && old_info != info) {
> -        if (info->fbops->fb_set_par)
> -            info->fbops->fb_set_par(info);
> +    if (old_info != NULL && old_info != info)
>         fbcon_del_cursor_timer(old_info);
> +
> +    if (info->fbops->fb_set_par) {
> +        info->fbops->fb_set_par(info);
>         fbcon_add_cursor_timer(info);
>     }
>
>
>

