Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbTH2RIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbTH2RH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:07:56 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:46014 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261451AbTH2RFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:05:39 -0400
Date: Fri, 29 Aug 2003 19:05:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (1/8): Kconfig.
Message-ID: <20030829170510.GC1242@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Use common drivers/block/Kconfig instead of own config options, move
   s390 block device config options to drivers/s390/block/Kconfig and
   include it from drivers/block/Kconfig.
 - Fix configuration combination CONFIG_IPV6=m and CONFIG_QETH=y.

diffstat:
 drivers/block/Kconfig      |    5 -
 drivers/s390/Kconfig       |  170 ---------------------------------------------
 drivers/s390/block/Kconfig |   49 ++++++++++++
 drivers/s390/net/Kconfig   |   12 +--
 4 files changed, 57 insertions(+), 179 deletions(-)

diff -urN linux-2.6/drivers/block/Kconfig linux-2.6-s390/drivers/block/Kconfig
--- linux-2.6/drivers/block/Kconfig	Sat Aug 23 01:53:09 2003
+++ linux-2.6-s390/drivers/block/Kconfig	Fri Aug 29 18:55:08 2003
@@ -6,7 +6,7 @@
 
 config BLK_DEV_FD
 	tristate "Normal floppy disk support"
-	depends on !X86_PC9800
+	depends on !X86_PC9800 && !ARCH_S390
 	---help---
 	  If you want to use the floppy disk drive(s) of your PC under Linux,
 	  say Y. Information about this driver, especially important for IBM
@@ -346,5 +346,6 @@
 	  your machine, or if you want to have a raid or loopback device
 	  bigger than 2TB.  Otherwise say N.
 
-endmenu
+source "drivers/s390/block/Kconfig"
 
+endmenu
diff -urN linux-2.6/drivers/s390/Kconfig linux-2.6-s390/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	Sat Aug 23 01:59:03 2003
+++ linux-2.6-s390/drivers/s390/Kconfig	Fri Aug 29 18:55:08 2003
@@ -2,175 +2,7 @@
 	bool
 	default y
 
-
-menu "Block device drivers"
-
-config BLK_DEV_LOOP
-	tristate "Loopback device support"
-	---help---
-	  Saying Y here will allow you to use a regular file as a block
-	  device; you can then create a file system on that block device and
-	  mount it just as you would mount other block devices such as hard
-	  drive partitions, CD-ROM drives or floppy drives. The loop devices
-	  are block special device files with major number 7 and typically
-	  called /dev/loop0, /dev/loop1 etc.
-
-	  This is useful if you want to check an ISO 9660 file system before
-	  burning the CD, or if you want to use floppy images without first
-	  writing them to floppy. Furthermore, some Linux distributions avoid
-	  the need for a dedicated Linux partition by keeping their complete
-	  root file system inside a DOS FAT file using this loop device
-	  driver.
-
-	  The loop device driver can also be used to "hide" a file system in a
-	  disk partition, floppy, or regular file, either using encryption
-	  (scrambling the data) or steganography (hiding the data in the low
-	  bits of, say, a sound file). This is also safe if the file resides
-	  on a remote file server. If you want to do this, you will first have
-	  to acquire and install a kernel patch from
-	  <ftp://ftp.kerneli.org/pub/kerneli/>, and then you need to
-	  say Y to this option.
-
-	  Note that alternative ways to use encrypted file systems are
-	  provided by the cfs package, which can be gotten from
-	  <ftp://ftp.kerneli.org/pub/kerneli/net-source/>, and the newer tcfs
-	  package, available at <http://tcfs.dia.unisa.it/>. You do not need
-	  to say Y here if you want to use one of these. However, using cfs
-	  requires saying Y to "NFS file system support" below while using
-	  tcfs requires applying a kernel patch. An alternative steganography
-	  solution is provided by StegFS, also available from
-	  <ftp://ftp.kerneli.org/pub/kerneli/net-source/>.
-
-	  To use the loop device, you need the losetup utility and a recent
-	  version of the mount program, both contained in the util-linux
-	  package. The location and current version number of util-linux is
-	  contained in the file <file:Documentation/Changes>.
-
-	  Note that this loop device has nothing to do with the loopback
-	  device used for network connections from the machine to itself.
-
-	  If you want to compile this driver as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>. The module
-	  will be called loop.
-
-	  Most users will answer N here.
-
-config BLK_DEV_NBD
-	tristate "Network block device support"
-	depends on NET
-	---help---
-	  Saying Y here will allow your computer to be a client for network
-	  block devices, i.e. it will be able to use block devices exported by
-	  servers (mount file systems on them etc.). Communication between
-	  client and server works over TCP/IP networking, but to the client
-	  program this is hidden: it looks like a regular local file access to
-	  a block device special file such as /dev/nd0.
-
-	  Network block devices also allows you to run a block-device in
-	  userland (making server and client physically the same computer,
-	  communicating using the loopback network device).
-
-	  Read <file:Documentation/nbd.txt> for more information, especially
-	  about where to find the server code, which runs in user space and
-	  does not need special kernel support.
-
-	  Note that this has nothing to do with the network file systems NFS
-	  or Coda; you can say N here even if you intend to use NFS or Coda.
-
-	  If you want to compile this driver as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read <file:Documentation/modules.txt>. The module
-	  will be called nbd.
-
-	  If unsure, say N.
-
-config BLK_DEV_RAM
-	tristate "RAM disk support"
-	---help---
-	  Saying Y here will allow you to use a portion of your RAM memory as
-	  a block device, so that you can make file systems on it, read and
-	  write to it and do all the other things that you can do with normal
-	  block devices (such as hard drives). It is usually used to load and
-	  store a copy of a minimal root file system off of a floppy into RAM
-	  during the initial install of Linux.
-
-	  Note that the kernel command line option "ramdisk=XX" is now
-	  obsolete. For details, read <file:Documentation/ramdisk.txt>.
-
-	  If you want to compile this as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want),
-	  say M and read <file:Documentation/modules.txt>. The module will be
-	  called rd.
-
-	  Most normal users won't need the RAM disk functionality, and can
-	  thus say N here.
-
-config BLK_DEV_RAM_SIZE
-	int "Default RAM disk size"
-	depends on BLK_DEV_RAM
-	default "24576"
-	help
-	  The default value is 4096. Only change this if you know what are
-	  you doing. If you are using IBM S/390, then set this to 8192.
-
-config BLK_DEV_INITRD
-	bool "Initial RAM disk (initrd) support"
-	depends on BLK_DEV_RAM=y
-	help
-	  The initial RAM disk is a RAM disk that is loaded by the boot loader
-	  (loadlin or lilo) and that is mounted as root before the normal boot
-	  procedure. It is typically used to load modules needed to mount the
-	  "real" root file system, etc. See <file:Documentation/initrd.txt>
-	  for details.
-
-config BLK_DEV_XPRAM
-	tristate "XPRAM disk support"
-	help
-	  Select this option if you want to use your expanded storage on S/390
-	  or zSeries as a disk.  This is useful as a _fast_ swap device if you
-	  want to access more than 2G of memory when running in 31 bit mode.
-	  This option is also available as a module which will be called
-	  xpram.  If unsure, say "N".
-
-comment "S/390 block device drivers"
-
-config DASD
-	tristate "Support for DASD devices"
-	help
-	  Enable this option if you want to access DASDs directly utilizing
-	  S/390s channel subsystem commands. This is necessary for running
-	  natively on a single image or an LPAR.
-
-config DASD_PROFILE
-	bool "Profiling support for dasd devices"
-	help
-	  Enable this option if you want to see profiling information
-          in /proc/dasd/statistics.
-
-config DASD_ECKD
-	tristate "Support for ECKD Disks"
-	depends on DASD
-	help
-	  ECKD devices are the most commonly used devices. You should enable
-	  this option unless you are very sure to have no ECKD device.
-
-config DASD_FBA
-	tristate "Support for FBA  Disks"
-	depends on DASD
-	help
-	  Select this option to be able to access FBA devices. It is safe to
-	  say "Y".
-
-config DASD_DIAG
-	tristate "Support for DIAG access to CMS reserved Disks"
-	depends on DASD && ARCH_S390X = 'n'
-	help
-	  Select this option if you want to use CMS reserved Disks under VM
-	  with the Diagnose250 command.  If you are not running under VM or
-	  unsure what it is, say "N".
-
-endmenu
+source "drivers/block/Kconfig"
 
 source "drivers/md/Kconfig"
 
diff -urN linux-2.6/drivers/s390/block/Kconfig linux-2.6-s390/drivers/s390/block/Kconfig
--- linux-2.6/drivers/s390/block/Kconfig	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/drivers/s390/block/Kconfig	Fri Aug 29 18:55:08 2003
@@ -0,0 +1,49 @@
+comment "S/390 block device drivers"
+	depends on ARCH_S390
+
+config BLK_DEV_XPRAM
+	tristate "XPRAM disk support"
+	depends on ARCH_S390
+	help
+	  Select this option if you want to use your expanded storage on S/390
+	  or zSeries as a disk.  This is useful as a _fast_ swap device if you
+	  want to access more than 2G of memory when running in 31 bit mode.
+	  This option is also available as a module which will be called
+	  xpram.  If unsure, say "N".
+
+config DASD
+	tristate "Support for DASD devices"
+	depends on CCW
+	help
+	  Enable this option if you want to access DASDs directly utilizing
+	  S/390s channel subsystem commands. This is necessary for running
+	  natively on a single image or an LPAR.
+
+config DASD_PROFILE
+	bool "Profiling support for dasd devices"
+	depends on DASD
+	help
+	  Enable this option if you want to see profiling information
+          in /proc/dasd/statistics.
+
+config DASD_ECKD
+	tristate "Support for ECKD Disks"
+	depends on DASD
+	help
+	  ECKD devices are the most commonly used devices. You should enable
+	  this option unless you are very sure to have no ECKD device.
+
+config DASD_FBA
+	tristate "Support for FBA  Disks"
+	depends on DASD
+	help
+	  Select this option to be able to access FBA devices. It is safe to
+	  say "Y".
+
+config DASD_DIAG
+	tristate "Support for DIAG access to CMS reserved Disks"
+	depends on DASD && ARCH_S390X = 'n'
+	help
+	  Select this option if you want to use CMS reserved Disks under VM
+	  with the Diagnose250 command.  If you are not running under VM or
+	  unsure what it is, say "N".
diff -urN linux-2.6/drivers/s390/net/Kconfig linux-2.6-s390/drivers/s390/net/Kconfig
--- linux-2.6/drivers/s390/net/Kconfig	Sat Aug 23 01:59:34 2003
+++ linux-2.6-s390/drivers/s390/net/Kconfig	Fri Aug 29 18:55:08 2003
@@ -51,18 +51,16 @@
 comment "Gigabit Ethernet default settings"
 	depends on QETH
 
-# FIXME IPV6=m && QETH=y
 config QETH_IPV6
 	bool "IPv6 support for gigabit ethernet"
-	depends on QETH && IPV6
+	depends on (QETH = IPV6) || (QETH && IPV6 = 'y')
 	help
 	  If CONFIG_QETH is switched on, this option will include IPv6
 	  support in the qeth device driver.
-
-# FIXME VLAN_8021Q=m && QETH=y
+	
 config QETH_VLAN
 	bool "VLAN support for gigabit ethernet"
-	depends on QETH && VLAN_8021Q
+	depends on (QETH = VLAN_8021Q) || (QETH && VLAN_8021Q = 'y')
 	help
 	  If CONFIG_QETH is switched on, this option will include IEEE
 	  802.1q VLAN support in the qeth device driver.
@@ -78,8 +76,6 @@
 
 config CCWGROUP
  	tristate
- 	depends on LCS || CTC  || QETH
-	default m if LCS!=y && CTC!=y && QETH!=y
-	default y if LCS=y || CTC=y || QETH=y
+	default (LCS || CTC || QETH)
 
 endmenu
