Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbTJYNnl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 09:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTJYNnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 09:43:41 -0400
Received: from gprs193-18.eurotel.cz ([160.218.193.18]:42368 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262560AbTJYNni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 09:43:38 -0400
Date: Sat, 25 Oct 2003 15:43:24 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Mock <kd6pag@qsl.net>, Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kill unneccessary debug printk [PATCH]
Message-ID: <20031025134324.GC330@elf.ucw.cz>
References: <E1ADIWJ-00012u-00@penngrove.fdns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ADIWJ-00012u-00@penngrove.fdns.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>     > Better yet, let's take this opportunity to do this more cleanly.  How 
>     > about having something like /sys/power/vmode (or /proc/...) contain that 
>     > inforemation instead?  With luck, it might even be few kernel bytes than
>     > the original printk (or at least not much more).  (I know nothing about
>     > either /proc or /sys, so it would take me awhile to suggest a patch).
> 
>     Well, you probably know about as much as I do. I'm afraid I'm just
>     going to take the easy way out.
> 								    Pavel
> 
> OK, then, here's a quick fix (perhaps someone else can refine it) which 
> reads back saved video mode via '/sys/power/gmode'.  Maybe someone else
> who understand mechanism better than i do can come up with some cleaner
> code to do the same thing (or at least find a better place to put this).
> Hopefully, i've at least picked the right CONFIG variable...


> Attachment: Patch to 2.6.0-test8-bk2
> -------------------------------------------------------------------------------
> --- ./kernel/power/disk.c.orig	2003-10-17 14:42:53.000000000 -0700
> +++ ./kernel/power/disk.c	2003-10-25 00:02:10.000000000 -0700
> @@ -326,10 +326,55 @@
>  	.attrs = g,
>  };
>  
> -
>  static int __init pm_disk_init(void)
>  {
>  	return sysfs_create_group(&power_subsys.kset.kobj,&attr_group);
>  }
>  
>  core_initcall(pm_disk_init);
> +
> +#ifdef CONFIG_VIDEO_SELECT
> +/*
> + *	gmode - report graphics mode
> + *
> + * In order for software suspend to succeed, the video mode must match that
> + * supplied via the console or from the kernel command line.  This provides
> + * an orderly means of retrieving that information (rather than grep'ing
> + * 'dmesg' at an appropriate time, as was the previous means of obtaining
> + * this datum).

What about /proc/cmdline? ... ... hmm, that does not work with
vga=ask, right?

> + *
> + * TO DO:  Make sure framebuffer code updates 'saved_videomode' if it is
> + *	   capable of changing the video mode ('vesafb' apparently cannot).


That TODO is meaningless... This only works with vesafb, and vesafb
can not change video modes by design. And with vgacon; but if you
change mode using SVGATextMode there's no way to find out if same mode
is available using vga=....

> + */
> +extern unsigned long saved_videomode;
> +
> +static ssize_t gmode_show(struct subsystem * subsys, char * buf)
> +{
> +	return sprintf(buf,"0x%lx\n",saved_videomode);
> +}
> +
> +static ssize_t gmode_store(struct subsystem * s, const char * buf, size_t n) {
> +	return -EINVAL;
> +}
> +
> +/* Probably should use some macro which makes 'gmode' read-only, since the
> +   above code didn't report an error when storing into /sys/prog/gmode */
> +power_attr(gmode);
> +
> +static struct attribute * g2[] = {
> +	&gmode_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group attr_group2 = {
> +	.attrs = g2,
> +};
> +
> +static int __init pm_gmode_init(void)
> +{
> +	return sysfs_create_group(&power_subsys.kset.kobj,&attr_group2);
> +}
> +
> +core_initcall(pm_gmode_init);
> +
> +#endif /* CONFIG_VIDEO_SELECT */

Otherwise it looks good. Can you try pushing it through Patrick
Mochel? [Cc-ed].
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
