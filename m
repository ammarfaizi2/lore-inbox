Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVKLEhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVKLEhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbVKLEhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:37:14 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2569 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751273AbVKLEhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:37:12 -0500
Date: Sat, 12 Nov 2005 05:37:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] removed useless SCSI_GENERIC_NCR5380_MMIO
Message-ID: <20051112043707.GX5376@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the useless SCSI_GENERIC_NCR5380_MMIO.

It's useless, since SCSI_G_NCR5380_MEM != CONFIG_SCSI_G_NCR5380_MEM.

This issue exists at least since kernel 2.6.0 and since it seems noone 
noticed it I'd say we can safely remove it.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/Kconfig          |   14 -------------
 drivers/scsi/Makefile         |    1 
 drivers/scsi/g_NCR5380.c      |   36 ----------------------------------
 drivers/scsi/g_NCR5380.h      |   19 -----------------
 drivers/scsi/g_NCR5380_mmio.c |   10 ---------
 5 files changed, 80 deletions(-)

--- linux-2.6.14-mm2-full/drivers/scsi/Kconfig.old	2005-11-12 01:16:47.000000000 +0100
+++ linux-2.6.14-mm2-full/drivers/scsi/Kconfig	2005-11-12 01:17:05.000000000 +0100
@@ -846,20 +846,6 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called g_NCR5380.
 
-config SCSI_GENERIC_NCR5380_MMIO
-	tristate "Generic NCR5380/53c400 SCSI MMIO support"
-	depends on ISA && SCSI
-	---help---
-	  This is a driver for the old NCR 53c80 series of SCSI controllers
-	  on boards using memory mapped I/O. 
-	  It is explained in section 3.8 of the SCSI-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.  If it doesn't work out
-	  of the box, you may have to change some settings in
-	  <file:drivers/scsi/g_NCR5380.h>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called g_NCR5380_mmio.
-
 config SCSI_GENERIC_NCR53C400
 	bool "Enable NCR53c400 extensions"
 	depends on SCSI_GENERIC_NCR5380
--- linux-2.6.14-mm2-full/drivers/scsi/Makefile.old	2005-11-12 01:17:15.000000000 +0100
+++ linux-2.6.14-mm2-full/drivers/scsi/Makefile	2005-11-12 01:17:21.000000000 +0100
@@ -74,7 +74,6 @@
 obj-$(CONFIG_SCSI_FUTURE_DOMAIN)+= fdomain.o
 obj-$(CONFIG_SCSI_IN2000)	+= in2000.o
 obj-$(CONFIG_SCSI_GENERIC_NCR5380) += g_NCR5380.o
-obj-$(CONFIG_SCSI_GENERIC_NCR5380_MMIO) += g_NCR5380_mmio.o
 obj-$(CONFIG_SCSI_NCR53C406A)	+= NCR53c406a.o
 obj-$(CONFIG_SCSI_NCR_D700)	+= 53c700.o NCR_D700.o
 obj-$(CONFIG_SCSI_NCR_Q720)	+= NCR_Q720_mod.o
--- linux-2.6.14-mm2-full/drivers/scsi/g_NCR5380.h.old	2005-11-12 01:17:34.000000000 +0100
+++ linux-2.6.14-mm2-full/drivers/scsi/g_NCR5380.h	2005-11-12 01:17:48.000000000 +0100
@@ -64,8 +64,6 @@
 #define __STRVAL(x) #x
 #define STRVAL(x) __STRVAL(x)
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
-
 #define NCR5380_map_config port
 #define NCR5380_map_type int
 #define NCR5380_map_name port
@@ -82,23 +80,6 @@
 #define NCR5380_read(reg) (inb(NCR5380_map_name + (reg)))
 #define NCR5380_write(reg, value) (outb((value), (NCR5380_map_name + (reg))))
 
-#else 
-/* therefore CONFIG_SCSI_G_NCR5380_MEM */
-
-#define NCR5380_map_config memory
-#define NCR5380_map_type unsigned long
-#define NCR5380_map_name base
-#define NCR5380_instance_name base
-#define NCR53C400_register_offset 0x108
-#define NCR53C400_address_adjust 0
-#define NCR53C400_mem_base 0x3880
-#define NCR53C400_host_buffer 0x3900
-#define NCR5380_region_size 0x3a00
-
-#define NCR5380_read(reg) isa_readb(NCR5380_map_name + NCR53C400_mem_base + (reg))
-#define NCR5380_write(reg, value) isa_writeb(value, NCR5380_map_name + NCR53C400_mem_base + (reg))
-#endif
-
 #define NCR5380_implementation_fields \
     NCR5380_map_type NCR5380_map_name
 
--- linux-2.6.14-mm2-full/drivers/scsi/g_NCR5380.c.old	2005-11-12 01:17:57.000000000 +0100
+++ linux-2.6.14-mm2-full/drivers/scsi/g_NCR5380.c	2005-11-12 01:19:01.000000000 +0100
@@ -373,7 +373,6 @@
 			break;
 		}
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
 		if (ports) {
 			/* wakeup sequence for the NCR53C400A and DTC3181E */
 
@@ -423,24 +422,14 @@
 				continue;
 			region_size = NCR5380_region_size;
 		}
-#else
-		if(!request_mem_region(overrides[current_override].NCR5380_map_name, NCR5380_region_size, "ncr5380"))
-			continue;
-#endif
 		instance = scsi_register(tpnt, sizeof(struct NCR5380_hostdata));
 		if (instance == NULL) {
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
 			release_region(overrides[current_override].NCR5380_map_name, region_size);
-#else
-			release_mem_region(overrides[current_override].NCR5380_map_name, NCR5380_region_size);
-#endif
 			continue;
 		}
 
 		instance->NCR5380_instance_name = overrides[current_override].NCR5380_map_name;
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
 		instance->n_io_port = region_size;
-#endif
 
 		NCR5380_init(instance, flags);
 
@@ -506,12 +495,7 @@
 		free_irq(instance->irq, NULL);
 	NCR5380_exit(instance);
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
 	release_region(instance->NCR5380_instance_name, instance->n_io_port);
-#else
-	release_mem_region(instance->NCR5380_instance_name, NCR5380_region_size);
-#endif
-
 
 	return 0;
 }
@@ -578,16 +562,11 @@
 		}
 		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY);
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
 		{
 			int i;
 			for (i = 0; i < 128; i++)
 				dst[start + i] = NCR5380_read(C400_HOST_BUFFER);
 		}
-#else
-		/* implies CONFIG_SCSI_G_NCR5380_MEM */
-		isa_memcpy_fromio(dst + start, NCR53C400_host_buffer + NCR5380_map_name, 128);
-#endif
 		start += 128;
 		blocks--;
 	}
@@ -598,16 +577,11 @@
 			// FIXME - no timeout
 		}
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
 		{
 			int i;	
 			for (i = 0; i < 128; i++)
 				dst[start + i] = NCR5380_read(C400_HOST_BUFFER);
 		}
-#else
-		/* implies CONFIG_SCSI_G_NCR5380_MEM */
-		isa_memcpy_fromio(dst + start, NCR53C400_host_buffer + NCR5380_map_name, 128);
-#endif
 		start += 128;
 		blocks--;
 	}
@@ -664,15 +638,10 @@
 		}
 		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY)
 			; // FIXME - timeout
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
 		{
 			for (i = 0; i < 128; i++)
 				NCR5380_write(C400_HOST_BUFFER, src[start + i]);
 		}
-#else
-		/* implies CONFIG_SCSI_G_NCR5380_MEM */
-		isa_memcpy_toio(NCR53C400_host_buffer + NCR5380_map_name, src + start, 128);
-#endif
 		start += 128;
 		blocks--;
 	}
@@ -680,15 +649,10 @@
 		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY)
 			; // FIXME - no timeout
 
-#ifndef CONFIG_SCSI_G_NCR5380_MEM
 		{
 			for (i = 0; i < 128; i++)
 				NCR5380_write(C400_HOST_BUFFER, src[start + i]);
 		}
-#else
-		/* implies CONFIG_SCSI_G_NCR5380_MEM */
-		isa_memcpy_toio(NCR53C400_host_buffer + NCR5380_map_name, src + start, 128);
-#endif
 		start += 128;
 		blocks--;
 	}
--- linux-2.6.14-mm2-full/drivers/scsi/g_NCR5380_mmio.c	2005-10-28 02:02:08.000000000 +0200
+++ /dev/null	2005-11-08 19:07:57.000000000 +0100
@@ -1,10 +0,0 @@
-/*
- *	There is probably a nicer way to do this but this one makes
- *	pretty obvious what is happening. We rebuild the same file with
- *	different options for mmio versus pio.
- */
-
-#define SCSI_G_NCR5380_MEM
-
-#include "g_NCR5380.c"
-

