Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280149AbRK1TO7>; Wed, 28 Nov 2001 14:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280037AbRK1TOt>; Wed, 28 Nov 2001 14:14:49 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:48255 "EHLO
	shookay.e-steel.com") by vger.kernel.org with ESMTP
	id <S280149AbRK1TNu>; Wed, 28 Nov 2001 14:13:50 -0500
To: matthias@winterdrache.de ("Matthias Benkmann")
Cc: linux-kernel@vger.kernel.org
Subject: Re: sym53c875: reading /proc causes SCSI parity error
In-Reply-To: <3C053AF2.10037.4CCE47@localhost>
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 28 Nov 2001 14:13:42 -0500
In-Reply-To: <3C053AF2.10037.4CCE47@localhost>
Message-ID: <xltelmiso7t.fsf@shookay.e-steel.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I bet it only happens when you're root and you read /proc/scsi/sym53c8xx/0
(or whatever in your case).

I had this discussion with Gérard Roudier and it's not a bug, rather a
feature...

So don't do it!

matthias@winterdrache.de ("Matthias Benkmann") writes:
> I have a reproducible problem that somehow reading from /proc causes a 
> SCSI parity error.
> 
> When I am inside a chroot environment (on my IDE hard disk) with proc 
> mounted on /proc and execute the following script from / (of chroot)
> 
> -----------------------
> #!/bin/sh
> 
> case "z$1" in
>   z) echo Finding
>      find . -path "./old-distro" -prune -or -path "./static" -prune -or -
> path "./usr/src" -prune -or -type f -exec $0 {} \;
>      ;;
>   *) strings $1 | grep -q /static || exit 0
>      echo '*************'$1'****************'
>      strings $1 | grep -A 3 -B 3 /static
>      ;;
> esac
> 
> exit 0
> ----------------------
> 
> and then (not concurrently, can be a minute later) access my SCSI hard 
> disk, I get
> 
> sym53c875-0: SCSI parity error detected: SCR1=132 DBC=1e000000 SBCL=26
> sym53c875-0: restart (scsi reset).
> sym53c875-0: Downloading SCSI SCRIPTS.
> 
> 
> When I access my SCSI hard disk first and use the script afterwards (again 
> there can be some time in between), I get
> 
> sym53c875-0: SCSI parity error detected: SCR1=132 DBC=50000000 SBCL=0
> sym53c875-0: SCSI parity error detected: SCR1=132 DBC=870b0000 SBCL=0
> sym53c875-0:0: ERROR (81:0) (8-0-0) (f/95) @ (script 28:f31c0004).
> sym53c875-0: script cmd = e21c0004
> sym53c875-0: regdump: da 00 00 95 47 0f 00 0f 35 08 80 00 80 00 0f 02.
> sym53c875-0: restart (scsi reset).
> sym53c875-0: Downloading SCSI SCRIPTS.
> 
> 
> I can repeat this as often as I want. The errors stop occuring when I 
> unmount /proc (inside chroot). I can only guess that somehow reading from 
> /proc (note that I forgot to prune /proc in the find command) causes the 
> error. Are there some files in /proc that are not safe for reading?
> And why does it only occur in chroot?
> 
> The error occurs with my normal 2.2.17 kernel and with the 2.4.12-ac3 
> kernel. I have a Tekram DC 390U SCSI controller.
> 
> MSB
> 
> Linux version 2.2.17 (root@(none)) (gcc version 2.95.2 19991024 (release)) 
> #1 Fri Feb 2 14:06:58 CET 2001
> Detected 501122 kHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 999.42 BogoMIPS
> Memory: 257900k/262128k available (940k kernel code, 412k reserved, 2808k 
> data, 68k init)
> Dentry hash table entries: 32768 (order 6, 256k)
> Buffer cache hash table entries: 262144 (order 8, 1024k)
> Page cache hash table entries: 65536 (order 6, 256k)
> CPU: L1 I Cache: 32K  L1 D Cache: 32K
> CPU: AMD-K6(tm) 3D processor stepping 0c
> Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
> PCI: PCI BIOS revision 2.10 entry at 0xf0720
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> Linux NET4.0 for Linux 2.2
> Based upon Swansea University Computer Society NET3.039
> NET4: Unix domain sockets 1.0 for Linux NET4.0.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> TCP: Hash tables configured (ehash 262144 bhash 65536)
> Starting kswapd v 1.5 
> Serial driver version 4.27 with no serial options enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> es1370: version v0.31 time 14:08:53 Feb  2 2001
> es1370: found adapter at io 0xd800 irq 15
> es1370: features: joystick off, line in, mic impedance 0
> RAM disk driver initialized:  16 RAM disks of 4096K size
> loop: registered device at major 7
> Uniform Multi-Platform E-IDE driver Revision: 6.30
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> ALI15X3: IDE controller on PCI bus 00 dev 78
> ALI15X3: chipset revision 193
> ALI15X3: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
> ALI15X3: simplex device:  DMA disabled
> ide1: ALI15X3 Bus-Master DMA disabled (BIOS)
> hda: ST340823A, ATA DISK drive
> ide: Assuming 33MHz system bus speed for PIO modes; override with 
> idebus=xx
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hda: ST340823A, 38166MB w/512kB Cache, CHS=4865/255/63, UDMA(33)
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> sym53c8xx: at PCI bus 0, device 10, function 0
> sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
> sym53c8xx: 53c875 detected with Tekram NVRAM
> sym53c875-0: rev=0x03, base=0xd6000000, io_port=0xd400, irq=12
> sym53c875-0: Tekram format NVRAM, ID 7, Fast-20, Parity Checking
> sym53c875-0: on-chip RAM at 0xd5800000
> sym53c875-0: restart (scsi reset).
> sym53c875-0: Downloading SCSI SCRIPTS.
> scsi0 : sym53c8xx - version 1.3g
> scsi : 1 host.
>   Vendor: IBM       Model: DDRS-34560        Rev: S97B
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
>   Vendor: FUJITSU   Model: M2513E            Rev: 0040
>   Type:   Optical Device                     ANSI SCSI revision: 02
> Detected scsi removable disk sdb at scsi0, channel 0, id 1, lun 0
>   Vendor: TEAC      Model: CD-ROM CD-532S    Rev: 1.0A
>   Type:   CD-ROM                             ANSI SCSI revision: 02
> Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
> sym53c875-0-<0,0>: tagged command queue depth set to 8
> scsi : detected 1 SCSI cdrom 2 SCSI disks total.
> sym53c875-0-<3,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 16)
> sr0: scsi3-mmc drive: 0x/0x caddy
> Uniform CD-ROM driver Revision: 3.11
> sym53c875-0-<0,*>: FAST-20 SCSI 20.0 MB/s (50 ns, offset 15)
> SCSI device sda: hdwr sector= 512 bytes. Sectors= 8925000 [4357 MB] [4.4 
> GB]
> sym53c875-0-<1,*>: FAST-10 SCSI 10.0 MB/s (100 ns, offset 15)
> sdb : READ CAPACITY failed.
> sdb : status = 1, message = 00, host = 0, driver = 28 
> sdb : extended sense code = 2 
> sdb : block size assumed to be 512 bytes, disk size 1GB.  
> ne2k-pci.c:vpre-1.00e 5/27/99 D. Becker/P. Gortmaker 
> http://cesdis.gsfc.nasa.gov/linux/drivers/ne2k-pci.html
> ne2k-pci.c: PCI NE2000 clone 'RealTek RTL-8029' at I/O 0xd000, IRQ 10.
> eth0: RealTek RTL-8029 found at 0xd000, IRQ 10, 00:00:21:C6:1E:30.
> Partition check:
>  sda: sda1 sda2 < sda5 sda6 sda7 >
>  sdb:scsidisk I/O error: dev 08:10, sector 0
>  unable to read partition table
>  hda: hda1 hda2
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 68k freed
> Adding Swap: 72256k swap-space (priority -1)
> strings uses obsolete /proc/pci interface
> 
> 
> 
> ----
> Indecision is the key to flexibility.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
