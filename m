Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSFDPyV>; Tue, 4 Jun 2002 11:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314475AbSFDPyV>; Tue, 4 Jun 2002 11:54:21 -0400
Received: from air-2.osdl.org ([65.201.151.6]:19334 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S314451AbSFDPyT>;
	Tue, 4 Jun 2002 11:54:19 -0400
Date: Tue, 4 Jun 2002 08:50:11 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "David S. Miller" <davem@redhat.com>
cc: <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
In-Reply-To: <20020602.203916.21926462.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0206040821100.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2 Jun 2002, David S. Miller wrote:

>    From: Anton Blanchard <anton@samba.org>
>    Date: Mon, 3 Jun 2002 14:27:27 +1000
>    
>    On ppc64 I found that pcibios_init was being called before
>    pci_driver_init, maybe its happening on alpha too. I am using the
>    following hack for the moment, I'll leave it to Patrick to fix it properly.
>    
> It's happening on every platform.  It should be done before
> arch_initcalls actually, but after core_initcalls.  I would suggest to
> rename unused_initcall into postcore_iniscall, then use it for this
> and sys_bus_init which has the same problem.

Can't it go the other way? Instead of mass-promotion of the setup 
functions, can't we demote the ones that are causing the problems? 

The initcalls levels were determined by looking at the explicit calls in
init/main.c. Recall that they were:

early_arch
mem
subsys
arch
fs
device
late

with the default being device_initcall. I initially thought that most
things in init/main.c could become initcalls. But, I failed to realize
that init is started before the initcalls are done (duh). (Most things in 
start_kernel() could become initcalls also, but it would require a 
separate initcall section).

Sometime in March, the ACPI people promoted their initialization above 
the initialization of the device model core. This caused a few things to 
fail, and Linus changed the initcall levels to what we have today:

core
unused
arch
subsys
fs
device
late

core is used for what's in drivers/base/*.c. unused is unused. 

arch can be used for arch- and platform-specific initialization. For PCI 
on x86, these determine things like the config space access method. 

subsys is intended primarily for initializing and advertising the 
existence of bus types and device class types (network, input, etc). 
Device probing doesn't necessarily have to take place here, and in some 
cases, it can't: e.g. when the firmware is used to inform the system of 
the PCI buses present.

Theoretically, we should be able to demote bus probing until after 
subsys_initcall. Right? By making them device_initcalls and relying on 
link order, we can guarantee that buses get probed before drivers are 
initialized and start looking for devices they support. (Or, we could make 
a driver_initcall just for drivers; or a bus_initcall for probing buses.)

Thoughts?

	-pat

