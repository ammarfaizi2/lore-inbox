Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTFHGBM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 02:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTFHGBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 02:01:12 -0400
Received: from iris.slb.nwc.acsalaska.net ([209.112.155.43]:18447 "EHLO
	iris.acsalaska.net") by vger.kernel.org with ESMTP id S264509AbTFHGBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 02:01:08 -0400
Date: Sat, 7 Jun 2003 22:14:39 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] don't allow utime()/utimes() on immutable/append-only files
Message-ID: <20030608061439.GA8983@plato.local.lan>
Mail-Followup-To: Ethan Benson <erbenson@alaska.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Debian GNU
X-gpg-fingerprint: E3E4 D0BC 31BC F7BB C1DD  C3D6 24AC 7B1A 2C44 7AFC
X-gpg-key: http://www.alaska.net/~erbenson/gpg/key.asc
X-ACS-Spam-Status: no
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I recently noticed that utime() and utimes() is allowed on immutable
or append-only files.  I believe this should not be permitted.

Attached is a patch which returns -EPERM on attempts to set timestamps
explicitly (utime[s]() with a timebuf arg), and which returns EACCES
when these are called with a NULL time arg for immutable files.

utime/utimes with a NULL time arg is allowed on an append-only file.
Since timestamps are updated when append-only files are written to, it
seems acceptable to allow the timestamp to be updated to the current
time.

I am not subscribed to linux-kernel, so please CC any replies, thanks.

--- linux.orig/fs/open.c	Sun Jun  1 20:39:38 2003
+++ linux/fs/open.c	Sun Jun  1 20:54:14 2003
@@ -272,6 +272,9 @@
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (times) {
+		error = -EPERM;
+		if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
+			goto dput_and_out;
 		error = get_user(newattrs.ia_atime, &times->actime);
 		if (!error) 
 			error = get_user(newattrs.ia_mtime, &times->modtime);
@@ -280,6 +283,9 @@
 
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
+		error = -EACCES;
+		if (IS_IMMUTABLE(inode))
+			goto dput_and_out;
 		if (current->fsuid != inode->i_uid &&
 		    (error = permission(inode,MAY_WRITE)) != 0)
 			goto dput_and_out;
@@ -318,6 +324,9 @@
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (utimes) {
 		struct timeval times[2];
+		error = -EPERM;
+		if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
+			goto dput_and_out;
 		error = -EFAULT;
 		if (copy_from_user(&times, utimes, sizeof(times)))
 			goto dput_and_out;
@@ -325,6 +334,10 @@
 		newattrs.ia_mtime = times[1].tv_sec;
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
+		error = -EACCES;
+		if (IS_IMMUTABLE(inode))
+			goto dput_and_out;
+
 		if (current->fsuid != inode->i_uid &&
 		    (error = permission(inode,MAY_WRITE)) != 0)
 			goto dput_and_out;


-- 
Ethan Benson
http://www.alaska.net/~erbenson/
