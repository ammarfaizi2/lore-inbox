Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbTJRTlw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbTJRTlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:41:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13698 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261787AbTJRTlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:41:50 -0400
Date: Sat, 18 Oct 2003 20:41:48 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Christophe Saout <christophe@saout.de>
Cc: Walt H <waltabbyh@comcast.net>, arekm@pld-linux.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] initrd with devfs enabled (Re: initrd and 2.6.0-test8)
Message-ID: <20031018194148.GE7665@parcelfarce.linux.theplanet.co.uk>
References: <3F916A0C.10800@comcast.net> <20031018175236.GA7665@parcelfarce.linux.theplanet.co.uk> <1066501993.4208.6.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066501993.4208.6.camel@chtephan.cs.pocnet.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, that should do it - the problems happened if you had devfs
enabled; in that case late-boot code does temporary mount of devfs over
rootfs /dev, which made /dev/initrd inaccessible.  For setups without
devfs that didn't happen.

	Fix is trivial - put the file in question outside of /dev; IOW,
we simply replace "/dev/initrd" with "/initrd.image" in init/*.  It works
here; please check if it fixes all initrd problems on your boxen.

diff -urN B8/init/do_mounts_initrd.c B8-current/init/do_mounts_initrd.c
--- B8/init/do_mounts_initrd.c	Sat Oct 18 13:09:57 2003
+++ B8-current/init/do_mounts_initrd.c	Sat Oct 18 15:26:58 2003
@@ -109,12 +109,12 @@
 		 * in that case the ram disk is just set up here, and gets
 		 * mounted in the normal path.
 		 */
-		if (rd_load_image("/dev/initrd") && ROOT_DEV != Root_RAM0) {
-			sys_unlink("/dev/initrd");
+		if (rd_load_image("/initrd.image") && ROOT_DEV != Root_RAM0) {
+			sys_unlink("/initrd.image");
 			handle_initrd();
 			return 1;
 		}
 	}
-	sys_unlink("/dev/initrd");
+	sys_unlink("/initrd.image");
 	return 0;
 }
diff -urN B8/init/do_mounts_rd.c B8-current/init/do_mounts_rd.c
--- B8/init/do_mounts_rd.c	Sat Sep 27 22:05:01 2003
+++ B8-current/init/do_mounts_rd.c	Sat Oct 18 15:27:22 2003
@@ -185,7 +185,7 @@
 	else
 		devblocks >>= 1;
 
-	if (strcmp(from, "/dev/initrd") == 0)
+	if (strcmp(from, "/initrd.image") == 0)
 		devblocks = nblocks;
 
 	if (devblocks == 0) {
diff -urN B8/init/initramfs.c B8-current/init/initramfs.c
--- B8/init/initramfs.c	Sat Oct 18 13:09:57 2003
+++ B8-current/init/initramfs.c	Sat Oct 18 15:25:50 2003
@@ -497,7 +497,7 @@
 			return;
 		}
 		printk("it isn't (%s); looks like an initrd\n", err);
-		fd = sys_open("/dev/initrd", O_WRONLY|O_CREAT, 700);
+		fd = sys_open("/initrd.image", O_WRONLY|O_CREAT, 700);
 		if (fd >= 0) {
 			sys_write(fd, (char *)initrd_start,
 					initrd_end - initrd_start);
