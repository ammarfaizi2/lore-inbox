Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264718AbTIJIdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 04:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTIJIdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 04:33:10 -0400
Received: from dp.samba.org ([66.70.73.150]:36761 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264754AbTIJIdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 04:33:03 -0400
Date: Wed, 10 Sep 2003 18:31:30 +1000
From: Anton Blanchard <anton@samba.org>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] quieten initramfs and fix /dev permissions
Message-ID: <20030910083130.GF1532@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dont print the contents of the initramfs, for any decent sized cpio it will
overflow the kernel ring buffer. 

Also relax permissions on /dev (755 not 700).


 work-anton/init/initramfs.c     |    1 -
 work-anton/usr/gen_init_cpio.c  |    2 +-

diff -puN init/initramfs.c~initramfs_stuff init/initramfs.c
--- work/init/initramfs.c~initramfs_stuff	2003-09-06 22:58:23.000000000 -0500
+++ work-anton/init/initramfs.c	2003-09-10 03:04:31.000000000 -0500
@@ -248,7 +248,6 @@ static int __init do_name(void)
 		next_state = Reset;
 		return 0;
 	}
-	printk(KERN_INFO "-> %s\n", collected);
 	if (S_ISREG(mode)) {
 		if (maybe_link() >= 0) {
 			wfd = sys_open(collected, O_WRONLY|O_CREAT, mode);
diff -puN usr/gen_init_cpio.c~initramfs_stuff usr/gen_init_cpio.c
--- work/usr/gen_init_cpio.c~initramfs_stuff	2003-09-06 22:58:23.000000000 -0500
+++ work-anton/usr/gen_init_cpio.c	2003-09-06 22:58:23.000000000 -0500
@@ -212,7 +212,7 @@ error:
 
 int main (int argc, char *argv[])
 {
-	cpio_mkdir("/dev", 0700, 0, 0);
+	cpio_mkdir("/dev", 0755, 0, 0);
 	cpio_mknod("/dev/console", 0600, 0, 0, 'c', 5, 1);
 	cpio_mkdir("/root", 0700, 0, 0);
 	cpio_trailer();
