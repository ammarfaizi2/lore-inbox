Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbUKWFEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbUKWFEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 00:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbUKWFCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 00:02:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:48871 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262196AbUKWE5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 23:57:47 -0500
Date: Mon, 22 Nov 2004 20:57:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Stian Jordet <stian_web@jordet.nu>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <Pine.LNX.4.58.0411221815460.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411222048120.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>  <1100819685.987.120.camel@d845pe>
 <20041118230948.W2357@build.pdx.osdl.net>  <1100941324.987.238.camel@d845pe>
 <20041120124001.GA2829@stusta.de>  <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
  <1101151780.20006.69.camel@d845pe>  <Pine.LNX.4.58.0411221137200.20993@ppc970.osdl.org>
 <1101155893.20007.125.camel@d845pe> <Pine.LNX.4.58.0411221815460.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Linus Torvalds wrote:
> 
> So what's the right way to get ELCR into a useful state? I'm starting to
> lean towards your "just clear it all" after all, but that does the wrong
> thing for SCI (which is _usually_ level-triggered), and I worry that there
> are other cases too.
> 
> Any reasonably simple patch that likely gets it right?

Len, how about this patch - it re-enables the link disable and then
re-codes the ELCR setting to match.

Basically it just computes the new ELCR: if acpi_noirq is set, it leaves
it at the old value, otherwise it zeroes it - and in both cases it fixes
the SCI entry.

Your argument for doing this ended up being convincing, so the only
difference between this and your debug patch is really just the obvious
organizational ones, and the test for "acpi_noirq", which I think is
needed (since if acpi_noirq is set, we're not going to disable and
re-enable the PCI interrupts, so we'll just have to trust ELCR).

		Linus

----
===== arch/i386/kernel/acpi/boot.c 1.75 vs edited =====
--- 1.75/arch/i386/kernel/acpi/boot.c	2004-11-11 16:08:40 -08:00
+++ edited/arch/i386/kernel/acpi/boot.c	2004-11-22 20:55:57 -08:00
@@ -409,28 +409,38 @@
 void __init
 acpi_pic_sci_set_trigger(unsigned int irq, u16 trigger)
 {
-	unsigned char mask = 1 << (irq & 7);
-	unsigned int port = 0x4d0 + (irq >> 3);
-	unsigned char val = inb(port);
+	unsigned int mask = 1 << irq;
+	unsigned int old, new;
 
-	
-	printk(PREFIX "IRQ%d SCI:", irq);
-	if (!(val & mask)) {
-		printk(" Edge");
+	/* Real old ELCR mask */
+	old = inb(0x4d0) | (inb(0x4d1) << 8);
 
-		if (trigger == 3) {
-			printk(" set to Level");
-			outb(val | mask, port);
-		}
-	} else {
-		printk(" Level");
+	/*
+	 * If we use ACPI to set PCI irq's, then we should clear ELCR
+	 * since we will set it correctly as we enable the PCI irq
+	 * routing.
+	 */
+	new = acpi_noirq ? old : 0;
 
-		if (trigger == 1) {
-			printk(" set to Edge");
-			outb(val & ~mask, port);
-		}
+	/*
+	 * Update SCI information in the ELCR, it isn't in the PCI
+	 * routing tables..
+	 */
+	switch (trigger) {
+	case 1:	/* Edge - clear */
+		new &= ~mask;
+		break;
+	case 3: /* Level - set */
+		new |= mask;
+		break;
 	}
-	printk(" Trigger.\n");
+
+	if (old == new)
+		return;
+
+	printk(PREFIX "setting ELCR to %04x (from %04x)\n", new, old);
+	outb(new, 0x4d0);
+	outb(new >> 8, 0x4d1);
 }
 
 
===== drivers/acpi/pci_link.c 1.35 vs edited =====
--- 1.35/drivers/acpi/pci_link.c	2004-11-22 10:41:11 -08:00
+++ edited/drivers/acpi/pci_link.c	2004-11-22 20:02:53 -08:00
@@ -685,6 +685,9 @@
 	acpi_link.count++;
 
 end:
+	/* disable all links -- to be activated on use */
+	acpi_ut_evaluate_object(link->handle, "_DIS", 0, NULL);
+
 	if (result)
 		kfree(link);
 
