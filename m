Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVBGTTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVBGTTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBGTRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:17:16 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:33971 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261249AbVBGTPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:15:31 -0500
Subject: [patch 2/2] uml - hostfs: (security) fix chmod +s permission check [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       xraz@rwxr-xr-x.de, viro@parcelfarce.linux.theplanet.co.uk
From: blaisorblade@yahoo.it
Date: Mon, 07 Feb 2005 20:11:35 +0100
Message-Id: <20050207191135.D8BC750BF2@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Frank 'xraz' Fricke <xraz@rwxr-xr-x.de>, Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>

Frank Fricke reported that hostfs does not verify that a chmod +s, for
instance, is done by a sufficiently privileged user, as long as the UML kernel
itself can complete the operation on the host.

So, for instance, if UML is run as root and under /mnt/host we have a hostfs
mount, this works successfully:

paolo@zion:~ (0)$ chmod 4755 /mnt/host/bin/bash
paolo@zion:~ (0)$ ll /mnt/host/bin/bash

 -rwsr-xr-x  1 root root 662724 2004-10-20 02:15 /mnt/host/bin/bash*

(bash refuses running as setuid, but you could have another shell on the host,
as dash or whatever).

In general, if UML is run as uid 500 on the host, a hostfs mount is done and
under the hostfs mount there is a file with uid 500 on the host, I can freely
make it setuid (if it's executable).

This is especially bad when UML is run as root (which you should not do), but
is a problem in general, since it allows any user to create setuid 500 (in
this example) executables on the host filesystem.

Finally, while I was looking at the chmod() implementation, I spotted a kludge
in the code and explained it with a comment.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/fs/hostfs/hostfs.h      |   21 +++++++++++++++++++++
 linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c |    4 ++++
 2 files changed, 25 insertions(+)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-fix-setuid-permission-check fs/hostfs/hostfs_kern.c
--- linux-2.6.11/fs/hostfs/hostfs_kern.c~uml-hostfs-fix-setuid-permission-check	2005-02-07 19:37:51.661248648 +0100
+++ linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c	2005-02-07 19:39:24.317162808 +0100
@@ -823,6 +823,10 @@ int hostfs_setattr(struct dentry *dentry
 	char *name;
 	int err;
 
+	err = inode_change_ok(dentry->d_inode, attr);
+	if (err)
+		return err;
+
 	if(append)
 		attr->ia_valid &= ~ATTR_SIZE;
 
diff -puN fs/hostfs/hostfs.h~uml-hostfs-fix-setuid-permission-check fs/hostfs/hostfs.h
--- linux-2.6.11/fs/hostfs/hostfs.h~uml-hostfs-fix-setuid-permission-check	2005-02-07 19:37:51.663248344 +0100
+++ linux-2.6.11-paolo/fs/hostfs/hostfs.h	2005-02-07 19:37:51.666247888 +0100
@@ -16,9 +16,30 @@
 #define HOSTFS_ATTR_CTIME	64
 #define HOSTFS_ATTR_ATIME_SET	128
 #define HOSTFS_ATTR_MTIME_SET	256
+
+/* These two are unused by hostfs. */
 #define HOSTFS_ATTR_FORCE	512	/* Not a change, but a change it */
 #define HOSTFS_ATTR_ATTR_FLAG	1024
 
+/* If you are very careful, you'll notice that these two are missing:
+ *
+ * #define ATTR_KILL_SUID	2048
+ * #define ATTR_KILL_SGID	4096
+ *
+ * and this is because they were added in 2.5 development in this patch:
+ *
+ * http://linux.bkbits.net:8080/linux-2.5/
+ * cset@3caf4a12k4XgDzK7wyK-TGpSZ9u2Ww?nav=index.html
+ * |src/.|src/include|src/include/linux|related/include/linux/fs.h
+ *
+ * Actually, they are not needed by most ->setattr() methods - they are set by
+ * callers of notify_change() to notify that the setuid/setgid bits must be
+ * dropped.
+ * notify_change() will delete those flags, make sure attr->ia_valid & ATTR_MODE
+ * is on, and remove the appropriate bits from attr->ia_mode (attr is a
+ * "struct iattr *"). -BlaisorBlade
+ */
+
 struct hostfs_iattr {
 	unsigned int	ia_valid;
 	mode_t		ia_mode;
_
