Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269329AbUHaXq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269329AbUHaXq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbUHaXqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:46:23 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:57234 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269128AbUHaXbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:31:19 -0400
Date: Wed, 01 Sep 2004 08:36:25 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [Lhms-devel] Re: [RFC] buddy allocator without bitmap(2) [1/3]
In-reply-to: <1093993935.28787.416.camel@nighthawk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
Message-id: <41350B79.1070305@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6)
 Gecko/20040113
References: <413455BE.6010302@jp.fujitsu.com>
 <1093969857.26660.4816.camel@nighthawk> <413501DC.2050409@jp.fujitsu.com>
 <1093993935.28787.416.camel@nighthawk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

> On Tue, 2004-08-31 at 15:55, Hiroyuki KAMEZAWA wrote:
> 
>>Dave Hansen wrote:
>>
>>
>>>On Tue, 2004-08-31 at 03:41, Hiroyuki KAMEZAWA wrote:
>>>
>>>
>>>>+static void __init calculate_aligned_end(struct zone *zone,
>>>>+					 unsigned long start_pfn,
>>>>+					 int nr_pages)
>>>
>>>...
>>>
>>>
>>>>+		end_address = (zone->zone_start_pfn + end_idx) << PAGE_SHIFT;
>>>>+#ifndef CONFIG_DISCONTIGMEM
>>>>+		reserve_bootmem(end_address,PAGE_SIZE);
>>>>+#else
>>>>+		reserve_bootmem_node(zone->zone_pgdat,end_address,PAGE_SIZE);
>>>>+#endif
>>>>+	}
>>>>+	return;
>>>>+}
>>>
>>>
>>>What if someone has already reserved that address?  You might not be
>>>able to grow the zone, right?
>>>
>>
>>1) If someone has already reserved that address,  it (the page) will not join to
>>   buddy allocator and it's no problem.
>>
>>2) No, I can grow the zone.
>>   A reserved page is the last page of "not aligned contiguous mem_map", not zone.
>>
>>I answer your question ?
> 
> 
> If the end of the zone isn't aligned, you simply waste memory until it becomes aligned, right?
> 
No. I waste just one page, the end page of mem_map.
When the end of mem_map is not aligned, there are 2 cases.

case 1) length of mem_map is even number.
 -------------------------------
 |  |  |  |  |C |  |B |  |A | X|  no-page-area    order=0
 -------------------------------
 |     |     |C    |B    |                        order=1
 -------------------------
 |           |C          |                        order=2
 -------------------------
X is reserved and will not join to buddy system.
By doing this,
page "A" has no boddy in order=0, "X" is reserved.
page "B" has no buddy in order=1, "A" is order 0.
page "C" has no buddy in order=2, "A" is order 0.
..........

case 2) length of mem_map is odd number.
-----------------------------
 |  |  |  |  |C |  |B |  |X |    no-page-area    order=0
 ----------------------------
 |     |     |C    |B    |                       order=1
 -------------------------
 |           |C          |                       order=2
 -------------------------
page "B" has no buddy in order=1, X is reserved.
.........

Access to no-page-area in buddy system does not occur.

-- Kame

-- 
--the clue is these footmarks leading to the door.--
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

