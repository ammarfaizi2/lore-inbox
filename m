Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316216AbSEKN1T>; Sat, 11 May 2002 09:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316217AbSEKN1S>; Sat, 11 May 2002 09:27:18 -0400
Received: from netmail.netcologne.de ([194.8.194.109]:49931 "EHLO
	netmail.netcologne.de") by vger.kernel.org with ESMTP
	id <S316216AbSEKN1R>; Sat, 11 May 2002 09:27:17 -0400
Message-Id: <200205111327.AWB48806@netmail.netcologne.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
Reply-To: joergprante@gmx.de
Organization: Linux jungle 2.4.19-pre8 #4 Don Mai 9 23:37:47 CEST 2002 i686 unknown
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] 2.4.19pre8-jp11
Date: Sat, 11 May 2002 15:25:07 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200205102107.AWB17222@netmail.netcologne.de> <20020511010955.GB23320@opeth.ath.cx>
Cc: David Nielsen <Lovechild@foolclan.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just discovered that something in jp11 IDE code is broken because of 
supermount. The supermount patches were originally for 2.4.18 and conflict 
with other parts of the jp patch set. That has been already the case in jp10, 
when supermount was suspended because it caused oopses at boot time.

IDE Disk seems to work, but IDE CD is unusable, for data and audio. 
"HDIO_GETGEO" failed, and user apps get "no valid block device found" even if 
there is a CD inserted. Audio access with KDE gives me "no CD", and cdfs give 
me an oops in sys_lstat64 when trying 'ls' on the mounted device. 

The reason must be in 28_new-stat, which comes with supermount patch. Maybe 
28_new-stat is buggy, or it causes unwanted interaction between the IDE code, 
the stat changes in 2.4.19pre4-pre5, and supermount. I will try upgrading 
the supermount patch. It's not trivial for me and might take some time to 
investigate, and maybe Juan Jose Quintela can point me to the right 
direction (http://people.mandrakesoft.com/~quintela/supermount/2.4.18)

For some "funny" effects see below.

Strong recommendation: please remove the supermount patches from jp11. The 
patches involved are

26_autofs4
27_isrdonly
28_new-stat
29_mediactl
30_llseek
31_mount
32_device
33_supermount

Sorry folks. Any help is strongly appreciated to fix that problem quickly.

Jörg

------- snip -------------------

jungle:/home/joerg # hdparm -I /dev/hdb

/dev/hdb:
 HDIO_GETGEO failed: Invalid argument

 Model=OTHSBI AVD-DOR MDSC-5220                , FwRev=D131    , 
SerialNo=170003
6335
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=128kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 3 : ATA-2 ATA-3 ATA-4 ATA-5

[few minutes later and invoked 'hdparm -i /dev/hda' with ok results]

jungle:/home/joerg # hdparm -i /dev/hdb

/dev/hdb:
 HDIO_GETGEO failed: Invalid argument

 Model=TOSHIBA DVD-ROM SD-C2502, FwRev=1D13, SerialNo=7100303653
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=128kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 3 : ATA-2 ATA-3 ATA-4 ATA-5

---- snip ----

jungle:/home/joerg # mount -t cdfs -o ro /dev/hdb /mnt/cdfs

May 11 12:33:55 jungle kernel: cdfs 0.5b loaded.

jungle:/home/joerg # ls /mnt/cdfs

May 11 12:34:02 jungle kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 0000003c
May 11 12:34:02 jungle kernel:  printing eip:
May 11 12:34:02 jungle kernel: c0141713
May 11 12:34:02 jungle kernel: *pde = 00000000
May 11 12:34:02 jungle kernel: Oops: 0000
May 11 12:34:02 jungle kernel: CPU:    0
May 11 12:34:02 jungle kernel: EIP:    0010:[vfs_lstat+91/148]    Not tainted
May 11 12:34:02 jungle kernel: EFLAGS: 00210246
May 11 12:34:02 jungle kernel: eax: ccd19400   ebx: 00000000   ecx: 00000000  
 edx: cb771bc0
May 11 12:34:02 jungle kernel: esi: cbe41f5c   edi: cbe41f88   ebp: bfffec8c  
 esp: cbe41f50
May 11 12:34:02 jungle kernel: ds: 0018   es: 0018   ss: 0018
May 11 12:34:02 jungle kernel: Process ls (pid: 920, stackpage=cbe41000)
May 11 12:34:02 jungle kernel: Stack: cbe41f88 40164f4c bfffeca4 cb771bc0 
cffe84a0 00000000 3c507f10 00000000
May 11 12:34:02 jungle kernel:        00000008 00000001 c0141e57 bfffeca4 
cbe41f88 cbe40000 00117741 cbe40000
May 11 12:34:02 jungle kernel:        41ed0307 0000000a 00000000 00000000 
00200000 00001000 00000000 3cdcf1ed
May 11 12:34:02 jungle kernel: Call Trace: [sys_lstat64+19/48] 
[system_call+51/56]
May 11 12:34:02 jungle kernel:
May 11 12:34:02 jungle kernel: Code: 83 79 3c 00 74 0e 57 52 8b 44 24 18 50 
8b 41 3c ff d0 eb 0c

---- snip----
On Duron 1Ghz K7S5A board I get the name right, but HDIO_GETGEO failed too.

mountain:/home/joerg # hdparm -I /dev/hdb

/dev/hdb:
 HDIO_GETGEO failed: Invalid argument

 Model=LG DVD-ROM DRD-8160B, FwRev=1.01, SerialNo=
 Config={ Fixed Removeable DTR<=5Mbs DTR>10Mbs nonMagnetic }
 RawCHS=0/0/0, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=0kB, MaxMultSect=0
 (maybe): CurCHS=0/0/0, CurSects=0, LBA=yes, LBAsects=0
 IORDY=on/off, tPIO={min:227,w/IORDY:120}, tDMA={min:120,rec:150}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
 AdvancedPM=no

