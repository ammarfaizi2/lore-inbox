Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBLJc7>; Mon, 12 Feb 2001 04:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbRBLJct>; Mon, 12 Feb 2001 04:32:49 -0500
Received: from mpoli.fi ([62.236.132.1]:42501 "EHLO mpoli.fi")
	by vger.kernel.org with ESMTP id <S129031AbRBLJcn>;
	Mon, 12 Feb 2001 04:32:43 -0500
Date: Mon, 12 Feb 2001 11:27:52 +0200
From: Olli Lounela <olli@mpoli.fi>
To: linux-kernel@vger.kernel.org
Subject: Mylex dac960 not SMP-safe?
Message-ID: <20010212112752.A13228@mpoli.fi>
Reply-To: olli@mpoli.fi
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii

Hi all!

I'm having mucho trouble trying to run any kind of kernel in the following
hardware:

    - Intel PR440FX, latest BIOS (1.00.09DI)
    - 2 * Intel PPro/200, stepping 09
    - Onboard Intel eepro100/B with 82557, driver in 2.2.18 reports 
      assembly 645520-034
    - Onboard Adaptec 7880
    - Mylex AcceleRAID 250 (code DACPTLM-1), 8 MB ECC cache SIMM.
    - 3 * IBM DNES-309170 9 GB LVD-SCSI disks in RAID-5 setup (Mylex
      recognizes them as LVD)

Basically, there's something there that just locks the machine up.

Apparently the keyboard controller is peculiar, or else any of the keyboards
I have access to can't produce SysRQ, since SysRQ key just produces four raw
scancodes, not one, and the documentation doesn't say how to handle this
case. I'd be much happier to force an OOPS and add the trace here.

The main idea is to boot from the dac960, and remove any old disks still
attached to the aic7880. The dac960 is in a butmastering slot, and I did try
removing the busmastering jumper. Main memory is ECC, and has been swapped
(the SIMMs available are 64 MB and 128 MB, one each).

Symptoms with booting 2.4-kernels from dac960

  - Booting with SMP

    * Both 2.4.1-ac9 and 2.4.2-pre3 hang at dac960 initialization

  - Booting SMP-compiled kernel with nosmp option

    * dac960 gets initialized, but the builtin eepro/100b hangs at once

Nothing is produced in the log, and the machine just stops. To me it looks
like a deadlock. Getting the machine to react in any way requires hardware
reset. Softdog doesn't react, so apparently the kernel is still running, to
a degree at least.

With newer 2.2-kernels (like 2.2.19pre9) the machine works for a while, and
then hangs at random, apparently from network traffic. This also occurs with
stock RedHat 2.2.16-3.

The machine has formerly run linux faultlessly for a long time (years),
without the dac960. It's pretty hard to find out the kernel version for sure,
but apparently 2.2.14 has worked from 10 March 2000 till Dec 2000.
Accordingly, while the dac960 card itself may be the culprit, I strongly
suspect the dac960 driver is not SMP-safe.

Booting from aic7880, the system works with 2.2.18 kernel (with dac960
driver), and I can compile kernel with 'make -j 20', but the machine still
hangs in a few minutes if I try to simultaneously fetch 2.4.1 from mirror.
The latter hanged the even with RH 2.2.16-3 (2.2.19pre9 was a bit better but
did the same). What with the dismaying results above, I haven't tested
2.4-kernels booting from the aic7880.

With most any 2.2-kernel, when booting with nosmp or UP-compiled kernel I
seem to be able fetch and compile a new kernel. Booting 2.2.14-SMP without
dac960 driver, fetching 2.4.1 while compiling kernel with -j15 did not hang
the machine.

Apparently there's some strange interaction with SMP PPro and eepro100/B and
dac960 drivers. I'm a bit at a loss on how to approach the problem, any help
will be appreciated.

lspci -vvvxx attached.

Oh, and I read the list from a www-archive, so please CC me.

-- 
    Olli               ...and he thought I'm serious! Hahahaha...

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0 set
00: 86 80 37 12 06 01 80 22 02 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:06.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 56 max, 72 set
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ffbe6000 (32-bit, prefetchable)
	Region 1: I/O ports at ff40
	Region 2: Memory at fef00000 (32-bit, non-prefetchable)
00: 86 80 29 12 07 01 80 02 01 00 00 02 00 48 00 00
10: 08 60 be ff 41 ff 00 00 00 00 f0 fe 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 08 38

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
00: 86 80 00 70 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Region 4: I/O ports at ffa0
00: 86 80 10 70 05 00 80 02 00 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: a1 ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 SCSI storage controller: Adaptec AIC-7880U
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 8 max, 72 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at fc00
	Region 1: Memory at ffbe7000 (32-bit, non-prefetchable)
00: 04 90 78 80 07 00 80 02 00 00 00 01 08 48 00 00
10: 01 fc 00 00 00 70 be ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 08 08

00:0b.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ff000000 (32-bit, non-prefetchable)
00: 33 53 11 88 03 00 00 02 00 00 00 03 00 00 00 00
10: 00 00 00 ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00

00:11.0 PCI bridge: Intel Corporation 80960RP [i960 RP Microprocessor/Bridge] (rev 05) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set, cache line size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: ff900000-ff9fffff
	Prefetchable memory behind bridge: ff800000-ff8fffff
	BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: 86 80 60 09 06 00 80 02 05 00 04 06 08 00 81 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 f0 00 80 22
20: 90 ff 90 ff 80 ff 80 ff 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 03 00

00:11.1 RAID bus controller: Mylex Corporation DAC960PX (rev 05)
	Subsystem: Mylex Corporation: Unknown device 0010
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fe000000 (32-bit, prefetchable)
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 69 10 10 00 16 00 90 22 05 00 04 01 08 20 80 00
10: 08 00 00 fe 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 69 10 10 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 01 00 00


--k1lZvvs/B4yU6o8G--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
