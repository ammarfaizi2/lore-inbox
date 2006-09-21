Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWIUDdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWIUDdl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 23:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWIUDd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 23:33:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:12434 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751178AbWIUDdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 23:33:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=a/wQpXAI13g0mPNXGTtozJ1087BWKrAKl53kxFpUyTo1HNVeCChDldU2h0/C2WuVNuKpw450JSJRCRm6/ZnufmxmdfORm49EZ6j3QmNTpaHdOR7yy/uGlhznoOsrSDr3/lq8j9HenZ4f2gslzVns7G4wM415s+C3p0PFQbfVFkQ=
Message-ID: <489ecd0c0609202033g330cfb52te1b246da63b55cf4@mail.gmail.com>
Date: Thu, 21 Sep 2006 11:33:12 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 3/4] Blackfin: documents and maintainer patch
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  This is the documents patche for Blackfin arch, also includes the
MAINTAINERS file change.

Signed-off-by: Luke Yang <luke.adi@gmail.com>

 Documentation/blackfin/00-INDEX          |   11 ++
 Documentation/blackfin/Filesystems       |  152 +++++++++++++++++++++++++++++++
 Documentation/blackfin/cache-lock.txt    |   31 ++++++
 Documentation/blackfin/cachefeatures.txt |   48 +++++++++
 MAINTAINERS                              |   32 ++++++
 5 files changed, 274 insertions(+)

diff -urN linux-2.6.18.patch3/Documentation/blackfin/00-INDEX
linux-2.6.18.patch4/Documentation/blackfin/00-INDEX
--- linux-2.6.18.patch3/Documentation/blackfin/00-INDEX	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18.patch4/Documentation/blackfin/00-INDEX	2006-09-21
10:20:33.000000000 +0800
@@ -0,0 +1,11 @@
+00-INDEX
+	- This file
+
+cache-lock.txt
+	- HOWTO for blackfin cache locking.
+
+cachefeatures.txt
+	- Supported cache features.
+
+Filesystems
+	- Requirements for mounting the root file system.
diff -urN linux-2.6.18.patch3/Documentation/blackfin/Filesystems
linux-2.6.18.patch4/Documentation/blackfin/Filesystems
--- linux-2.6.18.patch3/Documentation/blackfin/Filesystems	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18.patch4/Documentation/blackfin/Filesystems	2006-09-21
10:20:33.000000000 +0800
@@ -0,0 +1,152 @@
+		How to mount the root file system in uClinux/Blackfin
+		-----------------------------------------------------
+
+1	Mounting EXT3 File system.
+	------------------------
+
+	Creating an EXT3 File system for uClinux/Blackfin:
+
+
+Please follow the steps to form the EXT3 File system and mount the same as root
+file system.
+
+a	Make an ext3 file system as large as you want the final root file
+	system.
+
+		mkfs.ext3  /dev/ram0 <your-rootfs-size-in-1k-blocks>
+
+b	Mount this Empty file system on a free directory as:
+
+		mount -t ext3 /dev/ram0  ./test
+			where ./test is the empty directory.
+
+c	Copy your root fs directory that you have so carefully made over.
+
+		cp -af  /tmp/my_final_rootfs_files/* ./test
+
+		(For ex: cp -af uClinux-dist/romfs/* ./test)
+
+d	If you have done everything right till now you should be able to see
+	the required "root" dir's (that's etc, root, bin, lib, sbin...)
+
+e	Now unmount the file system
+
+		umount  ./test
+
+f	Create the root file system image.
+
+		dd if=/dev/ram0 bs=1k count=<your-rootfs-size-in-1k-blocks> \
+		> ext3fs.img
+
+
+Now you have to tell the kernel that will be mounting this file system as
+rootfs.
+So do a make menuconfig under kernel and select the Ext3 journaling file system
+support under File system --> submenu.
+
+
+2.	Mounting EXT2 File system.
+	-------------------------
+
+By default the ext2 file system image will be created if you invoke make from
+the top uClinux-dist directory.
+
+
+3.	Mounting CRAMFS File System
+	----------------------------
+
+To create a CRAMFS file system image execute the command
+
+	mkfs.cramfs ./test cramfs.img
+
+	where ./test is the target directory.
+
+
+4.	Mounting ROMFS File System
+	--------------------------
+
+To create a ROMFS file system image execute the command
+
+	genromfs -v -V "ROMdisk" -f romfs.img -d ./test
+
+	where ./test is the target directory
+
+
+5.	Mounting the JFFS2 Filesystem
+	-----------------------------
+
+To create a compressed JFFS filesystem (JFFS2), please execute the command
+
+	mkfs.jffs2 -d ./test -o jffs2.img
+
+	where ./test is the target directory.
+
+However, please make sure the following is in your kernel config.
+
+/*
+ * RAM/ROM/Flash chip drivers
+ */
+#define CONFIG_MTD_CFI 1
+#define CONFIG_MTD_ROM 1
+/*
+ * Mapping drivers for chip access
+ */
+#define CONFIG_MTD_COMPLEX_MAPPINGS 1
+#define CONFIG_MTD_BF533 1
+#undef CONFIG_MTD_UCLINUX
+
+Through the u-boot boot loader, use the jffs2.img in the corresponding
+partition made in linux-2.6.x/drivers/mtd/maps/bf533_flash.c.
+
+NOTE - 	Currently the Flash driver is available only for EZKIT. Watch out for a
+	STAMP driver soon.
+
+
+6. 	Mounting the NFS File system
+	-----------------------------
+
+	For mounting the NFS please do the following in the kernel config.
+
+	In Networking Support --> Networking options --> TCP/IP networking -->
+		IP: kernel level autoconfiguration
+
+	Enable BOOTP Support.
+
+	In Kernel hacking --> Compiled-in kernel boot parameter add the following
+
+		root=/dev/nfs rw ip=bootp
+
+	In File system --> Network File system, Enable
+
+		NFS file system support --> NFSv3 client support
+		Root File system on NFS
+
+	in uClibc menuconfig, do the following
+	In Networking Support
+		enable Remote Procedure Call (RPC) support
+			Full RPC Support
+
+	On the Host side, ensure that /etc/dhcpd.conf looks something like this
+
+		ddns-update-style ad-hoc;
+		allow bootp;
+		subnet 10.100.4.0 netmask 255.255.255.0 {
+		default-lease-time 122209600;
+		max-lease-time 31557600;
+		group {
+			host bf533 {
+				hardware ethernet 00:CF:52:49:C3:01;
+				fixed-address 10.100.4.50;
+				option root-path "/home/nfsmount";
+			}
+		}
+
+	ensure that /etc/exports looks something like this
+		/home/nfsmount *(rw,no_root_squash,no_all_squash)
+
+	 run the following commands as root (may differ depending on your
+	 distribution) :
+		-  service nfs start
+		-  service portmap start
+		-  service dhcpd start
+		-  /usr/sbin/exportfs
diff -urN linux-2.6.18.patch3/Documentation/blackfin/cache-lock.txt
linux-2.6.18.patch4/Documentation/blackfin/cache-lock.txt
--- linux-2.6.18.patch3/Documentation/blackfin/cache-lock.txt	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18.patch4/Documentation/blackfin/cache-lock.txt	2006-09-21
10:20:33.000000000 +0800
@@ -0,0 +1,31 @@
+How to lock your code in cache in uClinux/blackfin
+--------------------------------------------------
+
+There are only a few steps required to lock your code into the cache.
+Currently you can lock the code by Way.
+
+Below are the interface provided for locking the cache.
+
+
+1. cache_grab_lock(int Ways);
+
+This function grab the lock for locking your code into the cache specified
+by Ways.
+
+
+2. cache_lock(int Ways);
+
+This function should be called after your critical code has been executed.
+Once the critical code exits, the code is now loaded into the cache. This
+function locks the code into the cache.
+
+
+So, the example sequence will be:
+
+	cache_grab_lock(WAY0_L);	/* Grab the lock */
+
+	critical_code();		/* Execute the code of interest */
+
+	cache_lock(WAY0_L);		/* Lock the cache */
+
+Where WAY0_L signifies WAY0 locking.
diff -urN linux-2.6.18.patch3/Documentation/blackfin/cachefeatures.txt
linux-2.6.18.patch4/Documentation/blackfin/cachefeatures.txt
--- linux-2.6.18.patch3/Documentation/blackfin/cachefeatures.txt	1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.18.patch4/Documentation/blackfin/cachefeatures.txt	2006-09-21
10:20:33.000000000 +0800
@@ -0,0 +1,48 @@
+	- Instruction and Data cache initialization.
+		icache_init();
+		dcache_init();
+
+	-  Instruction and Data cache Invalidation Routines, when flushing the
+	   same is not required.
+		_icache_invalidate();
+		_dcache_invalidate();
+
+	Also, for invalidating the entire instruction and data cache, the below
+	routines are provided (another method for invalidation, refer page
no 267 and 287 of
+	ADSP-BF533 Hardware Reference manual)
+
+		invalidate_entire_dcache();
+		invalidate_entire_icache();
+
+	-External Flushing of Instruction and data cache routines.
+
+		flush_instruction_cache();
+		flush_data_cache();
+
+	- Internal Flushing of Instruction and Data Cache.
+
+		icplb_flush();
+		dcplb_flush();
+
+	- Locking the cache.
+
+		cache_grab_lock();
+		cache_lock();
+
+	Please refer linux-2.6.x/Documentation/blackfin/cache-lock.txt for how to
+	lock the cache.
+
+	Locking the cache is optional feature.
+
+	- Miscellaneous cache functions.
+
+		flush_cache_all();
+		flush_cache_mm();
+		invalidate_dcache_range();
+		flush_dcache_range();
+		flush_dcache_page();
+		flush_cache_range();
+		flush_cache_page();
+		invalidate_dcache_range();
+		flush_page_to_ram();
+
diff -urN linux-2.6.18.patch3/MAINTAINERS linux-2.6.18.patch4/MAINTAINERS
--- linux-2.6.18.patch3/MAINTAINERS	2006-09-21 09:45:22.000000000 +0800
+++ linux-2.6.18.patch4/MAINTAINERS	2006-09-21 10:20:02.000000000 +0800
@@ -481,6 +481,38 @@
 T:	git kernel.org:/pub/scm/linux/kernel/git/axboe/linux-2.6-block.git
 S:	Maintained

+BLACKFIN ARCHITECTURE
+P:     Aubery Li
+M:     aubery.li@analog.com
+P:     Bernd Schmidt
+M:     bernd.schmidt@analog.com
+P:     Michael Hennerich
+M:     michael.hennerich@analog.com
+P:     Mike Frysinger
+M:     michael.frysinger@analog.com
+P:     Jie Zhang
+M:     jie.zhang@analog.com
+P:     Luke Yang
+M:     luke.adi@gmail.com
+P:     Robin Getz
+M:     robin.retz@analog.com
+P:     Roy Huang
+M:     roy.huang@analog.com
+P:     Sonic Zhang
+M:     sonic.zhang@analog.com
+L:     linux-kernel@vger.kernel.org
+L:     uclinux533-devel@blackfin.uclinux.org
+W:     http://blackfin.uclinux.org
+S:     Supported
+
+BLACKFIN SERIAL DRIVER
+P:     Sonic Zhang
+M:     sonic.zhang@analog.com
+L:     linux-kernel@vger.kernel.org
+L:     uclinux533-devel@blackfin.uclinux.org
+W:     http://blackfin.uclinux.org
+S:     Supported
+
 BLUETOOTH SUBSYSTEM
 P:	Marcel Holtmann
 M:	marcel@holtmann.org

-- 
Best regards,
Luke Yang
luke.adi@gmail.com
