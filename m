Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbUKKQd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbUKKQd4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUKKQdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:33:55 -0500
Received: from paldo.org ([213.202.245.43]:17558 "EHLO buildd1.paldo.org")
	by vger.kernel.org with ESMTP id S262278AbUKKQdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:33:53 -0500
Subject: [PATCH RESEND] Don't remove /sys in initramfs
From: Juerg Billeter <juerg@paldo.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Organization: paldo
Date: Thu, 11 Nov 2004 17:33:48 +0100
Message-Id: <1100190828.5888.0.camel@juerg-p4.bitron.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the "resume" kernel parameter together with an initramfs revealed
a bug that causes removal of the /sys directory in the initramfs' tmpfs,
making the system unbootable.

The source of the problem is that the try_name() function removes
the /sys directory unconditionally, instead of removing it only when it
has been created by try_name().

The attached patch only removes /sys if it has been created before.

Please CC me, I'm not on lkml.

	Juerg

--
Signed-off-by: Juerg Billeter <juerg@paldo.org>

diff -upNr linux-2.6.10-rc1-bk15.orig/init/do_mounts.c linux-2.6.10-rc1-bk15/init/do_mounts.c
--- linux-2.6.10-rc1-bk15.orig/init/do_mounts.c 2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6.10-rc1-bk15/init/do_mounts.c      2004-11-05 16:24:17.816549948 +0100
@@ -142,7 +142,7 @@ dev_t __init name_to_dev_t(char *name)
        int part;

 #ifdef CONFIG_SYSFS
-       sys_mkdir("/sys", 0700);
+       int mkdir_err = sys_mkdir("/sys", 0700);
        if (sys_mount("sysfs", "/sys", "sysfs", 0, NULL) < 0)
                goto out;
 #endif
@@ -197,7 +197,8 @@ done:
 #ifdef CONFIG_SYSFS
        sys_umount("/sys", 0);
 out:
-       sys_rmdir("/sys");
+       if (!mkdir_err)
+               sys_rmdir("/sys");
 #endif
        return res;
 fail:


