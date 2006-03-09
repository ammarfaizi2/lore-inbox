Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWCIMDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWCIMDK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 07:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbWCIMCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 07:02:55 -0500
Received: from fmr23.intel.com ([143.183.121.15]:19429 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751879AbWCIMCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 07:02:54 -0500
Message-Id: <200603091202.k29C24g19696@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <wli@holomorphy.com>, "'Andrew Morton'" <akpm@osdl.org>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] hugetlb strict commit accounting
Date: Thu, 9 Mar 2006 04:02:06 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZDbMghlXpYtzMfTSmocFe7P0uhNQAAvGNQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20060309112635.GB9479@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Thursday, March 09, 2006 3:27 AM
> Again, there are no changes to the fault handler.  Including the
> promised changes which would mean my instantiation serialization path
> isn't necessary ;-).

This is the major portion that I omitted in the first patch and is the
real kicker that fulfills the promise of guaranteed available hugetlb
page for shared mapping.

You can shower me all over on the lock protection :-) yes, this is not
perfect and was the reason I did not post it earlier, but I want to give
you the concept on how I envision this route would work.

Again PRIVATE mapping is busted, you can't count them from inode.  You
would have to count them via mm_struct (I think).

- Ken

Note: definition of "reservation" in earlier patch is total hugetlb pages
needed for that file, including the one that is already faulted in.  Maybe
that throw you off a bit because I'm guessing your definition is "needed
in the future" and probably you are looking for a decrement of the counter
in the fault path?


--- ./mm/hugetlb.c.orig	2006-03-09 04:46:38.965547435 -0800
+++ ./mm/hugetlb.c	2006-03-09 04:48:20.804413375 -0800
@@ -196,6 +196,8 @@ static unsigned long set_max_huge_pages(
 		enqueue_huge_page(page);
 		spin_unlock(&hugetlb_lock);
 	}
+	if (count < atomic_read(&resv_huge_pages))
+		count = atomic_read(&resv_huge_pages);
 	if (count >= nr_huge_pages)
 		return nr_huge_pages;
 

