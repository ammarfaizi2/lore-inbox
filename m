Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265573AbUAZXJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbUAZXJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:09:46 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:38339 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S265573AbUAZXJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:09:41 -0500
Date: Mon, 26 Jan 2004 18:07:33 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 1/2] vfsmount_lock / mnt_parent
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk
Message-id: <40159DB5.2050402@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------090501050108010808040803
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
 Debian/1.6-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501050108010808040803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch makes __d_name grab vfsmount_lock when walking up the mount-tree.

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--------------090501050108010808040803
Content-Type: text/x-patch;
 name="d_name_vfsmount_lock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d_name_vfsmount_lock.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1520  -> 1.1521 
#	         fs/dcache.c	1.64    -> 1.65   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/26	michael.waychison@sun.com	1.1521
# dcache.c:
#   - protect vfsmount->mnt_parent by nesting vfsmount_lock in __d_path
# --------------------------------------------
#
diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Mon Jan 26 21:39:56 2004
+++ b/fs/dcache.c	Mon Jan 26 21:39:56 2004
@@ -1296,10 +1296,14 @@
 			break;
 		if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
 			/* Global root? */
-			if (vfsmnt->mnt_parent == vfsmnt)
+			spin_lock(&vfsmount_lock);
+			if (vfsmnt->mnt_parent == vfsmnt) {
+				spin_unlock(&vfsmount_lock);
 				goto global_root;
+			}
 			dentry = vfsmnt->mnt_mountpoint;
 			vfsmnt = vfsmnt->mnt_parent;
+			spin_unlock(&vfsmount_lock);
 			continue;
 		}
 		parent = dentry->d_parent;

--------------090501050108010808040803--
