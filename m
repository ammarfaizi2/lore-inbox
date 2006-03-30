Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWC3Fwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWC3Fwl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 00:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWC3Fwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 00:52:41 -0500
Received: from holly.csn.ul.ie ([193.1.99.76]:58517 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751055AbWC3Fwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 00:52:40 -0500
Date: Thu, 30 Mar 2006 06:52:19 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] DRM changes for 2.6.17
Message-ID: <Pine.LNX.4.64.0603300650180.24125@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
 	Can you please pull the 'drm-patches' branch from
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

This contains the changes for the DRM I'd like in 2.6.17, mainly a new 
memory mapper and a safer r300 method for enabling pci ids... they now 
require a new Xorg driver..

It also finally makes the DRM use the correct PCI DMA interfaces...

Dave.

  drmP.h             |   16 ++---
  drm_bufs.c         |   20 +++----
  drm_dma.c          |    4 -
  drm_memory.c       |   59 --------------------
  drm_memory_debug.h |   70 ------------------------
  drm_pci.c          |   29 ++++++++--
  drm_pciids.h       |  116 +++++++++++++++++++++++++++-------------
  i915_dma.c         |    2
  i915_irq.c         |    2
  r300_cmdbuf.c      |   86 +++++++++++++++++++++++++++---
  r300_reg.h         |   39 +++++++++++--
  radeon_cp.c        |  151 +++++++++++++++++++++++++++++++++++++----------------
  radeon_drm.h       |    5 +
  radeon_drv.h       |   25 +++++---
  radeon_state.c     |  107 ++++++++++++++++---------------------
  sis_mm.c           |    2
  16 files changed, 414 insertions(+), 319 deletions(-)

commit 55eb061326765b2d0489387cfb3fc7dbd244f917
Author: Dave Airlie <airlied@linux.ie>
Date:   Wed Mar 29 08:16:12 2006 +1000

     drm: remove drm_{alloc,free}_pages

     drm_alloc_pages and drm_free_pages can now be removed.

     Signed-off-by: Adrian Bunk <bunk@stusta.de>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit d2b58b58838159b2afdc624f74b208e8bd3c029e
Author: Dave Airlie <airlied@linux.ie>
Date:   Wed Mar 29 08:12:52 2006 +1000

     drm: sis fix compile warning

     Prevent a gcc warning in the SIS DRM driver.  offset is a unsigned int and
     the printk wants a long.

     Signed-off-by: Jon Mason <jdmason@us.ibm.com>
     Signed-off-by: Andrew Morton <akpm@osdl.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit f3dd5c37382472a8b245ad791ed768771594e60c
Author: Dave Airlie <airlied@linux.ie>
Date:   Sat Mar 25 18:09:46 2006 +1100

     drm: add new radeon PCI ids..

     This adds all the r300 and r400 PCI ids from DRM CVS, it also
     makes these cards only initialise when the new xorg driver is
     used, as otherwise the DRM can cause lockups.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 6e5fca53c72c95da92c092411c7ec81e926af632
Author: Dave Airlie <airlied@linux.ie>
Date:   Mon Mar 20 18:34:29 2006 +1100

     drm: read breadcrumb in IRQ handler

     From: Keith Whitwell <keithw@tungstengraphics.com>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit e7f947b908921a661efcbc08ce42d7de67691b07
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Mar 19 20:28:19 2006 +1100

     drm: fixup i915 breadcrumb read/write

     Some minor issues in the i915 breadcrumb code.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 2fab58d1a18c752887c2b9f6ee7b6997ced4a77a
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Mar 19 20:15:41 2006 +1100

     drm:  remove pointless checks in radeon_state

     If these were valid checks, we'd have already oopsed several
     lines above where we were already dereferencing them.

     DA: these used to be valid but other changes made them unnecessary.

     Coverity: 776,777,778
     Signed-off-by: Dave Jones <davej@redhat.com>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit f15e92d702bba47f451bd5f63e170252c6e1bba2
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Mar 19 20:12:23 2006 +1100

     drm: fixup improper cast.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit dfab11542fbecd8539c092fe36155909b4812f73
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Mar 19 20:01:37 2006 +1100

     drm: rationalise some pci ids

     This is the start of some work from Roland Scheidegger to align
     the X DDX pci ids and the drm ones, however we don't want to put
     r300 ids in the kernel just yet, they destabilise a few machines.

     From: Roland Scheidegger (via DRM CVS)
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit ee4621f011750a6eff9f56631e12ab7fd9503aaa
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Mar 19 19:45:26 2006 +1100

     drm: Add general-purpose packet for manipulating scratch registers (r300)

     From: Aapo Tahkola (via DRM CVS)
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit d5ea702f1e8e3edeea6b673a58281bf99f3dbec5
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Mar 19 19:37:55 2006 +1100

     drm: rework radeon memory map (radeon 1.23)

     This code reworks the radeon memory map so it works better
     for newer r300 chips and for a lot of older PCI chips.

     It really requires a new X driver in order to take advantage of this code.

     From: Ben Herrenschmidt <benh@kernel.crashing.org>
     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit 45f17100bfd18c99d6479e94598f4e533bbe30d8
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Mar 19 19:12:10 2006 +1100

     drm: update r300 register names

     Update some of the DRM register names from DRM CVS

     Signed-off-by: Dave Airlie <airlied@linux.ie>

commit ddf19b973be5a96d77c8467f657fe5bd7d126e0f
Author: Dave Airlie <airlied@linux.ie>
Date:   Sun Mar 19 18:56:12 2006 +1100

     drm: fixup PCI DMA support

     This patch makes the PCI support use the correct Linux interfaces finally.
     Tested in DRM CVS on PCI MGA card.

     Signed-off-by: Dave Airlie <airlied@linux.ie>

