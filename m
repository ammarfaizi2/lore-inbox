Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965236AbVKPDvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbVKPDvA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965226AbVKPDut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:50:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:27806 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965225AbVKPDud
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:50:33 -0500
To: torvalds@osdl.org
Subject: [PATCH 3/8] isaectomy: g_NCR5380
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Message-Id: <E1EcEJc-0007dq-8T@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 16 Nov 2005 03:50:32 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1132110458 -0500

switched CONFIG_SCSI_G_NCR5380_MEM code in g_NCR5380 to ioremap(); massaged
g_NCR5380.h accordingly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 drivers/scsi/g_NCR5380.c |   28 +++++++++++++++++++++-------
 drivers/scsi/g_NCR5380.h |   23 +++++++++++++++++------
 2 files changed, 38 insertions(+), 13 deletions(-)

6432444077b99d420f973ce8f1e748792f50a161
diff --git a/drivers/scsi/g_NCR5380.c b/drivers/scsi/g_NCR5380.c
--- a/drivers/scsi/g_NCR5380.c
+++ b/drivers/scsi/g_NCR5380.c
@@ -127,7 +127,7 @@ static int ncr_53c400a = NCR_NOT_SET;
 static int dtc_3181e = NCR_NOT_SET;
 
 static struct override {
-	NCR5380_implementation_fields;
+	NCR5380_map_type NCR5380_map_name;
 	int irq;
 	int dma;
 	int board;		/* Use NCR53c400, Ricoh, etc. extensions ? */
@@ -299,6 +299,10 @@ int __init generic_NCR5380_detect(struct
 	};
 	int flags = 0;
 	struct Scsi_Host *instance;
+#ifdef CONFIG_SCSI_G_NCR5380_MEM
+	unsigned long base;
+	void __iomem *iomem;
+#endif
 
 	if (ncr_irq != NCR_NOT_SET)
 		overrides[0].irq = ncr_irq;
@@ -424,15 +428,22 @@ int __init generic_NCR5380_detect(struct
 			region_size = NCR5380_region_size;
 		}
 #else
-		if(!request_mem_region(overrides[current_override].NCR5380_map_name, NCR5380_region_size, "ncr5380"))
+		base = overrides[current_override].NCR5380_map_name;
+		if (!request_mem_region(base, NCR5380_region_size, "ncr5380"))
+			continue;
+		iomem = ioremap(base, NCR5380_region_size);
+		if (!iomem) {
+			release_mem_region(base, NCR5380_region_size);
 			continue;
+		}
 #endif
 		instance = scsi_register(tpnt, sizeof(struct NCR5380_hostdata));
 		if (instance == NULL) {
 #ifndef CONFIG_SCSI_G_NCR5380_MEM
 			release_region(overrides[current_override].NCR5380_map_name, region_size);
 #else
-			release_mem_region(overrides[current_override].NCR5380_map_name, NCR5380_region_size);
+			iounmap(iomem);
+			release_mem_region(base, NCR5380_region_size);
 #endif
 			continue;
 		}
@@ -440,6 +451,8 @@ int __init generic_NCR5380_detect(struct
 		instance->NCR5380_instance_name = overrides[current_override].NCR5380_map_name;
 #ifndef CONFIG_SCSI_G_NCR5380_MEM
 		instance->n_io_port = region_size;
+#else
+		((struct NCR5380_hostdata *)instance->hostdata).iomem = iomem;
 #endif
 
 		NCR5380_init(instance, flags);
@@ -509,6 +522,7 @@ int generic_NCR5380_release_resources(st
 #ifndef CONFIG_SCSI_G_NCR5380_MEM
 	release_region(instance->NCR5380_instance_name, instance->n_io_port);
 #else
+	iounmap(((struct NCR5380_hostdata *)instance->hostdata).iomem);
 	release_mem_region(instance->NCR5380_instance_name, NCR5380_region_size);
 #endif
 
@@ -586,7 +600,7 @@ static inline int NCR5380_pread(struct S
 		}
 #else
 		/* implies CONFIG_SCSI_G_NCR5380_MEM */
-		isa_memcpy_fromio(dst + start, NCR53C400_host_buffer + NCR5380_map_name, 128);
+		memcpy_fromio(dst + start, iomem + NCR53C400_host_buffer, 128);
 #endif
 		start += 128;
 		blocks--;
@@ -606,7 +620,7 @@ static inline int NCR5380_pread(struct S
 		}
 #else
 		/* implies CONFIG_SCSI_G_NCR5380_MEM */
-		isa_memcpy_fromio(dst + start, NCR53C400_host_buffer + NCR5380_map_name, 128);
+		memcpy_fromio(dst + start, iomem + NCR53C400_host_buffer, 128);
 #endif
 		start += 128;
 		blocks--;
@@ -671,7 +685,7 @@ static inline int NCR5380_pwrite(struct 
 		}
 #else
 		/* implies CONFIG_SCSI_G_NCR5380_MEM */
-		isa_memcpy_toio(NCR53C400_host_buffer + NCR5380_map_name, src + start, 128);
+		memcpy_toio(iomem + NCR53C400_host_buffer, src + start, 128);
 #endif
 		start += 128;
 		blocks--;
@@ -687,7 +701,7 @@ static inline int NCR5380_pwrite(struct 
 		}
 #else
 		/* implies CONFIG_SCSI_G_NCR5380_MEM */
-		isa_memcpy_toio(NCR53C400_host_buffer + NCR5380_map_name, src + start, 128);
+		memcpy_toio(iomem + NCR53C400_host_buffer, src + start, 128);
 #endif
 		start += 128;
 		blocks--;
diff --git a/drivers/scsi/g_NCR5380.h b/drivers/scsi/g_NCR5380.h
--- a/drivers/scsi/g_NCR5380.h
+++ b/drivers/scsi/g_NCR5380.h
@@ -82,6 +82,15 @@ static const char* generic_NCR5380_info(
 #define NCR5380_read(reg) (inb(NCR5380_map_name + (reg)))
 #define NCR5380_write(reg, value) (outb((value), (NCR5380_map_name + (reg))))
 
+#define NCR5380_implementation_fields \
+    NCR5380_map_type NCR5380_map_name
+
+#define NCR5380_local_declare() \
+    register NCR5380_implementation_fields
+
+#define NCR5380_setup(instance) \
+    NCR5380_map_name = (NCR5380_map_type)((instance)->NCR5380_instance_name)
+
 #else 
 /* therefore CONFIG_SCSI_G_NCR5380_MEM */
 
@@ -95,18 +104,20 @@ static const char* generic_NCR5380_info(
 #define NCR53C400_host_buffer 0x3900
 #define NCR5380_region_size 0x3a00
 
-#define NCR5380_read(reg) isa_readb(NCR5380_map_name + NCR53C400_mem_base + (reg))
-#define NCR5380_write(reg, value) isa_writeb(value, NCR5380_map_name + NCR53C400_mem_base + (reg))
-#endif
+#define NCR5380_read(reg) readb(iomem + NCR53C400_mem_base + (reg))
+#define NCR5380_write(reg, value) writeb(value, iomem + NCR53C400_mem_base + (reg))
 
 #define NCR5380_implementation_fields \
-    NCR5380_map_type NCR5380_map_name
+    NCR5380_map_type NCR5380_map_name; \
+    void __iomem *iomem;
 
 #define NCR5380_local_declare() \
-    register NCR5380_implementation_fields
+    register void __iomem *iomem
 
 #define NCR5380_setup(instance) \
-    NCR5380_map_name = (NCR5380_map_type)((instance)->NCR5380_instance_name)
+    iomem = (((struct NCR5380_hostdata *)(instance)->hostdata).iomem)
+
+#endif
 
 #define NCR5380_intr generic_NCR5380_intr
 #define NCR5380_queue_command generic_NCR5380_queue_command

