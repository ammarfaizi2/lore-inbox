Return-Path: <linux-kernel-owner+w=401wt.eu-S933032AbWLSW7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933032AbWLSW7d (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933051AbWLSW7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:59:33 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:40182 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932991AbWLSW7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:59:24 -0500
Subject: [PATCH 2.6.20-git] sata_svw: Check for errors from ata_device_add()
From: Ben Collins <ben.collins@ubuntu.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 19 Dec 2006 17:59:13 -0500
Message-Id: <1166569153.5210.116.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, G5 oopses on boot. I've had this in Ubuntu since
2.6.17, but I forgot it was in there. Still required with 2.6.20.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index d89c959..85911b4 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -473,11 +473,11 @@ static int k2_sata_init_one (struct pci_
 
 	pci_set_master(pdev);
 
-	/* FIXME: check ata_device_add return value */
-	ata_device_add(probe_ent);
-	kfree(probe_ent);
+	if (ata_device_add(probe_ent))
+		return 0;
 
-	return 0;
+	/* Failed to add, no device present */
+	rc = -ENODEV;
 
 err_out_free_ent:
 	kfree(probe_ent);

