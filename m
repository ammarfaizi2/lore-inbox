Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVERWeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVERWeC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVERWeC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:34:02 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:15336 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S262283AbVERWdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:33:20 -0400
Date: Wed, 18 May 2005 15:33:03 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com
Cc: torvalds@osdl.org, akpm@osdl.org, wim.coekaerts@oracle.com, lmb@suse.de
Subject: [RFC] [PATCH] OCFS2
Message-ID: <20050518223303.GE1340@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is OCFS2, a shared disk cluster file system which we hope will be
included in the kernel.

We think OCFS2 has many qualities which make it particularly
interesting as a cluster file system:

-We've tried very hard to avoid the abstraction layers which tend to
 plague other cluster file systems. Wherever possible, OCFS2 sits directly
 atop the VFS. Journaling is done via JBD, including node recovery.

-Though OCFS2 is an extent based file system, much of the disk layout
 design has been taken from Ext3. As mentioned before, journal formats
 are JBD. Though OCFS2 does not yet support htree, directory data
 looks nearly identical to that of Ext3, with the exception that OCFS2
 inode numbers are 64 bits wide. Data and meta data are allocated from
 dynamically growable "chain allocators" whose chain items look very
 similar to block groups.

-OCFS2 has a strong data locking model, which includes a shared mmap
 implementation (shared writeable mappings are not yet supported) and
 full AIO support.

-OCFS2 has a very low overhead direct I/O path.

Within the file system, the cluster stack below us has been abstracted
out as much as possible:

-Heartbeat events are delivered to us via a simple callback mechanism.

-File system network communication has only minimal knowledge of node
 information.

-File system cluster locking, including lock caching, is handled
 through a "dlm glue" layer which abstracts away the actual dlm
 implementation beneath (though it assumes a VMS-like API with a
 minimal set of features).

Included in OCFS2 is a small cluster stack. It should be noted that we
do *not* propose this as a generic cluster stack. While we hope the
cluster stack can be useful to other projects it was certainly
implemented with only the requirements of a cluster file system in
mind. Looking towards the future, we would like to either extend this
stack to be more generic or plug in a more generic stack - assuming it
gives us similar ease of use and performance and has undergone the
appropriate community discussion. For now the cluster stack and dlm
components have been placed in their respective directories within the
"ocfs2" subdirectory.

A major goal in the design of OCFS2 was to make configuration of the
entire stack as painless as possible. There is only one configuration
file required which describes all nodes in an OCFS2 cluster
(/etc/ocfs2/cluster.conf). The cluster.conf file is the same for all
nodes so that it can be easily re-copied when changed.

Anyone wanting to use OCFS2 should download the tool chain from
http://oss.oracle.com/projects/ocfs2-tools/source.html The current
OCFS2-tools package includes a full set of standard file system
utilities (mkfs.ocfs2, fsck.ocfs2, mount.ocfs2, tunefs.ocfs2,
debugfs.ocfs). Pulling down the latest subversion tree is usually
best. Setup is quite simple, after software installation, either hand
create a configuration or use the "ocfs2console" program to generate
one for you.

Currently the code should be considered beta quality. The OCFS2 team
is deep in a cycle of bug fixing and performance evaluation. As a
proof of concept, we've been able to bring up a 12 node shared root
cluster.  Already, performance on the file system looks promising. A
parallel kernel build (make -j4 bzImage on each node within their own
trees) compares well with ext3:

        Ext3           OCFS2
node1   13m4s          13m16s
node2   10m27s         10m38s

In case there is any concern about code size, a quick comparison shows
the file system and cluster stacks combined size to be not
significantly larger than reiserfs and 1/3 the size of xfs.

For people using git, these changes can be pulled from:
http://oss.oracle.com/git/ocfs2.git/

A full patch can be downloaded from:
http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/complete/ocfs2-configfs-all.patch

Broken out versions of the patches can be found at:
http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-out/

A short description of each patch follows. The same descriptions can be
found at the top of each patch file.

http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-out/01_configfs.patch
Configfs, a file system for userspace-driven kernel object configuration.
The OCFS2 stack makes extensive use of this for propagation of cluster
configuration information into kernel.

http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-out/02_mlog.patch
Very simple printk wrapper which adds the ability to enable various
sets of debug messages at run-time.

http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-out/03_nm.patch
A simple node information service, filled and updated from
userspace. The rest of the stack queries this service for simple node
information.

http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-out/04_heartbeat.patch
Disk based heartbeat. Configured and started from userspace, the
kernel component handles I/O submission and event generation via
callback mechanism.

http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-out/05_messaging.patch
Node messaging via tcp. Used by the dlm and the file system for point
to point communication between nodes.

http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-out/06_dlm.patch
A distributed lock manager built with the cluster file system use case
in mind. The OCFS2 dlm exposes a VMS style API, though things have
been simplified internally. The only lock levels implemented currently
are NLMODE, PRMODE and EXMODE.

http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-out/07_dlmfs.patch
dlmfs: A minimal dlm userspace interface implemented via a virtual
file system.
Most of the OCFS2 tools make use of this to take cluster locks when
doing operations on the file system.

http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-out/08_ocfs2.patch
The OCFS2 file system module.

http://oss.oracle.com/projects/ocfs2/dist/files/patches/2.6.12-rc4/broken-out/09_build.patch
Link the code into the kernel build system. OCFS2 is marked as
experimental and we only enable builds on x86, x86-64 and ia64 -
endianness consistency is a work in progress.

When built, the stack will result in 5 modules: configfs.ko,
ocfs2_nodemanager.ko, ocfs2_dlm.ko, ocfs2.ko and ocfs2_dlmfs.ko


--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

