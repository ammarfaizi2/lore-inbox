Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbTBAGil>; Sat, 1 Feb 2003 01:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbTBAGil>; Sat, 1 Feb 2003 01:38:41 -0500
Received: from surfer.sbm.temple.edu ([155.247.185.2]:23639 "EHLO
	surfer.sbm.temple.edu") by vger.kernel.org with ESMTP
	id <S264729AbTBAGii>; Sat, 1 Feb 2003 01:38:38 -0500
Date: Sat, 1 Feb 2003 01:47:52 -0500
From: AU <au@sbm.temple.edu>
To: Chris Ison <cisos@bigpond.net.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Radeon PCI support
In-Reply-To: <3E398E44.E2D16B4F@bigpond.net.au>
Message-ID: <Pine.SGI.4.32.0302010127540.9773312-100000@surfer.sbm.temple.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here what I did
1) Kernel

/usr/src/linux/drivers/char/drm/radeon_cp.c

comment out
/*
#if defined(__alpha__)
# define PCIGART_ENABLED
#else
# undef PCIGART_ENABLED
#endif
*/

#define PCIGART_ENABLED

and then I got drm works

But I don't think I have to do that, but I don't know  because I am
too lazy to make a new kernel without that feature, after I got Xfree86
work with glx.

Herewhat I did:

1) download 4.2.1 source code from Xfree86.org
2) modify xc/programs/Xserver/hw/xfree86/drivers/ati/radeon_dri.c
comment out

#include "sarea.h"
/*
#if defined(__alpha__)
# define PCIGART_ENABLED
#else
# undef PCIGART_ENABLED
#endif
*/
/* insert this line */
#define PCIGART_ENABLED

/* ?? HACK - for now, put this here... */
/* ?? Alpha - this may need to be a variable to handle UP1x00 vs TITAN */
#if defined(__alpha__)
# define DRM_PAGE_SIZE 8192
#elif defined(__ia64__)
# define DRM_PAGE_SIZE getpagesize()
#else
# define DRM_PAGE_SIZE 4096
#endif

/* insert this line */
#define DRM_PAGE_SIZE 8192

3) modify
xc/programs/Xserver/hw/xfree86/os-support/linux/drm/kernel/radeon_cp.c

/*
#if defined(__alpha__)
# define PCIGART_ENABLED
#else
# undef PCIGART_ENABLED
#endif
*/
/* insert this line */
#define PCIGART_ENABLED

4) Last one this I trial and error, some how it works. According to
Whitney.diff patch.

in xc/programs/Xserver/hw/xfree86/common/xf86pciBus.c
-------------------------------------------------------
*** xf86pciBus.c	Thu Jan 30 23:57:29 2003
--- xf86pciBus.c.orig	Sat Jan 18 01:11:45 2003
***************
*** 1518,1537 ****
  		  tmp->block_end = MIN(tmp->block_end,PCI_MEM32_LENGTH_MAX);
  		  tmp = tmp->next;
  	      }
! 	  } /* Hacking by me */
!           else if ((pbp->primary == pvp->bus) &&
!                   (pbp->secondary >= 0) &&
!                   (pbp->primary != pbp->secondary)) {
!            tmp = xf86DupResList(pbp->preferred_pmem);
!            avoid = xf86JoinResLists(avoid, tmp);
!            tmp = xf86DupResList(pbp->pmem);
!            avoid = xf86JoinResLists(avoid, tmp);
!            tmp = xf86DupResList(pbp->preferred_mem);
!            avoid = xf86JoinResLists(avoid, tmp);
!            tmp = xf86DupResList(pbp->mem);
!            avoid = xf86JoinResLists(avoid, tmp);
!         }
!
  	  while (pbp1) {
  	      if (pbp1->primary == pvp->bus) {
  		  tmp = xf86DupResList(pbp1->preferred_pmem);
--- 1518,1524 ----
  		  tmp->block_end = MIN(tmp->block_end,PCI_MEM32_LENGTH_MAX);
  		  tmp = tmp->next;
  	      }
! 	  }
  	  while (pbp1) {
  	      if (pbp1->primary == pvp->bus) {
  		  tmp = xf86DupResList(pbp1->preferred_pmem);
***************
*** 2211,2230 ****
  		    res_m_io = xf86JoinResLists(res_m_io,
  			xf86FindIntersectOfLists(pbp->preferred_io,ResRange));
  		}
! 	    } /* hacking */
! 		else if ((pbp->primary == pvp->bus) &&
!                       (pbp->secondary >= 0) &&
!                       (pbp->primary != pbp->secondary)) {
!                tmp = xf86DupResList(pbp->preferred_pmem);
!                avoid = xf86JoinResLists(avoid, tmp);
!                tmp = xf86DupResList(pbp->preferred_mem);
!                avoid = xf86JoinResLists(avoid, tmp);
!                tmp = xf86DupResList(pbp->preferred_io);
!                avoid = xf86JoinResLists(avoid, tmp);
!             }
!
!
!
  	    while (pbp1) {
  		if (pbp1->primary == pvp->bus) {
  		    tmp = xf86DupResList(pbp1->preferred_pmem);
--- 2198,2204 ----
  		    res_m_io = xf86JoinResLists(res_m_io,
  			xf86FindIntersectOfLists(pbp->preferred_io,ResRange));
  		}
! 	    }
  	    while (pbp1) {
  		if (pbp1->primary == pvp->bus) {
  		    tmp = xf86DupResList(pbp1->preferred_pmem);

-------------------------------------------------------------------

Try it and let me know if you have any questions, I would like to know the
result too.

Thanks,

On Fri, 31 Jan 2003, Chris Ison wrote:

> just a couple of things I forgot to mention, my system doesn't have AGP
> and I'm using kernel version 2.4.20-ac1
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

