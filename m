Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263033AbVHEORt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263033AbVHEORt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVHEORt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:17:49 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:24285 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S263033AbVHEOR1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:17:27 -0400
X-ORBL: [69.107.32.110]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:message-id;
	b=TWq+g+uJ2EddWDB4N346kw0KfLVTKGNWWunlHiG9Cb70oCHQWwlY9Y0P5+PYV6nJD
	v2b/yIOaWGV9Tt48L7R9A==
Date: Fri, 05 Aug 2005 07:17:20 -0700
From: david-b@pacbell.net
To: greg@kroah.com
Subject: Re: [linux-usb-devel] Re: 2.6.13-rc4-mm1
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       iogl64nx@gmail.com, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050805141720.2BD10DCA46@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 31 Jul 2005 19:02:09 -0700
> From: david-b@pacbell.net
>
> > Date: Sun, 31 Jul 2005 16:02:44 -0700
> > From: Greg KH <greg@kroah.com>
> >
> > On Sun, Jul 31, 2005 at 11:25:10AM -0700, david-b@pacbell.net wrote:
> > > I think that "continuing" codepath came from someone at Phoenix, FWIW;
> > > the problem is that I see the PCI quirks code has evolved even farther
> > > from the main copy of the init code in the USB tree.  Sigh.
> >
> > I don't like that either, but can't think of a way to make it easier to
> > keep them in sync.  Can you?
>
> Sure.  The problem as I see it is that there are two copies, and one
> of them isn't in the USB part of the tree.  So just move it, and cope
> with the consequences during the 2.6.14 cycle:
>
>   (a) Move the USB quirks out of the generic PCI drivers directory
>       into the USB HCD directory (see the attached patch);
>
>   (b) foreach HCD in (ehci ohci uhci) do:
>   
>       (1) Merge the two different routines:  HCD internal init/reset
>           and the PCI quirk code are identical in intent, but they
> 	  each address different sets of quirks.
>
>       (2) Then the HCD reset() and PCI quirk() code will call those
>           single shared routine. 

Attached, find a patch addressing the additional Makefile issue ...


> At OLS, Vojtech mentioned wanting to make "usb-handoff" be the default.
> That's seem plausible (USB has more than its fair share of BIOS issues!)
> but should only kick in sometime after we merge the two different sets
> of quirk handling logic.

... but conflicting with a patch Vojtech just submitted for "-mm";
which, as I said, should IMO kick in only after we merge the two
different sets of quirk logic.

- Dave



This moves the PCI quirk handling for USB host controllers from the
PCI directory to the USB directory.

Follow-on patches will need to:

 - Merge the two copies that exist ... so EHCI, OHCI, and UHCI
   each have only one copy of this PCI-specific init logic, and
   it agrees with more recent code that's aware of _different_
   sets of quirks.

 - We should probably make "usb-handoff" be the default.  The
   late handoff seems to confuse some BIOS versions, and then
   the input subsystem.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/usb/host/Makefile
===================================================================
--- g26.orig/drivers/usb/host/Makefile	2005-08-02 06:59:22.000000000 -0700
+++ g26/drivers/usb/host/Makefile	2005-08-02 07:58:44.000000000 -0700
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
Index: g26/drivers/usb/Makefile
===================================================================
--- g26.orig/drivers/usb/Makefile	2005-08-02 06:59:22.000000000 -0700
+++ g26/drivers/usb/Makefile	2005-08-02 07:58:44.000000000 -0700
@@ -8,6 +8,7 @@ obj-$(CONFIG_USB)		+= core/
 
 obj-$(CONFIG_USB_MON)		+= mon/
 
+obj-$(CONFIG_PCI)		+= host/
 obj-$(CONFIG_USB_EHCI_HCD)	+= host/
 obj-$(CONFIG_USB_ISP116X_HCD)	+= host/
 obj-$(CONFIG_USB_OHCI_HCD)	+= host/
Index: g26/drivers/Makefile
===================================================================
--- g26.orig/drivers/Makefile	2005-08-02 06:59:22.000000000 -0700
+++ g26/drivers/Makefile	2005-08-02 07:58:44.000000000 -0700
@@ -5,7 +5,7 @@
 # Rewritten to use lists instead of if-statements.
 #
 
-obj-$(CONFIG_PCI)		+= pci/
+obj-$(CONFIG_PCI)		+= pci/ usb/host/
 obj-$(CONFIG_PARISC)		+= parisc/
 obj-y				+= video/
 obj-$(CONFIG_ACPI_BOOT)		+= acpi/
Index: g26/drivers/usb/host/pci-quirks.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/usb/host/pci-quirks.c	2005-08-02 07:58:44.000000000 -0700
@@ -0,0 +1,279 @@
+/*
+ * This file contains work-arounds for many known PCI hardware and BIOS
+ * quirks relating to USB host controllers.
+ *
+ * There are a lot of those, especially on hardware that needs to work
+ * with USB mice and keyboard for booting.  And this code needs to fire
+ * early; before the input subsystem gets initialized, and while BIOS
+ * (or SMI) code has few problems running.
+ *
+ * They're collected here since USB host controller drivers need to use
+ * the same code as part of hardware initialization.
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
+// #include "pci.h"
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
+/* FIXME this should be the same code that the USB controllers use...
+ * the hcd->reset() method basically does this.
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
Index: g26/drivers/pci/quirks.c
===================================================================
--- g26.orig/drivers/pci/quirks.c	2005-08-02 07:06:10.000000000 -0700
+++ g26/drivers/pci/quirks.c	2005-08-02 07:58:44.000000000 -0700
@@ -7,6 +7,9 @@
  *
  *  Copyright (c) 1999 Martin Mares <mj@ucw.cz>
  *
+ *  Quirks for USB host controllers should be handled in the USB
+ *  quirks file; that code is reused by host controller drivers.
+ *
  *  The bridge optimization stuff has been removed. If you really
  *  have a silly BIOS which is unable to set your host bridge right,
  *  use the PowerTweak utility (see http://powertweak.sourceforge.net).
@@ -513,28 +516,6 @@ static void quirk_via_irq(struct pci_dev
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
@@ -876,234 +857,6 @@ static void __init quirk_sis_96x_smbus(s
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
