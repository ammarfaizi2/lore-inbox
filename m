Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUCEIRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 03:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbUCEIRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 03:17:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:53433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262238AbUCEIR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 03:17:28 -0500
Date: Fri, 5 Mar 2004 00:17:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Race in nobh_prepare_write
Message-Id: <20040305001748.60172d3c.akpm@osdl.org>
In-Reply-To: <1078413178.9164.24.camel@shaggy.austin.ibm.com>
References: <1078413178.9164.24.camel@shaggy.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> wrote:
>
> I discovered a race betwen nobh_prepare_write and end_buffer_read_sync. 

Having looked at this a little more, I don't really like the dropping of
the bh refcount in end_buffer_read_sync() prior to unlocking the buffer.

I don't see any problem with it per-se because of the behaviour of
try_to_free_buffers(), and the fact that the page lock totally protects the
buffer ring.  But it is, I think, cleaner and more future-safe to give
nobh_prepare_write() a custom end_io handler.

This passes decent testing on 1k blocksize ext2.


 fs/buffer.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 39 insertions(+), 4 deletions(-)

diff -puN fs/buffer.c~nobh_prepare_write-race-fix-2 fs/buffer.c
--- 25/fs/buffer.c~nobh_prepare_write-race-fix-2	2004-03-04 23:11:33.000000000 -0800
+++ 25-akpm/fs/buffer.c	2004-03-04 23:12:14.000000000 -0800
@@ -2321,6 +2321,28 @@ int generic_commit_write(struct file *fi
 	return 0;
 }
 
+
+/*
+ * nobh_prepare_write()'s prereads are special: the buffer_heads are freed
+ * immediately, while under the page lock.  So it needs a special end_io
+ * handler which does not touch the bh after unlocking it.
+ *
+ * Note: unlock_buffer() sort-of does touch the bh after unlocking it, but
+ * a race there is benign: unlock_buffer() only use the bh's address for
+ * hashing after unlocking the buffer, so it doesn't actually touch the bh
+ * itself.
+ */
+static void end_buffer_read_nobh(struct buffer_head *bh, int uptodate)
+{
+	if (uptodate) {
+		set_buffer_uptodate(bh);
+	} else {
+		/* This happens, due to failed READA attempts. */
+		clear_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
+}
+
 /*
  * On entry, the page is fully not uptodate.
  * On exit the page is fully uptodate in the areas outside (from,to)
@@ -2412,12 +2434,25 @@ int nobh_prepare_write(struct page *page
 	}
 
 	if (nr_reads) {
-		ll_rw_block(READ, nr_reads, read_bh);
+		struct buffer_head *bh;
+
+		/*
+		 * The page is locked, so these buffers are protected from
+		 * any VM or truncate activity.  Hence we don't need to care
+		 * for the buffer_head refcounts.
+		 */
 		for (i = 0; i < nr_reads; i++) {
-			wait_on_buffer(read_bh[i]);
-			if (!buffer_uptodate(read_bh[i]))
+			bh = read_bh[i];
+			lock_buffer(bh);
+			bh->b_end_io = end_buffer_read_nobh;
+			submit_bh(READ, bh);
+		}
+		for (i = 0; i < nr_reads; i++) {
+			bh = read_bh[i];
+			wait_on_buffer(bh);
+			if (!buffer_uptodate(bh))
 				ret = -EIO;
-			free_buffer_head(read_bh[i]);
+			free_buffer_head(bh);
 			read_bh[i] = NULL;
 		}
 		if (ret)

_

