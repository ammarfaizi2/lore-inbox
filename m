Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVKOBOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVKOBOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVKOBOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:14:08 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:18372 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751304AbVKOBOH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:14:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Tl9QbHm6sQG/NKmx/LkBwOyagjFU1/1lRMW1RLQ7bXZqDsWKXdLuri1/EWMsWjGaCFmrKOK1ptxkSYWhpTUboNEUGfL3ZQOsHpRKqKmeQYx36r1iWT0QSfisUpmZD+VMy3Pr5vv0XhAWg1mLIfQ3yDZlb13oRW4hFnFiH3yc9pQ=
Message-ID: <d4b6d3ea0511141714o2e3e23daqb87f4d0ffa0146df@mail.gmail.com>
Date: Mon, 14 Nov 2005 17:14:06 -0800
From: Michael Madore <michael.madore@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: USB handoff, irq 193: nobody cared!
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting the following errors in my kernel log with 2.6.14:

Nov 14 09:27:06 asl95 kernel: ACPI: PCI Interrupt 0000:00:03.2[A] ->
GSI 10 (level, low) -> IRQ 193
Nov 14 09:27:06 asl95 kernel: ehci_hcd 0000:00:03.2: EHCI Host Controller
Nov 14 09:27:06 asl95 kernel: ehci_hcd 0000:00:03.2: new USB bus
registered, assigned bus number 1
Nov 14 09:27:06 asl95 kernel: ehci_hcd 0000:00:03.2: irq 193, io mem 0xfebfd000
Nov 14 09:27:06 asl95 kernel: ehci_hcd 0000:00:03.2: USB 2.0
initialized, EHCI 1.00, driver 10 Dec 2004
Nov 14 09:27:07 asl95 kernel: hub 1-0:1.0: USB hub found
Nov 14 09:27:07 asl95 kernel: hub 1-0:1.0: 4 ports detected
Nov 14 09:27:07 asl95 kernel: hub 1-0:1.0: over-current change on port 1
Nov 14 09:27:07 asl95 kernel: ACPI: PCI Interrupt 0000:00:03.0[A] ->
GSI 10 (level, low) -> IRQ 193
Nov 14 09:27:07 asl95 kernel: ohci_hcd 0000:00:03.0: OHCI Host Controller
Nov 14 09:27:07 asl95 kernel: ohci_hcd 0000:00:03.0: new USB bus
registered, assigned bus number 2
Nov 14 09:27:07 asl95 kernel: ohci_hcd 0000:00:03.0: irq 193, io mem 0xfebfb000
Nov 14 09:27:07 asl95 kernel: hub 2-0:1.0: USB hub found
Nov 14 09:27:07 asl95 kernel: hub 2-0:1.0: 2 ports detected
Nov 14 09:27:07 asl95 kernel: ACPI: PCI Interrupt 0000:00:03.1[A] ->
GSI 10 (level, low) -> IRQ 193
Nov 14 09:27:08 asl95 kernel: ohci_hcd 0000:00:03.1: OHCI Host Controller
Nov 14 09:27:08 asl95 kernel: irq 193: nobody cared!

I don't see this behavior under kernel 2.6.12.  Running git-bisect, I
narrowed it down to this change:

d49d431744007cec0ee1a3ade96f9e0f100c7907 is first bad commit
diff-tree d49d431744007cec0ee1a3ade96f9e0f100c7907 (from
9198769363d4dc1d63d49ec b2e2b189aceb42d94)
Author: David Brownell <david-b@pacbell.net>
Date:   Sat May 7 13:21:50 2005 -0700

    [PATCH] USB: misc ehci updates

    Various minor EHCI updates

       * Dump some more info in the debug dumps, notably the product
         description (e.g. chip vendor), BIOS handhake flags, and
         debug port status (when it's not managed by the HCD).

       * Minor updates to the BIOS handoff code:  always flag the HCD
         as owned by Linux (in case BIOS doesn't grab it "early"),
         and on the buggy-BIOS path always match the "early handoff"
         code and forcibly disable SMI IRQs.

       * For the disabled 64bit DMA support, there's now a constant
         to use for the mask; use it.

    Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

:040000 040000 e883b4103743cfeb337c5b914affcdcb51adc23f
c55d891960ce2b85c70a9b43 2730c3a4aa70261c M      drivers

Reverting this patch restores the original behavior.  Also, I only see
this error if USB legacy support is _disabled_ in the BIOS.  If I
enable legacy support, then the error goes away.

Mike
