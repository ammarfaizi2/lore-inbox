Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263642AbUJ3ITb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUJ3ITb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 04:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUJ3ITb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 04:19:31 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:45440 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263642AbUJ3ITZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 04:19:25 -0400
Date: Sat, 30 Oct 2004 17:25:11 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
In-reply-to: <41824760.7010703@tebibyte.org>
To: Chris Ross <chris@tebibyte.org>, Andrew Morton <akpm@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Rik van Riel <riel@redhat.com>, javier@marcet.info,
       linux-kernel@vger.kernel.org, kernel@kolivas.org,
       barry <barry@disus.com>
Message-id: <41834FE7.5060705@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3)
 Gecko/20040910
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com>
 <20041028120650.GD5741@logos.cnet> <41824760.7010703@tebibyte.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 > Oct 29 15:25:19 sleepy protections[]: 0 0 0
 > Oct 29 15:25:19 sleepy DMA: 4294567735*4kB 4294792863*8kB
 > 4294895642*16kB 4294943555*32kB 4294962724*64kB 4294966891*128kB
 > 4294967255*256kB 4294967283*512kB
 >  4294967290*1024kB 4294967293*2048kB 4294967294*4096kB = 4289685332kB
 > Oct 29 15:25:19 sleepy Normal: 4293893066*4kB 4294583823*8kB
 > 4294849819*16kB 4294950038*32kB 4294966291*64kB 4294966753*128kB
 > 4294967182*256kB 4294967238*51
 > 2kB 4294967265*1024kB 4294967278*2048kB 4294967281*4096kB = 4284847952kB
 > Oct 29 15:25:19 sleepy HighMem: empty
 > Oct 29 15:25:19 sleepy Swap cache: add 9372, delete 7530, find

This looks odd.

How about this fix ?
I don't know why this is missng ....

Kame <kamezawa.hiroyu@jp.fujitsu.com>
--



---

  linux-2.6.10-rc1-mm2-kamezawa/mm/page_alloc.c |    4 +++-
  1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN mm/page_alloc.c~clean-up mm/page_alloc.c
--- linux-2.6.10-rc1-mm2/mm/page_alloc.c~clean-up	2004-10-30 17:07:01.918419104 +0900
+++ linux-2.6.10-rc1-mm2-kamezawa/mm/page_alloc.c	2004-10-30 17:08:25.904651256 +0900
@@ -261,7 +261,9 @@ static inline void __free_pages_bulk (st
  	}
  	coalesced = base + page_idx;
  	set_page_order(coalesced, order);
-	list_add(&coalesced->lru, &zone->free_area[order].free_list);
+	area = zone->free_area + order;
+	list_add(&coalesced->lru, &area->free_list);
+	area->nr_free++;
  }

  static inline void free_pages_check(const char *function, struct page *page)

_
