Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWFSXvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWFSXvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWFSXvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:51:13 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:56758 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932550AbWFSXvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:51:12 -0400
Date: Tue, 20 Jun 2006 00:51:09 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: karsten wiese <annabellesgarden@yahoo.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, gregkh@suse.de
Subject: [FIXED PATCH] Clear abnormal poweroff flag on VIA southbridges, fix resume
Message-ID: <20060619235109.GA23675@srcf.ucam.org>
References: <20060618191421.GA15358@srcf.ucam.org> <20060619225719.87000.qmail@web26501.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619225719.87000.qmail@web26501.mail.ukl.yahoo.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2006 at 12:57:19AM +0200, karsten wiese wrote:
> --- Matthew Garrett <mjg59@srcf.ucam.org> schrieb:
> > Some VIA southbridges contain a flag in the ACPI register space that 
> > indicates whether an abnormal poweroff has occured, presumably with the 
> > intention that it can be cleared on clean shutdown. Some BIOSes check
> 
> (intel defines this bit as being set, when poweroff-button is
> pressed for > 4s. They say, BIOS is responsible for handling it.)

Interesting. The ACPI spec claims that it should just be ignored by the 
OS.

> with above comments applied it works on this VIA K8T800 mobo.
> Please repost. Thanks!

Yes, I sent entirely the wrong one. Try this.

Some VIA southbridges contain a flag in the ACPI register space that 
indicates whether an abnormal poweroff has occured, presumably with the 
intention that it can be cleared on clean shutdown. Some BIOSes check 
this and will fail to resume if it's set. Clear it on boot in order to 
prevent this.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
ACKed-by: Karsten Wiese <annabellesgarden@yahoo.de>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 7537260..01da8cc 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -660,6 +660,33 @@ static void __devinit quirk_vt82c598_id(
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id );
 
+#ifdef CONFIG_ACPI
+
+/* Some VIA systems boot with the abnormal status flag set. This can cause
+ * the BIOS to re-POST the system on resume rather than passing control 
+ * back to the OS. Clear the flag on boot
+ */
+
+static void __devinit quirk_via_abnormal_poweroff(struct pci_dev *dev)
+{
+	u32 pm1_status;
+
+	acpi_hw_register_read (ACPI_MTX_DO_NOT_LOCK, ACPI_REGISTER_PM1_STATUS,
+			       &pm1_status);
+
+	if (pm1_status & 0x800) {
+		printk ("Clearing abnormal poweroff flag\n");
+		acpi_hw_register_write (ACPI_MTX_DO_NOT_LOCK,
+					ACPI_REGISTER_PM1_STATUS,
+					(u16)0x800);
+	}
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8235, quirk_via_abnormal_poweroff);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8237, quirk_via_abnormal_poweroff);
+
+#endif
+
 /*
  * CardBus controllers have a legacy base address that enables them
  * to respond as i82365 pcmcia controllers.  We don't want them to

-- 
Matthew Garrett | mjg59@srcf.ucam.org
