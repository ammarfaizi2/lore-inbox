Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTJYXOg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 19:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTJYXOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 19:14:36 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:4100 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S262855AbTJYXOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 19:14:34 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.6.0-test8] fix new initrd with devfs
Date: Sun, 26 Oct 2003 02:23:22 +0300
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qXwm/Lhm5/EMQDY"
Message-Id: <200310260223.22765.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_qXwm/Lhm5/EMQDY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

If devfs is mounted on boot initrd does not work. devfs does not allow 
creation of files other than device and symlink. Now when initrd is no more 
device there is no reason to create it in /dev either. The patch simply 
changes /dev/initrd -> /initrd.img. I do not insist on this name :)

regards

-andrey

--Boundary-00=_qXwm/Lhm5/EMQDY
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.0-test8-initrd_with_devfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.0-test8-initrd_with_devfs.patch"

--- ../tmp/linux-2.6.0-test8/init/initramfs.c	2003-10-25 22:26:11.000000000 +0400
+++ linux-2.6.0-test8/init/initramfs.c	2003-10-26 02:04:00.000000000 +0400
@@ -497,7 +497,7 @@ void __init populate_rootfs(void)
 			return;
 		}
 		printk("it isn't (%s); looks like an initrd\n", err);
-		fd = sys_open("/dev/initrd", O_WRONLY|O_CREAT, 700);
+		fd = sys_open("/initrd.img", O_WRONLY|O_CREAT, 700);
 		if (fd >= 0) {
 			sys_write(fd, (char *)initrd_start,
 					initrd_end - initrd_start);
--- ../tmp/linux-2.6.0-test8/init/do_mounts_rd.c	2003-10-25 22:22:22.000000000 +0400
+++ linux-2.6.0-test8/init/do_mounts_rd.c	2003-10-26 02:08:02.000000000 +0400
@@ -185,7 +185,7 @@ int __init rd_load_image(char *from)
 	else
 		devblocks >>= 1;
 
-	if (strcmp(from, "/dev/initrd") == 0)
+	if (strcmp(from, "/initrd.img") == 0)
 		devblocks = nblocks;
 
 	if (devblocks == 0) {
--- ../tmp/linux-2.6.0-test8/init/do_mounts_initrd.c	2003-10-25 22:26:11.000000000 +0400
+++ linux-2.6.0-test8/init/do_mounts_initrd.c	2003-10-26 02:03:37.000000000 +0400
@@ -109,12 +109,12 @@ int __init initrd_load(void)
 		 * in that case the ram disk is just set up here, and gets
 		 * mounted in the normal path.
 		 */
-		if (rd_load_image("/dev/initrd") && ROOT_DEV != Root_RAM0) {
-			sys_unlink("/dev/initrd");
+		if (rd_load_image("/initrd.img") && ROOT_DEV != Root_RAM0) {
+			sys_unlink("/initrd.img");
 			handle_initrd();
 			return 1;
 		}
 	}
-	sys_unlink("/dev/initrd");
+	sys_unlink("/initrd.img");
 	return 0;
 }

--Boundary-00=_qXwm/Lhm5/EMQDY--

