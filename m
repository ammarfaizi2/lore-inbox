Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVC3S4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVC3S4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 13:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVC3Szw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 13:55:52 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:18062 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S262399AbVC3Svd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 13:51:33 -0500
Subject: [patch 6/8] uml: fix hostfs special perm handling [for 2.6.12]
To: torvalds@osdl.org
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       rob@landley.net
From: blaisorblade@yahoo.it
Date: Wed, 30 Mar 2005 19:34:00 +0200
Message-Id: <20050330173400.36A5FEFEFF@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
CC: Rob Landley <rob@landley.net>
When opening devices nodes on hostfs, it does not make sense to call
access(), since we are not going to open the file on the host.

If the device node is owned by root, the root user in UML should succeed in
opening it, even if UML won't be able to open the file.

As reported by Rob Landley, UML currently does not follow this, so here's an
(untested) fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-fix-hostfs-special-perm-handling fs/hostfs/hostfs_kern.c
--- linux-2.6.11/fs/hostfs/hostfs_kern.c~uml-fix-hostfs-special-perm-handling	2005-03-22 20:10:07.000000000 +0100
+++ linux-2.6.11-paolo/fs/hostfs/hostfs_kern.c	2005-03-22 20:12:45.000000000 +0100
@@ -806,15 +806,21 @@ int hostfs_permission(struct inode *ino,
 	char *name;
 	int r = 0, w = 0, x = 0, err;
 
-	if(desired & MAY_READ) r = 1;
-	if(desired & MAY_WRITE) w = 1;
-	if(desired & MAY_EXEC) x = 1;
+	if (desired & MAY_READ) r = 1;
+	if (desired & MAY_WRITE) w = 1;
+	if (desired & MAY_EXEC) x = 1;
 	name = inode_name(ino, 0);
-	if(name == NULL) return(-ENOMEM);
-	err = access_file(name, r, w, x);
+	if (name == NULL) return(-ENOMEM);
+
+	if (S_ISCHR(ino->i_mode) || S_ISBLK(ino->i_mode) ||
+			S_ISFIFO(ino->i_mode) || S_ISSOCK(ino->i_mode))
+		err = 0;
+	else
+		err = access_file(name, r, w, x);
 	kfree(name);
-	if(!err) err = generic_permission(ino, desired, NULL);
-	return(err);
+	if(!err)
+		err = generic_permission(ino, desired, NULL);
+	return err;
 }
 
 int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
_
