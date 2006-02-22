Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161153AbWBVWOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbWBVWOs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWBVWLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:11:40 -0500
Received: from fmr18.intel.com ([134.134.136.17]:19898 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751496AbWBVWLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:11:11 -0500
Date: Wed, 22 Feb 2006 13:51:33 -0800
From: Randy Dunlap <randy_d_dunlap@linux.intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [PATCH 2/13] ATA ACPI: debugging infrastructure
Message-Id: <20060222135133.3f80fbf9.randy_d_dunlap@linux.intel.com>
In-Reply-To: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
References: <20060222133241.595a8509.randy_d_dunlap@linux.intel.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
X-Face: "}I"O`t9.W]b]8SycP0Jap#<FU!b:16h{lR\#aFEpEf\3c]wtAL|,'>)%JR<P#Yg.88}`$#
 A#bhRMP(=%<w07"0#EoCxXWD%UDdeU]>,H)Eg(FP)?S1qh0ZJRu|mz*%SKpL7rcKI3(OwmK2@uo\b2
 GB:7w&?a,*<8v[ldN`5)MXFcm'cjwRs5)ui)j
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Jeff has already merged this in his tree.)

From: Borislav Petkov <petkov@uni-muenster.de>

libata new debugging macro definitions

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 include/linux/libata.h |   52 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

--- linux-2616-rc4-ata.orig/include/linux/libata.h
+++ linux-2616-rc4-ata/include/linux/libata.h
@@ -36,7 +36,8 @@
 #include <acpi/acpi.h>
 
 /*
- * compile-time options
+ * compile-time options: to be removed as soon as all the drivers are
+ * converted to the new debugging mechanism
  */
 #undef ATA_DEBUG		/* debugging output */
 #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
@@ -72,6 +73,38 @@
         }
 #endif
 
+/* NEW: debug levels */
+#define HAVE_LIBATA_MSG 1
+
+enum {
+	ATA_MSG_DRV	= 0x0001,
+	ATA_MSG_INFO	= 0x0002,
+	ATA_MSG_PROBE	= 0x0004,
+	ATA_MSG_WARN	= 0x0008,
+	ATA_MSG_MALLOC	= 0x0010,
+	ATA_MSG_CTL	= 0x0020,
+	ATA_MSG_INTR	= 0x0040,
+	ATA_MSG_ERR	= 0x0080,
+};
+
+#define ata_msg_drv(p)    ((p)->msg_enable & ATA_MSG_DRV)
+#define ata_msg_info(p)   ((p)->msg_enable & ATA_MSG_INFO)
+#define ata_msg_probe(p)  ((p)->msg_enable & ATA_MSG_PROBE)
+#define ata_msg_warn(p)   ((p)->msg_enable & ATA_MSG_WARN)
+#define ata_msg_malloc(p) ((p)->msg_enable & ATA_MSG_MALLOC)
+#define ata_msg_ctl(p)    ((p)->msg_enable & ATA_MSG_CTL)
+#define ata_msg_intr(p)   ((p)->msg_enable & ATA_MSG_INTR)
+#define ata_msg_err(p)    ((p)->msg_enable & ATA_MSG_ERR)
+
+static inline u32 ata_msg_init(int dval, int default_msg_enable_bits)
+{
+	if (dval < 0 || dval >= (sizeof(u32) * 8))
+		return default_msg_enable_bits; /* should be 0x1 - only driver info msgs */
+	if (!dval)
+		return 0;
+	return (1 << dval) - 1;
+}
+
 /* defines only for the constants which don't work well as enums */
 #define ATA_TAG_POISON		0xfafbfcfdU
 
@@ -365,6 +398,8 @@ struct ata_port {
 	unsigned int		hsm_task_state;
 	unsigned long		pio_task_timeout;
 
+	u32			msg_enable;
+
 	void			*private_data;
 };
 
@@ -651,9 +686,9 @@ static inline u8 ata_wait_idle(struct at
 
 	if (status & (ATA_BUSY | ATA_DRQ)) {
 		unsigned long l = ap->ioaddr.status_addr;
-		printk(KERN_WARNING
-		       "ATA: abnormal status 0x%X on port 0x%lX\n",
-		       status, l);
+		if (ata_msg_warn(ap))
+			printk(KERN_WARNING "ATA: abnormal status 0x%X on port 0x%lX\n",
+				status, l);
 	}
 
 	return status;
@@ -745,7 +780,8 @@ static inline u8 ata_irq_ack(struct ata_
 
 	status = ata_busy_wait(ap, bits, 1000);
 	if (status & bits)
-		DPRINTK("abnormal status 0x%X\n", status);
+		if (ata_msg_err(ap))
+			printk(KERN_ERR "abnormal status 0x%X\n", status);
 
 	/* get controller status; clear intr, err bits */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -763,8 +799,10 @@ static inline u8 ata_irq_ack(struct ata_
 		post_stat = inb(ap->ioaddr.bmdma_addr + ATA_DMA_STATUS);
 	}
 
-	VPRINTK("irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
-		host_stat, post_stat, status);
+	if (ata_msg_intr(ap))
+		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
+			__FUNCTION__,
+			host_stat, post_stat, status);
 
 	return status;
 }
