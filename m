Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266524AbUGKIl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266524AbUGKIl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 04:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUGKIly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 04:41:54 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:49285 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266522AbUGKIl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 04:41:29 -0400
Date: Sun, 11 Jul 2004 10:42:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Harald Dunkel <harald.dunkel@t-online.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7, amd64: PS/2 Mouse detection doesn't work
Message-ID: <20040711084208.GA1322@ucw.cz>
References: <40F0E586.4040000@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <40F0E586.4040000@t-online.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 11, 2004 at 09:00:22AM +0200, Harald Dunkel wrote:
> Hi folks,
> 
> Most of the times my mouse is detected as generic PS/2,
> even though it is a Logitech. I have to reload the mousedev
> and psmouse modules to make it work.
> 
> # grep -i mouse /var/log/kern.log
> Jul 10 17:23:08 r101 kernel: input: PS/2 Generic Mouse on isa0060/serio1
> Jul 10 17:23:08 r101 kernel: mice: PS/2 mouse device common for all mice
> Jul 10 17:24:59 r101 kernel: input: PS/2 Generic Mouse on isa0060/serio1
> Jul 10 17:24:59 r101 kernel: mice: PS/2 mouse device common for all mice
> Jul 10 17:43:41 r101 kernel: input: PS2++ Logitech Mouse on isa0060/serio1
> Jul 10 17:43:41 r101 kernel: mice: PS/2 mouse device common for all mice
> Jul 10 17:46:59 r101 kernel: input: PS2++ Logitech Mouse on isa0060/serio1
> Jul 10 17:47:00 r101 kernel: mice: PS/2 mouse device common for all mice
> Jul 11 07:34:34 r101 kernel: input: PS/2 Generic Mouse on isa0060/serio1
> Jul 11 07:34:34 r101 kernel: mice: PS/2 mouse device common for all mice
> Jul 11 07:36:01 r101 kernel: input: PS/2 Generic Mouse on isa0060/serio1
> Jul 11 07:36:01 r101 kernel: mice: PS/2 mouse device common for all mice
> Jul 11 08:43:33 r101 kernel: mice: PS/2 mouse device common for all mice
> Jul 11 08:43:33 r101 kernel: input: PS2++ Logitech Mouse on isa0060/serio1
> 
> 
> Usually I wouldn't care, but I can go mad if the 4th mouse
> button doesn't work :-).
> 
> Any idea?
 
Build the USB drivers into the kernel, or use the attached patch.
If it helps, please tell me.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=psmouse-usb-fix-3

ChangeSet@1.1831, 2004-04-03 23:30:39+02:00, vojtech@suse.cz
  input: Disable USB Legacy emulation in PCI quirks.


 quirks.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 62 insertions(+)


diff -Nru a/drivers/pci/quirks.c b/drivers/pci/quirks.c
--- a/drivers/pci/quirks.c	Sat Apr  3 23:30:49 2004
+++ b/drivers/pci/quirks.c	Sat Apr  3 23:30:49 2004
@@ -868,6 +868,68 @@
 }
 #endif /* CONFIG_SCSI_SATA */
 
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
+#if defined(__i386__) || defined(__x86_64__)
+static void __init quirk_usb_disable_smm_bios(struct pci_dev *pdev)
+{
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
+       		schedule_timeout((HZ*50+999) / 1000);
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
+#endif
+
 /*
  *  The main table of quirks.
  *
@@ -983,6 +1043,10 @@
 	{ PCI_FIXUP_FINAL,      PCI_VENDOR_ID_INTEL,    PCI_ANY_ID,
 	  quirk_intel_ide_combined },
 #endif /* CONFIG_SCSI_SATA */
+
+#if defined(__i386__) || defined(__x86_64__)
+	{ PCI_FIXUP_FINAL,	PCI_ANY_ID,		PCI_ANY_ID,			quirk_usb_disable_smm_bios },
+#endif
 
 	{ 0 }
 };

--ZPt4rx8FFjLCG7dd--
