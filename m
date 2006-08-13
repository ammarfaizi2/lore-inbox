Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWHMVAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWHMVAs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWHMVAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:00:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4366 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751471AbWHMVAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:00:34 -0400
Date: Sun, 13 Aug 2006 23:00:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: [-mm patch] drivers/char/drm/: cleanups
Message-ID: <20060813210033.GM3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
>  git-drm.patch
>...
>  git trees
>...

This patch contains the following cleanups:
- make 3 needlessly global functions static
- sis_mm.c: fix compile warnings with CONFIG_FB_SIS=y

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/drm/drm_bufs.c |    4 ++--
 drivers/char/drm/drm_sman.c |    2 +-
 drivers/char/drm/sis_mm.c   |   12 +++++++-----
 3 files changed, 10 insertions(+), 8 deletions(-)

--- linux-2.6.18-rc4-mm1/drivers/char/drm/drm_bufs.c.old	2006-08-13 17:31:20.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/char/drm/drm_bufs.c	2006-08-13 17:31:32.000000000 +0200
@@ -62,14 +62,14 @@
 		}
 	}
 
 	return NULL;
 }
 
-int drm_map_handle(drm_device_t *dev, drm_hash_item_t *hash,
-		   unsigned long user_token, int hashed_handle)
+static int drm_map_handle(drm_device_t *dev, drm_hash_item_t *hash,
+			  unsigned long user_token, int hashed_handle)
 {
 	int use_hashed_handle;
 #if (BITS_PER_LONG == 64)
 	use_hashed_handle = ((user_token & 0xFFFFFFFF00000000UL) || hashed_handle);
 #elif (BITS_PER_LONG == 32)
 	use_hashed_handle = hashed_handle;
--- linux-2.6.18-rc4-mm1/drivers/char/drm/drm_sman.c.old	2006-08-13 17:33:04.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/char/drm/drm_sman.c	2006-08-13 17:33:12.000000000 +0200
@@ -111,13 +111,13 @@
 {
 	drm_mm_t *mm = (drm_mm_t *) private;
 	drm_mm_takedown(mm);
 	drm_free(mm, sizeof(*mm), DRM_MEM_MM);
 }
 
-unsigned long drm_sman_mm_offset(void *private, void *ref)
+static unsigned long drm_sman_mm_offset(void *private, void *ref)
 {
 	drm_mm_node_t *node = (drm_mm_node_t *) ref;
 	return node->start;
 }
 
 int
--- linux-2.6.18-rc4-mm1/drivers/char/drm/sis_mm.c.old	2006-08-13 17:33:27.000000000 +0200
+++ linux-2.6.18-rc4-mm1/drivers/char/drm/sis_mm.c	2006-08-13 18:47:14.000000000 +0200
@@ -37,15 +37,12 @@
 
 #include <video/sisfb.h>
 
 #define VIDEO_TYPE 0
 #define AGP_TYPE 1
 
-#define SIS_MM_ALIGN_SHIFT 4
-#define SIS_MM_ALIGN_MASK ( (1 << SIS_MM_ALIGN_SHIFT) - 1)
-
 #if defined(CONFIG_FB_SIS)
 /* fb management via fb device */
 
 #define SIS_MM_ALIGN_SHIFT 0
 #define SIS_MM_ALIGN_MASK 0
 
@@ -69,18 +66,23 @@
 
 static void sis_sman_mm_destroy(void *private)
 {
 	;
 }
 
-unsigned long sis_sman_mm_offset(void *private, void *ref)
+static unsigned long sis_sman_mm_offset(void *private, void *ref)
 {
 	return ~((unsigned long)ref);
 }
 
-#endif
+#else  /*  CONFIG_FB_SIS  */
+
+#define SIS_MM_ALIGN_SHIFT 4
+#define SIS_MM_ALIGN_MASK ( (1 << SIS_MM_ALIGN_SHIFT) - 1)
+
+#endif  /*  CONFIG_FB_SIS  */
 
 static int sis_fb_init(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_sis_private_t *dev_priv = dev->dev_private;
 	drm_sis_fb_t fb;
