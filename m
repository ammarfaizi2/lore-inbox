Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbUJ1URi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUJ1URi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUJ1UQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:16:26 -0400
Received: from paldo.org ([213.202.245.43]:51861 "EHLO buildd1.paldo.org")
	by vger.kernel.org with ESMTP id S262893AbUJ1UGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:06:01 -0400
Subject: [PATCH] Don't remove /sys in initramfs
From: Juerg Billeter <juerg@paldo.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Content-Type: text/plain
Organization: paldo
Date: Thu, 28 Oct 2004 22:05:56 +0200
Message-Id: <1098993956.4570.10.camel@juerg-p4.bitron.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

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

diff -uNr linux-2.6.9.orig/init/do_mounts.c linux-2.6.9/init/do_mounts.c
--- linux-2.6.9.orig/init/do_mounts.c   2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6.9/init/do_mounts.c        2004-10-28 19:04:10.803026647 +0200
@@ -142,7 +142,7 @@
        int part;

 #ifdef CONFIG_SYSFS
-       sys_mkdir("/sys", 0700);
+       int mkdir_err = sys_mkdir("/sys", 0700);
        if (sys_mount("sysfs", "/sys", "sysfs", 0, NULL) < 0)
                goto out;
 #endif
@@ -197,7 +197,8 @@
 #ifdef CONFIG_SYSFS
        sys_umount("/sys", 0);
 out:
-       sys_rmdir("/sys");
+       if (!mkdir_err)
+               sys_rmdir("/sys");
 #endif
        return res;
 fail:


