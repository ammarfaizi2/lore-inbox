Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVCVSLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVCVSLS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVCVSJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:09:41 -0500
Received: from fmr14.intel.com ([192.55.52.68]:52126 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261593AbVCVSHL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:07:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/5] freepgt: free_pgtables use vma list
Date: Tue, 22 Mar 2005 10:06:15 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0321137B@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/5] freepgt: free_pgtables use vma list
Thread-Index: AcUvCI2rIMuLHUb8TRyRIkBTlvVRoAAAIDig
From: "Luck, Tony" <tony.luck@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <hugh@veritas.com>, <akpm@osdl.org>, <benh@kernel.crashing.org>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Mar 2005 18:06:20.0510 (UTC) FILETIME=[D9CB07E0:01C52F09]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> For example, you may have a single page (start,end) address range
>> to free, but if this is enclosed by a large enough (floor,ceiling)
>> then it may free an entire pgd entry.
>> 
>> I assume the intention of the API would be to provide the full
>> pgd width in that case?
>
>Yes, that is what should happen if the full PGD entry is liberated.
>
>Any time page table chunks are liberated, they have to be included
>in the range passed to the flush_tlb_pgtables() call.

So should this part of Hugh's code:

                        /*
                         * Optimization: gather nearby vmas into one call down
                         */
                        while (next && next->vm_start <= vma->vm_end + PMD_SIZE
                        && !is_hugepage_only_range(next->vm_start, HPAGE_SIZE)){
                                vma = next;
                                next = vma->vm_next;
                        }
                        free_pgd_range(tlb, addr, vma->vm_end,
                                floor, next? next->vm_start: ceiling);
 
be changed to use pgd_addr_end() to gather up all the vma that
are mapped by a single pgd instead of just spanning out the next
PMD_SIZE?

On ia64 we can have a vma big enough to require more than one pgd, but
in the case that we span, we won't cross the problematic pgd boundaries
where the holes in the address space are lurking.

-Tony
