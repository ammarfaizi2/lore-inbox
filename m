Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933717AbWKQVCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933717AbWKQVCU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933623AbWKQVCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:02:15 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:51372 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755921AbWKQVB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:58 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 13/15] sas_ata: Implement a libata error handler
Date: Fri, 17 Nov 2006 13:08:27 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210827.17052.46206.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/libsas/sas_ata.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index e897140..7338775 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -351,6 +351,27 @@ static u32 sas_ata_scr_read(struct ata_p
 	}
 }
 
+static int sas_ata_hardreset(struct ata_port *ap, unsigned int *classes)
+{
+	struct domain_device *dev = ap->private_data;
+	struct sas_phy *phy = dev->port->phy;
+
+	return sas_phy_reset(phy, 1);
+}
+
+static int sas_ata_softreset(struct ata_port *ap, unsigned int *classes)
+{
+	struct domain_device *dev = ap->private_data;
+	struct sas_phy *phy = dev->port->phy;
+
+	return sas_phy_reset(phy, 0);
+}
+
+static void sas_ata_eh(struct ata_port *ap)
+{
+	ata_do_eh(ap, NULL, sas_ata_softreset, sas_ata_hardreset, NULL);
+}
+
 static struct ata_port_operations sas_sata_ops = {
 	.port_disable		= ata_port_disable,
 	.check_status		= sas_ata_check_status,
@@ -364,7 +385,8 @@ static struct ata_port_operations sas_sa
 	.port_start		= ata_sas_port_start,
 	.port_stop		= ata_sas_port_stop,
 	.scr_read		= sas_ata_scr_read,
-	.scr_write		= sas_ata_scr_write
+	.scr_write		= sas_ata_scr_write,
+	.error_handler		= sas_ata_eh
 };
 
 static struct ata_port_info sata_port_info = {
