Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWF0UVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWF0UVI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWF0UVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:21:07 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:27777 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1030331AbWF0UVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:21:01 -0400
Message-Id: <20060627201837.477852000@sous-sol.org>
References: <20060627200745.771284000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 27 Jun 2006 00:00:25 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, neilb@suse.de, schwidefsky@de.ibm.com,
       vs@namesys.com
Subject: [PATCH 25/25] generic_file_buffered_write(): deadlock on vectored write
Content-Disposition: inline; filename=generic_file_buffered_write-deadlock-on-vectored-write.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Vladimir V. Saveliev <vs@namesys.com>

generic_file_buffered_write() prefaults in user pages in order to avoid
deadlock on copying from the same page as write goes to.

However, it looks like there is a problem when write is vectored:
fault_in_pages_readable brings in current segment or its part (maxlen). 
OTOH, filemap_copy_from_user_iovec is called to copy number of bytes
(bytes) which may exceed current segment, so filemap_copy_from_user_iovec
switches to the next segment which is not brought in yet.  Pagefault is
generated.  That causes the deadlock if pagefault is for the same page
write goes to: page being written is locked and not uptodate, pagefault
will deadlock trying to lock locked page.

[akpm@osdl.org: somewhat rewritten]
Cc: Neil Brown <neilb@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 mm/filemap.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- linux-2.6.17.1.orig/mm/filemap.c
+++ linux-2.6.17.1/mm/filemap.c
@@ -2004,14 +2004,21 @@ generic_file_buffered_write(struct kiocb
 	do {
 		unsigned long index;
 		unsigned long offset;
-		unsigned long maxlen;
 		size_t copied;
 
 		offset = (pos & (PAGE_CACHE_SIZE -1)); /* Within page */
 		index = pos >> PAGE_CACHE_SHIFT;
 		bytes = PAGE_CACHE_SIZE - offset;
-		if (bytes > count)
-			bytes = count;
+
+		/* Limit the size of the copy to the caller's write size */
+		bytes = min(bytes, count);
+
+		/*
+		 * Limit the size of the copy to that of the current segment,
+		 * because fault_in_pages_readable() doesn't know how to walk
+		 * segments.
+		 */
+		bytes = min(bytes, cur_iov->iov_len - iov_base);
 
 		/*
 		 * Bring in the user page that we will copy from _first_.
@@ -2019,10 +2026,7 @@ generic_file_buffered_write(struct kiocb
 		 * same page as we're writing to, without it being marked
 		 * up-to-date.
 		 */
-		maxlen = cur_iov->iov_len - iov_base;
-		if (maxlen > bytes)
-			maxlen = bytes;
-		fault_in_pages_readable(buf, maxlen);
+		fault_in_pages_readable(buf, bytes);
 
 		page = __grab_cache_page(mapping,index,&cached_page,&lru_pvec);
 		if (!page) {

--
