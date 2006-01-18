Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWARSmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWARSmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 13:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWARSmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 13:42:04 -0500
Received: from fmr18.intel.com ([134.134.136.17]:60300 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030261AbWARSmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 13:42:01 -0500
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
In-Reply-To: <20060118130444.GA1518@elf.ucw.cz>
References: <1137545813.19858.45.camel@whizzy>
	 <20060118130444.GA1518@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 10:42:27 -0800
Message-Id: <1137609747.31839.6.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 18 Jan 2006 18:39:33.0222 (UTC) FILETIME=[864B4060:01C61C5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 14:04 +0100, Pavel Machek wrote:
> Hi!
> 
> > This series of patches is against the -mm kernel, and will enable
> > docking station support.  It is an early patch, but still pretty 
> > functional, so I think it's worthwhile to include at this point.
> > For some laptops, it's necessary to use the pci=assign-busses kernel 
> > parameter, because some _DCK methods will attempt to assign bus numbers
> > to the dock bridge (incorrectly).
> 
> On thinkpad X32: I selected
> 
> CONFIG_HOTPLUG_PCI=y
> # CONFIG_HOTPLUG_PCI_FAKE is not set
> # CONFIG_HOTPLUG_PCI_COMPAQ is not set
> # CONFIG_HOTPLUG_PCI_IBM is not set
> CONFIG_HOTPLUG_PCI_ACPI=y
> # CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> # CONFIG_HOTPLUG_PCI_SHPC is not set
> CONFIG_ACPI_IBM=y
> 
> Recompiled, rebooted with machine out of dock. /sys/bus/pci/slots/ is
> empty. I then inserted machine into dock, and locked it:
> 
> root@amd:/sys/bus/pci/slots# echo dock > /proc/acpi/ibm/dock
> root@amd:/sys/bus/pci/slots# ls
> root@amd:/sys/bus/pci/slots#
> 
> ...still empty. What am I doing wrong?
> 								Pavel

You may not use the ibm_acpi driver at the same time as the acpiphp
driver for docking.  This is because the ibm_acpi driver also tries to
handle the dock event notification, and doesn't actually do any
hotplugging of the devices.  So, you want to set that config option to
N.  What you are doing above is actually writing to the ibm_acpi driver.
I didn't provide a way to do undocking via software. I just use the
button on the dock station.  You should however, see something
in /sys/bus/pci/slots - can you scan your dmesg to make sure that the
acpiphp driver is running?  You might run it as a module and enable
debugging:

modprobe acpiphp debug=1

This way we can see if it finds your dock slot and registers the notify
handler.

Thanks for testing!

Kristen

