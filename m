Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265817AbUFOSTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265817AbUFOSTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 14:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbUFOSTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 14:19:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:24253 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265817AbUFOSTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 14:19:34 -0400
Subject: [PATCH 2.6.7-rc3-mm2] handle partial DIO write
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1087323566.2287.84.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jun 2004 11:19:26 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

The fsx-linux hole fill failure problem was caused by
generic_file_aio_write_nolock() not handling the partial DIO write
correctly.  Here's a patch lets DIO do the partial write, and the
fallback to buffered is done (correctly) for what is left.
This fixes the hole filling without retrying the entire i/o.
This patch also applies to 2.6.7-rc3 with some offset.

I tested this (on ext3) with 
fsx-linux -l 500000 -r 4096 -t 4096 -w 4096 -Z -N 10000 junk  -R -W

Daniel

diff -rup linux-2.6.7-rc3-mm2.orig/fs/direct-io.c linux-2.6.7-rc3-mm2/fs/direct-io.c
--- linux-2.6.7-rc3-mm2.orig/fs/direct-io.c	2004-06-15 10:38:54.588122820 -0700
+++ linux-2.6.7-rc3-mm2/fs/direct-io.c	2004-06-15 10:43:45.803731414 -0700
@@ -990,6 +990,13 @@ direct_io_worker(int rw, struct kiocb *i
 		}
 	} /* end iovec loop */
 
+	if (ret == -ENOTBLK && rw == WRITE) {
+		/*
+		 * The remaining part of the request will be
+		 * be handled by buffered I/O when we return
+		 */
+		ret = 0;
+	}
 	/*
 	 * There may be some unwritten disk at the end of a part-written
 	 * fs-block-sized block.  Go zero that now.
@@ -1089,13 +1096,6 @@ direct_io_worker(int rw, struct kiocb *i
 			aio_complete(iocb, ret, 0);
 		kfree(dio);
 	}
-	if (ret == -ENOTBLK && rw == WRITE) {
-		/*
-		 * The entire request will be be handled by buffered I/O
-		 * when we return
-		 */
-		ret = 0;
-	}
 	return ret;
 }
 
diff -rup linux-2.6.7-rc3-mm2.orig/mm/filemap.c linux-2.6.7-rc3-mm2/mm/filemap.c
--- linux-2.6.7-rc3-mm2.orig/mm/filemap.c	2004-06-15 10:39:05.361146577 -0700
+++ linux-2.6.7-rc3-mm2/mm/filemap.c	2004-06-15 10:43:45.806730864 -0700
@@ -1915,7 +1915,7 @@ generic_file_aio_write_nolock(struct kio
 		count -= written;
 	}
 
-	buf = iov->iov_base;
+	buf = iov->iov_base + written;	/* handle partial DIO write */
 	do {
 		unsigned long index;
 		unsigned long offset;



