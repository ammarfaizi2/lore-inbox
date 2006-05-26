Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWEZLzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWEZLzx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWEZLxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:53:35 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:18395 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932455AbWEZLxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:53:13 -0400
Message-ID: <348644391.06434@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060526115316.335626686@localhost.localdomain>
References: <20060526113906.084341801@localhost.localdomain>
Date: Fri, 26 May 2006 19:39:35 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: [PATCH 29/33] readahead: nfsd case
Content-Disposition: inline; filename=readahead-nfsd-case.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bypass nfsd raparms cache -- the new logic do not rely on it.

--------------------------------
For the case of NFS service, the new read-ahead logic
+ can handle disordered nfsd requests
+ can handle concurrent sequential requests on large files
  with the help of look-ahead
- will have much ado about the concurrent ones on small files

--------------------------------
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
overlapped read-ahead requests, which lead to many conflicts at step 4.

There's no much luck to eliminate the concurrent problem in general and
efficient ways. But experiments show that mount with tcp,rsize=32768 can
cut down the overhead a lot.

--------------------------------
Here are the benchmark outputs. The test cases cover
- small/big files
- small/big rsize mount option
- serialized/parallel nfsd processing

`serialized' means running the following command to enforce serialized
nfsd requests processing:

# for pid in `pidof nfsd`; do taskset -p 1 $pid; done

8 nfsd; local mount with tcp,rsize=8192
=======================================

SERIALIZED, SMALL FILES
readahead_ratio = 0, ra_max = 128kb (old logic, the ra_max is not quite relevant)
96.51s real  11.32s system  3.27s user  160334+2829 cs  diff -r $NFSDIR $NFSDIR2
readahead_ratio = 70, ra_max = 1024kb (new read-ahead logic)
94.88s real  11.53s system  3.20s user  152415+3777 cs  diff -r $NFSDIR $NFSDIR2

SERIALIZED, BIG FILES
readahead_ratio = 0, ra_max = 128kb
56.52s real  3.38s system  1.23s user  47930+5256 cs  diff $NFSFILE $NFSFILE2
readahead_ratio = 70, ra_max = 1024kb
32.54s real  5.71s system  1.38s user  23851+17007 cs  diff $NFSFILE $NFSFILE2

PARALLEL, SMALL FILES
readahead_ratio = 0, ra_max = 128kb
99.87s real  11.41s system  3.15s user  173945+9163 cs  diff -r $NFSDIR $NFSDIR2
readahead_ratio = 70, ra_max = 1024kb
100.14s real  12.06s system  3.16s user  170865+13406 cs  diff -r $NFSDIR $NFSDIR2

PARALLEL, BIG FILES
readahead_ratio = 0, ra_max = 128kb
63.35s real  5.68s system  1.57s user  82594+48747 cs  diff $NFSFILE $NFSFILE2
readahead_ratio = 70, ra_max = 1024kb
33.87s real  10.17s system  1.55s user  72291+100079 cs  diff $NFSFILE $NFSFILE2

8 nfsd; local mount with tcp,rsize=32768
========================================
Note that the normal data are now much better, and come close to that of the
serialized ones.

PARALLEL/NORMAL

readahead_ratio = 8, ra_max = 1024kb (old logic)
48.36s real  2.22s system  1.51s user  7209+4110 cs  diff $NFSFILE $NFSFILE2
readahead_ratio = 70, ra_max = 1024kb (new logic)
30.04s real  2.46s system  1.33s user  5420+2492 cs  diff $NFSFILE $NFSFILE2

readahead_ratio = 8, ra_max = 1024kb
92.99s real  10.32s system  3.23s user  145004+1826 cs  diff -r $NFSDIR $NFSDIR2 > /dev/null
readahead_ratio = 70, ra_max = 1024kb
90.96s real  10.68s system  3.22s user  144414+2520 cs  diff -r $NFSDIR $NFSDIR2 > /dev/null

SERIALIZED

readahead_ratio = 8, ra_max = 1024kb
47.58s real  2.10s system  1.27s user  7933+1357 cs  diff $NFSFILE $NFSFILE2
readahead_ratio = 70, ra_max = 1024kb
29.46s real  2.41s system  1.38s user  5590+2613 cs  diff $NFSFILE $NFSFILE2

readahead_ratio = 8, ra_max = 1024kb
93.02s real  10.67s system  3.25s user  144850+2286 cs  diff -r $NFSDIR $NFSDIR2 > /dev/null
readahead_ratio = 70, ra_max = 1024kb
91.15s real  11.04s system  3.31s user  144432+2814 cs  diff -r $NFSDIR $NFSDIR2 > /dev/null

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


Greg Banks gives a valuable recommend on the test cases, which helps me to
get the more complete picture. Thanks!

 fs/nfsd/vfs.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.17-rc4-mm3.orig/fs/nfsd/vfs.c
+++ linux-2.6.17-rc4-mm3/fs/nfsd/vfs.c
@@ -829,7 +829,10 @@ nfsd_vfs_read(struct svc_rqst *rqstp, st
 #endif
 
 	/* Get readahead parameters */
-	ra = nfsd_get_raparms(inode->i_sb->s_dev, inode->i_ino);
+	if (prefer_adaptive_readahead())
+		ra = NULL;
+	else
+		ra = nfsd_get_raparms(inode->i_sb->s_dev, inode->i_ino);
 
 	if (ra && ra->p_set)
 		file->f_ra = ra->p_ra;

--
