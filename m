Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266925AbUH1PYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266925AbUH1PYC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUH1PYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:24:01 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:21138 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266925AbUH1PW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:22:57 -0400
Date: Sat, 28 Aug 2004 16:22:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Sid Boyce <sboyce@blueyonder.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: RE: 2.6.9-rc1-mm1
In-Reply-To: <4130933D.5060007@blueyonder.co.uk>
Message-ID: <Pine.LNX.4.44.0408281617290.2111-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004, Sid Boyce wrote:
> I get hangs with 2.6.9-rc1-mm1 if ACPI or APM are enabled. I haven't 
> tried console=ttyS1 to see if there is an oops, but from previous 
> experiences also posted, they are probably being generated.

I don't know.

> One other problem is that trying to rebuild a 2.6.9-rc1-mm1 kernel under 
> 2.6.9-rc1-mm1 fails, once as shown below and once elsewhere in fs/. I 
> have to boot 2.6.8-rc4-mm1 in order to build 2.6.9-rc1-mm1. Asus A7N8X-E 
> nForce2 chipset, Version: ASUS A7N8X-E Deluxe ACPI BIOS Rev 1011, SuSE 
> 9.1. Upgrading to 1012 shortly.
> fs/.tmp_open.o: could not read symbols: File truncated
> make[1]: *** [fs/open.o] Error 1
> make: *** [fs] Error 2
> barrabas:/usr/src/linux-2.6.9-rc1-mm1 # l fs/.tmp_open.o
> -rw-r--r--  1 root root 114688 2004-08-27 01:01 fs/.tmp_open.o

You probably want the patch I posted yesterday in "data loss" thread
(expect we'll end up choosing a competing patch, but this does fine).

Hugh

--- 2.6.9-rc1-mm1/mm/filemap.c	2004-08-26 12:09:50.000000000 +0100
+++ linux/mm/filemap.c	2004-08-27 14:35:32.113359872 +0100
@@ -722,10 +722,7 @@ void do_generic_mapping_read(struct addr
 	offset = *ppos & ~PAGE_CACHE_MASK;
 
 	isize = i_size_read(inode);
-	if (!isize)
-		goto out;
-
-	end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
+	end_index = isize >> PAGE_CACHE_SHIFT;
 
 	for (;;) {
 		struct page *page;
@@ -733,6 +730,11 @@ void do_generic_mapping_read(struct addr
 
 		if (index > end_index)
 			goto out;
+		if (index == end_index) {
+			nr = isize & ~PAGE_CACHE_MASK;
+			if (nr <= offset)
+				goto out;
+		}
 
 		cond_resched();
 		page_cache_readahead(mapping, &ra, filp, index);
@@ -831,8 +833,8 @@ readpage:
 		 * another truncate extends the file - this is desired though).
 		 */
 		isize = i_size_read(inode);
-		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
-		if (unlikely(!isize || index > end_index)) {
+		end_index = isize >> PAGE_CACHE_SHIFT;
+		if (unlikely(index > end_index)) {
 			page_cache_release(page);
 			goto out;
 		}

