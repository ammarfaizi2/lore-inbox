Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316783AbSFDVOd>; Tue, 4 Jun 2002 17:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSFDVOc>; Tue, 4 Jun 2002 17:14:32 -0400
Received: from air-2.osdl.org ([65.201.151.6]:39047 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316783AbSFDVOb>;
	Tue, 4 Jun 2002 17:14:31 -0400
Date: Tue, 4 Jun 2002 14:10:27 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "David S. Miller" <davem@redhat.com>
cc: <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
In-Reply-To: <20020604.124241.78709149.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0206041403010.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It says "this has to be initialized, but after core initcalls because
> it expects core to be setup."  That's what "postcore" means. :-)

Oh right; silly me. 

>    The initcall levels are not a means to bypass true dependency resolution. 
>    They're an alternative means to solving some of the dependency problems 
>    without having a ton of #ifdefs and hardcoded, explicit calls to 
>    initialization routines. 
>    
> I added no ifdefs, what are you talking about.

I was referring to the original motivation of the patch: what 
init/main.c::do_basic_setup() and arch/i386/kernel/pci-pc.c used to look 
like. 

> How much more meaning do you want than "this requires core to be
> setup"  That describes a lot to me.

Because it describes every initcall. But, whatever. Let me ask this 
instead: is there a better way to specify dependencies between components? 

> You people are blowing this shit WAY out of proportion.  Just fix the
> bug now and reinplement the initcall hierarchy in a seperate changeset
> so people can actually get work done in the 2.5.x tree while you do
> that ok?

Fine. Use Ivan's; it's appended below, and will be in BK soon. 

	-pat

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


