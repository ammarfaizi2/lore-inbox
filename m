Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbWHRPf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbWHRPf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 11:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbWHRPf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 11:35:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9643 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030273AbWHRPf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 11:35:26 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/7] Permit filesystem local caching and NFS superblock sharing  [try #12]
Date: Fri, 18 Aug 2006 16:35:02 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060818153502.29482.91650.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



These patches add local caching for network filesystems such as NFS and AFS.

The patches can be grouped as:

 (A) 01-04

     Filesystem caching, including support for AFS.

 (B) 05

     Filesystem caching support for NFS; depends on (A) and upon the superblock
     sharing patches in Trond's tree.

 (C) 06-07

     CacheFiles: cache on files backend; depends on (A).

Note to Andrew Morton: I have not included the 64-bit inode number patches, the
dentry destruction patches or the NFS superblock sharing fix patches in this
patch set.

---
Changes in [try #12]:

 (*) [PATCH] FS-Cache: Release page->private after failed readahead
     [PATCH] FS-Cache: Make kAFS use FS-Cache
     [PATCH] NFS: Use local caching

     [*] Use invalidatepage() rather than releasepage() to forcibly invalidate
     	 a page that we failed to add to the pagecache.

     [*] Make AFS and NFS's releasepage() ops return false if the page is busy
     	 interacting with the cache rather than waiting for the cache
     	 interaction to complete.  invalidatepage() still waits.

 (*) [PATCH] FS-Cache: CacheFiles: A cache that backs onto a mounted filesystem

     [*] Fix a printk format warning.

 (*) [PATCH] NFS: Use local caching

     [*] Handle upstream changes to base version of nfs_release_page().

Changes in [try #11]:

 (*) Split up of the NFS superblock sharing patches into a set of smaller
     patches and reworked some of the contents as per Trond's suggestions.

 (*) [PATCH] NFS: Fix error handling

     [*] Fix error handling in earlier patches (the earlier patches are also in
     	 Trond's NFS tree, so I haven't rolled this in for the moment).

 (*) [PATCH] NFS: Secure the roots of the NFS subtrees in a shared superblock

     [*] Initialise the security on detached NFS roots manually since they're
     	 allocated with dcache_alloc_anon() not dcache_alloc_root().

 (*) [PATCH] FS-Cache: CacheFiles: A cache that backs onto a mounted filesystem

     [*] Don't use file structs when accessing the data storage backing files.
     	 Pass NULL as the file argument to prepare_write() and commit_write()
     	 calls.

     [*] Check for a bmap() inode op to prevent NFS being used as the cache
     	 backing store (and besides, we need bmap() available anyway).

     [*] Make the calls to the statfs() superblock op supply a dentry not a
     	 vfsmount.

     [*] CONFIG_CACHEFILES_DEBUG permits _enter(), _debug() and _exit() to be
     	 enabled dynamically.

     [*] debugging macros are checked by gcc for printf format compliance even
     	 when completely disabled.

 (*) [PATCH] FS-Cache: CacheFiles: ia64: missing copy_page export

     [*] Export copy_page() on IA-64 as we need that.

 (*) [PATCH] AUTOFS: Make sure all dentries refs are released before calling kill_anon_super()

     [*] Make sure autofs4 releases all its retained dentries in its kill_sb()
     	 op before calling kill_anon_super() rather than in the put_super() op.
     	 This prevents the next patch from oopsing it.

 (*) [PATCH] VFS: Destroy the dentries contributed by a superblock on unmounting

     [*] Optimise the destruction of the dentries attached to a superblock
     	 during unmounting.

Changes in [try #10]:

 (*) [PATCH] NFS: Permit filesystem to perform statfs with a known root dentry

     [*] Pass a dentry rather than a vfsmount to the statfs() op as the key by
     	 which to determine the filesystem.

 (*) [PATCH] NFS: Share NFS superblocks per-protocol per-server per-FSID

     [*] nfs4_pathname_string() needed an extra const.

 (*) [PATCH] FS-Cache: Release page->private in failed readahead

     [*] The comment header on the helper function is much expanded.  This
     	 states why there's a need to call the releasepage() op in the event of
     	 an error.

     [*] BUG() if the page is already locked when we try and lock it.

     [*] Don't set the page mapping pointer until we've locked the page.

     [*] The page is unlocked after try_to_release_page() is called.

 (*) The release-page patch now comes before the fscache-afs patch as well as
     the fscache-nfs patch.

Changes in [try #9]:

 (*) [PATCH] NFS: Permit filesystem to perform statfs with a known root dentry

     [*] Inclusions of linux/mount.h have been added where necessary to make
       	 allyesconfig build successfully.

 (*) [PATCH] NFS: Share NFS superblocks per-protocol per-server per-FSID

     [*] The exports from fs/namespace.c and fs/namei.c are no longer required.

 (*) [PATCH] FS-Cache: Release page->private in failed readahead

     [*] The try_to_release_page() is called instead of calling the
     	 releasepage() op directly.

     [*] The page is locked before try_to_release_page() is called.

     [*] The call to try_to_release_page() and page_cache_release() have been
     	 abstracted out into a helper function as this bit of code occurs
     	 twice..

---
In response to those who've asked, there are at least three reasons for
implementing superblock sharing:

 (1) As I understand what I've been told, NFSv4 requires a 1:1 mapping between
     server files and client files.  I suspect this has to do with the
     management of leases.

 (2) We can reduce the resource consumption on NFSv2 and NFSv3 clients as well
     as on NFSv4 clients by sharing superblocks that cover overlapping segments
     of the file space.

     Consider a machine that's used by a lot of people at the same time, each
     of whom has an automounted NFS homedir off of the same server - and in
     fact off of the same disk on the that server.  Currently, with Linus's
     tree, each one will get a separate superblock to represent them; with
     Trond's tree, each one will still get a separate superblock unless they
     share the same root filehandle; and with my patches, they'll get the same
     superblock.

     If two homedirs have a hard link between them (unlikely, I know, but by no
     means impossible, and probably more likely with, say, data such as NFS
     mounted git repositories), then you have the possibility of aliasing.
     This means that you can have two or more inodes in core that refer to the
     same server object, and each of these inodes can have pages that refer to
     the same remote pages on the server - aliasing again.  You _have_ to have
     two inodes because they're covered by separate superblocks.

     Aliasing is bad, generally, because you end up using more storage than
     you need to (pagecache and inode cache in this case), and you have the
     problem of keeping them in sync.  It's also twice as hard to keep two
     inodes up to date when they change on the server as to keep one up to
     date.

     If you can use the same superblock where possible, then you can cut out
     aliasing on that client since you can share dentries that have the same
     file handle (hard links or subtrees).

     Part of the problem with NFSv2 and NFSv3 is that you invoke mountd to get
     the filehandle to a subtree, but you may not be able to work out how two
     different subtrees relate.  The getsb patch permits the superblock to
     have more than one root, which allows us to defer this problem until we
     see the root of one subtree cropping up in another subtree - at which
     point we can splice the former into the latter.

 (3) In my local file caching patches (FS-Cache), I have two reasons for
     wanting this:

     (a) Unique keys.  I need a unique key to find an object in the cache.  If
     	 we can get inode aliases, then I end up with several inodes referring
     	 to the same cache object.  This also means that I have to use a fair
     	 bit of extra memory to keep track of the multiple cookie mappings in
     	 FS-Cache, and have to compare keys a lot to find duplicate mappings.

	 If I can assume that the _netfs_ will manage the 1:1 mapping, I can
	 use a lot less memory and save some processing capacity also.

	 I don't want to invent random keys to differentiate aliased
	 superblocks or inodes as that destroys the persistence capabilities
	 of the cache across power failures and reboots.

     (b) Callbacks.  I want a callback that the netfs passes to FS-Cache to
     	 permit the cache to update the metadata in the cache from netfs
     	 metadata at convenient times.  However, if there's more than one
     	 inode alias in core, which one should the cache use?

AFS doesn't have anything like these problems because mounts are always made
from the root of a volume, and AFS was designed with local caching in mind.

The getsb and statfs patches are a consequence of NFS being permitted to mount
arbitrary subtrees from the server.

David
