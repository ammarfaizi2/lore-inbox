Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310441AbSCLGf0>; Tue, 12 Mar 2002 01:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310438AbSCLGfR>; Tue, 12 Mar 2002 01:35:17 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:45753 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S310451AbSCLGfE>;
	Tue, 12 Mar 2002 01:35:04 -0500
Date: Tue, 12 Mar 2002 17:33:32 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, Linus <torvalds@transmeta.com>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Oskar Liljeblad <oskar@osk.mine.nu>, <mjp@securepipe.com>
Subject: [PATCH] dnotify
Message-Id: <20020312173332.5bf6f277.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo, Linus,

The following patch makes directory notifications per thread group instead
of per process tree as they are now.  This means, in particular, that if
a child closes a file descriptor that has a directory open with notifies
enabled, the notification will not be removed.

Thanks to Andrea for the push in the right direction.

Patch against 2.4.19-pre3, but also applies to 2.5.6 with a small offset.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.4.19-pre3/fs/dnotify.c 2.4.19-pre3-notify/fs/dnotify.c
--- 2.4.19-pre3/fs/dnotify.c	Wed Nov  8 18:27:57 2000
+++ 2.4.19-pre3-notify/fs/dnotify.c	Tue Mar 12 12:02:15 2002
@@ -1,7 +1,7 @@
 /*
  * Directory notifications for Linux.
  *
- * Copyright (C) 2000 Stephen Rothwell
+ * Copyright (C) 2000,2001,2002 Stephen Rothwell
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -59,7 +59,7 @@
 	write_lock(&dn_lock);
 	prev = &inode->i_dnotify;
 	for (odn = *prev; odn != NULL; prev = &odn->dn_next, odn = *prev)
-		if (odn->dn_filp == filp)
+		if ((odn->dn_owner == current->files) && (odn->dn_filp == filp))
 			break;
 	if (odn != NULL) {
 		if (turning_off) {
@@ -82,6 +82,7 @@
 	dn->dn_mask = arg;
 	dn->dn_fd = fd;
 	dn->dn_filp = filp;
+	dn->dn_owner = current->files;
 	inode->i_dnotify_mask |= arg & ~DN_MULTISHOT;
 	dn->dn_next = inode->i_dnotify;
 	inode->i_dnotify = dn;
diff -ruN 2.4.19-pre3/include/linux/dnotify.h 2.4.19-pre3-notify/include/linux/dnotify.h
--- 2.4.19-pre3/include/linux/dnotify.h	Wed Mar  6 16:08:12 2002
+++ 2.4.19-pre3-notify/include/linux/dnotify.h	Tue Mar 12 11:23:07 2002
@@ -11,6 +11,7 @@
 						   see linux/fcntl.h */
 	int			dn_fd;
 	struct file *		dn_filp;
+	fl_owner_t		dn_owner;
 };
 
 #define DNOTIFY_MAGIC	0x444E4F54
