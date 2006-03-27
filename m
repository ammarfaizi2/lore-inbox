Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbWC0RkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWC0RkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 12:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750906AbWC0RkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 12:40:24 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25503 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750897AbWC0RkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 12:40:23 -0500
Subject: PATCH: Add ->set_mode hook for odd drivers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 27 Mar 2006 18:46:37 +0100
Message-Id: <1143481597.4970.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some hardware doesn't want the usual mode setup logic running. This
allows the hardware driver to replace it for special cases in the least
invasive way possible.

Signed-off-by: Alan Cox <alan@redhat.com> (and the previous diff)

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1cb9813..18d5239 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1409,7 +1415,11 @@ static int ata_bus_probe(struct ata_port
 	if (!found)
 		goto err_out_disable;
 
-	ata_set_mode(ap);
+	if (ap->ops->set_mode)
+		ap->ops->set_mode(ap);
+	else
+		ata_set_mode(ap);
+
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		goto err_out_disable;
 
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9fcc061..26e0351 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -429,6 +438,7 @@ struct ata_port_operations {
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
 
 	void (*phy_reset) (struct ata_port *ap); /* obsolete */
+	void (*set_mode) (struct ata_port *ap);
 	int (*probe_reset) (struct ata_port *ap, unsigned int *classes);
 
 	void (*post_set_mode) (struct ata_port *ap);

