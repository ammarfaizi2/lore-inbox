Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129723AbQKHGlT>; Wed, 8 Nov 2000 01:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129747AbQKHGlJ>; Wed, 8 Nov 2000 01:41:09 -0500
Received: from linuxcare.com.au ([203.29.91.49]:18957 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S129723AbQKHGku>; Wed, 8 Nov 2000 01:40:50 -0500
Message-Id: <200011080640.eA86ejJ24397@wattle.linuxcare.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Obscure possible bug in directory notify
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24394.973665644.1@linuxcare.com.au>
Date: Wed, 08 Nov 2000 17:40:44 +1100
From: Stephen Rothwell <sfr@linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This patch fixes a place where we could return with a read/write
lock held.  Also update MAINTAINERS and CREDITS files.

Cheers,
Stephen
-- 
Stephen Rothwell, Open Source Researcher, Linuxcare, Inc.
+61-2-62628990 tel, +61-2-62628991 fax 
sfr@linuxcare.com.au, http://www.linuxcare.com/ 
Linuxcare. Support for the revolution.

diff -ruN 2.4.0-test11pre1/CREDITS 2.4.0-test11pre1-not1/CREDITS
--- 2.4.0-test11pre1/CREDITS	Wed Nov  8 10:07:59 2000
+++ 2.4.0-test11pre1-not1/CREDITS	Wed Nov  8 17:09:20 2000
@@ -2240,11 +2240,12 @@
 S: Germany
 
 N: Stephen Rothwell
-E: sfr@linuxcare.com
+E: sfr@linuxcare.com.au
 W: http://linuxcare.com.au/sfr
 P: 1024/BD8C7805 CD A4 9D 01 10 6E 7E 3B  91 88 FA D9 C8 40 AA 02
 D: Boot/setup/build work for setup > 2K
 D: Author, APM driver
+D: Directory notification
 S: 66 Maltby Circuit
 S: Wanniassa ACT 2903
 S: Australia
diff -ruN 2.4.0-test11pre1/MAINTAINERS 2.4.0-test11pre1-not1/MAINTAINERS
--- 2.4.0-test11pre1/MAINTAINERS	Wed Nov  1 09:36:12 2000
+++ 2.4.0-test11pre1-not1/MAINTAINERS	Wed Nov  8 17:08:05 2000
@@ -353,6 +353,12 @@
 L:	digilnux@dgii.com
 S:	Maintained
 
+DIRECTORY NOTIFICATION
+P:	Stephen Rothwell
+M:	sfr@linuxcare.com.au
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+
 DISK GEOMETRY AND PARTITION HANDLING
 P:     Andries Brouwer
 M:     aeb@veritas.com
diff -ruN 2.4.0-test11pre1/fs/dnotify.c 2.4.0-test11pre1-not1/fs/dnotify.c
--- 2.4.0-test11pre1/fs/dnotify.c	Wed Oct  4 10:37:09 2000
+++ 2.4.0-test11pre1-not1/fs/dnotify.c	Wed Nov  8 17:06:08 2000
@@ -103,14 +103,14 @@
 	write_lock(&dn_lock);
 	prev = &inode->i_dnotify;
 	while ((dn = *prev) != NULL) {
-		if ((dn->dn_mask & event) == 0) {
-			prev = &dn->dn_next;
-			continue;
-		}
 		if (dn->dn_magic != DNOTIFY_MAGIC) {
 		        printk(KERN_ERR "__inode_dir_notify: bad magic "
 				"number in dnotify_struct!\n");
-		        return;
+		        goto out;
+		}
+		if ((dn->dn_mask & event) == 0) {
+			prev = &dn->dn_next;
+			continue;
 		}
 		fown = &dn->dn_filp->f_owner;
 		if (fown->pid)
@@ -125,6 +125,7 @@
 	}
 	if (changed)
 		redo_inode_mask(inode);
+out:
 	write_unlock(&dn_lock);
 }
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
