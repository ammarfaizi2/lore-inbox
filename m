Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267450AbUJRTWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267450AbUJRTWr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUJRTIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:08:41 -0400
Received: from fmr12.intel.com ([134.134.136.15]:13207 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S267450AbUJRTDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:03:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] General purpose zeroed page slab
Date: Mon, 18 Oct 2004 12:03:04 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0236348B@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] General purpose zeroed page slab
Thread-Index: AcS1QjBYpFV2JdbRSFeS1dEbNibbHAAAg1eA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Matthew Wilcox" <matthew@wil.cx>,
       "Martin K. Petersen" <mkp@wildopensource.com>
Cc: "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>, <akpm@osdl.org>
X-OriginalArrivalTime: 18 Oct 2004 19:03:06.0202 (UTC) FILETIME=[19B723A0:01C4B545]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It's probably worth doing this with a static cachep in slab.c and only
>exposing a get_zeroed_page() / free_zeroed_page() interface, with the
>latter doing the memset to 0.  I disagree with Andi over the dumbness
>of zeroing the whole page.  That makes it cache-hot, which is what you
>want from a page you allocate from slab.

We started this discussion with the plan of using this interface to
allocate/free page tables at all levels in the page table hierarchy
(rather than maintain a special purpose "quicklist" allocator for each
level).  This is a somewhat specialized usage in that we know that we
have a completely zeroed page when we free ... so we really don't
want the overhead of zeroing it again.  There is also somewhat limited
benefit to the cache hotness argument here as most page tables (especially
higher-order ones) are used very sparsely.

That said, the idea to expose this slab only through a specific API
should calm fears about accidental mis-use (with people freeing a page
that isn't all zeroes).

-Tony
