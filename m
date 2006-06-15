Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWFOJBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWFOJBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 05:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWFOJBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 05:01:48 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:34095 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751284AbWFOJBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 05:01:48 -0400
Message-ID: <449121F5.7040706@openvz.org>
Date: Thu, 15 Jun 2006 13:01:41 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] printk() should not be called under zone->lock
Content-Type: multipart/mixed;
 boundary="------------070003010709060304000301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070003010709060304000301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes printk() under zone->lock in show_free_areas().
It can be unsafe to call printk() under this lock, since
caller can try to allocate/free some memory and selfdeadlock
on this lock.
I found allocations/freeing mem both in netconsole and serial console.

This issue was faced in reallity when meminfo was periodically
printed for debug purposes and netconsole was used.

Signed-Off-By: Kirill Korotaev <dev@openvz.org>


--------------070003010709060304000301
Content-Type: text/plain;
 name="diff-show-free-areas"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-show-free-areas"

--- linux-2.6.17-rc6-mm1s.orig/mm/page_alloc.c	2006-06-09 15:37:09.000000000 +0400
+++ linux-2.6.16-rc6-mm1/mm/page_alloc.c	2006-06-15 12:42:31.000000000 +0400
@@ -1580,7 +1580,7 @@ void show_free_areas(void)
 	}
 
 	for_each_zone(zone) {
- 		unsigned long nr, flags, order, total = 0;
+ 		unsigned long nr[MAX_ORDER], flags, order, total = 0;
 
 		show_node(zone);
 		printk("%s: ", zone->name);
@@ -1591,11 +1591,12 @@ void show_free_areas(void)
 
 		spin_lock_irqsave(&zone->lock, flags);
 		for (order = 0; order < MAX_ORDER; order++) {
-			nr = zone->free_area[order].nr_free;
-			total += nr << order;
-			printk("%lu*%lukB ", nr, K(1UL) << order);
+			nr[order] = zone->free_area[order].nr_free;
+			total += nr[order] << order;
 		}
 		spin_unlock_irqrestore(&zone->lock, flags);
+		for (order = 0; order < MAX_ORDER; order++)
+			printk("%lu*%lukB ", nr[order], K(1UL) << order);
 		printk("= %lukB\n", K(total));
 	}
 

--------------070003010709060304000301--
