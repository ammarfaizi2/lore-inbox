Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbWANGqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWANGqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 01:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWANGqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 01:46:17 -0500
Received: from xenotime.net ([66.160.160.81]:20885 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932777AbWANGqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 01:46:10 -0500
Date: Fri, 13 Jan 2006 22:44:14 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: ide <linux-ide@vger.kernel.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Subject: [PATCH 2/4] libata debugging support
Message-Id: <20060113224414.20509944.rdunlap@xenotime.net>
In-Reply-To: <20060113224252.38d8890f.rdunlap@xenotime.net>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <petkov@uni-muenster.de>

libata new debugging macro definitions

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>
Signed-off-by: Randy Dunlap <randy_d_dunlap@linux.intel.com>
---
 include/linux/libata.h |   52 ++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 45 insertions(+), 7 deletions(-)

--- linux-2615-g9.orig/include/linux/libata.h
+++ linux-2615-g9/include/linux/libata.h
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
 
@@ -362,6 +395,8 @@ struct ata_port {
 	unsigned int		hsm_task_state;
 	unsigned long		pio_task_timeout;
 
+	u32			msg_enable;
+
 	void			*private_data;
 };
 
@@ -646,9 +681,9 @@ static inline u8 ata_wait_idle(struct at
 
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
@@ -740,7 +775,8 @@ static inline u8 ata_irq_ack(struct ata_
 
 	status = ata_busy_wait(ap, bits, 1000);
 	if (status & bits)
-		DPRINTK("abnormal status 0x%X\n", status);
+		if (ata_msg_err(ap))
+			printk(KERN_ERR "abnormal status 0x%X\n", status);
 
 	/* get controller status; clear intr, err bits */
 	if (ap->flags & ATA_FLAG_MMIO) {
@@ -758,8 +794,10 @@ static inline u8 ata_irq_ack(struct ata_
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

---
