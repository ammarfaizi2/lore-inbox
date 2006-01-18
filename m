Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWARVjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWARVjq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWARVjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:39:46 -0500
Received: from fmr19.intel.com ([134.134.136.18]:64452 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S964941AbWARVjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:39:45 -0500
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
In-Reply-To: <20060118194554.GA1502@elf.ucw.cz>
References: <1137545813.19858.45.camel@whizzy>
	 <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy>
	 <20060118194554.GA1502@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 13:06:09 -0800
Message-Id: <1137618370.31839.12.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 18 Jan 2006 21:03:15.0484 (UTC) FILETIME=[999005C0:01C61C72]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 20:45 +0100, Pavel Machek wrote:
> Hi!
> 
> > > > This series of patches is against the -mm kernel, and will enable
> > > > docking station support.  It is an early patch, but still pretty 
> > > > functional, so I think it's worthwhile to include at this point.
> > > > For some laptops, it's necessary to use the pci=assign-busses kernel 
> > > > parameter, because some _DCK methods will attempt to assign bus numbers
> > > > to the dock bridge (incorrectly).
> > > 
> > > On thinkpad X32: I selected
> ...
> > > Recompiled, rebooted with machine out of dock. /sys/bus/pci/slots/ is
> > > empty. I then inserted machine into dock, and locked it:
> > > 
> > > root@amd:/sys/bus/pci/slots# echo dock > /proc/acpi/ibm/dock
> > > root@amd:/sys/bus/pci/slots# ls
> > > root@amd:/sys/bus/pci/slots#
> > > 
> > > ...still empty. What am I doing wrong?
> > 
> > You may not use the ibm_acpi driver at the same time as the acpiphp
> > driver for docking.  This is because the ibm_acpi driver also tries to
> > handle the dock event notification, and doesn't actually do any
> > hotplugging of the devices.  So, you want to set that config option to
> > N.  What you are doing above is actually writing to the ibm_acpi
> > driver.
> 
> Done.
> 
> > I didn't provide a way to do undocking via software. I just use the
> > button on the dock station.  You should however, see something
> > in /sys/bus/pci/slots - can you scan your dmesg to make sure that the
> > acpiphp driver is running?  You might run it as a module and enable
> > debugging:
> > 
> > modprobe acpiphp debug=1
> > 
> > This way we can see if it finds your dock slot and registers the notify
> > handler.
> 
> Result is:
> 
> root@amd:/data/l/linux-mm/drivers/pci/hotplug# insmod acpiphp.ko debug=1
> insmod: error inserting 'acpiphp.ko': -1 No such device
> root@amd:/data/l/linux-mm/drivers/pci/hotplug# dmesg | tail -3
> Failure of coda_cnode_make for root: error -19
> acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> acpiphp_glue: Total 0 slots
> root@amd:/data/l/linux-mm/drivers/pci/hotplug#
> 
> Should I have CONFIG_HOTPLUG_PCI_ACPI_IBM set?
> 
> 								Pavel
> 


Hum, I don't think so (but maybe someone else knows for sure), I thought
that driver was specifically for a certain kind of IBM server, not an
IBM laptop.  It looks like from this output that the acpiphp is not
recognizing any hotplug capable devices on your laptop.  I believe that
this is defined by acpiphp as a slot which is "ejectable", meaning
contains an ACPI method called _EJ0.  I think we should take a look at
your dsdt to make sure that it seems reasonable, and also perhaps you
could send the output of lspci -vv -x with the laptop booted in the dock
just to see what kind of dock bridge you have and make sure everything
seems like it should work.  Please send the disassembled output of your
dsdt - if you've never done it before, instructions for doing this can
be found here: 
http://acpi.sourceforge.net/dsdt/index.php

thanks!
Kristen

