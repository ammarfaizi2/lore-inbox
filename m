Return-Path: <linux-kernel-owner+w=401wt.eu-S1752281AbWLSDBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281AbWLSDBi (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 22:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbWLSDBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 22:01:38 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:20474 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbWLSDBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 22:01:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b6r6q/UqfoT5JnXspWnhAfcByeclqcFT+pdc29c4gIH310P+Kxm/gDgHu/wxegp0AS0VNhWCbDREijg+Cm3Ua5A3HbnCc8UoXZvlRUc8JDZBFHcH5NGWyGYac7ASaErozxXqpAzVuJLrdsTBCcFFZnYh9PU2RSa1TGsWz5xIJHI=
Message-ID: <6d6a94c50612181901m1bfd9d1bsc2d9496ab24eb3f8@mail.gmail.com>
Date: Tue, 19 Dec 2006 11:01:36 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC][PATCH] Fix area->nr_free-- went (-1) issue in buddy system
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When I setup two zones (NORMAL and DMA) in my system, I got the
following wired result from /proc/buddyinfo.
-----------------------------------------------------------------------------------------
root:~> cat /proc/buddyinfo
Node 0, zone      DMA      2      1      2      1      1      0      0
     1      1      2      2      0      0      0
Node 0, zone   Normal      1      1      1      1      1      1      0
     0 4294967295      0 4294967295      2      0      0
-----------------------------------------------------------------------------------------

As you see, two area->nr_free went -1.

After dig into the code, I found the problem is in the fun
__free_one_page() when the kernel boot up call free_all_bootmem(). If
two zones setup, it's possible NORMAL zone merged a block whose order
=8 at the first time(this time zone[NORMA]->free_area[8].nr_free = 0)
and found its buddy in the DMA zone. So the two blocks will be merged
and area->nr_free went to -1.

My proposed patch is as follows:


Signed-off-by: Aubrey Li <aubreylee@gmail.com>
---------------------------------------------------------------------------------------------------
--- page_alloc.c.orig	2006-12-19 10:45:25.000000000 +0800
+++ page_alloc.c	2006-12-19 10:44:48.000000000 +0800
@@ -407,7 +407,8 @@ static inline void __free_one_page(struc

 		list_del(&buddy->lru);
 		area = zone->free_area + order;
-		area->nr_free--;
+		if (area->nr_free > 0)
+			area->nr_free--;
 		rmv_page_order(buddy);
 		combined_idx = __find_combined_index(page_idx, order);
 		page = page + (combined_idx - page_idx);
----------------------------------------------------------------------------------------------------
Any comments?

Thanks,
-Aubrey
