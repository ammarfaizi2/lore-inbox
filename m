Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264103AbUFFUUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUFFUUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 16:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUFFUUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 16:20:47 -0400
Received: from wl-193.226.227-253-szolnok.dunaweb.hu ([193.226.227.253]:10425
	"EHLO szolnok.dunaweb.hu") by vger.kernel.org with ESMTP
	id S264103AbUFFUUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 16:20:43 -0400
Message-ID: <40C37C99.1050103@freemail.hu>
Date: Sun, 06 Jun 2004 22:20:41 +0200
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en-US
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DEC 2104x driver confusion with 2.6.5+
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this afternoon I installed FC2 on an old Pentium 166MMX
machine that serves as a firewall. I installed RH9 on this
same machine about 18 month ago, the hard disk died 3 days ago.

The machine has two identical network card:

# lspci
00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
00:0e.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] 
(rev 54)
00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
  Tulip Pass 3] (rev 11)
00:10.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
[Tulip Pass 3] (rev 11)
[root@localhost root]# lspci -n -vvv -s 00:0f.0
00:0f.0 Class 0200: 1011:0014 (rev 11)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 96
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at fc00
         Region 1: Memory at fedffc00 (32-bit, non-prefetchable) [size=128]
[root@localhost root]# lspci -n -vvv -s 00:10.0
00:10.0 Class 0200: 1011:0014 (rev 11)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 96
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at f880
         Region 1: Memory at fedff800 (32-bit, non-prefetchable) [size=128]

There are two problems, the first one is that the OS thinks
that "tulip.ko" drives the card but it doesn't.
The same "tulip.o" driver in RH9 (2.4.x) handled this well,
although I had to manually give the media type since autosense
did not work.

The second problem is that "de2104x.ko" recognizes the cards
but autosense does not work, either, and one of the card
shares its interrupt (IRQ 11) with the onboard USB host.
The host is flooded with interrupts on IRQ 11 after I load
de2104x and after some minutes, the kernel disables this IRQ, 
occasionally I got a lockup, too.

Fortunately, there is a third driver, "de4x5.ko", which
can drive these, but only after I do a "modprobe de2104x ;
rmmod de2104x". Without this, after a clean boot into single
mode "modprobe de4x5" does not emit any messages.

I finally put

alias eth0 de4x5
alias eth1 de4x5

into /etc/modprobe.conf and modified /etc/rc.d/init.d/network
so it pulls in and removes de2104x before doing anything.

I have now these in dmesg:

...
de2104x PCI Ethernet driver v0.7 (Mar 17, 2004)
PCI: Enabling device 0000:00:0f.0 (0004 -> 0007)
de0: SROM leaf offset 30, default media 10baseT auto
de0:   media block #0: 10baseT-FD
de0:   media block #1: BNC
de0:   media block #2: 10baseT-HD
divert: allocating divert_blk for eth0
eth0: 21041 at 0xd0843c00, 00:e0:29:09:84:99, IRQ 10
PCI: Enabling device 0000:00:10.0 (0004 -> 0007)
de1: SROM leaf offset 30, default media 10baseT auto
de1:   media block #0: 10baseT-FD
de1:   media block #1: BNC
de1:   media block #2: 10baseT-HD
divert: allocating divert_blk for eth1
eth1: 21041 at 0xd08a9800, 00:e0:29:09:84:ab, IRQ 11
divert: freeing divert_blk for eth0
divert: freeing divert_blk for eth1
0000:00:0f.0: DC21041 at 0xfc00, h/w address 00:e0:29:09:84:99,
       and requires IRQ10 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
divert: allocating divert_blk for eth0
0000:00:10.0: DC21041 at 0xf880, h/w address 00:e0:29:09:84:ab,
       and requires IRQ11 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
divert: allocating divert_blk for eth1
eth0: media is TP.
eth1: media is TP.
...

Hence the subject is driver confusion, I though it worth reporting. :-)

Best regards,
Zoltán Böszörményi

