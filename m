Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbVIZUR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbVIZUR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVIZUR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:17:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:33761 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932499AbVIZUR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:17:27 -0400
Message-ID: <43385754.5080704@austin.ibm.com>
Date: Mon, 26 Sep 2005 15:17:24 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Joel Schopp <jschopp@austin.ibm.com>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
Subject: [PATCH 9/9] free memory is user reclaimable
References: <4338537E.8070603@austin.ibm.com>
In-Reply-To: <4338537E.8070603@austin.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------000805030705090005000407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000805030705090005000407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Make the free memory revert to user reclaimable type, which is probably more
accurate, and certainly helpful for memory hotplug remove.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>


--------------000805030705090005000407
Content-Type: text/plain;
 name="9_free_memory_is_user"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="9_free_memory_is_user"

Index: 2.6.13-joel2/mm/page_alloc.c
===================================================================
--- 2.6.13-joel2.orig/mm/page_alloc.c	2005-09-21 11:31:51.%N -0500
+++ 2.6.13-joel2/mm/page_alloc.c	2005-09-21 11:37:48.%N -0500
@@ -339,6 +339,9 @@ static inline int page_is_buddy(struct p
  * triggers coalescing into a block of larger size.            
  *
  * -- wli
+ *
+ * For hotplug memory purposes make the free memory revert to the user
+ * reclaimable type, which is probably more accurate for that state anyway.
  */
 
 static inline void __free_pages_bulk (struct page *page,
@@ -379,7 +382,10 @@ static inline void __free_pages_bulk (st
 		page_idx = combined_idx;
 		order++;
 	}
-	if (unlikely(order == MAX_ORDER-1)) zone->fallback_balance++;
+	if (unlikely(order == MAX_ORDER-1)) {
+		set_pageblock_type(zone, page, RCLM_USER);
+		zone->fallback_balance++;
+	}
 
 	set_page_order(page, order);
 	area = freelist + order;

--------------000805030705090005000407--
