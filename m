Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbULFOeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbULFOeL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 09:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbULFOeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 09:34:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:51658 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261533AbULFOcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 09:32:05 -0500
Subject: Re: [<02282da7>] (usb_hcd_irq+0x0/0x4b) Disabling IRQ #5 - USB
	Devices do not work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: florian <florian_kr@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1102333735.5095.4.camel@orange-bud>
References: <1102333735.5095.4.camel@orange-bud>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102339694.13485.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Dec 2004 13:28:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-06 at 11:48, florian wrote:
> How can I enable "USB Legacy Support" without errors?
> How can I resolve the problem with the USB devices?

What chipset is the motherboard ?

> I've found via google some BIOS Bugs for "USB Legacy Support", but this
> bug occurs only on Windows XP (I don't found this for Linux). I tried
> allready to update my BIOS and now USB is disabled for all devices
> (Mouse, Printer, Scanner, USB-FlashMemory)

Windows XP and Linux may well hit the same problems with USB.

> irq 5: nobody cared! (screaming interrupt?)
> irq 5: Please try booting with acpi=off and report a bug
> Stack pointer is garbage, not printing trace
> handlers:
> [<02282da7>] (usb_hcd_irq+0x0/0x4b)
> Disabling IRQ #5

The latest FC3 kernel should have new enough -ac patches to run on boxes
with
totally broken BIOS IRQ routing. Try the boot option "irqpoll"

> ehci_hcd 0000:00:13.2: EHCI Host Controller
> ehci_hcd 0000:00:13.2: BIOS handoff failed (160, 1010001)
> ehci_hcd 0000:00:13.2: continuing after BIOS bug...
> irq 5: nobody cared! (screaming interrupt?)
> irq 5: Please try booting with acpi=off and report a bug
> Stack pointer is garbage, not printing trace

This is all interesting seen as one. It implies the BIOS handover failed
and
then we get an IRQ mess. 

> ehci_hcd 0000:00:13.2: EHCI Host Controller
> ehci_hcd 0000:00:13.2: BIOS handoff failed (160, 1010001)
> ehci_hcd 0000:00:13.2: continuing after BIOS bug...
> irq 5: nobody cared! (screaming interrupt?)
> irq 5: Please try booting with acpi=off and report a bug
> Stack pointer is garbage, not printing trace

Ditto, and this is quite possibly the root cause. That suggests the BIOS
handover code for EHCI is insufficient for some cases (and it appears to
be looking at the code quickly - it should register IRQ 5 before doing a
handover which it does but it probably needs to just ack and mask IRQ 5
during the handover. It could be another device breaking IRQ5 however)


What occurs if you build a kernel with EHCI disabled, ditto what occurs
if you boot with init=/bin/sh and then load ohci before ehci ?


