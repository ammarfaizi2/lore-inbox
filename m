Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262703AbVF3A3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbVF3A3Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 20:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVF3A3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 20:29:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4258 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262703AbVF3A3R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 20:29:17 -0400
Message-ID: <42C33CD8.6080002@engr.sgi.com>
Date: Wed, 29 Jun 2005 17:29:12 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.12] Improper initrd failure message at boot time
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050602050105070309080006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050602050105070309080006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

On system boot up, there was an failure reported to boot.msg:

     <5>Trying to move old root to /initrd ... failed

According to initrd(4) man page, step #7 of BOOT-UP OPERATION
is described as below:
          7. If the normal root file has directory /initrd, device
          /dev/ram0 is moved from  /  to  /initrd.   Otherwise  if
          directory  /initrd  does  not  exist device /dev/ram0 is
          unmounted.

We got service calls from customers concerning about this failure
message at boot time. Many systems do not have /initrd and thus
the message can be changed in the case of non-existing /initrd
so that it does not sound like a failure of the system.


Signed-off-by: Jay Lan <jlan@sgi.com>

--------------050602050105070309080006
Content-Type: text/plain;
 name="handle_initrd-2.6.12"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="handle_initrd-2.6.12"

Index: linux/init/do_mounts_initrd.c
===================================================================
--- linux.orig/init/do_mounts_initrd.c	2005-06-17 12:48:29.000000000 -0700
+++ linux/init/do_mounts_initrd.c	2005-06-29 16:48:21.512229871 -0700
@@ -86,7 +86,10 @@ static void __init handle_initrd(void)
 		printk("okay\n");
 	else {
 		int fd = sys_open("/dev/root.old", O_RDWR, 0);
-		printk("failed\n");
+		if (error == -ENOENT)
+			printk("/initrd does not exist. Ignored.\n");
+		else
+			printk("failed\n");
 		printk(KERN_NOTICE "Unmounting old root\n");
 		sys_umount("/old", MNT_DETACH);
 		printk(KERN_NOTICE "Trying to free ramdisk memory ... ");

--------------050602050105070309080006--
