Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVCWTRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVCWTRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 14:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVCWTRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 14:17:31 -0500
Received: from fmr14.intel.com ([192.55.52.68]:24488 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S261774AbVCWTR0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 14:17:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 1/6] freepgt: free_pgtables use vma list
Date: Wed, 23 Mar 2005 11:16:27 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0324516D@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/6] freepgt: free_pgtables use vma list
Thread-Index: AcUvy4/Dv9gq5dTkQkCmsoEWc9QL5QAC7DqA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Hugh Dickins" <hugh@veritas.com>, "Nick Piggin" <nickpiggin@yahoo.com.au>
Cc: <akpm@osdl.org>, <davem@davemloft.net>, <benh@kernel.crashing.org>,
       <ak@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Mar 2005 19:16:29.0083 (UTC) FILETIME=[D0B60EB0:01C52FDC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+	 * Why all these "- 1"s?  Because 0 represents both the bottom
+	 * of the address space and the top of it (using -1 for the
+	 * top wouldn't help much: the masks would do the wrong thing).
+	 * The rule is that addr 0 and floor 0 refer to the bottom of
+	 * the address space, but end 0 and ceiling 0 refer to the top
+	 * Comparisons need to use "end - 1" and "ceiling - 1" (though
+	 * that end 0 case should be mythical).

Can we legislate that "end==0" isn't possible.  On ia64 this is
certainly true (user virtual space is confined to regions 0-4, so
the max value of end is 0xa000000000000000[*]).  Same applies on x86
where the max user address is 0xc0000000 (assuming a standard 3G/1G
split, and ignoring the 4G-4G patch).  What do the other architectures
do?  Does anyone allow:
	mmap((void *)-PAGE_SIZE, PAGE_SIZE, MAP_FIXED, ...)
to succeed?

Otherwise throw in some extra macros to hide the computation needed
to make the masks work on ceiling values that represent the last byte
of the vma rather than the address beyond.  Presumably we can use a
few cycles on some extra arithmetic to help us save gazillions of
cycles for all the cache misses that we currently expend traversing
empty areas of page tables at each level.

Latest patches run on ia64 ... I did at least throw a fork-tester at
it to make sure that we aren't leaking pagetables ... it is still
running after a few million forks, so the simple cases are not doing
anything completely bogus.

-Tony

[*] Since a three level page table doesn't give us enough bits, the
actual limit (with a 16k page size) is 0x8000100000000000 with a hole
for the rest of region 4).

