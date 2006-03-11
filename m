Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWCKT2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWCKT2o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 14:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWCKT2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 14:28:44 -0500
Received: from mail.terralink.de ([217.9.16.16]:7677 "EHLO mail.terralink.de")
	by vger.kernel.org with ESMTP id S1750940AbWCKT2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 14:28:43 -0500
Date: Sat, 11 Mar 2006 20:28:41 +0100
From: Johannes Goecke <goecke@upb.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Patch: MSI-K8T-Neo2-Fir OnboardSound and additional Soundcard
Message-ID: <20060311192840.GA19313@uni-paderborn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-added-header: added by server
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello *, 
	 
	  i have a small patch for a Problem that i had.

On the MSI-K8T-NEO2 FIR ( Athlon-64, Socket 939 with VIA-K8T800- Chipset 
and onboard Sound,... ) the BIOS lets you choose "DISABLED" or "AUTO" 
for the On-Board Sound Device.

If you add another PCI-Sound-Card the BIOS disables the on-board device.

So far I have a Quirk, that does set the correspondent BIT in the PCI-registers
to enable the soundcard. 

But i have another 2 problems:

- how to enshure that the code is executed ONLY on excactly this kind of boards
 (not any other with similar Chipset)?

- what to do to (hopefully) integrate that pice of code into
  one of the next Kernel Releases?


Johannes Goecke


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-msi-k8t-neo2fir-soundcard

diff -u -r linux-2.6.15.6/drivers/pci/quirks.c linux-2.6.15.6-jg/drivers/pci/quirks.c
--- linux-2.6.15.6/drivers/pci/quirks.c	2006-03-05 20:07:54.000000000 +0100
+++ linux-2.6.15.6-jg/drivers/pci/quirks.c	2006-03-09 13:05:06.000000000 +0100
@@ -861,6 +861,41 @@
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82375,	quirk_eisa_bridge );
 
+/* 
+ * On the MSI-K8T-Neo2Fir Board, the internal Soundcard is disabled
+ * when a PCI-Soundcard is added. The BIOS only gives Options 
+ * "Disabled" and "AUTO". This Quirk Sets the corresponding
+ * Register-Value to enable the Soundcard.
+ */
+static void __init k8t_sound_hostbridge(struct pci_dev *dev) 
+{
+	printk(KERN_INFO "PCI: Quirk-MSI-K8T Soundcard On\n");
+
+	unsigned char val;
+
+	pci_read_config_byte(dev, 0x50, &val);
+
+	if ((val == 0x88) || (val == 0xc8)) {
+		pci_write_config_byte(dev, 0x50, val & (~0x40));
+
+		/* Verify the Change for Status output */
+		pci_read_config_byte(dev, 0x50, &val);
+		if (val & 0x40)
+			printk(KERN_INFO "PCI: MSI-K8T soundcard still off\n");
+		else
+			printk(KERN_INFO "PCI: MSI-K8T soundcard on\n");
+	} else {
+		printk(KERN_INFO "PCI: Unexpected Value in PCI-Register : no Change!\n");
+	}
+
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8237,	k8t_sound_hostbridge );
+
+
 /*
  * On ASUS P4B boards, the SMBus PCI Device within the ICH2/4 southbridge
  * is not activated. The myth is that Asus said that they do not want the

--7JfCtLOvnd9MIVvH--
