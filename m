Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269179AbUIRKxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269179AbUIRKxN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 06:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUIRKxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 06:53:13 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:56202 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269179AbUIRKxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 06:53:08 -0400
Message-ID: <414C1390.6050802@yahoo.com.au>
Date: Sat, 18 Sep 2004 20:53:04 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix missing unlock_page in mm/rmap.c
Content-Type: multipart/mixed;
 boundary="------------050509070006010004010504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050509070006010004010504
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Please apply.

--------------050509070006010004010504
Content-Type: text/x-patch;
 name="mm-rmap-missing-unlock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-rmap-missing-unlock.patch"



A required unlock_page will be missed in a very rare (but possible) race
condition. Acked by Hugh, who says:

	It'll be hard to hit because of the additional page_mapped test above,
	with truncate unmapping ptes from mms before it advances to removing
	pages from cache; but nothing to prevent it happening.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>
Signed-off-by: Hugh Dickins <hugh@veritas.com>



---

 linux-2.6-npiggin/mm/rmap.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN mm/rmap.c~mm-rmap-missing-unlock mm/rmap.c
--- linux-2.6/mm/rmap.c~mm-rmap-missing-unlock	2004-09-18 20:46:16.000000000 +1000
+++ linux-2.6-npiggin/mm/rmap.c	2004-09-18 20:46:41.000000000 +1000
@@ -406,8 +406,9 @@ int page_referenced(struct page *page, i
 			referenced += page_referenced_file(page);
 		else if (TestSetPageLocked(page))
 			referenced++;
-		else if (page->mapping) {
-			referenced += page_referenced_file(page);
+		else {
+			if (page->mapping)
+				referenced += page_referenced_file(page);
 			unlock_page(page);
 		}
 	}

_

--------------050509070006010004010504--
