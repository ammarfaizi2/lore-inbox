Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWARAz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWARAz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWARAyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:54:47 -0500
Received: from fmr17.intel.com ([134.134.136.16]:33176 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932469AbWARAyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:54:43 -0500
Subject: [patch 0/4]  Hot Dock/Undock support
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org, pavel@ucw.cz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 16:56:53 -0800
Message-Id: <1137545813.19858.45.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 18 Jan 2006 00:54:02.0078 (UTC) FILETIME=[AC5CD7E0:01C61BC9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches is against the -mm kernel, and will enable
docking station support.  It is an early patch, but still pretty 
functional, so I think it's worthwhile to include at this point.
For some laptops, it's necessary to use the pci=assign-busses kernel 
parameter, because some _DCK methods will attempt to assign bus numbers
to the dock bridge (incorrectly).

Supported Features:
* Hot Dock/Undock via hardware control
* Enumeration of PCI Devices on Dock Station (Hot Add/Remove) via pci 

Not Supported Yet (but will be with laptops with sane dsdts):
* _EJD, _EDL support for devices that aren't enumerable
* hot add of devices other than PCI devices (such as the serial/lpt etc).
* More thorough testing needs to be done for everything, but especially
  video, as I've not even begun to worry about that.

All docking events are handled by the acpiphp driver.  For docking,
the acpiphp driver will call the _DCK acpi method, and then insert
the docking bridge and all the pci devices behind the dock bridge.
This is in conflict with some acpi platform drivers (ibm_acpi) that already
attempt to implement a limited form of docking support only for that platform.
You may not use both drivers at the same time right now.  This is a generic
docking solution that should work for all docking stations, not just IBM,
although I tested it on an IBM docking station exclusively, because that's
all I've got right now. 

Right now devices that are not on enumerable buses (or on the PCI bus at all) 
will not be discovered by acpiphp.  Your mileage will vary on any devices 
other than PCI.  This is because in many cases, there are extra hardware 
configuration steps that need to occur after the _DCK method (because they 
really should have been done in the _DCK method but were not).  Even with PCI 
devices, you may find that some things don't work properly, because there 
was some extra configuration step that needed to occur that didn't get done 
as part of _DCK.  For example, included in this patch series is a quirk for the
IBM Dock Station II, which seemed to need the cardbus controller interrupts
tied together, but this didn't get done with any of the laptops I tested
with.  I've not yet been able to determine what needs to be done to the 
USB controller on the T30 or T41 to make it discover the USB hub on the
docking station, although this works fine on the T20, and also I hear on
the T42, although I've not tested the T42 myself.  

You may also find that as soon as you call _DCK, everything is
broken.  For example, on the T30 laptop I tested, the _DCK method would set
the dock bridge's parent secondary bus number to zero, even if it should
have been something other than zero.  This specific case is handled in
the acpiphp driver in the post_dock_fixups() routine, but this may need to
be changed for the future if it starts to get out of hand. 

There is a workaround right now in this patch for a problem with acpi, where
the acpi thread that notifies acpiphp of the dock event will deadlock while
executing the _DCK method.  I've managed to avoid trying to solve this 
problem for now by spawning a separate thread to handle the _DCK, but 
eventually this will be addressed when I'm brave enough. 

Please comment on these patches, and test if you have a docking station
available.  When you find problems, if you would like me to debug them,
please load the acpiphp driver with the debug param (modprobe acpiphp debug=1),
and send me the output of dmesg -s 100000 as well as lspci -vv -x -n with
the laptop booted in the station, and then the output after booting out
of the station and attempting to dock, as well as a copy of your disassembled
dsdt.  Make sure you have PCI debugging enabled, and debugging enabled for
whatever device you are having issues with.  This should be a good starting 
point.

Kristen
