Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263539AbTC3Let>; Sun, 30 Mar 2003 06:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263540AbTC3Let>; Sun, 30 Mar 2003 06:34:49 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:18112 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263539AbTC3Ler>; Sun, 30 Mar 2003 06:34:47 -0500
Date: Sun, 30 Mar 2003 12:45:44 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: torvalds@transmeta.com, dri-devel@lists.sourceforge.net
Subject: Re: Update direct-rendering to current DRI CVS tree.
Message-ID: <20030330114544.GB16060@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	torvalds@transmeta.com, dri-devel@lists.sf.net
References: <200303300712.h2U7CVB32581@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303300712.h2U7CVB32581@hera.kernel.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 06:34:37AM +0000, Linux Kernel wrote:

This bit seems to be backing out a memleak fix..
(takedown doesn't kfree 'device' & 'minor' that I can see.)

 > diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
 > --- a/drivers/char/drm/drm_drv.h	Sat Mar 29 23:12:35 2003
 > +++ b/drivers/char/drm/drm_drv.h	Sat Mar 29 23:12:35 2003
 > @@ -576,13 +578,9 @@
 >  		memset( (void *)dev, 0, sizeof(*dev) );
 >  		dev->count_lock = SPIN_LOCK_UNLOCKED;
 >  		sema_init( &dev->struct_sem, 1 );
 > -		init_timer( &dev->timer );
 > -		init_waitqueue_head( &dev->context_wait );
 >  
 > -		if ((DRM(minor)[i] = DRM(stub_register)(DRIVER_NAME, &DRM(fops),dev)) < 0) {
 > -			retcode = -EPERM;
 > -			goto fail_reg;
 > -		}
 > +		if ((DRM(minor)[i] = DRM(stub_register)(DRIVER_NAME, &DRM(fops),dev)) < 0)
 > +			return -EPERM;
 >  		dev->device = MKDEV(DRM_MAJOR, DRM(minor)[i] );
 >  		dev->name   = DRIVER_NAME;
 >  
 > @@ -591,8 +589,9 @@
 >  #if __MUST_HAVE_AGP
 >  		if ( dev->agp == NULL ) {
 >  			DRM_ERROR( "Cannot initialize the agpgart module.\n" );
 > -			retcode = -ENOMEM;
 > -			goto fail;
 > +			DRM(stub_unregister)(DRM(minor)[i]);
 > +			DRM(takedown)( dev );
 > +			return -ENOMEM;
 >  		}
 >  #endif
 >  #if __REALLY_HAVE_MTRR
 > @@ -608,7 +607,9 @@
 >  		retcode = DRM(ctxbitmap_init)( dev );
 >  		if( retcode ) {
 >  			DRM_ERROR( "Cannot allocate memory for context bitmap.\n" );
 > -			goto fail;
 > +			DRM(stub_unregister)(DRM(minor)[i]);
 > +			DRM(takedown)( dev );
 > +			return retcode;
 >  		}
 >  #endif
 >  		DRM_INFO( "Initialized %s %d.%d.%d %s on minor %d\n",
 > @@ -623,17 +624,6 @@
 >  	DRIVER_POSTINIT();
 >  
 >  	return 0;
 > -
 > -#if (__REALLY_HAVE_AGP && __MUST_HAVE_AGP) || __HAVE_CTX_BITMAP
 > -fail:
 > -	DRM(stub_unregister)(DRM(minor)[i]);
 > -	DRM(takedown)( dev );
 > -#endif
 > -
 > -fail_reg:
 > -	kfree (DRM(device));
 > -	kfree (DRM(minor));
 > -	return retcode;
 >  }
 >  
 >  /* drm_cleanup is called via cleanup_module at module unload time.

...

 > @@ -41,7 +42,7 @@
 >  
 >  /* malloc/free without the overhead of DRM(alloc) */
 >  #define DRM_MALLOC(x) kmalloc(x, GFP_KERNEL)
 > -#define DRM_FREE(x) kfree(x)
 > +#define DRM_FREE(x,size) kfree(x)

eww. wtf is this for ? Some cross-OS compataiblity gunk ?

 > diff -Nru a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
 > --- a/drivers/char/drm/i830_dma.c	Sat Mar 29 23:12:35 2003
 > +++ b/drivers/char/drm/i830_dma.c	Sat Mar 29 23:12:35 2003
 > @@ -46,8 +47,6 @@
 >  #define I830_BUF_UNMAPPED 0
 >  #define I830_BUF_MAPPED   1
 >  
 > -#define RING_LOCALS	unsigned int outring, ringmask; volatile char *virt;
 > -
 >  #if LINUX_VERSION_CODE <= KERNEL_VERSION(2,4,2)
 >  #define down_write down
 >  #define up_write up

#if can go, like it did in other parts of the patch.

I would read through the other 10 billion lines, but I lost
enthusiasm..  More frequent merges may help here.
With the two trees in sync, would it help to have DRI cvs changes
tracked in a bk tree you could pull from ?

It could maybe even be scripted. Doing the opposite of
Larry's bk->cvs gizmo should be easier due to the linear
nature of cvs.

		Dave

