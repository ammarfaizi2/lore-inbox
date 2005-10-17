Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVJQCO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVJQCO3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 22:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJQCO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 22:14:29 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:29384 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751208AbVJQCO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 22:14:29 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com, akpm@osdl.org
Subject: Intel SATA combined mode quirk broken for SCSI_SATA=m
Date: Sun, 16 Oct 2005 19:13:59 -0700
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_njwUDtCFxRDBADr"
Message-Id: <200510161913.59622.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_njwUDtCFxRDBADr
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Back in July, Adrian Bunk sent in a patch to make SCSI_SATA tristate.  This 
prevents the intel_ide_combined quirk in drivers/pci/quirks.c from working if 
SCSI_SATA=m, which is the case for Fedora kernels (my motivation for tracking 
this down).

In my configuration, not running the quirk causes the ata_piix driver (the 
libata driver for my IDE controller) to fail to attach to the device, since 
the legacy IDE driver has already claimed the ports.  Unfortunately, the AHCI 
driver also tries to mess with the device, and ends up disabling its 
interrupts before aborting its load, causing the IDE layer to complain loudly 
that hda is losing interrupts.

So what should be done?  Ideally, libata would fully support ATAPI and then I 
wouldn't need the legacy IDE drivers at all on this box, making the quirk 
moot, but that won't happen for 2.6.14, so we'll need something else.  
Unconditionally enabling the quirk will cause at least one of the ports to be 
reserved for the SATA driver, which may never load.  And obviously not 
running the quirk leads to the situation described above.

A hack that might be suitable for 2.6.14 is to make the quirk depend on either 
CONFIG_SCSI_SATA or CONFIG_SCSI_SATA_MODULE.  Then the quirk could be removed 
entirely when ATAPI support for libata is merged.

Thoughts?

Thanks,
Jesse

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>

--Boundary-00=_njwUDtCFxRDBADr
Content-Type: text/x-diff;
  charset="us-ascii";
  name="intel-combined-mode-quirk-hack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="intel-combined-mode-quirk-hack.patch"

--- linux-2.6.14-rc4/drivers/pci/quirks.c.orig	2005-10-16 19:12:05.000000000 -0700
+++ linux-2.6.14-rc4/drivers/pci/quirks.c	2005-10-16 19:12:33.000000000 -0700
@@ -1233,8 +1233,7 @@
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_EESSC,	quirk_alder_ioapic );
 #endif
 
-#ifdef CONFIG_SCSI_SATA
-#error building quirk
+#if defined(CONFIG_SCSI_SATA) || defined(CONFIG_SCSI_SATA_MODULE)
 static void __devinit quirk_intel_ide_combined(struct pci_dev *pdev)
 {
 	u8 prog, comb, tmp;

--Boundary-00=_njwUDtCFxRDBADr--
