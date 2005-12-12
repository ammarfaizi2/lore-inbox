Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbVLLBga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVLLBga (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 20:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbVLLBg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 20:36:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18704 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751008AbVLLBfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 20:35:55 -0500
Date: Mon, 12 Dec 2005 02:35:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix drivers/scsi/g_NCR5380_mmio.c
Message-ID: <20051212013555.GL23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/g_NCR5380_mmio.c #define's SCSI_G_NCR5380_MEM, and 
therefore drivers/scsi/g_NCR5380.{h,c} should check for this and not for
CONFIG_SCSI_G_NCR5380_MEM.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/g_NCR5380.c |   24 ++++++++++++------------
 drivers/scsi/g_NCR5380.h |    4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

--- linux-2.6.15-rc5-mm2-full/drivers/scsi/g_NCR5380.h.old	2005-12-12 01:39:09.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/drivers/scsi/g_NCR5380.h	2005-12-12 01:39:26.000000000 +0100
@@ -64,7 +64,7 @@
 #define __STRVAL(x) #x
 #define STRVAL(x) __STRVAL(x)
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
+#ifndef SCSI_G_NCR5380_MEM
 
 #define NCR5380_map_config port
 #define NCR5380_map_type int
@@ -83,7 +83,7 @@
 #define NCR5380_write(reg, value) (outb((value), (NCR5380_map_name + (reg))))
 
 #else 
-/* therefore CONFIG_SCSI_G_NCR5380_MEM */
+/* therefore SCSI_G_NCR5380_MEM */
 
 #define NCR5380_map_config memory
 #define NCR5380_map_type unsigned long
--- linux-2.6.15-rc5-mm2-full/drivers/scsi/g_NCR5380.c.old	2005-12-12 01:39:35.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/drivers/scsi/g_NCR5380.c	2005-12-12 01:39:41.000000000 +0100
@@ -373,7 +373,7 @@
 			break;
 		}
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
+#ifndef SCSI_G_NCR5380_MEM
 		if (ports) {
 			/* wakeup sequence for the NCR53C400A and DTC3181E */
 
@@ -429,7 +429,7 @@
 #endif
 		instance = scsi_register(tpnt, sizeof(struct NCR5380_hostdata));
 		if (instance == NULL) {
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
+#ifndef SCSI_G_NCR5380_MEM
 			release_region(overrides[current_override].NCR5380_map_name, region_size);
 #else
 			release_mem_region(overrides[current_override].NCR5380_map_name, NCR5380_region_size);
@@ -438,7 +438,7 @@
 		}
 
 		instance->NCR5380_instance_name = overrides[current_override].NCR5380_map_name;
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
+#ifndef SCSI_G_NCR5380_MEM
 		instance->n_io_port = region_size;
 #endif
 
@@ -506,7 +506,7 @@
 		free_irq(instance->irq, NULL);
 	NCR5380_exit(instance);
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
+#ifndef SCSI_G_NCR5380_MEM
 	release_region(instance->NCR5380_instance_name, instance->n_io_port);
 #else
 	release_mem_region(instance->NCR5380_instance_name, NCR5380_region_size);
@@ -578,14 +578,14 @@
 		}
 		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY);
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
+#ifndef SCSI_G_NCR5380_MEM
 		{
 			int i;
 			for (i = 0; i < 128; i++)
 				dst[start + i] = NCR5380_read(C400_HOST_BUFFER);
 		}
 #else
-		/* implies CONFIG_SCSI_G_NCR5380_MEM */
+		/* implies SCSI_G_NCR5380_MEM */
 		isa_memcpy_fromio(dst + start, NCR53C400_host_buffer + NCR5380_map_name, 128);
 #endif
 		start += 128;
@@ -598,14 +598,14 @@
 			// FIXME - no timeout
 		}
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
+#ifndef SCSI_G_NCR5380_MEM
 		{
 			int i;	
 			for (i = 0; i < 128; i++)
 				dst[start + i] = NCR5380_read(C400_HOST_BUFFER);
 		}
 #else
-		/* implies CONFIG_SCSI_G_NCR5380_MEM */
+		/* implies SCSI_G_NCR5380_MEM */
 		isa_memcpy_fromio(dst + start, NCR53C400_host_buffer + NCR5380_map_name, 128);
 #endif
 		start += 128;
@@ -664,13 +664,13 @@
 		}
 		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY)
 			; // FIXME - timeout
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
+#ifndef SCSI_G_NCR5380_MEM
 		{
 			for (i = 0; i < 128; i++)
 				NCR5380_write(C400_HOST_BUFFER, src[start + i]);
 		}
 #else
-		/* implies CONFIG_SCSI_G_NCR5380_MEM */
+		/* implies SCSI_G_NCR5380_MEM */
 		isa_memcpy_toio(NCR53C400_host_buffer + NCR5380_map_name, src + start, 128);
 #endif
 		start += 128;
@@ -680,13 +680,13 @@
 		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY)
 			; // FIXME - no timeout
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
+#ifndef SCSI_G_NCR5380_MEM
 		{
 			for (i = 0; i < 128; i++)
 				NCR5380_write(C400_HOST_BUFFER, src[start + i]);
 		}
 #else
-		/* implies CONFIG_SCSI_G_NCR5380_MEM */
+		/* implies SCSI_G_NCR5380_MEM */
 		isa_memcpy_toio(NCR53C400_host_buffer + NCR5380_map_name, src + start, 128);
 #endif
 		start += 128;

