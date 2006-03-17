Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWCQEhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWCQEhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 23:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWCQEhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 23:37:09 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:26899 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751285AbWCQEhG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 23:37:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PoSxXwcvwOuLpE6lI9dz52RxoDdux/goIDR8GRRDfs5DXjlQkrSa/0YD+BuQnxpBYITxgu6jqzx4xvpvubr0T+P/LulWf+oNP6g5cD8WhuQ3XtboHWBJUaeB8gh/vNtOGeXaYh5zE+yBz2M88dliboqkydKVNjLFe3ijSf0fdFY=
Message-ID: <93564eb70603162037g1856b7eey@mail.gmail.com>
Date: Fri, 17 Mar 2006 13:37:04 +0900
From: "Samuel Masham" <samuel.masham@gmail.com>
To: "Mauro Tassinari" <mtassinari@cmanet.it>
Subject: Re: libata/sata errors on ich[?]/maxtor
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAoSG5sanwXkG4qxYkj76rcgEAAAAA@cmanet.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAoSG5sanwXkG4qxYkj76rcgEAAAAA@cmanet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro, All,

On 17/03/06, Mauro Tassinari <mtassinari@cmanet.it> wrote:
> The following hw combination appears to be broken, up to 2.6.16-rc6,
> hanging after giving the usual bunch of repeated messages whenever a
> moderate
> i/o load is started, in this case a sda (hitachi) to sdb (maxtor) cpio.
>
> .... snip ....
>
> ata2: command 0x35 timeout, stat 0xd0 host_stat 0x21
> ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> ata2: status=0xd0 { Busy }
> sd 1:0:0:0: SCSI error: return code = 0x8000002
> sdb: Current: sense key: Aborted Command
>     Additional sense: Scsi parity error
> end_request: I/O error, dev sdb, sector 308678943
> ATA: abnormal status 0xD0 on port 0xEFA7
> ATA: abnormal status 0xD0 on port 0xEFA7
> ATA: abnormal status 0xD0 on port 0xEFA7
>
> .... snip ....

Unfortualy I can reproduce this at will just by trying to mkfs -t ext3
on one of the box's second drive.

A couple of weeks ago we added a second hardisk to our Dell 750's

SATA controler (lspci output from a slightly less uptodate box...)
00:1f.2 IDE interface: Intel Corp. 6300ESB SATA Storage Controller
(rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: Dell: Unknown device 0165
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at fea0 [size=16]
SATA drives
  Ata Maxtor 6Y080M0  SCSI  sda  0
  Ata Maxtor 6V250F0  SCSI  sdb  0

(using the ata_piix driver...)

We have 10 of these boxes with RHEL 3 on an even with the latest
(updated yesterday 2.4.20-40? ie update 7) version the situation is
unchanged.

I wasn't going to post the issue to LKML as it in our case it should
be a redhat problem but if you are seeing the same thing they may be
some value in adding my information here... I will be adding this to
redhats bugzilla ... soon ;)

What seems to happen is that mkfs will try and write to the drive
using the normal

(From strace)

_llseek(3, 72613699584, [72613699584], SEEK_SET) = 0
write(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 32768

but this write then "never" returns...

from the echo t > /proc/sysrq-trigger output

mkfs.ext3     R F6EA8000  3872 22820  22819                     (NOTLB)
Call Trace:   [<c01355d5>] schedule_timeout [kernel] 0x65 (0xd5233cd4)
[<c0135560>] process_timeout [kernel] 0x0 (0xd5233cf4)
[<c012569d>] io_schedule_timeout [kernel] 0x2d (0xd5233d0c)
[<c01d33fa>] __get_request_wait [kernel] 0xfa (0xd5233d18)
[<c01d3a5c>] __make_request [kernel] 0x15c (0xd5233d74)
[<c01d40da>] generic_make_request [kernel] 0xea (0xd5233dd0)
[<c01d4179>] submit_bh_rsector [kernel] 0x49 (0xd5233df8)
[<c01667bb>] write_locked_buffers [kernel] 0x3b (0xd5233e14)
[<c0166930>] write_some_buffers [kernel] 0x160 (0xd5233e28)
[<c0167b24>] balance_dirty [kernel] 0x34 (0xd5233ecc)
[<c0168aa4>] __block_commit_write [kernel] 0x84 (0xd5233ed8)
[<c01692dd>] block_commit_write [kernel] 0x2d (0xd5233ef4)
[<c014c6d5>] do_generic_file_write [kernel] 0x235 (0xd5233f0c)
[<c014cc4f>] generic_file_write [kernel] 0x18f (0xd5233f60)
[<c0165267>] sys_write [kernel] 0x97 (0xd5233f94)
[<c01110d9>] syscall_trace_enter [kernel] 0x59 (0xd5233fac)
[<c02af114>] no_timing2 [kernel] 0x7 (0xd5233fc0)
[<c02a002b>] clip_pop [kernel] 0x5b (0xd5233fe0)

The value of R varies with it sometime being 00000001  or a number
like F6758000

As you can see from the printk's here this error continues and the for
every access (write?) to the drive you just have to wait for a
timeout.

ata1: command 0x35 timeout, stat 0xd1 host_stat 0x61
ata1: translated ATA stat/err 0xd1/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xd1 { Busy }
SCSI disk error : host 0 channel 0 id 1 lun 0 return code = 8000002
Current sd08:12: sense key Aborted Command
Additional sense indicates Scsi parity error
  I/O error: dev 08:12, sector 89391226
ATA: abnormal status 0xD1 on port 0x177
ATA: abnormal status 0xD1 on port 0x177
ATA: abnormal status 0xD1 on port 0x177
ata1: command 0x35 timeout, stat 0xd1 host_stat 0x61
ata1: translated ATA stat/err 0xd1/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xd1 { Busy }
SCSI disk error : host 0 channel 0 id 1 lun 0 return code = 8000002
Current sd08:12: sense key Aborted Command
Additional sense indicates Scsi parity error
  I/O error: dev 08:12, sector 89391228
ATA: abnormal status 0xD1 on port 0x177
ATA: abnormal status 0xD1 on port 0x177
ATA: abnormal status 0xD1 on port 0x177

For us this also seems to be blocking the access to the other drive?
so we are left with a effectively dead box....

We have seen this effect on 3 of the 10 boxes so far (with different
triggers) but it is 100% repeatable on this one box this way.

It looks to me like ether we should be clearing an error status after
we have got it or the drive should clear it automatically but it
clearly isn't. As such all subsequent accesses just timeout repeating
the already seen error...

Obviously this last paragraph is random wild speculation on my part :)

Anyone got a handle on this one?

Samuel

ps we cant upgrade to the latest and greatest (ie anything other than
rhel3) on these boxes but if we are showing the same symptoms then
maybe it is useful... and we have a great test case here for any
fixes...

>
> The behaviour is repetitive and does not depend on hw.
> Different tests were run on different disks and platforms.
> Hitachi to hitachi gave no errors.
>
> Some details follow
>
> Regards
>
> Mauro Tassinari
>
>
>
>
> root@test:~# /usr/src/linux/scripts/ver_linux
> If some fields are empty or look unusual you may have an old version.
> Compare to the current minimal requirements in Documentation/Changes.
>
> Linux test 2.6.16-rc6-abi-sata #3 PREEMPT Thu Mar 16 18:59:20 Local time
> zone must be set--see  i686 pentium4 i386 GNU/Linux
>
> Gnu C                  3.4.6
> Gnu make               3.80
> binutils               2.15.92.0.2
> util-linux             2.12r
> mount                  2.12r
> module-init-tools      3.1
> e2fsprogs              1.38
> jfsutils               1.1.8
> reiserfsprogs          3.6.19
> reiser4progs           line
> xfsprogs               2.7.11
> pcmcia-cs              3.2.8
> quota-tools            3.12.
> PPP                    2.4.4b1
> nfs-utils              1.0.7
> Linux C Library        2.3.6
> Dynamic linker (ldd)   2.3.6
> Linux C++ Library      6.0.3
> Procps                 3.2.6
> Net-tools              1.60
> Kbd                    1.12
> Sh-utils               5.94
> udev                   064
> Modules Loaded         binfmt_aout binfmt_xout binfmt_coff abi_wyse
> abi_solaris abi_sco abi_uw7 abi_ibcs abi_cxenix abi_svr4 lcall
> 7 abi_util snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss
> snd_mixer_oss nfsd exportfs lockd sunrpc ipv6 ohci_hcd
>  pcspkr intel_agp pl2303 usbserial shpchp pci_hotplug uhci_hcd ehci_hcd
> usbcore i8xx_tco ahci i2c_i801 i2c_core sky2 pci200syn hdl
> c syncppp com20020_pci com20020 arcnet snd_ens1371 gameport snd_rawmidi
> snd_seq_device snd_ac97_codec snd_ac97_bus snd_pcm snd_tim
> er snd soundcore snd_page_alloc pcmcia firmware_class yenta_socket
> rsrc_nonstatic pcmcia_core tsdev lp parport_pc parport psmouse
>
> root@test:~# hdparm -I /dev/sdb
>
> /dev/sdb:
>
> ATA device, with non-removable media
>         Model Number:       Maxtor 6L160M0
>         Serial Number:      L39VAZ4G
>         Firmware Revision:  BACE1G20
> Standards:
>         Used: ATA/ATAPI-7 T13 1532D revision 0
>         Supported: 7 6 5 4
> Configuration:
>         Logical         max     current
>         cylinders       16383   16383
>         heads           16      16
>         sectors/track   63      63
>         --
>         CHS current addressable sectors:   16514064
>         LBA    user addressable sectors:  268435455
>         LBA48  user addressable sectors:  320173056
>         device size with M = 1024*1024:      156334 MBytes
>         device size with M = 1000*1000:      163928 MBytes (163 GB)
> Capabilities:
>         LBA, IORDY(can be disabled)
>         Queue depth: 32
>         Standby timer values: spec'd by Standard, no device specific minimum
>         R/W multiple sector transfer: Max = 16  Current = 16
>         Advanced power management level: unknown setting (0x0000)
>         Recommended acoustic management value: 192, current value: 254
>         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
>              Cycle time: min=120ns recommended=120ns
>         PIO: pio0 pio1 pio2 pio3 pio4
>              Cycle time: no flow control=120ns  IORDY flow control=120ns
>              Cycle time: no flow control=120ns  IORDY flow control=120ns
> Commands/features:
>         Enabled Supported:
>            *    SMART feature set
>                 Security Mode feature set
>            *    Power Management feature set
>            *    Write cache
>            *    Look-ahead
>            *    Host Protected Area feature set
>            *    WRITE_VERIFY command
>            *    WRITE_BUFFER command
>            *    READ_BUFFER command
>            *    NOP cmd
>            *    DOWNLOAD_MICROCODE
>                 Advanced Power Management feature set
>                 SET_MAX security extension
>            *    Automatic Acoustic Management feature set
>            *    48-bit Address feature set
>            *    Device Configuration Overlay feature set
>            *    Mandatory FLUSH_CACHE
>            *    FLUSH_CACHE_EXT
>            *    SMART error logging
>            *    SMART self-test
>                 Media Card Pass-Through
>            *    General Purpose Logging feature set
>            *    WRITE_{DMA|MULTIPLE}_FUA_EXT
>            *    URG for READ_STREAM[_DMA]_EXT
>            *    URG for WRITE_STREAM[_DMA]_EXT
>            *    SATA-I signaling speed (1.5Gb/s)
>            *    Native Command Queueing (NCQ)
>                 Software settings preservation
> Security:
>         Master password revision code = 65534
>                 supported
>         not     enabled
>         not     locked
>         not     frozen
>         not     expired: security count
>         not     supported: enhanced erase
> Checksum: correct
>
>
> 1^ platform
>
> root@test:~# lspci -v
> 00:00.0 Host bridge: Intel Corporation 82865G/PE/P DRAM Controller/Host-Hub
> Interface (rev 02)
>         Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
>         Flags: bus master, fast devsel, latency 0
>         Memory at f8000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: [e4] #09 [2106]
>         Capabilities: [a0] AGP version 3.0
>
> 00:01.0 PCI bridge: Intel Corporation 82865G/PE/P PCI to AGP Controller (rev
> 02) (prog-if 00 [Normal decode])
>         Flags: bus master, 66Mhz, fast devsel, latency 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
>         Memory behind bridge: fc900000-fe9fffff
>         Prefetchable memory behind bridge: e7f00000-f7efffff
>
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2) (prog-if 00
> [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: fea00000-feafffff
>
> 00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface
> Bridge (rev 02)
>         Flags: bus master, medium devsel, latency 0
>
> 00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
> Controller (rev 02) (prog-if 8a [Master SecP PriP])
>         Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
>         Flags: bus master, medium devsel, latency 0, IRQ 16
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at fc00 [size=16]
>         Memory at 30000000 (32-bit, non-prefetchable) [size=1K]
>
> 00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev
> 02) (prog-if 8f [Master SecP SecO PriP PriO])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
>         Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 16
>         I/O ports at efe0 [size=8]
>         I/O ports at efac [size=4]
>         I/O ports at efa0 [size=8]
>         I/O ports at efa8 [size=4]
>         I/O ports at ef90 [size=16]
>
> 00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller
> (rev 02)
>         Subsystem: ASUSTeK Computer Inc. P4P800 Mainboard
>         Flags: medium devsel, IRQ 11
>         I/O ports at 0400 [size=32]
>
> 00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER
> (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 812a
>         Flags: bus master, medium devsel, latency 0, IRQ 20
>         I/O ports at e800 [size=256]
>         I/O ports at ef00 [size=64]
>         Memory at febfb800 (32-bit, non-prefetchable) [size=512]
>         Memory at febfb400 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Power Management version 2
>
> 01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440
> AGP 8x] (rev c1) (prog-if 00 [VGA])
>         Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 19
>         Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
>         Memory at e8000000 (32-bit, prefetchable) [size=128M]
>         Expansion ROM at fe9e0000 [disabled] [size=128K]
>         Capabilities: [60] Power Management version 2
>         Capabilities: [44] AGP version 3.0
>
> 02:04.0 RAID bus controller: Promise Technology, Inc. PDC20378 (FastTrak
> 378/SATA 378) (rev 02)
>         Subsystem: ASUSTeK Computer Inc. K8V Deluxe/PC-DL Deluxe motherboard
>         Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 18
>         I/O ports at df00 [size=64]
>         I/O ports at dfa0 [size=16]
>         I/O ports at dc00 [size=128]
>         Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
>         Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
>         Capabilities: [60] Power Management version 2
>
> 02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8139/8139C/8139C+ (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>         Flags: bus master, medium devsel, latency 64, IRQ 18
>         I/O ports at d800 [size=256]
>         Memory at feafec00 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Power Management version 2
>
> 02:0c.0 Communication controller: PLX Technology, Inc. PCI <-> IOBus Bridge
> (rev 01)
>         Subsystem: PLX Technology, Inc.: Unknown device 1584
>         Flags: medium devsel, IRQ 17
>         I/O ports at d480 [size=128]
>         I/O ports at df80 [size=32]
>         I/O ports at dfe0 [size=8]
>
>
>
> 2^ platform
>
> root@test:/var/lspci -v
> 00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to
> I/O Controller (rev 04)
>         Subsystem: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O
> Controller
>         Flags: bus master, fast devsel, latency 0
>         Capabilities: [e0] #09 [2109]
>
> 00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express Root
> Port (rev 04) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
>         I/O behind bridge: 0000e000-0000efff
>         Memory behind bridge: d7f00000-d7ffffff
>         Prefetchable memory behind bridge: d8000000-dfffffff
>         Capabilities: [88] #0d [0000]
>         Capabilities: [80] Power Management version 2
>         Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0
> Enable-
>         Capabilities: [a0] #10 [0141]
>
> 00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
> PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
>         I/O behind bridge: 0000d000-0000dfff
>         Capabilities: [40] #10 [0141]
>         Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
> Enable-
>         Capabilities: [90] #0d [0000]
>         Capabilities: [a0] Power Management version 2
>
> 00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
> PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>         I/O behind bridge: 0000c000-0000cfff
>         Memory behind bridge: d7e00000-d7efffff
>         Capabilities: [40] #10 [0141]
>         Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0
> Enable-
>         Capabilities: [90] #0d [0000]
>         Capabilities: [a0] Power Management version 2
>
> 00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
>         Flags: bus master, medium devsel, latency 0, IRQ 22
>         I/O ports at 9880 [size=32]
>
> 00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
>         Flags: bus master, medium devsel, latency 0, IRQ 19
>         I/O ports at 9c00 [size=32]
>
> 00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
>         Flags: bus master, medium devsel, latency 0, IRQ 18
>         I/O ports at a000 [size=32]
>
> 00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
>         Flags: bus master, medium devsel, latency 0, IRQ 16
>         I/O ports at a080 [size=32]
>
> 00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
> Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
>         Flags: bus master, medium devsel, latency 0, IRQ 22
>         Memory at d7dff800 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] #0a [20a0]
>
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3) (prog-if 01
> [Subtractive decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>         I/O behind bridge: 0000b000-0000bfff
>         Capabilities: [50] #0d [0000]
>
> 00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface
> Bridge (rev 03)
>         Flags: bus master, medium devsel, latency 0
>
> 00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
> IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
>         Flags: bus master, medium devsel, latency 0, IRQ 18
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at <unassigned>
>         I/O ports at ffa0 [size=16]
>
> 00:1f.2 IDE interface: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA
> Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 2601
>         Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 19
>         I/O ports at ac00 [size=8]
>         I/O ports at a880 [size=4]
>         I/O ports at a800 [size=8]
>         I/O ports at a480 [size=4]
>         I/O ports at a400 [size=16]
>         Memory at d7dffc00 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [70] Power Management version 2
>
> 00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus
> Controller (rev 03)
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
>         Flags: medium devsel
>         I/O ports at 0400 [size=32]
>
> 01:0a.0 Communication controller: PLX Technology, Inc. PCI <-> IOBus Bridge
> (rev 01)
>         Subsystem: PLX Technology, Inc.: Unknown device 1588
>         Flags: medium devsel, IRQ 21
>         I/O ports at b880 [size=128]
>         I/O ports at b800 [size=64]
>         I/O ports at b480 [size=8]
>
> 01:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
>         Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
>         Flags: bus master, slow devsel, latency 64, IRQ 20
>         I/O ports at bc00 [size=64]
>         Capabilities: [dc] Power Management version 1
>
> 02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit
> Ethernet Controller (rev 15)
>         Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet
> Controller (Asus)
>         Flags: bus master, fast devsel, latency 0, IRQ 17
>         Memory at d7efc000 (64-bit, non-prefetchable) [size=16K]
>         I/O ports at c800 [size=256]
>         Expansion ROM at d7ec0000 [disabled] [size=128K]
>         Capabilities: [48] Power Management version 2
>         Capabilities: [50] Vital Product Data
>         Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1
> Enable-
>         Capabilities: [e0] #10 [0011]
>
> 04:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon
> X300 (PCIE)] (prog-if 00 [VGA])
>         Subsystem: ASUSTeK Computer Inc. Extreme AX300SE-X
>         Flags: bus master, fast devsel, latency 0
>         Memory at d8000000 (32-bit, prefetchable) [size=128M]
>         I/O ports at e000 [size=256]
>         Memory at d7fe0000 (32-bit, non-prefetchable) [size=64K]
>         Expansion ROM at d7fc0000 [disabled] [size=128K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] #10 [0001]
>         Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0
> Enable-
>
> 04:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 002b
>         Flags: bus master, fast devsel, latency 0
>         Memory at d7ff0000 (32-bit, non-prefetchable) [size=64K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [58] #10 [0001]
>
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
