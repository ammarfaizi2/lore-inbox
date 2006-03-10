Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWCJAwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWCJAwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWCJAwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:52:25 -0500
Received: from 66.239.25.20.ptr.us.xo.net ([66.239.25.20]:52145 "EHLO
	zoot.lnxi.com") by vger.kernel.org with ESMTP id S932376AbWCJAwX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:52:23 -0500
Message-Id: <441069940200003600001450@zoot.lnxi.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Thu, 09 Mar 2006 17:44:52 -0700
From: "Doug Thompson" <dthompson@lnxi.com>
To: <greg@kroah.com>
Cc: <arjan@infradead.org>, <gregkh@kroah.com>,
       <bluesmoke-devel@lists.sourceforge.net>, <dsp@llnl.gov>,
       "Doug Thompson" <dthompson@lnxi.com>, <torvalds@osdl.org>,
       <alan@redhat.com>, <linux-kernel@vger.kernel.org>,
       <rdunlap@xenotime.net>
Subject: Re: [PATCH] EDAC: core EDAC support code
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 00:02 +0000, Greg KH  wrote:
> On Thu, Mar 09, 2006 at 03:51:25PM -0800, Dave Peterson wrote:
> > On Tuesday 07 March 2006 11:03, Arjan van de Ven wrote:
> > > afaics it is a list of pci devices. these should just be symlinks to the
> > > sysfs resource of these pci devices instead, not a flat table file.
> > 
> > Ok, I'm looking at the EDAC sysfs interface.  I see the following
> > issues concerning the "one value per file" rule:
> > 
> >     1.  /sys/devices/system/edac/mc/mc0/module_name contains two
> >         values, a module name and a version:
> > 
> >             # cat /sys/devices/system/edac/mc/mc0/module_name
> >             k8_edac  Ver: 2.0.1.devel Mar  8 2006
> 
> Woah.  That's what /sys/modules/ is for right?  Don't add new stuff
> please.
>
> >     2.  /sys/devices/system/edac/mc/mc0/supported_mem_type contains
> >         the following on the machine I am looking at:
> > 
> >             # cat /sys/devices/system/edac/mc/mc0/supported_mem_type
> >             Unbuffered-DDR Registered-DDR
> >             #
> > 
> >         Here we have a whitespace-delimited list of values.  Likewise,
> >         the following files contain whitespace-delimited lists:
> > 
> >             /sys/devices/system/edac/mc/mc0/edac_capability
> >             /sys/devices/system/edac/mc/mc0/edac_current_capability
> 
> What exactly do they look like?

Unbuffered-DDR Registered-DDR

These come from the memory controller on what types of memory are
possible (or capable), NOT actuals. Its a domain of multiple types.

> 
> >     3.  The following files contain comma-delimited lists of
> >         (vendor ID, device ID) tuples:
> > 
> >             /sys/devices/system/edac/pci/pci_parity_blacklist
> >             /sys/devices/system/edac/pci/pci_parity_whitelist
> 
> What exactly do they look like?

Example:

1022:7450,1434:16a6

is a list of 2 devices that should be skipped. Retrieved via a lspci.

PCI vendor-ID:device-ID series list. One or more devices are possible

The number of devices depends on how many devices should be skipped on a
given server. 

Somehow the system admin needs to tell edac/pci to skip one or more
devices in the PCI device list. As the iterator proceeds through the PCI
device list, it compares each to a blacklist (or whitelist if on - only
one or the other can be one) entry. If found it skipsits. I toyed with
the idea of each PCI device having a control file and the admin setting
a scan/no-scan state, but quickly dropped that.

If a device is blacklisted, it is non-conforming to the PCI Parity
standard of operation and its status cannot be trusted. PCI-X Infiniband
card is such a card, though they have promised a firmware update.

> 
> >         I assume this is what Arjan is referring to.
> >         Documentation/drivers/edac/edac.txt gives the following
> >         description of how the whitelist functions:
> > 
> >             This control file allows for an explicit list of PCI
> >             devices to be scanned for parity errors. Only devices
> >             found on this list will be examined.  The list is a line
> >             of hexadecimel VENDOR and DEVICE ID tuples:
> > 
> >             1022:7450,1434:16a6
> > 
> >             One or more can be inserted, seperated by a comma.
> >             To write the above list doing the following as one
> >             command line:
> > 
> >             echo "1022:7450,1434:16a6"
> >                     > /sys/devices/system/edac/pci/pci_parity_whitelist
> > 
> >             To display what the whitelist is, simply 'cat' the same
> >             file.
> > 
> > Looking at the current EDAC implementation, these are all of the
> > "one value per file" issues I see.  If anyone sees any others I
> > missed, please let me know.  Here are my thoughts on each:
> > 
> >     Issue #1
> >     --------
> >     Fixing this is easy.  /sys/devices/system/edac/mc/mc0/module_name
> >     can be replaced by two separate files, one providing the name and
> >     the other providing the version:
> > 
> >         /sys/devices/system/edac/mc/mc0/module_name
> >         /sys/devices/system/edac/mc/mc0/module_version
> 
> No, these should just be deleted.  Use the proper MODULE_* macros for
> these if you really want to display them to users.

When these macros are used, they then show up in the /sys/module/xxxx
directory, is that correct?

> 
> >     Issue #2
> >     --------
> >     To fix this, /sys/devices/system/edac/mc/mc0/supported_mem_type
> >     can be made into a directory containing a file representing each
> >     supported memory type.  Thus we might have the following:
> > 
> >         /sys/devices/system/edac/mc/mc0/supported_mem_type
> >         /sys/devices/system/edac/mc/mc0/supported_mem_type/Unbuffered-DDR
> >         /sys/devices/system/edac/mc/mc0/supported_mem_type/Registered-DDR
> > 
> >     In the above example, the files Unbuffered-DDR and Registered-DDR
> >     would each be empty in content.  The presence of each file would
> >     indicate that the memory type it represents is supported.

This attribute reports POSSIBLE memory types, not ACTUAL memory type.

> 
> I don't think the original file is really a big problem.

Are you saying to leave it as is?

the supported_mem_type reports what the memory controller is CAPABLE of
supporting. Then in '..../mc0/csrowN/mem_type' reports what is ACTUALLY
being used.

> 
> >     Issue #3
> >     --------
> >     I am unclear about what to do here.  If the list contents were
> >     read-only, it would be relatively easy to make
> >     /sys/devices/system/edac/pci/pci_parity_whitelist into a directory
> >     containing symlinks, one for each device.  However, the user is
> >     supposed to be able to modify the list contents.  This would imply
> >     that the user creates and destroys symlinks.  Does sysfs currently
> >     support this sort of behavior?  If not, what is the preferred
> >     means for implementing a user-modifiable set of values?

This input and presentation of a list was troublesome in matching the
one attribute policy.

> 
> No it doesn't.  How big can this list get?

Depends on how many PCI devices there are AND which ones have been
identified as non-conforming to the PCI standard for PCI parity status.

At most, the Number of devices minus 1, but then using a 'whitelist'
with just that one lone device would be better. IF all devices are
listed in a blacklist, then just turn off parity checking instead.

Getting the blacklist/whitelist into the edac driver took some pondering
and various designs on my part. I might have missed a more obvious
solution.

> 
> thanks,
> 
> greg k-h

thanks

doug t

