Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUIXAsy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUIXAsy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267633AbUIXAsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:48:40 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:9419 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S267619AbUIXAeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:34:21 -0400
Subject: [PATCH] 2.6.9-rc2-mm1 dio fine alignment and pages in io
From: Badari Pulavarty <pbadari@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-u7lcEm+3fTPpMGutt4Cw"
Organization: 
Message-Id: <1095985718.3628.416.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Sep 2004 17:28:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u7lcEm+3fTPpMGutt4Cw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew,

Here is the fix for dio_new_bio() BUG() with fsx tests.
The problem is, I changed dio_pages_in_io calculation to
be exactly the number of pages we needed to map the user-buffer
to do the IO. But with fine-grain alignment (non fs-blocksize),
we may need 2 more pages (ZERO_PAGE) to zero out first and last
block if needed.

Here is the patch to fix the problem.

Here is the bug info.

http://bugme.osdl.org/show_bug.cgi?id=3447


Thanks,
Badari



--=-u7lcEm+3fTPpMGutt4Cw
Content-Disposition: attachment; filename=dio_finealign_pages.patch
Content-Type: text/plain; name=dio_finealign_pages.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux.org/fs/direct-io.c	2004-09-23 18:02:16.386912312 -0700
+++ linux/fs/direct-io.c	2004-09-23 18:06:51.110148032 -0700
@@ -958,7 +958,15 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->bio_list = NULL;
 	dio->waiter = NULL;
 
-	dio->pages_in_io = 0;
+	/* 
+	 * In case of non-aligned buffers, we may need 2 more
+	 * pages since we need to zero out first and last block.
+	 */	
+	if (unlikely(dio->blkfactor))
+		dio->pages_in_io = 2;
+	else
+		dio->pages_in_io = 0;
+		
 	for (seg = 0; seg < nr_segs; seg++) {
 		user_addr = (unsigned long)iov[seg].iov_base;
 		dio->pages_in_io +=

--=-u7lcEm+3fTPpMGutt4Cw--

