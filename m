Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288534AbSADIOF>; Fri, 4 Jan 2002 03:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288538AbSADIN4>; Fri, 4 Jan 2002 03:13:56 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:54458 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288534AbSADINs>; Fri, 4 Jan 2002 03:13:48 -0500
Date: Fri, 4 Jan 2002 00:13:47 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Partial patch?: linux-2.5.2-pre7/init/do_mounts.c kdev_t initrd fixes
Message-ID: <20020104001347.A13214@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch gets linux-2.5.2-pre7/init/do_mounts.c
to compile when CONFIG_INITRD has been set; however, it does so by
ifdef'ing out the "/linuxrc" support (CONFIG_LINUXRC).

	I regard the linuxrc facility as unnecessary bloat, but
linuxrc fans are welcome to fix the code that I have bracketed in
CONFIG_LINUXRC and either remove my CONFIG_LINUXRC conditionals or,
better yet, add it as an option to drivers/block/Config.in.

	Also, note that this patch is completely untested as I
am still working on getting 2.5.2-pre7 to build.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mounts.diff"

--- linux-2.5.2-pre7/init/do_mounts.c	Thu Jan  3 19:52:02 2002
+++ linux/init/do_mounts.c	Fri Jan  4 00:07:50 2002
@@ -631,7 +631,7 @@
 #ifdef CONFIG_BLK_DEV_RAM
 	if (rd_prompt)
 		change_floppy("root floppy disk to be loaded into RAM disk");
-	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, n), NULL);
+	create_dev("/dev/ram", mk_kdev(RAMDISK_MAJOR, n), NULL);
 #endif
 	return rd_load_image("/dev/root");
 }
@@ -724,7 +724,7 @@
 	mount_block_root("/dev/root", root_mountflags);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#if defined(CONFIG_BLK_DEV_INITRD) && defined(CONFIG_LINUXRC)
 static int do_linuxrc(void * shell)
 {
 	static char *argv[] = { "linuxrc", NULL, };
@@ -748,7 +748,7 @@
 
 static void __init handle_initrd(void)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
+#if defined(CONFIG_BLK_DEV_INITRD) && defined(CONFIG_LINUXRC)
 	int ram0 = kdev_t_to_nr(MKDEV(RAMDISK_MAJOR,0));
 	int error;
 	int i, pid;
@@ -801,8 +801,8 @@
 static int __init initrd_load(void)
 {
 #ifdef CONFIG_BLK_DEV_INITRD
-	create_dev("/dev/ram", MKDEV(RAMDISK_MAJOR, 0), NULL);
-	create_dev("/dev/initrd", MKDEV(RAMDISK_MAJOR, INITRD_MINOR), NULL);
+	create_dev("/dev/ram", mk_kdev(RAMDISK_MAJOR, 0), NULL);
+	create_dev("/dev/initrd", mk_kdev(RAMDISK_MAJOR, INITRD_MINOR), NULL);
 #endif
 	return rd_load_image("/dev/initrd");
 }
@@ -816,7 +816,9 @@
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (!initrd_start)
 		mount_initrd = 0;
+# ifdef CONFIG_LINUXRC
 	real_root_dev = ROOT_DEV;
+# endif
 #endif
 	sys_mkdir("/dev", 0700);
 	sys_mkdir("/root", 0700);

--fUYQa+Pmc3FrFX/N--
