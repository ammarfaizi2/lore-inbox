Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTFXOcE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 10:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbTFXOcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 10:32:04 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:17817 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S262127AbTFXOcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 10:32:00 -0400
Message-ID: <3EF86337.1020103@sun.com>
Date: Tue, 24 Jun 2003 10:41:59 -0400
From: Mike Waychison <michael.waychison@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.72: follow_mount / follow_link
Content-Type: multipart/mixed;
 boundary="------------090104040709050901040500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090104040709050901040500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Al,

When a follow_link dentry call is made, the implementation expects the 
dentry to be followed as well as a nameidata struct to be filled in. 
The received nd->mnt is expected to contain the vfsmount of the dentry 
being followed, so that a subsequent call to vfs_follow_link may 
properly pivot off that mount and onto another vfsmount as the path of 
the link is walked, thus keeping reference counts proper.

The changes made in fs/namei.c@1.42 break this behaviour iff the dentry 
being follow_link'ed is a root dentry.  This is because follow_mount 
follows down next.mnt and not nd->mnt like it used to.  So, if a root 
dentry has a follow_link op, the nd->mnt it receives is in fact the 
vfsmount of the mount it is mounted upon (which breaks reference counts).

Please apply the attached patch which was made against 2.5.72.

Thanks,

Mike Waychison

--------------090104040709050901040500
Content-Type: text/plain;
 name="ndmnt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ndmnt.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1348  -> 1.1349 
#	          fs/namei.c	1.76    -> 1.77   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/23	mikew@nisserv.test.com	1.1349
# namei.c:
#   nameidata should have the mnt we are looking at when doing a follow_link after a follow_mount
# --------------------------------------------
#
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Tue Jun 24 13:29:37 2003
+++ b/fs/namei.c	Tue Jun 24 13:29:37 2003
@@ -655,6 +655,7 @@
 
 		if (inode->i_op->follow_link) {
 			mntget(next.mnt);
+		        nd->mnt = next.mnt;
 			err = do_follow_link(next.dentry, nd);
 			dput(next.dentry);
 			mntput(next.mnt);
@@ -708,6 +709,7 @@
 		if ((lookup_flags & LOOKUP_FOLLOW)
 		    && inode && inode->i_op && inode->i_op->follow_link) {
 			mntget(next.mnt);
+		        nd->mnt = next.mnt;
 			err = do_follow_link(next.dentry, nd);
 			dput(next.dentry);
 			mntput(next.mnt);

--------------090104040709050901040500--

