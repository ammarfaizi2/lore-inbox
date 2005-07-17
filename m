Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVGQSQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVGQSQE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 14:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVGQSQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 14:16:04 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:30497 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261377AbVGQSQD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 14:16:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lBP/46id/rvPjRj3zlS3Bs+HMviLRh0BIAdQXR2VqU0XrDnXmZh8sT8EGUJpfNGdNS+q/IhmF4sUaqDoxii7p9HtUF/uqRyryF2f6tX00T/JQ/ggZfuJD+6qFOrYQtuMtQBOTAhrjkYijXk3CMcRhI9QZfbEtfDzjLvMgOssSlA=
Message-ID: <9a87484905071711165b896ea2@mail.gmail.com>
Date: Sun, 17 Jul 2005 20:16:02 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Michal Januszewski <spock@gentoo.org>
Subject: Re: [PATCH] fbdev: Update info->cmap when setting cmap from user-/kernelspace.
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050717122747.GA25475@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050717122747.GA25475@spock.one.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/05, Michal Januszewski <spock@gentoo.org> wrote:
> Hi.
> 
> The fb_info struct, as defined in include/linux/fb.h, contains an element
> that is supposed to hold the current color map:
>   struct fb_cmap cmap;            /* Current cmap */
> 
> This cmap is currently never updated when either fb_set_cmap() or
> fb_set_user_cmap() are called. As a result, info->cmap contains the
> default cmap that was set by a device driver/fbcon and a userspace
> application using the FBIOGETCMAP ioctl will not always get the
> *currently* used color map.
> 
> The patch fixes this by making sure the cmap is copied to info->cmap
> after it is set correctly. It moves most of the code that is responsible
> for setting the cmap to fb_set_cmap() and out of fb_set_user_cmap() to
> avoid code-duplication.
> 
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> ---
> 
> diff -Nupr linux-2.6.12-orig/drivers/video/fbcmap.c linux-2.6.12/drivers/video/fbcmap.c
> --- linux-2.6.12-orig/drivers/video/fbcmap.c    2005-06-17 21:48:29.000000000 +0200
> +++ linux-2.6.12/drivers/video/fbcmap.c 2005-07-17 13:32:49.000000000 +0200
> @@ -212,7 +212,7 @@ int fb_cmap_to_user(struct fb_cmap *from
> 
>  int fb_set_cmap(struct fb_cmap *cmap, struct fb_info *info)
>  {
> -       int i, start;
> +       int i, start, rc = 0;
>         u16 *red, *green, *blue, *transp;
>         u_int hred, hgreen, hblue, htransp = 0xffff;
> 
> @@ -225,75 +225,51 @@ int fb_set_cmap(struct fb_cmap *cmap, st
>         if (start < 0 || (!info->fbops->fb_setcolreg &&

'start' is initialized here by cmap->start which is an unsigned
integer, so testing start for <0 makes little sense.


>                           !info->fbops->fb_setcmap))
>                 return -EINVAL;
> -       if (info->fbops->fb_setcmap)
> -               return info->fbops->fb_setcmap(cmap, info);
> -       for (i = 0; i < cmap->len; i++) {
> -               hred = *red++;
> -               hgreen = *green++;
> -               hblue = *blue++;
> -               if (transp)
> -                       htransp = *transp++;
> -               if (info->fbops->fb_setcolreg(start++,
> -                                             hred, hgreen, hblue, htransp,
> -                                             info))
> -                       break;
> +       if (info->fbops->fb_setcmap) {
> +               rc = info->fbops->fb_setcmap(cmap, info);
> +       } else {
> +               for (i = 0; i < cmap->len; i++) {
> +                       hred = *red++;
> +                       hgreen = *green++;
> +                       hblue = *blue++;
> +                       if (transp)
> +                               htransp = *transp++;
> +                       if (info->fbops->fb_setcolreg(start++,
> +                                                     hred, hgreen, hblue,
> +                                                     htransp, info))
> +                               break;
> +               }
>         }
> -       return 0;
> +       if (rc == 0)
> +               fb_copy_cmap(cmap, &info->cmap);
> +
> +       return rc;
>  }
> 
>  int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
>  {
> -       int i, start;
> -       u16 __user *red, *green, *blue, *transp;
> -       u_int hred, hgreen, hblue, htransp = 0xffff;
> -
> -       red = cmap->red;
> -       green = cmap->green;
> -       blue = cmap->blue;
> -       transp = cmap->transp;
> -       start = cmap->start;
> -
> -       if (start < 0 || (!info->fbops->fb_setcolreg &&
> -                         !info->fbops->fb_setcmap))
> +       int rc, size = cmap->len * sizeof(u16);
> +       struct fb_cmap umap;
> +
> +       if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&

cmap->start is of type __u32 as far as I can see, so testing it for <0
makes little sense.

> +                               !info->fbops->fb_setcmap))
>                 return -EINVAL;
> 
> -       /* If we can batch, do it */
> -       if (info->fbops->fb_setcmap && cmap->len > 1) {
> -               struct fb_cmap umap;
> -               int size = cmap->len * sizeof(u16);
> -               int rc;
> -
> -               memset(&umap, 0, sizeof(struct fb_cmap));
> -               rc = fb_alloc_cmap(&umap, cmap->len, transp != NULL);
> -               if (rc)
> -                       return rc;
> -               if (copy_from_user(umap.red, red, size) ||
> -                   copy_from_user(umap.green, green, size) ||
> -                   copy_from_user(umap.blue, blue, size) ||
> -                   (transp && copy_from_user(umap.transp, transp, size))) {
> -                       rc = -EFAULT;
> -               }
> -               umap.start = start;
> -               if (rc == 0)
> -                       rc = info->fbops->fb_setcmap(&umap, info);
> -               fb_dealloc_cmap(&umap);
> +       memset(&umap, 0, sizeof(struct fb_cmap));
> +       rc = fb_alloc_cmap(&umap, cmap->len, cmap->transp != NULL);
> +       if (rc)
>                 return rc;
> +       if (copy_from_user(umap.red, cmap->red, size) ||
> +           copy_from_user(umap.green, cmap->green, size) ||
> +           copy_from_user(umap.blue, cmap->blue, size) ||
> +           (cmap->transp && copy_from_user(umap.transp, cmap->transp, size))) {
> +               fb_dealloc_cmap(&umap);
> +               return -EFAULT;
>         }
> -
> -       for (i = 0; i < cmap->len; i++, red++, blue++, green++) {
> -               if (get_user(hred, red) ||
> -                   get_user(hgreen, green) ||
> -                   get_user(hblue, blue) ||
> -                   (transp && get_user(htransp, transp)))
> -                       return -EFAULT;
> -               if (info->fbops->fb_setcolreg(start++,
> -                                             hred, hgreen, hblue, htransp,
> -                                             info))
> -                       return 0;
> -               if (transp)
> -                       transp++;
> -       }
> -       return 0;
> +       umap.start = cmap->start;
> +       rc = fb_set_cmap(&umap, info);
> +       fb_dealloc_cmap(&umap);
> +       return rc;
>  }
> 
>  /**
> 
> 
> 
> 
> 


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
