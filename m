Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVCWDsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVCWDsH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 22:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVCWDsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 22:48:07 -0500
Received: from fire.osdl.org ([65.172.181.4]:4562 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262752AbVCWDsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 22:48:00 -0500
Date: Tue, 22 Mar 2005 19:47:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Tetsuji \"Maverick\" Rai" <badtrans666@yahoo.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: prompt_ramdisk=1 and load_ramdisk=1 doesn't work with 2.6.11 on
 floppy
Message-Id: <20050322194741.3b251b05.akpm@osdl.org>
In-Reply-To: <423ED8C7.1020008@yahoo.co.jp>
References: <423ED8C7.1020008@yahoo.co.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tetsuji \"Maverick\" Rai" <badtrans666@yahoo.co.jp> wrote:
>
> I am making a small boot-floppy linux distro with kernel 2.6.11.   The
>  kernel is so big that I need to load ramdisk from the second floppy
>  and I don't use initrd.   My problem is the kernel wouldn't prompt to
>  load ramdisk image.  I tried syslinux, grub and lilo as boot loader
>  and for syslinux,

The basic mechanism seems to work OK here.  I couldn't be bothered setting
up a floppy so I patched things:

--- 25/init/do_mounts_rd.c~a	2005-03-22 19:16:22.000000000 -0800
+++ 25-akpm/init/do_mounts_rd.c	2005-03-22 19:16:26.000000000 -0800
@@ -12,7 +12,7 @@
 
 #define BUILD_CRAMDISK
 
-int __initdata rd_prompt = 1;/* 1 = prompt for RAM disk, 0 = don't prompt */
+int rd_prompt = 1;/* 1 = prompt for RAM disk, 0 = don't prompt */
 
 static int __init prompt_ramdisk(char *str)
 {
diff -puN init/do_mounts.c~a init/do_mounts.c
--- 25/init/do_mounts.c~a	2005-03-22 19:32:53.000000000 -0800
+++ 25-akpm/init/do_mounts.c	2005-03-22 19:41:38.000000000 -0800
@@ -371,8 +371,7 @@ void __init mount_root(void)
 		ROOT_DEV = Root_FD0;
 	}
 #endif
-#ifdef CONFIG_BLK_DEV_FD
-	if (MAJOR(ROOT_DEV) == FLOPPY_MAJOR) {
+	if (1) {
 		/* rd_doload is 2 for a dual initrd/ramload setup */
 		if (rd_doload==2) {
 			if (rd_load_disk(1)) {
@@ -382,7 +381,6 @@ void __init mount_root(void)
 		} else
 			change_floppy("root floppy");
 	}
-#endif
 	create_dev("/dev/root", ROOT_DEV, root_device_name);
 	mount_block_root("/dev/root", root_mountflags);
 }
_


The machine does pause at the prompt.

So I'd suggest that you need to start sticking printk()s into mount_root(),
rd_load_disk() and change_floppy(), see if you can work out what's
happening. 
