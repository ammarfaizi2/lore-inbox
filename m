Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269207AbUJUGmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269207AbUJUGmJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 02:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269155AbUJUGkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 02:40:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36573 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269170AbUJUG2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 02:28:10 -0400
Date: Wed, 20 Oct 2004 23:26:59 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, vojtech@suse.cz,
       <johnstul@us.ibm.com>, Aleksey_Gorelov@Phoenix.com
Subject: Re: forcing PS/2 USB emulation off
Message-ID: <20041020232659.73bc8838@lembas.zaitcev.lan>
In-Reply-To: <mailman.1098042300.20451.linux-kernel2news@redhat.com>
References: <mailman.1098042300.20451.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Oct 2004 16:34:35 -0300, Alexandre Oliva <aoliva@redhat.com> wrote:

> Here's Vojtech's patch, updated to 2.6.9-rc4-bk2-ish (Fedora Core
> kernel-2.6.8-1.624).  Is there a good reason to keep it out of the
> base kernel?

Looks like something pre-historic. But I cannot blame you for not paying
attention to little elves working on patches, because there was no way
to do it. If hackers always sent their patches to mailing lists instead
of maintainers directly, it might have saved hacking on obsolete patches
and made world a better place, I reckon. Attached is the latest I have,
but with all the activity under the carpet I cannot be sure that one is
the head of the development either.

Anyone having a newer version please speak up.

-- Pete

Subject: [PATCH] early usb handoff for 2.6
From: john stultz <johnstul@us.ibm.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, Aleksey_Gorelov@Phoenix.com, vojtech@suse.cz
Message-Id: <1094778721.29408.178.camel@cog.beaverton.ibm.com>
Date: Thu, 09 Sep 2004 18:12:02 -0700

Greg,
        Apparently there is an issue w/ the IBM x440/x445's BIOS's USB
Legacy support. Due to the delay in issuing SMI's across the IOAPICs,
its possible for I/O to ports 60/64 to cause register corruption. 

The solution is to disable the BIOS's USB Legacy support early in
boot(via PCI quirks) for x440/x445 systems. 

Originally written by Vojtech against SuSE's tree, this patch was then
updated to disable EHCI by Aleksey Gorelov, cleaned up by Pete Zaitcev
for 2.4 and finally tweaked and updated against 2.6 by me.

I've lightly tested this version of the patch, but it differs little
from what Aleksey, Pete and I have been testing for 2.4. 

Please consider for inclusion into your tree for further testing?

thanks
-john

linux-2.6.9-rc1_usb-handoff_A3.patch
====================================
diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-09-09 17:59:01 -07:00
+++ b/Documentation/kernel-parameters.txt	2004-09-09 17:59:01 -07:00
@@ -1270,6 +1270,8 @@
 
 	uart6850=	[HW,OSS]
 			Format: <io>,<irq>
+
+	usb-handoff	[HW] Enable early USB BIOS -> OS handoff
  
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.txt.
diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	2004-09-09 17:59:01 -07:00
+++ b/drivers/pci/quirks.c	2004-09-09 17:59:01 -07:00
@@ -826,6 +826,236 @@
 	pci_read_config_byte(dev, 0x77, &val);
 }
 
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
+int usb_early_handoff __initdata = 0;
+static int __init usb_handoff_early(char *str)
+{
+	usb_early_handoff = 1;
+	return 0;
+}
+__setup("usb-handoff", usb_handoff_early);
+
+static void __init quirk_usb_handoff_uhci(struct pci_dev *pdev)
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
+static void __init quirk_usb_handoff_ohci(struct pci_dev *pdev)
+{
+	char *base;
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
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_timeout((HZ*10 + 999) / 1000);
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
+static void __init quirk_usb_disable_ehci(struct pci_dev *pdev)
+{
+	int wait_time, delta;
+	char *base, *op_reg_base;
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
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule_timeout((HZ*10+999)/1000);
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
+static void __init quirk_usb_early_handoff(struct pci_dev *pdev)
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
+
 /*
  * ... This is further complicated by the fact that some SiS96x south
  * bridges pretend to be 85C503/5513 instead.  In that case see if we
diff -Nru a/include/asm-i386/mach-summit/mach_mpparse.h b/include/asm-i386/mach-summit/mach_mpparse.h
--- a/include/asm-i386/mach-summit/mach_mpparse.h	2004-09-09 17:59:01 -07:00
+++ b/include/asm-i386/mach-summit/mach_mpparse.h	2004-09-09 17:59:01 -07:00
@@ -22,6 +22,7 @@
 {
 }
 
+extern int usb_early_handoff;
 static inline int mps_oem_check(struct mp_config_table *mpc, char *oem, 
 		char *productid)
 {
@@ -31,6 +32,7 @@
 			 || !strncmp(productid, "RUTHLESS SMP", 12))){
 		use_cyclone = 1; /*enable cyclone-timer*/
 		setup_summit();
+		usb_early_handoff = 1;
 		return 1;
 	}
 	return 0;
@@ -44,6 +46,7 @@
 	     || !strncmp(oem_table_id, "EXA", 3))){
 		use_cyclone = 1; /*enable cyclone-timer*/
 		setup_summit();
+		usb_early_handoff = 1;
 		return 1;
 	}
 	return 0;
