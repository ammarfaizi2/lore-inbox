Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261941AbTCQUcx>; Mon, 17 Mar 2003 15:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbTCQUcx>; Mon, 17 Mar 2003 15:32:53 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:37297 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261941AbTCQUcs>; Mon, 17 Mar 2003 15:32:48 -0500
Date: Mon, 17 Mar 2003 19:26:25 +0100
From: Henning Schroeder <schroeder@psychologie.uni-wuerzburg.de>
X-Mailer: The Bat! (v1.61)
Reply-To: Henning Schroeder <schroeder@psychologie.uni-wuerzburg.de>
Organization: =?ISO-8859-15?B?VW5pdmVyc2l05HQgV/xyemJ1cmcsIEluc3RpdHV0IGb8ciBQc3ljaG9s?=
	=?ISO-8859-15?B?b2dpZQ==?=
X-Priority: 3 (Normal)
Message-ID: <52531372122.20030317192625@psychologie.uni-wuerzburg.de>
To: linux-kernel@vger.kernel.org
Subject: Highpoint HPT372N not supported by 2.4.20?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i recently bought a Tyan Trinity KT400 S2495 mainboard. (more info at
http://www.tyan.com/products/html/trinitykt400.html). It has an
onboard Highpoint RAID controller labelled "Highpoint HPT372N
0236K41N". To my surprise, Kernel 2.4.21-pre5 does not support this
chip. The relevant driver, linux/drivers/ide/pci/hpt366.c, does
support the HPT372, though.

Looking through the Highpoint Web Site, I found a downloadable
opensource driver (at
http://www.highpoint-tech.com/372drivers_down.htm). The revision
history said that starting with v1.31 (21Dec2002), the HPT372N IC is
supported. Great.

I downloaded, compiled and insmod'ed the driver
(http://www.highpoint-tech.com/hpt3xx-opensource-v131.tgz), which
failed. I then checked the PCI IDS and to my very surprise, the PCI ID
from my chip (1103:0009) does not match the one required by the
Highpoint driver.

Doing further research, nobody seems to know anything about the
1103:0009. I finally submitted the description myself to the Linux PCI
ID Repository (http://pciids.sourceforge.net/).

So i changed the highpoint driver to detect the HPT372N on my
motherboard (see diff below) and it finally works.

I don't like that solution very much, though, because the highpoint
driver uses the scsi subsystem. Looking through highpoints hpt.c file
I could not find very much differences in the way the HPT372N is
accessed from the HPT372-way. Maybe somebody (Andre Hedrick?) could
look through the code and integrate the HPT372N into
drivers/ide/pci/hpt366.c? This feat is regrettably way beyound
my own programming capability.

I still wonder whether the HPT372N really is so new that it is not yet
listed anywhere. (It is even hard to find on the Highpoint Website).
And I wonder what the difference between HPT372N and HPT372 is.

I would love to hear about the current status of that chip. I do not
need the RAID capability, just the extra IDE ports.

Thank you for your time.

Henning

~~~ lspci output (cropped) ~~~~~~~~~~~~~~~~~~~
00:0e.0 RAID bus controller: Triones Technologies, Inc.: Unknown device 0009 (rev 01)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at c400 [size=8]
        Region 1: I/O ports at c800 [size=4]
        Region 2: I/O ports at cc00 [size=8]
        Region 3: I/O ports at d000 [size=4]
        Region 4: I/O ports at d400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


~~~ cat /proc/pci output (cropped) ~~~~~~~~~~~~~~~~~~~
  Bus  0, device  14, function  0:
    RAID bus controller: PCI device 1103:0009 (Triones Technologies, Inc.) (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=8.
      I/O at 0xc400 [0xc407].
      I/O at 0xc800 [0xc803].
      I/O at 0xcc00 [0xcc07].
      I/O at 0xd000 [0xd003].
      I/O at 0xd400 [0xd4ff].

~~~ highpoint driver diff ~~~~~~~~~~~~~~~~~~~
diff -u hpt3xx-opensource-v131/hpt.c hpt3xx-opensource-v131-new/hpt.c
--- hpt3xx-opensource-v131/hpt.c        Tue Dec 24 02:45:16 2002
+++ hpt3xx-opensource-v131-new/hpt.c    Mon Mar 17 01:07:53 2003
@@ -4571,6 +4571,20 @@
                if (hpt3xx_init(pAdap, pPciDev)==0)
                        hpt_adapters[NumAdapters++] = pAdap;
        }
+       /*
+        * search for HPT372N chip
+        */
+       pPciDev = NULL;
+       while ((pPciDev=pci_find_device(HPT372N_VENDORID, HPT372N_DEVICEID, pPciDev))){
+               if (NumAdapters>=MAX_ADAPTERS) break;
+               pAdap = (PHPT_ADAPTER)GLOBAL_DATA_ALLOC(sizeof(HPT_ADAPTER));
+               pci_read_config_byte(pPciDev, REG_RID, &rev);
+               pAdap->chip_type = CHIP_TYPE_HPT372N;
+               pAdap->name = CONTROLLER_NAME_HPT372N;
+               pAdap->num_buses = 2;
+               if (hpt3xx_init(pAdap, pPciDev)==0)
+                       hpt_adapters[NumAdapters++] = pAdap;
+       }

        if (NumAdapters) {
                /*
diff -u hpt3xx-opensource-v131/hptglb.h hpt3xx-opensource-v131-new/hptglb.h
--- hpt3xx-opensource-v131/hptglb.h     Mon Dec  9 04:18:42 2002
+++ hpt3xx-opensource-v131-new/hptglb.h Mon Mar 17 01:08:35 2003
@@ -676,6 +676,8 @@
 #define HPT370_DEVICEID 0x0004
 #define HPT372A_VENDORID 0x1103
 #define HPT372A_DEVICEID 0x0005
+#define HPT372N_VENDORID 0x1103
+#define HPT372N_DEVICEID 0x0009

 /*
  * 370-370A timing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
Henning Schroeder, Dipl.-Psych.
mailto:schroeder@psychologie.uni-wuerzburg.de

