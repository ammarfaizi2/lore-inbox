Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUCJHwp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 02:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUCJHwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 02:52:45 -0500
Received: from [212.239.224.181] ([212.239.224.181]:6528 "EHLO precious")
	by vger.kernel.org with ESMTP id S262092AbUCJHwk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 02:52:40 -0500
From: Jan De Luyck <lkml@kcore.org>
To: lkml@vger.kernel.org
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
Date: Wed, 10 Mar 2004 08:52:28 +0100
User-Agent: KMail/1.6.1
Cc: James Ketrenos <jketreno@linux.co.intel.com>, linux-kernel@vger.kernel.org
References: <404E27E6.40200@linux.co.intel.com>
In-Reply-To: <404E27E6.40200@linux.co.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200403100852.35429.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 09 March 2004 21:24, James Ketrenos wrote:
> I am pleased to announce the launch of an open source development project
> for the Intel PRO/Wireless 2100 miniPCI network adapter. The project has
> been created and is hosted at http://ipw2100.sf.net.

Nice. Applied to 2.6.2 without problems.

Machine: Acer TravelMate 803LCI with Intel PRO/Wireless 2100.

02:04.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
        Subsystem: Intel Corp.: Unknown device 2527
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 8500ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at d0206000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

I've tried the driver out, and here are some remarks:

1. When loading the driver, it outputs this:

ipw2100: Intel(R) PRO/Wireless 2100 Network Driver, 0.0.29
ipw2100: Copyright(c) 2003-2004 Intel Corporation
Detected ipw2100 PCI device at 0000:02:04.0, dev: eth%%d, mem: 0xD0206000-0xE498BFFF -> e498b000, irq: 10

I guess the eth%%d is just cosmetic, still, it looks ugly.

2. When you load the module, and immediately rmmod it, you get an oops:

Mar 10 08:43:13 precious kernel:  Unable to handle kernel paging request at virtual address ffffffd8
Mar 10 08:43:13 precious kernel:  printing eip:
Mar 10 08:43:13 precious kernel: e49e8e53
Mar 10 08:43:13 precious kernel: *pde = 00002067
Mar 10 08:43:13 precious kernel: *pte = 00000000
Mar 10 08:43:13 precious kernel: Oops: 0000 [#1]
Mar 10 08:43:13 precious kernel: CPU:    0
Mar 10 08:43:13 precious kernel: EIP:    0060:[__crc_rtattr_parse+686442/4765576]    Not tainted
Mar 10 08:43:13 precious kernel: EFLAGS: 00010217
Mar 10 08:43:13 precious kernel: EIP is at ipw2100_defrag_free+0x33/0x90 [ipw2100]
Mar 10 08:43:13 precious kernel: eax: debdb000   ebx: 00000000   ecx: df5c5bc0   edx: dff6f270
Mar 10 08:43:13 precious kernel: esi: ffffffd0   edi: df15c200   ebp: df15c54c   esp: dad9ded8
Mar 10 08:43:13 precious kernel: ds: 007b   es: 007b   ss: 0068
Mar 10 08:43:13 precious kernel: Process rmmod (pid: 1194, threadinfo=dad9c000 task=df901940)
Mar 10 08:43:13 precious kernel: Stack: dfe12c00 df15c200 df15c000 dfe12c00 dad9c000 e49e6dd2 df15c200 db016de0
Mar 10 08:43:13 precious kernel:        dfe12c00 e49ef264 00000000 c024ec0b dfe12c00 dfe12c54 c02ae786 dfe12c54
Mar 10 08:43:13 precious kernel:        dfe12c80 e49ef2b0 e49ef2b0 c02ae7bb dfe12c54 e49ef264 c0396cd8 c02ae9fd
Mar 10 08:43:13 precious kernel: Call Trace:
Mar 10 08:43:13 precious kernel:  [__crc_rtattr_parse+678121/4765576] ipw2100_pci_remove_one+0x52/0xe0 [ipw2100]
Mar 10 08:43:13 precious kernel:  [pci_device_remove+59/64] pci_device_remove+0x3b/0x40
Mar 10 08:43:13 precious kernel:  [device_release_driver+102/112] device_release_driver+0x66/0x70
Mar 10 08:43:13 precious kernel:  [driver_detach+43/64] driver_detach+0x2b/0x40
Mar 10 08:43:13 precious kernel:  [bus_remove_driver+61/128] bus_remove_driver+0x3d/0x80
Mar 10 08:43:13 precious kernel:  [driver_unregister+19/40] driver_unregister+0x13/0x28
Mar 10 08:43:13 precious kernel:  [pci_unregister_driver+22/48] pci_unregister_driver+0x16/0x30
Mar 10 08:43:13 precious kernel:  [__crc_rtattr_parse+686758/4765576] ipw2100_exit+0xf/0x15 [ipw2100]
Mar 10 08:43:13 precious kernel:  [sys_delete_module+309/336] sys_delete_module+0x135/0x150
Mar 10 08:43:13 precious kernel:  [sys_munmap+68/112] sys_munmap+0x44/0x70
Mar 10 08:43:13 precious kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Mar 10 08:43:13 precious kernel:
Mar 10 08:43:13 precious kernel: Code: 8b 56 08 85 d2 74 25 8b 82 90 00 00 00 48 74 0d ff 8a 90 00


3. Loading av5100 on this machine shows the line "Turning radio ON" which afterwards deadlocks my machine.
It does show that 'device is disabled by hardware RF switch', but the led is lit which shows that it's enabled instead. 
Weird.

I can't test the actual transmitting since I've got no accesspoint handy. Will do so when at home, though.

Otherwise: great work, and thanks for finally releasing this driver!

Jan

- -- 
Plus ,ca change, plus c'est la m^eme chose.
	[The more things change, the more they remain the same.]
		-- Alphonse Karr, "Les Gu^epes"
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFATslCUQQOfidJUwQRAvXMAJ46sckVYqtGSXGGF6OqArBhLUbGBgCfej11
Sn2xVq6mdaJ4GN+x1/iNDhY=
=1iy0
-----END PGP SIGNATURE-----
