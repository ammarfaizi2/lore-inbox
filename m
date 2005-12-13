Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVLMWVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVLMWVh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbVLMWVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:21:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030280AbVLMWVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:21:22 -0500
Date: Tue, 13 Dec 2005 14:20:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: adaplas@gmail.com, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and updated CyblaFB
Message-Id: <20051213142054.4fd59226.akpm@osdl.org>
In-Reply-To: <439EF4CB.8030007@t-online.de>
References: <439EF4CB.8030007@t-online.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen <Knut_Petersen@t-online.de> wrote:
>
> With kernel 2.6.15-rc5-git3 all patches needed by this new version
> of cyblafb reached the main line kernel. So here it is.
> 
> Main advantages:
> ============
>    - vxres > xres support
>    - ywrap support
>    - much faster for almost all modes (e.g. 1280x1024-16bpp
>       draws more than 41 full screens of text instead of about 25
>       full screens of text per second on authors Epia 5000)
>    - module init/exit code fixed
>    - bugs triggered by console rotation fixed
>    - lots of minor improvements
>    - startup modes suitable for high performance scrolling
>       in all directions
> 
> As only one single graphics core is affected, there should be no
> reason not to include it in 2.6.15. No side effects are possible.

Well yes, but effects on cyblafb are possible!  We'd be putting new and
un-tested-in-linus's-tree code into the tree at the last minute.

It would hardly be a calamity if we were to merge this into 2.6.15 of
course, but the principle which you describe ain't right.

> +static int basestride = 0;

That consumes storage in vmlinux or cylbafb.ko.  I'll remove the `= 0'.

> -	int direction;
> -
> -	s1 = point(ca->sx,ca->sy);
> -	s2 = point(ca->sx+ca->width-1,ca->sy+ca->height-1);
> -	d1 = point(ca->dx,ca->dy);
> -	d2 = point(ca->dx+ca->width-1,ca->dy+ca->height-1);
> -	if ((ca->sy > ca->dy) || ((ca->sy == ca->dy) && (ca->sx > ca->dx)))
> -		direction = 0;
> -	else
> -		direction = 2;
> -
> -	cyblafb_sync(info);
> +        __u32 s1,s2,d1,d2;
> +        int direction;
>  
> -	out32(GE44,0xa0000000|1<<19|1<<2|direction);
> -	out32(GE00,direction?s2:s1);
> -	out32(GE04,direction?s1:s2);
> -	out32(GE08,direction?d2:d1);
> -	out32(GE0C,direction?d1:d2);
> +        s1 = point(ca->sx,0);
> +        s2 = point(ca->sx+ca->width-1,ca->height-1);
> +        d1 = point(ca->dx,0);
> +        d2 = point(ca->dx+ca->width-1,ca->height-1);
> +
> +        if ((ca->sy > ca->dy) || ((ca->sy == ca->dy) && (ca->sx > ca->dx)))
> +                direction = 0;
> +        else
> +                direction = 2;
> +
> +	out32(GEB8,basestride | ((ca->dy * info->var.xres_virtual *
> +				info->var.bits_per_pixel) >> 6));
> +	out32(GEC8,basestride | ((ca->sy * info->var.xres_virtual *
> +				info->var.bits_per_pixel) >> 6 ));
> +        out32(GE44,0xa0000000|1<<19|1<<2|direction);
> +        out32(GE00,direction?s2:s1);
> +        out32(GE04,direction?s1:s2);
> +        out32(GE08,direction?d2:d1);
> +        out32(GE0C,direction?d1:d2);

The above hunk is full of whitespace damage (spaces instead of tabs).  I
fixed that, and other places like it.

> -			index+=3;
> -			break;
> +	if (likely(info->pixmap.scan_align == 4)) {
> +		int dds = ((image->width + 31) >> 5) * image->height;
> +		while (dds--)
> +			out32(GE9C,*pd++);
> +	} else {
> +		int i, j, dds = image->width / 32, bits = image->width % 32;
> +		for (i=0; i<image->height; i++) {
> +			for (j=0; j<dds; j++)
> +				out32(GE9C, *pd++);
> +			if(bits != 0) {
> +				out32(GE9C, *pd);
> +				if (info->pixmap.scan_align == 2)
> +					pd = (u32*)((u32) pd +
> +						(((bits + 15) >> 4) << 1) );
> +				else
> +					pd = (u32*)((u32) pd +
> +						((bits + 7) >> 3));
> +			}

Masking pointers to 32 bits.  Is this driver supposed to be run on 64-bit
machines?

> +	info->pixmap.addr = kmalloc(CYBLAFB_PIXMAPSIZE, GFP_KERNEL);
> +	if (!info->pixmap.addr) {
> +		output("allocation of pixmap buffer failed!\n");
> +		goto errout_alloc_pixmap;
> +	}
> +	memset(info->pixmap.addr, 0, CYBLAFB_PIXMAPSIZE);

I'll switch this to kzalloc().


