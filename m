Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269225AbTGJLsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 07:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269226AbTGJLsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 07:48:36 -0400
Received: from neko.kfib.org ([193.12.253.17]:15759 "EHLO neko.kfib.org")
	by vger.kernel.org with ESMTP id S269225AbTGJLsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 07:48:30 -0400
Date: Thu, 10 Jul 2003 14:03:15 +0200
Message-Id: <200307101203.h6AC3FB17406@neko.kfib.org>
From: "=^.^=" <martin@kfib.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Bug in initrd-handling while remounting the root
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At work we've encountered a problem when trying to netboot 2.4.21.
After /linuxrc has been executed and the kernel tries to remount the
root, it panics with the all too well known message "Unable to mount
root fs on ...".

The kernel bugs out in mount_block_root in the file init/do_mounts.c,
to be more precise in the for-loop. What happens is that it tries to
mount the file system as type ext2 (which happens to be first in the
list in our case), but instead of returning -EINVAL it returns -EBUSY,
the loop exits instead of trying the next (correct) fs-type and the
kernel panics.

Here's a patch:

--- linux-2.4.21/init/do_mounts.orig	Thu Jul 10 13:44:03 2003
+++ linux-2.4.21/init/do_mounts.c	Thu Jul 10 13:46:36 2003
@@ -359,6 +359,7 @@
 				flags |= MS_RDONLY;
 				goto retry;
 			case -EINVAL:
+		        case -EBUSY:
 				continue;
 		}
 	        /*

--
Martin Persson           martin@kfib.org
http://martin.kfib.org/  http://ss.kfib.org/

  "esound is junk. The only thing esd has is a good client API for
   going boing at approximately the right time. Anything else is
   beyond it." -- Alan Cox
