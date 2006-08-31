Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWHaNg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWHaNg6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWHaNg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:36:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43403 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932302AbWHaNg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:36:57 -0400
Subject: [PATCH 13/16] GFS2: Makefiles and Kconfig
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 31 Aug 2006 14:40:55 +0100
Message-Id: <1157031655.3384.810.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 13/16] GFS2: Makefiles and Kconfig

This hooks GFS2 into the kernel's build system. It also adds some
documentation. Note that the dlm has been moved to be under
fs/dlm as per Ingo Molnar's suggestion. This patch series doesn't
include the dlm however. The DLM is already in both -mm and the git
tree containing GFS2 at kernel.org.


Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>


 Documentation/filesystems/gfs2.txt |   43 ++++++++++++++++++++++++++++++++++++
 fs/Kconfig                         |    2 +
 fs/Makefile                        |    2 +
 fs/gfs2/Kconfig                    |   44 +++++++++++++++++++++++++++++++++++++
 fs/gfs2/Makefile                   |   10 ++++++++
 5 files changed, 101 insertions(+)

--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -323,6 +323,7 @@ #
 	default n
 
 source "fs/xfs/Kconfig"
+source "fs/gfs2/Kconfig"
 
 config OCFS2_FS
 	tristate "OCFS2 file system support (EXPERIMENTAL)"
@@ -1930,6 +1931,7 @@ source "fs/partitions/Kconfig"
 endmenu
 
 source "fs/nls/Kconfig"
+source "fs/dlm/Kconfig"
 
 endmenu
 
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_CONFIGFS_FS)	+= configfs/
 obj-y				+= devpts/
 
 obj-$(CONFIG_PROFILING)		+= dcookies.o
+obj-$(CONFIG_DLM)		+= dlm/
  
 # Do not add any filesystems before this line
 obj-$(CONFIG_REISERFS_FS)	+= reiserfs/
@@ -102,3 +103,4 @@ obj-$(CONFIG_HOSTFS)		+= hostfs/
 obj-$(CONFIG_HPPFS)		+= hppfs/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
+obj-$(CONFIG_GFS2_FS)           += gfs2/
--- /dev/null
+++ b/fs/gfs2/Makefile
@@ -0,0 +1,10 @@
+obj-$(CONFIG_GFS2_FS) += gfs2.o
+gfs2-y := acl.o bmap.o daemon.o dir.o eaops.o eattr.o glock.o \
+	glops.o inode.o lm.o log.o lops.o locking.o lvb.o main.o meta_io.o \
+	mount.o ondisk.o ops_address.o ops_dentry.o ops_export.o ops_file.o \
+	ops_fstype.o ops_inode.o ops_super.o ops_vm.o quota.o \
+	recovery.o rgrp.o super.o sys.o trans.o util.o
+
+obj-$(CONFIG_GFS2_FS_LOCKING_NOLOCK) += locking/nolock/
+obj-$(CONFIG_GFS2_FS_LOCKING_DLM) += locking/dlm/
+
--- /dev/null
+++ b/fs/gfs2/Kconfig
@@ -0,0 +1,44 @@
+config GFS2_FS
+	tristate "GFS2 file system support"
+	depends on EXPERIMENTAL
+	select FS_POSIX_ACL
+	help
+	A cluster filesystem.
+
+	Allows a cluster of computers to simultaneously use a block device
+	that is shared between them (with FC, iSCSI, NBD, etc...).  GFS reads
+	and writes to the block device like a local filesystem, but also uses
+	a lock module to allow the computers coordinate their I/O so
+	filesystem consistency is maintained.  One of the nifty features of
+	GFS is perfect consistency -- changes made to the filesystem on one
+	machine show up immediately on all other machines in the cluster.
+
+	To use the GFS2 filesystem, you will need to enable one or more of
+	the below locking modules. Documentation and utilities for GFS2 can
+	be found here: http://sources.redhat.com/cluster
+
+config GFS2_FS_LOCKING_NOLOCK
+	tristate "GFS2 \"nolock\" locking module"
+	depends on GFS2_FS
+	help
+	Single node locking module for GFS2.
+
+	Use this module if you want to use GFS2 on a single node without
+	its clustering features. You can still take advantage of the
+	large file support, and upgrade to running a full cluster later on
+	if required.
+
+	If you will only be using GFS2 in cluster mode, you do not need this
+	module.
+
+config GFS2_FS_LOCKING_DLM
+	tristate "GFS2 DLM locking module"
+	depends on GFS2_FS
+	select DLM
+	help
+	Multiple node locking module for GFS2
+
+	Most users of GFS2 will require this module. It provides the locking
+	interface between GFS2 and the DLM, which is required to use GFS2
+	in a cluster environment.
+
--- /dev/null
+++ b/Documentation/filesystems/gfs2.txt
@@ -0,0 +1,43 @@
+Global File System
+------------------
+
+http://sources.redhat.com/cluster/
+
+GFS is a cluster file system. It allows a cluster of computers to
+simultaneously use a block device that is shared between them (with FC,
+iSCSI, NBD, etc).  GFS reads and writes to the block device like a local
+file system, but also uses a lock module to allow the computers coordinate
+their I/O so file system consistency is maintained.  One of the nifty
+features of GFS is perfect consistency -- changes made to the file system
+on one machine show up immediately on all other machines in the cluster.
+
+GFS uses interchangable inter-node locking mechanisms.  Different lock
+modules can plug into GFS and each file system selects the appropriate
+lock module at mount time.  Lock modules include:
+
+  lock_nolock -- allows gfs to be used as a local file system
+
+  lock_dlm -- uses a distributed lock manager (dlm) for inter-node locking
+  The dlm is found at linux/fs/dlm/
+
+In addition to interfacing with an external locking manager, a gfs lock
+module is responsible for interacting with external cluster management
+systems.  Lock_dlm depends on user space cluster management systems found
+at the URL above.
+
+To use gfs as a local file system, no external clustering systems are
+needed, simply:
+
+  $ mkfs -t gfs2 -p lock_nolock -j 1 /dev/block_device
+  $ mount -t gfs2 /dev/block_device /dir
+
+GFS2 is not on-disk compatible with previous versions of GFS.
+
+The following man pages can be found at the URL above:
+  gfs2_fsck	to repair a filesystem
+  gfs2_grow	to expand a filesystem online
+  gfs2_jadd	to add journals to a filesystem online
+  gfs2_tool	to manipulate, examine and tune a filesystem
+  gfs2_quota	to examine and change quota values in a filesystem
+  mount.gfs2	to help mount(8) mount a filesystem
+  mkfs.gfs2	to make a filesystem


