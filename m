Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVKFI0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVKFI0D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVKFI0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:26:01 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:18573 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932329AbVKFIZ6 (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:25:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=tSLng8Cybe2DLp51oxwVU8HCPUpFZ2hQ+Z6/J3itAdJUlNQOX1VDvxfMAoQo5gy5Q/KbGat3NC/c+ILIp4Qx30VmlYjY7TawEJ74l84r2GYzgBwtn8t/pghFGAdNYhYNyIjfiLINd5w1IHYf1t8hvjpaDR4+iesfp8UwL/cKQME=  ;
Message-ID: <436DBE98.7070003@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:28:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 14/14] mm: page_alloc cleanups
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au> <436DBD11.8010600@yahoo.com.au> <436DBD31.8060801@yahoo.com.au> <436DBD82.2070500@yahoo.com.au> <436DBDA9.2040908@yahoo.com.au> <436DBDC8.5090308@yahoo.com.au> <436DBDE5.2010405@yahoo.com.au> <436DBE03.90009@yahoo.com.au> <436DBE26.5080504@yahoo.com.au> <436DBE43.1080405@yahoo.com.au> <436DBE5E.2060509@yahoo.com.au> <436DBE78.3060405@yahoo.com.au>
In-Reply-To: <436DBE78.3060405@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090409000102090102050709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090409000102090102050709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

14/14

-- 
SUSE Labs, Novell Inc.


--------------090409000102090102050709
Content-Type: text/plain;
 name="mm-page_alloc-cleanups.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-page_alloc-cleanups.patch"

Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -431,8 +431,7 @@ void __free_pages_ok(struct page *page, 
  *
  * -- wli
  */
-static inline struct page *
-expand(struct zone *zone, struct page *page,
+static inline void expand(struct zone *zone, struct page *page,
  	int low, int high, struct free_area *area)
 {
 	unsigned long size = 1 << high;
@@ -446,7 +445,6 @@ expand(struct zone *zone, struct page *p
 		area->nr_free++;
 		set_page_order(&page[size], high);
 	}
-	return page;
 }
 
 /*
@@ -498,7 +496,8 @@ static struct page *__rmqueue(struct zon
 		rmv_page_order(page);
 		area->nr_free--;
 		zone->free_pages -= 1UL << order;
-		return expand(zone, page, order, current_order, area);
+		expand(zone, page, order, current_order, area);
+		return page;
 	}
 
 	return NULL;
@@ -513,19 +512,16 @@ static int rmqueue_bulk(struct zone *zon
 			unsigned long count, struct list_head *list)
 {
 	int i;
-	int allocated = 0;
-	struct page *page;
 	
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order);
-		if (page == NULL)
+		struct page *page = __rmqueue(zone, order);
+		if (unlikely(page == NULL))
 			break;
-		allocated++;
 		list_add_tail(&page->lru, list);
 	}
 	spin_unlock(&zone->lock);
-	return allocated;
+	return i;
 }
 
 #ifdef CONFIG_NUMA

--------------090409000102090102050709--
Send instant messages to your online friends http://au.messenger.yahoo.com 
