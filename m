Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbVIANu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbVIANu6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVIANuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:50:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19141 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965118AbVIANug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:50:36 -0400
Date: Thu, 1 Sep 2005 21:56:23 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] GFS: build and documentation
Message-ID: <20050901135623.GM25581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add gfs to the build system and gfs2.txt to Documentation.

Signed-off-by: Ken Preslan <ken@preslan.org>
Signed-off-by: David Teigland <teigland@redhat.com>

---

 Documentation/filesystems/gfs2.txt |  194 +++++++++++++++++++++++++++++++++++++
 fs/Kconfig                         |   15 ++
 fs/Makefile                        |    1 
 fs/gfs2/Makefile                   |   45 ++++++++
 4 files changed, 255 insertions(+)

--- a/fs/gfs2/Makefile	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/Makefile	2005-09-01 17:36:55.572076408 +0800
@@ -0,0 +1,45 @@
+obj-$(CONFIG_GFS2_FS) += gfs2.o
+gfs2-y := \
+	acl.o \
+	bits.o \
+	bmap.o \
+	daemon.o \
+	dir.o \
+	eaops.o \
+	eattr.o \
+	glock.o \
+	glops.o \
+	inode.o \
+	ioctl.o \
+	jdata.o \
+	lm.o \
+	log.o \
+	lops.o \
+	lvb.o \
+	main.o \
+	meta_io.o \
+	mount.o \
+	ondisk.o \
+	ops_address.o \
+	ops_dentry.o \
+	ops_export.o \
+	ops_file.o \
+	ops_fstype.o \
+	ops_inode.o \
+	ops_super.o \
+	ops_vm.o \
+	page.o \
+	quota.o \
+	resize.o \
+	recovery.o \
+	rgrp.o \
+	super.o \
+	sys.o \
+	trans.o \
+	unlinked.o \
+	util.o
+
+obj-$(CONFIG_GFS2_FS) += locking/harness/
+obj-$(CONFIG_GFS2_FS) += locking/nolock/
+obj-$(CONFIG_GFS2_FS) += locking/dlm/
+
--- a/fs/Makefile	2005-09-01 16:59:28.042752800 +0800
+++ b/fs/Makefile	2005-09-01 17:10:11.211976216 +0800
@@ -105,3 +105,4 @@
 obj-$(CONFIG_OCFS2_FS)		+= ocfs2/
 obj-$(CONFIG_RELAYFS_FS)	+= relayfs/
 obj-$(CONFIG_9P_FS)		+= 9p/
+obj-$(CONFIG_GFS2_FS)		+= gfs2/
--- a/fs/Kconfig	2005-09-01 16:59:28.038753408 +0800
+++ b/fs/Kconfig	2005-09-01 17:09:39.810749928 +0800
@@ -360,6 +360,21 @@
 	          - POSIX ACLs
 	          - readpages / writepages (not user visible)
 
+config GFS2_FS
+	tristate "GFS2 file system support"
+	depends on DLM
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
 config MINIX_FS
 	tristate "Minix fs support"
 	help
--- a/Documentation/filesystems/gfs2.txt	1970-01-01 07:30:00.000000000 +0730
+++ b/Documentation/filesystems/gfs2.txt	2005-09-01 17:36:55.593073216 +0800
@@ -0,0 +1,194 @@
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
+GFS uses interchangable inter-node locking mechanisms.  GFS plugs into one
+side of a module called "lock_harness" and different lock modules can plug
+into the other side of the harness.  Each gfs file system selects the
+appropriate lock module at mount time.  Lock modules include:
+
+  lock_nolock -- does no real locking and allows gfs to be used as a
+  local file system
+
+  lock_dlm -- uses a distributed lock manager (dlm) for inter-node locking
+  The dlm is found at linux/drivers/dlm/
+
+In addition to interfacing with an external locking manager, a gfs lock
+module is responsible for interacting with external cluster management
+systems.  Lock_dlm depends on user space cluster management systems found
+at the location above.
+
+To use gfs as a local file system, no external clustering systems are
+needed, simply:
+
+  $ gfs2_mkfs -p lock_nolock -j 1 /dev/block_device
+  $ mount -t gfs2 /dev/block_device /dir
+
+GFS2 is not on-disk compatible with previous versions of GFS.
+
+
+The following man pages can be found at the location above:
+  gfs2_mkfs	to make a filesystem
+  gfs2_fsck	to repair a filesystem
+  gfs2_grow	to expand a filesystem online
+  gfs2_jadd	to add journals to a filesystem online
+  gfs2_tool	to manipulate, examine and tune a filesystem
+  gfs2_quota	to examine and change quota values in a filesystem
+  gfs2_mount	to find mount options
+
+Mount options (from the gfs2_mount man page)
+
+       lockproto=LockModuleName
+              This  specifies  which  inter-node lock protocol is used by the
+              GFS2 filesystem for this mount,  overriding  the  default  lock
+              protocol name stored in the filesystem's on-disk superblock.
+
+              The  LockModuleName must be an exact match of the protocol name
+              presented by the lock module when it registers  with  the  lock
+              harness.   Traditionally,  this  matches the .o filename of the
+              lock module, e.g. lock_dlm, lock_gulm, or lock_nolock.
+
+              The default lock protocol name is  written  to  disk  initially
+              when  creating the filesystem with gfs2_mkfs(8), -p option.  It
+              can be changed on-disk by using the gfs2_tool(8)  utility's  sb
+              proto command.
+
+              The  lockproto  mount  option should be used only under special
+              circumstances in which you want to temporarily use a  different
+              lock protocol without changing the on-disk default.
+
+       locktable=LockTableName
+              This  specifies the identity of the cluster and of the filesys-
+              tem for this mount, overriding the  default  cluster/filesystem
+              identify  stored  in  the filesystem's on-disk superblock.  The
+              cluster/filesystem name is recognized globally  throughout  the
+              cluster,  and establishes a unique namespace for the inter-node
+              locking system, enabling the mounting of multiple GFS2 filesys-
+              tems.
+
+              The  format  of  LockTableName  is  lock-module-specific.   For
+              lock_gulm and lock_dlm, the format is clustername:fsname.   For
+              lock_nolock, the field is ignored.
+
+              The  default  cluster/filesystem  name  is written to disk ini-
+              tially when  creating  the  filesystem  with  gfs2_mkfs(8),  -t
+              option.   It  can  be changed on-disk by using the gfs2_tool(8)
+              utility's sb table command.
+
+              The locktable mount option should be used  only  under  special
+              circumstances  in  which  you want to mount the filesystem in a
+              different cluster, or mount it as a different filesystem  name,
+              without changing the on-disk default.
+
+       hostdata=HostIDInfo
+              This  field sends host (the computer on which the filesystem is
+              being mounted) identity information to the lock module.
+
+              The format and behavior of HostIDInfo is  lock-module-specific.
+              For  lock_gulm,  it overrides the uname(1) -n network node name
+              used as default by lock_gulm.  For lock_nolock, a HostIDInfo of
+              "jid=x" tells GFS to mount journal number x.
+
+              This field is ignored by lock_dlm.
+
+       localcaching
+              This  flag  tells GFS2 that it is running as a local (not clus-
+              tered) filesystem, so it can turn on some block  caching  opti-
+              mizations that can't be used when running in cluster mode.
+
+              This  is turned on automatically by the lock_nolock module, but
+              can be overridden by using the ignore_local_fs option.
+
+       localflocks
+              This flag tells GFS2 that it is running as a local  (not  clus-
+              tered)  filesystem,  so it can allow the kernel VFS layer to do
+              all flock and fcntl file  locking.   When  running  in  cluster
+              mode,  these  file  locks require inter-node locks, and require
+              the support of GFS2.  When running locally, better  performance
+              is achieved by letting VFS handle the whole job.
+
+              This  is turned on automatically by the lock_nolock module, but
+              can be overridden by using the ignore_local_fs option.
+
+       oopses_ok
+              When GFS2 detects certain errors (mostly some  type  of  memory
+              corruption) it will panic the machine rather than risk corrupt-
+              ing the ondisk state.  Using this option  will  cause  GFS2  to
+              oops  instead of panic.  This may produce more useful debugging
+              information than a panic will.  The downside of this option  is
+              that  an  oops on one machine of a cluster filesystem may cause
+              the filesystem to stall on all machines in the cluster.   (Pan-
+              ics don't have this "feature".)  Use this option with care.
+
+              This  is turned on automatically by the lock_nolock module, but
+              can be overridden by using the ignore_local_fs option.
+
+       debug  Causes GFS2 to oops when encountering an error that would cause
+              the  mount  to  withdraw  or  print an assertion warning.  This
+              option should probably not be used in a production system.
+
+       ignore_local_fs
+              By default, using the nolock lock module automatically turns on
+              the     localcaching     and     localflocks     optimizations.
+              ignore_local_fs forces GFS2 to treat the filesystem  as  if  it
+              were  a multihost (clustered) filesystem, with localcaching and
+              localflocks optimizations turned off.
+
+       upgrade
+              This flag tells GFS2 to upgrade the filesystem's on-disk format
+              to the version supported by the current GFS2 software installa-
+              tion on this computer.  If you try to mount an old-version disk
+              image,  GFS2 will notify you via a syslog message that you need
+              to upgrade.  Try mounting again, using the -o  upgrade  option.
+              When upgrading, only one node may mount the GFS2 filesystem.
+
+       num_glockd=Number
+              Tunes  GFS2  to alleviate memory pressure when rapidly aquiring
+              many locks  (e.g.   several  processes  scanning  through  huge
+              directory  trees).  GFS2' glockd kernel daemon cleans up memory
+              for no-longer-needed glocks.  Multiple instances of the  daemon
+              clean  up  faster than a single instance.  The default value is
+              one daemon, with a maximum of 16.  Since this option was intro-
+              duced,  other  methods  of  rapid  cleanup  have been developed
+              within GFS2, so this option may go away in the future.
+
+       acl    Enables POSIX Access Control List acl(5) support within GFS2.
+
+       spectator
+              Mount this filesystem using a special form of read-only  mount.
+              The mount does not use one of the filesystem's journals.
+
+       suiddir
+              Sets owner of any newly created file or directory to be that of
+              parent directory, if parent directory  has  S_ISUID  permission
+              attribute  bit  set.  Sets S_ISUID in any new directory, if its
+              parent directory's S_ISUID is set.  Strips all  execution  bits
+              on  a  new  file,  if  parent directory owner is different from
+              owner of process creating the file.  Set this  option  only  if
+              you know why you are setting it.
+
+       quota=[off/account/on]
+              Turns quotas on or off for a filesystem.  Setting the quotas to
+              be in the "account" state causes the per UID/GID usage  statis-
+              tics  to  be  correctly maintained by the filesystem, limit and
+              warn values are ignored.  The default value is "off".
+
+       data=[ordered/writeback]
+              When data=ordered is set, the user data modified by a  transac-
+              tion  is flushed to the disk before the transaction is commited
+              to disk.  This should prevent the user from  seeing  uninitial-
+              ized  blocks  in  a  file  after  a crash.  Data=writeback mode
+              writes the user data to the disk at any time after  it's  dirt-
+              ied.   This  doesn't  provide the same consistency guarantee as
+              ordered mode, but it should be slightly faster for  some  work-
+              loads.  The default is ordered mode.
+
