Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbVKQT2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVKQT2X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbVKQT2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:28:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28647 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964786AbVKQT2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:28:22 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20051116035639.3eaa7a35.akpm@osdl.org> 
References: <20051116035639.3eaa7a35.akpm@osdl.org>  <20051115112504.4b645a86.akpm@osdl.org> <20051114150347.1188499e.akpm@osdl.org> <dhowells1132005277@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0511141428390.3263@g5.osdl.org> <11717.1132077542@warthog.cambridge.redhat.com> <1932.1132140406@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>, sct@redhat.com
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-cachefs@redhat.com,
       linux-fsdevel@vger.kernel.org, nfsv4@linux-nfs.org
Subject: Re: [PATCH 0/12] FS-Cache: Generic filesystem caching facility 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Thu, 17 Nov 2005 19:28:02 +0000
Message-ID: <4204.1132255682@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > That's the third time you've asked:-)
> 
> Maybe on the fourth or fifth time it'll occur you to put it into the
> changelog.

But that's not what's changed.

So if/when I produce a CacheFiles patch as well, you'll expect a critique of
why that's better than everything else in the changelog for that?

> None of that appears to be relevant.

It rules out the use of i_mapping...

> A blockdev is just a big, fixed-sized file.  Why cannot it be backed by a
> big, fixed-sized file?
> 
> <looks>
> 
> OK, it's doing submit_bio() directly.

Using a big fixed-sized file also means that you've got two layout managers
and two transaction managers and two metadata managers on top of each other.

> > This facility isn't well advanced yet, and will initially only be
> > available on EXT2/3. It will also require a userspace component to clean
> > up dead nodes.
> 
> I'd have thought that a decent intermediate step would be
> cache-on-single-file using a_ops.direct_IO, as you're implying above.

That's really the worst of both worlds. If you can access files, then you're
best of doing so on a one cache-file per netfs-file basis, *if* you can get
notification of completion on an asynchronous operation.

If you try to do this, the caching backend will try to lay the blocks out in
a manner that will then be undone because the underlying filesystem will then
put the blocks or parts thereof where *it* wishes.

Furthermore, it would seem that whilst undertaking direct I/O on an inode,
that inode is locked against other direct I/O operations. This could end up
serialising all I/O operations on the cache (see dio_complete() in
fs/direct-io.c).

> Then all the direct-to-blockdev code can go away.  It'll take some tweaking
> of the core direct-io code, but nothing terribly serious.

The direct-to-blockdev code should get you better performance than going
through a single file on a filesystem: with your suggestion, you end up adding
the latency of the cache-to-single-file to that of the underlying filesystem.


There are five main problems that need solving for cachefiles that I can see:

 (1) Reading of holes must return ENODATA or a short write. I have a patch to
     do this for O_DIRECT (attached).

 (2) It must be possible to do O_DIRECT reads/writes directly to/from kernel
     pages. This may possible without modification, but I'm not certain of
     that; looking at dio_refill_pages() it may not be - that accesses the
     current->mm to get more pages.

 (3) It must be possible to do these reads and writes asynchronously and to
     get notification of their completion. I'm not sure how easy this is, but
     it looks like it should be possible, perhaps using a kiocb. The routines
     in fs/direct-io.c don't seem to be able to do asynchronicity, except
     through AIO.

 (4) It must be possible to maintain structural integrity in the cache. This
     should be possible simply be relying on the underlying filesystem.

 (5) It must be possible to maintain a certain level of data integrity in the
     cache. We really don't want to have to blow the entire cache away if the
     power goes out or the cache isn't laid to rest correctly.

It may end up being necessary to have a parallel to fs/direct-io.c for doing
I/O asynchronously to/from kernel pages.

Also, fs/direct-io.c seems to assume the filesystem on which it's running uses
buffer_heads - but not all of them do.

David


diff -uNr linux-2.6.12-rc2-mm1/fs/direct-io.c linux-2.6.12-rc2-mm1-cachefs/fs/direct-io.c
--- linux-2.6.12-rc2-mm1/fs/direct-io.c	2005-04-06 13:48:23.000000000 +0100
+++ linux-2.6.12-rc2-mm1-cachefs/fs/direct-io.c	2005-04-08 10:34:36.778872220 +0100
@@ -790,7 +790,7 @@
 	struct page *page;
 	unsigned block_in_page;
 	struct buffer_head *map_bh = &dio->map_bh;
-	int ret = 0;
+	int ret = 0, sent = 0;
 
 	/* The I/O can start at any block offset within the first page */
 	block_in_page = dio->first_block_in_page;
@@ -861,6 +861,14 @@
 					page_cache_release(page);
 					return -ENOTBLK;
 				}
+				else if (dio->iocb->ki_filp->f_flags &
+					 O_NOREADHOLE
+					 ) {
+					page_cache_release(page);
+					if (sent)
+						return 0;
+					return -ENODATA;
+				}
 
 				if (dio->block_in_file >=
 					i_size_read(dio->inode)>>blkbits) {
@@ -907,6 +915,7 @@
 				page_cache_release(page);
 				goto out;
 			}
+			sent = 1;
 			dio->next_block_for_io += this_chunk_blocks;
 
 			dio->block_in_file += this_chunk_blocks;
diff -uNr linux-2.6.12-rc2-mm1/include/asm-i386/fcntl.h linux-2.6.12-rc2-mm1-cachefs/include/asm-i386/fcntl.h
--- linux-2.6.12-rc2-mm1/include/asm-i386/fcntl.h	2004-09-16 12:06:17.000000000 +0100
+++ linux-2.6.12-rc2-mm1-cachefs/include/asm-i386/fcntl.h	2005-04-07 15:46:30.000000000 +0100
@@ -21,6 +21,7 @@
 #define O_DIRECTORY	0200000	/* must be a directory */
 #define O_NOFOLLOW	0400000 /* don't follow links */
 #define O_NOATIME	01000000
+#define O_NOREADHOLE	02000000 /* give short read or ENODATA on a hole */
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
