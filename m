Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUGTB4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUGTB4H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 21:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUGTB4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 21:56:07 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:15056 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261236AbUGTBz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 21:55:57 -0400
Subject: [PATCH][2.4 Backport] x445 usb legacy fix
From: john stultz <johnstul@us.ibm.com>
To: zaitcev@redhat.com
Cc: lkml <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Content-Type: text/plain
Message-Id: <1090289222.1388.461.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 19 Jul 2004 19:07:03 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete, All,
	This is just the 2.4 backport of the patch posted here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0407.2/0469.html

	Apparently there is an issue w/ the IBM x440/x445's BIOS's USB Legacy
support. Due to the delay in issuing SMI's across the IOAPICs, its
possible for I/O to ports 60/64 to cause register corruption. 

The solution is to disable the BIOS's USB Legacy support early in boot
(via PCI quirks) for x440/x445 systems. 

This is the same method posted to lkml here (Originally written by
Vojtech): http://www.ussg.iu.edu/hypermail/linux/kernel/0405.3/1712.html

While Greg was cautious that this method couldn't always be used, I've
added to Vojtech's patch a boot option which allows you to specify
"no-usb-legacy". Additionally this patch enables the "no-usb-legacy"
option by default for x440/x445 systems.

Unlike the 2.6 version of the patch, this one also includes a ported
version of Vojtech's patch, so it is not dependent on any other patches.

Please consider for inclusion into your tree. 

thanks
-john


diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Mon Jul 19 19:01:52 2004
+++ b/Documentation/kernel-parameters.txt	Mon Jul 19 19:01:52 2004
@@ -635,7 +635,9 @@
 	uart6850=	[HW,SOUND]
  
 	usbfix		[BUGS=IA-64] 
- 
+
+	no-usb-legacy	[HW] Disables BIOS SMM USB Legacy Support
+
 	video=		[FB] frame buffer configuration.
 
 	vga=		[BOOT] on ix386, select a particular video mode
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Mon Jul 19 19:01:52 2004
+++ b/drivers/pci/quirks.c	Mon Jul 19 19:01:52 2004
@@ -726,6 +726,76 @@
 	pciehp_msi_quirk = 1;
 }
 
+
+#define UHCI_USBLEGSUP		0xc0		/* legacy support */
+#define UHCI_USBCMD		0		/* command register */
+#define UHCI_USBINTR		4		/* interrupt register */
+#define UHCI_USBLEGSUP_DEFAULT	0x2000		/* only PIRQ enable set */
+#define UHCI_USBCMD_GRESET	0x0004		/* Global reset */
+
+#define OHCI_CONTROL		0x04
+#define OHCI_CMDSTATUS		0x08
+#define OHCI_INTRENABLE		0x10
+#define OHCI_OCR		(1 << 3)	/* ownership change request */
+#define OHCI_CTRL_IR		(1 << 8)	/* interrupt routing */
+#define OHCI_INTR_OC		(1 << 30)	/* ownership change */
+
+int disable_legacy_usb __initdata = 0;
+static int __init usb_legacy_disable(char *str)
+{
+	disable_legacy_usb = 1;
+	return 0;
+}
+__setup("no-usb-legacy", usb_legacy_disable);
+
+static void __init quirk_usb_disable_smm_bios(struct pci_dev *pdev)
+{
+	if (!disable_legacy_usb)
+		return;
+
+	if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x00)) { /* UHCI */
+		int i;
+		unsigned long base = 0;;
+
+		for (i = 0; i < PCI_ROM_RESOURCE; i++) 
+			if ((pci_resource_flags(pdev, i) & IORESOURCE_IO)) {
+				base = pci_resource_start(pdev, i);
+				break;
+			}
+
+		if (!base)
+			return;
+
+		outw(0, base + UHCI_USBINTR);
+		outw(UHCI_USBCMD_GRESET, base + UHCI_USBCMD);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout((HZ*50+999) / 1000);
+		outw(0, base + UHCI_USBCMD);
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout((HZ*10+999) / 1000);
+
+		pci_write_config_word(pdev, UHCI_USBLEGSUP, UHCI_USBLEGSUP_DEFAULT);
+	}
+
+	if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x10)) { /* OHCI */
+		char *base = ioremap_nocache(pci_resource_start(pdev, 0),
+							pci_resource_len(pdev, 0));
+		if (base == NULL) return;
+
+		if (readl(base + OHCI_CONTROL) & OHCI_CTRL_IR) {
+			int temp = 500;     /* arbitrary: five seconds */
+			writel(OHCI_INTR_OC, base + OHCI_INTRENABLE);
+			writel(OHCI_OCR, base + OHCI_CMDSTATUS);
+			while (temp && readl(base + OHCI_CONTROL) & OHCI_CTRL_IR) {
+				temp--;
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule_timeout( HZ / 100);
+			}
+		}
+		iounmap(base);
+	}
+}
+
 /*
  *  The main table of quirks.
  */
@@ -816,6 +886,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82801BA_0,	asus_hides_smbus_lpc },
 
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_SMCH,  quirk_pciehp_msi },
+	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,		quirk_usb_disable_smm_bios },
 	
 	{ 0 }
 };
diff -Nru a/include/asm-i386/smpboot.h b/include/asm-i386/smpboot.h
--- a/include/asm-i386/smpboot.h	Mon Jul 19 19:01:52 2004
+++ b/include/asm-i386/smpboot.h	Mon Jul 19 19:01:52 2004
@@ -15,6 +15,7 @@
 extern unsigned char int_delivery_mode;
 extern unsigned int int_dest_addr_mode;
 extern int cyclone_setup(char*);
+extern int disable_legacy_usb;
 
 static inline void detect_clustered_apic(char* oem, char* prod)
 {
@@ -29,6 +30,7 @@
 		esr_disable = 1;
 		/*Start cyclone clock*/
 		cyclone_setup(0);
+		disable_legacy_usb = 1;
 	/* check for ACPI tables */
 	} else if (!strncmp(oem, "IBM", 3) &&
 	    (!strncmp(prod, "SERVIGIL", 8) ||
@@ -41,6 +43,7 @@
 		esr_disable = 1;
 		/*Start cyclone clock*/
 		cyclone_setup(0);
+		disable_legacy_usb = 1;
 	} else if (!strncmp(oem, "IBM NUMA", 8)){
 		clustered_apic_mode = CLUSTERED_APIC_NUMAQ;
 		apic_broadcast_id = APIC_BROADCAST_ID_APIC;


