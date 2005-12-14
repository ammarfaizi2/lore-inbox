Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbVLNPIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbVLNPIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 10:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVLNPIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 10:08:30 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:26770 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964787AbVLNPI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 10:08:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=auTxnfS9qxOsK2xTPta16jq7baGSOErxvu3n84I0KYf/z/YRP578UKCvCACW5LwhnPiTv8Z3QIFeB9SqPK0HQMpnQQhOZSBH/3gEoMGTykt2BCijjACcOR4nq9aHMPOp4F6InBBDd/mMIQ3vIYu6woNtpV3MrYM4ApKnG1bac3A=
Message-ID: <43A03568.6010602@gmail.com>
Date: Wed, 14 Dec 2005 23:08:24 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Knut Petersen <Knut_Petersen@t-online.de>
CC: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1: 2.6.15-rc5-git3] Fixed and updated CyblaFB
References: <439EF4CB.8030007@t-online.de>
In-Reply-To: <439EF4CB.8030007@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen wrote:
> With kernel 2.6.15-rc5-git3 all patches needed by this new version
> of cyblafb reached the main line kernel. So here it is.
> 
> Main advantages:
> ============
>   - vxres > xres support
>   - ywrap support
>   - much faster for almost all modes (e.g. 1280x1024-16bpp
>      draws more than 41 full screens of text instead of about 25
>      full screens of text per second on authors Epia 5000)
>   - module init/exit code fixed
>   - bugs triggered by console rotation fixed
>   - lots of minor improvements
>   - startup modes suitable for high performance scrolling
>      in all directions
> 
> As only one single graphics core is affected, there should be no
> reason not to include it in 2.6.15. No side effects are possible.
> 

But current users of cyblafb will be affected if your patch
does have a problem.

> @@ -240,8 +247,8 @@ static void cyblafb_setup_GE(int pitch,i
> 
> static int cyblafb_sync(struct fb_info *info)
> {
> -    int status, i=100000;
> -    while( ((status=in32(GE20)) & 0xFA800000) && i != 0)
> +    int status,i=100000;
> +    while( ((status=in32(GE20)) & 0xFe800000) && i != 0)

It's easier to read if you change your whitespace to something
like this...

int status, i = 100000;
while (((status = in32(GE20)) & 0xFE800000) && i != 0)

space after commas, before and after an operator. No space 
here, in32(GE20), but put a space here, while (...)
 

> +        s1 = point(ca->sx,0);
> +        s2 = point(ca->sx+ca->width-1,ca->height-1);
> +        d1 = point(ca->dx,0);
> +        d2 = point(ca->dx+ca->width-1,ca->height-1);
> +
> +        if ((ca->sy > ca->dy) || ((ca->sy == ca->dy) && (ca->sx >
> ca->dx)))
> +                direction = 0;
> +        else
> +                direction = 2;
> +
> +    out32(GEB8,basestride | ((ca->dy * info->var.xres_virtual *
> +                info->var.bits_per_pixel) >> 6));
> +    out32(GEC8,basestride | ((ca->sy * info->var.xres_virtual *
> +                info->var.bits_per_pixel) >> 6 ));
> +        out32(GE44,0xa0000000|1<<19|1<<2|direction);
> +        out32(GE00,direction?s2:s1);
> +        out32(GE04,direction?s1:s2);
> +        out32(GE08,direction?d2:d1);
> +        out32(GE0C,direction?d1:d2);

You replaced the tabs here with spaces.

> 
> }
> 
> @@ -355,26 +364,37 @@ static void cyblafb_copyarea(struct fb_i
> //
> // Cyberblade specific imageblit
> //
> -// Accelerated for the most usual case, blitting 1-bit deep character
> -// character images. Everything else is passed to the generic imageblit.
> +// Accelerated for the most usual case, blitting 1-bit deep
> +// character images. Everything else is passed to the generic imageblit
> +// unless it is so insane that it is better to printk an alert.
> //
> //=======================================================================
> 
> static void cyblafb_imageblit(struct fb_info *info,
>                   const struct fb_image *image)
> {
> +    u32 fgcol, bgcol, *pd = (u32 *) image->data;
> 
> -    u32 fgcol, bgcol;
> -
> -    int i;
>     int bpp = info->var.bits_per_pixel;
> -    int index = 0;
> -    int index_end=image->height * image->width / 8;
> -    int width_dds=image->width / 32;
> -    int width_dbs=image->width % 32;
> 
> -    if (image->depth != 1 || bpp < 8 || bpp > 32 || bpp % 8 != 0 ||
> -        image->width % 8 != 0 || image->width == 0 || image->height ==
> 0) {
> +    // Used only for drawing the penguine (image->depth > 1)
> +    if (image->depth != 1) {
> +        if (verbosity > 1)
> +            output("imageblit depth = %d, dimen = %d x %d\n",
> +            image->depth, image->width, image->height);
> +        cfb_imageblit(info,image);
> +        return;
> +    }
> +
> +    // That should never happen, but it would be fatal

It won't :-)

> +    if (image->width == 0 || image->height == 0) {
> +        output("imageblit: width/height 0 detected\n");
> +        return;
> +    }
> +
> +    if (bpp < 8 || bpp > 32 || bpp % 8 != 0 ||
> +                   info->pixmap.scan_align > 4 ) {

Why this paranoid check?  The check_var() function already
guaranteed that these conditions will not happen.

> +        output("imageblit: invalid bpp or pixmap alignement\n");
>         cfb_imageblit(info,image);
>         return;
>     }
> @@ -401,32 +421,32 @@ static void cyblafb_imageblit(struct fb_
>              break;
>     }
> 
> -    cyblafb_sync(info);
> -
> +    out32(GEB8,basestride |
> +           ((image->dy * info->var.xres_virtual * bpp) >> 6));
>     out32(GE60,fgcol);
>     out32(GE64,bgcol);
>     out32(GE44,0xa0000000 | 1<<20 | 1<<19);
> -    out32(GE08,point(image->dx,image->dy));
> -    out32(GE0C,point(image->dx+image->width-1,image->dy+image->height-1));
> +    out32(GE08,point(image->dx,0));
> +    out32(GE0C,point(image->dx+image->width-1,image->height-1));
> 
> -    while(index < index_end) {
> -        const char *p = image->data + index;
> -        for(i=0;i<width_dds;i++) {
> -            out32(GE9C,*(u32*)p);
> -            p+=4;
> -            index+=4;
> -        }
> -        switch(width_dbs) {
> -        case 0: break;
> -        case 8:    out32(GE9C,*(u8*)p);
> -            index+=1;
> -            break;
> -        case 16: out32(GE9C,*(u16*)p);
> -            index+=2;
> -            break;
> -        case 24: out32(GE9C,*(u16*)p | *(u8*)(p+2)<<16);
> -            index+=3;
> -            break;
> +    if (likely(info->pixmap.scan_align == 4)) {
> +        int dds = ((image->width + 31) >> 5) * image->height;
> +        while (dds--)
> +            out32(GE9C,*pd++);
> +    } else {
> +        int i, j, dds = image->width / 32, bits = image->width % 32;
> +        for (i=0; i<image->height; i++) {
> +            for (j=0; j<dds; j++)
> +                out32(GE9C, *pd++);
> +            if(bits != 0) {
> +                out32(GE9C, *pd);
> +                if (info->pixmap.scan_align == 2)
> +                    pd = (u32*)((u32) pd +
> +                        (((bits + 15) >> 4) << 1) );
> +                else
> +                    pd = (u32*)((u32) pd +
> +                        ((bits + 7) >> 3));
> +            }

Do you really have to support scan_align 1 and 2?  Why not just stick
with scan_align of 4, the code is so much easier to understand? I can't
find anything useful with this, even for debugging.

> +    // try to be smart about (x|y)res(_virtual) problems.
> +    //
> +    if (var->xres % 8 != 0)
>         return -EINVAL;

Isn't this too much?  Why not var->xres = (var->xres + 7) & ~7?

> +    if (var->xres > var->xres_virtual)
> +        var->xres_virtual = var->xres;
> +    if (var->yres > var->yres_virtual)
> +        var->yres_virtual = var->yres;
> +    if (bpp == 8 || bpp == 16) {
> +        if (var->xres_virtual > 4088)
> +            var->xres_virtual = 4088;
> +    } else {
> +        if (var->xres_virtual > 2040)
> +            var->xres_virtual = 2040;
> +    }
> +    if (var->xres_virtual % 8 != 0)
> +        var->xres_virtual &= ~7;

Or just var->xres_virtual &= ~7 without the if (...)

> @@ -1336,18 +1442,21 @@ static int __devinit cybla_pci_probe(str
>  errout_findmode:
>     iounmap(info->screen_base);
>  errout_smem_remap:
> -    release_mem_region(info->fix.smem_start,
> -               info->fix.smem_len);
> - errout_smem_req:
> +    if (!(vesafb & 4))

Wrong boolean check?  Should be if (vesafb & 4). Or might as
well get rid of this check, it's redundant.

> +        release_mem_region(info->fix.smem_start,
> +                   info->fix.smem_len);
>     iounmap(io_virt);
>  errout_mmio_remap:
>     release_mem_region(info->fix.mmio_start,
>                info->fix.mmio_len);
>  errout_mmio_reqmem:
> -//    release_region(0x3c0,32);
> +    if (!(vesafb & 1))
> +        release_region(0x3c0,32);
>  errout_enable:
> +    kfree(info->pixmap.addr);
> + errout_alloc_pixmap:
>     framebuffer_release(info);
> - errout_alloc:
> + errout_alloc_info:
>     output("CyblaFB version %s aborting init.\n",VERSION);
>     return -ENODEV;
> }
> @@ -1359,9 +1468,15 @@ static void __devexit cybla_pci_remove(s
>     unregister_framebuffer(info);
>     iounmap(io_virt);
>     iounmap(info->screen_base);
> -    release_mem_region(info->fix.smem_start,info->fix.smem_len);
> +    if (!(vesafb & 4))

Shouldn't this be if (vesafb & 4)?

> +        release_mem_region(info->fix.smem_start,info->fix.smem_len);
>     release_mem_region(info->fix.mmio_start,info->fix.mmio_len);
>     fb_dealloc_cmap(&info->cmap);
> +    if (!(vesafb & 2))

and this...

> +        release_region(GEBase,0x100);
> +    if (!(vesafb & 1))

and this...?

Tony
