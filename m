Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVCHA0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVCHA0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 19:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVCHAX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 19:23:57 -0500
Received: from peabody.ximian.com ([130.57.169.10]:12182 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261301AbVCHAWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 19:22:24 -0500
Subject: Re: [RFC][PATCH] PCI bridge driver rewrite (rev 02)
From: Adam Belay <abelay@novell.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, len.brown@intel.com
In-Reply-To: <9e47339105030715034a8f8ff9@mail.gmail.com>
References: <1110234742.2456.37.camel@localhost.localdomain>
	 <9e47339105030715034a8f8ff9@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 07 Mar 2005 19:20:05 -0500
Message-Id: <1110241206.12485.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-07 at 18:03 -0500, Jon Smirl wrote:
> What about a bridge driver for ISA LPC bridges? That would also
> provide a logical place to hang serial ports, floppy, parallel port,
> ps2 port, etc. Things in /sys/bus/platform are really attached to the
> LPC bridge.
> 

I agree that /sys/bus/platform isn't really the right place.  It doesn't
show the correct parent device, among other issues.  I've done some work
on this issue in the past, and it turns out to be a very complicated
problem.

Basically there are many protocols that feed into the pool of devices
known as *legacy hardware*.  The include the following:

1.) ACPI
      * provides resource information
      * provides identification information
      * the only protocol that accurately describes topology
      * often provides power management features
      * sometimes a few device specific methods (e.g. floppy drives)
2.) PnPBIOS
      * outdated by ACPI, generally useful for x86 boxes before 2000
      * provides resource information
      * provides identification information, and a class code not found
        in ACPI
      * all devices reported are considered root devices, no sense of
        true topology
      * In theory could handle some hotplugging of these devices (e.g.
        docking stations)
3.) ISAPnP
      * Even more outdated.
      * Provides resource information.
      * provides identification, including a card id not found in
        PnPBIOS or ACPI (obviously).
      * Only used for ISA expansion cards
4.) SuperIO drivers
      * In theory it is possible to determine configuration information
        from the SuperIO directly.
      * Some, but very limited, work has been done in this area.
      * ACPI generally handles this because there is little
        standardization at this level.
5.) Legacy Probing
      * Driver attempts to find the hardware directly by reading various
        ports.
      * Can be dangerous.
      * Drivers of this type encourage vendors to include legacy
        compatibility (which in the long run holds us back).
      * Very difficult to integrate with the driver model.
6.) Open Firmware
      * I don't know much about it, but I believe it does do similar
        things to ACPI.
      * Hopefully it uses EISA ids, but not really sure.  If not, it
        wouldn't be included.

So basically we have to handle all (or most) of these.  The question
becomes should driver developers have to write code for all 6 of these
interfaces (which seems a little overwhelming), or should they share a
common layer.  If so, the driver model would need a way to represent
this.  One idea I had was to make "buses" a special type of "class".
And then allow classes to be layered.  So it would look something like
ISA/LPC	->ACPI
	->PnPBIOS
	->ISAPnP
	->SuperIO
	->legacy
	->Open Firmware

Where each of the 6 classes inherit characteristics from "ISA/LPC".

A driver could then choose to bind to the more general "ISA/LPC"
interfaces, or if necessary a more specific interface like "ACPI".
"ISA/LPC" would be sort of a least common denominator.

Of course this would require big changes to the driver model, so it
would have to be really worth it.  I look forward to any comments or
suggestions for alternative approaches.

Thanks,
Adam


