Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030783AbVKIVu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030783AbVKIVu4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030784AbVKIVuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:50:55 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:26258 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030783AbVKIVux
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:50:53 -0500
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17266.28445.60709.667841@tut.ibm.com>
Date: Wed, 9 Nov 2005 15:50:21 -0600
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, karim@opersys.com
Subject: [PATCH 2/4] relayfs: Documentation for non-relay file support
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation update for non-relay file support.

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

---

diff --git a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
--- a/Documentation/filesystems/relayfs.txt
+++ b/Documentation/filesystems/relayfs.txt
@@ -44,30 +44,40 @@ relayfs can operate in a mode where it w
 collected by userspace, and not wait for it to consume it.
 
 relayfs itself does not provide for communication of such data between
-userspace and kernel, allowing the kernel side to remain simple and not
-impose a single interface on userspace. It does provide a separate
-helper though, described below.
+userspace and kernel, allowing the kernel side to remain simple and
+not impose a single interface on userspace. It does provide a set of
+examples and a separate helper though, described below.
+
+klog and relay-apps example code
+================================
+
+relayfs itself is ready to use, but to make things easier, a couple
+simple utility functions and a set of examples are provided.
+
+The relay-apps example tarball, available on the relayfs sourceforge
+site, contains a set of self-contained examples, each consisting of a
+pair of .c files containing boilerplate code for each of the user and
+kernel sides of a relayfs application; combined these two sets of
+boilerplate code provide glue to easily stream data to disk, without
+having to bother with mundane housekeeping chores.
+
+The 'klog debugging functions' patch (klog.patch in the relay-apps
+tarball) provides a couple of high-level logging functions to the
+kernel which allow writing formatted text or raw data to a channel,
+regardless of whether a channel to write into exists or not, or
+whether relayfs is compiled into the kernel or is configured as a
+module.  These functions allow you to put unconditional 'trace'
+statements anywhere in the kernel or kernel modules; only when there
+is a 'klog handler' registered will data actually be logged (see the
+klog and kleak examples for details).
+
+It is of course possible to use relayfs from scratch i.e. without
+using any of the relay-apps example code or klog, but you'll have to
+implement communication between userspace and kernel, allowing both to
+convey the state of buffers (full, empty, amount of padding).
 
-klog, relay-app & librelay
-==========================
-
-relayfs itself is ready to use, but to make things easier, two
-additional systems are provided.  klog is a simple wrapper to make
-writing formatted text or raw data to a channel simpler, regardless of
-whether a channel to write into exists or not, or whether relayfs is
-compiled into the kernel or is configured as a module.  relay-app is
-the kernel counterpart of userspace librelay.c, combined these two
-files provide glue to easily stream data to disk, without having to
-bother with housekeeping.  klog and relay-app can be used together,
-with klog providing high-level logging functions to the kernel and
-relay-app taking care of kernel-user control and disk-logging chores.
-
-It is possible to use relayfs without relay-app & librelay, but you'll
-have to implement communication between userspace and kernel, allowing
-both to convey the state of buffers (full, empty, amount of padding).
-
-klog, relay-app and librelay can be found in the relay-apps tarball on
-http://relayfs.sourceforge.net
+klog and the relay-apps examples can be found in the relay-apps
+tarball on http://relayfs.sourceforge.net
 
 The relayfs user space API
 ==========================
@@ -125,6 +135,8 @@ Here's a summary of the API relayfs prov
     relay_reset(chan)
     relayfs_create_dir(name, parent)
     relayfs_remove_dir(dentry)
+    relayfs_create_file(name, parent, mode, fops, data)
+    relayfs_remove_file(dentry)
 
   channel management typically called on instigation of userspace:
 
@@ -320,6 +332,21 @@ forces a sub-buffer switch on all the ch
 to finalize and process the last sub-buffers before the channel is
 closed.
 
+Creating non-relay files
+------------------------
+
+relay_open() automatically creates files in the relayfs filesystem to
+represent the per-cpu kernel buffers; it's often useful for
+applications to be able to create their own files in the relayfs
+filesystem as well e.g. 'control' files used to communicate control
+information between the kernel and user sides of a relayfs
+application.  For this purpose the relayfs_create_file() and
+relayfs_remove_file() API functions exist.  For relayfs_create_file(),
+the caller passes in a set of user-defined file operations to be used
+for the file and an optional void * to a user-specified data item,
+which will be accessible via inode->u.generic_ip (see the relay-apps
+tarball for examples).
+
 Misc
 ----
 



