Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316527AbSEPASB>; Wed, 15 May 2002 20:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316529AbSEPASA>; Wed, 15 May 2002 20:18:00 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:1028 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316527AbSEPAR5>; Wed, 15 May 2002 20:17:57 -0400
Date: Wed, 15 May 2002 17:17:34 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Nuno Monteiro <nuno@itsari.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with Andre's ide.all.convert patches in 2.4.19pre7
In-Reply-To: <20020515203910.GA957@hobbes.itsari.int>
Message-ID: <Pine.LNX.4.10.10205151713100.392-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Nuno Monteiro wrote:

> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> PIIX4: IDE controller on PCI bus 00 dev 39
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
>      ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
>      ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
> hda: Seagate Technology 1275MB - ST31276A, ATA DISK drive
> hdb: FUJITSU MPF3102AT, ATA DISK drive
> hdc: ATAPI CDROM, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: task_no_data_intr: error=0x04 { DriveStatusError }

That just means the drive aborted the command, no problem here.

> hda: 2502308 sectors (1281 MB), CHS=620/64/63, DMA
> hdb: host protected area => 1
> hdb: 20015856 sectors (10248 MB) w/512KiB Cache, CHS=1245/255/63, UDMA(33)

I had not considered this mix but it could be fatal :-/

Does it run just fine w/o the patch?

> Partition check:
>   hda: hda1
>   hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 >
> 
> Note the task_no_data_intr errors.
> When I boot this kernel, hdparm segfaults when retrieving info for hda:
> 
> root@guernica# hdparm -i /dev/hda
> 
> /dev/hda:
> 
>   Model=Seagate Technology 1275MB - ST31276, FwRev=1.37, SerialNo=FN9RN9K
>   Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>   RawCHS=2482/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>   BuffType=unknown, BuffSize=0kB, MaxMultSect=16, MultSect=16
>   CurCHS=2482/16/63, CurSects=2502308, LBA=yes, LBAsects=2502308
>   IORDY=on/off, tPIO={min:383,w/IORDY:120}, tDMA={min:120,red:120}
>   PIO modes: pio0 pio1 pio2 pio3 pio4
>   DMA modes: mdma0 mdma1 *mdma2
>   AdvancedPM=no
> Segmentation fault (core dumped)
> root@guernica#
> 
> The segfault happens on convert.10 and 2.4.19-pre7-ide6 (all.convert.6). I 
> didnt bother to try and build all.convert.8, and all.convert.7 wouldnt 
> build. And I'm using hdparm v4.9, which I believe is the latest version.

I need to get v4.9 to see if changes in the the hddriveid struct tanks it.

> With _this_ kernel (2.4.19-pre7-ide10), the system boots and _seems_ ok, 
> despite the errors mentioned above. I cant really tell if anything is 
> broken or not because hda is not holding anything other than the bootloader 
> and an empty ReiserFS partition. Eventually I'm going to remove that drive, 
> but I can hold on to it for a while longer if this is indeed a bug and 
> needs testing.
> 
> So, now, with 2.4.19-pre7-ide9 (ide-2.4.19-p7.all.convert.9.bz2). It just 
> wont boot, it'll oops right after printing the identification string for 
> hdc. I copied the oops down to paper and decoded it, if its of any 
> interest, here it is:
> 
> ksymoops 2.4.5 on i586 2.4.19-pre8.  Options used
>       -V (default)
>       -k /proc/ksyms (default)
>       -l /proc/modules (default)
>       -o /lib/modules/2.4.19-pre8/ (default)
>       -m ./System.map-2.4.19-pre7-ide9 (specified)
> 
> Error (regular_file): read_ksyms stat /proc/ksyms failed
> ksymoops: No such file or directory
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> Unable to handle kernel NULL dereference at virtual address 00000040
> c018a4fa
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c018a4fa>]   Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010286
> eax: 00000000  ebx: c0260704  ecx: c0260704  edx: 00000007
> esi: 00000007  edi: c02606c0  ebp: c10e3f70  esp: c10e3f54
> ds: 0010   es: 0018  ss: 0018
> Stack: c0260704 00000282 c02029a0 000001f0 00008124 00000009 c025e23c 
> 0008e000
>         c018b557 00000007 c0260704 c0189a62 00000007 c0260704 c0260704 
> 00000001
>         c02029a0 c019025c c0260704 c02029a0 00000001 c02606c0 00000009 
> c025e23c
> Call Trace: [<c018b557>] [<c0189962>] [<c019025c>] [<c010502f>] [<c0106f90>]
> Code: 8b 40 40 89 45 fc 8a 91 c0 00 00 00 8b 9f 24 03 00 00 c0 ea
> 
> 
> >> EIP; c018a4fa <ide_dmaproc+1e/348>   <=====
> 
> >> ebx; c0260704 <ide_hwifs+44/21e8>
> >> ecx; c0260704 <ide_hwifs+44/21e8>
> >> edi; c02606c0 <ide_hwifs+0/21e8>
> >> ebp; c10e3f70 <END_OF_CODE+e7e8dc/????>
> >> esp; c10e3f54 <END_OF_CODE+e7e8c0/????>
> 
> Trace; c018b557 <piix_dmaproc+23/2c>
> Trace; c0189962 <ide_scan_devices+4e/c0>
> Trace; c019025c <idedisk_init+18/fc>
> Trace; c010502f <init+7/108>
> Trace; c0106f90 <kernel_thread+28/38>
> 
> Code;  c018a4fa <ide_dmaproc+1e/348>
> 00000000 <_EIP>:
> Code;  c018a4fa <ide_dmaproc+1e/348>   <=====
>     0:   8b 40 40                  mov    0x40(%eax),%eax   <=====
> Code;  c018a4fd <ide_dmaproc+21/348>
>     3:   89 45 fc                  mov    %eax,0xfffffffc(%ebp)
> Code;  c018a500 <ide_dmaproc+24/348>
>     6:   8a 91 c0 00 00 00         mov    0xc0(%ecx),%dl
> Code;  c018a506 <ide_dmaproc+2a/348>
>     c:   8b 9f 24 03 00 00         mov    0x324(%edi),%ebx
> Code;  c018a50c <ide_dmaproc+30/348>
>    12:   c0 ea 00                  shr    $0x0,%dl
> 
>   <0>Kernel panic: Attempted to kill init!
> 
> 1 error issued.  Results may not be reliable.
> 
> 
> A final summary, ide-all.convert.6 boots and runs fine, no errors on boot 
> or otherwise, but _will_ segfault hdparm. ide-all.convert.9 will oops on 
> boot, and ide-all.convert.10 will boot but with some errors. All kernels 
> were built with the exact same config, which I'll attach too. So, anyone 
> can give me any pointers? Is that hard drive going south? The mobo? Or is 
> it really a bug? Thanks for any info :)
> 
> 
> Kind regards,
> 
> 
>    -- nuno
> 
> 

Andre Hedrick
LAD Storage Consulting Group

