Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312054AbSCQPfQ>; Sun, 17 Mar 2002 10:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312051AbSCQPfH>; Sun, 17 Mar 2002 10:35:07 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:34741 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S312050AbSCQPe7>; Sun, 17 Mar 2002 10:34:59 -0500
From: Marion Steiner <msteiner@rbg.informatik.tu-darmstadt.de>
Message-Id: <200203171439.g2HEdwX00738@orion.steiner.local>
Subject: SCSI-Problem with AM53C974
To: linux-kernel@vger.kernel.org
Date: Sun, 17 Mar 2002 15:39:58 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There is a problem with the AM53C974 Scsi-driver (Revision 0.5, 
kernel 2.4.x) and the DawiControl DC-2974.

The driver finds an AM53C97 based Scsi-Board but it can't initialise it and
so hangs the computer. Here what's written in /var/log/messages while trying
to modprobe AM53C97:

Mar 17 14:12:55 orion kernel: PCI: Found IRQ 15 for device 00:0a.0
Mar 17 14:12:55 orion kernel: PCI: Sharing IRQ 15 with 00:07.5
Mar 17 14:12:55 orion kernel: scsi1 : AM53/79C974 PCscsi driver rev. 0.5;
host I/O address: 0xc000; irq: 15
Mar 17 14:12:55 orion kernel: 
Mar 17 14:12:55 orion kernel: DC390: Suc. op/ Serv. req: pActiveDCB = 0!
Mar 17 14:12:59 orion /usr/sbin/gpm[258]: Error in protocol
Mar 17 14:12:59 orion last message repeated 12 times
Mar 17 14:13:01 orion kernel: scsi : aborting command due to timeout : pid
123, scsi1, channel 0, id 0, lun 0 Inquiry 00 0
Mar 17 14:13:03 orion kernel: SCSI host 1 abort (pid 123) timed out -
resetting
Mar 17 14:13:03 orion kernel: SCSI bus is being reset for host 1 channel 0.
Mar 17 14:13:03 orion kernel: AM53C974_reset called
Mar 17 14:13:03 orion kernel: AM53C974 register dump:
Mar 17 14:13:03 orion kernel: IO base: 0xc000; CTCREG: 0x120000; CMDREG:
0x45; STATREG: 0x00; ISREG: 0xc0
Mar 17 14:13:03 orion kernel: CFIREG: 0x00; CNTLREG1-4: 0x57; 0x40; 0x18;
0x44
Mar 17 14:13:03 orion kernel: DMACMD: 0x80; DMASTC: 0x0800; DMASPA:
0x14f5c000
Mar 17 14:13:03 orion kernel: DMAWBC: 0x0000; DMAWAC: 0x14f5c800; DMASTATUS:
0x00
Mar 17 14:13:03 orion kernel:
---------------------------------------------------------
Mar 17 14:13:03 orion kernel: DC390: Suc. op/ Serv. req: pActiveDCB = 0!
Mar 17 14:13:11 orion kernel: SCSI host 1 abort (pid 125) timed out -
resetting
Mar 17 14:13:11 orion kernel: SCSI bus is being reset for host 1 channel 0.
Mar 17 14:13:11 orion kernel: AM53C974_reset called
Mar 17 14:13:11 orion kernel: AM53C974 register dump:
Mar 17 14:13:11 orion kernel: IO base: 0xc000; CTCREG: 0x120000; CMDREG:
0x45; STATREG: 0x00; ISREG: 0xc0
Mar 17 14:13:11 orion kernel: CFIREG: 0x00; CNTLREG1-4: 0x57; 0x40; 0x18;
0x44
Mar 17 14:13:11 orion kernel: DMACMD: 0x80; DMASTC: 0x0800; DMASPA:
0x14f5c000
Mar 17 14:13:11 orion kernel: DMAWBC: 0x0000; DMAWAC: 0x14f5c800; DMASTATUS:
0x00
Mar 17 14:13:11 orion kernel:
---------------------------------------------------------
Mar 17 14:13:11 orion kernel: DC390: Suc. op/ Serv. req: pActiveDCB = 0!


This repeats every 8 Seconds and can only be stoped by rebooting, because
modprobe enters D state. But even a proper reboot is not possible,
it hangs while 'Shutting down NFS', the disks aren't cleanly unmounted.

And there is another thing: I've only got 1 Scsi-Board, but the AM53C97 is
the second driver trying to use it. The first is the tmscsim which works
well. But the AM53C974 doesn't care if the board is already in use.

This is how the drivers try to find a board:
tcscsim: PCI_FIND_DEVICE (PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD53C974)
AM53C97: pci_find_device(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_SCSI, pdev)



That's what 'lspci -vvv' says about the DC-2974:
00:0a.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974
[PCscsi] (rev 10)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping+ SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 70 (1000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at c000 [size=128]
        Expansion ROM at <unassigned> [disabled] [size=64K]


'cat /proc/scsi/scsi': 
Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-40TS   Rev: 1.10
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: FUJITSU  Model: MCE3064SS        Rev: 0030
  Type:   Optical Device                   ANSI SCSI revision: 02


'cat /proc/scsi/tmscsim/0': 
Tekram DC390/AM53C974 PCI SCSI Host Adapter, Driver Version 2.0f 2000-12-20
SCSI Host Nr 0, AM53C974 Adapter Nr 0
IOPortBase 0xc000, IRQ 15
MaxID 7, MaxLUN 1, AdapterID 7, SelTimeout 250 ms, DelayReset 1 s
TagMaxNum 16, Status 0x00, ACBFlag 0x00, GlitchEater 24 ns
Statistics: Cmnds 13, Cmnds not sent directly 0, Out of SRB conds 0
            Lost arbitrations 0, Sel. connected 0, Connected: No
Nr of attached devices: 2, Nr of DCBs: 2
Map of attached LUNs: 00 00 01 01 00 00 00 00
Idx ID LUN Prty Sync DsCn SndS TagQ NegoPeriod SyncSpeed SyncOffs MaxCmd
00  02  00  Yes  Yes  Yes  Yes  No    100 ns    10.0 M      15      01
01  03  00  Yes  No   Yes  Yes  No   (100 ns)                       01
Commands in Queues: Query: 0:


And the problem occurs with every distribution, it is not possible to boot
any CD which uses autoprobing for modules.

CU
Marion Steiner
