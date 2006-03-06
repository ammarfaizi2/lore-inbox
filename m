Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751131AbWCFEft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWCFEft (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 23:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWCFEfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 23:35:48 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:62343 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1751131AbWCFEfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 23:35:48 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       airlied@linux.ie
Subject: [PATCH] basic drm driver for Trident CyberBlade
Date: Sun, 5 Mar 2006 20:35:40 -0800
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dw7CEhiw07xBdFq"
Message-Id: <200603052035.41084.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_dw7CEhiw07xBdFq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I'm trying to get the CyberBlade EXA driver into a bit better shape, and 
that means some sort of decent host<->fb DMA support.  The device 
itself is apparently capable of that, but EXA has trouble since it only 
has the user virtual address of the transfers it wants to make, so I 
thought a DRM driver might be in order.  It's also necessary for decent 
VBLANK support, which will hopefully be pretty straightforward.  Note 
that at this point, the DRM driver won't do you any good since I 
haven't checked the EXA stuff that uses it into X.Org CVS yet (and 
afaik there's no DRI driver for this device either).

Any thoughts on how the host<->fb DMA stuff should work?  Basically EXA 
UploadToScreen wants to hand the card a virtual address range and have 
it loaded up to the card's VRAM; DownloadFromScreen wants to do the 
same in reverse.  Should I just add a device specific DRM_IOCTL to 
accomplish this (using get_user_pages() etc.) or is there some existing 
code I could leverage?

Thanks,
Jesse

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

--Boundary-00=_dw7CEhiw07xBdFq
Content-Type: text/x-diff;
  charset="us-ascii";
  name="blade-drm-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="blade-drm-2.patch"

diff --git a/drivers/char/drm/Makefile b/drivers/char/drm/Makefile
index 9d180c4..a212175 100644
--- a/drivers/char/drm/Makefile
+++ b/drivers/char/drm/Makefile
@@ -8,6 +8,7 @@ drm-objs    :=	drm_auth.o drm_bufs.o drm
 		drm_agpsupport.o drm_scatter.o ati_pcigart.o drm_pci.o \
 		drm_sysfs.o
 
+blade-objs  := blade_drv.o
 tdfx-objs   := tdfx_drv.o
 r128-objs   := r128_drv.o r128_cce.o r128_state.o r128_irq.o
 mga-objs    := mga_drv.o mga_dma.o mga_state.o mga_warp.o mga_irq.o
@@ -30,6 +31,7 @@ endif
 
 obj-$(CONFIG_DRM)	+= drm.o
 obj-$(CONFIG_DRM_TDFX)	+= tdfx.o
+obj-$(CONFIG_DRM_BLADE) += blade.o
 obj-$(CONFIG_DRM_R128)	+= r128.o
 obj-$(CONFIG_DRM_RADEON)+= radeon.o
 obj-$(CONFIG_DRM_MGA)	+= mga.o
--- /dev/null	2006-03-02 18:11:38.777108750 -0800
+++ drivers/char/drm/blade_drv.c	2006-03-05 20:24:53.000000000 -0800
@@ -0,0 +1,117 @@
+/*
+ * Copyright 2006 Jesse Barnes <jbarnes@virtuousgeek.org>
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * PRECISION INSIGHT AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * Authors:
+ *    Jesse Barnes <jbarnes@virtuousgeek.org>
+ */
+
+#include <linux/config.h>
+#include "drm_pciids.h"
+#include "drmP.h"
+
+#define DRIVER_AUTHOR		"Jesse Barnes"
+
+#define DRIVER_NAME		"blade_drm"
+#define DRIVER_DESC		"Trident CyberBlade"
+#define DRIVER_DATE		"20060303"
+
+#define DRIVER_MAJOR		1
+#define DRIVER_MINOR		0
+#define DRIVER_PATCHLEVEL	0
+
+static struct pci_device_id blade_pciids[] = {
+	blade_PCI_IDS
+};
+
+static struct drm_driver blade_driver = {
+	.driver_features = (DRIVER_USE_AGP | DRIVER_USE_MTRR |
+			    DRIVER_PCI_DMA | DRIVER_SG | DRIVER_HAVE_DMA |
+			    DRIVER_HAVE_IRQ | DRIVER_FB_DMA), /* IRQ_VBL? */
+	.reclaim_buffers = drm_core_reclaim_buffers,
+	.get_map_ofs = drm_core_get_map_ofs,
+	.get_reg_ofs = drm_core_get_reg_ofs,
+	.fops = {
+		 .owner = THIS_MODULE,
+		 .open = drm_open,
+		 .release = drm_release,
+		 .ioctl = drm_ioctl,
+		 .mmap = drm_mmap,
+		 .poll = drm_poll,
+		 .fasync = drm_fasync,
+	},
+	.pci_driver = {
+		 .name = DRIVER_NAME,
+		 .id_table = blade_pciids,
+	},
+
+	.name = DRIVER_NAME,
+	.desc = DRIVER_DESC,
+	.date = DRIVER_DATE,
+	.major = DRIVER_MAJOR,
+	.minor = DRIVER_MINOR,
+	.patchlevel = DRIVER_PATCHLEVEL,
+};
+
+static int vblank_wait(struct drm_device * dev, unsigned int *sequence)
+{
+	/* Use next vblank interrupt or pending register */
+}
+
+static irqreturn_t irq_handler(DRM_IRQ_ARGS)
+{
+}
+
+static void irq_preinstall(struct drm_device * dev)
+{
+}
+
+static void irq_postinstall(struct drm_device * dev)
+{
+}
+
+static void irq_uninstall(struct drm_device * dev)
+{
+}
+
+static int __init blade_init(void)
+{
+	/*
+	 * TODO:
+	 *   ioremap device resources
+	 *   Setup IRQ for vblank
+	 *   Lots of other stuff (e.g. host<->fb dma stuff)
+	 */
+	return drm_init(&blade_driver);
+}
+
+static void __exit blade_exit(void)
+{
+	drm_exit(&blade_driver);
+}
+
+module_init(blade_init);
+module_exit(blade_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL and additional rights");
diff --git a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
index 56ace9d..10c42b7 100644
--- a/drivers/char/drm/Kconfig
+++ b/drivers/char/drm/Kconfig
@@ -16,6 +16,13 @@ config DRM
 	  details.  You should also select and configure AGP
 	  (/dev/agpgart) support.
 
+config DRM_BLADE
+	tristate "Trident CyberBlade/i1"
+	depends on DRM && PCI
+	help
+	  Choose this option if you have a Trident CyberBlade/i1 device.  If M
+	  is selected, the module will be called blade.
+
 config DRM_TDFX
 	tristate "3dfx Banshee/Voodoo3+"
 	depends on DRM && PCI

--Boundary-00=_dw7CEhiw07xBdFq--
