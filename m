Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751841AbWCILn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbWCILn7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 06:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWCILn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 06:43:59 -0500
Received: from fmr22.intel.com ([143.183.121.14]:29825 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751841AbWCILn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 06:43:58 -0500
Message-Id: <200603091143.k29BhAg19160@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'David Gibson'" <david@gibson.dropbear.id.au>
Cc: <wli@holomorphy.com>, "'Andrew Morton'" <akpm@osdl.org>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] hugetlb strict commit accounting
Date: Thu, 9 Mar 2006 03:43:12 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZDbMghlXpYtzMfTSmocFe7P0uhNQAAEKjA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20060309112635.GB9479@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote on Thursday, March 09, 2006 3:27 AM
> Um... as far as I can tell, this patch doesn't actually reserve
> anything.  There are no changes to the fault handler ot
> alloc_huge_page(), so there's nothing to stop PRIVATE mappings dipping
> into the supposedly reserved pool.

Well, the reservation is already done at mmap time for shared mapping. Why
does kernel need to do anything at fault time?  Doing it at fault time is
an indication of weakness (or brokenness) - you already promised at mmap
time that there will be a page available for faulting.  Why check them
again at fault time?

I don't think your implementation handles PRIVATE mapping either, Isn't it?
Private mapping doesn't enter into the page cache hanging of address_space
pointer, so either way, it is busted.


> This looks a bit like a case of "let's make it an atomic_t to sprinkle
> it with magic atomicity dust" without thinking about what operations
> are and need to be atomic.  I think resv_huge_pages should be an
> ordinary int, but protected by a lock (exactly which lock is not
> immediately obvious).

Yeah, I agree.  It crossed my mind whether I should fix that or post a
fairly straightforward back port.  I decided to do the latter and I got
bitten :-(  That is in the pipeline if people agree that this variable
reservation system is a better one.


> What is the list of regions (mapping->private_list) protected by?
> mmap_sem (the only thing I can think of off hand that's already taken)
> doesn't cut it, because the mapping can be accessed by multiple mms.

I think it is the inode->i_mutex.

- Ken

