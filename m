Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWFUSb6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWFUSb6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 14:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWFUSb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 14:31:58 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:18599 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1751185AbWFUSb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 14:31:58 -0400
Date: Wed, 21 Jun 2006 11:31:57 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.17-rc[56]-mm*: pcmcia "I/O resource not free"
Message-ID: <20060621183157.GB28016@hexapodia.org>
References: <20060615162859.GA1520@hexapodia.org> <20060617100327.e752b89a.akpm@osdl.org> <20060620211723.GA28016@hexapodia.org> <20060620150317.746372c5.akpm@osdl.org> <20060621065036.GR2038@hexapodia.org> <20060621004630.bb5eb68a.akpm@osdl.org> <20060621171048.GS2038@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621171048.GS2038@hexapodia.org>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 10:10:48AM -0700, Andy Isaacson wrote:
> > > [ 2035.976000] ide2: I/O resource 0xF8B0200E-0xF8B0200E not free.
> > > [ 2035.976000] ide2: ports already in use, skipping probe
> > 
> > hm.  It appears to have decided that 0 < 0xF8B0200E < 0xffff, which is
> > clever of it.
> > 
> > Does it help if you set CONFIG_RESOURCES_32BIT?
> 
> Nope, same conflict with CONFIG_RESOURCES_32BIT set.  You're right, it
> is deciding that 0xF8B0200E conflicts with that range:
> 
> conflict: PCI IO[0->ffff] conflicts with ide2[f8b3c00e->f8b3c00e]
> 
> Looking at the code, I don't understand how this could have worked in
> -rc6; __request_resource hasn't changed, and it says
> 
>     167         if (end < start)
>     168                 return root;
>     169         if (start < root->start)
>     170                 return root;
>     171         if (end > root->end)
>     172                 return root;
> 
> If root-> start == 0 and root->end == 0xffff, we should always hit line
> 172, unless sign extension is in effect... and all the variables are
> unsigned long in -rc6, so that doesn't make sense.
> 
> Rebooting into -rc6 with some debugging...

So 2.6.17-rc6 plus the conflict-printer patch and the
ide-single-byte-request patch does the following (booted with the
PCMCIA/CF adapter in by accident, and I'm using a different CF card now,
but it seems to have done the right thing):

cs: memory probe 0xf0000000-0xf7ffffff: excluding 0xf0000000-0xf7ffffff
cs: memory probe 0xd0200000-0xdfffffff: excluding 0xd0200000-0xd11fffff 0xd1a00000-0xd41fffff 0xd4a00000-0xd51fffff 0xd5a00000-0xd61fffff 0xd6a00000-0xd71fffff 0xd7a00000-0xd81fffff 0xd8a00000-0xd91fffff 0xd9a00000-0xda1fffff 0xdaa00000-0xdb1fffff 0xdba00000-0xdc1fffff 0xdca00000-0xdd1fffff 0xdda00000-0xde1fffff 0xdea00000-0xdf1fffff 0xdfa00000-0xe01fffff
pcmcia: registering new device pcmcia0.0
pcmcia: Detected deprecated PCMCIA ioctl usage from process: cardmgr.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0x100-0x4ff: excluding 0x170-0x177 0x370-0x377 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
conflict: PCI Bus #02[3000->7fff] conflicts with ide2[310e->310e]
conflict: pcmcia_socket0[3100->310f] conflicts with ide2[310e->310e]
hwif_request_region: single-byte request for ide2
 <c0242abe> hwif_request_region+0x9e/0xa0  <c0242bbf> ide_hwif_request_regions+0xff/0x120
 <c0249c90> ide_undecoded_slave+0x0/0xc0  <c0249d79> probe_hwif+0x29/0x4f0
 <c0249c90> ide_undecoded_slave+0x0/0xc0  <c024a255> probe_hwif_init_with_fixup+0x15/0xa0
 <c0243556> ide_register_hw_with_fixup+0x166/0x1b0  <c0249c90> ide_undecoded_slave+0x0/0xc0
 <f8a8612b> idecs_register+0x7b/0xb0 [ide_cs]  <c0249c90> ide_undecoded_slave+0x0/0xc0
 <f8a865a2> ide_config+0x442/0x6c0 [ide_cs]  <f8ab348e> pcmcia_device_probe+0x6e/0x100 [pcmcia]
 <c023ca1c> driver_probe_device+0xbc/0xe0  <c023cac0> __driver_attach+0x0/0x80
 <c023cb30> __driver_attach+0x70/0x80  <c023bd69> bus_for_each_dev+0x69/0x80
 <c01e5723> kobject_set_name+0x43/0xe0  <c023cb65> driver_attach+0x25/0x30
 <c023cac0> __driver_attach+0x0/0x80  <c023c338> bus_add_driver+0x88/0xd0
 <c023d077> driver_register+0x97/0xa0  <c023cfc0> klist_devices_get+0x0/0x10
 <c023cfd0> klist_devices_put+0x0/0x10  <f8ab32f7> pcmcia_register_driver+0x17/0x50 [pcmcia]
 <f894200f> init_ide_cs+0xf/0x11 [ide_cs]  <c0136da2> sys_init_module+0xf2/0x180
 <c0102f2f> sysenter_past_esp+0x54/0x75 
conflict: PCI Bus #02[3000->7fff] conflicts with ide2[3100->3107]
conflict: pcmcia_socket0[3100->310f] conflicts with ide2[3100->3107]
Probing IDE interface ide2...
hde: LEXAR ATA FLASH, CFA DISK drive
ide2 at 0x3100-0x3107,0x310e on irq 3
hde: max request size: 128KiB
hde: 64256 sectors (32 MB) w/1KiB Cache, CHS=1004/2/32
hde: cache flushes not supported
 hde: hde1
ide-cs: hde: Vpp = 0.0

I hope somebody who understands resource.c better than me is reading
this, because I'm pretty much out of time to spend reading code.  (Happy
to test patches, of course.)

-andy
