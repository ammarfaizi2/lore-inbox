Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbVB1QZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbVB1QZN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 11:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVB1QZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 11:25:09 -0500
Received: from orb.pobox.com ([207.8.226.5]:29097 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261678AbVB1QYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 11:24:08 -0500
Message-ID: <42234556.10206@pobox.com>
Date: Mon, 28 Feb 2005 11:22:46 -0500
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.11-rc5+ sata_qstor] sata_qstor:  eh_timeout fix
References: <421CE018.5030007@pobox.com> <200502232345.23666.adobriyan@mail.ru> <421D1113.9030502@pobox.com>
In-Reply-To: <421D1113.9030502@pobox.com>
Content-Type: multipart/mixed;
 boundary="------------050903040601080404090103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050903040601080404090103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is an update to sata_qstor.c to enable full/proper
register access during eh_timeout handling.

Patch is against 2.6.11-rc5 + earlier sata_qstor cosmetic patch.

Signed-off-by: Mark Lord <mlord@pobox.com>
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com


--------------050903040601080404090103
Content-Type: text/x-patch;
 name="sata_qstor-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_qstor-2.patch"

--- linux-2.6.11-rc5+/drivers/scsi/sata_qstor.c	2005-02-24 11:28:33.000000000 -0500
+++ linux/drivers/scsi/sata_qstor.c	2005-02-28 11:19:31.000000000 -0500
@@ -38,7 +38,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"sata_qstor"
-#define DRV_VERSION	"0.03"
+#define DRV_VERSION	"0.04"
 
 enum {
 	QS_PORTS		= 4,
@@ -120,6 +120,7 @@
 static void qs_bmdma_stop(struct ata_port *ap);
 static u8 qs_bmdma_status(struct ata_port *ap);
 static void qs_irq_clear(struct ata_port *ap);
+static void qs_eng_timeout(struct ata_port *ap);
 
 static Scsi_Host_Template qs_ata_sht = {
 	.module			= THIS_MODULE,
@@ -152,7 +153,7 @@
 	.phy_reset		= qs_phy_reset,
 	.qc_prep		= qs_qc_prep,
 	.qc_issue		= qs_qc_issue,
-	.eng_timeout		= ata_eng_timeout,
+	.eng_timeout		= qs_eng_timeout,
 	.irq_handler		= qs_intr,
 	.irq_clear		= qs_irq_clear,
 	.scr_read		= qs_scr_read,
@@ -212,7 +213,7 @@
 	/* nothing */
 }
 
-static void qs_enter_reg_mode(struct ata_port *ap)
+static inline void qs_enter_reg_mode(struct ata_port *ap)
 {
 	u8 __iomem *chan = ap->host_set->mmio_base + (ap->port_no * 0x4000);
 
@@ -220,17 +221,34 @@
 	readb(chan + QS_CCT_CTR0);        /* flush */
 }
 
-static void qs_phy_reset(struct ata_port *ap)
+static inline void qs_reset_channel_logic(struct ata_port *ap)
 {
 	u8 __iomem *chan = ap->host_set->mmio_base + (ap->port_no * 0x4000);
-	struct qs_port_priv *pp = ap->private_data;
 
-	pp->state = qs_state_idle;
 	writeb(QS_CTR1_RCHN, chan + QS_CCT_CTR1);
+	readb(chan + QS_CCT_CTR0);        /* flush */
 	qs_enter_reg_mode(ap);
+}
+
+static void qs_phy_reset(struct ata_port *ap)
+{
+	struct qs_port_priv *pp = ap->private_data;
+
+	pp->state = qs_state_idle;
+	qs_reset_channel_logic(ap);
 	sata_phy_reset(ap);
 }
 
+static void qs_eng_timeout(struct ata_port *ap)
+{
+	struct qs_port_priv *pp = ap->private_data;
+
+	if (pp->state != qs_state_idle) /* healthy paranoia */
+		pp->state = qs_state_mmio;
+	qs_reset_channel_logic(ap);
+	ata_eng_timeout(ap);
+}
+
 static u32 qs_scr_read (struct ata_port *ap, unsigned int sc_reg)
 {
 	if (sc_reg > SCR_CONTROL)

--------------050903040601080404090103--
