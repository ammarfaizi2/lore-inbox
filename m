Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVD1O1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVD1O1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 10:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVD1O1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 10:27:55 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:1705 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261329AbVD1O1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 10:27:39 -0400
To: akpm@osdl.org
CC: hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] FUSE: document serurity measures
Message-Id: <E1DR9z6-0005uK-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 28 Apr 2005 16:27:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents the security problems and solutions associated
with allowing mounts by non-privileged users.  I hope it clears up
some of the confusion that surrounds this area.  Thanks to everyone on
linux-fsdevel who contributed to the discussion.

Comments and corrections are welcome of course.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup linux-2.6.12-rc2-mm3/Documentation/filesystems/fuse.txt linux-fuse/Documentation/filesystems/fuse.txt
--- linux-2.6.12-rc2-mm3/Documentation/filesystems/fuse.txt	2005-04-22 15:37:19.000000000 +0200
+++ linux-fuse/Documentation/filesystems/fuse.txt	2005-04-28 15:32:02.000000000 +0200
@@ -1,3 +1,135 @@
+Definitions
+~~~~~~~~~~~
+
+Userspace filesystem:
+
+  A filesystem in which data and metadata are provided by an ordinary
+  userspace process.  The filesystem can be accessed normally through
+  the kernel interface.
+
+Filesystem daemon:
+
+  The process(es) providing the data and metadata of the filesystem.
+
+Non-privileged mount (or user mount):
+
+  A userspace filesystem mounted by a non-privileged (non-root) user.
+  The filesystem daemon is running with the privileges of the mounting
+  user.  NOTE: this is not the same as mounts allowed with the "user"
+  option in /etc/fstab, which is not discussed here.
+
+Mount owner:
+
+  The user who does the mounting.
+
+User:
+
+  The user who is performing filesystem operations.
+
+What is FUSE?
+~~~~~~~~~~~~~
+
+FUSE is a userspace filesystem framework.  It consists of a kernel
+module (fuse.ko), a userspace library (libfuse.*) and a mount utility
+(fusermount).
+
+One of the most important features of FUSE is allowing secure,
+non-privileged mounts.  This opens up new possibilities for the use of
+filesystems.  A good example is sshfs: a secure network filesystem
+using the sftp protocol.
+
+How do non-privileged mounts work?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Since the mount() system call is a privileged operation, a helper
+program (fusermount) is needed, which is installed setuid root.
+
+The implication of providing non-privileged mounts is that the mount
+owner must not be able to use this capability to compromise the
+system.  Obvious requirements arising from this are:
+
+ A) mount owner should not be able to get elevated privileges with the
+    help of the mounted filesystem
+
+ B) mount owner should not get illegitimate access to information from
+    other users' and the super user's processes
+
+ C) mount owner should not be able to induce undesired behavior in
+    other users' or the super user's processes
+
+How are requirements fulfilled?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+ A) The mount owner could gain elevated privileges by either:
+
+     1) creating a filesystem containing a device file, then opening
+	this device
+
+     2) creating a filesystem containing a suid or sgid application,
+	then executing this application
+
+    The solution is not to allow opening device files and ignore
+    setuid and setgid bits when executing programs.  To ensure this
+    fusermount always adds "nosuid" and "nodev" to the mount options
+    for non-privileged mounts.
+
+ B) If another user is accessing files or directories in the
+    filesystem, the filesystem daemon serving requests can record the
+    exact sequence and timing of operations performed.  This
+    information is otherwise inaccessible to the mount owner, so this
+    counts as an information leak.
+
+    The solution to this problem will be presented in point 2) of C).
+
+ C) There are several ways in which the mount owner can induce
+    undesired behavior in other users' processes, such as:
+
+     1) mounting a filesystem over a file or directory which the mount
+        owner could otherwise not be able to modify (or could only
+        make limited modifications).
+
+        This is solved in fusermount, by checking the access
+        permissions on the mountpoint and only allowing the mount if
+        the mount owner can do unlimited modification (has write
+        access to the mountpoint, and mountpoint is not a "sticky"
+        directory)
+
+     2) Even if 1) is solved the mount owner can change the behavior
+        of other users' processes.  
+
+         - It can slow down or indefinitely delay the execution of a
+           filesystem operation creating a DoS against the user or the
+           whole system.  For example a suid application locking a
+           system file, and then accessing a file on the mount owner's
+           filesystem could be stopped, and thus causing the system
+           file to be locked forever.
+
+         - It can present files or directories of unlimited length, or
+           directory structures of unlimited depth, possibly causing a
+           system process to eat up diskspace, memory or other
+           resources, again causing DoS.
+
+	The solution to this as well as B) is not to allow processes
+	to access the filesystem, which could otherwise not be
+	monitored or manipulated by the mount owner.  Since if the
+	mount owner can ptrace a process, it can do all of the above
+	without using a FUSE mount, the same criteria as used in
+	ptrace can be used to check if a process is allowed to access
+	the filesystem or not.
+
+I think these limitations are unacceptable?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If a sysadmin trusts the users enough, or can ensure through other
+measures, that system processes will never enter non-privileged
+mounts, it can relax the last limitation with a "user_allow_other"
+config option.  If this config option is set, the mounting user can
+add the "allow_other" mount option which disables the check for other
+users' processes.
+
+Kernel - userspace interface 
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 The following diagram shows how a filesystem operation (in this
 example unlink) is performed in FUSE.
 
