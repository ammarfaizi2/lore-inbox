Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129998AbRBDEvn>; Sat, 3 Feb 2001 23:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130210AbRBDEvY>; Sat, 3 Feb 2001 23:51:24 -0500
Received: from think.faceprint.com ([166.90.149.11]:38660 "EHLO
	think.faceprint.com") by vger.kernel.org with ESMTP
	id <S129998AbRBDEvS>; Sat, 3 Feb 2001 23:51:18 -0500
Message-ID: <3A7CDF9E.7A52E317@faceprint.com>
Date: Sat, 03 Feb 2001 23:50:38 -0500
From: Nathan Walp <faceprint@faceprint.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
CC: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: Promise PDC20265, VIA KT133 and corruption
In-Reply-To: <20010204035206.A21747@platan.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 
> Hi Andre,
>   if you remember, last week I complained that Promise corrupts data
> when I copy them from hdh to hde. Today I did some more experiments
> (running 2.4.1-ac1) and found:
> 
> 1) Debian sid's 'cmp' prints incorrect offsets when files differ
>    in more than one place if distance > cmp buffer size :-(
> 2) When I read data from hdh (UDMA2 Toshiba) sometime last four
>    bytes of 4KB page (== probably last 4 bytes of read request)
>    are not read at all and old contents of page is left here
>    (it happens about once per 20MB read; and in about 1% of
>    these last 8 bytes of page are incorrect).
>    I have no idea whether promise or KT133 is at fault, but
>    it for sure does not happen under Windows...
> 3) During write some corruption can happen on either hde (IBM
>    DTLA-307045 running UDMA5) or hdh - it looks like that
>    data are shifted on HDD, as fsck then complains about
>    imagic set, dtime set while inode not deleted and so on,
>    and then it cleaned inodes 178200-178300 from my hde :-(
>    Fortunately they were mostly in old kernel trees,
>    not in current data (except one inode, which was just
>    created by dpkg)
> 4) So I compiled kernel without IDE DMA support at all and now
>    everything works at PIO4 without any corruption...
> 
>   If anybody has any idea what I should try to get UDMA to
> work under Linux here...
> 
> lspci:
> 
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
> 00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
> 00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
> 00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
> 00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
> 00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
> 00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
> 00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
> 01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)
> 
>                                         Thanks,
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz


I've got a very similar setup, but i've got a SCSI hard drive as well. 
In copying a rather large file (600+ MB) from my home directory (on the
SCSI drive) to my IDE drive (on the promise controller, ata/100).  scsi
drive is ext2, the ide drive is vfat (basically to share movies and
music w/ windoze).  First try at copying, I got corruption.  Second try,
cp segfaulted.  Looked, and sure enough, had an oops sitting for me in
syslog, so here it is:

ksymoops 2.3.7 on i686 2.4.1-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.1-ac2/ (default)
     -m /boot/System.map-2.4.1-ac2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Feb  3 23:38:01 patience kernel: Unable to handle kernel paging request
at virtual address 81180b00
Feb  3 23:38:01 patience kernel: c0123a60
Feb  3 23:38:01 patience kernel: *pde = 00000000
Feb  3 23:38:01 patience kernel: Oops: 0002
Feb  3 23:38:01 patience kernel: CPU:    0
Feb  3 23:38:01 patience kernel: EIP:   
0010:[__remove_inode_page+48/96]
Feb  3 23:38:01 patience kernel: EFLAGS: 00010202
Feb  3 23:38:01 patience kernel: eax: c102b228   ebx: c1202058   ecx:
00000106   edx: 81180b00
Feb  3 23:38:01 patience kernel: esi: c532a828   edi: c1202058   ebp:
00001532   esp: cc8c5eac
Feb  3 23:38:01 patience kernel: ds: 0018   es: 0018   ss: 0018
Feb  3 23:38:01 patience kernel: Process cp (pid: 483,
stackpage=cc8c5000)
Feb  3 23:38:01 patience kernel: Stack: c1202074 c012a476 c1202058
c0309758 c0309930 00000002 00000000 c012bc18
Feb  3 23:38:01 patience kernel:        c0309758 00000000 c0309938
00000000 00000000 c012bd80 c030992c 00000000
Feb  3 23:38:01 patience kernel:        00000002 00000001 00000000
cc8c5f58 15ece000 00000000 00000005 00000001
Feb  3 23:38:01 patience kernel: Call Trace: [reclaim_page+790/1024]
[__alloc_pages_limit+120/176] [__alloc_pages+304/736]
[generic_file_write+724/1408] [<d2000001>]
[default_fat_file_write+34/80]
Feb  3 23:38:01 patience kernel: Code: 89 02 8b 43 10 8b 53 34 c7 43 08
00 00 00 00 85 c0 74 03 89
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   89 02                     mov    %eax,(%edx)
Code;  00000002 Before first symbol
   2:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  00000005 Before first symbol
   5:   8b 53 34                  mov    0x34(%ebx),%edx
Code;  00000008 Before first symbol
   8:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)
Code;  0000000f Before first symbol
   f:   85 c0                     test   %eax,%eax
Code;  00000011 Before first symbol
  11:   74 03                     je     16 <_EIP+0x16> 00000016 Before
first symbol
Code;  00000013 Before first symbol
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.


patience:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 02)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
(rev 05)
00:09.1 Input device controller: Creative Labs SB Live! (rev 05)
00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
00:0d.0 SCSI storage controller: Adaptec 7892A (rev 02)
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265
(rev 02)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 05)

relevant parts of dmesg:
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 21
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
PDC20265: IDE controller on PCI bus 00 dev 88
PCI: Found IRQ 10 for device 00:11.0
PDC20265: chipset revision 2
PDC20265: not 100% native mode: will probe irqs later
PDC20265: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide2: BM-DMA at 0x7800-0x7807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x7808-0x780f, BIOS settings: hdg:pio, hdh:pio
hda: KENWOOD CD-ROM UCR-421 V221G, ATAPI CD/DVD-ROM drive
hde: IBM-DTLA-307045, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0x9000-0x9007,0x8802 on irq 10
hde: 90069840 sectors (46116 MB) w/1916KiB Cache, CHS=89355/16/63,
UDMA(100)
hda: ATAPI 68X CD-ROM drive, 2048kB Cache, UDMA(33)
<snip>
(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI
0/13/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 392 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
(scsi0:0:0:0) Synchronous at 160.0 Mbyte/sec, offset 31.
  Vendor: SEAGATE   Model: ST318436LW        Rev: 0005
  Type:   Direct-Access                      ANSI SCSI revision: 03
(scsi0:0:4:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: iomega    Model: jaz 1GB           Rev: G.55
  Type:   Direct-Access                      ANSI SCSI revision: 02
(scsi0:0:6:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: HP        Model: CD-Writer+ 9200   Rev: 1.0c
  Type:   CD-ROM                             ANSI SCSI revision: 04
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi removable disk sdb at scsi0, channel 0, id 4, lun 0
SCSI device sda: 35885168 512-byte hdwr sectors (18373 MB)
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3

If there's anything else, I'll get it for you, but this is all I can
think of. 

Nathan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
