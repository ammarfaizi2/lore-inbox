Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270070AbUJTNnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270070AbUJTNnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270067AbUJTNmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:42:33 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:29874 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S270276AbUJTM5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 08:57:33 -0400
Message-ID: <417660AE.4060408@t-online.de>
Date: Wed, 20 Oct 2004 14:57:18 +0200
From: "Harald Dunkel" <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6.7, amd64: PS/2 Mouse detection doesn't work
References: <40F0E586.4040000@t-online.de> <20040711084208.GA1322@ucw.cz>
In-Reply-To: <20040711084208.GA1322@ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------090601020606030207010205"
X-ID: bpPlC-ZZYeuDbwAcrgGl6EC4zp9JbG85dnrFnlxjkDzyU-muFAjS8J
X-TOI-MSGID: 69509e1d-d48e-421e-b188-8aee7bfd17df
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090601020606030207010205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

Attached you can find an updated patch for 2.6.9.


Regards

Harri


--------------090601020606030207010205
Content-Type: text/plain;
 name="psmouse-usb-fix-3.new"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="psmouse-usb-fix-3.new"

--- /tmp/linux-2.6.9/drivers/pci/quirks.c	2004-10-18 23:53:06.000000000 +0200
+++ linux-2.6.9/drivers/pci/quirks.c	2004-10-20 14:21:02.000000000 +0200
@@ -826,6 +826,69 @@
 	pci_read_config_byte(dev, 0x77, &val);
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
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID,		PCI_ANY_ID,			quirk_usb_disable_smm_bios );
+#endif
+
 /*
  * ... This is further complicated by the fact that some SiS96x south
  * bridges pretend to be 85C503/5513 instead.  In that case see if we


--------------090601020606030207010205--
