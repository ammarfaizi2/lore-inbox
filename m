Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263473AbUJ3DwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263473AbUJ3DwM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbUJ3DvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:51:12 -0400
Received: from nessie.weebeastie.net ([220.233.7.36]:15751 "EHLO
	theirongiant.lochness.weebeastie.net") by vger.kernel.org with ESMTP
	id S263473AbUJ3DtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:49:04 -0400
Date: Sat, 30 Oct 2004 13:47:45 +1000
From: CaT <cat@zip.com.au>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: torvalds@osdl.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: PDC20267 bug and corruption (was: Re: [BK PATCHES] ide-2.6 update)
Message-ID: <20041030034745.GA1287@zip.com.au>
References: <58cb370e04102706074c20d6d7@mail.gmail.com> <20041027133431.GF1127@zip.com.au> <58cb370e04102706512283405@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <58cb370e04102706512283405@mail.gmail.com>
Organisation: Furball Inc.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 27, 2004 at 03:51:14PM +0200, Bartlomiej Zolnierkiewicz wrote:
> http://bugme.osdl.org/show_bug.cgi?id=2494

Tried it via bk7, wasn't it. 

Looks like I have found a bug relating to the pdc driver though.

The situation is such: I have 2 HDs connected to a PDC20267 PCI card,
one on each channel, with a master on the primary channel and a slave on
the secondry channel. Accessing each drive individually causes no
problems at all but accessing them simultaneously (like copying data off
one drive onto the other) causes the IDE layer to go to hell in a hand
basket. I can duplicate this each and every time by doing the following:

1. copying a few gig from hde to hdh
2. dd if=/dev/hde of=/dev/null
   dd if=/dev/zero of=/dev/hdh

With method #1 I get the following:

Oct 27 00:37:39 nessie kernel: attempt to access beyond end of device
Oct 27 00:37:39 nessie kernel: hdh1: rw=1, want=3034756264, limit=390716802
Oct 27 00:37:40 nessie kernel: Aborting journal on device hdh1.
Oct 27 00:37:40 nessie kernel: ext3_abort called.
Oct 27 00:37:40 nessie kernel: EXT3-fs error (device hdh1): ext3_journal_start: Detected aborted journal
Oct 27 00:37:40 nessie kernel: Remounting filesystem read-only
Oct 27 00:37:40 nessie kernel: EXT3-fs error (device hdh1) in start_transaction: Journal has aborted

With method #2, a whole lot more fun occurs. The logfile I have is big
(almost 400k) so I've compressed it and included it as an attachment.
This is with kernel 2.6.10-rc1-bk7 (no logs survived from me testing
this with rc1-mm2).

My HDs attached are:

/dev/hde:

ATA device, with non-removable media
powers-up in standby; SET FEATURES subcmd spins-up.
	Model Number:       IC35L060AVV207-0                        
	Serial Number:      VNVB01G2RAK8XH
	Firmware Revision:  V22OA63A
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 3a 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	65535
	heads		16	1
	sectors/track	63	63
	--
	CHS current addressable sectors:    4128705
	LBA    user addressable sectors:  120103200
	LBA48  user addressable sectors:  120103200
	device size with M = 1024*1024:       58644 MBytes
	device size with M = 1000*1000:       61492 MBytes (61 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 52	Queue depth: 32
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Advanced power management level: unknown setting (0x0000)
	Recommended acoustic management value: 128, current value: 254
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
		Release interrupt
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
		SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		Automatic Acoustic Management feature set 
		SET MAX security extension
		Address Offset Reserved Area Boot
		SET FEATURES subcommand required to spinup after power up
		Power-Up In Standby feature set
		Advanced Power Management feature set
	   *	READ/WRITE DMA QUEUED
	   *	General Purpose Logging feature set
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
	30min for SECURITY ERASE UNIT. 
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct

/dev/hdh:

ATA device, with non-removable media
	Model Number:       ST3200822A                              
	Serial Number:      3LJ22Y8F
	Firmware Revision:  3.01    
Standards:
	Used: ATA/ATAPI-6 T13 1410D revision 2 
	Supported: 6 5 4 3 
Configuration:
	Logical		max	current
	cylinders	16383	65535
	heads		16	1
	sectors/track	63	63
	--
	CHS current addressable sectors:    4128705
	LBA    user addressable sectors:  268435455
	LBA48  user addressable sectors:  390721968
	device size with M = 1024*1024:      190782 MBytes
	device size with M = 1000*1000:      200049 MBytes (200 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 4	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = 16
	Recommended acoustic management value: 128, current value: 0
	DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
	   *	SMART feature set
	   *	FLUSH CACHE EXT command
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
	   *	48-bit Address feature set 
		SET MAX security extension
	   *	DOWNLOAD MICROCODE cmd
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
		supported
	not	enabled
	not	locked
	not	frozen
	not	expired: security count
	not	supported: enhanced erase
HW reset results:
	CBLID- above Vih
	Device num = 1 determined by CSEL
Checksum: correct


And lspci -vvv output is:

0000:00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 64
	Region 0: Memory at 44000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 40000000-408fffff
	Prefetchable memory behind bridge: 41000000-41ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

0000:00:0d.0 Unknown mass storage controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 10f0 [size=8]
	Region 1: I/O ports at 1800 [size=4]
	Region 2: I/O ports at 10f8 [size=8]
	Region 3: I/O ports at 1804 [size=4]
	Region 4: I/O ports at 1080 [size=64]
	Region 5: Memory at 42000000 (32-bit, non-prefetchable) [size=128K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1000 [size=128]
	Region 1: Memory at 40900000 (32-bit, non-prefetchable) [size=128]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at 42100000 (32-bit, non-prefetchable) [size=256]

0000:00:14.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:14.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 10c0 [size=16]

0000:00:14.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 0
	Region 4: I/O ports at 1820 [disabled] [size=32]

0000:00:14.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G200 AGP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 41000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at 40800000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at 40000000 (32-bit, non-prefetchable) [size=8M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

-- 
    Red herrings strewn hither and yon.

--vtzGhvizbBRQ85DL
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="moo.gz"
Content-Transfer-Encoding: base64

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
4kBDERdIAYQUQEgBlBQANJRjMt0HwMBX28eklA+BgWr2oKEcE3A9AKakAEYKYKQAkRQgkQKQ
huJJQ/GkoXjSUDy5nvlICpBIARIpAPiOiwTSAwLpAYH0gEB6QCA9IJAeEEgPCKQHBNIDAukB
gfSAQHqAkB4gpAcI6QFCbiqE3FQI6U5CupOQ7kSm1UKm1UKm1UKm1UKm1UKm1aKkOynpTkq6
ExnKCxnKCxnKCxnKCxnKCxnKCxnKCxnKC5lWC5lWC5lWC5lWC5lWC5lWC5lWC5lWC5lWl5ca
joSBAkTSnSLpTmTCL2TCL2TCL2TCL2TCL2TCL2TCL2TCL2TCL2TALGTALGTALGTALIn0gEx6
QCY9IJMeQIbyQobyQobyQobyQobyQobyQobyQobyQobySobySgbMSgbMSgbMSgbM6iKpZiIF
SKQAoKEoGcorGcorGcorGcorGcorGcorGcorGcorGcorGcorGcormVYreONcgYFJhXrSnTzp
Tp50J/K4gJLHBZQ8LqDkcQEljwsoeVxAyeMCSh4XUPK4gJLHBZQ8LqDkcQEljwsoeVxAyeMC
Sh4XUDL6VjL6ViENRUhDEdJQyIRfyYRfyYRfyYRfyYRfyYRfyYRfyYRfyYRfyYRfyYRfyYRf
yYRfyYRfyYRfyYRfyYRfyVvIlbyFXMlQXslQXslQXslQXslQXslQXslQXslQXslQXslQXslQ
XslQXslQXslQXslQXslQXslQXslQXslQXslQXslbyJW8hVzJW8iVTPiVTPiVTPiVTPiVTPiV
TPiVTPiVTPiVTPiVTPiVTPiVTPiVTPiVTPiVTPiVTPiVTPiNzNGNzNGNzNGNzNGNzNGNzNGN
zNGNzNGNzNGNzNGNzNGNzNGNzNGNzNGNzNGNzNGNzNGNzNGNvLndyJvbjby53cjjAkam1Uam
1Uam1Uam1Uam1Uam1Uam1Uam1Uam1Uam1Uam1Uam1Uam1Uam1Uam1Uam1Ube3G7kze1G3txu
5M3tRib8RqbVRqbVRqbVRqbVRqbVRqbVRqbVRqbVRqbVRqbVRqbVRqbVRqbVRqbVRqbVRqbV
RqbVRt6PbuT96Ebej27kh8QbmPAL+c7e+OECjoQlEAZ+E4uRX8VikxPl/Zn71e90nI3f6bid
DW+u1tu3t9/yePu1jt2zZ934fcL3Qf0jvlLyVx/1m18pmX7jKyW/ne/nf7kdiftfL/mppzr0
+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
CwlgyjAplCqFUqVQqhRKlUKpUihVCqVKoVQplCqFUqVQqhRKlUKpUihNCqVJoTQplCaF0qRQ
mhRKkw4I6YCQDgjpgJAOCOmAkA4I6YCQDgjpgJAOCOmAkA4I6YAuHdClA7p0QJcO6NIBXTpg
/yeyT8JSAkgJYEgA8iDWpYRTSjhl06Zs2pRNK1fEKlfEKlfEKlfEOmTTDtm0QzbtkE07ZNMO
2bRyE65yE65yE65yE65yE65yE65yE65yq6tyq6tLluOS5bhkOS5ZjkuW45LluGQ5LlmOS5aj
HJirHJirHJibHJibHJibHJibHJibHP6aHP6aHP6aHP6aHP6aHP6aHP5a6RJASgApAQwJYEoA
shzlWNrkWNrkWNrkWNrkiNXkiNXkiNXkiNXkiNXkiNXkiNWaLMcmy7HJcmyyHJssR7kiNrki
NrkiNrkiNrkiNrkiNrkiNrkiNrkiNrkiNrkiNrkiNjkVNTkVNTkVNTkVNTkVNTkVNTkVNTkV
tZRNm7JpUzZtyqZN2bQpmzZl08oVsckVsckVscl5rcl5rcl5rcl5rcl5rcl5rcl5rcl5rcl5
rcl5rcl5rcl5rcl5rcl5rclXLpt85bLJVy6bfOWyyVcum3zlsskVsckVsckVsckVsckVsckV
sckVsckVsckVsckVsckVMeSKGHJFDLkihlwRQ76mGvI11ZCvqYZ8TTXka6oh982Q+2bIfTPk
vhly3wy5b4bcN0PumyH3zZD7Zsh9M+S+GXLfDLlvhnwZNOTLoCFfBg35MmjIl0FDvgwa8mXQ
kC+DhtzRQ+7oIXf0kGNpyLE05FgaciwNOZaGHEtDjqUhx9KQY2nIsTTkWBpyLA05loYcS0O+
chnylcuQr1yGfOUy5CuXIV+5DPnKZcgdPeSOHnJHD7mjh9zRQ+7oIXf0kDt6yB095I4eckcP
uaOH3NFD7ughd/SQO3rIHT3kjh7ybdyQb+OGfBs35OMCIR8XCPm4QMjHBUI+LhD74wLjIGx9
N+zp+f7L6+efb/Oqt9/efurdp7uX28vXp6fntx/cffjpe7/+l68fP949/3UZt8cvf1zI/fu7
P6/l4fHT/ft3D7dfHx7ff75Fi/W9xIfHl9fb09t13H5/vn+9u334end7ffz77/AW7b5K+6Z/
FDZh2GbKk7DNlCdhDX5M903/KEwC6BJASgBDApgSwJQAFgSwv5p9ElYggP2hiqMwCGB/qOIk
LCQAacr9oYqjMAlgOAD9KjIMCqVfUCj9gkLpFxRKv7oEkBLAkACmBDAlACiUXqBQeoFC6QUK
pRcolF6aBBASQJcAUgJICUAKpcLjTq/STlXaqUo7VWmnKu1UpZ2qtFOVdqrSTlXaqUo7NWmn
Ju3UpJ2atFOTdmrSTk3aqUk7NWmnJu20PyJzEBbSASEdENIBIR0Q0gEhHRDSASEdENIBXTqg
Swd06YAuHdClA7p0QJcO6NIBXTog4SDTU55QUp5QUp5QUtoppZ1S2imlnVLaKaWdUtoppZ1S
2mlIOw1ppyHtNKSdhrTTkHbaH12YB2HbrftJ2IJXtj8ucBQ2Ydhmp5OwCgHsjwuchIUEEBJA
lwBSAhgSwJQApgSwIID9cYGTsAIB7I8LHIVBAPvjAidhIQFIOy0olLygUPKCQskLCiUvKJS8
mgQQEkBIAF0CSAlgSABTApgSABRKFiiULFAoWaBQskCh5L5Wn4RNCUA6oEoHVOmAKh1QpQOq
dECVDqjSAVU6oEoHVOmAKh1QpQOqdECTDmjSAU06YB+Yj8IgzSaF0qRQmhRKSKGEFEpIoYQU
SkihhBRKSKGEFEpIoYQUSkihhBRKSKF0KZQuhdKlULo8VPQmAYQE0CUAKeEuJbz/Gwzrx8P2
Uf4kbBPKSdgmlJOwTShHYROGdQkgJYAhAUwJYEoACwLYR/mTsAIB7KP8URgEsI/yJ2EhAXQJ
ICWABa9sH+WPwuBHY0o7TWmnKe00pZ2mtNOUdprSTlPaaUo7TWmnKe20pJ2WtNOSdlrSTkva
aUk7LWmnJe20v8N/EiaPO/t/GOEkDEp4XFDC44ISHheU8LighMfVJAAo4VHg34BR4N+AUeDf
gFHk34Aq/wZU+Tegyr8BVf4NqPJvQJV/A2pIAF0CSAlgSABTApgSALwNHQ3eho4Gb0NHg7eh
o8Hb0NGaBBASQJcAUgKQEm5Swk1KuEkJh5RwSAmHtFNIO4W0U0g7hbRTSDuFtFNIO3Vppy7t
1KWdurRTl3bq0k5d2qlLO3VpJ7kJjy7t1KWdUtpJTpJDTpJDTpJDTpJDTpJDTpJDTpJDTpJD
TpJDTpJDTpJjyD4bss+G7DO5vA65vA65vA65vA65vA65vA65vA65vA65vA65vA65vA65vA65
bw65bw65bw65bw65bw65bw65bw65bw65bw65bw65bw65b065b065b065b065b065b85t3+zX
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
TWmnKe00pZ2mtNOqNAzSXFIoSwplSaHsO/o6CZswbBPKSdgmlJOwTSg/Hjb2fxDgKGzCsJIw
rAYMaxJASAAhAXQJICWABa9sH+VPwgr8aOyj/FEY/Gjso/xJWEgAXQJICSAlgCEBTAlA2qlK
O1VppyrtVKWdqqztKmt7H+VPwqb8aEz50ZB2atJOTdqpSTs1aacm7dSknZq0U5N2atJOTdqp
STs1aaeQ54CQ54CQ54CQQgkplJBCCSmUkEIJKZQuhdKlULoUyjf/VEH8fF0HYX9vjbOwbwbm
0zD4x/xmYD4M+/s97WFYkwBCAggJoEsAKQEMCWBKAFMCWBDAN+/wH4YVCOCbHf00DAL4Zkc/
DAsJoEMAU/bZlH02ZZ9N2WdT9tmUfTZln03ZZ1P22ZJ9tmSfLdlnS/bZkn22ZJ99M0kehsEb
5HnBG+R5wRvkecEb5HnBG+R5NQkgJICQALoEkBLAkACmBDAlACiUWaBQZoFCmQUKZRYolPnN
JHkaJq9syI/GlB8Naacq7VSlnaq0U5V2qtJOVdqpSjtVaacq7VSlnaq0U5V2qtJOTdqpSTu1
Jv+YIf+YXf4xpeqaVF2TqmtSdU2qLqTqQqoupOpCqi6k6kKqLqTqQqoupOpiU1358bC+OeAk
rMgr204oR2EThm12OgkLCaBLACkBpAQwJIApASwIYN/Rj8IggH1HPwmrEMC+o5+EhQQQEkCX
ABYMG1IoQwplSKEMKZQhhTKkUIYUypBCGVIoQwplSKEMKZQphTKlUKYUypRCmVIoUwplSqFM
KZT9QYaDsCVre8naXrK2l6ztJWt7ydpesraXrO0la3vB2l4XrO11wdpeF6ztdcHaXleTAEIC
CAlgyiub8srgoWIVeKhYBR4qVoF2WgXaaZUmAYQE0CWAlABSAhgSwJQApJ2qtFOVdqrSTlXa
qUo7VemAKh1QpQOadECTDmjSAU06oEkHNOmAJh3QpAOadECTDmjSAU06IKQDQjogpAP2Hb0e
hG0z7hb29Hz/5fXzz3+85nD77e2n3n26e7m9fH16en77wd2Hn77363/5+vHj3fNfl3F7/PLH
hdy/v/vzWh4eP92/f/dw+/Xh8f3nW+73GFviw+PL6+3p7Tpuvz/fv97dPny9u70+/v13eIuG
X6VNbkdhE4ZtcjsI22f4k7BSYVi9ZBgEsM/wJ2EhAXQJICWAlACGBDAlgAUB7DP8URgEkNJH
+3J+Ehbyaxbya9bhh3Z/A/0kbEgA0pspvZnSm0N6c0hvDunNIb05pDeHdMCQDhjSAVM6YEoH
7Mv5SZgUypRCmVIoUwplSqFMKZQphTKlUKYUypRCWVIoSwplSaEseUJZ8oSy5AllSTstaafl
7NSvy9npj7AJw5yd3sKcnd7CmgQQEkBIAF0CSAlgSABTApgSwIIAygUBlLxkGPyalSG/ZlN+
zWRtV1nbVdZ2lbVdZW1XWdtV1naVtV1lbVdZ21XWdpW1XWVtV1nb+6ML7SAsZNh2DjgJ24Ry
FDZh2CaUk7ApASwIYJ/hj8IggH2GPwmrEMD+OvtJWEgAIQF0CSAlgCEBTAlgQgBd1naXtd1l
bXdZ213Wdpe13WVtp6ztlLWdsrZT1nbK2k5Z2ylrO2Vtp6ztlLWdsrZT1va+Vh+EDXkO2Nfq
kzAplCGFMqRQhhTKkEIZUihTCmVKoUwplCmFMqVQphTKlEKZUihTCmVKoUwplCmFsr+BfhLW
IM0lTyhLCmVJoSwplCWFsqRQFhRKuaBQygWFUi4olHJ1GQbLsVxD0pyS5pQ04d12KfBuuxR4
t132l8aPwiCA0iSAkAC6BJASQEoAQwKYEoAUSpVCqVIoVQpln77jICxl2CaUk7BNKEdhE4Zt
QjkI22fck7ACAexvoB+FQQD7G+gnYSEBdAkgJYCEAPZN+ChMXlmBH42QTbtvwidhIQGEBNAl
AGmnkHYKaaeQdgpppy7t1KWdurRTl3bq0k5d2qlLO3Vppy7ttC/8B2Ep+yxln6Xss5R9lrLP
UvbZkH02ZJ8N2WdD9tmQfTZknw3ZZ0P22ZB9NmSf7QPzSdiCAKY8VEx5qJjyUDHloWLKQ8WU
Tbtk0y7ZtEs27ZJNu2TTLtm0Szbtkk27ZNMu2bRLNu2CTVsv2LT1gk1br5BXFvLK4DmgXvAc
UK8hPxpTApgSALRTLdBOtUA71QLtVAu0Uy1NAggJoEsAKQGkBDAkgCkBSDtVaad9xu0HYSHD
NqGchG1COQnbhHIStgnlKEwCWBDAPuOehBUIYJ9xj8IggH3GPQkLCaBLACkBpAQwJIApASwI
YJ9xT8KavLK4ZBj8aIS0U0g7hbRTSDuFtFNIO3Vppy7t1KWdurRTl3bq0k5dCqVLoXQplC6F
0qVQ9nerj8IggP3d6pMw6c2U3kzpzZTeTOnNlN5M6c2U3kzpzZTeHNKbQ3pzSG8O6c0hz05D
qm5I1Q2puiFVN6TqplTdlKqbUnVTqm5K1U2puilVN6XqplTdlKqbUihLCmVJoSwplCWFsuRB
bMmD2JKqW1J1S6puSdUtqboFVdcuqLp2QdW1C6quXVB17WoSQEgAIQF0CWBTXf542P4gw0nY
JpSTsE0oR2EThm1COQkLCaBLACkBpAQwJIApASwIYH+Q4SgMAtjfRz8JqxDA/k+xn4SFBBAS
QJcApFD2hz9OwiYE0KQDmnRAkw5o0gFNOqBJBzTpgCYd0KQDQjogpANCOiCkA0I6IKQDQjpg
f1zgJGxBml0eKro8VHR5qOhSKF0KpUuhdCmULoXSpVC6FEqXQulSKCmFkrJpUzZtyqZNebed
8m475d12yrvtlHZKaach7TSknYa005B2GtJOQ9ppSDsNaacpy3HKcpyyHKcsxynLccpynLIc
pyzHKctxyXJcshyXLMcly3HJclyyHJcsxwXLMa6Lhk0YBr+vERf8vkZcUChxhQQQEkCXAFIC
GBLAlACmBACFEnJgDjkwhxyYYx+Yx4+H7cPfFvb0fP/l9fPPt5jX7be3n3r36e7l9vL16en5
7Qd3H3763q//5evHj3fPf13G7fHLHxdy//7uz2t5ePx0//7dw+3Xh8f3n285Rv9e4sPjy+vt
6e06br8/37/e3T58vbu9Pv79d3iLll8l+SXfWv8kbGv9k7Ct9U/C4pJhEkCXAFICGBLAlACm
BLAggP119pOwAgHsr7MfhUEA+6R8EBayHEOWY8hyDFmOIcsxZDmGLMeQ5RiyHEOWY8hyDFmO
XZZjl+XYZTl2WY5dluM+j56EdQggZdOmbNqUTZuyaVM2bcqmTdm0KZs2ZdOmbNqUTTtk0w7Z
tEM27ZBNO2TTDtm0QzbtPvUdhE15tz2lA6Z0wJQOmNIBUzpgSgdM6YApHTClA6Z0wJQOWNIB
SzpgSQcs6YAlHbC/S3oSNuSVTfnRWO6j0a/rkmEThkE79QvaqV9NAggJICSALgGkBDAkgCkB
TAkA2qkXaKdeoJ16gXbqZciv2ZRfM1nbVda23De73De73De73De73De73De73De73De73De7
3De73Df7vm/OHw/b3z48Cdv67CRs67ODsP3tw6OwCcMKBLBPkidhTQIICSAkgC4BpAQwJIAp
AUwJQPbZPkmehOUlw+DXrMva7rK2u6ztlLWdsrZT1nbK2k5Z2ylrO2Vtp6ztlLWdsrZT1nbK
2k5Z20PW9r5vnoRVCGBfEU/CuvxjStUNqbohVTek6oZU3ZSqm1J1U6puStVNqbopVTel6qZU
3ZSqm1J1U6puStVNqbolVbekUJYUypJCWVIoSwplSaEsKJS8oFDygkLJCwolLyiUvJoEEBJA
SABdAkgJYEgAUwLYhLJ+PGx/yfIkbHvG5SRsE8pJ2CaUk7BNKEdhEsCQAKYEsCCAfRM+CoMA
9k34JKxCAPsmfBIWEkBIAF0CSAlgQAD7+5snYfWSYZBmk0JpUihNCqVJoTQplCaF0qRQmhRK
yD4L2Wch+yxkn4Xss30TPgqTABYEsG/CJ2HSAV06oEsHdOmALh3QpQO6dECXDujSAV06oEsH
pLzbTnm3ndJOKe2U0k4p7ZTSTintlNJOKe00pJ2GtNOQdhrSTkPaaUg7DWmnKftsyj6bss+m
7LMp+2zKPpuyz6bssyn7bMk+W7LPluyzJftsyT5bss+W7LMl77aXvNte8G57XPB72+Mq8srg
3fa4oJ3GBe00rpAAugSQEsCQAKYEMCUAaKdRoJ3G9ppquQ7CvrXTWdiEYd/a6SjsWzsdhQ15
ZVNe2YIfjW15PQuDH41teT0KqxDAtrwehYUEEBJAlwBSAhgSwJQApgSwIIDtXxs+CpN2atJO
24x7FJbyyhJ+NJq0U5N2atJOIe0U0k4h7RTSTiHtFNJOIe0U0k4h7RTSTiHtFNJOIe3UpZ26
tFOXdupJwyDNLoXSpVC6FEpKoaQUSkqhpBRKSqGkFEpKoaQUSkqhpBRKSqGkFEpKoQwplCH7
bMg+m7LPpuyzKftsyj6bss+m7LMp+2zKPpuyz6bssyn7bMo+m7LPluyzJW+Qt+m7lIOw7Tb0
JGyr7ZOwrbZ/PGxuL9CehU0YVhKG1YBhTQIICSAkgC4BpAQwJIApAUwJYEEA2yZ8FFYggO0F
2qOwvGQYpFmGpDklTSmUKoVSpVCqFEqVQqlSKFUKpUqhVCmUKoVSpVCqFEqVQtneeT0KCwig
SQc06YAmHdCkA5p0QJMOCOmAkA4I6YCQDgjpgJAOCOmAkH0W8ga5yxvkLm+QO/y+xtxeoD0K
k0LpUihdCqVLoXQplC6F0qVQuhRKSqGkFEpKoaQUSkqhpBRKSqGkPFSkPFQMKZQhhTKkUIYU
ypBCGVIoQwplSKEMKZQhhTKkUIYUypRCmVIoUwplSqFMKZQphTKlUKYUyr5W14Ow7bizhT09
3395/fzzLbLdfnv7qXef7l5uL1+fnp7ffnD34afv/fpfvn78ePf812XcHr/8cSH37+/+vJaH
x0/379893H59eHz/+fbW1vV7iQ+PL6+3p7fruP3+fP96d/vw9e72+vj33+Et2n2V9n36JKxU
GLZp9yhswrCWMCwkgC4BpASQEsCQAKYEsByAtT9tcBQ2YVhJGFYDhg0JYEoAUwJYEECBDlgF
OmAV6IBVoANWaRJASABdAkgJICWAIQHI2q6ytqus7Spru8ra3jf9k7CQAEIC6BJASgDSm1V6
s0pvVunNJr3ZpDeb9GaT3mzSm016s0mhtCmvTNoppJ1C2imknULaKaSdQtoppJ1C2imknULa
KaSdQtoppJ26tFOXTdvlCaXLE0qXJ5QuhdKlULoUSkqhpBRKSqGkFEpKoaQUSkqhpBRKSqGk
FMr+anb78bD90YWTsCqvbDsHnIRt54CTsM1OJ2FdAkgJICWAIQFMCWBBAPujC0dhEMD+6MJJ
WIUA9kcXTsJCAggJoEsAKQEMCUDaaVUaBmkuKZQlhbKkUJYUypJCWVIoSwplOaH88Z/QvmTY
hGFOKG9hTihvYU0CCAkgJIAuASQEUBq8shLyyjr8aJS8ZBj8aJQhAUwJQJZjleVYZTlWWY5V
lmOV5VhlOVZZjlWWY5XlWAcE0OolwyCAJh3QpAOadECTDmjSAU06oEkHNOmAkA4I6YCQDgjp
gJAOCOmAkA4I6YCQDtjH0pOwAml2KZQuhdKlULoUSpdC6VIoXQqlS6F0KZQuhZJSKPvAHAdh
m1BOwjahnIRtQjkJS3llQ17Z9r3tozD50Vjwo7G/G38SViCAfWA+CoMA9oH5JCwkgC4BpASQ
EsCQAKYEsCCAfWA+CZO1vS+vR2Hwo7Evrydh0k5T2mlKO01ppynttKSdlrTTknZa0k5L2mlJ
Oy1Z20vW9oK1XS5Y2+WCh4pywUNFueCholxNAggJICSALgGkBDAkgCkBTAkA2qkUaKdSoJ1K
gXYqBdqplJRXlvLKhvxoTPnRkHaq0k5V2qlKO1VppyrtVKWdqrRTlXaq0k5V2qlKO1VppwZv
3UuDt+6lwW8slSYd0KQDmnRAkw5o0gEhHRDSASEdENIBIR0Q0gEhHRDSASEdENIBIR3Q5Q1y
lw7o0gFdOqBLB3TpgC4d0KUDunRASgfI6bvI6bvI6bvI6bukdEBKB6R0gFz4i1z4i1z4y77w
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

--vtzGhvizbBRQ85DL--
