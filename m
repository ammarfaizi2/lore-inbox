Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVCVWma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVCVWma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 17:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVCVWm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 17:42:28 -0500
Received: from fmr14.intel.com ([192.55.52.68]:56736 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262153AbVCVWls convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 17:41:48 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/5] freepgt: free_pgtables use vma list
Date: Tue, 22 Mar 2005 14:40:55 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F03211751@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/5] freepgt: free_pgtables use vma list
Thread-Index: AcUvD9lTs3aswzO2S7i+xMDoOzJZlwAHXfDg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: "David S. Miller" <davem@davemloft.net>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, <akpm@osdl.org>,
       <benh@kernel.crashing.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Mar 2005 22:40:57.0298 (UTC) FILETIME=[36B95B20:01C52F30]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> be changed to use pgd_addr_end() to gather up all the vma that
>> are mapped by a single pgd instead of just spanning out the next
>> PMD_SIZE?
>
>Oh, I don't think so.  I suppose it could be done at this level,
>but then the lower levels would go back to searching through lots
>of unnecessary cachelines to find the significant entries, and
>we might as well throw out the whole set of patches (which will
>soon happen anyway if we can't find why they're not working!).

Then I don't see how we decide when to clear a pointer at each
level.  Are there counters of how many entries are active in each
table at all levels (pgd/pud/pmd/pte)?

Consider the case where two or more vmas are mapped at addresses that
share a pgd entry, but are far enough apart that you don't want
to coalesce them.  First call down through that pgd entry must
leave the pointer to the pud (or pmd/pte for systems with less
levels) so that the next call can still get to the pud/pmd/pte
to clear out entries for the other vma.  But without counters
(at all levels) you don't know when you are all done with a table,
or whether you need to leave it for the next call.

If you want to pursue this, then there are probably some fields
in the page_t for the page that is being used as a pgd/pud/pmd/pte
that are available (do all architectures allocate whole pages for
all levels of the page tree?)

Alternatively you could modify the use of floor/ceiling as they
are passed down from the top level to indicate the progressively
greater address ranges that have been dealt with ... but I'm not
completely convinced that gives you enough information.  You would
need to do careful extension of the ceiling at each level to make
sure that you reach out to the end of of each table at each level
to account for gaps between vmas (which would result in no future
calldown hitting this part of the table).

-Tony
