Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267834AbUHPRvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267834AbUHPRvZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267830AbUHPRux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:50:53 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:11459 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267827AbUHPRu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:50:28 -0400
Subject: [PATCH] 2.6.8-rc4-mm1 DIO pages-in-io accounting fix
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-nwAzg3HeNuVbKOKh4C2t"
Organization: 
Message-Id: <1092678626.3641.833.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Aug 2004 13:50:26 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nwAzg3HeNuVbKOKh4C2t
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

I found one more accounting inconsistency with dio_pages_in_io.
This is a day-one bug and I started hitting it on latest -mm
due to the recent changes to dio_pages_in_io calculations to be
exact.

If the file is badly fragmented (no contiguous blocks at all),
and the user buffer is not page aligned - we need to create
IO for each disk block with 2 pages. (bio with 2 vecs).
 
dio_bio_add_page() should not decrement dio_pages_in_io for every
add page. It should only decrement, it only if its done with that
page and moving on to next page. (since dio_pages_in_io represent 
how many actual pages we are operating on). 

Here is the patch to fix this accounting. Without this patch, we
will hit BUG() in dio_new_bio() with O_DIRECT on filesystems,.

Thanks,
Badari



--=-nwAzg3HeNuVbKOKh4C2t
Content-Disposition: attachment; filename=dio_inio.patch
Content-Type: text/plain; name=dio_inio.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux.org/fs/direct-io.c	2004-08-16 10:57:33.112528208 -0700
+++ linux-2.6.8-rc4-mm1/fs/direct-io.c	2004-08-16 10:59:10.668697416 -0700
@@ -561,7 +561,11 @@ static int dio_bio_add_page(struct dio *
 	ret = bio_add_page(dio->bio, dio->cur_page,
 			dio->cur_page_len, dio->cur_page_offset);
 	if (ret == dio->cur_page_len) {
-		dio->pages_in_io--;
+		/*
+		 * Decrement count only, if we are done with this page
+		 */
+		if ((dio->cur_page_len + dio->cur_page_offset) == PAGE_SIZE)
+			dio->pages_in_io--;
 		page_cache_get(dio->cur_page);
 		dio->final_block_in_bio = dio->cur_page_block +
 			(dio->cur_page_len >> dio->blkbits);

--=-nwAzg3HeNuVbKOKh4C2t--

