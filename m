Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWBMTQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWBMTQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 14:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWBMTQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 14:16:55 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:33391 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964810AbWBMTQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 14:16:53 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
Date: Mon, 13 Feb 2006 11:16:41 -0800
User-Agent: KMail/1.7.1
Cc: psusi@cfl.rr.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131116.41964.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think "simpler" isn't the issue; "swsusp" is a kind of checkpoint
even in its ACPI versions, while standby/str modes are substantially
different beasts.

True standby/suspend modes are classic "power management" things:
part of the system stay in low power modes (not necessarily "off")
to reduce power consumption, while other parts are in active use.
The more deeply they're suspended, the less the system looks like
"idle" and the more it looks like "suspend-to-ram".


Phillip Susi wrote:
> 	Thus when suspended to ram, 
> typically your usb hard drive and almost allways your ide/sata/scsi 
> drive will be completely powered off. 

What ide drive?  Oh, you're talking about PC-ish systems, not
embedded ones that don't _have_ rotating media to power off.

Your experience is very different from mine; I've observed that
most PC hardware keeps USB powered in suspend-to-ram states, so
a keyboard or mouse action may wake the system up, just as it can
with many PS2 style keyboards and mice.  Same thing for Ethernet,
using various types of wakeup event including "magic packet".
See /proc/acpi/wakeup, and the related parts of the ACPI specs.
(And USB specs, and lots more ... this info is widespread.)

At the PCI hardware level, that basically means staying in
what's called a D3hot state:  controller maintains power, and
might be a wakeup event source.  If you read the EHCI spec
you'll notice careful specification of how to maintain USB
connections by providing only minimal VBUS current using the
Vaux supply ... not all boards go that extra distance for
power savings, maintaining USB state (and allowing wakeup)
using a lower power D3cold state (with ACPI S3) not D3hot.

(And there's gobs of "legacy" PCI PM hardware still being
manufactured, using out-of-band signaling rather than the
standardized PCI PM stuff.  For that, see the relevant USB
controller specs ... e.g. OHCI, Intel UHCI, VIA UHCI.)

For non-PCI hardware, that's actually a system option.  Most
systems have many low power modes, including ones where it'd
make sense to support wakeup from USB and ones where it would
not; external transceivers seem to give the most flexibility.

You should also remember a useful point from the ACPI spec:
if you're taking the system apart with a screwdriver, then
you've gone out-of-spec.  So swapping IDE drives is strongly
in the "user error" category ... unlike swapping USB drives,
which is equally strongly in the "normal operation" category.
(So it would be an error if Linux didn't properly detect when
users unplug all usb devices after putting their laptops into
STR and before carrying them someplace else...)


> Then your motherboard keeps the bus in a lower power state such that it 
> is capable of causing a wake event when state changes.  I'm also fairly 
> sure that when such a wake event happens, there is no indication to the 
> kernel about why it was woken up. 

Read about the #PME signal status in the PCI PM capabilities.

And the USB remote wakeup reporting done by USB hubs; you can
even look at the drivers/usb/core/hub.c code and see how usb
wakeup events (of various types) are handled.

You don't seem to know what you're talking about here.


> 	 As I said before, once woken up, 
> the kernel must probe all hardware and if there is a new device, it will 
> find it.  The hardware only detected that something changed and thus, 
> generated a wake even, it did not notice exactly what that change was 
> and inform the kernel. 

You were wrong then too... both about probing "all hardware" and about not
being able to distinguish wakeup event sources.  

- Dave
