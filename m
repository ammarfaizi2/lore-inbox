Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVGZTGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVGZTGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 15:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVGZTD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 15:03:59 -0400
Received: from fmr16.intel.com ([192.55.52.70]:19870 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S262039AbVGZTCp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 15:02:45 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch] properly stop devices before poweroff
Date: Tue, 26 Jul 2005 12:02:00 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03FCF24C@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch] properly stop devices before poweroff
Thread-Index: AcVccIQvS8hDOceaSMaWccy2uICy9Q1nw7GA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Kenji Kaneshige" <kaneshige.kenji@jp.fujitsu.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: "Adam Belay" <ambx1@neo.rr.com>, <greg@kroah.org>, <pavel@ucw.cz>,
       <linux-kernel@vger.kernel.org>, <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2005 19:02:01.0872 (UTC) FILETIME=[8172E900:01C59214]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started on my OLS homework from Andrew ... and began looking
into what is going on here.

The story so far: Pavel added calls to device_suspend() to three of
the cases in the sys_reboot() path.  This stopped ia64 from being
able to shutdown.  There is a oops with a stacktrace pointing back
at the sys_reboot call.

Initial analysis from Kenji Kaneshige said that we might fix this
by adding a patch to the ia64 version of pcibios_disable_device()
to make it check whether the device was enabled before calling
acpi_pci_irq_disable().  This might fix things if the issue was
simply problems with this being called twice.  Pavel sent a
"Looks good", Adam said "Is it the right fix?"

I just tried it ... it doesn't work, we still see an oops from
the sys_reboot() ... so shutdown hangs, and we can sidestep the
issue of whether this is ideologically correct.

Then I wondered whether it was just an e1000 problem (since Pavel
had also commented that we should perhaps removed the reboot notifier
from the e1000 driver).  So I rebuilt my kernel with e1000 as a module
and ran "rmmod e1000" before running shutdown.  Which promptly failed
with a stack trace that ran through mptscsih driver instead of e1000.
[N.B. Kaneshige-san has also noted that his i386 system which has the
mptfusion also hangs executing a SYNCHRONIZE_CACHE command]. 

Code examination in the e1000 case shows that we are a bit confused
and call first:

notifier_call_chain(reboot_notifier, ...)
  e1000_notify_reboot(...)
    e1000_suspend(...)
      pci_disable_device(...)
      pci_set_power_state(...)

and then:

device_suspend(...)
   suspend_device() == dev->bus->suspend == pci_device_suspend
     e1000_suspend()
       pci_disable_device()
       pciset_power_state()

So it looks like Pavel is right ... registering the reboot notifier is
bogus in e1000.  Commenting out the register/unregister also allows
me to get past the e1000 so that I can fail in mptscsih_suspend() path.
But the fusion driver doesn't register a reboot notifier, so I can't
try the same trick there :-)

Andrew: How did you get the squitty font on ia64?  The stack trace
from the oops flies off the top of the screen.  I've tried a few
"vga=0x0f07" type options, but I keep getting a big font.

-Tony
