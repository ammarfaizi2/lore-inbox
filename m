Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933720AbWKQVCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933720AbWKQVCS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933681AbWKQVCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:02:17 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:26273 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755920AbWKQVB4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:56 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 12/15] sas_ata: Implement sata phy control
Date: Fri, 17 Nov 2006 13:08:24 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210824.17052.1005.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch requires "libsas: Add a sysfs knob to enable/disable a phy"
to be applied.  It hooks the SControl write function to provide basic
SATA phy control for phy enable/disable and speed limits.  Power
management is still broken, though it is unclear that libata actually
uses those SControl bits anyway.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/libsas/sas_ata.c       |   42 ++++++++++++++++++++++++++++++++++-
 drivers/scsi/libsas/sas_scsi_host.c |    1 +
 2 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index e2650fa..e897140 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -270,6 +270,46 @@ static void sas_ata_tf_read(struct ata_p
 	memcpy(tf, &dev->sata_dev.tf, sizeof (*tf));
 }
 
+static void sas_ata_scontrol_write(struct domain_device *dev, u32 val)
+{
+	u32 tmp = dev->sata_dev.scontrol;
+	struct sas_phy *phy = dev->port->phy;
+
+	val &= 0x0FF; /* only set max spd and dev ctrl */
+	val |= 0x300; /* disallow host pm */
+	val |= tmp & 0xFFFFF000; /* preserve upper bits */
+
+	/* disable phy */
+	if ((val & 0x4) && !(tmp & 0x4))
+		sas_phy_enable(phy, 0);
+
+	/* enable phy */
+	if (!(val & 0x4) && (tmp & 0x4))
+		sas_phy_enable(phy, 1);
+
+	/* reset phy */
+	if ((val & 0x1) && !(tmp & 0x1))
+		sas_phy_reset(phy, 0);
+
+	/* speed limit */
+	if ((val & 0xF0) != (tmp & 0xF0)) {
+		struct sas_phy_linkrates rates = {0};
+
+		switch ((val & 0xF0) >> 4) {
+		case 0:
+		case 2:
+			rates.maximum_linkrate = SAS_LINK_RATE_3_0_GBPS;
+			break;
+		case 1:
+			rates.maximum_linkrate = SAS_LINK_RATE_1_5_GBPS;
+			break;
+		}
+		sas_set_phy_speed(phy, &rates);
+	}
+
+	dev->sata_dev.scontrol = val;
+}
+
 static void sas_ata_scr_write(struct ata_port *ap, unsigned int sc_reg_in,
 			      u32 val)
 {
@@ -281,7 +321,7 @@ static void sas_ata_scr_write(struct ata
 			dev->sata_dev.sstatus = val;
 			break;
 		case SCR_CONTROL:
-			dev->sata_dev.scontrol = val;
+			sas_ata_scontrol_write(dev, val);
 			break;
 		case SCR_ERROR:
 			dev->sata_dev.serror = val;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 25639b5..59409be 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -938,3 +938,4 @@ EXPORT_SYMBOL_GPL(sas_ioctl);
 EXPORT_SYMBOL_GPL(sas_task_abort);
 EXPORT_SYMBOL_GPL(sas_phy_reset);
 EXPORT_SYMBOL_GPL(sas_phy_enable);
+EXPORT_SYMBOL_GPL(sas_set_phy_speed);
