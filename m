Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSHTXjg>; Tue, 20 Aug 2002 19:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317506AbSHTXjf>; Tue, 20 Aug 2002 19:39:35 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:11480 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317498AbSHTXjG>; Tue, 20 Aug 2002 19:39:06 -0400
Subject: [BK-2.5 PATCH] NTFS 2.1.0 1/7: Add config option for writing
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 21 Aug 2002 00:43:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17hIeV-0001Jb-00@storm.christs.cam.ac.uk>
From: Anton Altaparmakov <aia21@cantab.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.5

Below is the 1st of 7 ChangeSets updating NTFS to 2.1.0, which you
will get when you bk pull the ntfs-2.5 repository. Together they implement
file overwrite support for NTFS.

This first ChangeSet is the only one touching files outside fs/ntfs/ and
the files touched are only the defconfig files and fs/Config.in and
fs/Config.help, which are updated adding a new configuration option for the
new write support.

The remaining ChangeSets add the actual write code in small chunks.

I would like to thank Andrew Morton and Al Viro for investing their time
and answering the numerous questions I had.

Comments on the code would be appreciated, so get reading everyone. (-:

The current code is relatively well tested both for mmap(2) and write(2)
both using existing applications to randomly write to files and using
custom programs to do specialized writes to test boundary conditions.

Still the code has only been run on two machines, so people trying it,
please have backups! I am confident it won't eat your data, but I am not
willing to guarantee it! I have put in an appropriately very scary config
help message to scare off the casual user for the moment...

Features of NTFS 2.1.0
======================

It is now possible to write over existing files both with mmap(2)
and write(2).

It is now possible to setup a loopback on an NTFS file and then you have
full read/write access to the loopback device. You can create a Linux fs
on the loop device for example and mount it.

This has been a much requested feature because it allows installation of
Linux on an NTFS partition using the loopback trick, i.e. from windows one
creates a large file on NTFS, then one boots Linux (from installation CD,
rescue floppies or whatever) and as root does:

mount -t ntfs -o rw /dev/hda1 /mnt/ntfs
losetup /dev/loop0 /mnt/ntfs/some_dir/preprepared_large_file
mke2fs -j /dev/loop0
mount -t ext3 /dev/loop0 /mnt/new_root
mkdir old_root
<install Linux into /mnt/new_root>
umount /mnt/new_root
losetup -d /dev/loop0
umount /mnt/ntfs

>From now on, you can boot Linux and using a minimal ramdisk loaded via
floppy for example, one just needs to have something simillar to the
following done:

mount -t ntfs -o rw /dev/hda1 /mnt/ntfs
mount -t ext3 -o loop /ntfs/some_dir/preprepared_large_file /mnt/new_root
cd /mnt/new_root
pivot_root . old_root
exec chroot . sh <dev/console >dev/console 2>&1
umount /old-root

[Note you probably cannot umount /old-root but it doesn't matter. It doesn't
disturb anyone... You could always hide it inside root/old_root or something
so users don't see it.]

I haven't actually tried to install Linux in the above way but Richard
Russon (flatcap) tested the loopback/mke2fs/read-write stuff and it
worked fine for him.

Limitations of NTFS 2.1.0 overwrite abilities
=============================================

- Resident files only written to in memory so far, i.e. writes to files
  smaller than 1kiB won't be permanent. Warnings to that effect are shown
  via printk().

- Filling in of holes/non-initialized areas is not supported yes.

- File resize/truncate not implemented and actively trapped and aborted.

Anyone who tries this new code please let me know how you get on...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

This will update the following files:

 arch/alpha/defconfig                               |    1 +
 arch/arm/def-configs/a5k                           |    1 +
 arch/arm/def-configs/adi_evb                       |    1 +
 arch/arm/def-configs/adsbitsy                      |    1 +
 arch/arm/def-configs/anakin                        |    1 +
 arch/arm/def-configs/assabet                       |    1 +
 arch/arm/def-configs/badge4                        |    1 +
 arch/arm/def-configs/brutus                        |    1 +
 arch/arm/def-configs/cerfcube                      |    1 +
 arch/arm/def-configs/cerfpda                       |    1 +
 arch/arm/def-configs/cerfpod                       |    1 +
 arch/arm/def-configs/clps7500                      |    2 ++
 arch/arm/def-configs/ebsa110                       |    1 +
 arch/arm/def-configs/edb7211                       |    1 +
 arch/arm/def-configs/empeg                         |    1 +
 arch/arm/def-configs/epxa10db                      |    1 +
 arch/arm/def-configs/flexanet                      |    1 +
 arch/arm/def-configs/footbridge                    |    1 +
 arch/arm/def-configs/fortunet                      |    1 +
 arch/arm/def-configs/freebird                      |    1 +
 arch/arm/def-configs/freebird_new                  |    1 +
 arch/arm/def-configs/graphicsclient                |    1 +
 arch/arm/def-configs/graphicsmaster                |    1 +
 arch/arm/def-configs/h3600                         |    1 +
 arch/arm/def-configs/huw_webpanel                  |    1 +
 arch/arm/def-configs/integrator                    |    1 +
 arch/arm/def-configs/iq80310                       |    1 +
 arch/arm/def-configs/jornada720                    |    1 +
 arch/arm/def-configs/lart                          |    1 +
 arch/arm/def-configs/lubbock                       |    1 +
 arch/arm/def-configs/lusl7200                      |    1 +
 arch/arm/def-configs/neponset                      |    1 +
 arch/arm/def-configs/omnimeter                     |    1 +
 arch/arm/def-configs/pangolin                      |    1 +
 arch/arm/def-configs/pfs168_mqtft                  |    1 +
 arch/arm/def-configs/pfs168_mqvga                  |    1 +
 arch/arm/def-configs/pfs168_sastn                  |    1 +
 arch/arm/def-configs/pfs168_satft                  |    1 +
 arch/arm/def-configs/pleb                          |    1 +
 arch/arm/def-configs/rpc                           |    1 +
 arch/arm/def-configs/shannon                       |    2 ++
 arch/arm/def-configs/shark                         |    1 +
 arch/arm/def-configs/sherman                       |    2 ++
 arch/arm/def-configs/stork                         |    1 +
 arch/arm/def-configs/system3                       |    1 +
 arch/arm/defconfig                                 |    1 +
 arch/cris/defconfig                                |    1 +
 arch/i386/defconfig                                |    1 +
 arch/ia64/defconfig                                |    1 +
 arch/ia64/sn/configs/sn1/defconfig-bigsur-mp       |    1 +
 arch/ia64/sn/configs/sn1/defconfig-bigsur-sp       |    1 +
 arch/ia64/sn/configs/sn1/defconfig-dig-mp          |    1 +
 arch/ia64/sn/configs/sn1/defconfig-dig-sp          |    1 +
 arch/ia64/sn/configs/sn1/defconfig-generic-mp      |    1 +
 arch/ia64/sn/configs/sn1/defconfig-generic-sp      |    1 +
 arch/ia64/sn/configs/sn1/defconfig-hp-sp           |    1 +
 arch/ia64/sn/configs/sn1/defconfig-prom-medusa     |    1 +
 arch/ia64/sn/configs/sn1/defconfig-sn1-mp          |    1 +
 arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules  |    1 +
 arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0   |    1 +
 arch/ia64/sn/configs/sn1/defconfig-sn1-sp          |    1 +
 arch/ia64/sn/configs/sn2/defconfig-dig-numa        |    1 +
 arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp      |    1 +
 arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp      |    1 +
 arch/ia64/sn/configs/sn2/defconfig-sn2-mp          |    1 +
 arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules  |    1 +
 arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa |    1 +
 arch/ia64/sn/configs/sn2/defconfig-sn2-sp          |    1 +
 arch/m68k/defconfig                                |    2 ++
 arch/mips/defconfig                                |    1 +
 arch/mips/defconfig-atlas                          |    1 +
 arch/mips/defconfig-ddb5476                        |    1 +
 arch/mips/defconfig-ddb5477                        |    1 +
 arch/mips/defconfig-decstation                     |    1 +
 arch/mips/defconfig-ip22                           |    1 +
 arch/mips/defconfig-it8172                         |    1 +
 arch/mips/defconfig-malta                          |    1 +
 arch/mips/defconfig-nino                           |    1 +
 arch/mips/defconfig-ocelot                         |    1 +
 arch/mips/defconfig-pb1000                         |    1 +
 arch/mips/defconfig-rm200                          |    1 +
 arch/mips64/defconfig                              |    1 +
 arch/mips64/defconfig-ip22                         |    1 +
 arch/mips64/defconfig-ip27                         |    1 +
 arch/mips64/defconfig-ip32                         |    1 +
 arch/parisc/defconfig                              |    1 +
 arch/ppc/configs/FADS_defconfig                    |    1 +
 arch/ppc/configs/IVMS8_defconfig                   |    1 +
 arch/ppc/configs/SM850_defconfig                   |    1 +
 arch/ppc/configs/SPD823TS_defconfig                |    1 +
 arch/ppc/configs/TQM823L_defconfig                 |    1 +
 arch/ppc/configs/TQM8260_defconfig                 |    1 +
 arch/ppc/configs/TQM850L_defconfig                 |    1 +
 arch/ppc/configs/TQM860L_defconfig                 |    1 +
 arch/ppc/configs/adir_defconfig                    |    1 +
 arch/ppc/configs/apus_defconfig                    |    1 +
 arch/ppc/configs/ash_defconfig                     |    1 +
 arch/ppc/configs/bseip_defconfig                   |    1 +
 arch/ppc/configs/ceder_defconfig                   |    1 +
 arch/ppc/configs/common_defconfig                  |    1 +
 arch/ppc/configs/cpci405_defconfig                 |    1 +
 arch/ppc/configs/ep405_defconfig                   |    1 +
 arch/ppc/configs/est8260_defconfig                 |    1 +
 arch/ppc/configs/ev64260_defconfig                 |    1 +
 arch/ppc/configs/gemini_defconfig                  |    1 +
 arch/ppc/configs/iSeries_defconfig                 |    1 +
 arch/ppc/configs/ibmchrp_defconfig                 |    1 +
 arch/ppc/configs/k2_defconfig                      |    1 +
 arch/ppc/configs/lopec_defconfig                   |    1 +
 arch/ppc/configs/mbx_defconfig                     |    1 +
 arch/ppc/configs/mcpn765_defconfig                 |    1 +
 arch/ppc/configs/menf1_defconfig                   |    1 +
 arch/ppc/configs/mvme5100_defconfig                |    1 +
 arch/ppc/configs/oak_defconfig                     |    1 +
 arch/ppc/configs/pcore_defconfig                   |    1 +
 arch/ppc/configs/pmac_defconfig                    |    1 +
 arch/ppc/configs/power3_defconfig                  |    1 +
 arch/ppc/configs/pplus_defconfig                   |    1 +
 arch/ppc/configs/prpmc750_defconfig                |    1 +
 arch/ppc/configs/prpmc800_defconfig                |    1 +
 arch/ppc/configs/redwood5_defconfig                |    1 +
 arch/ppc/configs/redwood_defconfig                 |    1 +
 arch/ppc/configs/rpxcllf_defconfig                 |    1 +
 arch/ppc/configs/rpxlite_defconfig                 |    1 +
 arch/ppc/configs/sandpoint_defconfig               |    1 +
 arch/ppc/configs/spruce_defconfig                  |    1 +
 arch/ppc/configs/walnut_defconfig                  |    1 +
 arch/ppc/configs/zx4500_defconfig                  |    1 +
 arch/ppc/defconfig                                 |    1 +
 arch/ppc64/defconfig                               |    1 +
 arch/s390/defconfig                                |    1 +
 arch/s390x/defconfig                               |    1 +
 arch/sh/defconfig                                  |    1 +
 arch/sparc/defconfig                               |    1 +
 arch/sparc64/defconfig                             |    1 +
 arch/x86_64/defconfig                              |    1 +
 fs/Config.help                                     |    9 +++++++++
 fs/Config.in                                       |    1 +
 fs/ntfs/Makefile                                   |    8 ++++----
 139 files changed, 154 insertions(+), 4 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (02/08/13 1.456.26.2)
   NTFS: Add configuration option for developmental write support.


diff -Nru a/arch/alpha/defconfig b/arch/alpha/defconfig
--- a/arch/alpha/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/alpha/defconfig	Tue Aug 20 23:56:26 2002
@@ -572,6 +572,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/a5k b/arch/arm/def-configs/a5k
--- a/arch/arm/def-configs/a5k	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/a5k	Tue Aug 20 23:56:26 2002
@@ -385,6 +385,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/adi_evb b/arch/arm/def-configs/adi_evb
--- a/arch/arm/def-configs/adi_evb	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/adi_evb	Tue Aug 20 23:56:26 2002
@@ -529,6 +529,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/adsbitsy b/arch/arm/def-configs/adsbitsy
--- a/arch/arm/def-configs/adsbitsy	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/adsbitsy	Tue Aug 20 23:56:26 2002
@@ -479,6 +479,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/anakin b/arch/arm/def-configs/anakin
--- a/arch/arm/def-configs/anakin	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/anakin	Tue Aug 20 23:56:26 2002
@@ -509,6 +509,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/assabet b/arch/arm/def-configs/assabet
--- a/arch/arm/def-configs/assabet	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/assabet	Tue Aug 20 23:56:26 2002
@@ -658,6 +658,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/badge4 b/arch/arm/def-configs/badge4
--- a/arch/arm/def-configs/badge4	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/badge4	Tue Aug 20 23:56:26 2002
@@ -844,6 +844,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/arm/def-configs/brutus b/arch/arm/def-configs/brutus
--- a/arch/arm/def-configs/brutus	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/brutus	Tue Aug 20 23:56:26 2002
@@ -223,6 +223,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/cerfcube b/arch/arm/def-configs/cerfcube
--- a/arch/arm/def-configs/cerfcube	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/cerfcube	Tue Aug 20 23:56:26 2002
@@ -647,6 +647,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/cerfpda b/arch/arm/def-configs/cerfpda
--- a/arch/arm/def-configs/cerfpda	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/cerfpda	Tue Aug 20 23:56:26 2002
@@ -685,6 +685,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/cerfpod b/arch/arm/def-configs/cerfpod
--- a/arch/arm/def-configs/cerfpod	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/cerfpod	Tue Aug 20 23:56:26 2002
@@ -649,6 +649,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/clps7500 b/arch/arm/def-configs/clps7500
--- a/arch/arm/def-configs/clps7500	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/clps7500	Tue Aug 20 23:56:26 2002
@@ -420,6 +420,8 @@
 # CONFIG_ISO9660_FS is not set
 CONFIG_MINIX_FS=y
 # CONFIG_NTFS_FS is not set
+# CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/ebsa110 b/arch/arm/def-configs/ebsa110
--- a/arch/arm/def-configs/ebsa110	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/ebsa110	Tue Aug 20 23:56:26 2002
@@ -531,6 +531,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/edb7211 b/arch/arm/def-configs/edb7211
--- a/arch/arm/def-configs/edb7211	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/edb7211	Tue Aug 20 23:56:26 2002
@@ -330,6 +330,7 @@
 CONFIG_MINIX_FS=y
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/empeg b/arch/arm/def-configs/empeg
--- a/arch/arm/def-configs/empeg	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/empeg	Tue Aug 20 23:56:26 2002
@@ -1,4 +1,5 @@
 #
+#
 # Example empeg-car kernel configuration file.
 #
 CONFIG_ARM=y
diff -Nru a/arch/arm/def-configs/epxa10db b/arch/arm/def-configs/epxa10db
--- a/arch/arm/def-configs/epxa10db	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/epxa10db	Tue Aug 20 23:56:26 2002
@@ -544,6 +544,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/flexanet b/arch/arm/def-configs/flexanet
--- a/arch/arm/def-configs/flexanet	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/flexanet	Tue Aug 20 23:56:26 2002
@@ -642,6 +642,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/footbridge b/arch/arm/def-configs/footbridge
--- a/arch/arm/def-configs/footbridge	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/footbridge	Tue Aug 20 23:56:26 2002
@@ -615,6 +615,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/fortunet b/arch/arm/def-configs/fortunet
--- a/arch/arm/def-configs/fortunet	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/fortunet	Tue Aug 20 23:56:26 2002
@@ -455,6 +455,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/freebird b/arch/arm/def-configs/freebird
--- a/arch/arm/def-configs/freebird	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/freebird	Tue Aug 20 23:56:26 2002
@@ -492,6 +492,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/freebird_new b/arch/arm/def-configs/freebird_new
--- a/arch/arm/def-configs/freebird_new	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/freebird_new	Tue Aug 20 23:56:26 2002
@@ -512,6 +512,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/graphicsclient b/arch/arm/def-configs/graphicsclient
--- a/arch/arm/def-configs/graphicsclient	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/graphicsclient	Tue Aug 20 23:56:26 2002
@@ -585,6 +585,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/graphicsmaster b/arch/arm/def-configs/graphicsmaster
--- a/arch/arm/def-configs/graphicsmaster	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/graphicsmaster	Tue Aug 20 23:56:26 2002
@@ -560,6 +560,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/h3600 b/arch/arm/def-configs/h3600
--- a/arch/arm/def-configs/h3600	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/h3600	Tue Aug 20 23:56:26 2002
@@ -650,6 +650,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/huw_webpanel b/arch/arm/def-configs/huw_webpanel
--- a/arch/arm/def-configs/huw_webpanel	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/huw_webpanel	Tue Aug 20 23:56:26 2002
@@ -336,6 +336,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/integrator b/arch/arm/def-configs/integrator
--- a/arch/arm/def-configs/integrator	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/integrator	Tue Aug 20 23:56:26 2002
@@ -543,6 +543,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/iq80310 b/arch/arm/def-configs/iq80310
--- a/arch/arm/def-configs/iq80310	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/iq80310	Tue Aug 20 23:56:26 2002
@@ -638,6 +638,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/jornada720 b/arch/arm/def-configs/jornada720
--- a/arch/arm/def-configs/jornada720	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/jornada720	Tue Aug 20 23:56:26 2002
@@ -667,6 +667,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/arm/def-configs/lart b/arch/arm/def-configs/lart
--- a/arch/arm/def-configs/lart	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/lart	Tue Aug 20 23:56:26 2002
@@ -655,6 +655,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/lubbock b/arch/arm/def-configs/lubbock
--- a/arch/arm/def-configs/lubbock	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/lubbock	Tue Aug 20 23:56:26 2002
@@ -702,6 +702,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/lusl7200 b/arch/arm/def-configs/lusl7200
--- a/arch/arm/def-configs/lusl7200	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/lusl7200	Tue Aug 20 23:56:26 2002
@@ -417,6 +417,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/neponset b/arch/arm/def-configs/neponset
--- a/arch/arm/def-configs/neponset	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/neponset	Tue Aug 20 23:56:26 2002
@@ -762,6 +762,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/omnimeter b/arch/arm/def-configs/omnimeter
--- a/arch/arm/def-configs/omnimeter	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/omnimeter	Tue Aug 20 23:56:26 2002
@@ -422,6 +422,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/pangolin b/arch/arm/def-configs/pangolin
--- a/arch/arm/def-configs/pangolin	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/pangolin	Tue Aug 20 23:56:26 2002
@@ -559,6 +559,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/pfs168_mqtft b/arch/arm/def-configs/pfs168_mqtft
--- a/arch/arm/def-configs/pfs168_mqtft	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/pfs168_mqtft	Tue Aug 20 23:56:26 2002
@@ -598,6 +598,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/pfs168_mqvga b/arch/arm/def-configs/pfs168_mqvga
--- a/arch/arm/def-configs/pfs168_mqvga	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/pfs168_mqvga	Tue Aug 20 23:56:26 2002
@@ -598,6 +598,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/pfs168_sastn b/arch/arm/def-configs/pfs168_sastn
--- a/arch/arm/def-configs/pfs168_sastn	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/pfs168_sastn	Tue Aug 20 23:56:26 2002
@@ -591,6 +591,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/pfs168_satft b/arch/arm/def-configs/pfs168_satft
--- a/arch/arm/def-configs/pfs168_satft	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/pfs168_satft	Tue Aug 20 23:56:26 2002
@@ -598,6 +598,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/pleb b/arch/arm/def-configs/pleb
--- a/arch/arm/def-configs/pleb	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/pleb	Tue Aug 20 23:56:26 2002
@@ -460,6 +460,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/rpc b/arch/arm/def-configs/rpc
--- a/arch/arm/def-configs/rpc	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/rpc	Tue Aug 20 23:56:26 2002
@@ -620,6 +620,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/shannon b/arch/arm/def-configs/shannon
--- a/arch/arm/def-configs/shannon	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/shannon	Tue Aug 20 23:56:26 2002
@@ -534,6 +534,8 @@
 CONFIG_MINIX_FS=y
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
+# CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/def-configs/shark b/arch/arm/def-configs/shark
--- a/arch/arm/def-configs/shark	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/shark	Tue Aug 20 23:56:26 2002
@@ -681,6 +681,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/arm/def-configs/sherman b/arch/arm/def-configs/sherman
--- a/arch/arm/def-configs/sherman	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/sherman	Tue Aug 20 23:56:26 2002
@@ -151,6 +151,8 @@
 # CONFIG_JOLIET is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
+# CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_QNX4FS_FS is not set
diff -Nru a/arch/arm/def-configs/stork b/arch/arm/def-configs/stork
--- a/arch/arm/def-configs/stork	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/stork	Tue Aug 20 23:56:26 2002
@@ -649,6 +649,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/arm/def-configs/system3 b/arch/arm/def-configs/system3
--- a/arch/arm/def-configs/system3	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/def-configs/system3	Tue Aug 20 23:56:26 2002
@@ -684,6 +684,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/arm/defconfig b/arch/arm/defconfig
--- a/arch/arm/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/arm/defconfig	Tue Aug 20 23:56:26 2002
@@ -421,6 +421,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/cris/defconfig b/arch/cris/defconfig
--- a/arch/cris/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/cris/defconfig	Tue Aug 20 23:56:26 2002
@@ -441,6 +441,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/i386/defconfig b/arch/i386/defconfig
--- a/arch/i386/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/i386/defconfig	Tue Aug 20 23:56:26 2002
@@ -652,6 +652,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ia64/defconfig b/arch/ia64/defconfig
--- a/arch/ia64/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/defconfig	Tue Aug 20 23:56:26 2002
@@ -628,6 +628,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp b/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp
--- a/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp	Tue Aug 20 23:56:26 2002
@@ -526,6 +526,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp b/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp
--- a/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp	Tue Aug 20 23:56:26 2002
@@ -526,6 +526,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-dig-mp b/arch/ia64/sn/configs/sn1/defconfig-dig-mp
--- a/arch/ia64/sn/configs/sn1/defconfig-dig-mp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-dig-mp	Tue Aug 20 23:56:26 2002
@@ -288,6 +288,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-dig-sp b/arch/ia64/sn/configs/sn1/defconfig-dig-sp
--- a/arch/ia64/sn/configs/sn1/defconfig-dig-sp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-dig-sp	Tue Aug 20 23:56:26 2002
@@ -288,6 +288,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-generic-mp b/arch/ia64/sn/configs/sn1/defconfig-generic-mp
--- a/arch/ia64/sn/configs/sn1/defconfig-generic-mp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-generic-mp	Tue Aug 20 23:56:26 2002
@@ -283,6 +283,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-generic-sp b/arch/ia64/sn/configs/sn1/defconfig-generic-sp
--- a/arch/ia64/sn/configs/sn1/defconfig-generic-sp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-generic-sp	Tue Aug 20 23:56:26 2002
@@ -283,6 +283,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-hp-sp b/arch/ia64/sn/configs/sn1/defconfig-hp-sp
--- a/arch/ia64/sn/configs/sn1/defconfig-hp-sp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-hp-sp	Tue Aug 20 23:56:26 2002
@@ -253,6 +253,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-prom-medusa b/arch/ia64/sn/configs/sn1/defconfig-prom-medusa
--- a/arch/ia64/sn/configs/sn1/defconfig-prom-medusa	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-prom-medusa	Tue Aug 20 23:56:26 2002
@@ -363,6 +363,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-sn1-mp b/arch/ia64/sn/configs/sn1/defconfig-sn1-mp
--- a/arch/ia64/sn/configs/sn1/defconfig-sn1-mp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-sn1-mp	Tue Aug 20 23:56:26 2002
@@ -497,6 +497,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules b/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules
--- a/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules	Tue Aug 20 23:56:26 2002
@@ -499,6 +499,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0 b/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0
--- a/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0	Tue Aug 20 23:56:26 2002
@@ -497,6 +497,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ia64/sn/configs/sn1/defconfig-sn1-sp b/arch/ia64/sn/configs/sn1/defconfig-sn1-sp
--- a/arch/ia64/sn/configs/sn1/defconfig-sn1-sp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn1/defconfig-sn1-sp	Tue Aug 20 23:56:26 2002
@@ -497,6 +497,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ia64/sn/configs/sn2/defconfig-dig-numa b/arch/ia64/sn/configs/sn2/defconfig-dig-numa
--- a/arch/ia64/sn/configs/sn2/defconfig-dig-numa	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn2/defconfig-dig-numa	Tue Aug 20 23:56:26 2002
@@ -289,6 +289,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp b/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp
--- a/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp	Tue Aug 20 23:56:26 2002
@@ -288,6 +288,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp b/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp
--- a/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp	Tue Aug 20 23:56:26 2002
@@ -288,6 +288,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ia64/sn/configs/sn2/defconfig-sn2-mp b/arch/ia64/sn/configs/sn2/defconfig-sn2-mp
--- a/arch/ia64/sn/configs/sn2/defconfig-sn2-mp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn2/defconfig-sn2-mp	Tue Aug 20 23:56:26 2002
@@ -496,6 +496,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules b/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules
--- a/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules	Tue Aug 20 23:56:26 2002
@@ -498,6 +498,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa b/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa
--- a/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa	Tue Aug 20 23:56:26 2002
@@ -371,6 +371,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ia64/sn/configs/sn2/defconfig-sn2-sp b/arch/ia64/sn/configs/sn2/defconfig-sn2-sp
--- a/arch/ia64/sn/configs/sn2/defconfig-sn2-sp	Tue Aug 20 23:56:26 2002
+++ b/arch/ia64/sn/configs/sn2/defconfig-sn2-sp	Tue Aug 20 23:56:26 2002
@@ -496,6 +496,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/m68k/defconfig b/arch/m68k/defconfig
--- a/arch/m68k/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/m68k/defconfig	Tue Aug 20 23:56:26 2002
@@ -228,6 +228,8 @@
 # CONFIG_JOLIET is not set
 CONFIG_MINIX_FS=y
 # CONFIG_NTFS_FS is not set
+# CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig b/arch/mips/defconfig
--- a/arch/mips/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig	Tue Aug 20 23:56:26 2002
@@ -443,6 +443,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-atlas b/arch/mips/defconfig-atlas
--- a/arch/mips/defconfig-atlas	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-atlas	Tue Aug 20 23:56:26 2002
@@ -433,6 +433,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-ddb5476 b/arch/mips/defconfig-ddb5476
--- a/arch/mips/defconfig-ddb5476	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-ddb5476	Tue Aug 20 23:56:26 2002
@@ -467,6 +467,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-ddb5477 b/arch/mips/defconfig-ddb5477
--- a/arch/mips/defconfig-ddb5477	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-ddb5477	Tue Aug 20 23:56:26 2002
@@ -394,6 +394,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-decstation b/arch/mips/defconfig-decstation
--- a/arch/mips/defconfig-decstation	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-decstation	Tue Aug 20 23:56:26 2002
@@ -430,6 +430,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-ip22 b/arch/mips/defconfig-ip22
--- a/arch/mips/defconfig-ip22	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-ip22	Tue Aug 20 23:56:26 2002
@@ -443,6 +443,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-it8172 b/arch/mips/defconfig-it8172
--- a/arch/mips/defconfig-it8172	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-it8172	Tue Aug 20 23:56:26 2002
@@ -546,6 +546,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-malta b/arch/mips/defconfig-malta
--- a/arch/mips/defconfig-malta	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-malta	Tue Aug 20 23:56:26 2002
@@ -459,6 +459,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-nino b/arch/mips/defconfig-nino
--- a/arch/mips/defconfig-nino	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-nino	Tue Aug 20 23:56:26 2002
@@ -270,6 +270,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-ocelot b/arch/mips/defconfig-ocelot
--- a/arch/mips/defconfig-ocelot	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-ocelot	Tue Aug 20 23:56:26 2002
@@ -395,6 +395,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-pb1000 b/arch/mips/defconfig-pb1000
--- a/arch/mips/defconfig-pb1000	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-pb1000	Tue Aug 20 23:56:26 2002
@@ -382,6 +382,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips/defconfig-rm200 b/arch/mips/defconfig-rm200
--- a/arch/mips/defconfig-rm200	Tue Aug 20 23:56:26 2002
+++ b/arch/mips/defconfig-rm200	Tue Aug 20 23:56:26 2002
@@ -313,6 +313,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips64/defconfig b/arch/mips64/defconfig
--- a/arch/mips64/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/mips64/defconfig	Tue Aug 20 23:56:26 2002
@@ -400,6 +400,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips64/defconfig-ip22 b/arch/mips64/defconfig-ip22
--- a/arch/mips64/defconfig-ip22	Tue Aug 20 23:56:26 2002
+++ b/arch/mips64/defconfig-ip22	Tue Aug 20 23:56:26 2002
@@ -405,6 +405,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips64/defconfig-ip27 b/arch/mips64/defconfig-ip27
--- a/arch/mips64/defconfig-ip27	Tue Aug 20 23:56:26 2002
+++ b/arch/mips64/defconfig-ip27	Tue Aug 20 23:56:26 2002
@@ -400,6 +400,7 @@
 # CONFIG_FREEVXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/mips64/defconfig-ip32 b/arch/mips64/defconfig-ip32
--- a/arch/mips64/defconfig-ip32	Tue Aug 20 23:56:26 2002
+++ b/arch/mips64/defconfig-ip32	Tue Aug 20 23:56:26 2002
@@ -430,6 +430,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/parisc/defconfig b/arch/parisc/defconfig
--- a/arch/parisc/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/parisc/defconfig	Tue Aug 20 23:56:26 2002
@@ -294,6 +294,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/FADS_defconfig b/arch/ppc/configs/FADS_defconfig
--- a/arch/ppc/configs/FADS_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/FADS_defconfig	Tue Aug 20 23:56:26 2002
@@ -376,6 +376,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/IVMS8_defconfig b/arch/ppc/configs/IVMS8_defconfig
--- a/arch/ppc/configs/IVMS8_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/IVMS8_defconfig	Tue Aug 20 23:56:26 2002
@@ -404,6 +404,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/SM850_defconfig b/arch/ppc/configs/SM850_defconfig
--- a/arch/ppc/configs/SM850_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/SM850_defconfig	Tue Aug 20 23:56:26 2002
@@ -372,6 +372,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/SPD823TS_defconfig b/arch/ppc/configs/SPD823TS_defconfig
--- a/arch/ppc/configs/SPD823TS_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/SPD823TS_defconfig	Tue Aug 20 23:56:26 2002
@@ -371,6 +371,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/TQM823L_defconfig b/arch/ppc/configs/TQM823L_defconfig
--- a/arch/ppc/configs/TQM823L_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/TQM823L_defconfig	Tue Aug 20 23:56:26 2002
@@ -372,6 +372,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/TQM8260_defconfig b/arch/ppc/configs/TQM8260_defconfig
--- a/arch/ppc/configs/TQM8260_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/TQM8260_defconfig	Tue Aug 20 23:56:26 2002
@@ -345,6 +345,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/TQM850L_defconfig b/arch/ppc/configs/TQM850L_defconfig
--- a/arch/ppc/configs/TQM850L_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/TQM850L_defconfig	Tue Aug 20 23:56:26 2002
@@ -372,6 +372,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/TQM860L_defconfig b/arch/ppc/configs/TQM860L_defconfig
--- a/arch/ppc/configs/TQM860L_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/TQM860L_defconfig	Tue Aug 20 23:56:26 2002
@@ -417,6 +417,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/adir_defconfig b/arch/ppc/configs/adir_defconfig
--- a/arch/ppc/configs/adir_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/adir_defconfig	Tue Aug 20 23:56:26 2002
@@ -514,6 +514,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/apus_defconfig b/arch/ppc/configs/apus_defconfig
--- a/arch/ppc/configs/apus_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/apus_defconfig	Tue Aug 20 23:56:26 2002
@@ -659,6 +659,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/ash_defconfig b/arch/ppc/configs/ash_defconfig
--- a/arch/ppc/configs/ash_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/ash_defconfig	Tue Aug 20 23:56:26 2002
@@ -432,6 +432,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/bseip_defconfig b/arch/ppc/configs/bseip_defconfig
--- a/arch/ppc/configs/bseip_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/bseip_defconfig	Tue Aug 20 23:56:26 2002
@@ -371,6 +371,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/ceder_defconfig b/arch/ppc/configs/ceder_defconfig
--- a/arch/ppc/configs/ceder_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/ceder_defconfig	Tue Aug 20 23:56:26 2002
@@ -434,6 +434,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/common_defconfig b/arch/ppc/configs/common_defconfig
--- a/arch/ppc/configs/common_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/common_defconfig	Tue Aug 20 23:56:26 2002
@@ -725,6 +725,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ppc/configs/cpci405_defconfig b/arch/ppc/configs/cpci405_defconfig
--- a/arch/ppc/configs/cpci405_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/cpci405_defconfig	Tue Aug 20 23:56:26 2002
@@ -458,6 +458,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/ep405_defconfig b/arch/ppc/configs/ep405_defconfig
--- a/arch/ppc/configs/ep405_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/ep405_defconfig	Tue Aug 20 23:56:26 2002
@@ -428,6 +428,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/est8260_defconfig b/arch/ppc/configs/est8260_defconfig
--- a/arch/ppc/configs/est8260_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/est8260_defconfig	Tue Aug 20 23:56:26 2002
@@ -355,6 +355,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/ev64260_defconfig b/arch/ppc/configs/ev64260_defconfig
--- a/arch/ppc/configs/ev64260_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/ev64260_defconfig	Tue Aug 20 23:56:26 2002
@@ -473,6 +473,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ppc/configs/gemini_defconfig b/arch/ppc/configs/gemini_defconfig
--- a/arch/ppc/configs/gemini_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/gemini_defconfig	Tue Aug 20 23:56:26 2002
@@ -453,6 +453,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ppc/configs/iSeries_defconfig b/arch/ppc/configs/iSeries_defconfig
--- a/arch/ppc/configs/iSeries_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/iSeries_defconfig	Tue Aug 20 23:56:26 2002
@@ -364,6 +364,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ppc/configs/ibmchrp_defconfig b/arch/ppc/configs/ibmchrp_defconfig
--- a/arch/ppc/configs/ibmchrp_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/ibmchrp_defconfig	Tue Aug 20 23:56:26 2002
@@ -593,6 +593,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ppc/configs/k2_defconfig b/arch/ppc/configs/k2_defconfig
--- a/arch/ppc/configs/k2_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/k2_defconfig	Tue Aug 20 23:56:26 2002
@@ -494,6 +494,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/lopec_defconfig b/arch/ppc/configs/lopec_defconfig
--- a/arch/ppc/configs/lopec_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/lopec_defconfig	Tue Aug 20 23:56:26 2002
@@ -681,6 +681,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/mbx_defconfig b/arch/ppc/configs/mbx_defconfig
--- a/arch/ppc/configs/mbx_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/mbx_defconfig	Tue Aug 20 23:56:26 2002
@@ -364,6 +364,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/mcpn765_defconfig b/arch/ppc/configs/mcpn765_defconfig
--- a/arch/ppc/configs/mcpn765_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/mcpn765_defconfig	Tue Aug 20 23:56:26 2002
@@ -404,6 +404,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/menf1_defconfig b/arch/ppc/configs/menf1_defconfig
--- a/arch/ppc/configs/menf1_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/menf1_defconfig	Tue Aug 20 23:56:26 2002
@@ -503,6 +503,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/mvme5100_defconfig b/arch/ppc/configs/mvme5100_defconfig
--- a/arch/ppc/configs/mvme5100_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/mvme5100_defconfig	Tue Aug 20 23:56:26 2002
@@ -552,6 +552,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/oak_defconfig b/arch/ppc/configs/oak_defconfig
--- a/arch/ppc/configs/oak_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/oak_defconfig	Tue Aug 20 23:56:26 2002
@@ -407,6 +407,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/pcore_defconfig b/arch/ppc/configs/pcore_defconfig
--- a/arch/ppc/configs/pcore_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/pcore_defconfig	Tue Aug 20 23:56:26 2002
@@ -504,6 +504,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/pmac_defconfig b/arch/ppc/configs/pmac_defconfig
--- a/arch/ppc/configs/pmac_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/pmac_defconfig	Tue Aug 20 23:56:26 2002
@@ -805,6 +805,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ppc/configs/power3_defconfig b/arch/ppc/configs/power3_defconfig
--- a/arch/ppc/configs/power3_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/power3_defconfig	Tue Aug 20 23:56:26 2002
@@ -577,6 +577,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/pplus_defconfig b/arch/ppc/configs/pplus_defconfig
--- a/arch/ppc/configs/pplus_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/pplus_defconfig	Tue Aug 20 23:56:26 2002
@@ -596,6 +596,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/prpmc750_defconfig b/arch/ppc/configs/prpmc750_defconfig
--- a/arch/ppc/configs/prpmc750_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/prpmc750_defconfig	Tue Aug 20 23:56:26 2002
@@ -440,6 +440,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/prpmc800_defconfig b/arch/ppc/configs/prpmc800_defconfig
--- a/arch/ppc/configs/prpmc800_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/prpmc800_defconfig	Tue Aug 20 23:56:26 2002
@@ -454,6 +454,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/redwood5_defconfig b/arch/ppc/configs/redwood5_defconfig
--- a/arch/ppc/configs/redwood5_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/redwood5_defconfig	Tue Aug 20 23:56:26 2002
@@ -433,6 +433,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/redwood_defconfig b/arch/ppc/configs/redwood_defconfig
--- a/arch/ppc/configs/redwood_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/redwood_defconfig	Tue Aug 20 23:56:26 2002
@@ -372,6 +372,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/rpxcllf_defconfig b/arch/ppc/configs/rpxcllf_defconfig
--- a/arch/ppc/configs/rpxcllf_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/rpxcllf_defconfig	Tue Aug 20 23:56:26 2002
@@ -371,6 +371,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/rpxlite_defconfig b/arch/ppc/configs/rpxlite_defconfig
--- a/arch/ppc/configs/rpxlite_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/rpxlite_defconfig	Tue Aug 20 23:56:26 2002
@@ -371,6 +371,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/sandpoint_defconfig b/arch/ppc/configs/sandpoint_defconfig
--- a/arch/ppc/configs/sandpoint_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/sandpoint_defconfig	Tue Aug 20 23:56:26 2002
@@ -687,6 +687,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/spruce_defconfig b/arch/ppc/configs/spruce_defconfig
--- a/arch/ppc/configs/spruce_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/spruce_defconfig	Tue Aug 20 23:56:26 2002
@@ -402,6 +402,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/walnut_defconfig b/arch/ppc/configs/walnut_defconfig
--- a/arch/ppc/configs/walnut_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/walnut_defconfig	Tue Aug 20 23:56:26 2002
@@ -428,6 +428,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/ppc/configs/zx4500_defconfig b/arch/ppc/configs/zx4500_defconfig
--- a/arch/ppc/configs/zx4500_defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/configs/zx4500_defconfig	Tue Aug 20 23:56:26 2002
@@ -409,6 +409,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ppc/defconfig b/arch/ppc/defconfig
--- a/arch/ppc/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc/defconfig	Tue Aug 20 23:56:26 2002
@@ -725,6 +725,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/ppc64/defconfig b/arch/ppc64/defconfig
--- a/arch/ppc64/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/ppc64/defconfig	Tue Aug 20 23:56:26 2002
@@ -568,6 +568,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/s390/defconfig b/arch/s390/defconfig
--- a/arch/s390/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/s390/defconfig	Tue Aug 20 23:56:26 2002
@@ -295,6 +295,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/s390x/defconfig b/arch/s390x/defconfig
--- a/arch/s390x/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/s390x/defconfig	Tue Aug 20 23:56:26 2002
@@ -295,6 +295,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 CONFIG_DEVFS_FS=y
diff -Nru a/arch/sh/defconfig b/arch/sh/defconfig
--- a/arch/sh/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/sh/defconfig	Tue Aug 20 23:56:26 2002
@@ -156,6 +156,7 @@
 # CONFIG_MINIX_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/sparc/defconfig b/arch/sparc/defconfig
--- a/arch/sparc/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/sparc/defconfig	Tue Aug 20 23:56:26 2002
@@ -302,6 +302,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 CONFIG_HPFS_FS=m
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/sparc64/defconfig b/arch/sparc64/defconfig
--- a/arch/sparc64/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/sparc64/defconfig	Tue Aug 20 23:56:26 2002
@@ -682,6 +682,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 CONFIG_HPFS_FS=m
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/arch/x86_64/defconfig b/arch/x86_64/defconfig
--- a/arch/x86_64/defconfig	Tue Aug 20 23:56:26 2002
+++ b/arch/x86_64/defconfig	Tue Aug 20 23:56:26 2002
@@ -513,6 +513,7 @@
 # CONFIG_VXFS_FS is not set
 # CONFIG_NTFS_FS is not set
 # CONFIG_NTFS_DEBUG is not set
+# CONFIG_NTFS_RW is not set
 # CONFIG_HPFS_FS is not set
 CONFIG_PROC_FS=y
 # CONFIG_DEVFS_FS is not set
diff -Nru a/fs/Config.help b/fs/Config.help
--- a/fs/Config.help	Tue Aug 20 23:56:26 2002
+++ b/fs/Config.help	Tue Aug 20 23:56:26 2002
@@ -606,6 +606,15 @@
   When reporting bugs, please try to have available a full dump of
   debugging messages while the misbehaviour was occurring.
 
+CONFIG_NTFS_RW
+  This enables the experimental write support in the NTFS driver.
+
+  WARNING: Do not use this option unless you are actively developing
+           NTFS as it is currently guaranteed to be broken and you
+           may lose all your data!
+
+  It is strongly recommended and perfectly safe to say N here.
+
 CONFIG_SYSV_FS
   SCO, Xenix and Coherent are commercial Unix systems for Intel
   machines, and Version 7 was used on the DEC PDP-11. Saying Y
diff -Nru a/fs/Config.in b/fs/Config.in
--- a/fs/Config.in	Tue Aug 20 23:56:26 2002
+++ b/fs/Config.in	Tue Aug 20 23:56:26 2002
@@ -70,6 +70,7 @@
 
 tristate 'NTFS file system support (read only)' CONFIG_NTFS_FS
 dep_mbool '  NTFS debugging support' CONFIG_NTFS_DEBUG $CONFIG_NTFS_FS
+dep_mbool '  NTFS write support (DANGEROUS)' CONFIG_NTFS_RW $CONFIG_NTFS_FS $CONFIG_EXPERIMENTAL
 
 tristate 'OS/2 HPFS file system support' CONFIG_HPFS_FS
 
diff -Nru a/fs/ntfs/Makefile b/fs/ntfs/Makefile
--- a/fs/ntfs/Makefile	Tue Aug 20 23:56:26 2002
+++ b/fs/ntfs/Makefile	Tue Aug 20 23:56:26 2002
@@ -5,15 +5,15 @@
 ntfs-objs := aops.o attrib.o compress.o debug.o dir.o file.o inode.o mft.o \
 	     mst.o namei.o super.o sysctl.o time.o unistr.o upcase.o
 
-EXTRA_CFLAGS = -DNTFS_VERSION=\"2.0.25\"
+EXTRA_CFLAGS = -DNTFS_VERSION=\"2.1.0\"
 
 ifeq ($(CONFIG_NTFS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
 endif
 
-#ifeq ($(CONFIG_NTFS_RW),y)
-#EXTRA_CFLAGS += -DNTFS_RW
-#endif
+ifeq ($(CONFIG_NTFS_RW),y)
+EXTRA_CFLAGS += -DNTFS_RW
+endif
 
 include $(TOPDIR)/Rules.make
 

