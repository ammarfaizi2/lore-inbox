Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267976AbTCFKQp>; Thu, 6 Mar 2003 05:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267977AbTCFKQp>; Thu, 6 Mar 2003 05:16:45 -0500
Received: from vs-dmz.germanparcel.de ([193.155.135.231]:10969 "EHLO
	vs-dmz.germanparcel.de") by vger.kernel.org with ESMTP
	id <S267976AbTCFKQg> convert rfc822-to-8bit; Thu, 6 Mar 2003 05:16:36 -0500
Subject: Re: ide-problem still with 2.4.21-pre5-ac1
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas.Mieslinger@gls-germany.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.10  March 22, 2002
Message-ID: <OFA9D69D12.A2BE6A15-ONC1256CE1.00344A6F-C1256CE1.0039609A@LocalDomain>
From: Harald.Schaefer@gls-germany.com
Date: Thu, 6 Mar 2003 11:26:43 +0100
X-MIMETrack: Serialize by Router on deln001/europa(Release 5.0.9a |January 7, 2002) at
 03/06/2003 11:26:44 AM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

sorry for sending you directly again instead to the kernel-ML. I do so
because the problems are only caused by ide-disk.c. This mail is CCed to
the ML.

I was able to work around the problem for our little environment (about
2000 Computers of 9 different types) with the following dirty hack,
changing from kernel-2.4.21-pre5-ac1:
1150,1151c1150,1151
<           drive->head       = drive->bios_head = 255;
<           drive->sect       = drive->bios_sect = 63;
---
>           drive->head       = drive->bios_head;
>           drive->sect       = drive->bios_sect;


In your mail you wrote that the kernel honors the mapping of existing
partitions on the disk. Unfortunately the kernel 2.4.21-pre5-ac1 does not
so! I created a primary dos-partition on a Fujitsu-disk attached to a
Compaq Notebook Evo N610c using MS-DOS 6.22 fdisk, which bios uses a
240-head mapping, but linux used a 255-head maping at the next boot. This
may destroy data on the disk.

In ide-disk.c the following remark is listed at line 1127:
 *    1. CHS value set by user       (whatever user sets will be trusted)
 *    2. LBA value from target drive (require new ATA feature)
 *    3. LBA value from system BIOS  (new one is OK, old one may break)
 *    4. CHS value from system BIOS  (traditional style)

I think that the priority of LBA from BIOS has to be raised to 2 and the
priority of LBA from drive should be lowered to 3.
The mapping-problem only appreared with very new drives in some
brand-computers using a 240-head mapping from the bios.

We don't know which problems our workaround causes, but we're happy with it
and would like to see it in an upcoming release. Why was a 255 head mapping
hard coded in the kernel?

--snip--

On Tue, 2003-03-04 at 15:17, Harald.Schaefer@gls-germany.com wrote:
> [1.] One line summary of the problem:
> ide-drives are sometimes recognized with LBA-Mapping, even if the bios is
> configured diffrent

The kernel honours the partition mapping data it finds in the partition
table for. Its very hard to use/guess the bios mappings and for many
systems its not available hence we do this.

When we find the partition table doesn't seem to agree with the mapping
you'll see [PTBL] in the partition info when it probes the disk.

Can you post the query to the linux-kernel list rather than just to me.
I'm the IDE guy but people like Andries are the partitioning gurus

--snip--
Hello Alan,

we found a problem with the ide-drivers at some of our Computers.


[1.] One line summary of the problem:
ide-drives are sometimes recognized with LBA-Mapping, even if the bios is
configured diffrent

[2.] Full description of the problem/report:
kernel 2.2.22 was running fine and used the correct bios-mapping every time
the kernel 2.4.20 always uses lba-mapping regardless of the bios setting.
kernel 2.4.21-pre3 and -pre5 recognize the correct Disc mapping if the bios
uses by default LBA.
the patch 2.4.21-pre5-ac1 does the same as 2.4.21-pre3/pre5
If the bios uses by default bit shift or large mode the kernel recognize
the correct mapping
of the disc if a WDC WD400BB-60DGA0 or a Maxtor 4D040H2 is attached.
If a FUJITSU MHR2030AT or a Maxtor 6E040L0 is attached the kernel gets
confused. See
hdparam -i and -I outputs at the end of this document.

We create fdisk partitions with linux and run later dos from one of that
partitions. Dos gets
confused about the linux mapping of the partion that is different from the
bios supplied values.


[3.] Keywords (i.e., modules, networking, kernel):
ide, mapping, bios, lba

[4.] Kernel version (from /proc/version):
Linux version 2.4.21-pre3 (harri@eisler.fet.uni-hannover.de) (gcc version
2.95.4 20011002 (Debian prerelease)) #5 Mit Jan 22 11:33:07 CET 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
not available

[6.] A small shell script or example program which triggers the
     problem (if possible)
not available

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

[7.2.] Processor information (from /proc/cpuinfo):
the problem appears on some new Compaq-Desktops and Notebooks with
different CPU's
We have seen this also on older HP vli8 (PIII 650) and HP Omnibook 6000
(PIII 600).

Evo N610c Notebook for Example:
degpn025w130 # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.60GHz
stepping        : 4
cpu MHz         : 1594.851
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat p
se36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3185.04

Evo N510 Desktop:
degpn025w135 # cat proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 1.80GHz
stepping        : 4
cpu MHz         : 1794.239
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3578.26

[7.3.] Module information (from /proc/modules):
degpn025w130 # cat /proc/modules
nls_cp850               3404   0 (unused)
smbfs                  32360   1
ipt_reject              2616   1
ipt_masquerade           980   1
ipt_state                388   1
iptable_nat            13740   1 [ipt_masquerade]
iptable_filter          1468   1
ip_conntrack           15884   2 [ipt_masquerade ipt_state iptable_nat]
ip_tables              10656   7 [ipt_reject ipt_masquerade ipt_state
iptable_nat iptable_filter]
ds                      6604   2
i82365                 23076   2
pcmcia_core            43584   0 [ds i82365]
e100                   50516   1

degpn025w135 # cat /proc/modules
nls_cp850               3404   0 (unused)
smbfs                  32360   1
ipt_reject              2616   1
ipt_masquerade           980   1
ipt_state                388   1
iptable_nat            13740   1 [ipt_masquerade]
iptable_filter          1468   1
ip_conntrack           15884   2 [ipt_masquerade ipt_state iptable_nat]
ip_tables              10656   7 [ipt_reject ipt_masquerade ipt_state
iptable_nat iptable_filter]
e100                   50516   1


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
degpn025w130 # cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03e8-03ef : serial(auto)
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
2000-20ff : PCI device 11c1:0450
2400-243f : PCI device 8086:1038
  2400-243f : e100
2440-2447 : PCI device 11c1:0450
3000-3fff : PCI Bus #01
  3000-30ff : PCI device 1002:4c57
4000-40ff : PCI device 8086:2485
4400-443f : PCI device 8086:2485
4440-444f : PCI device 8086:248a
  4440-4447 : ide0
  4448-444f : ide1

degpn025w130 # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffcffff : System RAM
  00100000-001ce347 : Kernel code
  001ce348-002013bf : Kernel data
0ffd0000-0fff0bff : reserved
0fff0c00-0fffbfff : ACPI Non-volatile Storage
0fffc000-0fffffff : reserved
10000000-100003ff : PCI device 8086:248a
40000000-40000fff : PCI device 104c:ac51
  40000000-40000fff : i82365
40080000-40080fff : PCI device 104c:ac51
  40080000-40080fff : i82365
40100000-40100fff : PCI device 8086:1038
  40100000-40100fff : e100
40180000-40180fff : PCI device 1033:0035
40200000-40200fff : PCI device 1033:0035
40280000-402800ff : PCI device 11c1:0450
40300000-403000ff : PCI device 1033:00e0
40400000-404fffff : PCI Bus #01
  40400000-4040ffff : PCI device 1002:4c57
48000000-4fffffff : PCI Bus #01
  48000000-4fffffff : PCI device 1002:4c57
60000000-6fffffff : PCI device 8086:1a30


degpn025w135 # cat /proc/ioports
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
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-103f : PCI device 8086:103b
  1000-103f : e100
2000-20ff : PCI device 8086:24c5
2400-243f : PCI device 8086:24c5
2440-245f : PCI device 8086:24c2
2460-247f : PCI device 8086:24c4
24a0-24af : PCI device 8086:24cb
  24a0-24a7 : ide0
  24a8-24af : ide1

degpn025w135 # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0f7effff : System RAM
  00100000-001ce347 : Kernel code
  001ce348-002013bf : Kernel data
0f7f0000-0f7fffff : reserved
10000000-100003ff : PCI device 8086:24cb
f0000000-f7ffffff : PCI device 8086:2562
f8000000-fbffffff : PCI device 8086:2560
fc400000-fc47ffff : PCI device 8086:2562
fc480000-fc4803ff : PCI device 8086:24cd
fc480400-fc4805ff : PCI device 8086:24c5
fc480600-fc4806ff : PCI device 8086:24c5
fc500000-fc500fff : PCI device 8086:103b
  fc500000-fc500fff : e100
fec00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
sorry, lspci is not available on this linux-bootdisk. output of "cat
/proc/pci" instead
degpn025w130 # cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 8086:1a30 (rev 4).
      Prefetchable 32 bit memory at 0x60000000 [0x6fffffff].
  Bus  0, device   1, function  0:
    Class 0604: PCI device 8086:1a31 (rev 4).
      Master Capable.  Latency=64.  Min Gnt=12.
  Bus  0, device  30, function  0:
    Class 0604: PCI device 8086:2448 (rev 66).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    Class 0601: PCI device 8086:248c (rev 2).
  Bus  0, device  31, function  1:
    Class 0101: PCI device 8086:248a (rev 2).
      IRQ 11.
      I/O at 0x4440 [0x444f].
      Non-prefetchable 32 bit memory at 0x10000000 [0x100003ff].
  Bus  0, device  31, function  5:
    Class 0401: PCI device 8086:2485 (rev 2).
      IRQ 11.
      I/O at 0x4000 [0x40ff].
      I/O at 0x4400 [0x443f].
  Bus  1, device   0, function  0:
    Class 0300: PCI device 1002:4c57 (rev 0).
      IRQ 11.
      Master Capable.  Latency=66.  Min Gnt=8.
      Prefetchable 32 bit memory at 0x48000000 [0x4fffffff].
      I/O at 0x3000 [0x30ff].
      Non-prefetchable 32 bit memory at 0x40400000 [0x4040ffff].
  Bus  2, device   4, function  0:
    Class 0780: PCI device 11c1:0450 (rev 2).
      IRQ 11.
      Master Capable.  Latency=66.  Min Gnt=252.Max Lat=14.
      Non-prefetchable 32 bit memory at 0x40280000 [0x402800ff].
      I/O at 0x2440 [0x2447].
      I/O at 0x2000 [0x20ff].
  Bus  2, device   6, function  0:
    Class 0607: PCI device 104c:ac51 (rev 0).
      IRQ 11.
      Master Capable.  Latency=66.  Min Gnt=196.Max Lat=7.
      Non-prefetchable 32 bit memory at 0x40000000 [0x40000fff].
  Bus  2, device   6, function  1:
    Class 0607: PCI device 104c:ac51 (rev 0).
      IRQ 11.
      Master Capable.  Latency=66.  Min Gnt=196.Max Lat=7.
      Non-prefetchable 32 bit memory at 0x40080000 [0x40080fff].
  Bus  2, device   8, function  0:
    Class 0200: PCI device 8086:1038 (rev 66).
      IRQ 10.
      Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0x40100000 [0x40100fff].
      I/O at 0x2400 [0x243f].
  Bus  2, device  14, function  0:
    Class 0c03: PCI device 1033:0035 (rev 65).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0x40180000 [0x40180fff].
  Bus  2, device  14, function  1:
    Class 0c03: PCI device 1033:0035 (rev 65).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0x40200000 [0x40200fff].
  Bus  2, device  14, function  2:
    Class 0c03: PCI device 1033:00e0 (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=34.
      Non-prefetchable 32 bit memory at 0x40300000 [0x403000ff].


degpn025w135 # cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 8086:2560 (rev 1).
      Prefetchable 32 bit memory at 0xf8000000 [0xfbffffff].
  Bus  0, device   2, function  0:
    Class 0300: PCI device 8086:2562 (rev 1).
      IRQ 10.
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
      Non-prefetchable 32 bit memory at 0xfc400000 [0xfc47ffff].
  Bus  0, device  29, function  0:
    Class 0c03: PCI device 8086:24c2 (rev 1).
      IRQ 10.
      I/O at 0x2440 [0x245f].
  Bus  0, device  29, function  1:
    Class 0c03: PCI device 8086:24c4 (rev 1).
      IRQ 11.
      I/O at 0x2460 [0x247f].
  Bus  0, device  29, function  7:
    Class 0c03: PCI device 8086:24cd (rev 1).
      IRQ 5.
      Non-prefetchable 32 bit memory at 0xfc480000 [0xfc4803ff].
  Bus  0, device  30, function  0:
    Class 0604: PCI device 8086:244e (rev 129).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    Class 0601: PCI device 8086:24c0 (rev 1).
  Bus  0, device  31, function  1:
    Class 0101: PCI device 8086:24cb (rev 1).
      IRQ 10.
      I/O at 0x24a0 [0x24af].
      Non-prefetchable 32 bit memory at 0x10000000 [0x100003ff].
  Bus  0, device  31, function  5:
    Class 0401: PCI device 8086:24c5 (rev 1).
      IRQ 5.
      I/O at 0x2000 [0x20ff].
      I/O at 0x2400 [0x243f].
      Non-prefetchable 32 bit memory at 0xfc480400 [0xfc4805ff].
      Non-prefetchable 32 bit memory at 0xfc480600 [0xfc4806ff].
  Bus  5, device   8, function  0:
    Class 0200: PCI device 8086:103b (rev 129).
      IRQ 5.
      Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfc500000 [0xfc500fff].
      I/O at 0x1000 [0x103f].


[7.6.] SCSI information (from /proc/scsi/scsi)
scsi drivers are not loaded.
degpn025w135 # cat  /proc/scsi/scsi
cat: /proc/scsi/scsi: No such file or directory


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):



[X.] Other notes, patches, fixes, workarounds:
if the bios ist forced to use lba-mapping everything is running fine.
but in the notebook-bios mapping setting cannot be changed. It is set to
"bit shift" on
fujitsu disks

some harddisk are recognized with lba-setting, these models are running
fine.
output of "hdparm -i /dev/hda" and "hdparm -I /dev/hda" of some good disks:
hdparm -i /dev/hda
 Model=Maxtor 4D040H2, FwRev=DAH017K0, SerialNo=D22AKNYE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80043264
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

hdparm -I /dev/hda
 Model=aMtxro4 0D042H                          , FwRev=AD0H710K,
SerialNo=2DA2NKEY
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=80043264
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

hdparm -i /dev/hda
 Model=WDC WD400BB-60DGA0, FwRev=05.03E05, SerialNo=WD-WMADK1725099
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

hdparm -I /dev/hda
 Model=DW CDW04B0-B06GD0A                      , FwRev=500.E350,
SerialNo=DWW-AMKD715290
 Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
 RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5


and a bad disk, which is recognized with "bit shift"-mapping from the bios:

hdparm -i /dev/hda
 Model=Maxtor 6E040L0, FwRev=NAR61590, SerialNo=E11G00EE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

hdparm -I /dev/hda
 Model=aMtxro6 0E040L                          , FwRev=AN6R5109,
SerialNo=1EG100EE
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=78165360
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

another disk that doesn't work

hdparm -i /dev/hda
 Model=FUJITSU MHR2030AT, FwRev=53BB, SerialNo=NJ36T2813MYW
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=58605120
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

hdparm -I /dev/hda
 Model=UFIJST UHM2R30A0 T                      , FwRev=35BB    , SerialNo=
JN632T18M3WY
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=65535/1/63, CurSects=4128705, LBA=yes, LBAsects=58605120
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5


Harald Schäfer
--
GLS Germany
Basissysteme

Telefon +49 (0) 66 77 17 466



