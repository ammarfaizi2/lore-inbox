Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWIYXRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWIYXRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 19:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWIYXRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 19:17:09 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:10710 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751638AbWIYXRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 19:17:08 -0400
Message-ID: <4518636C.8090802@garzik.org>
Date: Mon, 25 Sep 2006 19:17:00 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Arne Ahrend <aahrend@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-git4 crashes in sata_via
References: <20060925225205.a4e0a2d3.aahrend@web.de>
In-Reply-To: <20060925225205.a4e0a2d3.aahrend@web.de>
Content-Type: multipart/mixed;
 boundary="------------080205080804050206070906"
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080205080804050206070906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Arne Ahrend wrote:
> Hi,
> 
> don't know if this is of any interest, but on my Athlon64 2.6.18-git4 (like -git3) crashes on startup when initializing
> the SATA ports. The machine does not actually have any SATA disks installed, but I compile in sata_via support anyway (and pata_via, of course).
> Alans pata_via driver has been working for me on various kernels without any issues for half a year now.


Does the attached patch fix your problems?

	Jeff



--------------080205080804050206070906
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 27c22fe..8cd730f 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -484,7 +484,7 @@ static void nv_error_handler(struct ata_
 static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	static int printed_version = 0;
-	struct ata_port_info *ppi;
+	struct ata_port_info *ppi[2];
 	struct ata_probe_ent *probe_ent;
 	int pci_dev_busy = 0;
 	int rc;
@@ -520,8 +520,8 @@ static int nv_init_one (struct pci_dev *
 
 	rc = -ENOMEM;
 
-	ppi = &nv_port_info[ent->driver_data];
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	ppi[0] = ppi[1] = &nv_port_info[ent->driver_data];
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
 		goto err_out_regions;
 
diff --git a/drivers/ata/sata_sis.c b/drivers/ata/sata_sis.c
index 9b17375..18d49ff 100644
--- a/drivers/ata/sata_sis.c
+++ b/drivers/ata/sata_sis.c
@@ -240,7 +240,7 @@ static int sis_init_one (struct pci_dev 
 	struct ata_probe_ent *probe_ent = NULL;
 	int rc;
 	u32 genctl;
-	struct ata_port_info *ppi;
+	struct ata_port_info *ppi[2];
 	int pci_dev_busy = 0;
 	u8 pmr;
 	u8 port2_start;
@@ -265,8 +265,8 @@ static int sis_init_one (struct pci_dev 
 	if (rc)
 		goto err_out_regions;
 
-	ppi = &sis_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	ppi[0] = ppi[1] = &sis_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
diff --git a/drivers/ata/sata_uli.c b/drivers/ata/sata_uli.c
index 8fc6e80..dd76f37 100644
--- a/drivers/ata/sata_uli.c
+++ b/drivers/ata/sata_uli.c
@@ -185,7 +185,7 @@ static int uli_init_one (struct pci_dev 
 {
 	static int printed_version;
 	struct ata_probe_ent *probe_ent;
-	struct ata_port_info *ppi;
+	struct ata_port_info *ppi[2];
 	int rc;
 	unsigned int board_idx = (unsigned int) ent->driver_data;
 	int pci_dev_busy = 0;
@@ -211,8 +211,8 @@ static int uli_init_one (struct pci_dev 
 	if (rc)
 		goto err_out_regions;
 
-	ppi = &uli_port_info;
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	ppi[0] = ppi[1] = &uli_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent) {
 		rc = -ENOMEM;
 		goto err_out_regions;
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index 7f087ae..a72a238 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -318,9 +318,10 @@ static void vt6421_init_addrs(struct ata
 static struct ata_probe_ent *vt6420_init_probe_ent(struct pci_dev *pdev)
 {
 	struct ata_probe_ent *probe_ent;
-	struct ata_port_info *ppi = &vt6420_port_info;
-
-	probe_ent = ata_pci_init_native_mode(pdev, &ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	struct ata_port_info *ppi[2];
+	
+	ppi[0] = ppi[1] = &vt6420_port_info;
+	probe_ent = ata_pci_init_native_mode(pdev, ppi, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
 	if (!probe_ent)
 		return NULL;
 

--------------080205080804050206070906--
