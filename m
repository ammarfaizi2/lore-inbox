Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTE0PQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbTE0PQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:16:32 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:15798 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S263807AbTE0PQ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:16:28 -0400
Date: Tue, 27 May 2003 11:29:53 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: devfs@oss.sgi.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Graceful failure in devfs_remove() in 2.5.x
Message-ID: <Pine.LNX.4.55.0305271105110.1412@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

It's already the second time that I encounter a kernel panic in the same
place.  When devfs_remove() is called on a non-existent file entry, the
kernel panics and I have to reboot the system.

First time it was unregistering of pseudoterminals.  This time it's
ide-floppy module that doesn't register devfs entries if the media is
absent but still tries to unregister them.  The bug in ide-floppy will be
reported separately.

The point of this message is that the failure in devfs_remove() is
possible, especially with rarely used drivers.  Secondly, is not fatal
enough to justify an immediate panic and reboot.  Thirdly, devfs misses a
chance to tell the user what's going wrong.

This patch makes devfs_remove() print an error to the kernel log and
continue.  PRINTK is defined in fs/devfs/base.c to report errors in the
cases like this one:

#define PRINTK(format, args...) \
   {printk (KERN_ERR "%s" format, __FUNCTION__ , ## args);}

The patch:

==============================================
--- linux.orig/fs/devfs/base.c
+++ linux/fs/devfs/base.c
@@ -1710,6 +1710,11 @@ void devfs_remove(const char *fmt, ...)
 	if (n < 64 && buf[0]) {
 		devfs_handle_t de = _devfs_find_entry(NULL, buf, 0);

+		if (!de) {
+			PRINTK ("(%s): not found, cannot remove\n", buf);
+			return;
+		}
+
 		write_lock(&de->parent->u.dir.lock);
 		_devfs_unregister(de->parent, de);
 		devfs_put(de);
==============================================

The patch is against Linux 2.5.70.

Linux 2.4.21-rc4 already has protection against panic although it doesn't
print the error message - see devfs_unlink() in fs/devfs/base.c

-- 
Regards,
Pavel Roskin
