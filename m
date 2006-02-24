Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWBXOob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWBXOob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWBXOob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:44:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14821 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932188AbWBXOoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:44:30 -0500
Subject: GFS2 Filesystem [0/16]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Feb 2006 14:48:31 +0000
Message-Id: <1140792511.6400.707.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following 16 patches make up the GFS2 filesystem as contained in the
git tree at:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=summary

Please consider GFS2 for inclusion in your -mm series of kernel patches.
The DLM is not included in this patch series since that is already in
-mm. The patches are relative to Linus' latest kernel (well as of
yesterday when I last updated the git tree).

There are some slight changes between the DLM in the git tree and that
in -mm being, that at Ingo Molnar's suggestion, it has been moved to be
in the fs/dlm directory in the git tree. Also the (unused) range locking
feature has been removed in the git tree version. Otherwise the two are
identical.

Below are some release notes which explain a bit more about GFS2 along
with pointers to documentation etc. I believe that we've taken into
account all the points which were raised in the comments from our last
posting to linux-kernel but see below for the detailed list,

Steve.

-------------------------------------------------------------------------------------------------
Release notes / State of the Union for GFS2

1. Relationship with GFS1
2. New features
3. Known issues (to be fixed before submission to Linus)
4. Some items from our TODO list
5. Where to find things....

1. Relationship with GFS1

A review of the metadata in GFS2 now means that most of the metadata
is now compatible between GFS1 and GFS2, making the writing of an
upgrade tool a relatively trivial operation. The differences between
the ondisk metadata between GFS1 and GFS2 are:

 a) The superblock has different magic numbers to indicate the new
    filesystem format.
 b) The indirect pointer blocks have pointers starting at a different
    offset to GFS1.
 c) The addition of the .gfs2_admin directory means that some new
    inodes would need to be added in order to upgrade a filesystem.
    The journals are now represented on disk as normal inodes as opposed
    to the extent based system of GFS1.
 d) The ondisk format for data has been changed _only_ in the case where
    that data is journaled. The new format for journaled data is in fact
    identical to the format for non-journaled data (i.e. the metadata
    header which used to be at the start of every journaled block is now
    no longer used for data blocks). Note that this change has resulted
    in a number of advantages outlined below (see 2(a)).
 e) In some cases, fields used in GFS1 are no longer used. These are
    left as padding fields in order to ease the upgrade procedure.


2. New features (since last posting to the kernel list)

 a) Journaled data files can now be:
    i) mmap()ed
   ii) exported via NFS
  iii) converted to/from normal files at any time
       (N.B. GFS1 had a restriction that conversion could only happen
       when files were zero sized)

 b) The .gfs2_admin directory exposes the internal files that GFS uses
    to store various bits of file system related information. This means
    that we've been able to remove virtually all the ioctl() calls from
    GFS2. There is one ioctl() call left which relates to
    getting/setting GFS2 specific flags on files. The various GFS2 tools
    will be updated in due course to use this new interface.

 c) Sparse annotation for the ondisk structures. (See also 3(e))

 d) vm_walk() and friends removed. All I/O is via the page cache now
    (aside from direct I/O of course).

 e) Recovery should be slightly faster since we now no longer need to
    read disk blocks from the journal which appear in the revoke list
    at recovery time.

 f) Many minor bug fixes and cleanups

 g) The code has also got smaller since the last posting to linux-kernel
    by approx 40k

3. Known issues (to be fixed before submission to Linus)

 a) Deadlock between page locks and GFS2's glocks.
    We intend fixing this in the same way that the OCFS2 file system
    does, i.e. adding the AOP_TRUNCATED_PAGE return code into the
    glock code at a suitable point.

 b) Protection of GFS2 system files under .gfs2_admin. Currently, due
    to the way in which GFS2's locking works its possible to hang a
    process by accessing a system file that's in use under some
    circumstances. This is mainly a problem with the journal files. We
    intend to add some special casing to prevent this from happening.

 c) selinux support will be integrated

 d) Various userland tools to be updated, currently mkfs is the only
    working userland program for GFS2.

 e) Remove the remainder of the endian conversion functions which are
    in ondisk.c (quite a few have gone already) in favour of changing
    the fields directly. This will remove a lot of sparse annotation
    warnings.

4. Some items from our TODO list (probably post-integration, but things
   we would like to do)

 a) Support for denying of write access to currently executing binaries.
    (Currently only works correctly on single node file systems, see the
    thread "Re: FMODE_EXEC or alike?" on linux-kernel/linux-fsdevel)

 b) Moving list of resource groups into a tree or similar structure
    sorted by disk location. This should then allow removal of the
    various sorts done in the deallocation code (since the resource
    groups will be pre-sorted) and also remove the requirement for
    the associated memory allocations.

5. Where to find things....

GFS2 and DLM kernel code is in a GIT tree at kernel.org:

http://www.kernel.org/git/?p=linux/kernel/git/steve/gfs2-2.6.git;a=summary

The mkfs program is currently in the CVS head, details can be found at:

http://sources.redhat.com/cluster/

Also I'll put a tar ball version of mkfs in my directory on kernel.org.
mkfs is not currently hooked into the build system in CVS. Just a simple
make, make install (after editing the Makefile to point it at your
kernel source) should do the trick. This is all you should need to test
GFS in single node mode.

To use GFS2 in clustered mode, see the more detailed instructions on
the cluster page (url above).




