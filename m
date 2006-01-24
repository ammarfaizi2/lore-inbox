Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030354AbWAXPPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbWAXPPd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbWAXPPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:15:32 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:29861 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030351AbWAXPPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:15:31 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Date: Tue, 24 Jan 2006 07:15:30 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       "Carlo E. Prelz" <fluido@fluido.as>, linux-kernel@vger.kernel.org
References: <20060120123202.GA1138@epio.fluido.as> <200601231101.25268.david-b@pacbell.net> <20060124044213.GA22270@kroah.com>
In-Reply-To: <20060124044213.GA22270@kroah.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SSk1DOsoQjin7mS"
Message-Id: <200601240715.30368.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_SSk1DOsoQjin7mS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 23 January 2006 8:42 pm, Greg KH wrote:
> On Mon, Jan 23, 2006 at 11:01:25AM -0800, David Brownell wrote:
> > This moves the previously widely-used ehci-pci.c BIOS handoff
> > code into the pci-quirks.c file, replacing the less widely used
> > "early handoff" version that seems to cause problems lately.
> > 
> > One notable change:  the "early handoff" version always enabled
> > an SMI IRQ ... and did so even if the pre-Linux code said it was
> > not using EHCI (and not expecting EHCI SMIs).  Looks like a goof
> > in a workaround for some unknown BIOS version.
> > 
> > This merged version only forcibly enables those IRQs when pre-Linux
> > code says it's using EHCI.  And now it always forces them off "just
> > in case".
> 
> Thanks for posting this, it fixes my EHCI + APIC error, and makes my
> laptop work just fine.

OK, here's a version with a Signed-Off-By; against current GIT.

I'm mildly surprised it helps that laptop, but not surprised that
it helps _some_ of those "ehci init goofs" cases.  :)

- Dave




--Boundary-00=_SSk1DOsoQjin7mS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ehci-handoff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ehci-handoff.patch"

This moves the previously widely-used ehci-pci.c BIOS handoff
code into the pci-quirks.c file, replacing the less widely used
"early handoff" version that seems to cause problems lately.

One notable change:  the "early handoff" version always enabled
an SMI IRQ ... and did so even if the pre-Linux code said it was
not using EHCI (and not expecting EHCI SMIs).  Looks like a goof
in a workaround for some unknown BIOS version.

This merged version only forcibly enables those IRQs when pre-Linux
code says it's using EHCI.  And now it always forces them off "just
in case".

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/drivers/usb/host/ehci-pci.c
===================================================================
--- g26.orig/drivers/usb/host/ehci-pci.c	2006-01-15 12:59:13.000000000 -0800
+++ g26/drivers/usb/host/ehci-pci.c	2006-01-22 09:17:54.000000000 -0800
@@ -24,40 +24,6 @@
 
 /*-------------------------------------------------------------------------*/
 
-/* EHCI 0.96 (and later) section 5.1 says how to kick BIOS/SMM/...
- * off the controller (maybe it can boot from highspeed USB disks).
- */
-static int bios_handoff(struct ehci_hcd *ehci, int where, u32 cap)
-{
-	struct pci_dev *pdev = to_pci_dev(ehci_to_hcd(ehci)->self.controller);
-
-	/* always say Linux will own the hardware */
-	pci_write_config_byte(pdev, where + 3, 1);
-
-	/* maybe wait a while for BIOS to respond */
-	if (cap & (1 << 16)) {
-		int msec = 5000;
-
-		do {
-			msleep(10);
-			msec -= 10;
-			pci_read_config_dword(pdev, where, &cap);
-		} while ((cap & (1 << 16)) && msec);
-		if (cap & (1 << 16)) {
-			ehci_err(ehci, "BIOS handoff failed (%d, %08x)\n",
-				where, cap);
-			// some BIOS versions seem buggy...
-			// return 1;
-			ehci_warn(ehci, "continuing after BIOS bug...\n");
-			/* disable all SMIs, and clear "BIOS owns" flag */
-			pci_write_config_dword(pdev, where + 4, 0);
-			pci_write_config_byte(pdev, where + 2, 0);
-		} else
-			ehci_dbg(ehci, "BIOS handoff succeeded\n");
-	}
-	return 0;
-}
-
 /* called after powerup, by probe or system-pm "wakeup" */
 static int ehci_pci_reinit(struct ehci_hcd *ehci, struct pci_dev *pdev)
 {
@@ -84,32 +50,9 @@ static int ehci_pci_reinit(struct ehci_h
 		}
 	}
 
-	temp = HCC_EXT_CAPS(readl(&ehci->caps->hcc_params));
-
-	/* EHCI 0.96 and later may have "extended capabilities" */
-	while (temp && count--) {
-		u32		cap;
-
-		pci_read_config_dword(pdev, temp, &cap);
-		ehci_dbg(ehci, "capability %04x at %02x\n", cap, temp);
-		switch (cap & 0xff) {
-		case 1:			/* BIOS/SMM/... handoff */
-			if (bios_handoff(ehci, temp, cap) != 0)
-				return -EOPNOTSUPP;
-			break;
-		case 0:			/* illegal reserved capability */
-			ehci_dbg(ehci, "illegal capability!\n");
-			cap = 0;
-			/* FALLTHROUGH */
-		default:		/* unknown */
-			break;
-		}
-		temp = (cap >> 8) & 0xff;
-	}
-	if (!count) {
-		ehci_err(ehci, "bogus capabilities ... PCI problems!\n");
-		return -EIO;
-	}
+	/* we expect static quirk code to handle the "extended capabilities"
+	 * (currently just BIOS handoff) allowed starting with EHCI 0.96
+	 */
 
 	/* PCI Memory-Write-Invalidate cycle support is optional (uncommon) */
 	retval = pci_set_mwi(pdev);
Index: g26/drivers/usb/host/pci-quirks.c
===================================================================
--- g26.orig/drivers/usb/host/pci-quirks.c	2006-01-05 17:35:38.000000000 -0800
+++ g26/drivers/usb/host/pci-quirks.c	2006-01-22 11:20:52.000000000 -0800
@@ -190,7 +190,7 @@ static void __devinit quirk_usb_handoff_
 			msleep(10);
 		}
 		if (wait_time <= 0)
-			printk(KERN_WARNING "%s %s: early BIOS handoff "
+			printk(KERN_WARNING "%s %s: BIOS handoff "
 					"failed (BIOS bug ?)\n",
 					pdev->dev.bus_id, "OHCI");
 
@@ -212,8 +212,9 @@ static void __devinit quirk_usb_disable_
 {
 	int wait_time, delta;
 	void __iomem *base, *op_reg_base;
-	u32 hcc_params, val, temp;
-	u8 cap_length;
+	u32	hcc_params, val;
+	u8	offset, cap_length;
+	int	count = 256/4;
 
 	if (!mmio_resource_enabled(pdev, 0))
 		return;
@@ -224,51 +225,80 @@ static void __devinit quirk_usb_disable_
 
 	cap_length = readb(base);
 	op_reg_base = base + cap_length;
+
+	/* EHCI 0.96 and later may have "extended capabilities"
+	 * spec section 5.1 explains the bios handoff, e.g. for
+	 * booting from USB disk or using a usb keyboard
+	 */
 	hcc_params = readl(base + EHCI_HCC_PARAMS);
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
+	offset = (hcc_params >> 8) & 0xff;
+	while (offset && count--) {
+		u32		cap;
+		int		msec;
+
+		pci_read_config_dword(pdev, offset, &cap);
+		switch (cap & 0xff) {
+		case 1:			/* BIOS/SMM/... handoff support */
+			if ((cap & EHCI_USBLEGSUP_BIOS)) {
+				pr_debug("%s %s: BIOS handoff\n",
+						pdev->dev.bus_id, "EHCI");
 
-			wait_time = 500;
-			do {
-				msleep(10);
-				wait_time -= 10;
+				/* BIOS workaround (?): be sure the
+				 * pre-Linux code receives the SMI
+				 */
 				pci_read_config_dword(pdev,
-						hcc_params + EHCI_USBLEGSUP,
+						offset + EHCI_USBLEGCTLSTS,
 						&val);
-			} while (wait_time && (val & EHCI_USBLEGSUP_BIOS));
-			if (!wait_time) {
-				/*
-				 * well, possibly buggy BIOS...
+				pci_write_config_dword(pdev,
+						offset + EHCI_USBLEGCTLSTS,
+						val | EHCI_USBLEGCTLSTS_SOOE);
+			}
+
+			/* always say Linux will own the hardware
+			 * by setting EHCI_USBLEGSUP_OS.
+			 */
+			pci_write_config_byte(pdev, offset + 3, 1);
+
+			/* if boot firmware now owns EHCI, spin till
+			 * it hands it over.
+			 */
+			msec = 5000;
+			while ((cap & EHCI_USBLEGSUP_BIOS) && (msec > 0)) {
+				msleep(10);
+				msec -= 10;
+				pci_read_config_dword(pdev, offset, &cap);
+			}
+
+			if (cap & EHCI_USBLEGSUP_BIOS) {
+				/* well, possibly buggy BIOS... try to shut
+				 * it down, and hope nothing goes too wrong
 				 */
-				printk(KERN_WARNING "%s %s: early BIOS handoff "
+				printk(KERN_WARNING "%s %s: BIOS handoff "
 						"failed (BIOS bug ?)\n",
 					pdev->dev.bus_id, "EHCI");
-				pci_write_config_dword(pdev,
-						hcc_params + EHCI_USBLEGSUP,
-						EHCI_USBLEGSUP_OS);
-				pci_write_config_dword(pdev,
-						hcc_params + EHCI_USBLEGCTLSTS,
-						0);
+				pci_write_config_byte(pdev, offset + 2, 0);
 			}
+
+			/* just in case, always disable EHCI SMIs */
+			pci_write_config_dword(pdev,
+					offset + EHCI_USBLEGCTLSTS,
+					0);
+			break;
+		case 0:			/* illegal reserved capability */
+			cap = 0;
+			/* FALLTHROUGH */
+		default:
+			printk(KERN_WARNING "%s %s: unrecognized "
+					"capability %02x\n",
+					pdev->dev.bus_id, "EHCI",
+					cap & 0xff);
+			break;
 		}
+		offset = (cap >> 8) & 0xff;
 	}
+	if (!count)
+		printk(KERN_DEBUG "%s %s: capability loop?\n",
+				pdev->dev.bus_id, "EHCI");
 
 	/*
 	 * halt EHCI & disable its interrupts in any case

--Boundary-00=_SSk1DOsoQjin7mS--
