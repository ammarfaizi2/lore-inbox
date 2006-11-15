Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162064AbWKOXaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162064AbWKOXaZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162065AbWKOXaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:30:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:8892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1162064AbWKOXaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:30:24 -0500
Date: Wed, 15 Nov 2006 15:29:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Tero Roponen <teanropo@jyu.fi>
Cc: linux-kernel@vger.kernel.org, Jordan Crouse <jordan.crouse@amd.com>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [PATCH -mm] fb: modedb uses wrong default_mode
Message-Id: <20061115152952.0e92c50d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 19:43:16 +0200 (EET)
Tero Roponen <teanropo@jyu.fi> wrote:

> 
> It seems that default_mode is always overwritten in
> fb_find_mode() if caller gives its own modedb; this
> patch should fix it.
> 
> dmesg diff before and after the following patch:
> 
>  neofb: mapped framebuffer at c4a80000
>  -Mode (640x400) won't display properly on LCD
>  -Mode (640x400) won't display properly on LCD
>  -neofb v0.4.2: 2048kB VRAM, using 640x480, 31.469kHz, 59Hz
>  -Console: switching to colour frame buffer device 80x30
>  +neofb v0.4.2: 2048kB VRAM, using 800x600, 37.878kHz, 60Hz
>  +Console: switching to colour frame buffer device 100x37
>   fb0: MagicGraph 128XD frame buffer device
> 
> Signed-off-by: Tero Roponen <teanropo@jyu.fi>
> ---
> 
> --- linux-2.6.19-rc5-mm2/drivers/video/modedb.c.orig	2006-11-15 19:03:03.000000000 +0200
> +++ linux-2.6.19-rc5-mm2/drivers/video/modedb.c	2006-11-15 19:02:57.000000000 +0200
> @@ -507,7 +507,7 @@ int fb_find_mode(struct fb_var_screeninf
>      }
>      if (!default_mode && db != modedb)
>  	default_mode = &db[0];
> -    else
> +    else if (!default_mode)
>  	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
>  
>      if (!default_bpp)

Sigh.

2.6.19-rc5 has:

    if (!default_mode)
	default_mode = &modedb[DEFAULT_MODEDB_INDEX];

and Jordan changed it to

    if (!default_mode && db != modedb)
	default_mode = &db[0];
    else
	default_mode = &modedb[DEFAULT_MODEDB_INDEX];

and you want to change it to

    if (!default_mode && db != modedb)
	default_mode = &db[0];
    else if (!default_mode)
	default_mode = &modedb[DEFAULT_MODEDB_INDEX];

which is actually a complicated way of doing

    if (!default_mode)
	default_mode = &db[DEFAULT_MODEDB_INDEX];

So let's do that.
