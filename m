Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266615AbSKGWhY>; Thu, 7 Nov 2002 17:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266618AbSKGWhX>; Thu, 7 Nov 2002 17:37:23 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:13696 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266615AbSKGWhS>; Thu, 7 Nov 2002 17:37:18 -0500
Date: Thu, 7 Nov 2002 17:43:54 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] too many setattr calls from VFS layer
Message-ID: <Pine.LNX.4.44.0211071740520.18237-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

new code in 2.5 VFS layer invokes notify_change to clear the suid and sgid
bits for every write request.  notify_change needs to optimize out calls
to ->setattr that don't do anything, because for many network file
systems, an on-the-wire SETATTR request is generated for every ->setattr
call, resulting in unnecessary latency for NFS writes.


diff -ruN 05-nfsroot/fs/attr.c 06-setattr/fs/attr.c
--- 05-nfsroot/fs/attr.c	Mon Nov  4 17:30:07 2002
+++ 06-setattr/fs/attr.c	Thu Nov  7 17:31:37 2002
@@ -134,6 +134,7 @@
 	if (!(ia_valid & ATTR_MTIME_SET))
 		attr->ia_mtime = now;
 	if (ia_valid & ATTR_KILL_SUID) {
+		attr->ia_valid &= ~ATTR_KILL_SUID;
 		if (mode & S_ISUID) {
 			if (!(ia_valid & ATTR_MODE)) {
 				ia_valid = attr->ia_valid |= ATTR_MODE;
@@ -143,6 +144,7 @@
 		}
 	}
 	if (ia_valid & ATTR_KILL_SGID) {
+		attr->ia_valid &= ~ ATTR_KILL_SGID;
 		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
 			if (!(ia_valid & ATTR_MODE)) {
 				ia_valid = attr->ia_valid |= ATTR_MODE;
@@ -151,6 +153,8 @@
 			attr->ia_mode &= ~S_ISGID;
 		}
 	}
+	if (!attr->ia_valid)
+		return 0;
 
 	if (inode->i_op && inode->i_op->setattr) {
 		error = security_ops->inode_setattr(dentry, attr);

