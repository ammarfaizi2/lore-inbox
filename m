Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263521AbTDYJhu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 05:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTDYJhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 05:37:50 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:49681 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263521AbTDYJhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 05:37:48 -0400
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi_to_dma_dir
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 25 Apr 2003 11:48:00 +0200
Message-ID: <wrpu1cmsyb3.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James,

Christoph suggested that I send you the following patch, rather than
having it in the aha1740 driver... It adds scsi_to_dma_dir, similar to
scsi_to_{sbus,pci}_dir.

It is conditionnaly defined on CONFIG_EISA or CONFIG_MCA, because most
non-PCI archs are still including asm-generic/dma-mapping.h and its
bunch of PCI functions...

Patch is against 2.5.68.

Thanks,

        M.

===== drivers/scsi/scsi.h 1.73 vs edited =====
--- 1.73/drivers/scsi/scsi.h	Fri Apr 18 17:58:55 2003
+++ edited/drivers/scsi/scsi.h	Thu Apr 24 18:40:31 2003
@@ -67,6 +67,32 @@
 #endif
 #endif
 
+#if defined(CONFIG_EISA) || defined(CONFIG_MCA)
+/*
+ * XXX FIXME :
+ *  
+ * We should be able to have this unconditionnaly
+ * defined. Unfortunately, most non-PCI architectures are still
+ * including asm-generic/dma-mapping.h, which has lots of references
+ * to PCI functions...
+ */
+#include <linux/dma-mapping.h>
+#if ((SCSI_DATA_UNKNOWN == DMA_BIDIRECTIONAL) && (SCSI_DATA_WRITE == DMA_TO_DEVICE) && (SCSI_DATA_READ == DMA_FROM_DEVICE) && (SCSI_DATA_NONE == DMA_NONE))
+#define scsi_to_dma_dir(scsi_dir)   ((enum dma_data_direction)(scsi_dir))
+#else
+extern __inline__ enum dma_data_direction scsi_to_dma_dir(unsigned char scsi_dir)
+{
+        if (scsi_dir == SCSI_DATA_UNKNOWN)
+                return DMA_BIDIRECTIONAL;
+        if (scsi_dir == SCSI_DATA_WRITE)
+                return DMA_TO_DEVICE;
+        if (scsi_dir == SCSI_DATA_READ)
+                return DMA_FROM_DEVICE;
+        return DMA_NONE;
+}
+#endif
+#endif
+
 /*
  * Some defs, in case these are not defined elsewhere.
  */

-- 
Places change, faces change. Life is so very strange.
