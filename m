Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUHNORo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUHNORo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 10:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbUHNORo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 10:17:44 -0400
Received: from web14930.mail.yahoo.com ([216.136.225.159]:41321 "HELO
	web14930.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262574AbUHNORI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 10:17:08 -0400
Message-ID: <20040814141705.43723.qmail@web14930.mail.yahoo.com>
Date: Sat, 14 Aug 2004 07:17:05 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Martin Mares <mj@ucw.cz>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20040814094700.GA662@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Martin Mares <mj@ucw.cz> wrote:
> Hello!
> 
> > I removed the call to pci_assign_resource(). The sysfs attribute
> code
> > builds the attributes before the pci subsystem is fully
> initialized.
> > specifically before arch pcibios_init() has been called. If
> > pci_assign_resource() is called for the ROM before pcibios_init()
> the
> > kernel's resource maps have not been built yet. This will result in
> the
> > ROM being assigned a location on top of the framebuffer; as soon as
> it
> > is enabled the system will lock. Right now the code relies on the
> BIOS
> > getting the ROM address set up right. If we can figure out how to
> > initialize the sysfs attributes after pcibios_init() then I can put
> the
> > assign call back.
> 
> If I understand correctly, you don't need that. Just don't map the
> ROM before somebody explicitly requests it -- be it either some 
> driver or sysfs. In both cases, the PCI subsystem is already 
> initialized.

That's why it works right now without the assign_resource. The BIOS has
already set everything up.

> > I think the decoder sharing problem is being blown out of
> proportion
> > there are very few boards with this problem.
> 
> Yes, but it's no excuse for writing code which triggers these
> problems if there is an easy way how to do that more safely.

The code that accesses the ROM runs very early, before anything else is
loaded. The only conflict I can think of is from the on-board BIOS of a
disk cotroller with partial decoding. But I'm not sure if a care like
that exists.

If a card like this exists, I need to make the code use the BIOS SHADOW
copy of the ROM.

> 
> > Also, one card I have has a 256MB PCI window over a 48KB ROM. If I
> use
> > the window size instead of true size for a copy I would waste a lot
> of
> > memory.
> 
> BTW, if the card doesn't share decoders, is there any need to create
> a copy of the ROM? If not, no memory gets wasted.

The copy is triggered manually by the device driver with partial
decoding. When the driver loads loads and it is safe to access the ROM,
call pci_map_rom_copy() this will trigger the copy. Alternatively it
can call pci_rom_remove() which will remove the rom sysfs attribute.

Normal hardware needs to do nothing. If a normal device driver wants to
access the ROM call pci_map_rom(). This will automatically return the
actual ROM or the BIOS shadow copy as needed.

There are two times the ROM can get copied:
1) manually when a driver knows it has partial PCI decoding and calls
pci_map_rom_copy()
2) By the system BIOS. PC system BIOS' automatically shadow all of the
roms located from C0000 to 1000000 into RAM. If this copy exists I use
it.

The system shadow copy is one of the main motivators for this code. On
some laptop the system and video ROMs are compressed. On these systems
the boot ROM decompresses these ROM into the shadow memory at
C0000-100000.


> 
> 				Have a nice fortnight
> -- 
> Martin `MJ' Mares   <mj@ucw.cz>  
> http://atrey.karlin.mff.cuni.cz/~mj/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep.,
> Earth
> How an engineer writes a program: Start by debugging an empty file...
> 


=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
