Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936393AbWLDMhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936393AbWLDMhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936374AbWLDMg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:36:59 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:21983 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936335AbWLDMgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:36:44 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 12/35] Unionfs: Documentation
Date: Mon,  4 Dec 2006 07:30:45 -0500
Message-Id: <11652354701616-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains documentation for Unionfs. You will find several files
outlining basic unification concepts and rename semantics.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
---
 Documentation/filesystems/00-INDEX             |    2 +
 Documentation/filesystems/unionfs/00-INDEX     |    8 +++
 Documentation/filesystems/unionfs/concepts.txt |   68 ++++++++++++++++++++++++
 Documentation/filesystems/unionfs/rename.txt   |   31 +++++++++++
 Documentation/filesystems/unionfs/usage.txt    |   41 ++++++++++++++
 5 files changed, 150 insertions(+), 0 deletions(-)

diff --git a/Documentation/filesystems/00-INDEX b/Documentation/filesystems/00-INDEX
index 4dc28cc..c737e3e 100644
--- a/Documentation/filesystems/00-INDEX
+++ b/Documentation/filesystems/00-INDEX
@@ -82,6 +82,8 @@ udf.txt
 	- info and mount options for the UDF filesystem.
 ufs.txt
 	- info on the ufs filesystem.
+unionfs/
+	- info on the unionfs filesystem
 v9fs.txt
 	- v9fs is a Unix implementation of the Plan 9 9p remote fs protocol.
 vfat.txt
diff --git a/Documentation/filesystems/unionfs/00-INDEX b/Documentation/filesystems/unionfs/00-INDEX
new file mode 100644
index 0000000..fa87f83
--- /dev/null
+++ b/Documentation/filesystems/unionfs/00-INDEX
@@ -0,0 +1,8 @@
+00-INDEX
+	- this file.
+concepts.txt
+	- A brief introduction of concepts
+rename.txt
+	- Information regarding rename operations
+usage.txt
+	- Usage & known limitations
diff --git a/Documentation/filesystems/unionfs/concepts.txt b/Documentation/filesystems/unionfs/concepts.txt
new file mode 100644
index 0000000..0b9bcc9
--- /dev/null
+++ b/Documentation/filesystems/unionfs/concepts.txt
@@ -0,0 +1,68 @@
+This file describes the concepts needed by a namespace unification file system.
+
+Branch Priority:
+================
+
+Each branch is assigned a unique priority - starting from 0 (highest priority).
+No two branches can have the same priority.
+
+
+Branch Mode:
+============
+
+Each branch is assigned a mode - read-write or read-only. This allows
+directories on media mounted read-write to be used in a read-only manner.
+
+
+Whiteouts:
+==========
+
+A whiteout removes a file name from the namespace. Whiteouts are needed when
+one attempts to remove a file on a read-only branch.
+
+Suppose we have a two-branch union, where branch 0 is read-write and branch 1
+is read-only. And a file 'foo' on branch 1:
+
+./b0/
+./b1/
+./b1/foo
+
+The unified view would simply be:
+
+./union/
+./union/foo
+
+Since 'foo' is stored on a read-only branch, it cannot be removed. A whiteout
+is used to remove the name 'foo' from the unified namespace. Again, since
+branch 1 is read-only, the whiteout cannot be created there. So, we try on a
+higher priority (lower numerically) branch. And there we create the whiteout.
+
+./b0/
+./b0/.wh.foo
+./b1/
+./b1/foo
+
+Later, when Unionfs traverses branches (due to lookup or readdir), it eliminate
+'foo' from the namespace (as well as the whiteout itself.)
+
+
+Duplicate Elimination:
+======================
+
+It is possible for files on different branches to have the same name. Unionfs
+then has to select which instance of the file to show to the user. Given the
+fact that each branch has a priority associated with it, the simplest
+solution is to take the instance from the highest priority (lowest numerical
+value) and "hide" the others.
+
+
+Copyup:
+=======
+
+When a change is made to the contents of a file's data or meta-data, they
+have to be stored somewhere. The best way is to create a copy of the
+original file on a branch that is writable, and then redirect the write
+though to this copy. The copy must be made on a higher priority branch so
+that lookup & readdir return this newer "version" of the file rather than
+the original (see duplicate elimination).
+
diff --git a/Documentation/filesystems/unionfs/rename.txt b/Documentation/filesystems/unionfs/rename.txt
new file mode 100644
index 0000000..e20bb82
--- /dev/null
+++ b/Documentation/filesystems/unionfs/rename.txt
@@ -0,0 +1,31 @@
+Rename is a complex beast. The following table shows which rename(2) operations
+should succeed and which should fail.
+
+o: success
+E: error (either unionfs or vfs)
+X: EXDEV
+
+none = file does not exist
+file = file is a file
+dir  = file is a empty directory
+child= file is a non-empty directory
+wh   = file is a directory containing only whiteouts; this makes it logically
+		empty
+
+                      none    file    dir     child   wh
+file                  o       o       E       E       E
+dir                   o       E       o       E       o
+child                 X       E       X       E       X
+wh                    o       E       o       E       o
+
+
+Renaming directories:
+=====================
+
+Whenever a empty (either physically or logically) directory is being renamed,
+the following sequence of events should take place:
+
+1) Remove whiteouts from both source and destination directory
+2) Rename source to destination
+3) Make destination opaque to prevent anything under it from showing up
+
diff --git a/Documentation/filesystems/unionfs/usage.txt b/Documentation/filesystems/unionfs/usage.txt
new file mode 100644
index 0000000..8db9158
--- /dev/null
+++ b/Documentation/filesystems/unionfs/usage.txt
@@ -0,0 +1,41 @@
+Unionfs is a stackable unification file system, which can appear to merge the
+contents of several directories (branches), while keeping their physical
+content separate. Unionfs is useful for unified source tree management, merged
+contents of split CD-ROM, merged separate software package directories, data
+grids, and more. Unionfs allows any mix of read-only and read-write branches,
+as well as insertion and deletion of branches anywhere in the fan-out. To
+maintain unix semantics, Unionfs handles elimination of duplicates,
+partial-error conditions, and more.
+
+mount -t unionfs -o branch-option[,union-options[,...]] none MOUNTPOINT
+
+The available branch-option for the mount command is:
+
+dirs=branch[=ro|=rw][:...]
+specifies a separated list of which directories compose the union.  Directories
+that come earlier in the list have a higher precedence than those which come
+later. Additionally, read-only or read-write permissions of the branch can be
+specified by appending =ro or =rw (default) to each directory.
+
+Syntax:
+dirs=/branch1[=ro|=rw]:/branch2[=ro|=rw]:...:/branchN[=ro|=rw]
+
+Example:
+dirs=/writable_branch=rw:/read-only_branch=ro
+
+
+KNOWN ISSUES:
+=============
+
+The NFS server returns -EACCES for read-only exports, instead of -EROFS.  This
+means we can't reliably detect a read-only NFS export.
+
+Modifying a Unionfs branch directly, while the union is mounted is currently
+unsupported.  Any such change can cause Unionfs to oops, however it could even
+RESULT IN DATA LOSS.
+
+Unionfs shouldn't use lookup_one_len on the underlying fs as it confuses
+NFS. Currently, unionfs_lookup passes lookup intents to the lower
+filesystem, this eliminates part of the problem. The remaining calls to
+lookup_one_len may need to be changed to pass an intent.
+
-- 
1.4.3.3

