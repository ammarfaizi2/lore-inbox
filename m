Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbUKEBQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbUKEBQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbUKEBQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:16:26 -0500
Received: from fmr04.intel.com ([143.183.121.6]:33941 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262555AbUKEBNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:13:01 -0500
Date: Thu, 4 Nov 2004 17:09:02 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, rusty@rustcorp.com.au,
       mochel@digitalimplant.org, anton@samba.org
Subject: Re: [RFC/PATCH 0/4] cpus, nodes, and the device model: dynamic cpu registration
Message-ID: <20041104170902.A8747@unix-os.sc.intel.com>
References: <20041024094551.28808.28284.87316@biclops>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041024094551.28808.28284.87316@biclops>; from nathanl@austin.ibm.com on Sun, Oct 24, 2004 at 03:42:10AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 03:42:10AM -0600, Nathan Lynch wrote:
Hi Nathan,

this has been lying for a while, and didnt pay attension.. sorry for the late
response.
> 
> I know of at least two platforms (ppc64 and ia64) which allow cpus to
> be physically or logically added and removed from a running system.
> These are distinct operations from onlining or offlining, which is
> well supported already.  Right now there is little support in the core
> cpu "driver" for dynamic addition or removal.  The patch series which
> follows implements support for this in a way which will (hopefully)
> reduce code duplication and enforce some uniformity across the
> relevant architectures.

I think unifying is very good, there are some minor suggestions, i will respond to those
patches separately.

> 
> For starters, the current situation is that cpu sysdevs are registered
> from architecture code at boot.  Already we have inconsistencies
> betweeen the arches -- ia64 registers only online cpus, ppc64

ia64 we register for all cpu's present in NUMA case. Say for e.g. you start with 

maxcpus=2 on a 4 way system, we would create sysfs for all 4 cpus. (This is with the acpi patches
submitted. Before that we were doing this just for all possible cpus.

we probably did online only cpus for numa systems, due to the association is not known until the
node is present (as you have mentioned below. so we probably took a short cut for numa since that was a work TBD.

> registers all "possible" cpus.  I propose to move the initial cpu
> sysdev registrations to the cpu "driver" itself (drivers/base/cpu.c),
> and to register only "present" cpus at boot.
> 
> But that breaks all the arch code which explicitly registers cpu
> sysdevs.  For instance, ppc64 wants to hang all kinds of attributes
> off of the cpu devices for performance counter stuff.  So code such as
> this needs to be converted to register a sysdev_driver with the cpu
> device class, which will allow the ppc64 code to be notified when a
> cpu is added or removed.  In the patches that follow I include the
> changes necessary for ppc64, as an example.  (An arch sweep or
> temporary compatibility hack can come later if I get positive
> responses to this approach.)
> 
> Also, there is the matter of the base numa "node" driver.  Currently
> the cpu driver makes symlinks from nodes to their cpus.  This seems
> backwards to me, so I have changed the node driver to create or remove
> the symlinks upon cpu addition or removal, respectively, also using
> the sysdev_driver approach.  I've also converted base/drivers/node.c
> to doing the boot-time node registration itself, like the cpu code.
> 
> Finally, I've added two new interfaces which wrap all this up --
> cpu_add() and cpu_remove().  These carry out the necessary update to
> cpu_present_map and take care of the cpu device registration.  These
> are meant to be invoked from the platform-specific code which
> discovers and removes processors.

I think you want the device registration that create the sysfs file to the 
arch code. If you look at the ACPI extensions to support physical cpu hotplug
we need to keep track of the acpi->logical association. so all we really need
is a bit off the bitmap, but the cpu is not yet ready for operation yet.

having helpers to get a index out of cpu_present_map can be a common helper routine, but 
arch may have to munch with this data before general consumption.

-- 
Cheers,
Ashok Raj
- Linux OS & Technology Team
