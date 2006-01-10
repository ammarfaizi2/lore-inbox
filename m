Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbWAJGNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbWAJGNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 01:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWAJGNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 01:13:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932068AbWAJGNt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 01:13:49 -0500
Date: Mon, 9 Jan 2006 22:13:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Dillow <dave@thedillows.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Adaptec 1420SA issues with MSI
Message-Id: <20060109221323.65f6987d.akpm@osdl.org>
In-Reply-To: <1136667984.2799.0.camel@obelisk.thedillows.org>
References: <1136667984.2799.0.camel@obelisk.thedillows.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Dillow <dave@thedillows.org> wrote:
>
> [ Doh! Forgot to cc LKML since it may be more of an MSI issue. ]
> 
>  I'm having some issues with sata_mv and my 1420SA card on an ASUS
>  CUV4X-D motherboard (2x PIII 1GHz, Via VT82C693A/694x Apollo PRO133x).
> 
>  If I build 2.6.15 with CONFIG_MSI=y, I get mv_eng_timeout() calls in the
>  log, and cannot talk to the disks. No interrupts are reported for libata
>  in /proc/interrupts. I've also tried pci=routeirq on the command line,
>  to no avail.
> 
>  If I build with CONFIG_MSI=n, then all seems to be well.
> 
>  I'd like to help find a fix, since Fedora uses CONFIG_MSI=y on their
>  kernels, and I eventually want to return this box to a non-custom
>  kernel. To that end, here's lspci and dmesg output. If you need any more
>  info, or have something for me to try, then please let me know.
> 
>  Thanks!
> 
>  lspci -vvv on CONFIG_MSI=y, pci=routeirq:
>  00:0a.0 RAID bus controller: Adaptec Serial ATA II RAID 1420SA (rev 01)
>          Subsystem: Adaptec Serial ATA II RAID 1420SA
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
>          Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>          Latency: 32, Cache Line Size 08
>          Interrupt: pin A routed to IRQ 209
>          Region 0: Memory at ed000000 (64-bit, non-prefetchable) [size=1M]
>          Region 2: I/O ports at a000 [size=256]
>          Capabilities: [40] Power Management version 2
>                  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>          Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable+
>                  Address: 00000000fee03000  Data: 40d1

Andi says "It's more likely a hardware bug that needs to be handled by the
driver maintainer.  sata_mv has an pci_enable_msi().  Hardware that reports
MSI capability but breaks when it's actually used is not unheard of."

-sata_mv 0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via MSI
-ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 177
-ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 177
-ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 177
-ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 177
+sata_mv 0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via INTx
+ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 18
+ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 18
+ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 18
+ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 18

It seems strange that pci_enable_msi() succeeded if the device is not
MSI-capable?

