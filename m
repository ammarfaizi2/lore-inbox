Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267726AbSLTFWw>; Fri, 20 Dec 2002 00:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267727AbSLTFWw>; Fri, 20 Dec 2002 00:22:52 -0500
Received: from sabre.velocet.net ([216.138.209.205]:24072 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S267726AbSLTFWt>;
	Fri, 20 Dec 2002 00:22:49 -0500
To: linux-kernel@vger.kernel.org
Subject: read blocking for really long time on /dev/scd?
From: Gregory Stark <gsstark@mit.edu>
Date: 20 Dec 2002 00:30:48 -0500
Message-ID: <87of7h1cl3.fsf@stark.dyndns.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having a problem with ogle glitching. It seems what's happening is it
isn't able to read data from the dvd fast enough to feed the decoder.
Sometimes read system calls block for seconds at a time. That doesn't seem
normal.

In the following straces fd 3 is /dev/scd1. I'm using an ide dvd-rom with
ide-scsi. DMA is enabled on the ide device.

Most read calls return in about 26us. But a significant chunk seem to take up
to 150ms to return. Those slow reads don't cause ogle any problem but they
seem to indicate a problem already. But every now and then a read will hang
for a really long time, I've seen as much as 10s. 

Here's an example that was correlated with a glitch in video playback:

read(3, "\0\0\1\272D\0-C6E\1\211\303\370\0\0\1\340\7\354\221\300"..., 288768) = 288768 <2.747268>


My question is I guess: Do other people observe the same issue? Is it
expected? What is the path from the read syscall through the ide-scsi layer to
the ide driver that the read syscall is waiting on? How do I go about tracking
down where in the scd or atapi ide driver this hang is happening?



Background info:

This is a custom build from pristine source from linux.kernel.org:

bash-2.05b# uname -a
Linux stark.dyndns.tv 2.4.19 #6 Tue Sep 10 22:08:51 EDT 2002 i686 unknown unknown GNU/Linux


bash-2.05b# hdparm /dev/hdd
/dev/hdd:
 HDIO_GET_MULTCOUNT failed: Input/output error
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 BLKRAGET failed: Input/output error
 HDIO_GETGEO failed: Invalid argument

bash-2.05b# hdparm -i /dev/hdd
/dev/hdd:

 Model=LG DVD-ROM DRD-8160B, FwRev=1.01, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:150}
 PIO modes:  pio0 pio1 pio2 pio3 pio4 
 DMA modes:  sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 
 UDMA modes: udma0 udma1 *udma2 
 AdvancedPM=no

Here are the modules loaded, however I have tested this problem with a fresh
reboot with hardly any of these modules loaded and the problem definitely
still occurs. I had openafs, pcmcia, parport, mga, agpgar, pppoe all unloaded.


bash-2.05b# lsmod
Module                  Size  Used by    Tainted: PF 
sr_mod                 12304   4  (autoclean)
openafs               403712   2 
pcmcia_core            39872   0 
serial                 50884   0  (autoclean)
isa-pnp                28708   0  (autoclean) [serial]
parport_pc             25288   1  (autoclean)
lp                      6432   0  (autoclean)
parport                25024   1  (autoclean) [parport_pc lp]
mga_vid                 7800   0 
mga                    98104   3 
agpgart                16552   3 
ide-scsi                7632   2 
scsi_mod               51356   2  [sr_mod ide-scsi]
pppoe                   6924   2 
pppox                   1128   1  [pppoe]
ppp_generic            16416   3  [pppoe pppox]
slhc                    4480   0  [ppp_generic]
ne2k-pci                4800   1 
8390                    5968   0  [ne2k-pci]
rtc                     5916   0  (autoclean)




-- 
greg

