Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbUKWT6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbUKWT6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 14:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbUKWT4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:56:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:37799 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261563AbUKWTyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 14:54:15 -0500
Date: Tue, 23 Nov 2004 11:54:14 -0800
From: Chris Wright <chrisw@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       gene.heskett@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-bk7, back to an irq 12 "nobody cared!"
Message-ID: <20041123115414.O2357@build.pdx.osdl.net>
References: <200411230014.15354.gene.heskett@verizon.net> <20041122233852.43f93aa9.akpm@osdl.org> <Pine.LNX.4.61.0411231212140.7167@musoma.fsmlabs.com> <20041123113957.D14339@build.pdx.osdl.net> <Pine.LNX.4.61.0411231248370.7167@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0411231248370.7167@musoma.fsmlabs.com>; from zwane@linuxpower.ca on Tue, Nov 23, 2004 at 12:48:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zwane Mwaikambo (zwane@linuxpower.ca) wrote:
> On Tue, 23 Nov 2004, Chris Wright wrote:
> 
> > * Zwane Mwaikambo (zwane@linuxpower.ca) wrote:
> > > On Mon, 22 Nov 2004, Andrew Morton wrote:
> > > 
> > > > Gene Heskett <gene.heskett@verizon.net> wrote:
> > > > >
> > > > > Just built bk7 after running the bk4-kjt1 version for a cpouple of 
> > > > >  days, and noticed this in /var/log/dmesg:
> > 
> > Try current, should be fixed.
> 
> Know which changeset fixed it?

The last two (currently numbered 1.2219,12220).


# ChangeSet
#   2004/11/22 21:02:49-08:00 torvalds@evo.osdl.org 
#   acpi: disable PCI links at boot again, fix ELCR
#   
#   Len Brown convinced me that the problem with disabling
#   PCI routing entries wasn't the disable as much as the
#   fact that ELCR needs to be updated when removing the PCI
#   routing. So this reverts the previous cset and updates
#   ELCR as suggested by Len.
# 
# drivers/acpi/pci_link.c
#   2004/11/22 21:02:39-08:00 torvalds@evo.osdl.org +3 -0
#   acpi: disable PCI links at boot again, fix ELCR
#   
#   Len Brown convinced me that the problem with disabling
#   PCI routing entries wasn't the disable as much as the
#   fact that ELCR needs to be updated when removing the PCI
#   routing. So this reverts the previous cset and updates
#   ELCR as suggested by Len.
# 
# arch/i386/kernel/acpi/boot.c
#   2004/11/22 21:02:39-08:00 torvalds@evo.osdl.org +28 -18
#   acpi: disable PCI links at boot again, fix ELCR
#   
#   Len Brown convinced me that the problem with disabling
#   PCI routing entries wasn't the disable as much as the
#   fact that ELCR needs to be updated when removing the PCI
#   routing. So this reverts the previous cset and updates
#   ELCR as suggested by Len.
# 
# ChangeSet
#   2004/11/22 10:41:17-08:00 torvalds@ppc970.osdl.org 
#   acpi: don't disable PCI irq links that were active at boot.
#   
#   This fixes at least some interrupt polarity setup cases.
#   The ACPI guys may want to eventually do this differently, but
#   in the meantime this makes ACPI behaviour closer to non-ACPI
#   behaviour, and fixes known problems.
#   
#   I'll further argue that this protects non-PCI devices that may
#   just share the irq routing from being screwed, but that may or
#   may not be an argument that everybody buys into.
# 
# drivers/acpi/pci_link.c
#   2004/11/22 10:41:11-08:00 torvalds@ppc970.osdl.org +0 -3
#   acpi: don't disable PCI irq links that were active at boot.
#   
#   This fixes at least some interrupt polarity setup cases.
#   The ACPI guys may want to eventually do this differently, but
#   in the meantime this makes ACPI behaviour closer to non-ACPI
#   behaviour, and fixes known problems.
#   
#   I'll further argue that this protects non-PCI devices that may
#   just share the irq routing from being screwed, but that may or
#   may not be an argument that everybody buys into.
# 
diff -Nru a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c	2004-11-23 11:53:08 -08:00
+++ b/arch/i386/kernel/acpi/boot.c	2004-11-23 11:53:08 -08:00
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
 
 
