Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316601AbSFUNoh>; Fri, 21 Jun 2002 09:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSFUNog>; Fri, 21 Jun 2002 09:44:36 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:16169 "EHLO ibm.com")
	by vger.kernel.org with ESMTP id <S316595AbSFUNof>;
	Fri, 21 Jun 2002 09:44:35 -0400
Date: Fri, 21 Jun 2002 09:29:43 -0500
From: sullivan <sullivan@austin.ibm.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       Linus Torvalds <torvalds@transmeta.com>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
Message-ID: <20020621092943.D1243@austin.ibm.com>
References: <3D12032C.7040105@evision-ventures.com> <Pine.LNX.4.33.0206201230190.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0206201230190.654-100000@geena.pdx.osdl.net>; from mochel@osdl.org on Thu, Jun 20, 2002 at 01:12:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 01:12:08PM -0700, Patrick Mochel wrote:
<snip>
> 
> Sure. Once device class supports materializes, classes will register and
> can be assigned a dynamic major number even (if they don't already have
> one). As devices (and partitions) are discovered, we can assign minor
> numbers (dynamically!), and call /sbin/hotplug to notify userspace of the
> discovery. It can use that information to create device nodes based on 
> user-defined policy. 
> 
<snip>

The driverfs patch for SCSI that was recently posted was the kernel portion of 
a device naming project that is intended to support all devices, at least the 
ones that implement to driverfs in a standard way. There are three items that
IMHO should be considered as part of the standard set that driverfs requires:

1. device type - It appears that Pat is heading down this path with the class
	type support so maybe this is a no brainer. Currently the scsi
	driverfs provides a "type" file to contain this info. The current
	strings used are taken from the scsi_device_types[] but should be
	replaced with the system wide device types that driverfs will provide.

2. uid - Since topology and discovery order of hardware can change, the
	driverfs path names to a device are also subject to change. To
	easily identify a device I think it's important that the driverfs
	bus implementations be responsible for create a unique identifier.

	Since each bus and the devices attached to it will have varying
	capabilities for identifying themselves the contents for this file
	should probably be a variable length string.

	Even for older devices that can't do a great job of providing info to
	uniquely identify themselves, the driverfs tree provides the nice
	topological context to fall back upon that allows at least as
	good of a job to be done as we do today.

	The scsi patch currently creates uid info from the INQUIRY evpd pages
	and makes it available in the name file. I would prefer to see a
	new standard uid file and let the name file contain a descriptive 
	(non-unique) name.

3. kdev - To create/manage/interface with the device node we need to know the
 	kdev.

Because of coldplugging this information should be available in each driverfs
device directory. Also, adding the driverfs path name on /sbin/hotplug
events and allowing the consumer to retrieve the info from the filesystem might
help simplify some of these implementations too.

The devnaming utility that is based on this strategy is available at
http://www-124.ibm.com/devreg/ 

I'd welcome any thoughts or suggestions.	

- Mike Sullivan
