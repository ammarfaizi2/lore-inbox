Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSKNMB7>; Thu, 14 Nov 2002 07:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSKNMB7>; Thu, 14 Nov 2002 07:01:59 -0500
Received: from port-213-148-149-130.reverse.qsc.de ([213.148.149.130]:24467
	"EHLO eumucln01.mscsoftware.com") by vger.kernel.org with ESMTP
	id <S264872AbSKNMB5>; Thu, 14 Nov 2002 07:01:57 -0500
From: Martin Knoblauch <martin.knoblauch@mscsoftware.com>
Reply-To: martin.knoblauch@mscsoftware.com
Organization: MSC.Software GmbH
To: linux-kernel@vger.kernel.org
Subject: [Patch] Prevent crash when loading "cpqfc" with Tachyon XL2 cards (against 2.4.20-rc1-ac1)
Date: Thu, 14 Nov 2002 13:07:49 +0100
User-Agent: KMail/1.4.2
Cc: fibrechannel@compaq.com, ehm@cris.com, grif@cs.ucr.edu
MIME-Version: 1.0
Message-Id: <200211141307.49206.martin.knoblauch@mscsoftware.com>
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.2; AVE: 6.16.0.0; VDF: 6.16.0.17
	 at mailmuc has not found any known virus in this email.
X-MIMETrack: Itemize by SMTP Server on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 11/14/2002 01:04:15 PM,
	Serialize by Router on EUMUCLN01/MSCsoftware(Release 5.0.10 |March 22, 2002) at
 11/14/2002 01:04:24 PM,
	Serialize complete at 11/14/2002 01:04:24 PM
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_11FKYUZU8UVFVF8XEIJW"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_11FKYUZU8UVFVF8XEIJW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
  charset="us-ascii"

Hi,

 please apply the appended patch to "drivers/scsi/cpqfcTSinit.c". It=20
adds a call to "pci_enable_device" which prevents a hard crash when=20
loading the driver on a Tachyon XL2 based HP card (IA64 platform). The=20
patch is against 2.4.20-rc1-ac1, but should apply to mainline.

 In general, is someone working making the Tachyon XL2 cards really work=20
with the cpqfc driver? I am very interested in that. It is really sad=20
to see those 60 FC disks idle when Linux is booted on our rx5670 :-( I=20
would love to help out with testing and experimenting.

 The current problems (after applying this patch are):

- unable to read WWN from NVRAM
- no GBIC found
- no link state
- no disks found



Thanks
Martin
--=20
Martin Knoblauch
Senior System Architect
MSC.software GmbH
Am Moosfeld 13
D-81829 Muenchen, Germany

e-mail: martin.knoblauch@mscsoftware.com
http://www.mscsoftware.com
Phone/Fax: +49-89-431987-189 / -7189
Mobile: +49-174-3069245

--------------Boundary-00=_11FKYUZU8UVFVF8XEIJW
Content-Transfer-Encoding: 7bit
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cpqfcTSinit.c.patch"
Content-Disposition: attachment; filename="cpqfcTSinit.c.patch"

--- cpqfcTSinit.c-orig	Wed Nov 13 11:05:10 2002
+++ cpqfcTSinit.c	Thu Nov 14 12:48:48 2002
@@ -242,6 +242,10 @@
 
 		while ((PciDev = pci_find_device(cpqfc_boards[i].vendor_id, cpqfc_boards[i].device_id, PciDev))) {
 
+			if (pci_enable_device(PciDev) != 0) {
+				printk(KERN_WARNING "cpqfc: pci_enable_devive failed, skipping.\n");
+				continue;
+			}
 			if (pci_set_dma_mask(PciDev, CPQFCTS_DMA_MASK) != 0) {
 				printk(KERN_WARNING "cpqfc: HBA cannot support required DMA mask, skipping.\n");
 				continue;
@@ -411,6 +415,7 @@
 	// can we find an FC device mapping to this SCSI target?
 	DumCmnd.channel = ScsiDev->channel;	// For searching
 	DumCmnd.target = ScsiDev->id;
+	DumCmnd.lun = ScsiDev->lun;
 	pLoggedInPort = fcFindLoggedInPort(fcChip, &DumCmnd,	// search Scsi Nexus
 					   0,	// DON'T search linked list for FC port id
 					   NULL,	// DON'T search linked list for FC WWN

--------------Boundary-00=_11FKYUZU8UVFVF8XEIJW--

