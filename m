Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVKFIT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVKFIT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 03:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVKFIT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 03:19:29 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:42346 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932299AbVKFIT2 (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 6 Nov 2005 03:19:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:Subject:References:In-Reply-To:Content-Type;
  b=OyV6Ou6w6ebyUVWVbq7EBrddB7/ThlQwINGTGfzd0hUrhU82W0cLUkV1sD5ygJTWgqCJk5dm43P/3wIO4QSFl1+KWE05WJ+/RiJZNG1QWUYgFWHMLaMHMr6vb/KaQWO1umU0Y/PsoGXMq35vi2/GQ4C2jWF+uxTu15WvnEj3Ks8=  ;
Message-ID: <436DBD11.8010600@yahoo.com.au>
Date: Sun, 06 Nov 2005 19:21:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: [patch 3/14] mm: release opt
References: <436DBAC3.7090902@yahoo.com.au> <436DBCBC.5000906@yahoo.com.au> <436DBCE2.4050502@yahoo.com.au>
In-Reply-To: <436DBCE2.4050502@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------030300080902090305070503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030300080902090305070503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

3/14

-- 
SUSE Labs, Novell Inc.


--------------030300080902090305070503
Content-Type: text/plain;
 name="mm-release-opt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-release-opt.patch"

Optimise some pagevec functions by not reenabling irqs while
switching lru locks.

Index: linux-2.6/mm/swap.c
===================================================================
--- linux-2.6.orig/mm/swap.c
+++ linux-2.6/mm/swap.c
@@ -220,10 +220,13 @@ void release_pages(struct page **pages, 
 
 		pagezone = page_zone(page);
 		if (pagezone != zone) {
-			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+			spin_lock_prefetch(&pagezone->lru_lock);
+			if (!zone)
+				local_irq_disable();
+			else
+				spin_unlock(&zone->lru_lock);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			spin_lock(&zone->lru_lock);
 		}
 		if (TestClearPageLRU(page))
 			del_page_from_lru(zone, page);
@@ -297,10 +300,12 @@ void __pagevec_lru_add(struct pagevec *p
 		struct zone *pagezone = page_zone(page);
 
 		if (pagezone != zone) {
+			if (!zone)
+				local_irq_disable();
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				spin_unlock(&zone->lru_lock);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			spin_lock(&zone->lru_lock);
 		}
 		if (TestSetPageLRU(page))
 			BUG();
@@ -324,10 +329,12 @@ void __pagevec_lru_add_active(struct pag
 		struct zone *pagezone = page_zone(page);
 
 		if (pagezone != zone) {
+			if (!zone)
+				local_irq_disable();
 			if (zone)
-				spin_unlock_irq(&zone->lru_lock);
+				spin_unlock(&zone->lru_lock);
 			zone = pagezone;
-			spin_lock_irq(&zone->lru_lock);
+			spin_lock(&zone->lru_lock);
 		}
 		if (TestSetPageLRU(page))
 			BUG();

--------------030300080902090305070503--
Send instant messages to your online friends http://au.messenger.yahoo.com 
