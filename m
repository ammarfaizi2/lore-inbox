Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSFDRJm>; Tue, 4 Jun 2002 13:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSFDRJl>; Tue, 4 Jun 2002 13:09:41 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:15364 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315222AbSFDRJk>; Tue, 4 Jun 2002 13:09:40 -0400
Date: Tue, 4 Jun 2002 21:07:45 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Patrick Mochel <mochel@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
Message-ID: <20020604210745.A849@jurassic.park.msu.ru>
In-Reply-To: <20020602.203916.21926462.davem@redhat.com> <Pine.LNX.4.33.0206040821100.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 08:50:11AM -0700, Patrick Mochel wrote:
> On Sun, 2 Jun 2002, David S. Miller wrote:
> > It's happening on every platform.  It should be done before
> > arch_initcalls actually, but after core_initcalls.  I would suggest to
> > rename unused_initcall into postcore_iniscall, then use it for this
> > and sys_bus_init which has the same problem.
> 
> Can't it go the other way? Instead of mass-promotion of the setup 
> functions, can't we demote the ones that are causing the problems? 

Agreed, but converting everything into initcalls without any good reason
looks like a bad idea either.
 
> core is used for what's in drivers/base/*.c. unused is unused.

So subsys_initcall(sys_bus_init) in base/sys.c should be
core_initcall(sys_bus_init), right? :-)

> subsys is intended primarily for initializing and advertising the 
> existence of bus types and device class types (network, input, etc). 
> Device probing doesn't necessarily have to take place here, and in some 
> cases, it can't: e.g. when the firmware is used to inform the system of 
> the PCI buses present.

pcibios_init on alpha and some other archs is a lot more than just
device probing. Basically it's a firmware, and we want it to be
executed early.
The PCI _is_ a subsystem, and pci_driver_init() as the part of the
subsystem should be called from inside of it - pci_allocate_primary_bus()
seems to be a proper place. What about following patch?

Ivan.

--- linux/drivers/base/sys.c~	Mon Jun  3 05:44:37 2002
+++ linux/drivers/base/sys.c	Tue Jun  4 16:09:16 2002
@@ -44,6 +44,6 @@ static int sys_bus_init(void)
        return device_register(&system_bus);
 }
 
-subsys_initcall(sys_bus_init);
+core_initcall(sys_bus_init);
 EXPORT_SYMBOL(register_sys_device);
 EXPORT_SYMBOL(unregister_sys_device);
--- linux/drivers/base/Makefile~	Mon Jun  3 05:44:45 2002
+++ linux/drivers/base/Makefile	Tue Jun  4 16:14:36 2002
@@ -1,6 +1,6 @@
 # Makefile for the Linux device tree
 
-obj-y		:= core.o sys.o interface.o fs.o power.o bus.o \
+obj-y		:= core.o interface.o fs.o power.o bus.o sys.o \
 			driver.o 
 
 export-objs	:= core.o fs.o power.o sys.o bus.o driver.o
--- linux/drivers/pci/pci-driver.c~	Tue Jun  4 15:35:54 2002
+++ linux/drivers/pci/pci-driver.c	Tue Jun  4 16:23:10 2002
@@ -199,13 +199,6 @@ struct bus_type pci_bus_type = {
 	bind:	pci_bus_bind,
 };
 
-static int __init pci_driver_init(void)
-{
-	return bus_register(&pci_bus_type);
-}
-
-subsys_initcall(pci_driver_init);
-
 EXPORT_SYMBOL(pci_match_device);
 EXPORT_SYMBOL(pci_register_driver);
 EXPORT_SYMBOL(pci_unregister_driver);
--- linux/drivers/pci/probe.c~	Mon Jun  3 05:44:42 2002
+++ linux/drivers/pci/probe.c	Tue Jun  4 16:24:55 2002
@@ -563,6 +563,9 @@ struct pci_bus * __devinit pci_alloc_pri
 		return NULL;
 	}
 
+	if (!atomic_read(&pci_bus_type.refcount))
+		bus_register(&pci_bus_type);
+
 	b = pci_alloc_bus();
 	if (!b)
 		return NULL;
