Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbRG2KJT>; Sun, 29 Jul 2001 06:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267809AbRG2KJJ>; Sun, 29 Jul 2001 06:09:09 -0400
Received: from [195.138.130.130] ([195.138.130.130]:61197 "EHLO
	goce.pirincom.com") by vger.kernel.org with ESMTP
	id <S267815AbRG2KJB>; Sun, 29 Jul 2001 06:09:01 -0400
Message-Id: <200107291029.f6TATso13796@goce.pirincom.com>
From: velizarb@pirincom.com
Subject: [PATCH] bugfix in memory.c
To: <linux-kernel@vger.kernel.org> (Linux Kernel mailing list)
Date: Sun, 29 Jul 2001 13:10:34 +0300 (EEST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

The following is a bugfix against memory.c:lock_kiovec, 
At line 649 we have:
	if (!PageLocked(page)) {
which assumes page is the page we failed to lock, and if it is unlocked after calling
the unlock_kiovec we have a page which has been mapped twice, but page has been modified
and it doesn't contain the expected value.

Patch is against 2.4.8-pre1, Comments are welcome.

--

--- memory.c.old	Sun Jul 29 12:38:19 2001
+++ memory.c	Sun Jul 29 12:39:04 2001
@@ -619,9 +619,10 @@
 			
 			if (TryLockPage(page)) {
 				while (j--) {
-					page = *(--ppage);
-					if (page)
-						UnlockPage(page);
+					struct page *tmp;
+					tmp = *(--ppage);
+					if (tmp)
+						UnlockPage(tmp);
 				}
 				goto retry;
 			}
