Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSK0Waq>; Wed, 27 Nov 2002 17:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264888AbSK0Waq>; Wed, 27 Nov 2002 17:30:46 -0500
Received: from [66.35.146.201] ([66.35.146.201]:49162 "EHLO int1.nea-fast.com")
	by vger.kernel.org with ESMTP id <S264878AbSK0Wal> convert rfc822-to-8bit;
	Wed, 27 Nov 2002 17:30:41 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: walt <walt@nea-fast.com>
To: kernel <linux-kernel@vger.kernel.org>
Subject: strange file corruption problem with 2.4.18 & 2.4.19
Date: Wed, 27 Nov 2002 17:38:49 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211271738.49627.walt@nea-fast.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted some messages about this a while back and have finally found some 
time to do more testing. I could really use some advise or direction on 
fixing this, or at least help to determine what is wrong.

Here is the situation. I can cp a file via nfs or scp from our file server 
(2.4.3-SGI_XFS_1.0.1) to my workstation.  Most of the time (2 out of 3), the 
file doesn't copy correctly but I get no warnings, errors, or ooopses. I've 
used diff, cmp, and sum to verify the file integrity. When using sum, the 
number of blocks is ALWAYS correct, but not the checksum. I've also verified 
this by coping a 200MB+ gzipped file over and getting crc errors when 
gunzipping.  


Here are some things I've done and been able to reproduce:

Create a tar file on the file server with one directory containing 7750 jpeg 
images. Copy the tar file via nfs to my local machine (I've even tried using 
my local machine as the nfs server). When I untar the file, I get no errors. 
When I diff the newly created directory from the tar file against the same 
directory on the file server, I'll get 5 - 10 images that differ. The images 
themselves appear to be fine, but if you compare them to the originals, you 
can see some difference in contrast and brightness.


Copy a file to my local machine. 
`sum -r file_name`.  
Unmount and mount the file system. 
 `sum -r file_name`. 
The file checksum changes

Copy a file to my local machine. 
`sum -r file_name`. 
`mv file_name new_name`. 
`sum -r new_name`. 
The file checksum changes. In some cases, to the correct checksum

Copy a file to my local machine. 
`sum -r file_name`. 
`mv file_name new_name`. 
`sum -r new_name`. The file checksum changes. 
`mv new_name new_name2`. 
`sum -r new_name`. The file checksum is the same as when it was "new_name".

I've tried RH 2.4.18-x, vanilla 2.4.19, RH7.3-SGI-XFS-1.1, and 
2.4.18-17SGI_XFS_1.2pre3.

I've tried ext2, ext3, and XFS file systems

I've tried turning dma off (hdparam) and compiling kernels without dma with 
the same result.


Here is a list of drives I've tried -
IDE - FUJITSU MPC3043AT, WD 84AA
SCSI - ST34371W

PC info -
[root@walt walt]# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 3).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 3).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device   4, function  0:
    ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 2).
  Bus  0, device   4, function  1:
    IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 1).
      Master Capable.  Latency=32.
      I/O at 0xb800 [0xb80f].
  Bus  0, device   4, function  2:
    USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 1).
      IRQ 10.
      Master Capable.  Latency=32.
      I/O at 0xb400 [0xb41f].
  Bus  0, device   4, function  3:
    Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 2).
      IRQ 9.
  Bus  0, device   9, function  0:
    SCSI storage controller: Artop Electronic Corp AEC6712U SCSI (rev 8).
      IRQ 10.
      Master Capable.  Latency=254.
      I/O at 0xb000 [0xb03f].
      Non-prefetchable 32 bit memory at 0xe1000000 [0xe1000fff].
  Bus  0, device  11, function  0:
    Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang] (rev 0).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
      I/O at 0xa800 [0xa83f].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 
92).
      Master Capable.  Latency=64.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xe2000000 [0xe2ffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xe1800000 [0xe1800fff].
*****************************************************************
root@walt scripts]# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux walt.nea-fast.com 2.4.18-17SGI_XFS_1.2pre3 #1 Thu Nov 7 04:49:56 CST 
2002 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.18
e2fsprogs              1.27
reiserfsprogs          3.x.0j
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         nfs lockd sunrpc soundcore 3c59x atp870u sd_mod 
scsi_mod
*****************************************************************
[root@walt walt]# lspci
00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:09.0 SCSI storage controller: Artop Electronic Corp AEC6712U SCSI (rev 08)
00:0b.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X 
(rev 5c)
*****************************************************************
[root@walt walt]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 267.274
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov mmx
bogomips        : 530.71
*****************************************************************
[root@walt walt]# cat /proc/mounts
rootfs / rootfs rw 0 0
/dev/root / ext2 rw 0 0
/proc /proc proc rw 0 0
none /dev/pts devpts rw 0 0
/dev/hda3 /usr xfs rw 0 0
none /dev/shm tmpfs rw 0 0
fs2.nea-fast.com:/export /export nfs 
rw,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=fs2.nea-fast.com 0 0
fs2.nea-fast.com:/backup /fs2-backup nfs 
rw,v3,rsize=4096,wsize=4096,soft,intr,udp,lock,addr=fs2.nea-fast.com 0 0
/dev/sda2 /opt ext2 rw 0 0
*****************************************************************

[root@walt walt]# cat /proc/partitions
major minor  #blocks  name     rio rmerge rsect ruse wio wmerge wsect wuse 
running use aveq

   8     0    4248442 sda 30863 825830 6835761 2851001 105321 19268028 
24333859 3519265 0 1237160 6378367
   8     1     208813 sda1 162 704 924 1945 849 145838 146695 334130 0 5156 
336396
   8     2    4032315 sda2 30674 825009 6834549 2848642 104465 19122190 
24187150 3185127 0 1231634 6041549
   3     0    4224150 hda 14471 24169 308608 306134 155262 13112 1351106 
1893970 -2 4754121 1978371
   3     1     610438 hda1 8495 6450 119562 208748 154139 9314 1311320 1826490 
0 404023 2037207
   3     2     200812 hda2 112 0 896 1064 191 2651 22736 38765 0 2396 39830
   3     3    3405780 hda3 5862 17713 188134 96296 932 1147 17050 28714 0 
89740 125011
*****************************************************************


Thanks for all your help!
Keep hacking!
-- 
Walter Anthony
System Administrator
National Electronic Attachment
Atlanta, Georgia 
1-800-782-5150 ext. 1608
 "If it's not broke....tweak it"
