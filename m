Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVJYVf6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVJYVf6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVJYVf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:35:58 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:47966 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932399AbVJYVf6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:35:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JuLfmn0XI+p/zbJJG9auurLfpFODDy/j/9r6y/46u+XDfwVKvyq6vh/6SNvaigxqr07yu5WByc3HvR4WRRovfKaONwnS+KMLv+go9w+yboLLLkTai0t7thfkk8beIV2S2vaZsJ44C5RrNAQc+E+nhOcioOt/TdzY1j5VsBelMfE=
Message-ID: <21d7e9970510251435s5608bafbvb552a99ad1fb74ae@mail.gmail.com>
Date: Wed, 26 Oct 2005 07:35:54 +1000
From: Dave Airlie <airlied@gmail.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: 2.6.14-rc5 GPF in radeon_cp_init_ring_buffer()
Cc: Badari Pulavarty <pbadari@gmail.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051026012520.A7501@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1130257682.6831.63.camel@localhost.localdomain>
	 <20051026012520.A7501@jurassic.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/05, Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
> On Tue, Oct 25, 2005 at 09:28:02AM -0700, Badari Pulavarty wrote:
> > On my EM64T machine, X gets killed every time due to
> > following GFP. Happens on mainline & -mm kernels.
> > Hasn't annoyed me enough to take a look on why ?
>
> I've seen similar failure on alpha.
>
> Obviously, someone forgot to convert sg->handle stuff for
> PCI gart case.

No someone forgot that that patch needed to go in.. it's already
sitting in my -mm queue, after PCI Express support...

I forgot it would've broken normal PCI GART support..

I'll push it to Linus in a while.

Dave.
>
> Ivan.
>
> --- 2.6.14-rc5/drivers/char/drm/radeon_cp.c     Fri Sep 23 23:39:48 2005
> +++ linux/drivers/char/drm/radeon_cp.c  Sat Sep 24 02:59:22 2005
> @@ -1136,7 +1136,7 @@ static void radeon_cp_init_ring_buffer(
>         } else
>  #endif
>                 ring_start = (dev_priv->cp_ring->offset
> -                             - dev->sg->handle
> +                             - (unsigned long)dev->sg->virtual
>                               + dev_priv->gart_vm_start);
>
>         RADEON_WRITE( RADEON_CP_RB_BASE, ring_start );
> @@ -1164,7 +1164,8 @@ static void radeon_cp_init_ring_buffer(
>                 drm_sg_mem_t *entry = dev->sg;
>                 unsigned long tmp_ofs, page_ofs;
>
> -               tmp_ofs = dev_priv->ring_rptr->offset - dev->sg->handle;
> +               tmp_ofs = dev_priv->ring_rptr->offset -
> +                               (unsigned long)dev->sg->virtual;
>                 page_ofs = tmp_ofs >> PAGE_SHIFT;
>
>                 RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
> @@ -1491,8 +1492,8 @@ static int radeon_do_init_cp( drm_device
>         else
>  #endif
>                 dev_priv->gart_buffers_offset = (dev->agp_buffer_map->offset
> -                                               - dev->sg->handle
> -                                               + dev_priv->gart_vm_start);
> +                                       - (unsigned long)dev->sg->virtual
> +                                       + dev_priv->gart_vm_start);
>
>         DRM_DEBUG( "dev_priv->gart_size %d\n",
>                    dev_priv->gart_size );
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
