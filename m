Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154363AbQDHT7U>; Sat, 8 Apr 2000 15:59:20 -0400
Received: by vger.rutgers.edu id <S154258AbQDHT7A>; Sat, 8 Apr 2000 15:59:00 -0400
Received: from colorfullife.com ([216.156.138.34]:3023 "EHLO colorfullife.com") by vger.rutgers.edu with ESMTP id <S154415AbQDHT6p>; Sat, 8 Apr 2000 15:58:45 -0400
Message-ID: <38EF9135.2A42DC6E@colorfullife.com>
Date: Sat, 08 Apr 2000 22:06:13 +0200
From: Manfred Spraul <manfreds@colorfullife.com>
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.14 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu, linux-mm@kvack.org
Subject: zap_page_range(): TLB flush race
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

it seems we have a smp race in zap_page_range():

When we remove a page from the page tables, we must call:

	flush_cache_page();
	pte_clear();
	flush_tlb_page();
	free_page();

We must not free the page before we have called flush_tlb_xy(),
otherwise the second cpu could access memory that already freed.

but zap_page_range() calls free_page() before the flush_tlb() call.

Is that really a bug, has anyone a good idea how to fix that?

filemap_sync() calls flush_tlb_page() for each page, but IMHO this is a
really bad idea, the performance will suck with multi-threaded apps on
SMP.

Perhaps build a linked list, and free later?
We could abuse the next pointer from "struct page".
--
	Manfred


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
