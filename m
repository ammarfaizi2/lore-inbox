Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314132AbSEAXyq>; Wed, 1 May 2002 19:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314137AbSEAXyq>; Wed, 1 May 2002 19:54:46 -0400
Received: from postfix2-1.free.fr ([213.228.0.9]:32474 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S314132AbSEAXyp>; Wed, 1 May 2002 19:54:45 -0400
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200205012354.g41NsgH20820@ns.home.local>
Subject: [PATCH] ide conflicts with floppy
To: andre@linux-ide.org
Date: Thu, 2 May 2002 01:54:42 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andre,

I don't know if you received my last mail about ide-2.4.19-p7.all.convert.6.
I encountered two problems with it (even with convert.7) :
  - it doesn't compile on alpha because of a typo (fix attached)
  - when the IDE chipset is an ALI M5229, the floppy cannot get its resources.
Although the first one was trivial, it took me about a day to find that a
piece of patch to arch/i386/pci-pc.c disabled a resource fixup in 
pci_fixup_ide_bases() if the pci function was not 1. The fact is that my
notebook, my k6 server and even an alpha server (with the same chipset) use
this chipset with a pci function 0, but all my other systems have their IDE
controller at 1. So it seems particular to that chipset anyway, but I don't
know for others (tested only sis, via and amd).

I don't know what this test was intended for, but after removing it,
everything's OK again. So I attach it here for those who also have trouble
getting their floppy to work with certain IDE chipset after applying your IDE
patch. Except for this, the rest of your patch seems to work well on several
systems.

Cheers,
Willy

>>>>> compile fix for alpha
--- ./include/asm-alpha/system.h-orig	Sun Apr 28 20:16:55 2002
+++ ./include/asm-alpha/system.h	Sun Apr 28 20:18:34 2002
@@ -309,7 +309,7 @@
 #define __sti()			do { barrier(); setipl(IPL_MIN); } while(0)
 #define __save_flags(flags)	((flags) = rdps())
 #define __save_and_cli(flags)	do { (flags) = swpipl(IPL_MAX); barrier(); } while(0)
-#define __save_and_sti(flags)	do { (flags) = setipl(IPL_MIN); barrier(); } while(0)
+#define __save_and_sti(flags)	do { (flags) = swpipl(IPL_MIN); barrier(); } while(0)
 #define __restore_flags(flags)	do { barrier(); setipl(flags); barrier(); } while(0)
 
 #define local_irq_save(flags)		__save_and_cli(flags)



>>>> fix for floppy
--- linux-2.4.19-p7/arch/i386/kernel/pci-pc.c	Sat Apr 20 01:21:17 2002
+++ linux-2.4.19-p7-pristine/arch/i386/kernel/pci-pc.c	Tue Apr 16 03:14:15 2002
@@ -1143,12 +1143,6 @@
 	 */
 	if ((d->class >> 8) != PCI_CLASS_STORAGE_IDE)
 		return;
-	/*
-	 * PCI IDE controllers who are not function 1 off the south bridge
-	 * need to be skipped.
-	 */
-	if (!(PCI_FUNC(d->devfn) & 1))
-		return;
 	DBG("PCI: IDE base address fixup for %s\n", d->slot_name);
 	for(i=0; i<4; i++) {
 		struct resource *r = &d->resource[i];


>>>>> lspci -vvv with ALI M5229 before second patch
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20) (prog-if fa)
        Subsystem: Acer Laboratories Inc. [ALi] M5229 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 01f0 [size=16]
        Region 1: I/O ports at 03f4 [size=4]
        Region 2: I/O ports at 0170 [size=16]
        Region 3: I/O ports at 0374 [size=4]
        Region 4: I/O ports at fcf0 [size=16]



>>>>> lspci -vvv with ALI M5229 after second patch
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20) (prog-if fa)
        Subsystem: Acer Laboratories Inc. [ALi] M5229 IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 01f0 [size=16]
        Region 1: I/O ports at 03f4
        Region 2: I/O ports at 0170 [size=16]
        Region 3: I/O ports at 0374
        Region 4: I/O ports at fcf0 [size=16]

