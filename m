Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316849AbSFFHDb>; Thu, 6 Jun 2002 03:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316848AbSFFHDa>; Thu, 6 Jun 2002 03:03:30 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:48114 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316880AbSFFHD3>; Thu, 6 Jun 2002 03:03:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, akpm@zip.com.au
Subject: [PATCH] Futex update III: don't use put_page...
Date: Thu, 06 Jun 2002 17:04:17 +1000
Message-Id: <E17FrJh-0003jW-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know nothing of VM, but put_page on a page on the LRU list hits a
BUG() inside __free_pages_ok().  Andrew Morton said this was right.

Name: Unpin page bug fix.
Author: Rusty Russell
Status: Tested on 2.5.20

D: This uses page_cache_release() instead of put_page(), as it might
D: be a pagecache page.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.20.1460/kernel/futex.c linux-2.5.20.1460.updated/kernel/futex.c
--- linux-2.5.20.1460/kernel/futex.c	Sat May 25 14:35:00 2002
+++ linux-2.5.20.1460.updated/kernel/futex.c	Wed Jun  5 21:24:37 2002
@@ -33,6 +33,7 @@
 #include <linux/futex.h>
 #include <linux/highmem.h>
 #include <linux/time.h>
+#include <linux/pagemap.h>
 #include <asm/uaccess.h>
 
 /* These mutexes are a very simple counter: the winner is the one who
@@ -69,6 +70,14 @@
 	return &futex_queues[hash_long(h, FUTEX_HASHBITS)];
 }
 
+static inline void unpin_page(struct page *page)
+{
+	/* Avoid releasing the page which is on the LRU list.  I don't
+           know if this is correct, but it stops the BUG() in
+           __free_pages_ok(). */
+	page_cache_release(page);
+}
+
 static int futex_wake(struct list_head *head,
 		      struct page *page,
 		      unsigned int offset,
@@ -218,7 +227,7 @@
 	default:
 		ret = -EINVAL;
 	}
-	put_page(page);
+	unpin_page(page);
 
 	return ret;
 }

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
