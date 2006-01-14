Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945926AbWANAnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945926AbWANAnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945906AbWANAnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:43:40 -0500
Received: from adsl-510.mirage.euroweb.hu ([193.226.239.254]:21678 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1945926AbWANAm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:42:28 -0500
Message-Id: <20060114004150.643338000@dorka.pomaz.szeredi.hu>
References: <20060114003948.793910000@dorka.pomaz.szeredi.hu>
Date: Sat, 14 Jan 2006 01:40:05 +0100
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] fuse: update documentation for sysfs
Content-Disposition: inline; filename=fuse_update_doc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for new attributes in sysfs.  Also describe the
different ways a connection may be aborted to a hung or deadlocked
filesystem.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/Documentation/filesystems/fuse.txt
===================================================================
--- linux.orig/Documentation/filesystems/fuse.txt	2006-01-03 04:21:10.000000000 +0100
+++ linux/Documentation/filesystems/fuse.txt	2006-01-14 01:31:13.000000000 +0100
@@ -86,6 +86,62 @@ Mount options
   The default is infinite.  Note that the size of read requests is
   limited anyway to 32 pages (which is 128kbyte on i386).
 
+Sysfs
+~~~~~
+
+FUSE sets up the following hierarchy in sysfs:
+
+  /sys/fs/fuse/connections/N/
+
+where N is an increasing number allocated to each new connection.
+
+For each connection the following attributes are defined:
+
+ 'waiting'
+
+  The number of requests which are waiting to be transfered to
+  userspace or being processed by the filesystem daemon.  If there is
+  no filesystem activity and 'waiting' is non-zero, then the
+  filesystem is hung or deadlocked.
+
+ 'abort'
+
+  Writing anything into this file will abort the filesystem
+  connection.  This means that all waiting requests will be aborted an
+  error returned for all aborted and new requests.
+
+Only a privileged user may read or write these attributes.
+
+Aborting a filesystem connection
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It is possible to get into certain situations where the filesystem is
+not responding.  Reasons for this may be:
+
+  a) Broken userspace filesystem implementation
+
+  b) Network connection down
+
+  c) Accidental deadlock
+
+  d) Malicious deadlock
+
+(For more on c) and d) see later sections)
+
+In either of these cases it may be useful to abort the connection to
+the filesystem.  There are several ways to do this:
+
+  - Kill the filesystem daemon.  Works in case of a) and b)
+
+  - Kill the filesystem daemon and all users of the filesystem.  Works
+    in all cases except some malicious deadlocks
+
+  - Use forced umount (umount -f).  Works in all cases but only if
+    filesystem is still attached (it hasn't been lazy unmounted)
+
+  - Abort filesystem through the sysfs interface.  Most powerful
+    method, always works.
+
 How do non-privileged mounts work?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -313,3 +369,10 @@ faulted with get_user_pages().  The 'req
 when the copy is taking place, and interruption is delayed until
 this flag is unset.
 
+Scenario 3 - Tricky deadlock with asynchronous read
+---------------------------------------------------
+
+The same situation as above, except thread-1 will wait on page lock
+and hence it will be uninterruptible as well.  The solution is to
+abort the connection with forced umount (if mount is attached) or
+through the abort attribute in sysfs.

--
