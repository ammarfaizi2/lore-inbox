Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129443AbRCHS0Z>; Thu, 8 Mar 2001 13:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRCHS0Q>; Thu, 8 Mar 2001 13:26:16 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:31576 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129443AbRCHS0D>; Thu, 8 Mar 2001 13:26:03 -0500
Date: Thu, 8 Mar 2001 12:25:36 -0600
From: Philipp Rumpf <prumpf@mandrakesoft.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: riel@conectiva.com.br, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ramdisk/VM fix
Message-ID: <20010308122536.F4306@mandrakesoft.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the current rd.c code, we can get into a situation where there is
a buffer-only page for data which is also in a page cache page with
page->buffers != NULL.  The current vmscan.c code never frees the page
cache page in this scenario, effectively doubling ramdisk memory
requirements.

Linus, I think this is a bugfix (tested against -ac kernels):

diff -ur linux/include/linux/swap.h linux-prumpf/include/linux/swap.h
--- linux/include/linux/swap.h	Thu Mar  8 10:01:30 2001
+++ linux-prumpf/include/linux/swap.h	Thu Mar  8 10:14:12 2001
@@ -284,7 +284,7 @@
 #endif
 
 #define page_ramdisk(page) \
-	(page->buffers && (MAJOR(page->buffers->b_dev) == RAMDISK_MAJOR))
+	(page->buffers && (MAJOR(page->buffers->b_dev) == RAMDISK_MAJOR) && buffer_protected(page->buffers))
 
 extern spinlock_t swaplock;
 

I don't think I'm missing anything important ...
