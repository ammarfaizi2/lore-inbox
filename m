Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWJPPMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWJPPMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWJPPMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:12:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41665 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932124AbWJPPMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:12:39 -0400
Subject: [PATCH] libata: Revamp blacklist support to allow multiple kinds
	of blacklisting flaws
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Oct 2006 16:37:31 +0100
Message-Id: <1161013051.24237.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/include/linux/libata.h linux-2.6.19-rc1-mm1/include/linux/libata.h
--- linux.vanilla-2.6.19-rc1-mm1/include/linux/libata.h	2006-10-13 15:10:15.000000000 +0100
+++ linux-2.6.19-rc1-mm1/include/linux/libata.h	2006-10-13 17:21:50.000000000 +0100
@@ -310,6 +310,8 @@
 	   (some horkage may be drive/controller pair dependant */
 
 	ATA_HORKAGE_DIAGNOSTIC	= (1 << 0),	/* Failed boot diag */
+	ATA_HORKAGE_NODMA	= (1 << 1),	/* DMA problems */
+	ATA_HORKAGE_NONCQ	= (1 << 2),	/* Don't use NCQ */
 };
 
 enum hsm_task_states {
@@ -796,6 +798,7 @@
 			  unsigned int ofs, unsigned int len);
 extern void ata_id_c_string(const u16 *id, unsigned char *s,
 			    unsigned int ofs, unsigned int len);
+extern unsigned long ata_device_blacklisted(const struct ata_device *dev);
 extern void ata_bmdma_setup (struct ata_queued_cmd *qc);
 extern void ata_bmdma_start (struct ata_queued_cmd *qc);
 extern void ata_bmdma_stop(struct ata_queued_cmd *qc);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.19-rc1-mm1/drivers/ata/libata-core.c linux-2.6.19-rc1-mm1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.19-rc1-mm1/drivers/ata/libata-core.c	2006-10-13 15:10:06.000000000 +0100
+++ linux-2.6.19-rc1-mm1/drivers/ata/libata-core.c	2006-10-13 17:15:45.000000000 +0100
@@ -1360,7 +1360,10 @@
 		desc[0] = '\0';
 		return;
 	}
-
+	if (ata_device_blacklisted(dev) & ATA_HORKAGE_NONCQ) {
+		snprintf(desc, desc_sz, "NCQ (not used)");
+		return;
+	}
 	if (ap->flags & ATA_FLAG_NCQ) {
 		hdepth = min(ap->scsi_host->can_queue, ATA_MAX_QUEUE - 1);
 		dev->flags |= ATA_DFLAG_NCQ;
@@ -3041,37 +3044,55 @@
 	return rc;
 }
 
-static const char * const ata_dma_blacklist [] = {
-	"WDC AC11000H", NULL,
-	"WDC AC22100H", NULL,
-	"WDC AC32500H", NULL,
-	"WDC AC33100H", NULL,
-	"WDC AC31600H", NULL,
-	"WDC AC32100H", "24.09P07",
-	"WDC AC23200L", "21.10N21",
-	"Compaq CRD-8241B",  NULL,
-	"CRD-8400B", NULL,
-	"CRD-8480B", NULL,
-	"CRD-8482B", NULL,
- 	"CRD-84", NULL,
-	"SanDisk SDP3B", NULL,
-	"SanDisk SDP3B-64", NULL,
-	"SANYO CD-ROM CRD", NULL,
-	"HITACHI CDR-8", NULL,
-	"HITACHI CDR-8335", NULL,
-	"HITACHI CDR-8435", NULL,
-	"Toshiba CD-ROM XM-6202B", NULL,
-	"TOSHIBA CD-ROM XM-1702BC", NULL,
-	"CD-532E-A", NULL,
-	"E-IDE CD-ROM CR-840", NULL,
-	"CD-ROM Drive/F5A", NULL,
-	"WPI CDD-820", NULL,
-	"SAMSUNG CD-ROM SC-148C", NULL,
-	"SAMSUNG CD-ROM SC", NULL,
-	"SanDisk SDP3B-64", NULL,
-	"ATAPI CD-ROM DRIVE 40X MAXIMUM",NULL,
-	"_NEC DV5800A", NULL,
-	"SAMSUNG CD-ROM SN-124", "N001"
+struct ata_blacklist_entry {
+	const char *model_num;
+	const char *model_rev;
+	unsigned long horkage;
+};
+
+static const struct ata_blacklist_entry ata_device_blacklist [] = {
+	/* Devices with DMA related problems under Linux */
+	{ "WDC AC11000H",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC22100H",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC32500H",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC33100H",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC31600H",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WDC AC32100H",	"24.09P07",	ATA_HORKAGE_NODMA },
+	{ "WDC AC23200L",	"21.10N21",	ATA_HORKAGE_NODMA },
+	{ "Compaq CRD-8241B", 	NULL,		ATA_HORKAGE_NODMA },
+	{ "CRD-8400B",		NULL, 		ATA_HORKAGE_NODMA },
+	{ "CRD-8480B",		NULL,		ATA_HORKAGE_NODMA },
+	{ "CRD-8482B",		NULL,		ATA_HORKAGE_NODMA },
+	{ "CRD-84",		NULL,		ATA_HORKAGE_NODMA },
+	{ "SanDisk SDP3B",	NULL,		ATA_HORKAGE_NODMA },
+	{ "SanDisk SDP3B-64",	NULL,		ATA_HORKAGE_NODMA },
+	{ "SANYO CD-ROM CRD",	NULL,		ATA_HORKAGE_NODMA },
+	{ "HITACHI CDR-8",	NULL,		ATA_HORKAGE_NODMA },
+	{ "HITACHI CDR-8335",	NULL,		ATA_HORKAGE_NODMA },
+	{ "HITACHI CDR-8435",	NULL,		ATA_HORKAGE_NODMA },
+	{ "Toshiba CD-ROM XM-6202B", NULL,	ATA_HORKAGE_NODMA },
+	{ "TOSHIBA CD-ROM XM-1702BC", NULL,	ATA_HORKAGE_NODMA },
+	{ "CD-532E-A", 		NULL,		ATA_HORKAGE_NODMA },
+	{ "E-IDE CD-ROM CR-840",NULL,		ATA_HORKAGE_NODMA },
+	{ "CD-ROM Drive/F5A",	NULL,		ATA_HORKAGE_NODMA },
+	{ "WPI CDD-820", 	NULL,		ATA_HORKAGE_NODMA },
+	{ "SAMSUNG CD-ROM SC-148C", NULL,	ATA_HORKAGE_NODMA },
+	{ "SAMSUNG CD-ROM SC",	NULL,		ATA_HORKAGE_NODMA },
+	{ "SanDisk SDP3B-64", 	NULL,		ATA_HORKAGE_NODMA },
+	{ "ATAPI CD-ROM DRIVE 40X MAXIMUM",NULL,ATA_HORKAGE_NODMA },
+	{ "_NEC DV5800A", 	NULL,		ATA_HORKAGE_NODMA },
+	{ "SAMSUNG CD-ROM SN-124","N001",	ATA_HORKAGE_NODMA },
+
+	/* Devices we expect to fail diagnostics */
+	
+	/* Devices where NCQ should be avoided */
+	/* NCQ is slow */
+        { "WDC WD740ADFD-00",   NULL,		ATA_HORKAGE_NONCQ },
+
+	/* Devices with NCQ limits */
+
+	/* End Marker */
+	{ }
 };
 
 static int ata_strim(char *s, size_t len)
@@ -3086,20 +3107,12 @@
 	return len;
 }
 
-static int ata_dma_blacklisted(const struct ata_device *dev)
+unsigned long ata_device_blacklisted(const struct ata_device *dev)
 {
 	unsigned char model_num[40];
 	unsigned char model_rev[16];
 	unsigned int nlen, rlen;
-	int i;
-
-	/* We don't support polling DMA.
-	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
-	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
-	 */
-	if ((dev->ap->flags & ATA_FLAG_PIO_POLLING) &&
-	    (dev->flags & ATA_DFLAG_CDB_INTR))
-		return 1;
+	const struct ata_blacklist_entry *ad = ata_device_blacklist;
 
 	ata_id_string(dev->id, model_num, ATA_ID_PROD_OFS,
 			  sizeof(model_num));
@@ -3108,17 +3121,30 @@
 	nlen = ata_strim(model_num, sizeof(model_num));
 	rlen = ata_strim(model_rev, sizeof(model_rev));
 
-	for (i = 0; i < ARRAY_SIZE(ata_dma_blacklist); i += 2) {
-		if (!strncmp(ata_dma_blacklist[i], model_num, nlen)) {
-			if (ata_dma_blacklist[i+1] == NULL)
-				return 1;
-			if (!strncmp(ata_dma_blacklist[i], model_rev, rlen))
-				return 1;
+	while (ad->model_num) {
+		if (!strncmp(ad->model_num, model_num, nlen)) {
+			if (ad->model_rev == NULL)
+				return ad->horkage;
+			if (!strncmp(ad->model_rev, model_rev, rlen))
+				return ad->horkage;
 		}
+		ad++;
 	}
 	return 0;
 }
 
+static int ata_dma_blacklisted(const struct ata_device *dev)
+{
+	/* We don't support polling DMA.
+	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
+	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
+	 */
+	if ((dev->ap->flags & ATA_FLAG_PIO_POLLING) &&
+	    (dev->flags & ATA_DFLAG_CDB_INTR))
+		return 1;
+	return (ata_device_blacklisted(dev) & ATA_HORKAGE_NODMA) ? 1 : 0;
+}
+
 /**
  *	ata_dev_xfermask - Compute supported xfermask of the given device
  *	@dev: Device to compute xfermask for
@@ -6184,6 +6210,7 @@
 EXPORT_SYMBOL_GPL(ata_host_resume);
 EXPORT_SYMBOL_GPL(ata_id_string);
 EXPORT_SYMBOL_GPL(ata_id_c_string);
+EXPORT_SYMBOL_GPL(ata_device_blacklisted);
 EXPORT_SYMBOL_GPL(ata_scsi_simulate);
 
 EXPORT_SYMBOL_GPL(ata_pio_need_iordy);

