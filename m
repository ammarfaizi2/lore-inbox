Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUHFUqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUHFUqr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 16:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUHFUoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 16:44:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36253 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268288AbUHFUmh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 16:42:37 -0400
Date: Fri, 6 Aug 2004 13:42:30 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] USB shared interrupt problem
Message-Id: <20040806134230.5b05bca0@lembas.zaitcev.lan>
In-Reply-To: <5F106036E3D97448B673ED7AA8B2B6B30154AFED@scl-exch2k.phoenix.com>
References: <5F106036E3D97448B673ED7AA8B2B6B30154AFED@scl-exch2k.phoenix.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004 15:03:58 -0700
"Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com> wrote:

>   I wonder how this problem might be addressed in general case: when
> some device is sharing IRQ with UHCI, and is initialized (with
> request_irq, etc...) before actual UHCI driver starts?

I have a patch which prevents SMM BIOS from doing this to us
by requesting unconditional handoff (it comes from Vojtech @SuSE,
modified by John Stulz from IBM for 2.4). However, if you have a "normal"
BIOS doing this, I'm a little lost as to what to do. It can still honor
the handoff, if you're lucky.

-- Pete

diff -ruN linux-rhel/Documentation/kernel-parameters.txt linux-rhel-fix/Documentation/kernel-parameters.txt
--- linux-rhel/Documentation/kernel-parameters.txt	2004-07-20 15:19:47.000000000 -0700
+++ linux-rhel-fix/Documentation/kernel-parameters.txt	2004-07-20 15:26:06.000000000 -0700
@@ -616,7 +616,9 @@
 	uart6850=	[HW,SOUND]
  
 	usbfix		[BUGS=IA-64] 
- 
+
+	no-usb-legacy	[HW] Disables BIOS SMM USB Legacy Support
+
 	video=		[FB] frame buffer configuration.
 
 	vga=		[BOOT] on ix386, select a particular video mode
diff -ruN linux-rhel/drivers/pci/quirks.c linux-rhel-fix/drivers/pci/quirks.c
--- linux-rhel/drivers/pci/quirks.c	2004-07-20 15:20:06.000000000 -0700
+++ linux-rhel-fix/drivers/pci/quirks.c	2004-07-20 16:32:26.000000000 -0700
@@ -701,6 +701,76 @@
 		request_region(0x170, 8, "libata");	/* port 1 */
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
+		unsigned long base = 0;
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
@@ -780,6 +850,7 @@
 #endif
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL,	PCI_ANY_ID,
 	  quirk_intel_ide_combined },
+	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,		quirk_usb_disable_smm_bios },
 
 	{ 0 }
 };
diff -ruN linux-rhel/include/asm-i386/smpboot.h linux-rhel-fix/include/asm-i386/smpboot.h
--- linux-rhel/include/asm-i386/smpboot.h	2004-07-20 15:20:14.000000000 -0700
+++ linux-rhel-fix/include/asm-i386/smpboot.h	2004-07-20 15:29:20.000000000 -0700
@@ -15,6 +15,7 @@
 extern unsigned char int_delivery_mode;
 extern unsigned int int_dest_addr_mode;
 extern int cyclone_setup(char*);
+extern int disable_legacy_usb;
 
 static inline void detect_clustered_apic(char* oem, char* prod)
 {
@@ -32,6 +33,7 @@
 		esr_disable = 1;
 		/*Start cyclone clock*/
 		cyclone_setup(0);
+		disable_legacy_usb = 1;
 	}
 	else if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(prod, "RUTHLESS SMP", 9)){
 		clustered_apic_mode = CLUSTERED_APIC_XAPIC;
@@ -41,6 +43,7 @@
 		esr_disable = 1;
 		/*Start cyclone clock*/
 		cyclone_setup(0);
+		disable_legacy_usb = 1;
 	}
 	else if (!strncmp(oem, "IBM NUMA", 8)){
 		clustered_apic_mode = CLUSTERED_APIC_NUMAQ;
