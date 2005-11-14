Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbVKNV52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbVKNV52 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbVKNV51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:57:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42901 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751282AbVKNVzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:55:31 -0500
Date: Mon, 14 Nov 2005 21:54:39 GMT
Message-Id: <200511142154.jAELsdrI007531@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Fcc: outgoing
Subject: [PATCH 9/12] FS-Cache: Add documentation for FS-Cache and its interfaces
In-Reply-To: <dhowells1132005277@warthog.cambridge.redhat.com>
References: <dhowells1132005277@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch adds documentation for FS-Cache in general and its network
filesystem and cache-backend interfaces specifically.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 fscache-docs-2614mm2.diff
 Documentation/filesystems/caching/backend-api.txt |  334 ++++++++++
 Documentation/filesystems/caching/fscache.txt     |  150 ++++
 Documentation/filesystems/caching/netfs-api.txt   |  726 ++++++++++++++++++++++
 3 files changed, 1210 insertions(+)

diff -uNrp linux-2.6.14-mm2/Documentation/filesystems/caching/fscache.txt linux-2.6.14-mm2-cachefs/Documentation/filesystems/caching/fscache.txt
--- linux-2.6.14-mm2/Documentation/filesystems/caching/fscache.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/Documentation/filesystems/caching/fscache.txt	2005-11-14 16:23:38.000000000 +0000
@@ -0,0 +1,150 @@
+			  ==========================
+			  General Filesystem Caching
+			  ==========================
+
+========
+OVERVIEW
+========
+
+This facility is a general purpose cache for network filesystems, though it
+could be used for caching other things such as ISO9660 filesystems too.
+
+FS-Cache mediates between cache backends (such as CacheFS) and network
+filesystems:
+
+	+---------+
+	|         |                        +-----------+
+	|   NFS   |--+                     |           |
+	|         |  |                 +-->|  CacheFS  |
+	+---------+  |   +----------+  |   | /dev/hda5 |
+	             |   |          |  |   +-----------+
+	+---------+  +-->|          |  |
+	|         |      |          |--+   +-------------+
+	|   AFS   |----->| FS-Cache |      |             |
+	|         |      |          |----->| Cache Files |
+	+---------+  +-->|          |      | /var/cache  |
+	             |   |          |--+   +-------------+
+	+---------+  |   +----------+  |
+	|         |  |                 |   +-------------+
+	|  ISOFS  |--+                 |   |             |
+	|         |                    +-->| ReiserCache |
+	+---------+                        | /           |
+	                                   +-------------+
+
+FS-Cache does not follow the idea of completely loading every netfs file
+opened in its entirety into a cache before permitting it to be accessed and
+then serving the pages out of that cache rather than the netfs inode because:
+
+ (1) It must be practical to operate without a cache.
+
+ (2) The size of any accessible file must not be limited to the size of the
+     cache.
+
+ (3) The combined size of all opened files (this includes mapped libraries)
+     must not be limited to the size of the cache.
+
+ (4) The user should not be forced to download an entire file just to do a
+     one-off access of a small portion of it (such as might be done with the
+     "file" program).
+
+It instead serves the cache out in PAGE_SIZE chunks as and when requested by
+the netfs('s) using it.
+
+
+FS-Cache provides the following facilities:
+
+ (1) More than one cache can be used at once. Caches can be selected explicitly
+     by use of tags.
+
+ (2) Caches can be added / removed at any time.
+
+ (3) The netfs is provided with an interface that allows either party to
+     withdraw caching facilities from a file (required for (2)).
+
+ (4) The interface to the netfs returns as few errors as possible, preferring
+     rather to let the netfs remain oblivious.
+
+ (5) Cookies are used to represent indexes, files and other objects to the
+     netfs. The simplest cookie is just a NULL pointer - indicating nothing
+     cached there.
+
+ (6) The netfs is allowed to propose - dynamically - any index hierarchy it
+     desires, though it must be aware that the index search function is
+     recursive, stack space is limited, and indexes can only be children of
+     indexes.
+
+ (7) Data I/O is done direct to and from the netfs's pages. The netfs indicates
+     that page A is at index B of the data-file represented by cookie C, and
+     that it should be read or written. The cache backend may or may not start
+     I/O on that page, but if it does, a netfs callback will be invoked to
+     indicate completion. The I/O may be either synchronous or asynchronous.
+
+ (8) Cookies can be "retired" upon release. At this point FS-Cache will mark
+     them as obsolete and the index hierarchy rooted at that point will get
+     recycled.
+
+ (9) The netfs provides a "match" function for index searches. In addition to
+     saying whether a match was made or not, this can also specify that an
+     entry should be updated or deleted.
+
+
+FS-Cache maintains a virtual indexing tree in which all indexes, files, objects
+and pages are kept. Bits of this tree may actually reside in one or more
+caches.
+
+                                           FSDEF
+                                             |
+                        +------------------------------------+
+                        |                                    |
+                       NFS                                  AFS
+                        |                                    |
+           +--------------------------+                +-----------+
+           |                          |                |           |
+        homedir                     mirror          afs.org   redhat.com
+           |                          |                            |
+     +------------+           +---------------+              +----------+
+     |            |           |               |              |          |
+   00001        00002       00007           00125        vol00001   vol00002
+     |            |           |               |                         |
+ +---+---+     +-----+      +---+      +------+------+            +-----+----+
+ |   |   |     |     |      |   |      |      |      |            |     |    |
+PG0 PG1 PG2   PG0  XATTR   PG0 PG1   DIRENT DIRENT DIRENT        R/W   R/O  Bak
+                     |                                            |
+                    PG0                                       +-------+
+                                                              |       |
+                                                            00001   00003
+                                                              |
+                                                          +---+---+
+                                                          |   |   |
+                                                         PG0 PG1 PG2
+
+In the example above, you can see two netfs's being backed: NFS and AFS. These
+have different index hierarchies:
+
+ (*) The NFS primary index contains per-server indexes. Each server index is
+     indexed by NFS file handles to get data file objects. Each data file
+     objects can have an array of pages, but may also have further child
+     objects, such as extended attributes and directory entries. Extended
+     attribute objects themselves have page-array contents.
+
+ (*) The AFS primary index contains per-cell indexes. Each cell index contains
+     per-logical-volume indexes. Each of volume index contains up to three
+     indexes for the read-write, read-only and backup mirrors of those
+     volumes. Each of these contains vnode data file objects, each of which
+     contains an array of pages.
+
+The very top index is the FS-Cache master index in which individual netfs's
+have entries.
+
+Any index object may reside in more than one cache, provided it only has index
+children. Any index with non-index object children will be assumed to only
+reside in one cache.
+
+
+The netfs API to FS-Cache can be found in:
+
+	Documentation/filesystems/caching/netfs-api.txt
+
+The cache backend API to FS-Cache can be found in:
+
+	Documentation/filesystems/caching/backend-api.txt
diff -uNrp linux-2.6.14-mm2/Documentation/filesystems/caching/netfs-api.txt linux-2.6.14-mm2-cachefs/Documentation/filesystems/caching/netfs-api.txt
--- linux-2.6.14-mm2/Documentation/filesystems/caching/netfs-api.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/Documentation/filesystems/caching/netfs-api.txt	2005-11-14 17:02:22.000000000 +0000
@@ -0,0 +1,726 @@
+			===============================
+			FS-CACHE NETWORK FILESYSTEM API
+			===============================
+
+There's an API by which a network filesystem can make use of the FS-Cache
+facilities. This is based around a number of principles:
+
+ (1) Caches can store a number of different object types. There are two main
+     object types: indexes and files. The first is a special type used by
+     FS-Cache to make finding objects faster and to make retiring of groups of
+     objects easier.
+
+ (2) Every index, file or other object is represented by a cookie. This cookie
+     may or may not have anything associated with it, but the netfs doesn't
+     need to care.
+
+ (3) Barring the top-level index (one entry per cached netfs), the index
+     hierarchy for each netfs is structured according the whim of the netfs.
+
+This API is declared in <linux/fscache.h>.
+
+This document contains the following sections:
+
+	 (1) Network filesystem definition
+	 (2) Index definition
+	 (3) Object definition
+	 (4) Network filesystem (un)registration
+	 (5) Cache tag lookup
+	 (6) Index registration
+	 (7) Data file registration
+	 (8) Miscellaneous object registration
+	 (9) Setting the data file size
+	(10) Page alloc/read/write
+	(11) Page uncaching
+	(12) Index and data file update
+	(13) Miscellaneous cookie operations
+	(14) Cookie unregistration
+	(15) Index and data file invalidation
+
+
+=============================
+NETWORK FILESYSTEM DEFINITION
+=============================
+
+FS-Cache needs a description of the network filesystem. This is specified using
+a record of the following structure:
+
+	struct fscache_netfs {
+		uint32_t			version;
+		const char			*name;
+		struct fscache_netfs_operations	*ops;
+		struct fscache_cookie		*primary_index;
+		...
+	};
+
+This first three fields should be filled in before registration, and the fourth
+will be filled in by the registration function; any other fields should just be
+ignored and are for internal use only.
+
+The fields are:
+
+ (1) The name of the netfs (used as the key in the toplevel index).
+
+ (2) The version of the netfs (if the name matches but the version doesn't, the
+     entire in-cache hierarchy for this netfs will be scrapped and begun
+     afresh).
+
+ (3) The operations table is defined as follows:
+
+	struct fscache_netfs_operations {
+	};
+
+     Currently there aren't any functions here.
+
+ (4) The cookie representing the primary index will be allocated according to
+     another parameter passed into the registration function.
+
+For example, kAFS (linux/fs/afs/) uses the following definitions to describe
+itself:
+
+	static struct fscache_netfs_operations afs_cache_ops = {
+	};
+
+	struct fscache_netfs afs_cache_netfs = {
+		.version	= 0,
+		.name		= "afs",
+		.ops		= &afs_cache_ops,
+	};
+
+
+================
+INDEX DEFINITION
+================
+
+Indexes are used for two purposes:
+
+ (1) To aid the finding of a file based on a series of keys (such as AFS's
+     "cell", "volume ID", "vnode ID").
+
+ (2) To make it easier to discard a subset of all the files cached based around
+     a particular key - for instance to mirror the removal of an AFS volume.
+
+However, since it's unlikely that any two netfs's are going to want to define
+their index hierarchies in quite the same way, FS-Cache tries to impose as few
+restraints as possible on how an index is structured and where it is placed in
+the tree. The netfs can even mix indexes and data files at the same level, but
+it's not recommended.
+
+Each index entry consists of a key of indeterminate length plus some auxilliary
+data, also of indeterminate length.
+
+There are some limits on indexes:
+
+ (1) Any index containing non-index objects should be restricted to a single
+     cache. Any such objects created within an index will be created in the
+     first cache only. The cache in which an index is created can be controlled
+     by cache tags (see below).
+
+ (2) The entry data must be atomically journallable, so it is limited to about
+     400 bytes at present. At least 400 bytes will be available.
+
+ (3) The depth of the index tree should be judged with care as the search
+     function is recursive. Too many layers will run the kernel out of stack.
+
+
+=================
+OBJECT DEFINITION
+=================
+
+To define an object, a structure of the following type should be filled out:
+
+	struct fscache_object_def
+	{
+		uint8_t name[16];
+		uint8_t type;
+
+		struct fscache_cache_tag *(*select_cache)(
+			const void *parent_netfs_data,
+			const void *cookie_netfs_data);
+
+		uint16_t (*get_key)(const void *cookie_netfs_data,
+				    void *buffer,
+				    uint16_t bufmax);
+
+		void (*get_attr)(const void *cookie_netfs_data,
+				 uint64_t *size);
+
+		uint16_t (*get_aux)(const void *cookie_netfs_data,
+				    void *buffer,
+				    uint16_t bufmax);
+
+		fscache_checkaux_t (*check_aux)(void *cookie_netfs_data,
+						const void *data,
+						uint16_t datalen);
+
+		void (*mark_pages_cached)(void *cookie_netfs_data,
+					  struct address_space *mapping,
+					  struct pagevec *cached_pvec);
+
+		void (*now_uncached)(void *cookie_netfs_data);
+	};
+
+This has the following fields:
+
+ (1) The type of the object [mandatory].
+
+     This is one of the following values:
+
+	(*) FSCACHE_COOKIE_TYPE_INDEX
+
+	    This defines an index, which is a special FS-Cache type.
+
+	(*) FSCACHE_COOKIE_TYPE_DATAFILE
+
+	    This defines an ordinary data file.
+
+	(*) Any other value between 2 and 255
+
+	    This defines an extraordinary object such as an XATTR.
+
+ (2) The name of the object type (NUL terminated unless all 16 chars are used)
+     [optional].
+
+ (3) A function to select the cache in which to store an index [optional].
+
+     This function is invoked when an index needs to be instantiated in a cache
+     during the instantiation of a non-index object. Only the immediate index
+     parent for the non-index object will be queried. Any indexes above that in
+     the hierarchy may be stored in multiple caches. This function does not
+     need to be supplied for any non-index object or any index that will only
+     have index children.
+
+     If this function is not supplied or if it returns NULL then the first
+     cache in the parent's list will be chosed, or failing that, the first
+     cache in the master list.
+
+ (4) A function to retrieve an object's key from the netfs [mandatory].
+
+     This function will be called with the netfs data that was passed to the
+     cookie acquisition function and the maximum length of key data that it may
+     provide. It should write the required key data into the given buffer and
+     return the quantity it wrote.
+
+ (5) A function to retrieve attribute data from the netfs [optional].
+
+     This function will be called with the netfs data that was passed to the
+     cookie acquisition function. It should return the size of the file if this
+     is a data file. The size may be used to govern how much cache must be
+     reserved for this file in the cache.
+
+     If the function is absent, a file size of 0 is assumed.
+
+ (6) A function to retrieve auxilliary data from the netfs [optional].
+
+     This function will be called with the netfs data that was passed to the
+     cookie acquisition function and the maximum length of auxilliary data that
+     it may provide. It should write the auxilliary data into the given buffer
+     and return the quantity it wrote.
+
+     If this function is absent, the auxilliary data length will be set to 0.
+
+     The length of the auxilliary data buffer may be dependent on the key
+     length. A netfs mustn't rely on being able to provide more than 400 bytes
+     for both.
+
+ (7) A function to check the auxilliary data [optional].
+
+     This function will be called to check that a match found in the cache for
+     this object is valid. For instance with AFS it could check the auxilliary
+     data against the data version number returned by the server to determine
+     whether the index entry in a cache is still valid.
+
+     If this function is absent, it will be assumed that matching objects in a
+     cache are always valid.
+
+     If present, the function should return one of the following values:
+
+	(*) FSCACHE_CHECKAUX_OKAY		- the entry is okay as is
+	(*) FSCACHE_CHECKAUX_NEEDS_UPDATE	- the entry requires update
+	(*) FSCACHE_CHECKAUX_OBSOLETE		- the entry should be deleted
+
+     This function can also be used to extract data from the auxilliary data in
+     the cache and copy it into the netfs's structures.
+
+ (8) A function to mark a page as retaining cache metadata [mandatory].
+
+     This is called by the cache to indicate that it is retaining in-memory
+     information for this page and that the netfs should uncache the page when
+     it has finished. This does not indicate whether there's data on the disk
+     or not. Note that several pages at once may be presented for marking.
+
+     kAFS and NFS use the PG_private bit on the page structure for this, but
+     that may not be appropriate in all cases.
+
+     This function is not required for indexes as they're not permitted data.
+
+ (9) A function to unmark all the pages retaining cache metadata [mandatory].
+
+     This is called by FS-Cache to indicate that a backing store is being
+     unbound from a cookie and that all the marks on the pages should be
+     cleared to prevent confusion. Note that the cache will have torn down all
+     its tracking information so that the pages don't need to be explicitly
+     uncached.
+
+     This function is not required for indexes as they're not permitted data.
+
+
+===================================
+NETWORK FILESYSTEM (UN)REGISTRATION
+===================================
+
+The first step is to declare the network filesystem to the cache. This also
+involves specifying the layout of the primary index (for AFS, this would be the
+"cell" level).
+
+The registration function is:
+
+	int fscache_register_netfs(struct fscache_netfs *netfs);
+
+It just takes a pointer to the netfs definition. It returns 0 or an error as
+appropriate.
+
+For kAFS, registration is done as follows:
+
+	ret = fscache_register_netfs(&afs_cache_netfs);
+
+The last step is, of course, unregistration:
+
+	void fscache_unregister_netfs(struct fscache_netfs *netfs);
+
+
+================
+CACHE TAG LOOKUP
+================
+
+FS-Cache permits the use of more than one cache. To permit particular index
+subtrees to be bound to particular caches, the second step is to look up cache
+representation tags. This step is optional; it can be left entirely up to
+FS-Cache as to which cache should be used. The problem with doing that is that
+FS-Cache will always pick the first cache that was registered.
+
+To get the representation for a named tag:
+
+	struct fscache_cache_tag *fscache_lookup_cache_tag(const char *name);
+
+This takes a text string as the name and returns a representation of a tag. It
+will never return an error. It may return a dummy tag, however, if it runs out
+of memory; this will inhibit caching with this tag.
+
+Any representation so obtained must be released by passing it to this function:
+
+	void fscache_release_cache_tag(struct fscache_cache_tag *tag);
+
+The tag will be retrieved by FS-Cache when it calls the object definition
+operation select_cache().
+
+
+==================
+INDEX REGISTRATION
+==================
+
+The third step is to inform FS-Cache about part of an index hierarchy that can
+be used to locate files. This is done by requesting a cookie for each index in
+the path to the file:
+
+	struct fscache_cookie *
+	fscache_acquire_cookie(struct fscache_cookie *parent,
+			       struct fscache_object_def *def,
+			       void *netfs_data);
+
+This function creates an index entry in the index represented by parent,
+filling in the index entry by calling the operations pointed to by def.
+
+Note that this function never returns an error - all errors are handled
+internally. It may also return FSCACHE_NEGATIVE_COOKIE. It is quite acceptable
+to pass this token back to this function as the parent to another acquisition
+(or even to the relinquish cookie, read page and write page functions - see
+below).
+
+Note also that no indexes are actually created in a cache until a non-index
+object needs to be created somewhere down the hierarchy. Furthermore, an index
+may be created in several different caches independently at different
+times. This is all handled transparently, and the netfs doesn't see any of it.
+
+For example, with AFS, a cell would be added to the primary index. This index
+entry would have a dependent inode containing a volume location index for the
+volume mappings within this cell:
+
+	cell->cache =
+		fscache_acquire_cookie(afs_cache_netfs.primary_index,
+				       &afs_cell_cache_index_def,
+				       cell);
+
+Then when a volume location was accessed, it would be entered into the cell's
+index and an inode would be allocated that acts as a volume type and hash chain
+combination:
+
+	vlocation->cache =
+		fscache_acquire_cookie(cell->cache,
+				       &afs_vlocation_cache_index_def,
+				       vlocation);
+
+And then a particular flavour of volume (R/O for example) could be added to
+that index, creating another index for vnodes (AFS inode equivalents):
+
+	volume->cache =
+		fscache_acquire_cookie(vlocation->cache,
+				       &afs_volume_cache_index_def,
+				       volume);
+
+
+======================
+DATA FILE REGISTRATION
+======================
+
+The fourth step is to request a data file be created in the cache. This is
+identical to index cookie acquisition. The only difference is that the type in
+the object definition should be something other than index type.
+
+	vnode->cache =
+		fscache_acquire_cookie(volume->cache,
+				       &afs_vnode_cache_object_def,
+				       vnode);
+
+
+=================================
+MISCELLANEOUS OBJECT REGISTRATION
+=================================
+
+An optional step is to request an object of miscellaneous type be created in
+the cache. This is almost identical to index cookie acquisition. The only
+difference is that the type in the object definition should be something other
+than index type. Whilst the parent object could be an index, it's more likely
+it would be some other type of object such as a data file.
+
+	xattr->cache =
+		fscache_acquire_cookie(vnode->cache,
+				       &afs_xattr_cache_object_def,
+				       xattr);
+
+Miscellaneous objects might be used to store extended attributes or directory
+entries for example.
+
+
+==========================
+SETTING THE DATA FILE SIZE
+==========================
+
+The fifth step is to set the size of the file. This doesn't automatically
+reserve any space in the cache, but permits the cache to adjust its metadata
+for data tracking appropriately:
+
+	int fscache_set_i_size(struct fscache_cookie *cookie, loff_t i_size);
+
+The cache will return -ENOBUFS if there is no backing cache or if there is no
+space to allocate any extra metadata required in the cache.
+
+Note that attempts to read or write data pages in the cache over this size may
+be rebuffed with -ENOBUFS.
+
+
+=====================
+PAGE READ/ALLOC/WRITE
+=====================
+
+And the sixth step is to store and retrieve pages in the cache. There are three
+functions that are used to do this.
+
+Note:
+
+ (1) A page should not be re-read or re-allocated without uncaching it first.
+
+ (2) A read or allocated page must be uncached when the netfs page is released
+     from the pagecache.
+
+ (3) A page should only be written to the cache if previous read or allocated.
+
+This permits the cache to maintain its page tracking in proper order.
+
+
+PAGE READ
+---------
+
+Firstly, the netfs should ask FS-Cache to examine the caches and read the
+contents cached for a particular page of a particular file if present, or else
+allocate space to store the contents if not:
+
+	typedef
+	void (*fscache_rw_complete_t)(void *cookie_data,
+				      struct page *page,
+				      void *end_io_data,
+				      int error);
+
+	int fscache_read_or_alloc_page(struct fscache_cookie *cookie,
+				       struct page *page,
+				       fscache_rw_complete_t end_io_func,
+				       void *end_io_data,
+				       gfp_t gfp);
+
+The cookie argument must specify a cookie for an object that isn't an index,
+the page specified will have the data loaded into it (and is also used to
+specify the page number), and the gfp argument is used to control how any
+memory allocations made are satisfied.
+
+If the cookie indicates the inode is not cached:
+
+ (1) The function will return -ENOBUFS.
+
+Else if there's a copy of the page resident in the cache:
+
+ (1) The mark_pages_cached() cookie operation will be called on that page.
+
+ (2) The function will submit a request to read the data from the cache's
+     backing device directly into the page specified.
+
+ (3) The function will return 0.
+
+ (4) When the read is complete, end_io_func() will be invoked with:
+
+     (*) The netfs data supplied when the cookie was created.
+
+     (*) The page descriptor.
+
+     (*) The end_io_data argument passed to the above function.
+
+     (*) An argument that's 0 on success or negative for an error code.
+
+     If an error occurs, it should be assumed that the page contains no usable
+     data.
+
+Otherwise, if there's not a copy available in cache, but the cache may be able
+to store the page:
+
+ (1) The mark_pages_cached() cookie operation will be called on that page.
+
+ (2) A block may be reserved in the cache and attached to the object at the
+     appropriate place.
+
+ (3) The function will return -ENODATA.
+
+This function may also return -ENOMEM or -EINTR, in which case it won't have
+read any data from the cache.
+
+
+PAGE ALLOCATE
+-------------
+
+Alternatively, if there's not expected to be any data in the cache for a page
+because the file has been extended, a block can simply be allocated instead:
+
+	int fscache_alloc_page(struct fscache_cookie *cookie,
+			       struct page *page,
+			       gfp_t gfp);
+
+This is similar to the fscache_read_or_alloc_page() function, except that it
+never reads from the cache. It will return 0 if a block has been allocated,
+rather than -ENODATA as the other would. One or the other must be performed
+before writing to the cache.
+
+The mark_pages_cached() cookie operation will be called on the page if
+successful.
+
+
+PAGE WRITE
+----------
+
+Secondly, if the netfs changes the contents of the page (either due to an
+initial download or if a user performs a write), then the page should be
+written back to the cache:
+
+	int fscache_write_page(struct fscache_cookie *cookie,
+			       struct page *page,
+			       fscache_rw_complete_t end_io_func,
+			       void *end_io_data,
+			       gfp_t gfp);
+
+The cookie argument must specify a data file cookie, the page specified should
+contain the data to be written (and is also used to specify the page number),
+and the gfp argument is used to control how any memory allocations made are
+satisfied.
+
+The page must have first been read or allocated successfully and must not have
+been uncached before writing is performed.
+
+If the cookie indicates the inode is not cached then:
+
+ (1) The function will return -ENOBUFS.
+
+Else if space can be allocated in the cache to hold this page:
+
+ (1) The function will submit a request to write the data to cache's backing
+     device directly from the page specified.
+
+ (2) The function will return 0.
+
+ (3) When the write is complete the end_io_func() will be invoked with:
+
+     (*) The netfs data supplied when the cookie was created.
+
+     (*) The page descriptor.
+
+     (*) The end_io_data argument passed to the function.
+
+     (*) An argument that's 0 on success or negative for an error.
+
+     If an error occurs, it can be assumed that the page has not been written
+     to the cache, and that either there's a block containing the old data or
+     no block at all in the cache.
+
+Else if there's no space available in the cache, -ENOBUFS will be returned.
+
+
+MULTIPLE PAGE READ
+------------------
+
+A facility is provided to read several pages at once, as requested by the
+readpages() address space operation:
+
+	int fscache_read_or_alloc_pages(struct fscache_cookie *cookie,
+					struct address_space *mapping,
+					struct list_head *pages,
+					int *nr_pages,
+					fscache_rw_complete_t end_io_func,
+					void *end_io_data,
+					gfp_t gfp);
+
+This works in a similar way to fscache_read_or_alloc_page(), except:
+
+ (1) Any page it can retrieve data for is removed from pages and nr_pages and
+     dispatched for reading to the disk. Reads of adjacent pages on disk may be
+     merged for greater efficiency.
+
+ (2) The mark_pages_cached() cookie operation will be called on several pages
+     at once if they're being read or allocated.
+
+ (3) If there was an general error, then that error will be returned.
+
+     Else if some pages couldn't be allocated or read, then -ENOBUFS will be
+     returned.
+
+     Else if some pages couldn't be read but were allocated, then -ENODATA will
+     be returned.
+
+     Otherwise, if all pages had reads dispatched, then 0 will be returned, the
+     list will be empty and *nr_pages will be 0.
+
+ (4) end_io_func will be called once for each page being read as the reads
+     complete.
+
+Note that a return of -ENODATA, -ENOBUFS or any other error does not preclude
+some of the pages being read and some being allocated. Those pages will have
+been marked appropriately and will need uncaching.
+
+
+==============
+PAGE UNCACHING
+==============
+
+To uncache a page, this function should be called:
+
+	void fscache_uncache_page(struct fscache_cookie *cookie,
+				  struct page *page);
+
+This function permits the cache to release any in-memory representation it
+might be holding for this netfs page. This function must be called once for
+each page on which the read or write page functions above have been called to
+make sure the cache's in-memory tracking information gets torn down.
+
+Note that pages can't be explicitly deleted from the a data file. The whole
+data file must be retired (see the relinquish cookie function below).
+
+Furthermore, note that this does not cancel the asynchronous read or write
+operation started by the read/alloc and write functions.
+
+There is another unbinding operation similar to the above that takes a set of
+pages to unbind in one go:
+
+	void fscache_uncache_pagevec(struct fscache_cookie *cookie,
+				     struct pagevec *pagevec);
+
+
+==========================
+INDEX AND DATA FILE UPDATE
+==========================
+
+To request an update of the index data for an index or other object, the
+following function should be called:
+
+	void fscache_update_cookie(struct fscache_cookie *cookie);
+
+This function will refer back to the netfs_data pointer stored in the cookie by
+the acquisition function to obtain the data to write into each revised index
+entry. The update method in the parent index definition will be called to
+transfer the data.
+
+Note that partial updates may happen automatically at other times, such as when
+data blocks are added to a data file object.
+
+
+===============================
+MISCELLANEOUS COOKIE OPERATIONS
+===============================
+
+There are a number of operations that can be used to control cookies:
+
+ (*) Cookie pinning:
+
+	int fscache_pin_cookie(struct fscache_cookie *cookie);
+	void fscache_unpin_cookie(struct fscache_cookie *cookie);
+
+     These operations permit data cookies to be pinned into the cache and to
+     have the pinning removed. They are not permitted on index cookies.
+
+     The pinning function will return 0 if successful, -ENOBUFS in the cookie
+     isn't backed by a cache, -EOPNOTSUPP if the cache doesn't support pinning,
+     -ENOSPC if there isn't enough space to honour the operation, -ENOMEM or
+     -EIO if there's any other problem.
+
+ (*) Data space reservation:
+
+	int fscache_reserve_space(struct fscache_cookie *cookie, loff_t size);
+
+     This permits a netfs to request cache space be reserved to store up to the
+     given amount of a file. It is permitted to ask for more than the current
+     size of the file to allow for future file expansion.
+
+     If size is given as zero then the reservation will be cancelled.
+
+     The function will return 0 if successful, -ENOBUFS in the cookie isn't
+     backed by a cache, -EOPNOTSUPP if the cache doesn't support reservations,
+     -ENOSPC if there isn't enough space to honour the operation, -ENOMEM or
+     -EIO if there's any other problem.
+
+     Note that this doesn't pin an object in a cache; it can still be culled to
+     make space if it's not in use.
+
+
+=====================
+COOKIE UNREGISTRATION
+=====================
+
+To get rid of a cookie, this function should be called.
+
+	void fscache_relinquish_cookie(struct fscache_cookie *cookie,
+				       int retire);
+
+If retire is non-zero, then the object will be marked for recycling, and all
+copies of it will be removed from all active caches in which it is present. Not
+only that but all child objects will also be retired.
+
+If retire is zero, then the object may be available again when next the
+acquisition function is called. Retirement here will overrule the pinning on a
+cookie.
+
+One very important note - relinquish must NOT be called for a cookie unless all
+the cookies for "child" indexes, objects and pages have been relinquished
+first.
+
+
+================================
+INDEX AND DATA FILE INVALIDATION
+================================
+
+There is no direct way to invalidate an index subtree or a data file. To do
+this, the caller should relinquish and retire the cookie they have, and then
+acquire a new one.
diff -uNrp linux-2.6.14-mm2/Documentation/filesystems/caching/backend-api.txt linux-2.6.14-mm2-cachefs/Documentation/filesystems/caching/backend-api.txt
--- linux-2.6.14-mm2/Documentation/filesystems/caching/backend-api.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14-mm2-cachefs/Documentation/filesystems/caching/backend-api.txt	2005-11-14 17:03:15.000000000 +0000
@@ -0,0 +1,334 @@
+			  ==========================
+			  FS-CACHE CACHE BACKEND API
+			  ==========================
+
+The FS-Cache system provides an API by which actual caches can be supplied to
+FS-Cache for it to then serve out to network filesystems and other interested
+parties.
+
+This API is declared in <linux/fscache-cache.h>.
+
+
+====================================
+INITIALISING AND REGISTERING A CACHE
+====================================
+
+To start off, a cache definition must be initialised and registered for each
+cache the backend wants to make available. For instance, CacheFS does this in
+the fill_super() operation on mounting.
+
+The cache definition (struct fscache_cache) should be initialised by calling:
+
+	void fscache_init_cache(struct fscache_cache *cache,
+				struct fscache_cache_ops *ops,
+				const char *idfmt,
+				...)
+
+Where:
+
+ (*) "cache" is a pointer to the cache definition;
+
+ (*) "ops" is a pointer to the table of operations that the backend supports on
+     this cache;
+
+ (*) and a format and printf-style arguments for constructing a label for the
+     cache.
+
+
+The cache should then be registered with FS-Cache by passing a pointer to the
+previously initialised cache definition to:
+
+	int fscache_add_cache(struct fscache_cache *cache,
+			      struct fscache_object *fsdef,
+			      const char *tagname);
+
+Two extra arguments should also be supplied:
+
+ (*) "fsdef" which should point to the object representation for the FS-Cache
+     master index in this cache. Netfs primary index entries will be created
+     here.
+
+ (*) "tagname" which, if given, should be a text string naming this cache. If
+     this is NULL, the identifier will be used instead. For CacheFS, the
+     identifier is set to name the underlying block device and the tag can be
+     supplied by mount.
+
+This function may return -ENOMEM if it ran out of memory or -EEXIST if the tag
+is already in use. 0 will be returned on success.
+
+
+=====================
+UNREGISTERING A CACHE
+=====================
+
+A cache can be withdrawn from the system by calling this function with a
+pointer to the cache definition:
+
+	void fscache_withdraw_cache(struct fscache_cache *cache)
+
+In CacheFS's case, this is called by put_super().
+
+
+==================
+FS-CACHE UTILITIES
+==================
+
+FS-Cache provides some utilities that a cache backend may make use of:
+
+ (*) Find the parent of an object:
+
+	struct fscache_object *
+	fscache_find_parent_object(struct fscache_object *object)
+
+     This allows a backend to find the logical parent of an index or data file
+     in the cache hierarchy.
+
+
+========================
+RELEVANT DATA STRUCTURES
+========================
+
+ (*) Index/Data file FS-Cache representation cookie.
+
+	struct fscache_cookie {
+		struct fscache_object_def	*def;
+		struct fscache_netfs		*netfs;
+		void				*netfs_data;
+		...
+	};
+
+     The fields that might be of use to the backend describe the object
+     definition, the netfs definition and the netfs's data for this
+     cookie. The object definition contain functions supplied by the netfs for
+     loading and matching index entries; these are required to provide some of
+     the cache operations.
+
+ (*) In-cache object representation.
+
+	struct fscache_object {
+		struct fscache_cache		*cache;
+		struct fscache_cookie		*cookie;
+		unsigned long			flags;
+	#define FSCACHE_OBJECT_RECYCLING	1
+		...
+	};
+
+     Structures of this type should be allocated by the cache backend and
+     passed to FS-Cache when requested by the appropriate cache operation. In
+     the case of CacheFS, they're embedded in CacheFS's internal object
+     structures.
+
+     Each object contains a pointer to the cookie that represents the object it
+     is backing. It also contains a flag that indicates whether this is an
+     index or not. This should be initialised by calling
+     fscache_object_init(object).
+
+
+================
+CACHE OPERATIONS
+================
+
+The cache backend provides FS-Cache with a table of operations that can be
+performed on the denizens of the cache. These are held in a structure of type
+
+	struct fscache_cache_ops
+
+ (*) Name of cache provider [mandatory].
+
+	const char *name
+
+     This isn't strictly an operation, but should be pointed at a string naming
+     the backend.
+
+ (*) Object lookup [mandatory].
+
+	struct fscache_object *(*lookup_object)(struct fscache_cache *cache,
+						struct fscache_object *parent,
+						struct fscache_cookie *cookie)
+
+     This method is used to look up an object in the specified cache, given a
+     pointer to the parent object and the cookie to which the object will be
+     attached. This should instantiate that object in the cache if it can, or
+     return -ENOBUFS or -ENOMEM if it can't.
+
+ (*) Increment object refcount [mandatory].
+
+	struct fscache_object *(*grab_object)(struct fscache_object *object)
+
+     This method is called to increment the reference count on an object. It
+     may fail (for instance if the cache is being withdrawn) by returning
+     NULL. It should return the object pointer if successful.
+
+ (*) Lock/Unlock object [mandatory].
+
+	void (*lock_object)(struct fscache_object *object)
+	void (*unlock_object)(struct fscache_object *object)
+
+     These methods are used to exclusively lock an object. It must be possible
+     to schedule with the lock held, so a spinlock isn't sufficient.
+
+ (*) Pin/Unpin object [optional].
+
+	int (*pin_object)(struct fscache_object *object)
+	void (*unpin_object)(struct fscache_object *object)
+
+     These methods are used to pin an object into the cache. Once pinned an
+     object cannot be reclaimed to make space. Return -ENOSPC if there's not
+     enough space in the cache to permit this.
+
+ (*) Update object [mandatory].
+
+	int (*update_object)(struct fscache_object *object)
+
+     This is called to update the index entry for the specified object. The new
+     information should be in object->cookie->netfs_data. This can be obtained
+     by calling object->cookie->def->get_aux()/get_attr().
+
+ (*) Release object reference [mandatory].
+
+	void (*put_object)(struct fscache_object *object)
+
+     This method is used to discard a reference to an object. The object may
+     be destroyed when all the references held by FS-Cache are released.
+
+ (*) Synchronise a cache [mandatory].
+
+	void (*sync)(struct fscache_cache *cache)
+
+     This is called to ask the backend to synchronise a cache with its backing
+     device.
+
+ (*) Dissociate a cache [mandatory].
+
+	void (*dissociate_pages)(struct fscache_cache *cache)
+
+     This is called to ask a cache to perform any page dissociations as part of
+     cache withdrawal.
+
+ (*) Set the data size on a cache file [mandatory].
+
+	int (*set_i_size)(struct fscache_object *object, loff_t i_size);
+
+     This is called to indicate to the cache the maximum size a file may
+     reach. The cache may use this to reserve space on the cache. It may also
+     return -ENOBUFS to indicate that insufficient space is available to expand
+     the metadata used to track the data. It should return 0 if successful or
+     -ENOMEM or -EIO on error.
+
+ (*) Reserve cache space for an object's data [optional].
+
+	int (*reserve_space)(struct fscache_object *object, loff_t size);
+
+     This is called to request that cache space be reserved to hold the data
+     for an object and the metadata used to track it. Zero size should be taken
+     as request to cancel a reservation.
+
+     This should return 0 if successful, -ENOSPC if there isn't enough space
+     available, or -ENOMEM or -EIO on other errors.
+
+     The reservation may exceed the size of the object, thus permitting future
+     expansion. If the amount of space consumed by an object would exceed the
+     reservation, it's permitted to refuse requests to allocate pages, but not
+     required. An object may be pruned down to its reservation size if larger
+     than that already.
+
+ (*) Request page be read from cache [mandatory].
+
+	int (*read_or_alloc_page)(struct fscache_object *object,
+				  struct page *page,
+				  fscache_rw_complete_t end_io_func,
+				  void *end_io_data,
+				  gfp_t gfp)
+
+     This is called to attempt to read a netfs page from the cache, or to
+     reserve a backing block if not. FS-Cache will have done as much checking
+     as it can before calling, but most of the work belongs to the backend.
+
+     If there's no page in the cache, then -ENODATA should be returned if the
+     backend managed to reserve a backing block; -ENOBUFS, -ENOMEM or -EIO if
+     it didn't.
+
+     If there is a page in the cache, then a read operation should be queued
+     and 0 returned. When the read finishes, end_io_func() should be called
+     with the following arguments:
+
+	(*end_io_func)(object->cookie->netfs_data,
+		       page,
+		       end_io_data,
+		       error);
+
+     The mark_pages_cached() cookie operation should be called for the page if
+     any cache metadata is retained. This will indicate to the netfs that the
+     page needs explicit uncaching. This operation takes a pagevec, thus
+     allowing several pages to be marked at once.
+
+ (*) Request pages be read from cache [mandatory].
+
+	int (*read_or_alloc_pages)(struct fscache_object *object,
+				   struct address_space *mapping,
+				   struct list_head *pages,
+				   unsigned *nr_pages,
+				   fscache_rw_complete_t end_io_func,
+				   void *end_io_data,
+				   gfp_t gfp)
+
+     This is like the previous operation, except it will be handed a list of
+     pages instead of one page. Any pages on which a read operation is started
+     must be added to the page cache for the specified mapping and also to the
+     LRU. Such pages must also be removed from the pages list and nr_pages
+     decremented per page.
+
+     If there was an error such as -ENOMEM, then that should be returned; else
+     if one or more pages couldn't be read or allocated, then -ENOBUFS should
+     be returned; else if one or more pages couldn't be read, then -ENODATA
+     should be returned. If all the pages are dispatched then 0 should be
+     returned.
+
+ (*) Request page be allocated in the cache [mandatory].
+
+	int (*allocate_page)(struct fscache_object *object,
+			     struct page *page,
+			     gfp_t gfp)
+
+     This is like read_or_alloc_page(), except that it shouldn't read from the
+     cache, even if there's data there that could be retrieved. It should,
+     however, set up any internal metadata required such that write_page() can
+     write to the cache.
+
+     If there's no backing block available, then -ENOBUFS should be returned
+     (or -ENOMEM or -EIO if there were other problems). If a block is
+     successfully allocated, then the netfs page should be marked and 0
+     returned.
+
+ (*) Request page be written to cache [mandatory].
+
+	int (*write_page)(struct fscache_object *object,
+			  struct page *page,
+			  fscache_rw_complete_t end_io_func,
+			  void *end_io_data,
+			  gfp_t gfp)
+
+     This is called to write from a page on which there was a previously
+     successful read_or_alloc_page() call. FS-Cache filters out pages that
+     don't have mappings.
+
+     If there's no backing block available, then -ENOBUFS should be returned
+     (or -ENOMEM or -EIO if there were other problems).
+
+     If the write operation could be queued, then 0 should be returned. When
+     the write completes, end_io_func() should be called with the following
+     arguments:
+
+	(*end_io_func)(object->cookie->netfs_data,
+		       page,
+		       end_io_data,
+		       error);
+
+ (*) Discard retained per-page metadata [mandatory].
+
+	void (*uncache_pages)(struct fscache_object *object,
+			      struct pagevec *pagevec)
+
+     This is called when one or more netfs pages are being evicted from the
+     pagecache. The cache backend should tear down any internal representation
+     or tracking it maintains.
