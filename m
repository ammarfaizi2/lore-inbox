Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130154AbRASGAU>; Fri, 19 Jan 2001 01:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130162AbRASGAL>; Fri, 19 Jan 2001 01:00:11 -0500
Received: from mail.mojomofo.com ([208.248.233.19]:58629 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S130154AbRASGAC>;
	Fri, 19 Jan 2001 01:00:02 -0500
Message-ID: <01b401c081dd$039e5ec0$0300a8c0@methusela>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: <paulus@linuxcare.com>, <linux-kernel@vger.kernel.org>,
        <linux-ppp@vger.kernel.org>
Subject: [2.4.1-pre8] MPP related OPPS
Date: Fri, 19 Jan 2001 00:58:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported this a few months ago without much details and the machine
involved died shortly after which made me think that
this oops was merely bad hardware. This is a brand new machine and the opps
popped up again. Thankfully I armed myself
with a serial console and captured this beast.

Definitely bad mojo involved in the MPPP code, this only occurs when 2
modems are bonded together over serial lines
connected to a 3com TotalControl PPP server.

I can recreate it with a bare-minimum kernel up to a full featured kernel,
going all the way back into 2.3.x land.
It isn't limited to this machine either. :)

Master link is on COM1 using an oldie but goodie USR Dual Standard
V.Everything
Slave link is on a USR PCI controller-full 56k modem

With the master link configured with MPP without the slave attached, I can
run it for days.
With the master link having the slave attached, I can run it for 5 minutes
to 30 minutes.

I've even switched master/slave configurations and tried different modems.

Details to follow:

[1.] One line summary of the problem:
After a few minutes of heavy load, MPPP over serial lines oops's.

[2.] Full description of the problem/report:
See above.

[4.] Kernel version (from /proc/version):
Linux version 2.4.1-pre8 (root@usr1-ip031-cs.wmis.net) (gcc version 2.95.3
20010101 (prerelease)) #1 Thu Jan 18 21:15:51 EST 2001

Note that this happens with egcs also, and gcc 2.95.2

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

Script started on Fri Jan 19 00:17:52 2001
[root@usr1-ip028-cs ~]# ksymoops -v /usr/src/linux/vmlinux -k /proc/ksyms -l
/pr
oc/modules -m /usr/src/linux/System.map <oops.txt
ksymoops 2.3.7 on i586 2.4.1-pre8.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.1-pre8/ (default)
     -m /usr/src/linux/System.map (specified)

Unable to handle kernel paging request at virtual address 01010101
01010101
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<01010101>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 01010101   ebx: c1ce7eb4   ecx: c209c000   edx: 00000000
esi: 00003fd2   edi: 00000000   ebp: c3d839e0   esp: c209de44
ds: 0018   es: 0018   ss: 0018
Process dnetc (pid: 695, stackpage=c209d000)
Stack: c01accd2 c1ce7eb4 c1ce7eb4 00000000 c49c95b3 c1ce7eb4 00003fd2
c2e5d1e0
       fffffffe c1ce7e44 000005bd 00000000 c2e5d1e0 c2e5d1e0 c1ce7eb4
00003fd2
       c49c9270 c1ce7e00 c1ce7e00 000005c3 c20a3be0 00000001 c1ce7eb4
c49c8b04
Call Trace: [<c01accd2>] [<c49c95b3>] [<c49c9270>] [<c49c8b04>] [<c49c8a1b>]
[<c49ccf86>] [<c49cc383>]
       [<c01726e5>] [<c0172774>] [<c0181487>] [<c0181766>] [<c0109f3c>]
[<c010a09e>] [<c0108e00>]
Code:  Bad EIP value.

>>EIP; 01010101 Before first symbol   <=====
Trace; c01accd2 <__kfree_skb+7e/134>
Trace; c49c95b3 <[ppp_generic]ppp_mp_reconstruct+2bf/2d8>
Trace; c49c9270 <[ppp_generic]ppp_receive_mp_frame+1cc/20c>
Trace; c49c8b04 <[ppp_generic]ppp_receive_frame+30/7c>
Trace; c49c8a1b <[ppp_generic]ppp_input+12f/164>
Trace; c49ccf86 <[ppp_async]ppp_async_input+3ae/458>
Trace; c49cc383 <[ppp_async]ppp_asynctty_receive+27/58>
Trace; c01726e5 <flush_to_ldisc+dd/e4>
Trace; c0172774 <tty_flip_buffer_push+14/5c>
Trace; c0181487 <receive_chars+1f3/200>
Trace; c0181766 <rs_interrupt_single+42/88>
Trace; c0109f3c <handle_IRQ_event+30/5c>
Trace; c010a09e <do_IRQ+6e/b0>
Trace; c0108e00 <ret_from_intr+0/20>

Kernel panic: Aiee, killing interrupt handler!
[root@usr1-ip028-cs ~]#
Script done on Fri Jan 19 00:18:38 2001


[6.] A small shell script or example program which triggers the
     problem (if possible)

Fire up a MPPP link and watch it burn. :)

[7.1.] Software (add the output of the ver_linux script here)
Kernel modules         2.3.21
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.7
Mount                  2.10m
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 374.229
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 747.11

Yes it's sick to have a K6-2 just routing packets. :)

[7.3.] Module information (from /proc/modules):

nls_iso8859-1           2848   1 (autoclean)
smbfs                  31216   1 (autoclean)
nfs                    74240   1 (autoclean)
ipt_unclean             6912   0 (autoclean) (unused)
ipt_TOS                 1104   0 (autoclean) (unused)
ipt_tos                  720   0 (autoclean) (unused)
ipt_state                800   0 (autoclean) (unused)
ipt_REJECT              2080   0 (autoclean) (unused)
ipt_REDIRECT             960   4 (autoclean)
ipt_owner               1360   0 (autoclean) (unused)
ipt_multiport            880   0 (autoclean) (unused)
ipt_MIRROR              1152   0 (autoclean) (unused)
ipt_MASQUERADE          1312   1 (autoclean)
ipt_MARK                 944   0 (autoclean) (unused)
ipt_mark                 720   0 (autoclean) (unused)
ipt_mac                  880   0 (autoclean) (unused)
ipt_LOG                 3312   1 (autoclean)
ipt_limit               1040   0 (autoclean) (unused)
iptable_mangle          1888   0 (autoclean) (unused)
iptable_filter          1920   0 (autoclean) (unused)
ip_queue                4544   0 (autoclean) (unused)
ip_nat_ftp              3024   0 (autoclean) (unused)
iptable_nat            12480   1 (autoclean) [ipt_REDIRECT ipt_MASQUERADE
ip_nat_ftp]
ip_tables              10016  20 (autoclean) [ipt_unclean ipt_TOS ipt_tos
ipt_state ipt_REJECT ipt_REDIRECT ipt_owner ipt_multiport ipt_MIRROR
ipt_MASQUERADE ipt_MARK ipt_mark ipt_mac ipt_LOG ipt_limit iptable_mangle
iptable_filter iptable_nat]
ip_conntrack_ftp        1984   0 (autoclean) (unused)
ip_conntrack           12640   3 (autoclean) [ipt_state ipt_REDIRECT
ipt_MASQUERADE ip_nat_ftp iptable_nat ip_conntrack_ftp]
bsd_comp                4192   0 (autoclean)
ppp_deflate            39200   0 (autoclean)
ppp_async               5968   2 (autoclean)
ppp_generic            15424   6 (autoclean) [bsd_comp ppp_deflate
ppp_async]
slhc                    4560   1 (autoclean) [ppp_generic]
isa-pnp                27600   0 (autoclean) (unused)
nfsd                   66736   2 (autoclean)
lockd                  49136   1 (autoclean) [nfs nfsd]
sunrpc                 57728   1 (autoclean) [nfs nfsd lockd]
af_packet               8016   1 (autoclean)
eepro100               16896   1 (autoclean)
usb-ohci               16112   0 (unused)
usbcore                45520   1 [usb-ohci]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffcfff : System RAM
  00100000-001df603 : Kernel code
  001df604-0022779b : Kernel data
03ffd000-03ffefff : ACPI Tables
03fff000-03ffffff : ACPI Non-volatile Storage
db800000-db80ffff : PCI device 1039:0200
dc000000-dc0fffff : PCI device 8086:1229
dc800000-dc87ffff : PCI device 5333:8a22
dd000000-dd000fff : PCI device 1039:7001
  dd000000-dd000fff : usb-ohci
de000000-de3fffff : PCI device 1039:0200
df000000-df000fff : PCI device 8086:1229
  df000000-df000fff : eepro100
e0000000-e7ffffff : PCI device 5333:8a22
ffff0000-ffffffff : reserved

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
b000-b07f : PCI device 1039:0200
b400-b41f : PCI device 8086:1229
  b400-b41f : eepro100
b800-b807 : PCI device 12b9:1008
  b800-b807 : serial(set)
d000-d00f : PCI device 1039:5513
  d000-d007 : ide0
  d008-d00f : ide1

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] (rev
02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 7
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at d000 [size=16]

00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 10)
(prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at dd000000 (32-bit, non-prefetchable) [size=4K]

00:0a.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01)
(prog-if 02 [16550])
        Subsystem: US Robotics/3Com USR 56k Internal FAX Modem (Model 2977)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b800 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 VGA compatible controller: S3 Inc. Savage 4 (rev 02) (prog-if 00
[VGA])
        Subsystem: Creative Labs 3d Blaster Savage 4
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at dc800000 (32-bit, non-prefetchable) [size=512K]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at 000c0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev
01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at df000000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at b400 [size=32]
        Region 2: Memory at dc000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]

00:13.0 VGA compatible controller: Silicon Integrated Systems [SiS]
5597/5598 VGA (rev 65) (prog-if 00 [VGA])
        Subsystem: Silicon Integrated Systems [SiS] 5597/5598 VGA
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at de000000 (32-bit, prefetchable) [disabled]
[size=4M]
        Region 1: Memory at db800000 (32-bit, non-prefetchable) [disabled]
[size=64K]
        Region 2: I/O ports at b000 [disabled] [size=128]
        Expansion ROM at ddff0000 [disabled] [size=32K]

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Here is some dmesg info:
Linux version 2.4.1-pre8 (root@usr1-ip031-cs.wmis.net) (gcc version 2.95.3
20010
101 (prerelease)) #1 Thu Jan 18 21:15:51 EST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 00000000000a0000 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000003efd000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000002000 @ 0000000003ffd000 (ACPI data)
 BIOS-e820: 0000000000001000 @ 0000000003fff000 (ACPI NVS)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
On node 0 totalpages: 16381
zone(0): 4096 pages.
zone(1): 12285 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=lnew ro root=341
BOOT_FILE=/home/kernel/ker
nel/linux/arch/i386/boot/bzImage console=ttyS1,9600 console=tty0
Initializing CPU#0
Detected 374.229 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 747.11 BogoMIPS
Memory: 62592k/65524k available (893k kernel code, 2548k reserved, 288k
data, 60
k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
CPU: Common caps: 008021bf 808029bf 00000000 00000002
CPU: AMD-K6(tm) 3D processor stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: AMD K6
PCI: PCI BIOS revision 2.10 entry at 0xf0500, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router SIS [1039/0008] at 00:01.0
Disabling direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.0 present.
28 structures occupying 890 bytes.
DMI table at 0x000F540A.
BIOS Vendor: Award Software, Inc.
BIOS Version: ASUS SP97-V ACPI BIOS Revision 1001 B03/18/99
BIOS Release:
System Vendor: System Manufacturer.
Product Name: System Name.
Version System Version.
Serial Number SYS-1234567890.
Board Vendor: ASUSTeK Computer INC..
Board Name: SP97-V.
Board Version: REV 1.XX.
Asset Tag: Asset-1234567890.
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
block: queued sectors max/low 41498kB/31124kB, 128 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 09
IRQ routing conflict in pirq table! Try 'pci=autoirq'
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS5597
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:pio
hda: ST5660A, ATA DISK drive
hdb: IBM-DJAA-31700, ATA DISK drive
hdc: Maxtor 72700 AP, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 1066184 sectors (546 MB) w/256KiB Cache, CHS=528/32/63, DMA
hdb: 3334464 sectors (1707 MB) w/96KiB Cache, CHS=827/64/63, DMA
hdc: 5290320 sectors (2709 MB) w/128KiB Cache, CHS=5248/16/63, DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
 /dev/ide/host0/bus0/target1/lun0: p1
 /dev/ide/host0/bus1/target0/lun0: [PTBL] [656/128/63] p1
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ DETECT_IRQ
SER
IAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PCI: Found IRQ 5 for device 00:0a.0
ttyS02 at port 0xb800 (irq = 5) is a 16550A
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ACPI: System description tables found
ACPI: System description tables loaded
ACPI: Subsystem enabled
ACPI: System firmware supports: C2
ACPI: System firmware supports: S0 S1 S5
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
reiserfs: checking transaction log (device 03:41) ...
Warning, log replay starting on readonly filesystem
reiserfs: replayed 3 transactions in 42 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25
VFS: Mounted root (reiserfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 60k freed
Adding Swap: 18136k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Found IRQ 7 for device 00:01.2
PCI: The same IRQ used for device 00:01.1
usb-ohci.c: USB OHCI at membase 0xc48c9000, IRQ 7
usb-ohci.c: usb-00:01.2, PCI device 1039:7001
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
reiserfs: checking transaction log (device 03:01) ...
reiserfs: replayed 1 transactions in 8 seconds
Using r5 hash to sort names
ReiserFS version 3.6.25

/proc/tty/driver/serial:
serinfo:1.0 driver:5.02 revision:2000-08-09
0: uart:16550A port:3F8 irq:4 baud:230400 tx:13602565 rx:2113469 fe:5
RTS|DTR|DSR|CD
1: uart:16550A port:2F8 irq:3 baud:115200 tx:4852 rx:32 RTS|CTS|DTR|DSR
2: uart:16550A port:B800 irq:5 baud:230400 tx:5286703 rx:485373
RTS|DTR|DSR|CD

setserial info:
/dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4, Flags: low_latency
/dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3, Flags: low_latency
/dev/ttyS2, UART: 16550A, Port: 0xb800, IRQ: 5, Flags: low_latency

/proc/interrupts:
           CPU0
  0:     492337          XT-PIC  timer
  1:          3          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:        361          XT-PIC  serial
  4:    1146775          XT-PIC  serial
  5:     397249          XT-PIC  serial
  7:          0          XT-PIC  usb-ohci
  9:          0          XT-PIC  acpi
 10:      65101          XT-PIC  eth0
 14:      14385          XT-PIC  ide0
 15:       7577          XT-PIC  ide1
NMI:          0
ERR:          0

---
Do I want too much? Would perfection be enough? Even if it came to me, would
it be what I really need?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
