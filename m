Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVG1NHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVG1NHe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVG1NHe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:07:34 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:6059 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261258AbVG1NHa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:07:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EQKqCYVwNzI65TIgTExhWGW7Aef96nCshFRDbOeAVgQCdVOzdxMDgIpmnfPo/B0PwDxNpN9Q6mXDq18qs1QZZtoZaGPIicLK0VKAZ06fs7a/iKVRdXihKn28b5CJd/VmcLt0+7ZoesGIx/ii3ejHiXqtDkF/DBHcGQJD78pvYTE=
Message-ID: <9e473391050728060741040424@mail.gmail.com>
Date: Thu, 28 Jul 2005 09:07:26 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fbdev: colormap fixes
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 27 Jul 2005, Linux Kernel Mailing List wrote:

There are a couple of ways to fix this. 

1) Add a check to limit use of the sysfs attributes to 256 entries. If
you want more you have to use /dev/fb0 and the ioctl. More is an
uncommon case.
2) Switch this to a binary parameter. Now you have to use tools like
hexdump instead of cat to work with the data. It was nice to be able
to use cat to see the current map.

Does anyone have preferences for which way to fix it?

Thanks for catching the problems. I'm posting these patches to fbdev
for review first so it is best to catch bugs there.

> > tree 17014af0ea8b19dae7848736d324499715b7a1a3
> > parent 3ca34fcbfbf8a7cbe99d54ae81c4e28fdc6f4ac6
> > author Jon Smirl <jonsmirl@gmail.com> Thu, 28 Jul 2005 01:46:05 -0700
> > committer Linus Torvalds <torvalds@g5.osdl.org> Thu, 28 Jul 2005 06:26:18 -0700
> >
> > [PATCH] fbdev: colormap fixes
> >
> > Color maps have up to 256 entries.  4096/256 allows for 16 characters per
>              ^^^^^^^^^^^^^^^^^^^^^^
> Most (all?) current drivers have this limitation. But there exists hardware
> with more entries.
> 
> > line.  The format for a cmap entry is "%02x%c%4x%4x%4x\n" %02x entry %c
> > transp %4x red %4x blue %4x green
> >
> > You can read the color_map with cat fb0/color_map.
> >
> > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> >
> >  drivers/video/fbsysfs.c |   82 ++++++++++++++++++++++++++++++++++++++++++------
> >  1 files changed, 72 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
> > --- a/drivers/video/fbsysfs.c
> > +++ b/drivers/video/fbsysfs.c
> > @@ -242,10 +242,68 @@ static ssize_t show_virtual(struct class
> >                       fb_info->var.yres_virtual);
> >  }
> >
> > -static ssize_t store_cmap(struct class_device *class_device, const char * buf,
> > +/* Format for cmap is "%02x%c%4x%4x%4x\n" */
> > +/* %02x entry %c transp %4x red %4x blue %4x green \n */
> > +/* 255 rows at 16 chars equals 4096 */
>       ^^^
> 256?
> 
> > +/* PAGE_SIZE can be 4096 or larger */
> > +static ssize_t store_cmap(struct class_device *class_device, const char *buf,
> >                         size_t count)
> >  {
> > -//   struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
> > +     struct fb_info *fb_info = (struct fb_info *)class_get_devdata(class_device);
> > +     int rc, i, start, length, transp = 0;
> > +
> > +     if ((count > 4096) || ((count % 16) != 0) || (PAGE_SIZE < 4096))
> > +             return -EINVAL;
> > +
> > +     if (!fb_info->fbops->fb_setcolreg && !fb_info->fbops->fb_setcmap)
> > +             return -EINVAL;
> > +
> > +     sscanf(buf, "%02x", &start);
> > +     length = count / 16;
> > +
> > +     for (i = 0; i < length; i++)
> > +             if (buf[i * 16 + 2] != ' ')
> > +                     transp = 1;
> > +
> > +     /* If we can batch, do it */
> > +     if (fb_info->fbops->fb_setcmap && length > 1) {
> > +             struct fb_cmap umap;
> > +
> > +             memset(&umap, 0, sizeof(umap));
> > +             if ((rc = fb_alloc_cmap(&umap, length, transp)))
> > +                     return rc;
> > +
> > +             umap.start = start;
> > +             for (i = 0; i < length; i++) {
> > +                     sscanf(&buf[i * 16 +  3], "%4hx", &umap.red[i]);
> > +                     sscanf(&buf[i * 16 +  7], "%4hx", &umap.blue[i]);
> > +                     sscanf(&buf[i * 16 + 11], "%4hx", &umap.green[i]);
> > +                     if (transp)
> > +                             umap.transp[i] = (buf[i * 16 +  2] != ' ');
> > +             }
> > +             rc = fb_info->fbops->fb_setcmap(&umap, fb_info);
> > +             fb_copy_cmap(&umap, &fb_info->cmap);
> > +             fb_dealloc_cmap(&umap);
> > +
> > +             return rc;
> > +     }
> > +     for (i = 0; i < length; i++) {
> > +             u16 red, blue, green, tsp;
> > +
> > +             sscanf(&buf[i * 16 +  3], "%4hx", &red);
> > +             sscanf(&buf[i * 16 +  7], "%4hx", &blue);
> > +             sscanf(&buf[i * 16 + 11], "%4hx", &green);
> > +             tsp = (buf[i * 16 +  2] != ' ');
> > +             if ((rc = fb_info->fbops->fb_setcolreg(start++,
> > +                                   red, green, blue, tsp, fb_info)))
> > +                     return rc;
> > +
> > +             fb_info->cmap.red[i] = red;
> > +             fb_info->cmap.blue[i] = blue;
> > +             fb_info->cmap.green[i] = green;
> > +             if (transp)
> > +                     fb_info->cmap.transp[i] = tsp;
> > +     }
> >       return 0;
> >  }
> >
> > @@ -253,20 +311,24 @@ static ssize_t show_cmap(struct class_de
> >  {
> >       struct fb_info *fb_info =
> >               (struct fb_info *)class_get_devdata(class_device);
> > -     unsigned int offset = 0, i;
> > +     unsigned int i;
> >
> >       if (!fb_info->cmap.red || !fb_info->cmap.blue ||
> > -         !fb_info->cmap.green || !fb_info->cmap.transp)
> > +        !fb_info->cmap.green)
> > +             return -EINVAL;
> > +
> > +     if (PAGE_SIZE < 4096)
> >               return -EINVAL;
> >
> > +     /* don't mess with the format, the buffer is PAGE_SIZE */
> > +     /* 255 entries at 16 chars per line equals 4096 = PAGE_SIZE */
>            ^^^
> 256?
> 
> >       for (i = 0; i < fb_info->cmap.len; i++) {
> > -             offset += snprintf(buf, PAGE_SIZE - offset,
> > -                                "%d,%d,%d,%d,%d\n", i + fb_info->cmap.start,
> > -                                fb_info->cmap.red[i], fb_info->cmap.blue[i],
> > -                                fb_info->cmap.green[i],
> > -                                fb_info->cmap.transp[i]);
> > +             sprintf(&buf[ i * 16], "%02x%c%4x%4x%4x\n", i + fb_info->cmap.start,
> 
> Woops, nice buffer overflow if fb_info->cmap.len > 256...
> 
> > +                     ((fb_info->cmap.transp && fb_info->cmap.transp[i]) ? '*' : ' '),
> > +                     fb_info->cmap.red[i], fb_info->cmap.blue[i],
> > +                     fb_info->cmap.green[i]);
> >       }
> > -     return offset;
> > +     return 4096;
>                ^^^^
> 
> What if fb_info->cmap.len is smaller than 256?
> 
> >  }
> 
> Gr{oetje,eeting}s,
> 
>                                                 Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                                             -- Linus Torvalds
> 


-- 
Jon Smirl
jonsmirl@gmail.com
