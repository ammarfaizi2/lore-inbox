Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUAFQb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbUAFQb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:31:56 -0500
Received: from witte.sonytel.be ([80.88.33.193]:42231 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264538AbUAFQbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:31:44 -0500
Date: Tue, 6 Jan 2004 17:31:31 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] VT locking
In-Reply-To: <1073349182.9504.175.camel@gaston>
Message-ID: <Pine.GSO.4.58.0401061725250.5752@waterleaf.sonytel.be>
References: <1073349182.9504.175.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Benjamin Herrenschmidt wrote:
> --- linux-2.5/kernel/printk.c	2004-01-06 10:07:08.640948328 +1100
> +++ linuxppc-2.5-benh/kernel/printk.c	2003-12-31 17:01:25.000000000 +1100
> @@ -479,6 +493,9 @@
>  	char *p;
>  	static char printk_buf[1024];
>  	static int log_level_unknown = 1;
> +#ifdef CONFIG_BOOTX_TEXT
> +	extern int force_printk_to_btext;
> +#endif
>
>  	if (oops_in_progress) {
>  		/* If a crash is occurring, make sure we can't deadlock */
> @@ -494,6 +511,10 @@
>  	va_start(args, fmt);
>  	printed_len = vsnprintf(printk_buf, sizeof(printk_buf), fmt, args);
>  	va_end(args);
> +#ifdef CONFIG_BOOTX_TEXT
> +	if (force_printk_to_btext)
> +		btext_drawstring(printk_buf);
> +#endif /* CONFIG_BOOTX_TEXT */

Looks like a nice opportunity to introduce an arch-specific printk() stub:

    void *arch_printk(const char *args);

    if (arch_printk)
	arch_printk(printk_buf);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
