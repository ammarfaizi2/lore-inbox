Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965039AbWEBXWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWEBXWk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 19:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWEBXWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 19:22:39 -0400
Received: from pproxy.gmail.com ([64.233.166.182]:53698 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965039AbWEBXWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 19:22:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ZXxQ1fNI0ycrU4wk+e86IElpzBr4pgULe63kgjG9RhWoZcRk7wV8cXyrag4fenezF9heqGXL6WmI98UImiHiIm4Co85xjtfQWMm3APbg21FoMy70oJx3th4dKB3pVrz3prpkMmk2IfkdJJ98Gx/02vYQd5QWCrpUZ5UQ5vtJzqQ=
Message-ID: <4457E9B2.7090305@gmail.com>
Date: Wed, 03 May 2006 07:22:26 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org, david.hollister@amd.com,
       jordan.crouse@amd.com
Subject: Re: [Linux-fbdev-devel] [PATCH] vt: Delay the update of the visible
 framebuffer console
References: <20060502231239.GB23644@cosmic.amd.com>
In-Reply-To: <20060502231239.GB23644@cosmic.amd.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse wrote:
> This is a patch that delays updating the visible framebuffer console
> until the other consoles have been initialized in order to avoid losing
> output lines.  This problem was discovered when loading a framebuffer driver
> as a module.  Comments welcome.
> 
> Jordan
> 
> 
> ------------------------------------------------------------------------
> 
> [PATCH] vt:  Delay the update of the visible framebuffer console
> 
> From: David Hollister <david.hollister@amd.com>
> 
> This patch delays the update of the visible framebuffer console until
> all other consoles have been initialized in order to avoid losing
> information.  This only seems to be a problem with modules, not with
> built-in drivers.

Looks okay except for one point...

> 
> Signed-off-by: David Hollister <david.hollister@amd.com>
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> ---
> 
>  drivers/char/vt.c |   22 ++++++++++++++--------
>  1 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/vt.c b/drivers/char/vt.c
> index acc5d47..30f0f24 100644
> --- a/drivers/char/vt.c
> +++ b/drivers/char/vt.c
> @@ -2700,9 +2700,11 @@ int take_over_console(const struct consw
>  		if (!vc || !vc->vc_sw)
>  			continue;
>  
> -		j = i;
> -		if (CON_IS_VISIBLE(vc))
> +		if (CON_IS_VISIBLE(vc)) {
> +			j = i;
>  			save_screen(vc);
> +		}
> +
>  		old_was_color = vc->vc_can_do_color;
>  		vc->vc_sw->con_deinit(vc);
>  		vc->vc_origin = (unsigned long)vc->vc_screenbuf;
> @@ -2718,17 +2720,21 @@ int take_over_console(const struct consw
>  		 */
>  		if (old_was_color != vc->vc_can_do_color)
>  			clear_buffer_attributes(vc);
> -
> -		if (CON_IS_VISIBLE(vc))
> -			update_screen(vc);
>  	}
> +
>  	printk("Console: switching ");
>  	if (!deflt)
>  		printk("consoles %d-%d ", first+1, last+1);
> -	if (j >= 0)
> +	if (j >= 0) {
> +		struct vc_data *vc = vc_cons[j].d;
> +
>  		printk("to %s %s %dx%d\n",
> -		       vc_cons[j].d->vc_can_do_color ? "colour" : "mono",
> -		       desc, vc_cons[j].d->vc_cols, vc_cons[j].d->vc_rows);
> +		       vc->vc_can_do_color ? "colour" : "mono",
> +		       desc, vc->vc_cols, vc->vc_rows);
> +
> +		if (CON_IS_VISIBLE(vc))
> +			update_screen(vc);
> +	}
>  	else
>  		printk("to %s\n", desc);

If take_over_console() is called with parameter first = 0, last = 4, and
the visible console = 5, you get here instead...

Tony


