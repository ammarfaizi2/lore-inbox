Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316544AbSFDTCv>; Tue, 4 Jun 2002 15:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSFDTCu>; Tue, 4 Jun 2002 15:02:50 -0400
Received: from air-2.osdl.org ([65.201.151.6]:55174 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316544AbSFDTCt>;
	Tue, 4 Jun 2002 15:02:49 -0400
Date: Tue, 4 Jun 2002 11:58:39 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: "David S. Miller" <davem@redhat.com>, <anton@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
In-Reply-To: <20020604210745.A849@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.33.0206041128020.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Can't it go the other way? Instead of mass-promotion of the setup 
> > functions, can't we demote the ones that are causing the problems? 
> 
> Agreed, but converting everything into initcalls without any good reason
> looks like a bad idea either.

True, but IMO, there are good reasons for converting these to initcalls. 

> > core is used for what's in drivers/base/*.c. unused is unused.
> 
> So subsys_initcall(sys_bus_init) in base/sys.c should be
> core_initcall(sys_bus_init), right? :-)

No. The system "bus" is a subsystem, not a piece of the infrastructure. 
It's a pseudo-bus that provides a parent for system devices (since they 
otherwise appear as floating, autonomous beings).

> > subsys is intended primarily for initializing and advertising the 
> > existence of bus types and device class types (network, input, etc). 
> > Device probing doesn't necessarily have to take place here, and in some 
> > cases, it can't: e.g. when the firmware is used to inform the system of 
> > the PCI buses present.
> 
> pcibios_init on alpha and some other archs is a lot more than just
> device probing. Basically it's a firmware, and we want it to be
> executed early.

Sure. x86 is similar, to an extent. OWOA, there is a distinction between 
the initialization and the actual probing. And, it appears that alpha 
already has that. It appears that most of the alpha platforms use 
common_init_pci() for their init_pci entry point. A few more use 
cia_init_pci() for init_pci. The rest define their own (except the 
jensen, which is NULL). 

cia_init_pci does this: 

        verify_tb_operation();
        common_init_pci();

All the platforms that define their own init_pci callbacks either call 
common_init_pci() or cia_init_pci() before doing anything else. 

My point is that the only thing pcibios_init() appears to be doing on 
alpha is probing the bus. Whatever firmware black magic that must take 
place appears to either not exist, or have already been done by that 
point. 

I'm not going to try and force you to use a device_initcall. But, it 
appears that it will work, and it fits the nomenclature. 

	-pat


