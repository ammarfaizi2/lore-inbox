Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266131AbUAGFFN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 00:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266134AbUAGFFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 00:05:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9075 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S266131AbUAGFE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 00:04:59 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@colin2.muc.de>, Mika Penttil? <mika.penttila@kolumbus.fi>,
       Andi Kleen <ak@muc.de>, David Hinds <dhinds@sonic.net>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
References: <1aJdi-7TH-25@gated-at.bofh.it>
	<m37k054uqu.fsf@averell.firstfloor.org>
	<Pine.LNX.4.58.0401051937510.2653@home.osdl.org>
	<20040106040546.GA77287@colin2.muc.de>
	<Pine.LNX.4.58.0401052100380.2653@home.osdl.org>
	<20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi>
	<20040106094442.GB44540@colin2.muc.de>
	<Pine.LNX.4.58.0401060726450.2653@home.osdl.org>
	<20040106153706.GA63471@colin2.muc.de>
	<m1brpgn1c3.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0401061554010.9166@home.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Jan 2004 21:58:23 -0700
In-Reply-To: <Pine.LNX.4.58.0401061554010.9166@home.osdl.org>
Message-ID: <m13casmk28.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 6 Jan 2004, Eric W. Biederman wrote:
> > 
> > And mtd map drivers for rom chips run into the same problem except in
> > that case regions is almost always reserved by the BIOS.
> > 
> > Which means it's just silly for the drivers to fail when request_mem_region
> > fails.
> 
> Note: you're not supposed to need to do "request_mem_region()" for modern 
> drivers. You should only need to claim ownership of the resources, and the 
> PCI driver interfaces should do that automatically.
> 
> What you should do for resources you know about is to just _create_ them.

Which I can do.   But what if the BIOS has marked them as reserved?
The BIOS always does this for ROM chips.  And it sounds like this occasionally
happens for AGP apertures.

> Not necessarily request them (although that is one way of creating them), 
> but you can literally just tell the kernel that they are there. That will 
> already mean that anybody else that tries to allocate a resource will 
> avoid that area.
> 
> So if you know the hardware is there, and it _tells_ you it's there
> (unlike, say, an ISA device), you can just call "request_mem_region()"  
> without ever even checking the error return (although you had better make
> sure that the name allocation is stable if you are a module - don't want
> to start oopsin in /proc if the module gets unloaded).

Or to oops when the module is unloaded, when you try and free the resource.
But actually completely freeing the resource is actually bad manners, because
the resources are used no matter what and you don't want to allocate anything
else in there.

> The PCI layer already does all of that for the "standard" resources. It's 
> just that the generic code can't do it for nonstandard regions, so drivers 
> for chips that don't have just the regular BAR things should create their 
> own resource entries..

So thinking out loud about the twist that is in my experience.  Southbridges
have a special decode region for BIOS ROM chips.  It is at least 64K, but can
be as big as 8M or so at the end of the address space.  

On my machine at home the e820 map looks like:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1fffbfff : System RAM
  00100000-002bdc69 : Kernel code
  002bdc6a-00347183 : Kernel data
1fffc000-1fffefff : ACPI Tables
1ffff000-1fffffff : ACPI Non-volatile Storage
cb800000-cb8fffff : Intel Corp. 82557 [Ethernet Pro 100]
cc000000-cc000fff : Intel Corp. 82557 [Ethernet Pro 100]
  cc000000-cc000fff : eepro100
cc800000-cddfffff : PCI Bus #01
  cc800000-ccffffff : Matrox Graphics, Inc. MGA G400 AGP
  cd000000-cd003fff : Matrox Graphics, Inc. MGA G400 AGP
cdf00000-cfffffff : PCI Bus #01
  ce000000-cfffffff : Matrox Graphics, Inc. MGA G400 AGP
d0000000-dfffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
ffff0000-ffffffff : reserved

That last reserved region is 64K.  Which looking at the pci registers
is technically correct at the moment.  Only 64K happen to be decoded.

If I wanted to flash my ROM what I need to do is:
- Load a driver for the region where a ROM chips can possible be at
  the top of memory.  This is the region 0xFFF00000 - 0xFFFFFFFF on
  the via686.

- The driver comes in and looks for the via686, and finds it so it
  knows it can do something.

- The driver can attempt to get the region 0xFFF00000 - 0xFFFFFFFF,
  but that is impossible.

- The driver enables the decodes on all of 0xFFF00000 - 0xFFFFFFFF
  in the via686

- In general the driver would enable to flip a bit in the via686 to
  or someplace to enable the WE (write-enable) line to the ROM chip.

- The driver would then call in the mtd subsystem at likely offsets
  into the region 0xFFF00000 - 0xFFFFFFFF and have it do a JEDEC
  mostly standard probe to see if a BIOS chip starts at that offset.

This basic algorithm works see drivers/mtd/maps/amd76xrom.c and
drivers/mtd/maps/ich2rom.c.  But it does not really play nice with the
existing kernel infrastructure.

So to do this cleanly it looks like I need to write a pci quirk for
the southbridge.  Adding a BAR that enables decodes to the BIOS ROM chip.  
And that quirk should always be present, so that nothing even thinks
of using that region for something else.

With the quirk doing the heavy lifting the map driver would just need to do
something like grab a child resource for the ROM chip to show that I am
actively using it.

The very practical question.  After the BIOS has allocated:
0xFFFF0000 - 0xFFFFFFFF how do I allocate
0xFFF00000 - 0xFFFFFFFF in the pci quirk?

The area is already allocated and it chops of the area I need to
allocate.  Which is a general mess, and that happens to be a very
typical scenario for BIOS ROMS.

Because the conflicting resource is allocated in what
is now: legacy_init_iomem_resources() from bootmem and just 
dropped on the floor I can't free the conflicting resource.
I don't know of anything I can do cleanly without modifying
the code.

Basically the question becomes what to do about an incorrect
e820 map that you don't find out about until you start initializing
drivers.

Eric
