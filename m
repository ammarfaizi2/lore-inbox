Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWJKGSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWJKGSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030661AbWJKGSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:18:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55239 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030654AbWJKGSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:18:02 -0400
Date: Tue, 10 Oct 2006 23:17:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch 2/6] revert "generic_file_buffered_write(): deadlock on
 vectored write"
Message-Id: <20061010231756.16b22ce2.akpm@osdl.org>
In-Reply-To: <20061010231150.fb9e30f5.akpm@osdl.org>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
	<20061010121332.19693.37204.sendpatchset@linux.site>
	<20061010221304.6bef249f.akpm@osdl.org>
	<452C8613.7080708@yahoo.com.au>
	<20061010231150.fb9e30f5.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Revert 6527c2bdf1f833cc18e8f42bd97973d583e4aa83

This patch fixed the following bug:

  When prefaulting in the pages in generic_file_buffered_write(), we only
  faulted in the pages for the firts segment of the iovec.  If the second of
  successive segment described a mmapping of the page into which we're
  write()ing, and that page is not up-to-date, the fault handler tries to lock
  the already-locked page (to bring it up to date) and deadlocks.

  An exploit for this bug is in writev-deadlock-demo.c, in
  http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz.

  (These demos assume blocksize < PAGE_CACHE_SIZE).

The problem with this fix is that it takes the kernel back to doing a single
prepare_write()/commit_write() per iovec segment.  So in the worst case we'll
run prepare_write+commit_write 1024 times where we previously would have run
it once.

<insert numbers obtained via ext3-tools's writev-speed.c here>

And apparently this change killed NFS overwrite performance, because, I
suppose, it talks to the server for each prepare_write+commit_write.

So just back that patch out - we'll be fixing the deadlock by other means.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/filemap.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff -puN mm/filemap.c~revert-generic_file_buffered_write-deadlock-on-vectored-write mm/filemap.c
--- a/mm/filemap.c~revert-generic_file_buffered_write-deadlock-on-vectored-write
+++ a/mm/filemap.c
@@ -2091,21 +2091,14 @@ generic_file_buffered_write(struct kiocb
 	do {
 		unsigned long index;
 		unsigned long offset;
+		unsigned long maxlen;
 		size_t copied;
 
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-
-		/* Limit the size of the copy to the caller's write size */
-		bytes = min(bytes, count);
-
-		/*
-		 * Limit the size of the copy to that of the current segment,
-		 * because fault_in_pages_readable() doesn't know how to walk
-		 * segments.
-		 */
-		bytes = min(bytes, cur_iov->iov_len - iov_base);
+		if (bytes > count)
+			bytes = count;
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2113,7 +2106,10 @@ generic_file_buffered_write(struct kiocb
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		fault_in_pages_readable(buf, bytes);
+		maxlen = cur_iov->iov_len - iov_base;
+		if (maxlen > bytes)
+			maxlen = bytes;
+		fault_in_pages_readable(buf, maxlen);
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {
_

