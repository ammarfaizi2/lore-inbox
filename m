Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030658AbWJKGSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030658AbWJKGSA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030654AbWJKGSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:18:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53191 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030658AbWJKGR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:17:58 -0400
Date: Tue, 10 Oct 2006 23:17:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch 1/6] revert "generic_file_buffered_write(): handle zero
 length iovec segments"
Message-Id: <20061010231751.2f1cd18e.akpm@osdl.org>
In-Reply-To: <452C8613.7080708@yahoo.com.au>
References: <20061010121314.19693.75503.sendpatchset@linux.site>
	<20061010121332.19693.37204.sendpatchset@linux.site>
	<20061010221304.6bef249f.akpm@osdl.org>
	<452C8613.7080708@yahoo.com.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Revert 81b0c8713385ce1b1b9058e916edcf9561ad76d6.

This was a bugfix against 6527c2bdf1f833cc18e8f42bd97973d583e4aa83, which we
also revert.


Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/filemap.c |    9 +--------
 mm/filemap.h |    4 ++--
 2 files changed, 3 insertions(+), 10 deletions(-)

diff -puN mm/filemap.c~revert-generic_file_buffered_write-handle-zero-length-iovec-segments mm/filemap.c
--- a/mm/filemap.c~revert-generic_file_buffered_write-handle-zero-length-iovec-segments
+++ a/mm/filemap.c
@@ -2121,12 +2121,6 @@ generic_file_buffered_write(struct kiocb
 			break;
 		}
 
-		if (unlikely(bytes == 0)) {
-			status = 0;
-			copied = 0;
-			goto zero_length_segment;
-		}
-
 		status = a_ops->prepare_write(file, page, offset, offset+bytes);
 		if (unlikely(status)) {
 			loff_t isize = i_size_read(inode);
@@ -2156,8 +2150,7 @@ generic_file_buffered_write(struct kiocb
 			page_cache_release(page);
 			continue;
 		}
-zero_length_segment:
-		if (likely(copied >= 0)) {
+		if (likely(copied > 0)) {
 			if (!status)
 				status = copied;
 
diff -puN mm/filemap.h~revert-generic_file_buffered_write-handle-zero-length-iovec-segments mm/filemap.h
--- a/mm/filemap.h~revert-generic_file_buffered_write-handle-zero-length-iovec-segments
+++ a/mm/filemap.h
@@ -87,7 +87,7 @@ filemap_set_next_iovec(const struct iove
 	const struct iovec *iov = *iovp;
 	size_t base = *basep;
 
-	do {
+	while (bytes) {
 		int copy = min(bytes, iov->iov_len - base);
 
 		bytes -= copy;
@@ -96,7 +96,7 @@ filemap_set_next_iovec(const struct iove
 			iov++;
 			base = 0;
 		}
-	} while (bytes);
+	}
 	*iovp = iov;
 	*basep = base;
 }
_

