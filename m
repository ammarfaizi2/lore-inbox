Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161240AbVIPS2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161240AbVIPS2L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161247AbVIPS2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:28:10 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41666 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161244AbVIPS1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:27:50 -0400
Date: Fri, 16 Sep 2005 11:26:19 -0700
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: linuxram@us.ibm.com, akpm@osdl.org, viro@ftp.linux.org.uk,
       miklos@szeredi.hu, mike@waychison.com, bfields@fieldses.org,
       serue@us.ibm.com
Subject: [RFC PATCH 0/10] vfs: shared subtree patches 
Message-ID: <20050916182619.GA28413@RAM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: linuxram@us.ibm.com (Ram)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Attached reworked patches for shared subtree feature.
 http://lwn.net/Articles/119232/ contains Al Viro's RFC explaining the
 semantics of this feature.

 These patches are against 2.6.13. The patches have incorporated comments
 received in the last round.  

 If the shared-subtree functionality is not used, the footprint of this code is  pretty small in the normal code path.

 I have put in extensive documentation in the file
 Documentation/sharedsubtree.txt .  That file explains the semantics in detail
 with couple of examples.


Overview
---------
 How can a cloned namespace access the CD that just got mounted by the
 automounter in the parent namespace?  Shared subtree semantics provide the
 necessary mechanism to accomplish the above.
 
 Bind mount and namespaces are static in nature. They create a snapshot of the
 current mounts. However any new mounts/unmounts within the original mount do
 not reflect under the new one. Shared subtree semantics makes bind mounts and
 namespaces dynamic in nature. The mount and unmount under any one replica
 reflects in the other.

 Shared subtree semantics also supports one-way-propagation. This is especially
 handy for a cloned-namespace requiring all mounts in the parent namespace
 propagated to itself, but still wants to keep its own mounts private.

 Shared subtree provides powerful building blocks for features like
 per-user-namespace and versioned filesystem.

 I have documented the detailed semantics and some implementation detail in the
 file Documentation/sharedsubtree.txt .

Who needs this?
--------------

    The following projects have indicated potential use for this feature.
    1. FUSE
    2. SeLinux
    3. MVFS
    4. autofs

Patches
-------
	I have broken down the implementation into 10 patches.

	1. white_space.patch : conforms namespace.c file to coding style

	2. shared_private_slave.patch : provides the ability to mark mounts as
	shared or private or slave

	3. unclone.patch : provides the ability to mark a mount unclonable.
	This feature is not mentioned in the RFC though the need for it was
	seen during the RFC review.

	4. namespace_sem_removal.patch : this patch is written by Miklos
	Szeredi. It gets rid of per namespace semaphore in favor of a global
	semaphore. Given that mounts can propagate to multiple namespaces under
	the new shared subtree semantics, the patch becomes relevant here.

	5. rbind.patch : provides the ability to bind/rbind mounts of type
	shared/private/slave to mountpoints residing in
	shared/private/slave/unclonable mounts.
		
	6. move.patch : provides the ability to move mount trees containing
	shared/private/slave/unclonable mounts to mountpoints residing in
	shared/private/slave/unclonable mounts. It handles the pivot_root
	functionality too.

	7. umount.patch : provides the ability to unmount mounts residing in
	shared/private/unclonable/slave mounts.
	
	8. namespace.patch : provides the ability to clone a namespace which
	contains shared/private/slave/unclonable mounts.

	9. automount.patch : provides the necessary auto-mounter helper
	functions which are aware of shared subtree semantics.

	10. documentation.patch: Contains all the documentation details of
	shared subtree semantics and some implementation details too.

		The diffstat of all the patches is:
Documentation/sharedsubtree.txt |  990 ++++++++++++++++++++++++++++++++++++++++ 
fs/Makefile                     |    2
fs/namespace.c                  |  854 +++++++++++++++++++++++++++-------
fs/pnode.c                      |  678 +++++++++++++++++++++++++++
include/linux/dcache.h          |    1
include/linux/fs.h              |   11
include/linux/mount.h           |   30 -
include/linux/namespace.h       |    1
include/linux/pnode.h           |   68 ++

Tests:
-----
	Avantika Mathur has developed about 90+ test cases that check various
	scenarios. All these tests have passed. No regression was found.  The
	code survived some stress test too.

Bugs:
-----
	There is one known umount bug that somebody will bump into and it has
	to do with the semantics of multiple mounts on the same dentry of a
	given mount. Its been documented in the sharedsubtree.txt file.  The
	effect of the bug is insignificant, but I will appreciate some
	community-thought into the issue.

Thanks and Acknowledgement:
---------------------------
	Miklos Szeredi for providing code snippets for traversing
	the propagation tree, and in fact many __valuable__ review comments.

	Mike Waychison, Bruce J Fields, Serge Hallyn, Pekka Enberg for their
	valuable review comments.

	Avantika Mathur for churning out many-many bugs.

Ram Pai
