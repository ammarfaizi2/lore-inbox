Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVHLMeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVHLMeL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 08:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVHLMeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 08:34:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19595 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751153AbVHLMeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 08:34:10 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200508121234.13951.phillips@arcor.de> 
References: <200508121234.13951.phillips@arcor.de>  <20050810234246.GT4006@stusta.de> <200508110823.53593.phillips@arcor.de> <27057.1123753592@warthog.cambridge.redhat.com> 
To: Daniel Phillips <phillips@arcor.de>
Cc: David Howells <dhowells@redhat.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC][PATCH] Rename PageChecked as PageMiscFS 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Date: Fri, 12 Aug 2005 13:32:32 +0100
Message-ID: <5083.1123849952@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Daniel Phillips <phillips@arcor.de> wrote:

> > I know you want to ruthlessly trim out anything that isn't used, but please
> > be patient:-)
> 
> Are you sure CacheFS is even the right way to do client-side caching?

It's just one way. See the attached document for how it works.

> What is wrong with handling the backing store directly in your network
> filesystem?

What do you mean by "handle the backing store"? Note that the system I'm
proposing involves directly moving data between netfs pages and the cache. I'm
trying very hard to avoid copying the data any more than I have to.

> You have to hack your filesystem to use CacheFS anyway, so why not write
> some library functions to handle the backing store mapping and turn the hack
> into a few library calls instead?

FS-Cache is just that. CacheFS is one of a number of proposed backends.

> I just don't see how turning this functionality into a filesystem is the
> right abstraction.  What actual advantage is there?  I noticed somebody out
> there on the web waxing poetic about how the administrator can look into the
> cache, see what is cached, and even delete some of it.  That just makes me
> cringe.

Well... With CacheFS you can't do that; not now, at least.

Using a block device has the very great advantage that it's a lot easier to
provide guarantees about service quality. Reading an NFS file through CacheFS
on a blockdev seems to be somewhat faster than reading the same file from
EXT2. I'm not sure why, but I'm sure Stephen and others will be very
interested if I find out.

The downside of using a block device is that you have to have one available,
and it can't easily be used for something else. Actually, this last isn't
entirely true: CacheFS is a filesystem after all...

Actually, given that CacheFS is a filesystem, that makes the userspace UI for
using it very simple...

Besides, who says CacheFS will be the only back end? CacheFiles is coming too,
but CacheFiles is, in many ways, a lot harder as I have to work through an
existing filesystem, using existing access functions. Not only that, but
CacheFiles can't provide a guarantee of minimum space and can't provide
reservations. CacheFiles has to be able to use O_DIRECT (which I have a patch
for), but has to be able to detect holes in the backing file.

What ever you do, do not forget the following hard requirements:

 (1) It must be trivially possible run without a cache.

 (2) It must be possible to access a file that's larger than the maximum size
     of the cache.

 (3) It must be possible to simultaneously access a set of files that are
     larger than the maximum size of the cache.

 (4) It mustn't take hours to open a huge file, just so you can access one
     block.

 (5) The cache must be able to survive power failure, and be recovered into a
     known state.

 (6) It must be possible to ignore I/O errors on the cache.

 (7) There mustn't be too much change to the netfs. FS-Cache doesn't really
     have that much of an impact on any filesystem that wishes to use it.

Note that if you're thinking of using i_host on the netfs inode to point at
the cache inode, and downloading the entire file on iget(), possibly in
userspace, then forget it: that violates (2), (3), (4) and (6) at the very
least.

David

--=-=-=
Content-Disposition: attachment; filename=fscache.txt

			  ==========================
			  General Filesystem Caching
			  ==========================

========
OVERVIEW
========

This facility is a general purpose cache for network filesystems, though it
could be used for caching other things such as ISO9660 filesystems too.

FS-Cache mediates between cache backends (such as CacheFS) and network
filesystems:

	+---------+
	|         |                        +-----------+
	|   NFS   |--+                     |           |
	|         |  |                 +-->|  CacheFS  |
	+---------+  |   +----------+  |   | /dev/hda5 |
	             |   |          |  |   +-----------+
	+---------+  +-->|          |  |
	|         |      |          |--+   +-------------+
	|   AFS   |----->| FS-Cache |      |             |
	|         |      |          |----->| Cache Files |
	+---------+  +-->|          |      | /var/cache  |
	             |   |          |--+   +-------------+
	+---------+  |   +----------+  |
	|         |  |                 |   +-------------+
	|  ISOFS  |--+                 |   |             |
	|         |                    +-->| ReiserCache |
	+---------+                        | /           |
	                                   +-------------+

FS-Cache does not follow the idea of completely loading every netfs file
opened in its entirety into a cache before permitting it to be accessed and
then serving the pages out of that cache rather than the netfs inode because:

 (1) It must be practical to operate without a cache.

 (2) The size of any accessible file must not be limited to the size of the
     cache.

 (3) The combined size of all opened files (this includes mapped libraries)
     must not be limited to the size of the cache.

 (4) The user should not be forced to download an entire file just to do a
     one-off access of a small portion of it (such as might be done with the
     "file" program).

It instead serves the cache out in PAGE_SIZE chunks as and when requested by
the netfs('s) using it.


FS-Cache provides the following facilities:

 (1) More than one cache can be used at once. Caches can be selected explicitly
     by use of tags.

 (2) Caches can be added / removed at any time.

 (3) The netfs is provided with an interface that allows either party to
     withdraw caching facilities from a file (required for (2)).

 (4) The interface to the netfs returns as few errors as possible, preferring
     rather to let the netfs remain oblivious.

 (5) Cookies are used to represent indexes, files and other objects to the
     netfs. The simplest cookie is just a NULL pointer - indicating nothing
     cached there.

 (6) The netfs is allowed to propose - dynamically - any index hierarchy it
     desires, though it must be aware that the index search function is
     recursive, stack space is limited, and indexes can only be children of
     indexes.

 (7) Data I/O is done direct to and from the netfs's pages. The netfs indicates
     that page A is at index B of the data-file represented by cookie C, and
     that it should be read or written. The cache backend may or may not start
     I/O on that page, but if it does, a netfs callback will be invoked to
     indicate completion. The I/O may be either synchronous or asynchronous.

 (8) Cookies can be "retired" upon release. At this point FS-Cache will mark
     them as obsolete and the index hierarchy rooted at that point will get
     recycled.

 (9) The netfs provides a "match" function for index searches. In addition to
     saying whether a match was made or not, this can also specify that an
     entry should be updated or deleted.


FS-Cache maintains a virtual indexing tree in which all indexes, files, objects
and pages are kept. Bits of this tree may actually reside in one or more
caches.

                                           FSDEF
                                             |
                        +------------------------------------+
                        |                                    |
                       NFS                                  AFS
                        |                                    |
           +--------------------------+                +-----------+
           |                          |                |           |
        homedir                     mirror          afs.org   redhat.com
           |                          |                            |
     +------------+           +---------------+              +----------+
     |            |           |               |              |          |
   00001        00002       00007           00125        vol00001   vol00002
     |            |           |               |                         |
 +---+---+     +-----+      +---+      +------+------+            +-----+----+
 |   |   |     |     |      |   |      |      |      |            |     |    |
PG0 PG1 PG2   PG0  XATTR   PG0 PG1   DIRENT DIRENT DIRENT        R/W   R/O  Bak
                     |                                            |
                    PG0                                       +-------+
                                                              |       |
                                                            00001   00003
                                                              |
                                                          +---+---+
                                                          |   |   |
                                                         PG0 PG1 PG2

In the example above, you can see two netfs's being backed: NFS and AFS. These
have different index hierarchies:

 (*) The NFS primary index contains per-server indexes. Each server index is
     indexed by NFS file handles to get data file objects. Each data file
     objects can have an array of pages, but may also have further child
     objects, such as extended attributes and directory entries. Extended
     attribute objects themselves have page-array contents.

 (*) The AFS primary index contains per-cell indexes. Each cell index contains
     per-logical-volume indexes. Each of volume index contains up to three
     indexes for the read-write, read-only and backup mirrors of those
     volumes. Each of these contains vnode data file objects, each of which
     contains an array of pages.

The very top index is the FS-Cache master index in which individual netfs's
have entries.

Any index object may reside in more than one cache, provided it only has index
children. Any index with non-index object children will be assumed to only
reside in one cache.


The netfs API to FS-Cache can be found in:

	Documentation/filesystems/caching/netfs-api.txt

The cache backend API to FS-Cache can be found in:

	Documentation/filesystems/caching/backend-api.txt

--=-=-=--
