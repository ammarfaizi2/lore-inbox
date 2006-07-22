Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWGVPh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWGVPh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 11:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWGVPhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 11:37:52 -0400
Received: from wm402rot.66.ADSL.NetSurf.Net ([66.135.97.66]:36482 "EHLO
	png3r11.pngxnet.com") by vger.kernel.org with ESMTP
	id S1750815AbWGVPhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 11:37:34 -0400
From: Dave Airlie <airlied@linux.ie>
To: linux-kernel@vger.kernel.org
Cc: Dave Airlie <airlied@linux.ie>
Subject: [PATCH] drm/gpu/radeon: Add radeon DRM support to use GPU layer (07/07)
Date: Sun, 23 Jul 2006 01:38:33 +1000
Message-Id: <11535827142177-git-send-email-airlied@linux.ie>
X-Mailer: git-send-email 1.4.1.ga3e6
In-Reply-To: <11535827143978-git-send-email-airlied@linux.ie>
References: <11535827134076-git-send-email-airlied@linux.ie> <11535827133352-git-send-email-airlied@linux.ie> <11535827131612-git-send-email-airlied@linux.ie> <11535827132905-git-send-email-airlied@linux.ie> <11535827141780-git-send-email-airlied@linux.ie> <11535827142307-git-send-email-airlied@linux.ie> <11535827143978-git-send-email-airlied@linux.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This ports the radeon DRM to use the GPU layer to bind to the PCI device.

Signed-off-by: Dave Airlie <airlied@linux.ie>
---
 drivers/char/drm/Kconfig        |    1 
 drivers/char/drm/drm_pciids.h   |  178 ++++++++++++++++++++-------------------
 drivers/char/drm/radeon_cp.c    |   40 ++++-----
 drivers/char/drm/radeon_drv.c   |   60 +++++++++++--
 drivers/char/drm/radeon_drv.h   |   22 ++---
 drivers/char/drm/radeon_state.c |   10 +-
 6 files changed, 178 insertions(+), 133 deletions(-)

diff --git a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
index 5278c38..d73cda7 100644
--- a/drivers/char/drm/Kconfig
+++ b/drivers/char/drm/Kconfig
@@ -34,6 +34,7 @@ config DRM_R128
 config DRM_RADEON
 	tristate "ATI Radeon"
 	depends on DRM && PCI
+	select GPU_RADEON
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
diff --git a/drivers/char/drm/drm_pciids.h b/drivers/char/drm/drm_pciids.h
index b1bb3c7..dedfa93 100644
--- a/drivers/char/drm/drm_pciids.h
+++ b/drivers/char/drm/drm_pciids.h
@@ -3,13 +3,13 @@
    Please contact dri-devel@lists.sf.net to add new cards to this list
 */
 #define radeon_PCI_IDS \
-	{0x1002, 0x3150, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x3152, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x3154, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x3E50, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x3E54, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4136, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS100|CHIP_IS_IGP}, \
-	{0x1002, 0x4137, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS200|CHIP_IS_IGP}, \
+	{0x1002, 0x3150, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x3152, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x3154, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x3E50, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x3E54, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4136, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS100|RADEON_IS_IGP}, \
+	{0x1002, 0x4137, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS200|RADEON_IS_IGP}, \
 	{0x1002, 0x4144, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R300}, \
 	{0x1002, 0x4145, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R300}, \
 	{0x1002, 0x4146, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R300}, \
@@ -25,35 +25,35 @@ #define radeon_PCI_IDS \
 	{0x1002, 0x4154, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350}, \
 	{0x1002, 0x4155, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350}, \
 	{0x1002, 0x4156, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350}, \
-	{0x1002, 0x4237, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS200|CHIP_IS_IGP}, \
+	{0x1002, 0x4237, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS200|RADEON_IS_IGP}, \
 	{0x1002, 0x4242, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R200}, \
 	{0x1002, 0x4243, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R200}, \
-	{0x1002, 0x4336, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS100|CHIP_IS_IGP|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4337, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS200|CHIP_IS_IGP|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4437, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS200|CHIP_IS_IGP|CHIP_IS_MOBILITY}, \
+	{0x1002, 0x4336, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS100|RADEON_IS_IGP|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4337, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS200|RADEON_IS_IGP|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4437, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS200|RADEON_IS_IGP|RADEON_IS_MOBILITY}, \
 	{0x1002, 0x4966, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV250}, \
 	{0x1002, 0x4967, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV250}, \
-	{0x1002, 0x4A48, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4A49, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4A4A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4A4B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4A4C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4A4D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4A4E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4A4F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4A50, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4A54, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4B49, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4B4A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4B4B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4B4C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x4C57, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV200|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4C58, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV200|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4C59, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4C5A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4C64, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV250|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4C66, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV250|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4C67, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV250|CHIP_IS_MOBILITY}, \
+	{0x1002, 0x4A48, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4A49, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4A4A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4A4B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4A4C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4A4D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4A4E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4A4F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4A50, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4A54, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4B49, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4B4A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4B4B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4B4C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x4C57, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV200|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4C58, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV200|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4C59, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4C5A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4C64, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV250|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4C66, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV250|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4C67, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV250|RADEON_IS_MOBILITY}, \
 	{0x1002, 0x4E44, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R300}, \
 	{0x1002, 0x4E45, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R300}, \
 	{0x1002, 0x4E46, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R300}, \
@@ -62,16 +62,16 @@ #define radeon_PCI_IDS \
 	{0x1002, 0x4E49, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R350}, \
 	{0x1002, 0x4E4A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R350}, \
 	{0x1002, 0x4E4B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R350}, \
-	{0x1002, 0x4E50, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4E51, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4E52, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4E53, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4E54, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x4E56, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x5144, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R100|CHIP_SINGLE_CRTC}, \
-	{0x1002, 0x5145, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R100|CHIP_SINGLE_CRTC}, \
-	{0x1002, 0x5146, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R100|CHIP_SINGLE_CRTC}, \
-	{0x1002, 0x5147, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R100|CHIP_SINGLE_CRTC}, \
+	{0x1002, 0x4E50, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4E51, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4E52, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4E53, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4E54, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x4E56, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV350|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x5144, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R100|RADEON_SINGLE_CRTC}, \
+	{0x1002, 0x5145, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R100|RADEON_SINGLE_CRTC}, \
+	{0x1002, 0x5146, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R100|RADEON_SINGLE_CRTC}, \
+	{0x1002, 0x5147, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R100|RADEON_SINGLE_CRTC}, \
 	{0x1002, 0x5148, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R200}, \
 	{0x1002, 0x514C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R200}, \
 	{0x1002, 0x514D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R200}, \
@@ -80,59 +80,59 @@ #define radeon_PCI_IDS \
 	{0x1002, 0x5159, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100}, \
 	{0x1002, 0x515A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100}, \
 	{0x1002, 0x515E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100}, \
-	{0x1002, 0x5460, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x5462, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x5464, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x5548, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5549, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x554A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x554B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x554C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x554D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x554E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x554F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5550, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5551, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5552, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5554, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x564A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x564B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x564F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5834, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS300|CHIP_IS_IGP}, \
-	{0x1002, 0x5835, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS300|CHIP_IS_IGP|CHIP_IS_MOBILITY}, \
+	{0x1002, 0x5460, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x5462, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x5464, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x5548, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5549, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x554A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x554B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x554C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x554D, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x554E, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x554F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5550, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5551, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5552, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5554, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x564A, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x564B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x564F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5652, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5653, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5834, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS300|RADEON_IS_IGP}, \
+	{0x1002, 0x5835, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS300|RADEON_IS_IGP|RADEON_IS_MOBILITY}, \
 	{0x1002, 0x5960, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280}, \
 	{0x1002, 0x5961, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280}, \
 	{0x1002, 0x5962, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280}, \
 	{0x1002, 0x5964, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280}, \
 	{0x1002, 0x5965, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280}, \
 	{0x1002, 0x5969, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV100}, \
-	{0x1002, 0x5b60, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5b62, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5b63, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5b64, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5b65, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5c61, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x5c63, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280|CHIP_IS_MOBILITY}, \
-	{0x1002, 0x5d48, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5d49, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5d4a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5d4c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5d4d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5d4e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5d4f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5d50, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5d52, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5d57, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5e48, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5e4a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5e4b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5e4c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5e4d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x5e4f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x7834, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS300|CHIP_IS_IGP|CHIP_NEW_MEMMAP}, \
-	{0x1002, 0x7835, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS300|CHIP_IS_IGP|CHIP_IS_MOBILITY|CHIP_NEW_MEMMAP}, \
+	{0x1002, 0x5b60, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5b62, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5b63, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5b64, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5b65, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV380|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5c61, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x5c63, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV280|RADEON_IS_MOBILITY}, \
+	{0x1002, 0x5d48, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5d49, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5d4a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5d4c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5d4d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5d4e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5d4f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5d50, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5d52, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5d57, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_R420|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5e48, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5e4a, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5e4b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5e4c, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5e4d, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x5e4f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RV410|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x7834, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS300|RADEON_IS_IGP|RADEON_NEW_MEMMAP}, \
+	{0x1002, 0x7835, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RS300|RADEON_IS_IGP|RADEON_IS_MOBILITY|RADEON_NEW_MEMMAP}, \
 	{0, 0, 0}
 
 #define r128_PCI_IDS \
diff --git a/drivers/char/drm/radeon_cp.c b/drivers/char/drm/radeon_cp.c
index 5ad43ba..37fbbfe 100644
--- a/drivers/char/drm/radeon_cp.c
+++ b/drivers/char/drm/radeon_cp.c
@@ -1130,7 +1130,7 @@ static void radeon_cp_init_ring_buffer(d
 			     | (dev_priv->fb_location >> 16));
 
 #if __OS_HAS_AGP
-	if (dev_priv->flags & CHIP_IS_AGP) {
+	if (dev_priv->flags & RADEON_IS_AGP) {
 		RADEON_WRITE(RADEON_AGP_BASE, (unsigned int)dev->agp->base);
 		RADEON_WRITE(RADEON_MC_AGP_LOCATION,
 			     (((dev_priv->gart_vm_start - 1 +
@@ -1158,7 +1158,7 @@ #endif
 	dev_priv->ring.tail = cur_read_ptr;
 
 #if __OS_HAS_AGP
-	if (dev_priv->flags & CHIP_IS_AGP) {
+	if (dev_priv->flags & RADEON_IS_AGP) {
 		RADEON_WRITE(RADEON_CP_RB_RPTR_ADDR,
 			     dev_priv->ring_rptr->offset
 			     - dev->agp->base + dev_priv->gart_vm_start);
@@ -1295,7 +1295,7 @@ static void radeon_set_pcigart(drm_radeo
 {
 	u32 tmp;
 
-	if (dev_priv->flags & CHIP_IS_PCIE) {
+	if (dev_priv->flags & RADEON_IS_PCIE) {
 		radeon_set_pciegart(dev_priv, on);
 		return;
 	}
@@ -1333,20 +1333,20 @@ static int radeon_do_init_cp(drm_device_
 	DRM_DEBUG("\n");
 
 	/* if we require new memory map but we don't have it fail */
-	if ((dev_priv->flags & CHIP_NEW_MEMMAP) && !dev_priv->new_memmap)
+	if ((dev_priv->flags & RADEON_NEW_MEMMAP) && !dev_priv->new_memmap)
 	{
 		DRM_ERROR("Cannot initialise DRM on this card\nThis card requires a new X.org DDX\n");
 		radeon_do_cleanup_cp(dev);
 		return DRM_ERR(EINVAL);
 	}
 
-	if (init->is_pci && (dev_priv->flags & CHIP_IS_AGP))
+	if (init->is_pci && (dev_priv->flags & RADEON_IS_AGP))
 	{
 		DRM_DEBUG("Forcing AGP card to PCI mode\n");
-		dev_priv->flags &= ~CHIP_IS_AGP;
+		dev_priv->flags &= ~RADEON_IS_AGP;
 	}
 
-	if ((!(dev_priv->flags & CHIP_IS_AGP)) && !dev->sg) {
+	if ((!(dev_priv->flags & RADEON_IS_AGP)) && !dev->sg) {
 		DRM_ERROR("PCI GART memory not allocated!\n");
 		radeon_do_cleanup_cp(dev);
 		return DRM_ERR(EINVAL);
@@ -1489,7 +1489,7 @@ static int radeon_do_init_cp(drm_device_
 				    init->sarea_priv_offset);
 
 #if __OS_HAS_AGP
-	if (dev_priv->flags & CHIP_IS_AGP) {
+	if (dev_priv->flags & RADEON_IS_AGP) {
 		drm_core_ioremap(dev_priv->cp_ring, dev);
 		drm_core_ioremap(dev_priv->ring_rptr, dev);
 		drm_core_ioremap(dev->agp_buffer_map, dev);
@@ -1548,7 +1548,7 @@ #endif
 		 * align it down.
 		 */
 #if __OS_HAS_AGP
-		if (dev_priv->flags & CHIP_IS_AGP) {
+		if (dev_priv->flags & RADEON_IS_AGP) {
 			base = dev->agp->base;
 			/* Check if valid */
 			if ((base + dev_priv->gart_size) > dev_priv->fb_location &&
@@ -1578,7 +1578,7 @@ #endif
 	}
 
 #if __OS_HAS_AGP
-	if (dev_priv->flags & CHIP_IS_AGP)
+	if (dev_priv->flags & RADEON_IS_AGP)
 		dev_priv->gart_buffers_offset = (dev->agp_buffer_map->offset
 						 - dev->agp->base
 						 + dev_priv->gart_vm_start);
@@ -1604,7 +1604,7 @@ #endif
 	dev_priv->ring.high_mark = RADEON_RING_HIGH_MARK;
 
 #if __OS_HAS_AGP
-	if (dev_priv->flags & CHIP_IS_AGP) {
+	if (dev_priv->flags & RADEON_IS_AGP) {
 		/* Turn off PCI GART */
 		radeon_set_pcigart(dev_priv, 0);
 	} else
@@ -1624,7 +1624,7 @@ #endif
 			    dev_priv->gart_info.mapping.handle;
 
 			dev_priv->gart_info.is_pcie =
-			    !!(dev_priv->flags & CHIP_IS_PCIE);
+			    !!(dev_priv->flags & RADEON_IS_PCIE);
 			dev_priv->gart_info.gart_table_location =
 			    DRM_ATI_GART_FB;
 
@@ -1636,7 +1636,7 @@ #endif
 			    DRM_ATI_GART_MAIN;
 			dev_priv->gart_info.addr = NULL;
 			dev_priv->gart_info.bus_addr = 0;
-			if (dev_priv->flags & CHIP_IS_PCIE) {
+			if (dev_priv->flags & RADEON_IS_PCIE) {
 				DRM_ERROR
 				    ("Cannot use PCI Express without GART in FB memory\n");
 				radeon_do_cleanup_cp(dev);
@@ -1678,7 +1678,7 @@ static int radeon_do_cleanup_cp(drm_devi
 		drm_irq_uninstall(dev);
 
 #if __OS_HAS_AGP
-	if (dev_priv->flags & CHIP_IS_AGP) {
+	if (dev_priv->flags & RADEON_IS_AGP) {
 		if (dev_priv->cp_ring != NULL) {
 			drm_core_ioremapfree(dev_priv->cp_ring, dev);
 			dev_priv->cp_ring = NULL;
@@ -1733,7 +1733,7 @@ static int radeon_do_resume_cp(drm_devic
 	DRM_DEBUG("Starting radeon_do_resume_cp()\n");
 
 #if __OS_HAS_AGP
-	if (dev_priv->flags & CHIP_IS_AGP) {
+	if (dev_priv->flags & RADEON_IS_AGP) {
 		/* Turn off PCI GART */
 		radeon_set_pcigart(dev_priv, 0);
 	} else
@@ -2177,13 +2177,13 @@ int radeon_driver_load(struct drm_device
 	dev->dev_private = (void *)dev_priv;
 	dev_priv->flags = flags;
 
-	switch (flags & CHIP_FAMILY_MASK) {
+	switch (flags & RADEON_FAMILY_MASK) {
 	case CHIP_R100:
 	case CHIP_RV200:
 	case CHIP_R200:
 	case CHIP_R300:
 	case CHIP_R420:
-		dev_priv->flags |= CHIP_HAS_HIERZ;
+		dev_priv->flags |= RADEON_HAS_HIERZ;
 		break;
 	default:
 		/* all other chips have no hierarchical z buffer */
@@ -2191,13 +2191,13 @@ int radeon_driver_load(struct drm_device
 	}
 
 	if (drm_device_is_agp(dev))
-		dev_priv->flags |= CHIP_IS_AGP;
+		dev_priv->flags |= RADEON_IS_AGP;
 
 	if (drm_device_is_pcie(dev))
-		dev_priv->flags |= CHIP_IS_PCIE;
+		dev_priv->flags |= RADEON_IS_PCIE;
 
 	DRM_DEBUG("%s card detected\n",
-		  ((dev_priv->flags & CHIP_IS_AGP) ? "AGP" : (((dev_priv->flags & CHIP_IS_PCIE) ? "PCIE" : "PCI"))));
+		  ((dev_priv->flags & RADEON_IS_AGP) ? "AGP" : (((dev_priv->flags & RADEON_IS_PCIE) ? "PCIE" : "PCI"))));
 	return ret;
 }
 
diff --git a/drivers/char/drm/radeon_drv.c b/drivers/char/drm/radeon_drv.c
index eb985c2..50b2e6a 100644
--- a/drivers/char/drm/radeon_drv.c
+++ b/drivers/char/drm/radeon_drv.c
@@ -31,6 +31,8 @@
 
 #include "drmP.h"
 #include "drm.h"
+#include <linux/pm.h>
+#include <linux/radeon_gpu.h>
 #include "radeon_drm.h"
 #include "radeon_drv.h"
 
@@ -44,7 +46,7 @@ module_param_named(no_wb, radeon_no_wb, 
 static int dri_library_name(struct drm_device *dev, char *buf)
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
-	int family = dev_priv->flags & CHIP_FAMILY_MASK;
+	int family = dev_priv->flags & RADEON_FAMILY_MASK;
 
 	return snprintf(buf, PAGE_SIZE, "%s\n",
 		        (family < CHIP_R200) ? "radeon" :
@@ -52,10 +54,27 @@ static int dri_library_name(struct drm_d
 		        "r300"));
 }
 
+static int __devinit radeondrm_gpu_register (struct gpu_device *gdev, void *driver_id);
+static void __devexit radeondrm_gpu_unregister (struct gpu_device *gdev);
+
 static struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
 
+static int radeondrm_suspend(struct device *dev, pm_message_t state)
+{
+//	struct gpu_device *gdev = to_gpu_device(dev);
+	printk("%s: called\n", __FUNCTION__);
+	return 0;
+}
+
+static int radeondrm_resume(struct device *dev)
+{
+//	struct gpu_device *gdev = to_gpu_device(dev);
+	printk("%s: called\n", __FUNCTION__);
+	return 0;
+}
+
 static struct drm_driver driver = {
 	.driver_features =
 	    DRIVER_USE_AGP | DRIVER_USE_MTRR | DRIVER_PCI_DMA | DRIVER_SG |
@@ -92,12 +111,18 @@ #ifdef CONFIG_COMPAT
 		 .compat_ioctl = radeon_compat_ioctl,
 #endif
 	},
-
-	.pci_driver = {
+	.drv_type = DRM_DRV_GPU,
+	.gpu_driver = {
 		 .name = DRIVER_NAME,
-		 .id_table = pciidlist,
-	},
-
+		 .drv_type = GPU_DRM,
+		 .driver = {
+		             .suspend = radeondrm_suspend,
+			     .resume = radeondrm_resume,
+		 },
+		 .probe = radeondrm_gpu_register,
+		 .remove = __devexit_p(radeondrm_gpu_unregister),
+		 .id_table = (void *)pciidlist,
+	 },
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESC,
 	.date = DRIVER_DATE,
@@ -106,15 +131,34 @@ #endif
 	.patchlevel = DRIVER_PATCHLEVEL,
 };
 
+
+static int __devinit radeondrm_gpu_register(struct gpu_device *gdev, void *driver_id)
+{
+	int retval;
+	struct radeon_gpu_info *gpu_info;
+
+	gpu_info = dev_get_drvdata(gdev->dev.parent);
+
+	retval = drm_gpu_get_dev(gdev, &driver, driver_id, gpu_info->pdev);
+	return retval;
+}
+
+static void __devexit radeondrm_gpu_unregister (struct gpu_device *gdev)
+{
+	drm_gpu_cleanup(gdev);
+}
+
 static int __init radeon_init(void)
 {
 	driver.num_ioctls = radeon_max_ioctl;
-	return drm_init(&driver);
+	drm_mem_init();
+
+	return radeon_gpu_register_driver(&driver.gpu_driver, THIS_MODULE);
 }
 
 static void __exit radeon_exit(void)
 {
-	drm_exit(&driver);
+	gpu_unregister_driver(&driver.gpu_driver);
 }
 
 module_init(radeon_init);
diff --git a/drivers/char/drm/radeon_drv.h b/drivers/char/drm/radeon_drv.h
index e5a256f..e9e20b3 100644
--- a/drivers/char/drm/radeon_drv.h
+++ b/drivers/char/drm/radeon_drv.h
@@ -103,7 +103,7 @@ #define DRIVER_PATCHLEVEL	0
 /*
  * Radeon chip families
  */
-enum radeon_family {
+enum radeondrm_family {
 	CHIP_R100,
 	CHIP_RV100,
 	CHIP_RS100,
@@ -132,16 +132,16 @@ enum radeon_cp_microcode_version {
 /*
  * Chip flags
  */
-enum radeon_chip_flags {
-	CHIP_FAMILY_MASK = 0x0000ffffUL,
-	CHIP_FLAGS_MASK = 0xffff0000UL,
-	CHIP_IS_MOBILITY = 0x00010000UL,
-	CHIP_IS_IGP = 0x00020000UL,
-	CHIP_SINGLE_CRTC = 0x00040000UL,
-	CHIP_IS_AGP = 0x00080000UL,
-	CHIP_HAS_HIERZ = 0x00100000UL,
-	CHIP_IS_PCIE = 0x00200000UL,
-	CHIP_NEW_MEMMAP = 0x00400000UL,
+enum radeondrm_chip_flags {
+	RADEON_FAMILY_MASK = 0x0000ffffUL,
+	RADEON_FLAGS_MASK = 0xffff0000UL,
+	RADEON_IS_MOBILITY = 0x00010000UL,
+	RADEON_IS_IGP = 0x00020000UL,
+	RADEON_SINGLE_CRTC = 0x00040000UL,
+	RADEON_IS_AGP = 0x00080000UL,
+	RADEON_HAS_HIERZ = 0x00100000UL,
+	RADEON_IS_PCIE = 0x00200000UL,
+	RADEON_NEW_MEMMAP = 0x00400000UL,
 };
 
 #define GET_RING_HEAD(dev_priv)	(dev_priv->writeback_works ? \
diff --git a/drivers/char/drm/radeon_state.c b/drivers/char/drm/radeon_state.c
index 5bb2234..220e060 100644
--- a/drivers/char/drm/radeon_state.c
+++ b/drivers/char/drm/radeon_state.c
@@ -862,7 +862,7 @@ static void radeon_cp_dispatch_clear(drm
 		 */
 		dev_priv->sarea_priv->ctx_owner = 0;
 
-		if ((dev_priv->flags & CHIP_HAS_HIERZ)
+		if ((dev_priv->flags & RADEON_HAS_HIERZ)
 		    && (flags & RADEON_USE_HIERZ)) {
 			/* FIXME : reverse engineer that for Rx00 cards */
 			/* FIXME : the mask supposedly contains low-res z values. So can't set
@@ -907,7 +907,7 @@ static void radeon_cp_dispatch_clear(drm
 		for (i = 0; i < nbox; i++) {
 			int tileoffset, nrtilesx, nrtilesy, j;
 			/* it looks like r200 needs rv-style clears, at least if hierz is not enabled? */
-			if ((dev_priv->flags & CHIP_HAS_HIERZ)
+			if ((dev_priv->flags & RADEON_HAS_HIERZ)
 			    && !(dev_priv->microcode_version == UCODE_R200)) {
 				/* FIXME : figure this out for r200 (when hierz is enabled). Or
 				   maybe r200 actually doesn't need to put the low-res z value into
@@ -991,7 +991,7 @@ static void radeon_cp_dispatch_clear(drm
 		}
 
 		/* TODO don't always clear all hi-level z tiles */
-		if ((dev_priv->flags & CHIP_HAS_HIERZ)
+		if ((dev_priv->flags & RADEON_HAS_HIERZ)
 		    && (dev_priv->microcode_version == UCODE_R200)
 		    && (flags & RADEON_USE_HIERZ))
 			/* r100 and cards without hierarchical z-buffer have no high-level z-buffer */
@@ -2982,9 +2982,9 @@ #endif
 		break;
 	
 	case RADEON_PARAM_CARD_TYPE:
-		if (dev_priv->flags & CHIP_IS_PCIE)
+		if (dev_priv->flags & RADEON_IS_PCIE)
 			value = RADEON_CARD_PCIE;
-		else if (dev_priv->flags & CHIP_IS_AGP)
+		else if (dev_priv->flags & RADEON_IS_AGP)
 			value = RADEON_CARD_AGP;
 		else
 			value = RADEON_CARD_PCI;
-- 
1.4.1.ga3e6

