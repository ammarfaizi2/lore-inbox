Return-Path: <linux-kernel-owner+w=401wt.eu-S1161217AbXAMDYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbXAMDYo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 22:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161210AbXAMDYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 22:24:43 -0500
Received: from mail.suse.de ([195.135.220.2]:49525 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161204AbXAMDYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 22:24:37 -0500
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Filesystems <linux-fsdevel@vger.kernel.org>,
       Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>
Message-Id: <20070113011218.9449.4113.sendpatchset@linux.site>
In-Reply-To: <20070113011159.9449.4327.sendpatchset@linux.site>
References: <20070113011159.9449.4327.sendpatchset@linux.site>
Subject: [patch 2/10] mm: revert "generic_file_buffered_write(): handle zero length iovec segments"
Date: Sat, 13 Jan 2007 04:24:33 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

Revert 81b0c8713385ce1b1b9058e916edcf9561ad76d6.

This was a bugfix against 6527c2bdf1f833cc18e8f42bd97973d583e4aa83, which we
also revert.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/mm/filemap.c
===================================================================
--- linux-2.6.orig/mm/filemap.c
+++ linux-2.6/mm/filemap.c
@@ -1911,12 +1911,6 @@ generic_file_buffered_write(struct kiocb
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
@@ -1946,8 +1940,7 @@ generic_file_buffered_write(struct kiocb
 			page_cache_release(page);
 			continue;
 		}
-zero_length_segment:
-		if (likely(copied >= 0)) {
+		if (likely(copied > 0)) {
 			if (!status)
 				status = copied;
 
Index: linux-2.6/mm/filemap.h
===================================================================
--- linux-2.6.orig/mm/filemap.h
+++ linux-2.6/mm/filemap.h
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
