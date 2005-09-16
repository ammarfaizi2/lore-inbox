Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVIPTpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVIPTpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbVIPTpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:45:33 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:30425 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1750833AbVIPTpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:45:32 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=kqIOcjz6fcPEPjxmG4zf34AXtabmjEXmeq8M6i+bd2s9etedmaa1rp+FIul5Bahxo
	7tvAXy+hws26y7ZG5Z8eg==
Date: Fri, 16 Sep 2005 12:45:13 -0700
From: David Brownell <david-b@pacbell.net>
To: greg@kroah.com, alan@lxorguk.ukuu.org.uk
Subject: Re: Lost keyboard on Inspiron 8200 at 2.6.13
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       dtor_core@ameritech.net, caphrim007@gmail.com, akpm@osdl.org
References: <432A4A1F.3040308@gmail.com>
 <200509152357.58921.dtor_core@ameritech.net>
 <20050916025356.0d5189a6.akpm@osdl.org>
 <d120d500050916082519c660e6@mail.gmail.com>
 <1126886449.17038.4.camel@localhost.localdomain>
 <20050916184440.GA11413@kroah.com>
In-Reply-To: <20050916184440.GA11413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050916194513.5E4D6E9DA9@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Interdependencies between ACPI, PNP, USB Legacy emulation and I8042 is
> > > very delicate and quite often changes in ACPI/PNP break that balance.
> > > USB legacy emulation is just evil. We need to have "usb-handoff" thing
> > > enabled by default, it fixes alot of problems.
> > 
> > I would definitely agree with this. There are very few, if any, cases
> > usb handoff doesn't work now that the Nvidia problems are fixed.
>
> Are we sure?  Yeah, SuSE has shipped that code "enabled" for a while,
> but I'm still not comfortable making that the default.

I tend to believe it's the right direction, but also concur with what
Greg writes below.  Which suggests _maybe_ the default could change in
the 2.6.15 release, and meanwhile folk booting with USB keyboards and
mice will just have to use the commandline parameter.


> Only if we merge the code that does the handoff, with the same code that
> does it in the usb core, would I feel more comfortable to enable this
> always.  I had a patch from David Brownell to do this, but it had some
> link errors at times, so I had to drop it :(

And for reference, here's that patch.  I have no clue why anyone had
link problems associated with _this_ patch, since all systems I have
work just fine with it.  I thought it was something else in the MM
tree that was making problems.

/Dave



This moves the PCI quirk handling for USB host controllers from the
PCI directory to the USB directory.  Follow-on patches will need to:

(a) merge these copies with the originals in the HCD reset methods.
they don't wholly agree, despite doing the very same thing; and

(b) eventually change it so "usb-handoff" is the default, to help
get more robust USB/BIOS/input/... interactions.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- g26.orig/drivers/Makefile	2005-09-09 22:50:03.000000000 -0700
+++ g26/drivers/Makefile	2005-09-10 01:06:27.000000000 -0700
@@ -5,7 +5,7 @@
 # Rewritten to use lists instead of if-statements.
 #
 
-obj-$(CONFIG_PCI)		+= pci/
+obj-$(CONFIG_PCI)		+= pci/ usb/host/
 obj-$(CONFIG_PARISC)		+= parisc/
 obj-y				+= video/
 obj-$(CONFIG_ACPI)		+= acpi/
--- g26.orig/drivers/usb/Makefile	2005-09-09 22:31:55.000000000 -0700
+++ g26/drivers/usb/Makefile	2005-09-10 01:06:27.000000000 -0700
@@ -8,6 +8,7 @@ obj-$(CONFIG_USB)		+= core/
 
 obj-$(CONFIG_USB_MON)		+= mon/
 
+obj-$(CONFIG_PCI)		+= host/
 obj-$(CONFIG_USB_EHCI_HCD)	+= host/
 obj-$(CONFIG_USB_ISP116X_HCD)	+= host/
 obj-$(CONFIG_USB_OHCI_HCD)	+= host/
--- g26.orig/drivers/usb/host/Makefile	2005-09-09 22:31:55.000000000 -0700
+++ g26/drivers/usb/host/Makefile	2005-09-10 01:06:27.000000000 -0700
@@ -1,8 +1,9 @@
 #
-# Makefile for USB Host Controller Driver
-# framework and drivers
+# Makefile for USB Host Controller Drivers
 #
 
+obj-$(CONFIG_PCI)		+= pci-quirks.o
+
 obj-$(CONFIG_USB_EHCI_HCD)	+= ehci-hcd.o
 obj-$(CONFIG_USB_ISP116X_HCD)	+= isp116x-hcd.o
 obj-$(CONFIG_USB_OHCI_HCD)	+= ohci-hcd.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/usb/host/pci-quirks.c	2005-09-10 01:06:27.000000000 -0700
@@ -0,0 +1,272 @@
+/*
+ * This file contains code to reset and initialize USB host controllers.
+ * Some of it includes work-arounds for PCI hardware and BIOS quirks.
+ * It may need to run early during booting -- before USB would normally
+ * initialize -- to ensure that Linux doesn't use any legacy modes. 
+ *
+ *  Copyright (c) 1999 Martin Mares <mj@ucw.cz>
+ *  (and others)
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/acpi.h>
+
+
+/*
+ * PIIX3 USB: We have to disable USB interrupts that are
+ * hardwired to PIRQD# and may be shared with an
+ * external device.
+ *
+ * Legacy Support Register (LEGSUP):
+ *     bit13:  USB PIRQ Enable (USBPIRQDEN),
+ *     bit4:   Trap/SMI On IRQ Enable (USBSMIEN).
+ *
+ * We mask out all r/wc bits, too.
+ */
+static void __devinit quirk_piix3_usb(struct pci_dev *dev)
+{
+	u16 legsup;
+
+	pci_read_config_word(dev, 0xc0, &legsup);
+	legsup &= 0x50ef;
+	pci_write_config_word(dev, 0xc0, legsup);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	quirk_piix3_usb );
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	quirk_piix3_usb );
+
+
+/* FIXME these should be the guts of hcd->reset() methods; resolve all
+ * the differences between this version and the HCD's version.
+ */
+
+#define UHCI_USBLEGSUP		0xc0		/* legacy support */
+#define UHCI_USBCMD		0		/* command register */
+#define UHCI_USBSTS		2		/* status register */
+#define UHCI_USBINTR		4		/* interrupt register */
+#define UHCI_USBLEGSUP_DEFAULT	0x2000		/* only PIRQ enable set */
+#define UHCI_USBCMD_RUN		(1 << 0)	/* RUN/STOP bit */
+#define UHCI_USBCMD_GRESET	(1 << 2)	/* Global reset */
+#define UHCI_USBCMD_CONFIGURE	(1 << 6)	/* config semaphore */
+#define UHCI_USBSTS_HALTED	(1 << 5)	/* HCHalted bit */
+
+#define OHCI_CONTROL		0x04
+#define OHCI_CMDSTATUS		0x08
+#define OHCI_INTRSTATUS		0x0c
+#define OHCI_INTRENABLE		0x10
+#define OHCI_INTRDISABLE	0x14
+#define OHCI_OCR		(1 << 3)	/* ownership change request */
+#define OHCI_CTRL_IR		(1 << 8)	/* interrupt routing */
+#define OHCI_INTR_OC		(1 << 30)	/* ownership change */
+
+#define EHCI_HCC_PARAMS		0x08		/* extended capabilities */
+#define EHCI_USBCMD		0		/* command register */
+#define EHCI_USBCMD_RUN		(1 << 0)	/* RUN/STOP bit */
+#define EHCI_USBSTS		4		/* status register */
+#define EHCI_USBSTS_HALTED	(1 << 12)	/* HCHalted bit */
+#define EHCI_USBINTR		8		/* interrupt register */
+#define EHCI_USBLEGSUP		0		/* legacy support register */
+#define EHCI_USBLEGSUP_BIOS	(1 << 16)	/* BIOS semaphore */
+#define EHCI_USBLEGSUP_OS	(1 << 24)	/* OS semaphore */
+#define EHCI_USBLEGCTLSTS	4		/* legacy control/status */
+#define EHCI_USBLEGCTLSTS_SOOE	(1 << 13)	/* SMI on ownership change */
+
+int usb_early_handoff __devinitdata = 0;
+static int __init usb_handoff_early(char *str)
+{
+	usb_early_handoff = 1;
+	return 0;
+}
+__setup("usb-handoff", usb_handoff_early);
+
+static void __devinit quirk_usb_handoff_uhci(struct pci_dev *pdev)
+{
+	unsigned long base = 0;
+	int wait_time, delta;
+	u16 val, sts;
+	int i;
+
+	for (i = 0; i < PCI_ROM_RESOURCE; i++)
+		if ((pci_resource_flags(pdev, i) & IORESOURCE_IO)) {
+			base = pci_resource_start(pdev, i);
+			break;
+		}
+
+	if (!base)
+		return;
+
+	/*
+	 * stop controller
+	 */
+	sts = inw(base + UHCI_USBSTS);
+	val = inw(base + UHCI_USBCMD);
+	val &= ~(u16)(UHCI_USBCMD_RUN | UHCI_USBCMD_CONFIGURE);
+	outw(val, base + UHCI_USBCMD);
+
+	/*
+	 * wait while it stops if it was running
+	 */
+	if ((sts & UHCI_USBSTS_HALTED) == 0)
+	{
+		wait_time = 1000;
+		delta = 100;
+
+		do {
+			outw(0x1f, base + UHCI_USBSTS);
+			udelay(delta);
+			wait_time -= delta;
+			val = inw(base + UHCI_USBSTS);
+			if (val & UHCI_USBSTS_HALTED)
+				break;
+		} while (wait_time > 0);
+	}
+
+	/*
+	 * disable interrupts & legacy support
+	 */
+	outw(0, base + UHCI_USBINTR);
+	outw(0x1f, base + UHCI_USBSTS);
+	pci_read_config_word(pdev, UHCI_USBLEGSUP, &val);
+	if (val & 0xbf) 
+		pci_write_config_word(pdev, UHCI_USBLEGSUP, UHCI_USBLEGSUP_DEFAULT);
+		
+}
+
+static void __devinit quirk_usb_handoff_ohci(struct pci_dev *pdev)
+{
+	void __iomem *base;
+	int wait_time;
+
+	base = ioremap_nocache(pci_resource_start(pdev, 0),
+				     pci_resource_len(pdev, 0));
+	if (base == NULL) return;
+
+	if (readl(base + OHCI_CONTROL) & OHCI_CTRL_IR) {
+		wait_time = 500; /* 0.5 seconds */
+		writel(OHCI_INTR_OC, base + OHCI_INTRENABLE);
+		writel(OHCI_OCR, base + OHCI_CMDSTATUS);
+		while (wait_time > 0 && 
+				readl(base + OHCI_CONTROL) & OHCI_CTRL_IR) {
+			wait_time -= 10;
+			msleep(10);
+		}
+	}
+
+	/*
+	 * disable interrupts
+	 */
+	writel(~(u32)0, base + OHCI_INTRDISABLE);
+	writel(~(u32)0, base + OHCI_INTRSTATUS);
+
+	iounmap(base);
+}
+
+static void __devinit quirk_usb_disable_ehci(struct pci_dev *pdev)
+{
+	int wait_time, delta;
+	void __iomem *base, *op_reg_base;
+	u32 hcc_params, val, temp;
+	u8 cap_length;
+
+	base = ioremap_nocache(pci_resource_start(pdev, 0),
+				pci_resource_len(pdev, 0));
+	if (base == NULL) return;
+
+	cap_length = readb(base);
+	op_reg_base = base + cap_length;
+	hcc_params = readl(base + EHCI_HCC_PARAMS);
+	hcc_params = (hcc_params >> 8) & 0xff;
+	if (hcc_params) {
+		pci_read_config_dword(pdev, 
+					hcc_params + EHCI_USBLEGSUP,
+					&val);
+		if (((val & 0xff) == 1) && (val & EHCI_USBLEGSUP_BIOS)) {
+			/*
+			 * Ok, BIOS is in smm mode, try to hand off...
+			 */
+			pci_read_config_dword(pdev,
+						hcc_params + EHCI_USBLEGCTLSTS,
+						&temp);
+			pci_write_config_dword(pdev,
+						hcc_params + EHCI_USBLEGCTLSTS,
+						temp | EHCI_USBLEGCTLSTS_SOOE);
+			val |= EHCI_USBLEGSUP_OS;
+			pci_write_config_dword(pdev, 
+						hcc_params + EHCI_USBLEGSUP, 
+						val);
+
+			wait_time = 500;
+			do {
+				msleep(10);
+				wait_time -= 10;
+				pci_read_config_dword(pdev,
+						hcc_params + EHCI_USBLEGSUP,
+						&val);
+			} while (wait_time && (val & EHCI_USBLEGSUP_BIOS));
+			if (!wait_time) {
+				/*
+				 * well, possibly buggy BIOS...
+				 */
+				printk(KERN_WARNING "EHCI early BIOS handoff "
+						"failed (BIOS bug ?)\n");
+				pci_write_config_dword(pdev,
+						hcc_params + EHCI_USBLEGSUP,
+						EHCI_USBLEGSUP_OS);
+				pci_write_config_dword(pdev,
+						hcc_params + EHCI_USBLEGCTLSTS,
+						0);
+			}
+		}
+	}
+
+	/*
+	 * halt EHCI & disable its interrupts in any case
+	 */
+	val = readl(op_reg_base + EHCI_USBSTS);
+	if ((val & EHCI_USBSTS_HALTED) == 0) {
+		val = readl(op_reg_base + EHCI_USBCMD);
+		val &= ~EHCI_USBCMD_RUN;
+		writel(val, op_reg_base + EHCI_USBCMD);
+
+		wait_time = 2000;
+		delta = 100;
+		do {
+			writel(0x3f, op_reg_base + EHCI_USBSTS);
+			udelay(delta);
+			wait_time -= delta;
+			val = readl(op_reg_base + EHCI_USBSTS);
+			if ((val == ~(u32)0) || (val & EHCI_USBSTS_HALTED)) {
+				break;
+			}
+		} while (wait_time > 0);
+	}
+	writel(0, op_reg_base + EHCI_USBINTR);
+	writel(0x3f, op_reg_base + EHCI_USBSTS);
+
+	iounmap(base);
+
+	return;
+}
+
+
+
+static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
+{
+	if (!usb_early_handoff)
+		return;
+
+	if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x00)) { /* UHCI */
+		quirk_usb_handoff_uhci(pdev);
+	} else if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x10)) { /* OHCI */
+		quirk_usb_handoff_ohci(pdev);
+	} else if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x20)) { /* EHCI */
+		quirk_usb_disable_ehci(pdev);
+	}
+
+	return;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
--- g26.orig/drivers/pci/quirks.c	2005-09-09 22:50:09.000000000 -0700
+++ g26/drivers/pci/quirks.c	2005-09-10 01:06:27.000000000 -0700
@@ -7,6 +7,9 @@
  *
  *  Copyright (c) 1999 Martin Mares <mj@ucw.cz>
  *
+ *  Init/reset quirks for USB host controllers should be in the
+ *  USB quirks file, where their drivers can access reuse it.
+ *
  *  The bridge optimization stuff has been removed. If you really
  *  have a silly BIOS which is unable to set your host bridge right,
  *  use the PowerTweak utility (see http://powertweak.sourceforge.net).
@@ -558,28 +561,6 @@ static void quirk_via_irq(struct pci_dev
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_VIA, PCI_ANY_ID, quirk_via_irq);
 
 /*
- * PIIX3 USB: We have to disable USB interrupts that are
- * hardwired to PIRQD# and may be shared with an
- * external device.
- *
- * Legacy Support Register (LEGSUP):
- *     bit13:  USB PIRQ Enable (USBPIRQDEN),
- *     bit4:   Trap/SMI On IRQ Enable (USBSMIEN).
- *
- * We mask out all r/wc bits, too.
- */
-static void __devinit quirk_piix3_usb(struct pci_dev *dev)
-{
-	u16 legsup;
-
-	pci_read_config_word(dev, 0xc0, &legsup);
-	legsup &= 0x50ef;
-	pci_write_config_word(dev, 0xc0, legsup);
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371SB_2,	quirk_piix3_usb );
-DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_82371AB_2,	quirk_piix3_usb );
-
-/*
  * VIA VT82C598 has its device ID settable and many BIOSes
  * set it to the ID of VT82C597 for backward compatibility.
  * We need to switch it off to be able to recognize the real
@@ -927,234 +908,6 @@ static void __init quirk_sis_96x_smbus(s
 	pci_read_config_byte(dev, 0x77, &val);
 }
 
-
-#define UHCI_USBLEGSUP		0xc0		/* legacy support */
-#define UHCI_USBCMD		0		/* command register */
-#define UHCI_USBSTS		2		/* status register */
-#define UHCI_USBINTR		4		/* interrupt register */
-#define UHCI_USBLEGSUP_DEFAULT	0x2000		/* only PIRQ enable set */
-#define UHCI_USBCMD_RUN		(1 << 0)	/* RUN/STOP bit */
-#define UHCI_USBCMD_GRESET	(1 << 2)	/* Global reset */
-#define UHCI_USBCMD_CONFIGURE	(1 << 6)	/* config semaphore */
-#define UHCI_USBSTS_HALTED	(1 << 5)	/* HCHalted bit */
-
-#define OHCI_CONTROL		0x04
-#define OHCI_CMDSTATUS		0x08
-#define OHCI_INTRSTATUS		0x0c
-#define OHCI_INTRENABLE		0x10
-#define OHCI_INTRDISABLE	0x14
-#define OHCI_OCR		(1 << 3)	/* ownership change request */
-#define OHCI_CTRL_IR		(1 << 8)	/* interrupt routing */
-#define OHCI_INTR_OC		(1 << 30)	/* ownership change */
-
-#define EHCI_HCC_PARAMS		0x08		/* extended capabilities */
-#define EHCI_USBCMD		0		/* command register */
-#define EHCI_USBCMD_RUN		(1 << 0)	/* RUN/STOP bit */
-#define EHCI_USBSTS		4		/* status register */
-#define EHCI_USBSTS_HALTED	(1 << 12)	/* HCHalted bit */
-#define EHCI_USBINTR		8		/* interrupt register */
-#define EHCI_USBLEGSUP		0		/* legacy support register */
-#define EHCI_USBLEGSUP_BIOS	(1 << 16)	/* BIOS semaphore */
-#define EHCI_USBLEGSUP_OS	(1 << 24)	/* OS semaphore */
-#define EHCI_USBLEGCTLSTS	4		/* legacy control/status */
-#define EHCI_USBLEGCTLSTS_SOOE	(1 << 13)	/* SMI on ownership change */
-
-int usb_early_handoff __devinitdata = 0;
-static int __init usb_handoff_early(char *str)
-{
-	usb_early_handoff = 1;
-	return 0;
-}
-__setup("usb-handoff", usb_handoff_early);
-
-static void __devinit quirk_usb_handoff_uhci(struct pci_dev *pdev)
-{
-	unsigned long base = 0;
-	int wait_time, delta;
-	u16 val, sts;
-	int i;
-
-	for (i = 0; i < PCI_ROM_RESOURCE; i++)
-		if ((pci_resource_flags(pdev, i) & IORESOURCE_IO)) {
-			base = pci_resource_start(pdev, i);
-			break;
-		}
-
-	if (!base)
-		return;
-
-	/*
-	 * stop controller
-	 */
-	sts = inw(base + UHCI_USBSTS);
-	val = inw(base + UHCI_USBCMD);
-	val &= ~(u16)(UHCI_USBCMD_RUN | UHCI_USBCMD_CONFIGURE);
-	outw(val, base + UHCI_USBCMD);
-
-	/*
-	 * wait while it stops if it was running
-	 */
-	if ((sts & UHCI_USBSTS_HALTED) == 0)
-	{
-		wait_time = 1000;
-		delta = 100;
-
-		do {
-			outw(0x1f, base + UHCI_USBSTS);
-			udelay(delta);
-			wait_time -= delta;
-			val = inw(base + UHCI_USBSTS);
-			if (val & UHCI_USBSTS_HALTED)
-				break;
-		} while (wait_time > 0);
-	}
-
-	/*
-	 * disable interrupts & legacy support
-	 */
-	outw(0, base + UHCI_USBINTR);
-	outw(0x1f, base + UHCI_USBSTS);
-	pci_read_config_word(pdev, UHCI_USBLEGSUP, &val);
-	if (val & 0xbf) 
-		pci_write_config_word(pdev, UHCI_USBLEGSUP, UHCI_USBLEGSUP_DEFAULT);
-		
-}
-
-static void __devinit quirk_usb_handoff_ohci(struct pci_dev *pdev)
-{
-	void __iomem *base;
-	int wait_time;
-
-	base = ioremap_nocache(pci_resource_start(pdev, 0),
-				     pci_resource_len(pdev, 0));
-	if (base == NULL) return;
-
-	if (readl(base + OHCI_CONTROL) & OHCI_CTRL_IR) {
-		wait_time = 500; /* 0.5 seconds */
-		writel(OHCI_INTR_OC, base + OHCI_INTRENABLE);
-		writel(OHCI_OCR, base + OHCI_CMDSTATUS);
-		while (wait_time > 0 && 
-				readl(base + OHCI_CONTROL) & OHCI_CTRL_IR) {
-			wait_time -= 10;
-			msleep(10);
-		}
-	}
-
-	/*
-	 * disable interrupts
-	 */
-	writel(~(u32)0, base + OHCI_INTRDISABLE);
-	writel(~(u32)0, base + OHCI_INTRSTATUS);
-
-	iounmap(base);
-}
-
-static void __devinit quirk_usb_disable_ehci(struct pci_dev *pdev)
-{
-	int wait_time, delta;
-	void __iomem *base, *op_reg_base;
-	u32 hcc_params, val, temp;
-	u8 cap_length;
-
-	base = ioremap_nocache(pci_resource_start(pdev, 0),
-				pci_resource_len(pdev, 0));
-	if (base == NULL) return;
-
-	cap_length = readb(base);
-	op_reg_base = base + cap_length;
-	hcc_params = readl(base + EHCI_HCC_PARAMS);
-	hcc_params = (hcc_params >> 8) & 0xff;
-	if (hcc_params) {
-		pci_read_config_dword(pdev, 
-					hcc_params + EHCI_USBLEGSUP,
-					&val);
-		if (((val & 0xff) == 1) && (val & EHCI_USBLEGSUP_BIOS)) {
-			/*
-			 * Ok, BIOS is in smm mode, try to hand off...
-			 */
-			pci_read_config_dword(pdev,
-						hcc_params + EHCI_USBLEGCTLSTS,
-						&temp);
-			pci_write_config_dword(pdev,
-						hcc_params + EHCI_USBLEGCTLSTS,
-						temp | EHCI_USBLEGCTLSTS_SOOE);
-			val |= EHCI_USBLEGSUP_OS;
-			pci_write_config_dword(pdev, 
-						hcc_params + EHCI_USBLEGSUP, 
-						val);
-
-			wait_time = 500;
-			do {
-				msleep(10);
-				wait_time -= 10;
-				pci_read_config_dword(pdev,
-						hcc_params + EHCI_USBLEGSUP,
-						&val);
-			} while (wait_time && (val & EHCI_USBLEGSUP_BIOS));
-			if (!wait_time) {
-				/*
-				 * well, possibly buggy BIOS...
-				 */
-				printk(KERN_WARNING "EHCI early BIOS handoff "
-						"failed (BIOS bug ?)\n");
-				pci_write_config_dword(pdev,
-						hcc_params + EHCI_USBLEGSUP,
-						EHCI_USBLEGSUP_OS);
-				pci_write_config_dword(pdev,
-						hcc_params + EHCI_USBLEGCTLSTS,
-						0);
-			}
-		}
-	}
-
-	/*
-	 * halt EHCI & disable its interrupts in any case
-	 */
-	val = readl(op_reg_base + EHCI_USBSTS);
-	if ((val & EHCI_USBSTS_HALTED) == 0) {
-		val = readl(op_reg_base + EHCI_USBCMD);
-		val &= ~EHCI_USBCMD_RUN;
-		writel(val, op_reg_base + EHCI_USBCMD);
-
-		wait_time = 2000;
-		delta = 100;
-		do {
-			writel(0x3f, op_reg_base + EHCI_USBSTS);
-			udelay(delta);
-			wait_time -= delta;
-			val = readl(op_reg_base + EHCI_USBSTS);
-			if ((val == ~(u32)0) || (val & EHCI_USBSTS_HALTED)) {
-				break;
-			}
-		} while (wait_time > 0);
-	}
-	writel(0, op_reg_base + EHCI_USBINTR);
-	writel(0x3f, op_reg_base + EHCI_USBSTS);
-
-	iounmap(base);
-
-	return;
-}
-
-
-
-static void __devinit quirk_usb_early_handoff(struct pci_dev *pdev)
-{
-	if (!usb_early_handoff)
-		return;
-
-	if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x00)) { /* UHCI */
-		quirk_usb_handoff_uhci(pdev);
-	} else if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x10)) { /* OHCI */
-		quirk_usb_handoff_ohci(pdev);
-	} else if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x20)) { /* EHCI */
-		quirk_usb_disable_ehci(pdev);
-	}
-
-	return;
-}
-DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_early_handoff);
-
 /*
  * ... This is further complicated by the fact that some SiS96x south
  * bridges pretend to be 85C503/5513 instead.  In that case see if we
