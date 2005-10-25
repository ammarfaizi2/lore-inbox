Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVJYVZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVJYVZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 17:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVJYVZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 17:25:50 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:45444 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S932388AbVJYVZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 17:25:50 -0400
Date: Wed, 26 Oct 2005 01:25:20 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Badari Pulavarty <pbadari@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc5 GPF in radeon_cp_init_ring_buffer()
Message-ID: <20051026012520.A7501@jurassic.park.msu.ru>
References: <1130257682.6831.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1130257682.6831.63.camel@localhost.localdomain>; from pbadari@gmail.com on Tue, Oct 25, 2005 at 09:28:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 09:28:02AM -0700, Badari Pulavarty wrote:
> On my EM64T machine, X gets killed every time due to
> following GFP. Happens on mainline & -mm kernels.
> Hasn't annoyed me enough to take a look on why ?

I've seen similar failure on alpha.

Obviously, someone forgot to convert sg->handle stuff for
PCI gart case.

Ivan.

--- 2.6.14-rc5/drivers/char/drm/radeon_cp.c	Fri Sep 23 23:39:48 2005
+++ linux/drivers/char/drm/radeon_cp.c	Sat Sep 24 02:59:22 2005
@@ -1136,7 +1136,7 @@ static void radeon_cp_init_ring_buffer( 
        } else
 #endif
 		ring_start = (dev_priv->cp_ring->offset
-			      - dev->sg->handle
+			      - (unsigned long)dev->sg->virtual
 			      + dev_priv->gart_vm_start);
 
 	RADEON_WRITE( RADEON_CP_RB_BASE, ring_start );
@@ -1164,7 +1164,8 @@ static void radeon_cp_init_ring_buffer( 
 		drm_sg_mem_t *entry = dev->sg;
 		unsigned long tmp_ofs, page_ofs;
 
-		tmp_ofs = dev_priv->ring_rptr->offset - dev->sg->handle;
+		tmp_ofs = dev_priv->ring_rptr->offset - 
+				(unsigned long)dev->sg->virtual;
 		page_ofs = tmp_ofs >> PAGE_SHIFT;
 
 		RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
@@ -1491,8 +1492,8 @@ static int radeon_do_init_cp( drm_device
 	else
 #endif
 		dev_priv->gart_buffers_offset = (dev->agp_buffer_map->offset
-						- dev->sg->handle
-						+ dev_priv->gart_vm_start);
+					- (unsigned long)dev->sg->virtual
+					+ dev_priv->gart_vm_start);
 
 	DRM_DEBUG( "dev_priv->gart_size %d\n",
 		   dev_priv->gart_size );
