Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUHBTGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUHBTGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbUHBTGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 15:06:14 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:9191 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262006AbUHBTGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 15:06:07 -0400
Subject: [PATCH] 2.6.8-rc2-mm1 dio cleanup
From: Badari Pulavarty <pbadari@us.ibm.com>
To: andrew@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-gTE4dmpDkSqeMOVWORuU"
Organization: 
Message-Id: <1091473736.3641.166.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Aug 2004 15:08:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gTE4dmpDkSqeMOVWORuU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

I noticed this while testing DIO code on 2.6.8-rc2-mm1.

dio_pages_in_io represents the approximate IO size. We
use this to allocate bio vector. In most common cases
(where buffer is page aligned and size is multiple of pages)
we end up asking for more vectors than what we need. This
sometimes causes allocations from next biovec-pool, there
by wasting memory.

Here is the patch to fix the common case.

Thanks,
Badari



--=-gTE4dmpDkSqeMOVWORuU
Content-Disposition: attachment; filename=dio_fix.patch
Content-Type: text/plain; name=dio_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux.org/fs/direct-io.c	2004-07-30 16:25:10.000000000 -0700
+++ linux/fs/direct-io.c	2004-08-02 10:45:56.000000000 -0700
@@ -954,8 +954,16 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->waiter = NULL;
 
 	dio->pages_in_io = 0;
-	for (seg = 0; seg < nr_segs; seg++) 
-		dio->pages_in_io += (iov[seg].iov_len >> blkbits) + 2; 
+	for (seg = 0; seg < nr_segs; seg++) { 
+		dio->pages_in_io += (iov[seg].iov_len >> blkbits); 
+		/* 
+		 * if address is not page aligned or io-size is not
+		 * page multiple, increase pages_in_io by 2.
+		 */
+		if (((unsigned long)iov[seg].iov_base & ~PAGE_MASK) ||
+			((unsigned long)iov[seg].iov_len & ~PAGE_MASK)) 
+			dio->pages_in_io += 2;
+	}
 
 	for (seg = 0; seg < nr_segs; seg++) {
 		user_addr = (unsigned long)iov[seg].iov_base;

--=-gTE4dmpDkSqeMOVWORuU--

