Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUIUOrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUIUOrW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 10:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267721AbUIUOrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 10:47:22 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:44454 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267720AbUIUOrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 10:47:14 -0400
Subject: Re: Boot failure with 2.6.9-rc2-bk latest in usb/hid-core.c
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921081047.GA10757@ucw.cz>
References: <1095610092.10887.16.camel@mulgrave> 
	<20040921081047.GA10757@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 21 Sep 2004 10:47:02 -0400
Message-Id: <1095778029.2467.45.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 04:10, Vojtech Pavlik wrote:
> There were changes in the function that prints the above message,
> however they were indentation only. I really doubt it could be the HID
> changes I did.

Well, I verified that it works before this merge

torvalds@ppc970.osdl.org|ChangeSet|20040916140404|15905

and doesn't with it (this was Linus pulling in your input tree).

> It looks like there is either a problem with ACPI IRQ routing that when
> enabling the EHCI controller IRQ does something bad to the OHCI
> controllers, or the EHCI driver itself does something bad to the OHCI
> controllers. (Afte all, the controllers share their ports.)
> 
> Try disabling EHCI in your config to confirm my theory.

Yes, disabling EHCI in the config allows boot.

This is what lspci says about the USB controller:

0000:a0:01.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10
[OHCI])
        Subsystem: NEC Corporation USB
        Flags: bus master, medium devsel, latency 128, IRQ 57
        Memory at 00000000d0022000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2

0000:a0:01.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10
[OHCI])
        Subsystem: NEC Corporation USB
        Flags: bus master, medium devsel, latency 128, IRQ 58
        Memory at 00000000d0021000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2

0000:a0:01.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if
20 [EHCI])
        Subsystem: NEC Corporation USB 2.0
        Flags: bus master, medium devsel, latency 128, IRQ 59
        Memory at 00000000d0020000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2

So it looks like ACPI is routing the IRQ's corectly.  Just to confirm,
here's the ACPI routing probe from boot:

ACPI: PCI interrupt 0000:a0:01.0[A] -> GSI 38 (level, low) -> IRQ 57
GSI 39 (level, low) -> CPU 0 (0x0000) vector 58
ACPI: PCI interrupt 0000:a0:01.1[B] -> GSI 39 (level, low) -> IRQ 58
GSI 40 (level, low) -> CPU 0 (0x0000) vector 59
ACPI: PCI interrupt 0000:a0:01.2[C] -> GSI 40 (level, low) -> IRQ 59

Anything else you need?

James


