Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269321AbUJQTh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269321AbUJQTh6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269293AbUJQTgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:36:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40917 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269297AbUJQTey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:34:54 -0400
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: forcing PS/2 USB emulation off
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 17 Oct 2004 16:34:35 -0300
Message-ID: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

To get the touchpad to work on my Compaq Presario r3004 notebook, in
addition to ALPS Touchpad patches by Dmitry Torokhov, I needed a patch
by Vojtech Pavlik that disabled PS/2 USB emulation early in the boot.
The BIOS didn't have an option to disable it, and, without it, PS/2
mouse detection wouldn't find anything and, if psmouse is built into
the kernel, as it happens to be the case for Fedora Core kernels,
there's no way to re-probe.

Having no idea of how safe/portable Vojtech's patch was, and assuming
some people might actually be relying on PS/2 USB emulation, I figured
it would be a good idea to not enable the code by default, requiring a
command-line option to do it instead.

The whole story is at
http://www.ic.unicamp.br/~oliva/snapshots/FC3-r3004/

Here's Vojtech's patch, updated to 2.6.9-rc4-bk2-ish (Fedora Core
kernel-2.6.8-1.624).  Is there a good reason to keep it out of the
base kernel?

Thanks to Vojtech and Dmitry for getting most of the work done, and
Arjan for pointing out the possibility of, and the existence of a
patch for, disabling USB emulation early in the boot.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=linux-2.6.9-nops2usbemul.patch

This patch introduces an option to force PS/2 USB emulation off.  Most
of the patch is by Vojtech Pavlik, I only updated it to 2.6.9ish
kernel and made it conditional on the nops2usbemul option.

--- a/drivers/pci/quirks.c	2004-10-17 04:24:28.000000000 -0300
+++ b/drivers/pci/quirks.c	2004-10-17 15:19:35.000000000 -0300
@@ -545,6 +545,76 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID,		PCI_ANY_ID,			quirk_cardbus_legacy );
 
+#if defined(__i386__) || defined(__x86_64__)
+#define UHCI_USBLEGSUP 0xc0 /* legacy support */
+#define UHCI_USBCMD 0 /* command register */
+#define UHCI_USBINTR 4 /* interrupt register */
+#define UHCI_USBLEGSUP_DEFAULT 0x2000 /* only PIRQ enable set */
+#define UHCI_USBCMD_GRESET 0x0004 /* Global reset */
+
+#define OHCI_CONTROL 0x04
+#define OHCI_CMDSTATUS 0x08
+#define OHCI_INTRENABLE 0x10
+#define OHCI_OCR (1 << 3) /* ownership change request */
+#define OHCI_CTRL_IR (1 << 8) /* interrupt routing */
+#define OHCI_INTR_OC (1 << 30) /* ownership change */
+
+/* If the BIOS doesn't have an option to disable legacy USB emulation,
+   and such emulation actually gets in the way of proper probing of
+   PS/2 devices, the nops2usbemul option should help.  */
+static void __init quirk_usb_disable_smm_bios(struct pci_dev *pdev)
+{
+  extern char saved_command_line[];
+
+  if (!strstr(saved_command_line, "nops2usbemul"))
+    return;
+
+  if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x00)) { /* UHCI */
+    int i;
+    unsigned long base = 0;;
+
+    for (i = 0; i < PCI_ROM_RESOURCE; i++)
+      if ((pci_resource_flags(pdev, i) & IORESOURCE_IO)) {
+	base = pci_resource_start(pdev, i);
+	break;
+      }
+
+    if (!base)
+      return;
+
+    outw(0, base + UHCI_USBINTR);
+    outw(UHCI_USBCMD_GRESET, base + UHCI_USBCMD);
+    set_current_state(TASK_UNINTERRUPTIBLE);
+    schedule_timeout((HZ*50+999) / 1000);
+    outw(0, base + UHCI_USBCMD);
+    set_current_state(TASK_UNINTERRUPTIBLE);
+    schedule_timeout((HZ*10+999) / 1000);
+
+    pci_write_config_word(pdev, UHCI_USBLEGSUP, UHCI_USBLEGSUP_DEFAULT);
+  }
+
+  if (pdev->class == ((PCI_CLASS_SERIAL_USB << 8) | 0x10)) { /* OHCI */
+    char *base = ioremap_nocache(pci_resource_start(pdev, 0),
+				 pci_resource_len(pdev, 0));
+    if (base == NULL) return;
+
+    if (readl(base + OHCI_CONTROL) & OHCI_CTRL_IR) {
+      int temp = 500; /* arbitrary: five seconds */
+      writel(OHCI_INTR_OC, base + OHCI_INTRENABLE);
+      writel(OHCI_OCR, base + OHCI_CMDSTATUS);
+      while (temp && readl(base + OHCI_CONTROL) & OHCI_CTRL_IR) {
+	temp--;
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout( HZ / 100);
+      }
+    }
+    iounmap(base);
+  }
+}
+
+DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_usb_disable_smm_bios);
+#endif
+
 /*
  * Following the PCI ordering rules is optional on the AMD762. I'm not
  * sure what the designers were smoking but let's not inhale...

--- a/Documentation/kernel-parameters.txt	2004-10-17 04:23:11.000000000 -0300
+++ b/Documentation/kernel-parameters.txt	2004-10-17 15:19:15.000000000 -0300
@@ -818,6 +818,8 @@
 
 	nousb		[USB] Disable the USB subsystem
 
+	nops2usbemul	[PCI,IA-32,X86_64] Disable PS/2 USB emulation
+
 	nowb		[ARM]
  
 	opl3=		[HW,OSS]

--=-=-=


-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

--=-=-=--
