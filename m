Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbTENNzB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 09:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTENNzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 09:55:01 -0400
Received: from www01.ies.inet6.fr ([62.210.153.201]:29830 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S262246AbTENNyx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 09:54:53 -0400
Message-ID: <3EC24DA6.8030908@inet6.fr>
Date: Wed, 14 May 2003 16:07:34 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030314
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [SiS IDE patch] various fixes
Content-Type: multipart/mixed;
 boundary="------------020206060205090805070105"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020206060205090805070105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

here's a patch against 2.4.21-rc2-ac1 (applies cleanly on 2.4.21-rc2, 
should do it on 2.4.21-rc2-ac2 too) which brings the following to the 
SiS IDE driver :

- support for SiS655,
- support for SiS630S/ET UDMA5 mode,
- corrected /proc/ide/sis output for ATA133 chipsets (drives' positions
were swapped),
- use of pci_read_config_byte() instead of direct pci poking for SiS962+ 
detection,

I didn't have any bugreport since its post 2 days ago on linux-kernel 
and to two users needing these corrections.

Please consider applying,

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
o Siege social: 51, rue de Verdun - 92158 Suresnes
/ _ __ _ Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
/ /\ /_ / /_ France
\/ \/_ / /_/ Tel. +33 (0) 1 41 44 85 36
Inetsys S.A. Fax +33 (0) 1 46 97 20 10



--------------020206060205090805070105
Content-Type: text/plain;
 name="sis.patch.20030512_1ac"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sis.patch.20030512_1ac"

diff -urN -X dontdiff --exclude=tmp_include_depends linux-2.4.21-rc2-ac1/drivers/ide/pci/sis5513.c linux-2.4.21-rc2-ac1-sis5513/drivers/ide/pci/sis5513.c
--- linux-2.4.21-rc2-ac1/drivers/ide/pci/sis5513.c	2003-05-12 00:10:19.000000000 +0200
+++ linux-2.4.21-rc2-ac1-sis5513/drivers/ide/pci/sis5513.c	2003-05-12 15:49:54.000000000 +0200
@@ -161,9 +161,10 @@
 	{ "SiS748",	PCI_DEVICE_ID_SI_748,	ATA_133,	0 },
 	{ "SiS746",	PCI_DEVICE_ID_SI_746,	ATA_133,	0 },
 	{ "SiS745",	PCI_DEVICE_ID_SI_745,	ATA_133,	0 },
-	{ "SiS740",	PCI_DEVICE_ID_SI_740,	ATA_100,	0 },
+	{ "SiS740",	PCI_DEVICE_ID_SI_740,	ATA_133,	0 },
 	{ "SiS735",	PCI_DEVICE_ID_SI_735,	ATA_100,	SIS5513_LATENCY },
 	{ "SiS730",	PCI_DEVICE_ID_SI_730,	ATA_100a,	SIS5513_LATENCY },
+	{ "SiS655",	PCI_DEVICE_ID_SI_655,	ATA_133,	0 },
 	{ "SiS652",	PCI_DEVICE_ID_SI_652,	ATA_133,	0 },
 	{ "SiS651",	PCI_DEVICE_ID_SI_651,	ATA_133,	0 },
 	{ "SiS650",	PCI_DEVICE_ID_SI_650,	ATA_133,	0 },
@@ -257,8 +258,8 @@
 static char* chipset_capability[] = {
 	"ATA", "ATA 16",
 	"ATA 33", "ATA 66",
-	"ATA 100", "ATA 100",
-	"ATA 133", "ATA 133"
+	"ATA 100 (1st gen)", "ATA 100 (2nd gen)",
+	"ATA 133 (1st gen)", "ATA 133 (2nd gen)"
 };
 
 #if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS)
@@ -331,8 +332,8 @@
 			// Configuration space remapped to 0x70
 			drive_pci = 0x70;
 		}
-		pci_read_config_dword(bmide_dev, (unsigned long)drive_pci+8*pos, &regdw0);
-		pci_read_config_dword(bmide_dev, (unsigned long)drive_pci+8*pos+4, &regdw1);
+		pci_read_config_dword(bmide_dev, (unsigned long)drive_pci+4*pos, &regdw0);
+		pci_read_config_dword(bmide_dev, (unsigned long)drive_pci+4*pos+8, &regdw1);
 		p += sprintf(p, "Drive %d:\n", pos);
 	}
 
@@ -357,8 +358,7 @@
 			case ATA_100a:	p += sprintf(p, cycle_time[(reg01 & 0x70) >> 4]); break;
 			case ATA_100:
 			case ATA_133a:	p += sprintf(p, cycle_time[reg01 & 0x0F]); break;
-			case ATA_133:
-			default:	p += sprintf(p, "133+ ?"); break;
+			default:	p += sprintf(p, "?"); break;
 		}
 		p += sprintf(p, " \t UDMA Cycle Time    ");
 		switch(chipset_family) {
@@ -367,42 +367,39 @@
 			case ATA_100a:	p += sprintf(p, cycle_time[(reg11 & 0x70) >> 4]); break;
 			case ATA_100:
 			case ATA_133a:  p += sprintf(p, cycle_time[reg11 & 0x0F]); break;
-			case ATA_133:
-			default:	p += sprintf(p, "133+ ?"); break;
+			default:	p += sprintf(p, "?"); break;
 		}
 		p += sprintf(p, "\n");
 	}
 
+	if (chipset_family < ATA_133) { /* else case TODO */
 /* Data Active */
-	p += sprintf(p, "                Data Active Time   ");
-	switch(chipset_family) {
-		case ATA_00:
-		case ATA_16: /* confirmed */
-		case ATA_33:
-		case ATA_66:
-		case ATA_100a: p += sprintf(p, active_time[reg01 & 0x07]); break;
-		case ATA_100:
-		case ATA_133a: p += sprintf(p, active_time[(reg00 & 0x70) >> 4]); break;
-		case ATA_133:
-		default: p += sprintf(p, "133+ ?"); break;
-	}
-	p += sprintf(p, " \t Data Active Time   ");
-	switch(chipset_family) {
-		case ATA_00:
-		case ATA_16:
-		case ATA_33:
-		case ATA_66:
-		case ATA_100a: p += sprintf(p, active_time[reg11 & 0x07]); break;
-		case ATA_100:
-		case ATA_133a: p += sprintf(p, active_time[(reg10 & 0x70) >> 4]); break;
-		case ATA_133:
-		default: p += sprintf(p, "133+ ?"); break;
-	}
-	p += sprintf(p, "\n");
+		p += sprintf(p, "                Data Active Time   ");
+		switch(chipset_family) {
+			case ATA_00:
+			case ATA_16: /* confirmed */
+			case ATA_33:
+			case ATA_66:
+			case ATA_100a: p += sprintf(p, active_time[reg01 & 0x07]); break;
+			case ATA_100:
+			case ATA_133a: p += sprintf(p, active_time[(reg00 & 0x70) >> 4]); break;
+			default: p += sprintf(p, "?"); break;
+		}
+		p += sprintf(p, " \t Data Active Time   ");
+		switch(chipset_family) {
+			case ATA_00:
+			case ATA_16:
+			case ATA_33:
+			case ATA_66:
+			case ATA_100a: p += sprintf(p, active_time[reg11 & 0x07]); break;
+			case ATA_100:
+			case ATA_133a: p += sprintf(p, active_time[(reg10 & 0x70) >> 4]); break;
+			default: p += sprintf(p, "?"); break;
+		}
+		p += sprintf(p, "\n");
 
 /* Data Recovery */
 	/* warning: may need (reg&0x07) for pre ATA66 chips */
-	if (chipset_family < ATA_133) {
 		p += sprintf(p, "                Data Recovery Time %s \t Data Recovery Time %s\n",
 			     recovery_time[reg00 & 0x0f], recovery_time[reg10 & 0x0f]);
 	}
@@ -430,7 +427,6 @@
 
 	p += sprintf(p, "\nSiS 5513 ");
 	switch(chipset_family) {
-		case ATA_00: p += sprintf(p, "Unknown???"); break;
 		case ATA_16: p += sprintf(p, "DMA 16"); break;
 		case ATA_33: p += sprintf(p, "Ultra 33"); break;
 		case ATA_66: p += sprintf(p, "Ultra 66"); break;
@@ -867,6 +863,19 @@
 	return sis5513_config_drive_xfer_rate(drive);
 }
 
+/* Helper function used at init time
+ * returns a PCI device revision ID
+ * (used to detect different IDE controller versions)
+ */
+static u8 __init devfn_rev(int device, int function)
+{
+	u8 revision;
+	/* Find device */
+	struct pci_dev* dev = pci_find_slot(0,PCI_DEVFN(device,function));
+	pci_read_config_byte(dev, PCI_REVISION_ID, &revision);
+	return revision;
+}
+
 /* Chip detection and general config */
 static unsigned int __init init_chipset_sis5513 (struct pci_dev *dev, const char *name)
 {
@@ -887,26 +896,24 @@
 		/* check 100/133 chipset family */
 		if (chipset_family == ATA_133) {
 			u32 reg54h;
-			u16 reg02h;
+			u16 devid;
 			pci_read_config_dword(dev, 0x54, &reg54h);
+			/* SiS962 and above report 0x5518 dev id if high bit is cleared */
 			pci_write_config_dword(dev, 0x54, (reg54h & 0x7fffffff));
-			pci_read_config_word(dev, 0x02, &reg02h);
+			pci_read_config_word(dev, 0x02, &devid);
+			/* restore register 0x54 */
 			pci_write_config_dword(dev, 0x54, reg54h);
+
 			/* devid 5518 here means SiS962 or later
-			   which supports ATA133 */
-			if (reg02h != 0x5518) {
+			   which supports ATA133.
+			   These are refered by chipset_family = ATA133
+			*/
+			if (devid != 0x5518) {
 				u8 reg49h;
-				unsigned long sbrev;
 				/* SiS961 family */
-
-		/*
-		 * FIXME !!! GAK!!!!!!!!!! PCI DIRECT POKING 
-		 */
-				outl(0x80001008, 0x0cf8);
-				sbrev = inl(0x0cfc);
-
 				pci_read_config_byte(dev, 0x49, &reg49h);
-				if (((sbrev & 0xff) == 0x10) && (reg49h & 0x80))
+				/* check isa bridge device rev id */
+				if (((devfn_rev(2,0) & 0xff) == 0x10) && (reg49h & 0x80))
 					chipset_family = ATA_133a;
 				else
 					chipset_family = ATA_100;
@@ -924,6 +931,14 @@
 			u8 latency = (chipset_family == ATA_100)? 0x80 : 0x10; /* Lacking specs */
 			pci_write_config_byte(dev, PCI_LATENCY_TIMER, latency);
 		}
+
+		/* Special case for SiS630 : 630S/ET is ATA_100a */
+		if (SiSHostChipInfo[i].host_id == PCI_DEVICE_ID_SI_630) {
+			/* check host device rev id */
+			if (devfn_rev(0,0) >= 0x30) {
+				chipset_family = ATA_100a;
+			}
+		}
 	}
 
 	/* Make general config ops here
diff -urN -X dontdiff --exclude=tmp_include_depends linux-2.4.21-rc2-ac1/include/linux/pci_ids.h linux-2.4.21-rc2-ac1-sis5513/include/linux/pci_ids.h
--- linux-2.4.21-rc2-ac1/include/linux/pci_ids.h	2003-05-12 00:12:32.000000000 +0200
+++ linux-2.4.21-rc2-ac1-sis5513/include/linux/pci_ids.h	2003-05-12 00:35:40.000000000 +0200
@@ -501,6 +501,7 @@
 #define PCI_DEVICE_ID_SI_650		0x0650
 #define PCI_DEVICE_ID_SI_651		0x0651
 #define PCI_DEVICE_ID_SI_652		0x0652
+#define PCI_DEVICE_ID_SI_655		0x0655
 #define PCI_DEVICE_ID_SI_730		0x0730
 #define PCI_DEVICE_ID_SI_630_VGA	0x6300
 #define PCI_DEVICE_ID_SI_730_VGA	0x7300

--------------020206060205090805070105--

