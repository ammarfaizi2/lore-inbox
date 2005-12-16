Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVLPMsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVLPMsA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVLPMru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:47:50 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:38287 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932261AbVLPMr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:47:27 -0500
Message-Id: <20051216131048.397266000@localhost.localdomain>
References: <20051216130738.300284000@localhost.localdomain>
Date: Fri, 16 Dec 2005 21:07:49 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: [PATCH 11/12] readahead: nfsd support
Content-Disposition: inline; filename=readahead-nfsd-support.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- disable nfsd raparms: the new logic do not rely on it
- disable look-ahead on start of file: leave it to the client

For the case of NFS service, the new read-ahead logic
+ can handle disordered nfsd requests
+ can handle concurrent sequential requests on large files
  with the help of look-ahead
- will have much ado about the concurrent ones on small files

------------------------------------------------------------------------
Notes about the concurrent nfsd requests issue:

nfsd read requests can be out of order, concurrent and with no ra-state info.
They are handled by the context based read-ahead method, which does the job
in the following steps:

1. scan in page cache
2. make read-ahead decisions
3. alloc new pages
4. insert new pages to page cache

A single read-ahead chunk in the client side will be dissembled and serviced
by many concurrent nfsd in the server side. It is highly possible for two or
more of these parallel nfsd instances to be in step 1/2/3 at the same time.
Without knowing others working on the same file region, they will issue
overlaped read-ahead requests, which lead to many conflicts at step 4.

There's no much luck to eliminate the concurrent problem in general and
efficient ways. But for small to medium NFS servers where the bottleneck
lies in storage devices, here is a performance tip:

# for pid in `pidof nfsd`; do taskset -p 1 $pid; done

This command effectively serializes all nfsd requests. It would be nice if
someone can code this serialization on a per-file basis.

------------------------------------------------------------------------
Here is some test output(8 nfsd; local mount with tcp,rsize=8192):

SERIALIZED, SMALL FILES
=======================
readahead_ratio = 0, ra_max = 128kb (old logic, the ra_max is really not relavant)
96.51s real  11.32s system  3.27s user  160334+2829 cs  diff -r $NFSDIR $NFSDIR2
readahead_ratio = 70, ra_max = 1024kb (new read-ahead logic)
94.88s real  11.53s system  3.20s user  152415+3777 cs  diff -r $NFSDIR $NFSDIR2

PARALLEL, SMALL FILES
=====================
readahead_ratio = 0, ra_max = 128kb
99.87s real  11.41s system  3.15s user  173945+9163 cs  diff -r $NFSDIR $NFSDIR2
readahead_ratio = 70, ra_max = 1024kb
100.14s real  12.06s system  3.16s user  170865+13406 cs  diff -r $NFSDIR $NFSDIR2

SERIALIZED, BIG FILES
=====================
readahead_ratio = 0, ra_max = 128kb
56.52s real  3.38s system  1.23s user  47930+5256 cs  diff $NFSFILE $NFSFILE2
readahead_ratio = 70, ra_max = 1024kb
32.54s real  5.71s system  1.38s user  23851+17007 cs  diff $NFSFILE $NFSFILE2

PARALLEL, BIG FILES
===================
readahead_ratio = 0, ra_max = 128kb
63.35s real  5.68s system  1.57s user  82594+48747 cs  diff $NFSFILE $NFSFILE2
readahead_ratio = 70, ra_max = 1024kb
33.87s real  10.17s system  1.55s user  72291+100079 cs  diff $NFSFILE $NFSFILE2

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 fs/nfsd/vfs.c      |    6 +++++-
 include/linux/fs.h |    1 +
 mm/readahead.c     |   11 +++++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

--- linux.orig/fs/nfsd/vfs.c
+++ linux/fs/nfsd/vfs.c
@@ -832,10 +832,14 @@ nfsd_vfs_read(struct svc_rqst *rqstp, st
 #endif
 
 	/* Get readahead parameters */
-	ra = nfsd_get_raparms(inode->i_sb->s_dev, inode->i_ino);
+	if (prefer_adaptive_readahead())
+		ra = NULL;
+	else
+		ra = nfsd_get_raparms(inode->i_sb->s_dev, inode->i_ino);
 
 	if (ra && ra->p_set)
 		file->f_ra = ra->p_ra;
+	file->f_ra.flags |= RA_FLAG_NFSD;
 
 	if (file->f_op->sendfile) {
 		svc_pushback_unused_pages(rqstp);
--- linux.orig/include/linux/fs.h
+++ linux/include/linux/fs.h
@@ -632,6 +632,7 @@ struct file_ra_state {
 #define RA_FLAG_INCACHE 0x02	/* file is already in cache */
 #define RA_FLAG_MMAP		(1UL<<31)	/* mmaped page access */
 #define RA_FLAG_NO_LOOKAHEAD	(1UL<<30)	/* disable look-ahead */
+#define RA_FLAG_NFSD		(1UL<<29)	/* request from nfsd */
 
 struct file {
 	/*
--- linux.orig/mm/readahead.c
+++ linux/mm/readahead.c
@@ -15,11 +15,13 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 #include <linux/writeback.h>
+#include <linux/nfsd/const.h>
 
 /* The default max/min read-ahead pages. */
 #define KB(size)	(((size)*1024 + PAGE_CACHE_SIZE-1) / PAGE_CACHE_SIZE)
 #define MAX_RA_PAGES	KB(VM_MAX_READAHEAD)
 #define MIN_RA_PAGES	KB(VM_MIN_READAHEAD)
+#define MIN_NFSD_PAGES	KB(NFSSVC_MAXBLKSIZE/1024)
 
 /* In laptop mode, poll delayed look-ahead on every ## pages read. */
 #define LAPTOP_POLL_INTERVAL 16
@@ -1791,8 +1793,13 @@ newfile_readahead(struct address_space *
 	if (req_size > ra_min)
 		req_size = ra_min;
 
-	ra_size = 4 * req_size;
-	la_size = 2 * req_size;
+	if (unlikely(ra->flags & RA_FLAG_NFSD)) {
+		ra_size = MIN_NFSD_PAGES;
+		la_size = 0;
+	} else {
+		ra_size = 4 * req_size;
+		la_size = 2 * req_size;
+	}
 
 	ra_set_class(ra, RA_CLASS_NEWFILE);
 	ra_set_index(ra, 0, 0);

--
