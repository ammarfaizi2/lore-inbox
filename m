Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274858AbTGaRO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 13:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274822AbTGaRNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 13:13:18 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:18845 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S274825AbTGaRM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 13:12:56 -0400
Message-ID: <3F294E9B.4020102@pacbell.net>
Date: Thu, 31 Jul 2003 10:15:07 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: "Trever L. Adams" <tadams-lists@myrealbox.com>
CC: Greg KH <greg@kroah.com>, arjanv@redhat.com,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [More Info] Re: 2.6.0test 1 fails on eth0 up (arjanv RPM's -
 all needed rpms installed)
References: <1058196612.3353.2.camel@aurora.localdomain>	 <3F12FF53.7060708@pobox.com> <1058210139.5981.6.camel@laptop.fenrus.com>	 <1058217601.4441.1.camel@aurora.localdomain>	 <1058299838.3358.4.camel@aurora.localdomain>	 <20030715210240.GA5345@kroah.com>  <3F21C5FA.5020507@pacbell.net> <1059633777.4720.7.camel@aurora.localdomain>
In-Reply-To: <1059633777.4720.7.camel@aurora.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trever L. Adams wrote:
> On Fri, 2003-07-25 at 20:06, David Brownell wrote:
> 
> 
>>See if this patch resolves it.
>>
>>The patch adds an explicit reset to HCD initialization, and then makes
>>EHCI use it.  (OHCI could do so even more easily ... but nobody's reported
>>firmware acting that type of strange with OHCI.)   It should prevent IRQs
>>being enabled while the HC is still in an indeterminate state.
>>
>>This also fixes a missing local_irq_restore() that was generating some
>>annoying might_sleep() messages, and a missing readb() that affects some
>>ARM (and other) PCI systems.
>>
>>- Dave
> 
> 
> Applied it against test2.  I think the problem is indeed ACPI handling
> PCI irqs.  This is an nVidia nForce2 board, I should check to see if the
> patch someone posted fixes this (Did it get folded into test2?).

I think it got posted after test2 finalized; and the patches I
saw were line-wrapped so I couldn't even read them.


> Anyway, the first oops only happens if I have the mouse plugged in as
> USB (Intellimouse USB... I usually use the dumb little PS/2 adapter). 
> The second happens now, but didn't before.  It is 1394 related. 
> Interrupts are at 100k+ on both usb and 1394 ohci almost instantly with
> ACPI on.

That's the symptom I saw when I tried ACPI + NForce2 (by accident)
a while back ... except that in your case it happens for IRQs
below 16 (which might be just an accident).  "pci=noacpi" was a
workaround.

If this appears with that patch of mine applied, then I'd certainly
agree with you that this is something other than a USB problem.

- Dave


> irq 11: nobody cared!
> Call Trace:
> [<c010c12a>] __report_bad_irq+0x2a/0x90
> [<c010c21c>] note_interrupt+0x6c/0xb0
> ...
> [<c010a839>] sysenter_past_esp+0x52/0x71
> 
> handlers:
> [<e087f350>] (usb_hcd_irq+0x0/0x60 [usbcore])
> Disabling IRQ #11
> ehci_hcd 0000:00:02.2: irq 11, pci mem e0815000
> ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
> 
> 
> irq 4: nobody cared!
> Call Trace:
> [<c010c12a>] __report_bad_irq+0x2a/0x90
> [<c010c21c>] note_interrupt+0x6c/0xb0
> ...
> [<c010a839>] sysenter_past_esp+0x52/0x71
> 
> handlers:
> [<e08536d0>] (ohci_irq_handler+0x0/0x720 [ohci1394])
> Disabling IRQ #4
> 
> Anyway, so either it is ACPI and fixable, or I just forget pci routing
> with ACPI.
> 
> Trever Adams

