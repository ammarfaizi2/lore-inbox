Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbTLCXMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 18:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTLCXMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 18:12:14 -0500
Received: from citi.umich.edu ([141.211.133.111]:53309 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S262315AbTLCXKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 18:10:34 -0500
Date: Wed, 3 Dec 2003 18:10:31 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4 read ahead never reads the last page in a file
Message-ID: <Pine.BSO.4.33.0312031800270.24127-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi marcelo-

i posted this a while back on fsdevel for comments, but never heard
anything.  i'd like this patch to be included in 2.4.24, as it improves
NFS client read performance by a significant margin, and doesn't appear to
have any negative impact (see fsdevel archives for benchmarks).  this is
against 2.4.23.

generic_file_readahead never reads the last page of a file.  this means
the last page is always read synchronously by do_generic_file_read.
normally this is not an issue, as most local disk reads are fast.
however, this means that the NFS client is never given the opportunity to
coalesce the last page of a file, which must be read in a separate
synchronous read operation.

this is especially honerous if the network round trip time is long, and/or
the workload consists of reading many uncached small files.

i also explored changing the way that generic_file_readahead computes the
index of the last page of the file.  the fix below appears to be the best
solution.



diff -X /home/cel/src/linux/dont-diff -Naurp 00-stock/mm/filemap.c 01-readahead1/mm/filemap.c
--- 00-stock/mm/filemap.c	2003-11-28 13:26:21.000000000 -0500
+++ 01-readahead1/mm/filemap.c	2003-12-03 16:46:11.000000000 -0500
@@ -1299,11 +1299,14 @@ static void generic_file_readahead(int r
  */
 	ahead = 0;
 	while (ahead < max_ahead) {
-		ahead ++;
-		if ((raend + ahead) >= end_index)
+		unsigned long ra_index = raend + ahead + 1;
+
+		if (ra_index > end_index)
 			break;
-		if (page_cache_read(filp, raend + ahead) < 0)
+		if (page_cache_read(filp, ra_index) < 0)
 			break;
+
+		ahead++;
 	}
 /*
  * If we tried to read ahead some pages,

	- Chuck Lever
--
corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

