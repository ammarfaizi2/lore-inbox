Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVIYQnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVIYQnc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 12:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVIYQnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 12:43:32 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:57063 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1750738AbVIYQnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 12:43:31 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=j0ZYyeJqOoNGIQLRllujyD4glGN8jDltY1Ac6TUkb1xGdzTz/13799nciq3I67U0Q
	laf7WODA+65h6AMaofNUw==
Date: Sun, 25 Sep 2005 09:43:21 -0700
From: David Brownell <david-b@pacbell.net>
To: thomas.mey3r@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-ge484585e: kexec into same kernel: irq 11 nobody 
 cared; but ehci_hcd should
References: <20050924163149.4d68ad07.akpm@osdl.org>
In-Reply-To: <20050924163149.4d68ad07.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050925164321.ECBDCEE901@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when i kexec into the same kernel i get this error message:
>
> [17179593.108000] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
> [17179593.108000] PCI: setting IRQ 11 as level-triggered
> [17179593.108000] ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 11 (level, low) -> IRQ 11
> [17179593.108000] ehci_hcd 0000:00:10.3: EHCI Host Controller
> [17179593.124000] ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
> [17179593.936000] irq 11: nobody cared (try booting with the "irqpoll" option)
> ...
>
> any ideas? 

This patch (compile-tested only) ought to do it.  Alternatively,
try the "usb-handoff" kernel parameter; it happens that will also
forcibly disable the IRQs.

(And notice how far that "usb-handoff" code has gotten out of sync
with the HCDs ... for EHCI the bug is that only that "pci quirks"
clone of the handoff code disables the IRQs, but for OHCI the bug
is the other way around:  only the HCD disables them.  Bleech.)

- Dave


This tweaks the EHCI reboot notifier to also halt the EHCI controller, and
makes that halt code force IRQs off.  Both should always have been done.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- g26.orig/drivers/usb/host/ehci-hcd.c	2005-09-23 10:40:21.000000000 -0700
+++ g26/drivers/usb/host/ehci-hcd.c	2005-09-25 09:17:01.000000000 -0700
@@ -182,6 +182,9 @@
 {
 	u32	temp = readl (&ehci->regs->status);
 
+	/* disable any irqs left enabled by previous code */
+	writel (0, &ehci->regs->intr_enable);
+
 	if ((temp & STS_HALT) != 0)
 		return 0;
 
@@ -297,12 +300,17 @@
 	spin_unlock_irqrestore (&ehci->lock, flags);
 }
 
+/* Reboot notifiers kick in for silicon on any bus (not just pci, etc).
+ * This forcibly disables dma and IRQs, helping kexec and other cases
+ * where the next system software may expect clean state.
+ */
 static int
 ehci_reboot (struct notifier_block *self, unsigned long code, void *null)
 {
 	struct ehci_hcd		*ehci;
 
 	ehci = container_of (self, struct ehci_hcd, reboot_notifier);
+	(void) ehci_halt (ehci);
 
 	/* make BIOS/etc use companion controller during reboot */
 	writel (0, &ehci->regs->configured_flag);
