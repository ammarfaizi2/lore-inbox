Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWCFSnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWCFSnU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWCFSnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:43:20 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:64032 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750961AbWCFSnT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:43:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=XkXAWFjuFQf2NcjJCgjIkjWzn3/Fa8nJQt2BGwyfDk6fVgGSB9p/UKhJIOIf+DJVSAr4v6eWHpJvUbSaWBOj7914ItFEZpsnwWurIgdi2T/JU7dW2GIMtvJHUCfMPx3MBS9EL8lru6HEcllV69T0/AifbzRk68sSYoElO1gX6HQ=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
Date: Mon, 6 Mar 2006 19:43:35 +0100
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, markhe@nextd.demon.co.uk,
       Andrea Arcangeli <andrea@suse.de>, Mike Christie <michaelc@cs.wisc.edu>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Jesper Juhl <jesper.juhl@gmail.com>
References: <200603060117.16484.jesper.juhl@gmail.com> <Pine.LNX.4.64.0603060956570.13139@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603060956570.13139@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200603061943.35502.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 19:25, Linus Torvalds wrote:
> 
<...snip...>
> Anyway, Jesper, I see two potential reasons for this bug:
> 
>  - total and utter slab confusion (the slab layer returned the same slab 
>    allocation twice to two different callers). I consider this pretty 
>    unlikely, because it's such a _major_ failure of the slab code, and the 
>    slab code hasn't changed that much, but I mention it just in case. 
> 
>  - SCSI layer breakage. It might well be the low-level driver completing a 
>    request too early, or it migth be the re-trying. If it's the re-trying, 
>    you could try just reverting that commit I pointed to (ie if you're a 
>    git user, just do "git revert 17e01f21", otherwise you'd need to look 
>    it up from gitweb and un-apply the patch)
> 
Not a git user (I need to become one but haven't found the time to read up 
on it yet), but no problem, I'll dig out the patch and try reverting it.
Luckily it seems this is pretty repeatable on every boot, I find it in the 
logs instantly after logging in and launching a shell on my KDE desktop and
running dmesg - I'll do a few more reboots to make sure it *really* is 
reproducible before reverting the patch so we can be sure if it fixes the 
problem or not.

Btw, the messages turn out slightly different on each boot, here are the 
ones from this current boot of my box:

Slab corruption: start=f72b6b98, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
000: 70 00 02 00 00 00 00 0a 00 00 00 00 3a 01 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f72b6b4c, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813e6>](free_fdtable_rcu+0x66/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=f72b6be4, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](_stext+0x3feffd68/0x8)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=f72b6b98, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02934eb>](sr_do_ioctl+0x11b/0x270)
000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Prev obj: start=f72b6b4c, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813e6>](free_fdtable_rcu+0x66/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=f72b6be4, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](_stext+0x3feffd68/0x8)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=f72b6b98, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01d3769>](ext3_clear_inode+0x29/0x40)
000: 70 00 05 00 00 00 00 0a 00 00 00 00 24 00 00 00
010: 00 00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=f72b6b4c, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01813e6>](free_fdtable_rcu+0x66/0x150)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=f72b6be4, len=64
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](_stext+0x3feffd68/0x8)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b

Would gathering more of these help you out?


> Regardless, Jesper, it would be great to hear _what_ strange CDROM device 
> you have that would implied in sr_ioctl.c - is it USB, SATA or something 
> else?
> 
I have no USB, SATA or similar devices in the box, only a floppy drive, a 
SCSI harddisk, a SCSI CD writer and a SCSI DVD-ROM.
Here are some details : 


$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: PIONEER  Model: DVD-ROM DVD-305  Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: IBM      Model: DDYS-T36950N     Rev: S96H
  Type:   Direct-Access                    ANSI SCSI revision: 03


>From dmesg :

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 29160N Ultra160 SCSI adapter>
        aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

  Vendor: PIONEER   Model: DVD-ROM DVD-305   Rev: 1.03
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:4: Beginning Domain Validation
 target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: Ending Domain Validation
  Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:5: Beginning Domain Validation
 target0:0:5: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
 target0:0:5: Domain Validation skipping write tests
 target0:0:5: Ending Domain Validation
  Vendor: IBM       Model: DDYS-T36950N      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:6:0: Tagged Queuing enabled.  Depth 200
 target0:0:6: Beginning Domain Validation
 target0:0:6: wide asynchronous
 target0:0:6: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 63)
 target0:0:6: Ending Domain Validation
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 71687340 512-byte hdwr sectors (36704 MB)
sda: Write Protect is off
sda: Mode Sense: cb 00 00 08
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:6:0: Attached scsi disk sda
sr0: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:4:0: Attached scsi CD-ROM sr0
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
sr 0:0:5:0: Attached scsi CD-ROM sr1
sr 0:0:4:0: Attached scsi generic sg0 type 5
sr 0:0:5:0: Attached scsi generic sg1 type 5
sd 0:0:6:0: Attached scsi generic sg2 type 0


# lspci -vvx
00:00.0 Host bridge: ALi Corporation M1695 K8 Northbridge [PCI Express and HyperTransport]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [40] #08 [0060]
        Capabilities: [5c] #08 [a800]
        Capabilities: [68] #08 [9000]
        Capabilities: [74] #08 [8000]
        Capabilities: [7c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
00: b9 10 95 16 07 00 10 00 00 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: ALi Corporation: Unknown device 524b (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: ff200000-ff2fffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
        Capabilities: [58] #10 [0141]
        Capabilities: [7c] #08 [a800]
        Capabilities: [88] #08 [8825]
00: b9 10 4b 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 00 00
20: 20 ff 20 ff f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 03 00

00:02.0 PCI bridge: ALi Corporation: Unknown device 524c (prog-if 00 [Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: ff300000-ff3fffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
                Address: 00000000fee00000  Data: 0000
        Capabilities: [58] #10 [0141]
        Capabilities: [7c] #08 [a800]
        Capabilities: [88] #08 [8825]
00: b9 10 4c 52 06 01 10 00 00 00 04 06 10 00 01 00
10: 00 00 00 00 00 00 00 00 00 02 02 00 f0 00 00 00
20: 30 ff 30 ff f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 03 00

00:04.0 Host bridge: ALi Corporation M1689 K8 Northbridge [Super K8 Single Chip]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at dc000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [40] #08 [0024]
        Capabilities: [60] #08 [8038]
        Capabilities: [80] AGP version 3.0
                Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: b9 10 89 16 06 01 10 00 00 00 00 06 00 00 00 00
10: 08 00 00 dc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00

00:05.0 PCI bridge: ALi Corporation AGP8X Controller (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
        Memory behind bridge: ff400000-ff4fffff
        Prefetchable memory behind bridge: c7f00000-d7efffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
00: b9 10 46 52 07 01 20 00 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 03 03 40 f0 00 20 22
20: 40 ff 40 ff f0 c7 e0 d7 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0b 00

00:06.0 PCI bridge: ALi Corporation M5249 HTT to PCI Bridge (prog-if 01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff500000-ff5fffff
        Prefetchable memory behind bridge: 88000000-880fffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
00: b9 10 49 52 07 01 00 00 00 01 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 04 04 20 d0 d0 00 22
20: 50 ff 50 ff 00 88 00 88 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 03 00

00:07.0 ISA bridge: ALi Corporation M1563 HyperTransport South Bridge (rev 70)
        Subsystem: ASRock Incorporation: Unknown device 1563
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 6000ns max)
00: b9 10 63 15 0f 00 00 02 70 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 63 15
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 18

00:07.1 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
        Subsystem: ASRock Incorporation: Unknown device 7101
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: b9 10 01 71 00 00 00 02 00 00 80 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 01 71
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:11.0 Ethernet controller: ALi Corporation M5263 Ethernet Controller (rev 40)
        Subsystem: ASRock Incorporation: Unknown device 5263
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (5000ns min, 10000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=256]
        Region 1: Memory at ff6ffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b9 10 63 52 07 01 10 02 40 00 00 02 08 20 00 00
10: 01 e8 00 00 00 fc 6f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 63 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 14 28

00:12.0 IDE interface: ALi Corporation M5229 IDE (rev c7) (prog-if 8a [Master SecP PriP])
        Subsystem: ASRock Incorporation: Unknown device 5229
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at ff00 [size=16]
00: b9 10 29 52 05 00 a0 02 c7 8a 01 01 00 20 00 00
10: f1 01 00 00 f5 03 00 00 71 01 00 00 75 03 00 00
20: 01 ff 00 00 00 00 00 00 00 00 00 00 49 18 29 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:13.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation: Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ff6fe000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 e0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 50

00:13.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation: Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 10
        Interrupt: pin B routed to IRQ 3
        Region 0: Memory at ff6fd000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 d0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 03 02 00 50

00:13.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
        Subsystem: ASRock Incorporation: Unknown device 5237
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 10
        Interrupt: pin C routed to IRQ 11
        Region 0: Memory at ff6fc000 (32-bit, non-prefetchable) [size=4K]
00: b9 10 37 52 17 01 a8 02 03 10 03 0c 10 20 80 00
10: 00 c0 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 37 52
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 03 00 50

00:13.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: ASRock Incorporation: Unknown device 5239
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 10
        Interrupt: pin D routed to IRQ 5
        Region 0: Memory at ff6ff800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2090]
00: b9 10 39 52 16 01 b0 02 01 20 03 0c 10 20 80 00
10: 00 f8 6f ff 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 49 18 39 52
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 04 10 20

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

03:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA Parhelia AGP (rev 03) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Parhelia 128Mb
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 8000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at c8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at ff4fe000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at ff4c0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: 2b 10 27 05 07 00 b0 02 03 00 00 03 10 20 00 00
10: 08 00 00 c8 00 e0 4f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 40 08
30: 00 00 4c ff dc 00 00 00 00 00 00 00 05 01 10 20

04:05.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
        Subsystem: Creative Labs SBLive! 5.1 eMicro 28028
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 20
        Region 0: I/O ports at d880 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 11 02 00 05 01 90 02 0a 00 01 04 00 20 80 00
10: 81 d8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 67 80
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 02 14

04:05.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 11 02 70 05 01 90 02 0a 00 80 09 00 20 80 00
10: 01 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 11 20 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 00 00

04:06.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
        Subsystem: Adaptec 29160N Ultra160 SCSI Controller
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 10
        Interrupt: pin A routed to IRQ 19
        BIST result: 00
        Region 0: I/O ports at d400 [disabled] [size=256]
        Region 1: Memory at ff5ff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 88000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 05 90 80 00 16 01 b0 02 02 00 00 01 10 20 00 80
10: 01 d4 00 00 04 f0 5f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 05 90 a0 62
30: 00 00 5c ff dc 00 00 00 00 00 00 00 03 01 28 19

04:07.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 42)
        Subsystem: D-Link System Inc DFE-530TX rev B
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at ff5fec00 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 88020000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 65 30 17 01 10 02 42 00 00 02 10 20 00 00
10: 01 d0 00 00 00 ec 5f ff 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 01 14
30: 00 00 ff ff 40 00 00 00 00 00 00 00 02 01 03 08



/Jesper

