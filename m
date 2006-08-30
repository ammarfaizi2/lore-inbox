Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965185AbWH3AMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185AbWH3AMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 20:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965180AbWH3AMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 20:12:31 -0400
Received: from mxsf31.cluster1.charter.net ([209.225.28.130]:2243 "EHLO
	mxsf31.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S965178AbWH3AMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 20:12:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17652.55275.556545.19616@smtp.charter.net>
Date: Tue, 29 Aug 2006 20:12:27 -0400
From: "John Stoffel" <john@stoffel.org>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: 2.6.18-rc5 - HPT302 wierdness
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I've got a Rocket 133 PCI dual channel controller in my dual CPU PIII
Xeon box, with 768 Mb of ram, and a pair of 120gb WD HDs hung off the
HPT302, each on it's own channel.  According to lspci, it's a version
1 of the controller.  I just upgraded it to 1.22 of the firmware, but
that was a debacle and it's now back down to it's original 1.21 that
it shipped with.  *grin*

   03:06.0 RAID bus controller: Triones Technologies, Inc. HPT302/302N (rev 01)
	   Subsystem: Triones Technologies, Inc. Unknown device 0001
	   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	   Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	   Latency: 120 (2000ns min, 2000ns max)
	   Interrupt: pin A routed to IRQ 18
	   Region 0: I/O ports at ecf8 [size=8]
	   Region 1: I/O ports at ecf0 [size=4]
	   Region 2: I/O ports at ece0 [size=8]
	   Region 3: I/O ports at ecd8 [size=4]
	   Region 4: I/O ports at e800 [size=256]
	   Expansion ROM at f9000000 [disabled by cmd] [size=128K]
	   Capabilities: [60] Power Management version 2
		   Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		   Status: D0 PME-Enable- DSel=0 DScale=0 PME-


The drives are identical, and bought at the same time, yet on bootup
of 2.6.18-rc5, they show up with different values for CHS and for Max
Request Size.

  HPT302: IDE controller at PCI slot 0000:03:06.0
  ACPI: PCI Interrupt 0000:03:06.0[A] -> GSI 18 (level, low) -> IRQ 18
  HPT302: chipset revision 1
  HPT302: 100% native mode on irq 18
  HPT37X: using 33MHz PCI clock
      ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
  HPT37X: using 33MHz PCI clock
      ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:DMA, hdh:pio
  Probing IDE interface ide2...
  hde: WDC WD1200JB-00CRA1, ATA DISK drive
  ide2 at 0xecf8-0xecff,0xecf2 on irq 18
  Probing IDE interface ide3...
  hdg: WDC WD1200JB-00EVA0, ATA DISK drive
  ide3 at 0xece0-0xece7,0xecda on irq 18
  Probing IDE interface ide1...
  hde: max request size: 128KiB
  hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=65535/16/63, UDMA(100)
  hde: cache flushes not supported
   hde: hde1
  hdg: max request size: 512KiB
  hdg: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
  hdg: cache flushes supported
   hdg: hdg1


And even when looking at the details in
/sys/block/hd[eg]/queue/max_hw_sectors_kb and
/sys/block/hd[eg]/queue/max_sectors_kb I see that the numbers are
different.  Is this a bug in the chip, or a known issue with the
controller?  

    > cat /sys/block/hde/queue/max_sectors_kb
    128
    > cat /sys/block/hde/queue/max_hw_sectors_kb
    128

    > cat /sys/block/hdg/queue/max_sectors_kb
    512
    > cat /sys/block/hdg/queue/max_hw_sectors_kb
    1024

Or could it be because the drives have different firmware revisions,
as shown by hdparm -I?  

    # hdparm -I /dev/hde

    /dev/hde:

    ATA device, with non-removable media
	    Model Number:       WDC WD1200JB-00CRA1                     
	    Serial Number:      WD-WMA8C4365875
	    Firmware Revision:  17.07W17
    Standards:
	    Supported: 5 4 3 
	    Likely used: 6
    Configuration:
	    Logical         max     current
	    cylinders       16383   16383
	    heads           16      16
	    sectors/track   63      63
	    --
	    CHS current addressable sectors:   16514064
	    LBA    user addressable sectors:  234441648
	    device size with M = 1024*1024:      114473 MBytes
	    device size with M = 1000*1000:      120034 MBytes (120 GB)
    Capabilities:
	    LBA, IORDY(can be disabled)
	    bytes avail on r/w long: 40
	    Standby timer values: spec'd by Standard, with device specific minimum
	    R/W multiple sector transfer: Max = 16  Current = 16
	    Recommended acoustic management value: 128, current value: 254
	    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
		 Cycle time: min=120ns recommended=120ns
	    PIO: pio0 pio1 pio2 pio3 pio4 
		 Cycle time: no flow control=120ns  IORDY flow control=120ns
    Commands/features:
	    Enabled Supported:
	       *    SMART feature set
		    Security Mode feature set
	       *    Power Management feature set
	       *    Write cache
	       *    Look-ahead
	       *    Host Protected Area feature set
	       *    WRITE_BUFFER command
	       *    READ_BUFFER command
	       *    DOWNLOAD_MICROCODE
		    SET_MAX security extension
		    Automatic Acoustic Management feature set
	       *    Device Configuration Overlay feature set
	       *    SMART error logging
	       *    SMART self-test
    Security: 
		    supported
	    not     enabled
	    not     locked
	    not     frozen
	    not     expired: security count
	    not     supported: enhanced erase
    HW reset results:
	    CBLID- above Vih
	    Device num = 0 determined by the jumper
    Checksum: correct



    # hdparm -I /dev/hdg

    /dev/hdg:

    ATA device, with non-removable media
	    Model Number:       WDC WD1200JB-00EVA0                     
	    Serial Number:      WD-WMAEK2844058
	    Firmware Revision:  15.05R15
    Standards:
	    Supported: 6 5 4 
	    Likely used: 6
    Configuration:
	    Logical         max     current
	    cylinders       16383   65535
	    heads           16      1
	    sectors/track   63      63
	    --
	    CHS current addressable sectors:    4128705
	    LBA    user addressable sectors:  234441648
	    LBA48  user addressable sectors:  234441648
	    device size with M = 1024*1024:      114473 MBytes
	    device size with M = 1000*1000:      120034 MBytes (120 GB)
    Capabilities:
	    LBA, IORDY(can be disabled)
	    Standby timer values: spec'd by Standard, with device specific minimum
	    R/W multiple sector transfer: Max = 16  Current = 16
	    Recommended acoustic management value: 128, current value: 254
	    DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
		 Cycle time: min=120ns recommended=120ns
	    PIO: pio0 pio1 pio2 pio3 pio4 
		 Cycle time: no flow control=120ns  IORDY flow control=120ns
    Commands/features:
	    Enabled Supported:
	       *    SMART feature set
		    Security Mode feature set
	       *    Power Management feature set
	       *    Write cache
	       *    Look-ahead
	       *    Host Protected Area feature set
	       *    WRITE_BUFFER command
	       *    READ_BUFFER command
	       *    DOWNLOAD_MICROCODE
		    SET_MAX security extension
		    Automatic Acoustic Management feature set
	       *    48-bit Address feature set
	       *    Device Configuration Overlay feature set
	       *    Mandatory FLUSH_CACHE
	       *    FLUSH_CACHE_EXT
	       *    SMART error logging
	       *    SMART self-test
    Security: 
		    supported
	    not     enabled
	    not     locked
	    not     frozen
	    not     expired: security count
	    not     supported: enhanced erase
    HW reset results:
	    CBLID- above Vih
	    Device num = 0 determined by CSEL
    Checksum: correct


Thanks,
John
