Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263491AbSJVXoY>; Tue, 22 Oct 2002 19:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSJVXoY>; Tue, 22 Oct 2002 19:44:24 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:19724 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263491AbSJVXoW>;
	Tue, 22 Oct 2002 19:44:22 -0400
Date: Tue, 22 Oct 2002 16:49:13 -0700
From: Greg KH <greg@kroah.com>
To: "Lee, Jung-Ik" <jung-ik.lee@intel.com>
Cc: "'KOCHI, Takayoshi'" <t-kouchi@mvf.biglobe.ne.jp>,
       "Luck, Tony" <tony.luck@intel.com>,
       "'David Mosberger'" <davidm@napali.hpl.hp.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       pcihpd-discuss@lists.sourceforge.net,
       linux ia64 kernel list <linux-ia64@linuxia64.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Two PCI Hotplug Drivers for 2.5
Message-ID: <20021022234913.GB9498@kroah.com>
References: <72B3FD82E303D611BD0100508BB29735046DFF32@orsmsx102.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72B3FD82E303D611BD0100508BB29735046DFF32@orsmsx102.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 04:28:14PM -0700, Lee, Jung-Ik wrote:
> 
> Hi Greg,
> 
> Please find the attached two PCI hotplug drivers for 2.5.
> 
>  intcphp: New Intel's PHP driver for CPQ or equivalent Intel
> 	    controllers for IA32/IA64, ACPI/legacy platforms.
> 	    This driver is needed for IA64 servers (Lion,
> 	    Tiger, etc), and has been verified on 2.5.39
>  acpiphp: ACPI based PHP driver updated to support CAL(*).
> 	    ACPI based ctrl/slot operations are abstracted to
> 	    CAL module. This has been verified on 2.5.39 and
> 	    Feature/functionality remain the same. 
> 	    Patch against Tak's 2.5.39 patch is included.
> 
> 
> (*) CAL is a Controller Abstraction Layer that we came up to provide a
> convenient and uniform interface to different types of hotplug controllers.
> CAL abstracts details of individual HP controller/slot operations and also
> provides flexibility of binding different CAL modules to single php driver
> core. Both intcphp driver and acpiphp driver support CAL interface.

Ah, something like this is nice to have, but you duplicated a _lot_ of
code in getting here.  A patch moving some of the common Compaq code to
the pci_hotplug.o module, which would enable a lot of the compaq and
acpi driver code to be removed would be greatly appreciated.

> The reason why we separated slot/controller operations(event management) as
> CAL is to make most of Common hotplug driver components not only for Hotplug
> PCI driver but also for Hotplug-Everything, required for Atlas project, and
> other server platforms.
> For Hotplug-everything - Hotplug-PCI, IO-Node, and memory, etc.-, ACPI based
> Resource Management and Event management are key common components.
> 
> To design an ACPI based PCI HP driver, we need a combination of the two
> common Hotplug-Everything components and PCI HP driver core.
> 	1. ACPI based PHPRM(Resource Management/configuration)
> 	2. Event Management(ACPI based or OEM ctrl based CAL)
> 	3. PHP driver core: usage model of PHP
> 
> For Hotplug-Others, #1, and #2 should be the same and #3 will be replaced
> with Hotplug-Other driver core.
> 
> This release is the first step to achieve the goal of the Common HotPlug
> architecture while minimizing affects on existing PHP driver features and
> functionalities. Current status of the drivers is: 
>   + Both conform to CAL.

A layer you came up with?  I would hope this driver would match it :)

>   + hotplug_ops routines are identical.

We have common hotplug operations right now.  What's wrong with those?
I'm not going to have some API that looks the same for PCI cards and
memory DIMMS, that's just dumb.  They are different things, and do
different things, don't try to merge them together.

>   + Functionality of Resource managements(PHPRM) are the
>     same and soon will share phprm_acpi.
>   + Both will use common php core.

Hm, and also you can now plug in closed source hotplug drivers, as you
went around the existing EXPORT_SYMBOL_GPL() symbols.  I've told you
about this _many_ times in the past and will never accept such a patch,
as you have said this is your end goal.

> The ultimate difference between acpiphp driver and intcphp driver,
> therefore, will be the CAL implementation only. I.e., acpiphp will use ACPI
> based event management for controller/slot operations thru CAL interface,
> while intcphp can use either it's own HPC controller based CAL or acpiphp's
> ACPI based event management CAL.
> 
> 
> We've tested two drivers with 2.5.39/IA64. This should also apply to 2.5.41
> and later. 2.4 backport will be available later as needed.
> Please apply.

Because of the above comments, no, I will not.  What I will accept would
be:
	- move the common code that you have already identified into the
	  pci_hotplug core.  That will enable the Compaq and ACPI
	  drivers to remove a lot of code (and hopefully the IBM driver,
	  but don't worry about that if it doesn't look obvious.)
	- stick with the existing pci_hotplug API for hotplug PCI
	  drivers.  If you need something different from what is
	  currently there, please let me know.  But do NOT try to go
	  around the EXPORT_SYMBOL_GPL functions by providing your own
	  shim layer, that's not acceptable.
	- please remove all typedefs from the code.
	- remove all LINUX_VERSION checks as they are necessary for code
	  that is in the main kernel tree.

thanks,

greg k-h
