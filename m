Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265206AbUFRPGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUFRPGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265214AbUFRPGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:06:08 -0400
Received: from holomorphy.com ([207.189.100.168]:10628 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265206AbUFRPF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:05:59 -0400
Date: Fri, 18 Jun 2004 08:05:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@redhat.com>, "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       y@redhat.com, Clay Haapala <chaapala@cisco.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Cc: akpm@osdl.org
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040618150518.GB1863@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@redhat.com>,
	"Salyzyn, Mark" <mark_salyzyn@adaptec.com>, y@redhat.com,
	Clay Haapala <chaapala@cisco.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>, akpm@osdl.org
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2407B@otce2k03.adaptec.com> <20040617203842.GC8705@devserv.devel.redhat.com> <20040617204828.GC1495@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617204828.GC1495@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 04:38:42PM -0400, Alan Cox wrote:
>> What do the stats look like with the patch Andrew Morton (I think) posted
>> to reverse the page order from the allocator ?

On Thu, Jun 17, 2004 at 01:48:28PM -0700, William Lee Irwin III wrote:
> Say, could you guys try this? jejb seemed to get decent results with it.

Proper changelog this time, and comments, too. Adaptec et al, please
verify this resolves the issues you've been having.
Someone say _something_.

---

Based on Arjan van de Ven's idea, with guidance and testing from
James Bottomley.

The physical ordering of pages delivered to the IO subsystem is
strongly related to the order in which fragments are subdivided from
larger blocks of memory tracked by the page allocator. Consider a
single MAX_ORDER block of memory in isolation acted on by a sequence of
order 0 allocations in an otherwise empty buddy system. Subdividing
the block beginning at the highest addresses will yield all the pages
of the block in reverse, and subdividing the block begining at the
lowest addresses will yield all the pages of the block in physical
address order. Empirical tests demonstrate this ordering is preserved,
and that changing the order of subdivision so that the lowest page is
split off first resolves the sglist merging difficulties encountered by
driver authors at Adaptec and others in James Bottomley's testing.
James found that before this patch, there were 40 merges out of about
32K segments.  Afterward, there were 24007 merges out of 19513 segments,
for a merge rate of about 55%. Merges of 128 segments, the maximum
allowed, were observed afterward, where beforehand they never occurred.
It also improves dbench on my workstation and works fine there.

Signed-off-by: William Lee Irwin III <wli@holomorphy.com>


diff -prauN linux-2.6.7/mm/page_alloc.c linux-2.6.7/mm/page_alloc.c 
--- linux-2.6.7/mm/page_alloc.c	Sat Jun 12 20:52:26 2004
+++ linux-2.6.7/mm/page_alloc.c	Fri Jun 18 07:45:05 2004
@@ -290,6 +290,20 @@
 #define MARK_USED(index, order, area) \
 	__change_bit((index) >> (1+(order)), (area)->map)
 
+/*
+ * The order of subdivision here is critical for the IO subsystem.
+ * Please do not alter this order without good reasons and regression
+ * testing. Specifically, as large blocks of memory are subdivided,
+ * the order in which smaller blocks are delivered depends on the order
+ * they're subdivided in this function. This is the primary factor
+ * influencing the order in which pages are delivered to the IO
+ * subsystem according to empirical testing, and this is also justified
+ * by considering the behavior of a buddy system containing a single
+ * large block of memory acted on by a series of small allocations.
+ * This behavior is a critical factor in sglist merging's success.
+ *
+ * -- wli
+ */
 static inline struct page *
 expand(struct zone *zone, struct page *page,
 	 unsigned long index, int low, int high, struct free_area *area)
@@ -297,14 +311,12 @@
 	unsigned long size = 1 << high;
 
 	while (high > low) {
-		BUG_ON(bad_range(zone, page));
 		area--;
 		high--;
 		size >>= 1;
-		list_add(&page->lru, &area->free_list);
-		MARK_USED(index, high, area);
-		index += size;
-		page += size;
+		BUG_ON(bad_range(zone, &page[size]));
+		list_add(&page[size].lru, &area->free_list);
+		MARK_USED(index + size, high, area);
 	}
 	return page;
 }
