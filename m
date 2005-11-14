Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVKNV5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVKNV5z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbVKNV5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:57:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43925 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751290AbVKNVzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:55:31 -0500
Date: Mon, 14 Nov 2005 21:54:39 GMT
Message-Id: <200511142154.jAELsdf0007538@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 12/12] FS-Cache: CacheFS: Add Documentation
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds documentation for CacheFS.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 fscache-cachefs-docs-2614mm2.diff
 Documentation/filesystems/caching/cachefs.txt |  375 ++++++++++++++++++++++++++
 1 files changed, 375 insertions(+)

diff -uNrp linux-2.6.14-mm2/Documentation/filesystems/caching/cachefs.txt linux-2.6.14-mm2-cachefs/Documentation/filesystems/caching/cachefs.txt
--- linux-2.6.14-mm2/Documentation/filesystems/caching/cachefs.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/Documentation/filesystems/caching/cachefs.txt	2005-11-14 16:23:38.000000000 +0000
@@ -0,0 +1,375 @@
+			  ===========================
+			  CacheFS: Caching Filesystem
+			  ===========================
+
+========
+OVERVIEW
+========
+
+CacheFS is a backend for the general filesystem cache facility.
+
+CacheFS uses a block device directly rather than a bunch of files under an
+already mounted filesystem. For why this is so, see further on. If necessary,
+however, a file can be loopback mounted as a cache.
+
+CacheFS is based on a wandering tree approach. This means that data already on
+the disk are not changed (more or less), only replaced. This means that
+CacheFS provides both metadata integrity and data integrity. There is a small,
+simple journal that tracks the state of the tree and the block allocation
+management. Should the power be cut to a computer, or should it crash, all
+changes made to the cache since the last time the journal was cranked will be
+lost; but a valid tree will remain, albeit slightly out of date.
+
+
+========
+MOUNTING
+========
+
+Since CacheFS is actually a quasi-filesystem, it requires a block device behind
+it. The way to give it one is to mount it as cachefs type on a directory
+somewhere. The mounted filesystem will then present the user with a single file
+describing the current cache management status.
+
+There are a number of mount options that can be provided when the cache is
+mounted:
+
+ (*) -o tag=<name>
+
+     This tells FS-Cache the name by which netfs's will refer to the cache.
+     This is not strictly a necessity; if it's not given, a tag will be
+     invented based on the major and minor numbers of the block device. If the
+     netfs doesn't give FS-Cache any specific instructions, the first cache in
+     the list will be picked by default.
+
+ (*) -o wander=<n>
+
+     Set the wander timer so that CacheFS will commit the journal that long
+     after a change is made if nothing else causes the tree to wander.
+
+     n may be in the range 0 to 3600. If n is 0 then automatic wandering will
+     be disabled, otherwise it's a number of seconds. The tree is also forced
+     to wander by allocator underrun, sync and unmounting the cache.
+
+     A smaller number means that the cache will be more up to date if the power
+     fails, but that the allocator will cycle faster and blocks will be
+     replaced more often, lowering performance.
+
+ (*) -o autodel
+
+     All files should be deleted when the last reference to them is dropped.
+     This is primarily for debugging purposes.
+
+For instance, the cache might by mounted thusly:
+
+	root>mount -t cachefs /dev/hdg9 /cache-hdg9 -o tag=mycache
+	root>ls -1 /cache-hdg9
+	status
+
+However, a block device that's going to be used for a cache must be prepared
+before it can be mounted initially. This is done very simply by:
+
+	echo "cachefs___" >/dev/hdg9
+
+During the initial mount, the basic structure will be written into the cache
+and then the journal will be replayed as during a normal mount.
+
+Note that trying to mount a cache read only will result in an error.
+
+
+=============================================
+WHY A BLOCK DEVICE? WHY NOT A BUNCH OF FILES?
+=============================================
+
+CacheFS is backed by a block device rather than being backed by a bunch of
+files on a filesystem. This confers several advantages:
+
+ (1) Performance.
+
+     Going directly to a block device means that we can DMA directly to/from
+     the the netfs's pages. If another filesystem was managing the backing
+     store, everything would have to be copied between pages. Whilst DirectIO
+     does exist, it doesn't appear easy to make use of in this situation.
+
+     New address space or file operations could be added to make it possible to
+     persuade a backing diskfs to generate block I/O directly to/from disk
+     blocks under its control, but that then means the diskfs has to keep track
+     of I/O requests to pages not under its control.
+
+     Furthermore, we only have to do one lot of readahead calculations, not
+     two; in the diskfs backing case, the netfs would do one and the diskfs
+     would also do one.
+
+ (2) Memory.
+
+     Using a block device means that we have a lower memory usage - all data
+     pages belong to the netfs we're backing. If we used a filesystem, we would
+     have twice as many pages at certain points - one from the netfs and one
+     from the backing diskfs. In the backing diskfs model, under situations of
+     memory pressure, we'd have to allocate or keep around a diskfs page to be
+     able to write out a netfs page; or else we'd need to be able to punch a
+     hole in the backing file.
+
+     Furthermore, whilst we have to keep a certain amount of memory around for
+     every netfs inode we're backing, a backing diskfs would have to keep the
+     inode, dentry and possibly a file struct, in addition to FS-specific
+     stuff, thus adding to the burden.
+
+ (3) Holes.
+
+     The cache uses holes in files to indicate to the netfs that it hasn't yet
+     downloaded the data for that page.
+
+     Since CacheFS is its own filesystem, it can support holes in files
+     trivially. Running on top of another diskfs would limit us to using ones
+     that can support holes.
+
+     Furthermore, it would have to be made possible to detect holes in a diskfs
+     file, rather than just seeing zero filled blocks.
+
+ (4) Integrity
+
+     CacheFS maintains filesystem integrity through its use of a wandering
+     tree. It (for the most part) replaces blocks that need updating rather
+     than overwriting them in place. That said, certain non-structural changes
+     - such as the updating of atimes - are done in place.
+
+     CacheFS gets data integrity for free - more or less - by treating the
+     data exactly as it treats the metadata. Data blocks that need changing
+     are simply replaced. Whilst this does mean that the meta data pointing to
+     it also needs updating, quite often these changes elide between journal
+     updates.
+
+     Knowing that your cache is in a good state is vitally important if you,
+     say, put /usr on AFS. Some organisations put everything barring /etc,
+     /sbin, /lib and /var on AFS and have an enormous cache on every
+     computer. Imagine if the power goes out and renders every cache
+     inconsistent, requiring all the computers to re-initialise their caches
+     when the power comes back on...
+
+ (5) Disk Space.
+
+     Whilst the block device does set a hard ceiling on the amount of space
+     available, CacheFS can guarantee that all that space will be available to
+     the cache. On a diskfs-backed cache, the administrator would probably want
+     to set a cache size limit, but the system wouldn't be able guarantee that
+     all that space would be available to the cache - not unless that cache was
+     on a partition of its own.
+
+     Furthermore, with a diskfs-backed cache, if the recycler starts to reclaim
+     cache files to make space, the freed blocks may just be eaten directly by
+     userspace programs, potentially resulting in the entire cache being
+     consumed. Alternatively, netfs operations may end up being held up because
+     the cache can't get blocks on which to store the data.
+
+ (6) Users.
+
+     Users can't so easily go into CacheFS and run amok. The worst they can do
+     is cause bits of the cache to be recycled early. With a diskfs-backed
+     cache, they can do all sorts of bad things to the files belonging to the
+     cache, and they can do this quite by accident.
+
+
+On the other hand, there would be some advantages to using a file-based cache
+rather than a blockdev-based cache:
+
+ (1) Having to copy to a diskfs's page would mean that a netfs could just make
+     the copy and then assume its own page is ready to go.
+
+ (2) Backing onto a diskfs wouldn't require a committed block device. You would
+     just nominate a directory and go from there. With CacheFS you have to
+     repartition or install an extra drive to make use of it in an existing
+     system (though the loopback device offers a way out).
+
+ (3) You could easily make your cache bigger if the diskfs has plenty of space,
+     you could even go across multiple mountpoints. This last isn't so much of
+     a problem as you can have multiple caches.
+
+
+======================
+CACHEFS ON-DISK LAYOUT
+======================
+
+The filesystem is divided into a number of parts:
+
+  0	+---------------------------+
+	|        Superblock         |
+  1	+---------------------------+
+	|         Journal           |
+  17	+---------------------------+
+	|                           |
+	|           Data            |
+	|                           |
+ END	+---------------------------+
+
+The superblock contains the filesystem ID tags and pointers to all the other
+regions. All blocks are PAGE_SIZE in size and the blocks are numbered, starting
+with the superblock as 0. Using 32-bit block pointers, a maximum number of
+0xffffffff blocks can be accessed, meaning that the maximum cache size is ~16TB
+for 4KB pages.
+
+CachefS will use the endianness and block size details from the kernel that
+created a cache, and it will not permit the cache to be mounted if these
+details differ from what was written on disk.
+
+The journal consists of a set of entries of sector size that keep track of the
+current root block of the tree and the various recycling and allocation lists.
+
+The journal scanned on mounting to find the most recent fully committed tree
+root, and that will be used. Any changes that were made but not connected to
+the tree rooted in the latest journal entry will be lost.
+
+The data region holds a number of things:
+
+  (1) The Metadata Tree
+
+      As previously mentioned, CacheFS is tree based. The journal points to the
+      current committed root of the tree. The structure of this tree is
+      discussed below:
+
+  (2) Data Blocks
+
+      These are fragments of files that are cached on the behalf of network
+      filesystems.
+
+  (4) Allocation, Recycling and Reclamation Stacks and Free Blocks
+
+      The free blocks of the filesystem are kept in either the two allocation
+      stacks if they're laundered and ready to be used, or the reclamation
+      stack if they'll be ready once the journal has ticked over. Note that
+      stacks are used in order that committed stack nodes don't have to be
+      changed - we can just add another block on the front and change the stack
+      top pointer in the journal.
+
+      There are also two stacks associated with recycling trees of data blocks
+      from deleted nodes. These are processed in the background by kcachefsd
+      and their components all get transferred to the reclamation stacks and
+      thence to the allocation stacks.
+
+
+============================
+CACHEFS METADATA NODE LAYOUT
+============================
+
+The CacheFS metadata tree has its layout based around the filesystem block size
+(PAGE_SIZE) and the sector size of the underlying device (512 bytes normally).
+
+Each "node" in the tree is mapped onto a single block and contains a number of
+slots of sector size, aligned on sector boundaries:
+
+	+-------+----------+
+	|	|  SLOT 0  |
+	|	+----------+
+	|	|  SLOT 1  |
+	|	+----------+
+	|	|  SLOT 2  |
+	|	+----------+
+	|	|  SLOT 3  |
+	| NODE	+----------+
+	|	|  SLOT 4  |
+	|	+----------+
+	|	|  SLOT 5  |
+	|	+----------+
+	|	|  SLOT 6  |
+	|	+----------+
+	|	|  SLOT 7  |
+	+-------+----------+
+
+Each slot can either be empty or it can hold a "leaf". There are a number of
+types of leaves:
+
+ (1) Index Object Leaf.
+ (2) Data File Object Leaf.
+ (3) Other Object Leaf.
+
+     These three all look exactly the same on disk. They have the following
+     attributes:
+
+	- The object type.
+	- A unique object ID.
+	- The parent's object ID.
+	- A netfs key and key length.
+	- A digest of the netfs key, parent object ID and netfs key length.
+	- Netfs auxilliary data.
+	- The inode maximum size.
+	- The last time this object was accessed.
+	- The netfs's name for the class of this object.
+	- A tree of data pages, the depth of that tree and the number of blocks
+ 	  it contains.
+
+     In general, any type of object can have data or child objects; however,
+     indexes aren't permitted data and non-indexes aren't permitted indexes as
+     children.
+
+ (4) Pointer Leaf.
+
+     This is simply a leaf that is entirely given over to pointers to other
+     blocks (it can also contain null pointers).
+
+ (5) Shortcut Leaf.
+
+     This is a leaf that permits a chunk of keyspace to be skipped, allowing
+     the path through the tree to be shortened in some extreme cases.
+
+Note that pointer leaves can be distinguished from other leaf types by the
+second pointer slot in the leaf. If this points into the journal, then it
+actually indicates the type of one of the other types of leaf.
+
+
+===============================
+CACHEFS METADATA TREE STRUCTURE
+===============================
+
+The CacheFS metadata tree is navigated by rigidly partitioned key space. For a
+4KB page size, each step along the path of the tree consumes 10 bits of the key
+(a "subkey"), assuming bit 0 of byte 0 to be the first bit of the key:
+
+	LEVEL 0		LEVEL 1		LEVEL 2		LEVEL 3		LEVEL 4
+
+	+-------+	+-------+	+-------+	+-------+	+-------+
+	| PTR	|------>| PTR	|------>| PTR	|------>| PTR	|------>| LEAF	|
+	| LEAF	|	|	|	|	|	| PTR	|---+	| LEAF	|
+	| PTR	|	|	|	|	|	|	|   |	| LEAF	|
+	+-------+	+-------+	+-------+	+-------+   |	+-------+
+								    |
+								    |	+-------+
+								    +-->| LEAF	|
+									|	|
+									|	|
+									+-------+
+
+Whilst this would seem to be horribly inefficient, there are a number of
+optimisations that help to make the scheme much more efficient:
+
+ (1) No path is longer than it has to be. A node can hold more than one leaf,
+     so we don't bother fanning out a node that isn't full to overflowing.
+
+	+-------+	+-------+	+-------+	+-------+	+-------+
+	| PTR	|------>| PTR	|------>| PTR	|------>| PTR	|------>| LEAF	|
+	| LEAF	|	|	|	|	|	| LEAF	|	| LEAF	|
+	| PTR	|	|	|	|	|	|	|	| LEAF	|
+	+-------+	+-------+	+-------+	+-------+	+-------+
+
+ (2) If a path to the point at which a number of nodes can be distinguished is
+     made up of a line of nodes, each of which contains one pointer, then part
+     of the path can be made up of a shortcut leaf pointing to a node. The
+     shortcut represents several adjacent nodes.
+
+	+-------+	+-------+	+-------+
+	| SHORT	|------>| PTR	|------>| LEAF	|
+	| LEAF	|	| LEAF	|	| LEAF	|
+	| PTR	|	|	|	| LEAF	|
+	+-------+	+-------+	+-------+
+
+ (3) With a digest function that produces a reasonably even distibution based
+     on the key set presented, you get, for the most part, the shortest paths
+     everywhere.
+
+ (4) With a digest function that produces a certain amount of clumping bits of
+     the tree wind up staying in memory longer because they're referred to more
+     often. Also with a certain amount of clumping the tree ends up being less
+     sparse and thus occupies less disk space.
+
+ (5) It is assumed that if a node has a non-null pointer in a pointer leaf at
+     the location indexed by the subkey for that level of the key you're
+     looking for, then the leaf must lie behind that pointer, if it exists.
+     Otherwise you just have to look in the current node and no further.
