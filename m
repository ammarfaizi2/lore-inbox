Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751412AbWIARkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWIARkc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWIARkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:40:31 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:43183 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751303AbWIARka
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:40:30 -0400
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, sct@redhat.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <20060901101801.7845bca2.akpm@osdl.org>
References: <1157125829.30578.6.camel@dyn9047017100.beaverton.ibm.com>
	 <Pine.LNX.4.64.0609011652420.24650@hermes-2.csi.cam.ac.uk>
	 <1157128342.30578.14.camel@dyn9047017100.beaverton.ibm.com>
	 <20060901101801.7845bca2.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 10:43:45 -0700
Message-Id: <1157132625.30578.22.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 10:18 -0700, Andrew Morton wrote:
> On Fri, 01 Sep 2006 09:32:22 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
> > > > Kernel BUG at fs/buffer.c:2791
> > > > invalid opcode: 0000 [1] SMP
> > > > 
> > > > Its complaining about BUG_ON(!buffer_mapped(bh)).
> 
> I need to have a little think about this, remember what _should_ be
> happening in this situation.

Agreed. I used to run fsx on regular basis - never saw the problem
before. I will try to go back few kernel versions and verify.

> 
> We (mainly I) used to do a huge amount of fsx-linux testing on 1k blocksize
> filesystems.  We've done something to make this start happening.  Part of
> resolving this bug will be working out what that was.
> 

Here is the other fix, I did to avoid the problem (basically, have
jbd manage its own submit function and skip unmapped buffers) - not
elegant. Thats why I tried to address at the root cause..

Thanks,
Badari

Patch to fix: Kernel BUG at fs/buffer.c:2791
on 1k (2k) filesystems while running fsx.

journal_commit_transaction collects lots of dirty buffer from
and does a single ll_rw_block() to write them out. ll_rw_block()
locks the buffer and checks to see if they are dirty and submits
them for IO.

In the mean while, journal_unmap_buffers() as part of
truncate can unmap the buffer and throw it away. Since its
a 1k (2k) filesystem - each page (4k) will have more than
one buffer_head attached to the page and and we can't free 
up buffer_heads attached to the page (if we are not
invalidating the whole page).

Now, any call to set_page_dirty() (like msync_interval)
could end up setting all the buffer heads attached to
this page again dirty, including the ones those got
cleaned up :(

So, -not-so-elegant fix would be to have make jbd skip all 
the buffers that are not mapped.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
---
 fs/jbd/commit.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc5/fs/jbd/commit.c
===================================================================
--- linux-2.6.18-rc5.orig/fs/jbd/commit.c	2006-08-27 20:41:48.000000000 -0700
+++ linux-2.6.18-rc5/fs/jbd/commit.c	2006-09-01 10:36:16.000000000 -0700
@@ -160,6 +160,34 @@ static int journal_write_commit_record(j
 	return (ret == -EIO);
 }
 
+static void jbd_write_buffers(int nr, struct buffer_head *bhs[])
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		struct buffer_head *bh = bhs[i];
+
+		lock_buffer(bh);
+
+		/*
+		 * case 1: Buffer could have been flushed by now,
+		 * if so nothing to do for us.
+		 * case 2: Buffer could have been unmapped up by 
+		 * journal_unmap_buffer - but still attached to the
+		 * page. Any calls to set_page_dirty() would dirty
+		 * the buffer even though its not mapped.  If so,
+		 * we need to skip them.
+		 */
+		if (buffer_mapped(bh) && test_clear_buffer_dirty(bh)) {
+			bh->b_end_io = end_buffer_write_sync;
+			get_bh(bh);
+			submit_bh(WRITE, bh);
+			continue;
+		}
+		unlock_buffer(bh);
+	}
+}
+
 /*
  * journal_commit_transaction
  *
@@ -356,7 +384,7 @@ write_out_data:
 					jbd_debug(2, "submit %d writes\n",
 							bufs);
 					spin_unlock(&journal->j_list_lock);
-					ll_rw_block(SWRITE, bufs, wbuf);
+					jbd_write_buffer(bufs, wbuf);
 					journal_brelse_array(wbuf, bufs);
 					bufs = 0;
 					goto write_out_data;
@@ -379,7 +407,7 @@ write_out_data:
 
 	if (bufs) {
 		spin_unlock(&journal->j_list_lock);
-		ll_rw_block(SWRITE, bufs, wbuf);
+		jbd_write_buffers(bufs, wbuf);
 		journal_brelse_array(wbuf, bufs);
 		spin_lock(&journal->j_list_lock);
 	}


