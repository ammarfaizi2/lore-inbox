Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUAMKMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 05:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbUAMKLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 05:11:46 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:50324 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S263823AbUAMKLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 05:11:36 -0500
Date: Tue, 13 Jan 2004 11:11:34 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: SOLVED: Performance drop 2.6.0-test7 -> 2.6.1-rc2
Message-ID: <20040113111133.A17239@fi.muni.cz>
References: <20040107102521.E12316@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040107102521.E12316@fi.muni.cz>; from kas@informatics.muni.cz on Wed, Jan 07, 2004 at 10:25:21AM +0100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: 	Yesterday I have upgraded the kernel on my FTP server to 2.6.1-rc2
: (from 2.6.0-test7) and today I have found the server struggling under
: load average of 40+ and the system was barely usable. The main load on the
: server is ProFTPd serving mainly ISO 9660 images using sendfile().

	For archives: Andrew Morton suggested to apply the following patch
to mm/filemap.c (which in fact reverts part of the patch-2.6.1), and this
solved the problem (bigger-than-needed read ahead when doing sendfile()
of large files). 2.6.1 with this patch works for me now. Thanks!

-Yenya

diff -puN mm/filemap.c~readahead-partial-backout mm/filemap.c
--- 25/mm/filemap.c~readahead-partial-backout	2004-01-09 22:19:32.000000000 -0800
+++ 25-akpm/mm/filemap.c	2004-01-09 22:19:32.000000000 -0800
@@ -587,22 +587,13 @@ void do_generic_mapping_read(struct addr
 			     read_actor_t actor)
 {
 	struct inode *inode = mapping->host;
-	unsigned long index, offset, last;
+	unsigned long index, offset;
 	struct page *cached_page;
 	int error;
 
 	cached_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	offset = *ppos & ~PAGE_CACHE_MASK;
-	last = (*ppos + desc->count) >> PAGE_CACHE_SHIFT;
-
-	/*
-	 * Let the readahead logic know upfront about all
-	 * the pages we'll need to satisfy this request
-	 */
-	for (; index < last; index++)
-		page_cache_readahead(mapping, ra, filp, index);
-	index = *ppos >> PAGE_CACHE_SHIFT;
 
 	for (;;) {
 		struct page *page;
@@ -621,6 +612,7 @@ void do_generic_mapping_read(struct addr
 		}
 
 		cond_resched();
+		page_cache_readahead(mapping, ra, filp, index);
 
 		nr = nr - offset;
 find_page:

_

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|  I actually have a lot of admiration and respect for the PATA knowledge  |
| embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
