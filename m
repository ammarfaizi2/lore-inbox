Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSFTMxb>; Thu, 20 Jun 2002 08:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314243AbSFTMxa>; Thu, 20 Jun 2002 08:53:30 -0400
Received: from pD9522E76.dip.t-dialin.net ([217.82.46.118]:18050 "EHLO Frankux")
	by vger.kernel.org with ESMTP id <S314149AbSFTMx2>;
	Thu, 20 Jun 2002 08:53:28 -0400
Subject: BUG: UFS Problem with 2.4.19-pre10-ac2 and 2.5.23
From: Frank <Frank@duranicub.sytes.net>
To: linux-kernel@vger.kernel.org
Cc: mikpe@csd.uu.se
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 20 Jun 2002 14:50:53 +0200
Mime-Version: 1.0
Message-Id: <20020620125513.3B548242FC@Frankux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

below i try to make clear the Bug i found:


[root@Frankux root]# dmesg
...
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c586b (rev 47) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307030, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: host protected area => 1
hda: 60036480 sectors (30739 MB) w/1916KiB Cache, CHS=7445/128/63,
UDMA(33)
Partition check:
 hda: hda1 hda2 hda3
 hda2: <solaris: [s0] hda5 [s1] hda6 [s2] hda7 [s7] hda8 >
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
...


[root@Frankux root]# cat /etc/fstab
LABEL=/                 /                       ext3    defaults       
1 1
none                    /dev/pts                devpts  gid=5,mode=620 
0 0
none                    /proc                   proc    defaults       
0 0
none                    /dev/shm                tmpfs   defaults       
0 0
/dev/hda8               /mnt/hda3               ufs rw,ufstype=sunx86  
0 0
/dev/hda3               swap                    swap    defaults       
0 0
/dev/cdrom              /mnt/cdrom              iso9660
noauto,owner,kudzu,ro 0 0


[root@Frankux hda3]# mount -o remount,rw /mnt/hda3/ (since i must do
this for write Access again)


[root@Frankux root]# cd /mnt/hda3/
[root@Frankux hda3]# ls
#lost+found
[root@Frankux hda3]# mkdir test
[root@Frankux hda3]# ls
lost+found  test
[root@Frankux hda3]# cd test
[root@Frankux test]# ls
[root@Frankux test]# mkdir test2
[root@Frankux test]# ls
[root@Frankux test]# cd test2
[root@Frankux test2]# ls
[root@Frankux test2]# pwd
/mnt/hda3/test/test2
[root@Frankux test2]# cd ..
[root@Frankux test]# pwd
/mnt/hda3/test
[root@Frankux test]# rm test2 (/var/log/messages appeares now Frankux
kernel: UFS-fs warning (device 03:08): empty_dir: bad directory (dir
#19) - no data block


In Summary, if i create a new Directory and change there, no Problem,
but an ls or ls -l dont shows the created Directory. Or an tar -xf is
not possible too

If i mount this Partiton in Solaris8 x86 there are no FS Problems, i can
do just anything there.

System: Linux RH 7.3 with Kernel 2.4.19-pre10-ac2 and 2.5.23

applied only [PATCH][2.4.19-pre10] fs/ufs/super.c:ufs_read_super() fixes
from Mikael Pettersson (mikpe@csd.uu.se)

There are three obvious errors:
1. When checking minimum fragment size the code references the
   wrong variable (block size).
2. Ditto when checking maximum fragment size.
3. (Minor) If the block size is too small, the wrong variable
   (fragment size) is printed in the error message.

The first two patches are already in the current 2.5 code.

/Mikael

--- linux-2.4.19-pre10/fs/ufs/super.c.~1~	Thu Jun  6 14:40:21 2002
+++ linux-2.4.19-pre10/fs/ufs/super.c	Thu Jun  6 14:50:17 2002
@@ -662,12 +662,12 @@
 			uspi->s_fsize);
 		goto failed;
 	}
-	if (uspi->s_bsize < 512) {
+	if (uspi->s_fsize < 512) {
 		printk(KERN_ERR "ufs_read_super: fragment size %u is too small\n",
 			uspi->s_fsize);
 		goto failed;
 	}
-	if (uspi->s_bsize > 4096) {
+	if (uspi->s_fsize > 4096) {
 		printk(KERN_ERR "ufs_read_super: fragment size %u is too large\n",
 			uspi->s_fsize);
 		goto failed;
@@ -679,7 +679,7 @@
 	}
 	if (uspi->s_bsize < 4096) {
 		printk(KERN_ERR "ufs_read_super: block size %u is too small\n",
-			uspi->s_fsize);
+			uspi->s_bsize);
 		goto failed;
 	}
 	if (uspi->s_bsize / uspi->s_fsize > 8) {



--
Frank

