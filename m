Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265198AbUGQReT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbUGQReT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 13:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUGQReS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 13:34:18 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:56516 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S265198AbUGQReQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 13:34:16 -0400
Message-ID: <40F962B6.3000501@pacbell.net>
Date: Sat, 17 Jul 2004 10:32:38 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Alexander Gran <alex@zodiac.dnsalias.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: fixing usb suspend/resuming
References: <200405281406.10447@zodiac.zodiac.dnsalias.org> <40B74FC2.8000708@pacbell.net> <200406011614.32726@zodiac.zodiac.dnsalias.org>
In-Reply-To: <200406011614.32726@zodiac.zodiac.dnsalias.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Somehow batch of mail to me got delayed, and yours was in it.
So I thought I'd follow up on this, since I've noticed the
same thing in other contexts:


Alexander Gran wrote:
> When I want acpi to go to S3 (echo 3 > /proc/acpi/sleep), the driver want's to 
> enter S2, which the device does not support:

I'm not clear on the intended relationship between PCI device state
numbers and ACPI device states in Linux ... but it's clear from the
specs (ACPI ch2, the mostly-generic bit) that ACPI "3" != PCI "3".

   Power Off   == ACPI 3
               == PCI 4 (D3cold)
   Low Power   == ACPI 2
               == PCI 3 (D3hot; or maybe D1 or D2, depending)

And in much the same way "USB Suspend" is an ACPI low power
state (2) ... not an ACPI power off state (3).  And for USB
host controllers, PCI D3hot is expected to support USB suspend.

I'm suspecting that something is mistranslating between ACPI
power state numbering and PCI power state numbering

I'd _certainly_ expect that the numbers passed to PCI suspend
and resume calls would match the PCI state numbers, not the
ACPI numbers!  But those numbers aren't documented in the
Linux sources, so probably different people are making rather
different assumptions.  After all, "3 == 3" and "2 == 2".

That's all different from the ACPI system power states, too.
(Which is what I'd expect /proc/acpi/sleep to affect.)

- Dave


> Stopping tasks: 
> ===================================================================|
> radeonfb: suspending to state: 2...
> agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
> agpgart: Putting AGP V2 device at 0000:00:00.0 into 0x mode
> agpgart: Putting AGP V2 device at 0000:01:00.0 into 0x mode
> ehci_hcd 0000:00:1d.7: suspend D0 --> D2
> ehci_hcd 0000:00:1d.7: PCI suspend fail, -5
> ehci_hcd 0000:00:1d.7: resume from state D0
> 
> This seems to be an acpi problem. I'm no acpi god, and no idea how it works. I 
> found that every call before acpi has state 3, every afterwards has state 2.


