Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317320AbSFLTti>; Wed, 12 Jun 2002 15:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317325AbSFLTth>; Wed, 12 Jun 2002 15:49:37 -0400
Received: from opus.INS.CWRU.Edu ([129.22.8.2]:42454 "EHLO opus.INS.cwru.edu")
	by vger.kernel.org with ESMTP id <S317320AbSFLTtd>;
	Wed, 12 Jun 2002 15:49:33 -0400
From: "Braden McGrath" <bwm3@po.cwru.edu>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Kernel 2.4.18 Promise driver (IDE) hangs @ boot with Promise 20267
Date: Wed, 12 Jun 2002 15:51:58 -0400
Message-ID: <006901c2124a$9cb2ab30$ceaa1681@z>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first problem ever with the kernel, and also my first mail to
linux-kernel so please be gentle...  I have followed the list a bit
though.  

The format of this mail is as recommended in "REPORTING-BUGS" in the
kernel source.  Sorry about the length, but I'm just following
documented procedure.  :P

Without further ado...

** The problem
I was having corruption issues with my onboard highpoint controller
(HPT366, Abit BE6 motherboard) when the PCI bus was being utilized
heavily (reading from the 4 drives and sending over 3com ethernet), and
I've read in several places that the highpoint controller is buggy.  I
picked up a Promise Ultra100 controller in hopes that things would work.

I rebooted the machine and realized I hadn't compiled the Promise driver
into my kernel - the machine booted fine at this point and found all of
my drives, but performance was horrible (2-3MB/sec instead of 10+) so I
recompiled and rebooted.  When I reboot with the Promise driver
compiled, the boot process looks like so:

Uniform Multi-Platform E-IDE driver Revision: 6.31
...<snip>...
hda: Maxtor 91024U4, ATA DISK drive
hdc: TOSHIBA DVD-ROM SD-M1212, ATAPI CD/DVD-ROM drive
hde: Maxtor 91366U4, ATA DISK drive
hdf: Maxtor 52049U4, ATA DISK drive
hdg: Maxtor 93073U6, ATA DISK drive
hdh: MAXTOR 4K080H4, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0x9400-0x9407,0x9802 on irq 7
ide3 at 0x9c00-0x9c07,0xa002 on irq 7
hda: 19999728 sectors (10240 MB) w/2048KiB Cache, CHS=1244/255/63,
UDMA(33)
***[HANG]***

The machine finds the controller and the drives attached to it, but
while attempting to determine the hardware settings from the drives
attached to the promise controller it hangs.  /dev/hda is on the intel
chipset controller and thus works fine.  Keyboard stops working, can't
reboot, etc.  Without the Promise driver compiled, my (relevant) output
after that point looks like:
...
hde: 26684784 sectors (13663 MB) w/2048KiB Cache, CHS=26473/16/63
hdf: 40020624 sectors (20491 MB) w/2048KiB Cache, CHS=39703/16/63
hdg: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63
hdh: 156301488 sectors (80026 MB) w/2000KiB Cache, CHS=155061/16/63
hdc: ATAPI 32X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
 hde: [PTBL] [1661/255/63] hde1
 hdf: hdf1
 hdg: hdg1
 hdh: hdh1
... etc

Note that booting without the promise driver and just using generic IDE
DOES work, but with dismal performance on the drives attached to the
promise controller along with high CPU usage.  They don't claim to be in
PIO mode when I hdparm -i them, but they feel like they are.

I played around a bit and then thought of feeding the drive geometry to
the driver with LILO boot: parameters.  I used the following line -
LILO boot: linux-new hde=1661,255,63 hde=noprobe hdf=39703,16,63
hdf=noprobe hdg=155061,16,63 hdg=noprobe hdh=59554,16,63 hdh=noprobe

When I boot like this, the machine gets to the same point in the boot
process (the hda: 19999728 sectors above) and then throws an oops (see
below) and panics.  Note that I am not using modules at all, and I
couldn't easily get /proc/ksyms because it happens before I even get a
prompt and the machine is dead hung afterwards.  (Thus why I used
ksymoops -K)

I have *not* tried this on older kernels, nor have I tried any of the
-pre* series.  If anyone thinks either of these could help I'm willing
to give it a try.  I'm waiting on another motherboard from a friend -
the only other possible cause of this that I can think of is that the
HPT366 controller is somehow confusing the Promise controller.  I can't
turn off the HPT366 on this motherboard, there is no disable in the
system bios.  The Promise card is known-good; it worked fine in my
friend's Windows system and in his linux system a while ago (kernel
unknown) before I bought the card from him.

** Kernel Version:
Linux version 2.4.18-xfs-1.1 (root@how)

** Hardware:
P3 500 Katamai
ABIT BE6 motherboard with builtin Highpoint 366 controller
Promise Ultra100 (20267) PCI controller
1x Maxtor on builtin Intel BX controller
4x Maxtor IDE drives of different sizes and modes (3 are UDMA66, one is
UDMA100) on Promise controller

** ksymoops output (from hand-transcribed oops message at boot):

ksymoops 2.4.5 on i686 2.4.18-xfs-1.1.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-xfs-1.1/ (default)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address
00000063
c021c800
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c021c800>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c0325bc0   ebx: 00000000     ecx: 0000a400       edx: 0000a402
esi: c0325c00   edi: 00000007     ebp: 0008e000       esp: dbf7df4c
ds: 0018        edi: 0018      ss: 0018
Process swapper (pid: 1, stackpage=dbf7d000)
Stack: c0325bc0 00000004 c0325c00 c021c89a c0325c00 c0325c00 00000286
c02c0b80
       c021a44a 00000004 c0325c00 00000007 c0325c00 c0325c00 00000001
c02c0b80
       c0221501 c0325c00 c02c0b80 00000001 c03217a0 000000ff c0321f9c
c02d40f4
Call Trace: [<c021c89a>] [<c021a44a>] [<c0221501>] [<c0105037>]
[<c0105478>]
Code: f6 43 63 08 75 06 f6 43 6a 02 74 10 bf 07 00 00 00 6a 05 56


>>EIP; c021c800 <config_drive_xfer_rate+b0/e4>   <=====

>>eax; c0325bc0 <ide_hwifs+620/1ea0>
>>ecx; 0000a400 Before first symbol
>>edx; 0000a402 Before first symbol
>>esi; c0325c00 <ide_hwifs+660/1ea0>
>>ebp; 0008e000 Before first symbol
>>esp; dbf7df4c <END_OF_CODE+1bc51bf8/????>

Trace; c021c89a <pdc202xx_dmaproc+52/e4>
Trace; c021a44a <ide_register_subdriver+9a/f4>
Trace; c0221501 <idedisk_init+15/b4>
Trace; c0105037 <init+7/110>
Trace; c0105478 <kernel_thread+28/38>

Code;  c021c800 <config_drive_xfer_rate+b0/e4>
00000000 <_EIP>:
Code;  c021c800 <config_drive_xfer_rate+b0/e4>   <=====
   0:   f6 43 63 08               testb  $0x8,0x63(%ebx)   <=====
Code;  c021c804 <config_drive_xfer_rate+b4/e4>
   4:   75 06                     jne    c <_EIP+0xc> c021c80c
<config_drive_xfer_rate+bc/
e4>
Code;  c021c806 <config_drive_xfer_rate+b6/e4>
   6:   f6 43 6a 02               testb  $0x2,0x6a(%ebx)
Code;  c021c80a <config_drive_xfer_rate+ba/e4>
   a:   74 10                     je     1c <_EIP+0x1c> c021c81c
<config_drive_xfer_rate+c
c/e4>
Code;  c021c80c <config_drive_xfer_rate+bc/e4>
   c:   bf 07 00 00 00            mov    $0x7,%edi
Code;  c021c811 <config_drive_xfer_rate+c1/e4>
  11:   6a 05                     push   $0x5
Code;  c021c813 <config_drive_xfer_rate+c3/e4>
  13:   56                        push   %esi

 <0>Kernel panic: Attempted to kill init!

** Software (note that the date on the kernel isn't correct as it isn't
the kernel that I am hanging on boot with, obviously): 
 
Linux how 2.4.18-xfs-1.1 #1 Fri May 17 20:46:54 EDT 2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         

** CPU info
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 501.149
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx f
xsr sse
bogomips        : 999.42

** modules
NONE

** PCI information
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev
03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR
- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+
 >SERR- <PERR-
        Latency: 32
        Region 0: Memory at d4000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev
03) (prog-if 00 [Nor
mal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR
+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort-
 >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: d0000000-d3ffffff
        Prefetchable memory behind bridge: d6000000-d6ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR
- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort-
 >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR
- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort-
 >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01) (prog-if
00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR
- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort-
 >SERR- <PERR-
        Latency: 32
        Interrupt: pin D routed to IRQ 0
        Region 4: I/O ports at 9000 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR
- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort-
 >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20267
(rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR
- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort-
 >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at 9400 [size=8]
        Region 1: I/O ports at 9800 [size=4]
        Region 2: I/O ports at 9c00 [size=8]
        Region 3: I/O ports at a000 [size=4]
        Region 4: I/O ports at a400 [size=64]
        Region 5: Memory at d8000000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR
- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort-
 >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at a800 [size=128]
        Region 1: Memory at d8020000 (32-bit, non-prefetchable)
[size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 Unknown mass storage controller: Triones Technologies, Inc.
HPT366 / HPT370 (rev 0
1)
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR
- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort-
>SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at ac00 [size=8]
        Region 1: I/O ports at b000 [size=4]
        Region 4: I/O ports at b400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]

00:13.1 Unknown mass storage controller: Triones Technologies, Inc.
HPT366 / HPT370 (rev 0
1)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR
- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort-
 >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at b800 [size=8]
        Region 1: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=256]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100
[Productiva] AGP (rev 02
) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. MGA-G100 Productiva AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR
- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort-
 >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at d6000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at d0000000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at d1000000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 1.0
                Status: RQ=1 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

I hope this helps the people it needs to... I'll be lurking around if
anyone wants clarification on anything or has helpful suggestions to
offer.

Thanks in advance, and I appreciate the work that everyone does to make
this operating system the best *nix (in my eyes).

-Braden McGrath-
bwm3@po.cwru.edu

