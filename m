Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbTHSU3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 16:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbTHSU3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 16:29:18 -0400
Received: from palrel10.hp.com ([156.153.255.245]:62426 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261331AbTHSUXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 16:23:25 -0400
Date: Tue, 19 Aug 2003 13:23:23 -0700
To: linux-pcmcia@lists.infradead.org, Russell King <rmk@arm.linux.org.uk>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Bug : Can't read CIS (3.2.4 + 2.4.22 ; 2.6.0-test3)
Message-ID: <20030819202323.GA10467@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030816000214.GA31977@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030816000214.GA31977@bougret.hpl.hp.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 05:02:14PM -0700, jt wrote:
> 	Hi David,
> 
> 	Summary : the Pcmcia subsystem seems to no be able to read the
> CIS on my new PC, and therefore always bind memory_cs to the card. Of
> course, that's not the proper driver...

	Hi again,

	I've just realised that I e-mailed only Dominik about my
progress with 2.6.0-test3, but you all might be interested...
	Earlier details (HW, setup) :
http://lists.infradead.org/pipermail/linux-pcmcia/2003-August/000205.html

	After a bit of back and forth with David Hinds, we managed to
fix a bug in the ressource manager of the Pcmcia code. With the
16-Aug-03 version, it gave me the following error message :
----------------------------------------
cs: unable to map card memory!
----------------------------------------

	So, I went into the BIOS and reserved a memory area for ISA
cards, and it started working properly :
--------------------------------------------------------
Linux PCMCIA Card Services 3.2.5
  kernel build: 2.4.22-rc2 #2 SMP Fri Aug 15 15:46:11 PDT 2003
  options:  [pci] [cardbus]
Intel ISA/PCI/CardBus PCIC probe:
  Vadem VG-469 rev 00 ISA-to-PCMCIA at port 0x3e0 ofs 0x00
    host opts [0]: none
    host opts [1]: none
    ISA irqs (scanned) = 3,4,5,7,10 polling interval = 1000 ms
cs: memory probe 0x0d0000-0x0dffff: excluding 0xd4000-0xdffff
cs: memory probe 0x0e0000-0x0effff: excluding 0xe0000-0xeffff
cs: memory probe 0x0c0000-0x0cffff: excluding 0xc0000-0xc7fff
cs: memory probe 0x0f0000-0x0fffff: excluding 0xf0000-0xfffff
airo:  Probing for PCI adapters
PCI: Enabling device 00:13.0 (0000 -> 0003)
PCI: Setting latency timer of device 00:13.0 to 64
airo: Doing fast bap_reads
airo: MAC enabled eth0 0:40:96:43:22:54
airo:  Finished probing for PCI adapters
cs: IO port probe 0x0100-0x04ff: excluding 0x1f0-0x1f7 0x378-0x37f 0x3c0-0x3e7 0x3f0-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: clean.
airo: Doing fast bap_reads
airo: MAC enabled eth1 0:7:e:b8:d4:9f
eth1: index 0x05: Vcc 5.0, Vpp 5.0, irq 5, io 0x0100-0x013f
Setting key 0
airo:  WEP_PERM set 12106
--------------------------------------------------------

	That was 2.4.22-rc2 with the external Pcmcia package. Now,
I've moved over to 2.6.0-test3 with kernel Pcmcia code, which is my
real target. Even after the BIOS change, it still fails :
-----------------------------------------
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus]
Intel PCIC probe: 
  Vadem VG-469 ISA-to-PCMCIA at port 0x3e0 ofs 0x00, 2 sockets
    host opts [0]: none
    host opts [1]: none
    ISA irqs (scanned) = 3,4,5,10<6>    PCI card interrupts, polling interval = 1000 ms
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x1f0-0x1f7 0x378-0x37f 0x390-0x39f 0x3c0-0x3e7 0x3f0-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0x0d0000-0x0dffff: excluding 0xd6000-0xe1fff
cs: memory probe 0x0c0000-0x0cffff: excluding 0xc0000-0xc7fff
-----------------------------------------
Aug 19 13:11:09 lagaffe cardmgr[202]: watching 2 sockets
Aug 19 13:11:09 lagaffe cardmgr[203]: starting, version is 3.2.5
Aug 19 13:11:09 lagaffe cardmgr[203]: socket 0: Anonymous Memory
Aug 19 13:11:09 lagaffe cardmgr[203]: executing: 'modprobe memory_cs'
Aug 19 13:11:09 lagaffe cardmgr[203]: + FATAL: Module memory_cs not found.
Aug 19 13:11:09 lagaffe cardmgr[203]: modprobe exited with status 1
Aug 19 13:11:09 lagaffe cardmgr[203]: module /lib/modules/2.6.0-test3/pcmcia/memory_cs.o not available
Aug 19 13:11:09 lagaffe cardmgr[203]: bind 'memory_cs' to socket 0 failed: Invalid argument
Aug 19 13:11:10 lagaffe cardmgr[203]: socket 0: Anonymous Memory
-----------------------------------------
	So, basically the BIOS change was not enough to make 2.6.X
work. Probably whatever ressource manager fix David did in his package
need to be ported over to the kernel code. I'm willing to try any
patch for this (I'm leaving in vacation on thursday).

	I've also tried a TI1225 (PCI-Pcmcia) on the same box with
2.6.X and it did hang the box. If one of you tell me how to enable
Pcmcia debug in 2.6.X, I could try to setup a serial console and get
more details.

	Have fun...

	Jean
