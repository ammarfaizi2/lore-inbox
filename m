Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbWCGSRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbWCGSRm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWCGSRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:17:41 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:54028 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751441AbWCGSRl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:17:41 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <200603071051.35791.bjorn.helgaas@hp.com>
x-originalarrivaltime: 07 Mar 2006 18:17:20.0798 (UTC) FILETIME=[5FEF7BE0:01C64213]
Content-class: urn:content-classes:message
Subject: Re: de2104x: interrupts before interrupt handler is registered
Date: Tue, 7 Mar 2006 13:17:20 -0500
Message-ID: <Pine.LNX.4.61.0603071306070.9728@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: de2104x: interrupts before interrupt handler is registered
Thread-Index: AcZCE1/5j54Ajq6OQD+915rECH2SHw==
References: <5N5Ql-30C-11@gated-at.bofh.it> <440D918D.2000502@shaw.ca> <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com> <200603071051.35791.bjorn.helgaas@hp.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: "Robert Hancock" <hancockr@shaw.ca>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 7 Mar 2006, Bjorn Helgaas wrote:

> On Tuesday 07 March 2006 07:21, linux-os (Dick Johnson) wrote:
>> Thinking that a device powers ON in a stable state is naive. Many
>> complex devices will have FPGA devices with floating pins that don't
>> become stable until their contents are loaded serially. Others will
>> have IRQ requests based upon power-on states that need to be cleared
>> with a software reset. One can't issue a software reset until the
>> device is enabled and enabling the device may generate interrupts
>> with no handler in place so you have a "can't get there from here"
>> problem.
>
> Maybe you could handle this with a PCI quirk that runs before
> pci_enable_device().  IIRC, we considered exposing a separate
> interface for PCI IRQ allocation and routing, but decided it
> wasn't worth the complexity since so few devices would need it.
>

The problem is that I can't write device internal registers to
put the device into a stable state without enabling the device.
So, the "fix" (read hack) was to mask off all possible interrupts
in the ioapic, call pci_enable_device(), initialize the device,
clear any pending hardware interrupts on the device, then reenable
the ioapic interrupts. I couldn't just use a spin-lock because
somebody complains and the machine panics.

>> Linux-2.4.x had IRQs that were stable. One could put
>> a handler in place that would handle the possible burst of interrupts
>> upon startup. Then this was changed so the IRQ value is wrong
>> until an unrelated and illogical event occurs.
>
> There are good reasons to wait to allocate the IRQ until you have
> a driver that cares about the device.  I'm sorry that this broke
> your specific case.
>
> Bjorn

There are now other "standard" boards that seem to be experiencing
the same problem. Maybe it is time to make a procedure that turns
off interrupts for a specific device (not an unknown IRQ). Then
a subsequent call turns them on after the handler is in place.
This wouldn't affect current drivers. They would still turn on
hot by default.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.50 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
