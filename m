Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVGDGd0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVGDGd0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 02:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVGDGd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 02:33:26 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:60864 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261519AbVGDGdF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 02:33:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dGCB/RSlyYcRS5QmAIzZqwal+wOYOzWi7KU3xD4F+qwvEHqWsLzysU2LgyDIlhNviCnwc56fvcsChmEDvnm5auC8RXBqyC0g2eK9ftK3uA+dqP7JmMbSwpRojczjrZLAhQh65IgYeXTWfHdBfUuOHdmznP/dDmY0bfMMvRz/8uU=
Message-ID: <21d7e99705070323334a194b47@mail.gmail.com>
Date: Mon, 4 Jul 2005 16:33:05 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] drm: remove drm_calloc()
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <200507041026.52631.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507041026.52631.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The DRM has wrappers for these function due to it being used on other
OS'es (BSD mainly)

However I will accept that the drm_calloc function should now just
called the kernel kcalloc function and this could probably be moved to
an inline in drm_memory.h

I'll code up something and put it my queue..

Thanks,
Dave.

On 7/4/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  drivers/char/drm/drmP.h       |    1 -
>  drivers/char/drm/drm_drv.c    |    3 +--
>  drivers/char/drm/drm_memory.c |   13 -------------
>  drivers/char/drm/drm_stub.c   |    2 +-
>  drivers/char/drm/sis_ds.c     |    8 +++-----
>  drivers/char/drm/sis_mm.c     |    8 ++++----
>  6 files changed, 9 insertions(+), 26 deletions(-)
> 
> diff -uprN linux-vanilla/drivers/char/drm/drmP.h linux-drm_calloc/drivers/char/drm/drmP.h
> --- linux-vanilla/drivers/char/drm/drmP.h       2005-06-30 02:44:22.000000000 +0400
> +++ linux-drm_calloc/drivers/char/drm/drmP.h    2005-07-04 10:15:24.000000000 +0400
> @@ -806,7 +806,6 @@ extern ssize_t       drm_read(struct fil
>  extern void         drm_mem_init(void);
>  extern int          drm_mem_info(char *buf, char **start, off_t offset,
>                                    int request, int *eof, void *data);
> -extern void         *drm_calloc(size_t nmemb, size_t size, int area);
>  extern void         *drm_realloc(void *oldpt, size_t oldsize, size_t size,
>                                    int area);
>  extern unsigned long drm_alloc_pages(int order, int area);
> diff -uprN linux-vanilla/drivers/char/drm/drm_drv.c linux-drm_calloc/drivers/char/drm/drm_drv.c
> --- linux-vanilla/drivers/char/drm/drm_drv.c    2005-06-30 02:44:22.000000000 +0400
> +++ linux-drm_calloc/drivers/char/drm/drm_drv.c 2005-07-04 10:14:56.000000000 +0400
> @@ -385,8 +385,7 @@ static int __init drm_core_init(void)
>         int ret = -ENOMEM;
> 
>         drm_cards_limit = (drm_cards_limit < DRM_MAX_MINOR + 1 ? drm_cards_limit : DRM_MAX_MINOR + 1);
> -       drm_heads = drm_calloc(drm_cards_limit,
> -                               sizeof(*drm_heads), DRM_MEM_STUB);
> +       drm_heads = kcalloc(drm_cards_limit, sizeof(*drm_heads), GFP_KERNEL);
>         if(!drm_heads)
>                 goto err_p1;
> 
> diff -uprN linux-vanilla/drivers/char/drm/drm_memory.c linux-drm_calloc/drivers/char/drm/drm_memory.c
> --- linux-vanilla/drivers/char/drm/drm_memory.c 2005-06-30 02:44:22.000000000 +0400
> +++ linux-drm_calloc/drivers/char/drm/drm_memory.c      2005-07-04 10:15:14.000000000 +0400
> @@ -65,19 +65,6 @@ int drm_mem_info(char *buf, char **start
>         return 0;
>  }
> 
> -/** Wrapper around kmalloc() */
> -void *drm_calloc(size_t nmemb, size_t size, int area)
> -{
> -       void *addr;
> -
> -       addr = kmalloc(size * nmemb, GFP_KERNEL);
> -       if (addr != NULL)
> -               memset((void *)addr, 0, size * nmemb);
> -
> -       return addr;
> -}
> -EXPORT_SYMBOL(drm_calloc);
> -
>  /** Wrapper around kmalloc() and kfree() */
>  void *drm_realloc(void *oldpt, size_t oldsize, size_t size, int area)
>  {
> diff -uprN linux-vanilla/drivers/char/drm/drm_stub.c linux-drm_calloc/drivers/char/drm/drm_stub.c
> --- linux-vanilla/drivers/char/drm/drm_stub.c   2005-06-30 02:44:23.000000000 +0400
> +++ linux-drm_calloc/drivers/char/drm/drm_stub.c        2005-07-04 10:11:18.000000000 +0400
> @@ -177,7 +177,7 @@ int drm_get_dev(struct pci_dev *pdev, co
> 
>         DRM_DEBUG("\n");
> 
> -       dev = drm_calloc(1, sizeof(*dev), DRM_MEM_STUB);
> +       dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
>         if (!dev)
>                 return -ENOMEM;
> 
> diff -uprN linux-vanilla/drivers/char/drm/sis_ds.c linux-drm_calloc/drivers/char/drm/sis_ds.c
> --- linux-vanilla/drivers/char/drm/sis_ds.c     2005-06-30 02:44:24.000000000 +0400
> +++ linux-drm_calloc/drivers/char/drm/sis_ds.c  2005-07-04 10:13:48.000000000 +0400
> @@ -166,7 +166,7 @@ memHeap_t *mmInit(int ofs,
>         if (size <= 0)
>                 return NULL;
> 
> -       blocks = (TMemBlock *)drm_calloc(1, sizeof(TMemBlock), DRM_MEM_DRIVER);
> +       blocks = (TMemBlock *)kcalloc(1, sizeof(TMemBlock), GFP_KERNEL);
>         if (blocks != NULL) {
>                 blocks->ofs = ofs;
>                 blocks->size = size;
> @@ -202,8 +202,7 @@ static TMemBlock* SliceBlock(TMemBlock *
> 
>         /* break left */
>         if (startofs > p->ofs) {
> -               newblock = (TMemBlock*) drm_calloc(1, sizeof(TMemBlock),
> -                   DRM_MEM_DRIVER);
> +               newblock = kcalloc(1, sizeof(TMemBlock), GFP_KERNEL);
>                 newblock->ofs = startofs;
>                 newblock->size = p->size - (startofs - p->ofs);
>                 newblock->free = 1;
> @@ -215,8 +214,7 @@ static TMemBlock* SliceBlock(TMemBlock *
> 
>         /* break right */
>         if (size < p->size) {
> -               newblock = (TMemBlock*) drm_calloc(1, sizeof(TMemBlock),
> -                   DRM_MEM_DRIVER);
> +               newblock = kcalloc(1, sizeof(TMemBlock), GFP_KERNEL);
>                 newblock->ofs = startofs + size;
>                 newblock->size = p->size - size;
>                 newblock->free = 1;
> diff -uprN linux-vanilla/drivers/char/drm/sis_mm.c linux-drm_calloc/drivers/char/drm/sis_mm.c
> --- linux-vanilla/drivers/char/drm/sis_mm.c     2005-06-30 02:44:24.000000000 +0400
> +++ linux-drm_calloc/drivers/char/drm/sis_mm.c  2005-07-04 10:14:28.000000000 +0400
> @@ -158,8 +158,8 @@ static int sis_fb_init( DRM_IOCTL_ARGS )
>         DRM_COPY_FROM_USER_IOCTL(fb, (drm_sis_fb_t __user *)data, sizeof(fb));
> 
>         if (dev_priv == NULL) {
> -               dev->dev_private = drm_calloc(1, sizeof(drm_sis_private_t),
> -                   DRM_MEM_DRIVER);
> +               dev->dev_private = kcalloc(1, sizeof(drm_sis_private_t),
> +                   GFP_KERNEL);
>                 dev_priv = dev->dev_private;
>                 if (dev_priv == NULL)
>                         return ENOMEM;
> @@ -246,8 +246,8 @@ static int sis_ioctl_agp_init( DRM_IOCTL
>         drm_sis_agp_t agp;
> 
>         if (dev_priv == NULL) {
> -               dev->dev_private = drm_calloc(1, sizeof(drm_sis_private_t),
> -                   DRM_MEM_DRIVER);
> +               dev->dev_private = kcalloc(1, sizeof(drm_sis_private_t),
> +                   GFP_KERNEL);
>                 dev_priv = dev->dev_private;
>                 if (dev_priv == NULL)
>                         return ENOMEM;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
