Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268532AbUI2OgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268532AbUI2OgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268527AbUI2O3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:29:04 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:62671 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S268480AbUI2OZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:25:10 -0400
Message-ID: <415AC5C2.9030707@tungstengraphics.com>
Date: Wed, 29 Sep 2004 15:25:06 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>,
       Discuss issues related to the xorg tree 
	<xorg@freedesktop.org>
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
References: <9e4733910409280854651581e2@mail.gmail.com>
In-Reply-To: <9e4733910409280854651581e2@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
>
> Drivers provide these callbacks......
> 
> struct drm_driver_fn {
>        u32 driver_features;
>        int dev_priv_size;
>        int permanent_maps;
>        drm_ioctl_desc_t *ioctls;
>        int num_ioctls;

>        int (*preinit)(struct drm_device *, unsigned long flags);
>        void (*prerelease)(struct drm_device *, struct file *filp);
>        void (*pretakedown)(struct drm_device *);
>        int (*postcleanup)(struct drm_device *);
>        int (*presetup)(struct drm_device *);
>        int (*postsetup)(struct drm_device *);
>        int (*dma_ioctl)( DRM_IOCTL_ARGS );
>        /* these are opposites at the moment */
>        int (*open_helper)(struct drm_device *, drm_file_t *);
>        void (*free_filp_priv)(struct drm_device *, drm_file_t *);

>        void (*release)(struct drm_device *, struct file *filp);
>        void (*dma_ready)(struct drm_device *);

Is this used by any driver?

>        int (*dma_quiescent)(struct drm_device *);

>        int (*context_ctor)(struct drm_device *dev, int context);
>        int (*context_dtor)(struct drm_device *dev, int context);
>        int (*kernel_context_switch)(struct drm_device *dev, int old, int new);
>        int (*kernel_context_switch_unlock)(struct drm_device *dev);

The whole context thing in the kernel is pretty much cruft.  The gamma module 
used to rely on it, maybe the ffb module if that still exists?  It would be 
good to see this disappear.

Though the drivers don't rely on it, I don't know if the server-side code 
persists in setting it up regardless, which might make it hard to get rid of.


>        int (*vblank_wait)(struct drm_device *dev, unsigned int *sequence);
> /* these have to be filled in */
>        int (*postinit)(struct drm_device *, unsigned long flags);

Maybe move this up with the other init/cleanup functions so that they are 
visibly grouped?  Can the large number of init/cleanup functions be 
rationalized in some way?

>        irqreturn_t (*irq_handler)( DRM_IRQ_ARGS );
>        void (*irq_preinstall)(struct drm_device *dev);
>        void (*irq_postinstall)(struct drm_device *dev);
>        void (*irq_uninstall)(struct drm_device *dev);

>        void (*reclaim_buffers)(struct file *filp);

Maybe rename this to dma_reclaim_buffers() to make clear what code it is 
associated with?

>        unsigned long (*get_map_ofs)(drm_map_t *map);
>        unsigned long (*get_reg_ofs)(struct drm_device *dev);
>        void (*set_version)(struct drm_device *dev, drm_set_version_t *sv);
>        int (*version)(drm_version_t *version);
> };
> 

