Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSFQHVl>; Mon, 17 Jun 2002 03:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSFQHUE>; Mon, 17 Jun 2002 03:20:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28430 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316798AbSFQGtS>;
	Mon, 17 Jun 2002 02:49:18 -0400
Message-ID: <3D0D875E.85A7B886@zip.com.au>
Date: Sun, 16 Jun 2002 23:53:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 14/19] remove set_page_buffers() and clear_page_buffers()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The set_page_buffers() and clear_page_buffers() macros are each used in
only one place.  Fold them into their callers.



--- 2.5.22/include/linux/buffer_head.h~move-set_page_buffers	Sun Jun 16 23:12:51 2002
+++ 2.5.22-akpm/include/linux/buffer_head.h	Sun Jun 16 23:22:44 2002
@@ -117,16 +117,6 @@ BUFFER_FNS(Boundary, boundary)
 		((struct buffer_head *)(page)->private);	\
 	})
 #define page_has_buffers(page)	PagePrivate(page)
-#define set_page_buffers(page, buffers)				\
-	do {							\
-		SetPagePrivate(page);				\
-		page->private = (unsigned long)buffers;		\
-	} while (0)
-#define clear_page_buffers(page)				\
-	do {							\
-		ClearPagePrivate(page);				\
-		page->private = 0;				\
-	} while (0)
 
 #define invalidate_buffers(dev)	__invalidate_buffers((dev), 0)
 #define destroy_buffers(dev)	__invalidate_buffers((dev), 1)
--- 2.5.22/fs/buffer.c~move-set_page_buffers	Sun Jun 16 23:12:51 2002
+++ 2.5.22-akpm/fs/buffer.c	Sun Jun 16 23:22:44 2002
@@ -152,14 +152,16 @@ __set_page_buffers(struct page *page, st
 {
 	if (page_has_buffers(page))
 		buffer_error();
-	set_page_buffers(page, head);
 	page_cache_get(page);
+	SetPagePrivate(page);
+	page->private = (unsigned long)head;
 }
 
 static inline void
 __clear_page_buffers(struct page *page)
 {
-	clear_page_buffers(page);
+	ClearPagePrivate(page);
+	page->private = 0;
 	page_cache_release(page);
 }
 

-
