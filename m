Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVJZKFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVJZKFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 06:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVJZKFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 06:05:40 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:1213 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751339AbVJZKFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 06:05:40 -0400
Date: Wed, 26 Oct 2005 11:05:25 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fwd: 2.6.14-rc5 GPF in radeon_cp_init_ring_buffer() (fwd)
Message-ID: <Pine.LNX.4.58.0510261103510.24177@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus/Andrew,

Another 2.6.14 DRM fix.. they always come in 3s.. hopefully thats it..

Dave.

--

I've seen similar failure on alpha.

Obviously, someone forgot to convert sg->handle stuff for
PCI gart case.

Ivan.

From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Signed-off-by: Dave Airlie <airlied@linux.ie>

--- 2.6.14-rc5/drivers/char/drm/radeon_cp.c     Fri Sep 23 23:39:48 2005
+++ linux/drivers/char/drm/radeon_cp.c  Sat Sep 24 02:59:22 2005
@@ -1136,7 +1136,7 @@ static void radeon_cp_init_ring_buffer(
        } else
 #endif
                ring_start = (dev_priv->cp_ring->offset
-                             - dev->sg->handle
+                             - (unsigned long)dev->sg->virtual
                              + dev_priv->gart_vm_start);

        RADEON_WRITE( RADEON_CP_RB_BASE, ring_start );
@@ -1164,7 +1164,8 @@ static void radeon_cp_init_ring_buffer(
                drm_sg_mem_t *entry = dev->sg;
                unsigned long tmp_ofs, page_ofs;

-               tmp_ofs = dev_priv->ring_rptr->offset - dev->sg->handle;
+               tmp_ofs = dev_priv->ring_rptr->offset -
+                               (unsigned long)dev->sg->virtual;
                page_ofs = tmp_ofs >> PAGE_SHIFT;

                RADEON_WRITE( RADEON_CP_RB_RPTR_ADDR,
@@ -1491,8 +1492,8 @@ static int radeon_do_init_cp( drm_device
        else
 #endif
                dev_priv->gart_buffers_offset = (dev->agp_buffer_map->offset
-                                               - dev->sg->handle
-                                               + dev_priv->gart_vm_start);
+                                       - (unsigned long)dev->sg->virtual
+                                       + dev_priv->gart_vm_start);

        DRM_DEBUG( "dev_priv->gart_size %d\n",
                   dev_priv->gart_size );
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
