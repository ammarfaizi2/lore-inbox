Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUFQUtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUFQUtm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 16:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUFQUtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 16:49:42 -0400
Received: from holomorphy.com ([207.189.100.168]:18818 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262951AbUFQUtb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 16:49:31 -0400
Date: Thu, 17 Jun 2004 13:48:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@redhat.com>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, y@redhat.com,
       Clay Haapala <chaapala@cisco.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040617204828.GC1495@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@redhat.com>,
	"Salyzyn, Mark" <mark_salyzyn@adaptec.com>, y@redhat.com,
	Clay Haapala <chaapala@cisco.com>,
	James Bottomley <James.Bottomley@steeleye.com>,
	Christoph Hellwig <hch@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2407B@otce2k03.adaptec.com> <20040617203842.GC8705@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617203842.GC8705@devserv.devel.redhat.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 01:54:38PM -0400, Salyzyn, Mark wrote:
>> And I might add, undoing the entropy to result in the descending page
>> list (but that is the forth time I've said this).
>> I ran heavy sequential load overnight and continued to have this
>> characteristic when taking snapshots of command SG lists. The average SG
>> element size statistically was 4168 bytes.

On Thu, Jun 17, 2004 at 04:38:42PM -0400, Alan Cox wrote:
> What do the stats look like with the patch Andrew Morton (I think) posted
> to reverse the page order from the allocator ?

Say, could you guys try this? jejb seemed to get decent results with it.


===== mm/page_alloc.c 1.211 vs edited =====
--- 1.211/mm/page_alloc.c	Sat Jun 12 20:52:26 2004
+++ edited/mm/page_alloc.c	Thu Jun 17 13:46:36 2004
@@ -297,14 +297,12 @@
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
