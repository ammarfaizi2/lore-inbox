Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbTFSRKY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265850AbTFSRKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:10:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:45709 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265848AbTFSRKR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:10:17 -0400
Date: Thu, 19 Jun 2003 10:26:42 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <greg@kroah.com>, viro@parcelfarce.linux.theplanet.co.uk,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Kevin P. Fleming'" <kpfleming@cox.net>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Russell King'" <rmk@arm.linux.org.uk>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Flaw in the driver-model implementation of attributes
Message-ID: <20030619172641.GA1172@beaverton.ibm.com>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Greg KH <greg@kroah.com>, viro@parcelfarce.linux.theplanet.co.uk,
	"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	"'Kevin P. Fleming'" <kpfleming@cox.net>,
	'Patrick Mochel' <mochel@osdl.org>,
	'Russell King' <rmk@arm.linux.org.uk>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <20030618171527.GA1415@kroah.com> <Pine.LNX.4.44L0.0306190949200.998-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0306190949200.998-100000@ida.rowland.org>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern [stern@rowland.harvard.edu] wrote:
> Right now they don't.  For example, I have a SCSI card in my system.  It
> shows up as /sys/devices/pci0/0000:00:0d.0/ -- that's the PCI bus driver's
> view of the card.  It also shows up as
> /sys/devices/pci0/0000:00:0d.0/host1/ -- that's the SCSI core's view of 
> the same card.  So there are two devices representing the same physical 
> object, and neither of them is created by the aic7xxx driver.

Actually host1 is created by the aic7xxx driver through registration
with the SCSI subsystem. The aic7xxx allocates the structure, registers
it, unregisters it, and drops the ref on it when it is done with it.

The SCSI subsystems view of hosts that have registered with the subsystem
is through /class/scsi_host.

> To change the topic slightly, consider this small inconsistency in sysfs.  
> The IDE bus driver creates entries for each IDE channel.  So for example, 
> /sys/devices/pci0/0000:00:07.1/ide0/0.0/ represents the master device on 
> channel 0 whereas /sys/devices/pci0/0000:00:07.1/ide1/1.1 represents the 
> slave device on channel 1.  The SCSI bus driver, on the other hand, does 
> not create intermediate levels in the hierarchy for channels or targets.  
> So for example, /sys/devices/pci0/0000:00:0d.0/host1/1:0:5:0/ is the entry 
> for host 1, channel 0, target 5, LUN 0.  There's nothing in between the 
> host level and the LUN level.
> 

Currently the scsi device in the SCSI subsystem is LUN.  While the
future may lead to having a having a target as a child of the host it
would be a large change for 2.5 / 2.6. 

> Is that the sort of decision that's left up to the bus driver author?  
> Should there be any sort of enforced consistency, or doesn't it matter?

Each transport / bus may have a unique nexus between a parent and child.
Interpretation of a name outside of the name space registering or
owning the name would lead to bad info (i.e.  interpretation of these
two child nodes using the same policy "pci0/0000:00:07.1"
"host1/1:0:5:0/")  Enforcing a overall consistency could lead to
creating pseudo hierarchies just to fit a consistency model.

-andmike
--
Michael Anderson
andmike@us.ibm.com

