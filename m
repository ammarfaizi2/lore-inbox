Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWCBVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWCBVeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 16:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932566AbWCBVeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 16:34:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44749 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932305AbWCBVeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 16:34:12 -0500
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/5] Permit NFS superblock sharing [try #3]
Date: Thu, 02 Mar 2006 21:33:56 +0000
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no, aviro@redhat.com
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These patches make it possible to share NFS superblocks between related mounts,
where "related" means on the same server. Inodes and dentries will be shared
where the NFS filehandles are the same (for example if two NFS3 files come from
the same export but from different mounts, such as is not uncommon with autofs
on /home).

Following discussion with Al Viro, the following changes [try #2] have been
made to the previous attempt at this set of patches:

 (*) The vfsmount is now passed into the get_sb() method for a filesystem
     instead of passing a pointer to a pointer to a dentry into which get_sb()
     could stick a root dentry if it wanted. get_sb() now instantiates the
     superblock and root dentry pointers in the vfsmount itself.

 (*) The get_sb() method now returns an integer (0 or -ve error number) rather
     than the superblock pointer or cast error number.

 (*) the get_sb_*() convenience functions in the core kernel now take a
     vfsmount pointer argument and return an integer, so most filesystems have
     to change very little.

 (*) If one of the convenience function is not used, then get_sb() should
     normally call simple_set_mnt() to instantiate the vfsmount. This will
     always return 0, and so can be tail-called from get_sb().

 (*) generic_shutdown_super() now calls shrink_dcache_sb() to clean up the
     dcache upon superblock destruction rather than shrink_dcache_parent() and
     shrink_dcache_anon(). This is because, as far as I can tell, the current
     code assumes that all the dentries will be linked into a tree depending
     from sb->s_root, and that anonymous dentries won't have children.

     However, with the way these patches implement NFS superblock sharing,
     these assumptions are violated: the root of the filesystem is simply a
     dummy dentry and inode (the real inode for '/' may well be inaccessible),
     and all the vfsmounts are rooted on anonymous[*] dentries with child
     trees.

     [*] Anonymous until discovered from another tree.

 (*) d_materialise_dentry() now switches the parentage of the two nodes around
     correctly when one or other of them is self-referential.

 (*) Whilst invoking link_path_walk(), the nfs4_get_root() routine now
     temporarily overrides the FS settings of the process to prevent absolute
     symbolic links from walking into the wrong namespace.

 (*) nfs*_get_sb() instantiate the supplied vfsmount directly by assigning to
     its mnt_root and mnt_sb members.

 (*) nfs_readdir_lookup() creates dentries for each of the entries readdir()
     returns; this function now attaches disconnected trees from alternate
     roots that happen to be discovered attached to a directory being read (in
     the same way nfs_lookup() is made to do for lookup ops).

 (*) Various bugs have been fixed.

Further changes [try #3] that have been made:

 (*) The patches are now against Trond's NFS git tree, so won't apply to
     Linus's tree.

 (*) The server record construction/destruction has been abstracted out into
     its own pair of functions to make things easier to get right.

 (*) Documentation changes have been moved from patch 2/5 to 1/5.

David
