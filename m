Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269096AbUIHKdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269096AbUIHKdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 06:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269094AbUIHKdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 06:33:32 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:27865 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269096AbUIHKd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 06:33:26 -0400
Date: Wed, 8 Sep 2004 11:33:23 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] DRM: misc patches..
Message-ID: <Pine.LNX.4.58.0409081132300.14419@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

These are just some misc matches for the DRM I've had backed up in my queue
here. It also removes the virt_to_bus.

Please do a

	bk pull bk://drm.bkbits.net/drm-fntbl

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/Kconfig        |    4 ++--
 drivers/char/drm/drm_bufs.h     |    3 ---
 drivers/char/drm/drm_drv.h      |    1 +
 drivers/char/drm/i915_dma.c     |    9 ++++++++-
 drivers/char/drm/radeon_state.c |    5 -----
 5 files changed, 11 insertions(+), 11 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/09/08 1.2060)
   drm: update Kconfig for r128/radeon

   ATI Rage 128 and Radeon DRM unconditionally depend on PCI

   Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

<airlied@starflyer.(none)> (04/09/08 1.2059)
   Missing ctx_count decrement when releasing driver.

   From: Erdi Chen
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/08 1.2058)
   drm: correct i915 packet length calculations

   Correct a couple of packet length calculations.

   From: Keith Whitwell
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/08 1.2057)
   We dereference dev->priv a few lines above, meaning we'd
   oops before we got to this sanity check. As it hasn't
   triggered in any bug reports I've been able to find, I think
   it's safe to nuke it.

   Signed-off-by: Dave Jones <davej@redhat.com>

<airlied@starflyer.(none)> (04/09/07 1.2056)
   drm: remove virt_to_bus

   remove virt_to_bus completely.. will fix up drm to use proper
   interfaces instead later..

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
--- a/drivers/char/drm/Kconfig	Wed Sep  8 20:29:57 2004
+++ b/drivers/char/drm/Kconfig	Wed Sep  8 20:29:57 2004
@@ -31,7 +31,7 @@

 config DRM_R128
 	tristate "ATI Rage 128"
-	depends on DRM
+	depends on DRM && PCI
 	help
 	  Choose this option if you have an ATI Rage 128 graphics card.  If M
 	  is selected, the module will be called r128.  AGP support for
@@ -39,7 +39,7 @@

 config DRM_RADEON
 	tristate "ATI Radeon"
-	depends on DRM
+	depends on DRM && PCI
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
diff -Nru a/drivers/char/drm/drm_bufs.h b/drivers/char/drm/drm_bufs.h
--- a/drivers/char/drm/drm_bufs.h	Wed Sep  8 20:29:57 2004
+++ b/drivers/char/drm/drm_bufs.h	Wed Sep  8 20:29:57 2004
@@ -659,9 +659,6 @@
 			buf->used    = 0;
 			buf->offset  = (dma->byte_count + byte_count + offset);
 			buf->address = (void *)(page + offset);
-#ifndef __sparc__
-			buf->bus_address = virt_to_bus(buf->address);
-#endif
 			buf->next    = NULL;
 			buf->waiting = 0;
 			buf->pending = 0;
diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	Wed Sep  8 20:29:57 2004
+++ b/drivers/char/drm/drm_drv.h	Wed Sep  8 20:29:57 2004
@@ -836,6 +836,7 @@

 				list_del( &pos->head );
 				DRM(free)( pos, sizeof(*pos), DRM_MEM_CTXLIST );
+				--dev->ctx_count;
 			}
 		}
 	}
diff -Nru a/drivers/char/drm/i915_dma.c b/drivers/char/drm/i915_dma.c
--- a/drivers/char/drm/i915_dma.c	Wed Sep  8 20:29:57 2004
+++ b/drivers/char/drm/i915_dma.c	Wed Sep  8 20:29:57 2004
@@ -296,7 +296,14 @@
 		case 0x1c:
 			return 1;
 		case 0x1d:
-			return (cmd & 0xffff) + 2;
+			switch ((cmd>>16)&0xff) {
+			case 0x3:
+				return (cmd & 0x1f) + 2;
+			case 0x4:
+				return (cmd & 0xf) + 2;
+			default:
+				return (cmd & 0xffff) + 2;
+			}
 		case 0x1e:
 			if (cmd & (1 << 23))
 				return (cmd & 0xffff) + 1;
diff -Nru a/drivers/char/drm/radeon_state.c b/drivers/char/drm/radeon_state.c
--- a/drivers/char/drm/radeon_state.c	Wed Sep  8 20:29:57 2004
+++ b/drivers/char/drm/radeon_state.c	Wed Sep  8 20:29:57 2004
@@ -1667,11 +1667,6 @@

 	LOCK_TEST_WITH_RETURN( dev, filp );

-	if ( !dev_priv ) {
-		DRM_ERROR( "%s called with no initialization\n", __FUNCTION__ );
-		return DRM_ERR(EINVAL);
-	}
-
 	DRM_GET_PRIV_WITH_RETURN( filp_priv, filp );

 	DRM_COPY_FROM_USER_IOCTL( vertex, (drm_radeon_vertex_t __user *)data,
