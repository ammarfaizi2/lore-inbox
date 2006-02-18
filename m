Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWBRFOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWBRFOc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 00:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWBRFOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 00:14:32 -0500
Received: from holly.skynet.ie ([136.201.105.4]:12467 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750815AbWBRFOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 00:14:32 -0500
Date: Sat, 18 Feb 2006 05:13:20 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git tree] drm fixes for 2.6.16
Message-ID: <Pine.LNX.4.58.0602180510030.25458@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	Can you pull the drm-patches branch from
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

It just contains some minor changes to the r300 DRM to add bitblt needed
to make the previous texture rectangle work, and a fix for a i915
interrupt issue..

Dave.

 drivers/char/drm/i915_irq.c    |    5 ++++
 drivers/char/drm/r300_cmdbuf.c |   50 +++++++++++++++++++++++++++++++++++++++++
 drivers/char/drm/r300_reg.h    |    3 ++
 drivers/char/drm/radeon_drv.h  |    3 +-
 4 files changed, 60 insertions(+), 1 deletion(-)
diff-tree 4e5e2e2... (from 91e3738...)
Author: Dave Airlie <airlied@linux.ie>
Date:   Sat Feb 18 15:51:35 2006 +1100

    drm: radeon add r300 TX_CNTL and verify bitblt packets

    The Xgl on r300 doesn't work unless you add a verify bitblt function to the
    DRM, and we need to pass TX_CNTL to flush texture caches.

    Signed-off-by: Dave Airlie <airlied@linux.ie>

:100644 100644 291dbf4... 6dd2175... M	drivers/char/drm/r300_cmdbuf.c
:100644 100644 a0ed20e... d1e1995... M	drivers/char/drm/r300_reg.h
:100644 100644 498b19b... 1f7d2ab... M	drivers/char/drm/radeon_drv.h

diff-tree 91e3738... (from bd71c2b...)
Author: Dave Airlie <airlied@linux.ie>
Date:   Sat Feb 18 15:17:04 2006 +1100

    drm: fixup i915 interrupt on X server exit

    Fixes: IRQ disabled (i915?) when switchig between gnome themes (gnome-theme-manager)

    Signed-off-by: Dave Airlie <airlied@linux.ie>

:100644 100644 a1381c6... d3879ac... M	drivers/char/drm/i915_irq.c
diff --git a/drivers/char/drm/i915_irq.c b/drivers/char/drm/i915_irq.c
index a1381c6..d3879ac 100644
--- a/drivers/char/drm/i915_irq.c
+++ b/drivers/char/drm/i915_irq.c
@@ -202,10 +202,15 @@ void i915_driver_irq_postinstall(drm_dev
 void i915_driver_irq_uninstall(drm_device_t * dev)
 {
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
+	u16 temp;
+
 	if (!dev_priv)
 		return;

 	I915_WRITE16(I915REG_HWSTAM, 0xffff);
 	I915_WRITE16(I915REG_INT_MASK_R, 0xffff);
 	I915_WRITE16(I915REG_INT_ENABLE_R, 0x0);
+
+	temp = I915_READ16(I915REG_INT_IDENTITY_R);
+	I915_WRITE16(I915REG_INT_IDENTITY_R, temp);
 }
diff --git a/drivers/char/drm/r300_cmdbuf.c b/drivers/char/drm/r300_cmdbuf.c
index 291dbf4..6dd2175 100644
--- a/drivers/char/drm/r300_cmdbuf.c
+++ b/drivers/char/drm/r300_cmdbuf.c
@@ -161,6 +161,7 @@ void r300_init_reg_flags(void)
 	ADD_RANGE(R300_VAP_PVS_CNTL_1, 3);
 	ADD_RANGE(R300_GB_ENABLE, 1);
 	ADD_RANGE(R300_GB_MSPOS0, 5);
+	ADD_RANGE(R300_TX_CNTL, 1);
 	ADD_RANGE(R300_TX_ENABLE, 1);
 	ADD_RANGE(0x4200, 4);
 	ADD_RANGE(0x4214, 1);
@@ -489,6 +490,52 @@ static __inline__ int r300_emit_3d_load_

 	return 0;
 }
+static __inline__ int r300_emit_bitblt_multi(drm_radeon_private_t *dev_priv,
+					     drm_radeon_kcmd_buffer_t *cmdbuf)
+{
+	u32 *cmd = (u32 *) cmdbuf->buf;
+	int count, ret;
+	RING_LOCALS;
+
+	count=(cmd[0]>>16) & 0x3fff;
+
+	if (cmd[0] & 0x8000) {
+		u32 offset;
+
+		if (cmd[1] & (RADEON_GMC_SRC_PITCH_OFFSET_CNTL
+			      | RADEON_GMC_DST_PITCH_OFFSET_CNTL)) {
+			offset = cmd[2] << 10;
+			ret = r300_check_offset(dev_priv, offset);
+			if (ret)
+			{
+				DRM_ERROR("Invalid bitblt first offset is %08X\n", offset);
+				return DRM_ERR(EINVAL);
+			}
+		}
+
+		if ((cmd[1] & RADEON_GMC_SRC_PITCH_OFFSET_CNTL) &&
+		    (cmd[1] & RADEON_GMC_DST_PITCH_OFFSET_CNTL)) {
+			offset = cmd[3] << 10;
+			ret = r300_check_offset(dev_priv, offset);
+			if (ret)
+			{
+				DRM_ERROR("Invalid bitblt second offset is %08X\n", offset);
+				return DRM_ERR(EINVAL);
+			}
+
+		}
+	}
+
+	BEGIN_RING(count+2);
+	OUT_RING(cmd[0]);
+	OUT_RING_TABLE((int *)(cmdbuf->buf + 4), count + 1);
+	ADVANCE_RING();
+
+	cmdbuf->buf += (count+2)*4;
+	cmdbuf->bufsz -= (count+2)*4;
+
+	return 0;
+}

 static __inline__ int r300_emit_raw_packet3(drm_radeon_private_t *dev_priv,
 					    drm_radeon_kcmd_buffer_t *cmdbuf)
@@ -527,6 +574,9 @@ static __inline__ int r300_emit_raw_pack
 	case RADEON_3D_LOAD_VBPNTR:	/* load vertex array pointers */
 		return r300_emit_3d_load_vbpntr(dev_priv, cmdbuf, header);

+	case RADEON_CNTL_BITBLT_MULTI:
+		return r300_emit_bitblt_multi(dev_priv, cmdbuf);
+
 	case RADEON_CP_3D_DRAW_IMMD_2:	/* triggers drawing using in-packet vertex data */
 	case RADEON_CP_3D_DRAW_VBUF_2:	/* triggers drawing of vertex buffers setup elsewhere */
 	case RADEON_CP_3D_DRAW_INDX_2:	/* triggers drawing using indices to vertex buffer */
diff --git a/drivers/char/drm/r300_reg.h b/drivers/char/drm/r300_reg.h
index a0ed20e..d1e1995 100644
--- a/drivers/char/drm/r300_reg.h
+++ b/drivers/char/drm/r300_reg.h
@@ -451,6 +451,9 @@ I am fairly certain that they are correc
 /* END */

 /* gap */
+/* Zero to flush caches. */
+#define R300_TX_CNTL                        0x4100
+
 /* The upper enable bits are guessed, based on fglrx reported limits. */
 #define R300_TX_ENABLE                      0x4104
 #       define R300_TX_ENABLE_0                  (1 << 0)
diff --git a/drivers/char/drm/radeon_drv.h b/drivers/char/drm/radeon_drv.h
index 498b19b..1f7d2ab 100644
--- a/drivers/char/drm/radeon_drv.h
+++ b/drivers/char/drm/radeon_drv.h
@@ -90,9 +90,10 @@
  * 1.19- Add support for gart table in FB memory and PCIE r300
  * 1.20- Add support for r300 texrect
  * 1.21- Add support for card type getparam
+ * 1.22- Add support for texture cache flushes (R300_TX_CNTL)
  */
 #define DRIVER_MAJOR		1
-#define DRIVER_MINOR		21
+#define DRIVER_MINOR		22
 #define DRIVER_PATCHLEVEL	0

 /*

