Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbVKHFof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbVKHFof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 00:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVKHFof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 00:44:35 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19666 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750946AbVKHFoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 00:44:34 -0500
Date: Mon, 7 Nov 2005 21:44:20 -0800
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: rohit.seth@intel.com, akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Cleanup of __alloc_pages
Message-Id: <20051107214420.6d0f6ec4.pj@sgi.com>
In-Reply-To: <43701FC6.5050104@yahoo.com.au>
References: <20051107174349.A8018@unix-os.sc.intel.com>
	<20051107175358.62c484a3.akpm@osdl.org>
	<1131416195.20471.31.camel@akash.sc.intel.com>
	<43701FC6.5050104@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> The compiler will constant fold this out if it is halfway smart.

How could that happen - when get_page_from_freelist() is called twice,
once with skip_cpuset_chk == 0 and once with skip_cpuset_chk == 1?


> +#define ALLOC_WATERMARKS	0x01 /* check watermarks */
> +#define ALLOC_HARDER		0x02 /* try to alloc harder */
> +#define ALLOC_HIGH		0x04 /* __GFP_HIGH set */
> +#define ALLOC_CPUSET		0x08 /* check for correct cpuset */

Names - bless you.

If these names were in a header, then calls to zone_watermark_ok()
from mm/vmscan.c could use them too?


> +	 * reclaim. Now things get more complex, so st up alloc_flags according

Typo: s/st/set/


At first glance, I think you've expressed the cpuset flags correctly.
Well, correctly maintained their current meaning.  Read on, and you
will see that I think that is not right.

I'm just reading the raw patch, so likely I missed something here.
But it seems to me that zone_watermark_ok() is called from __alloc_pages()
only if the ALLOC_WATERMARKS flag is set, and it seems that the two
alloc_flags values ALLOC_HARDER and ALLOC_HIGH are only of use if
zone_watermark() is called.  So what use is it setting ALLOC_HARDER
or ALLOC_HIGH if ALLOC_WATERMARKS is not set?  If the get_page_from_freelist()
check:
	if (alloc_flags & ALLOC_WATERMARKS)
was instead:
	if (alloc_flags & ALLOC_WATERMARKS|ALLOC_HARDER|ALLOC_HIGH)
then this would make more sense to me.  Or changing ALLOC_WATERMARKS
to ALLOC_EASY, and make it behave similarly to the HARDER & HIGH flags.
Or maybe if the initialization of alloc_flags:
> +	alloc_flags = 0;
was instead:
  +	alloc_flags = ALLOC_WATERMARKS;

As a possible future change, I wonder if there is a way to avoid having
the ALLOC_CPUSET flag separate, and instead collapse the logic (even if
it means modifying the conditions a little when cpusets are honored) to
make the cpuset_zone_allowed() check based on some combination of these
other WATERMARKS/HARDER/HIGH values.  For example, it might make sense
to check cpuset_zone_allowed() under the same conditions that it made
sense to call zone_watermark_ok() from get_page_from_freelist(), or
perhaps to check cpusets unless we are HIGH or not checking
watermarks.  To the best of my knowledge, subtle variations between
when we check some level of watermarks and when we check cpusets are
not worth it - not worth the extra conditional jump in the machine
code, and not worth the extra bit of logic and flags in the source code.

The cpuset check in the 'ignoring mins' code shortly after this for the
PF_MEMALLOC or TIF_MEMDIE cases seems bogus.  This is the case where we
should be most willing to use memory, regardless of where we find it.
That cpuset check should be removed.

My current inclination - check cpusets in the WATERMARKS or HARDER
or (HIGH && wait) cases, but ignore cpusets in the (HIGH && !wait) or
'ignoring mins' cases.  Can "HIGH && wait" even happen ??  Are
allocations either GFP_ATOMIC (aka GFP_HIGH) or (exclusive or)
GFP_WAIT, never both?  Perhaps GFP_HIGH should be permanently
deleted (another cleanup) in favor of the more popular and expressive
GFP_ATOMIC, and __GFP_WAIT retired, in favor of !GFP_ATOMIC.

However, I appreciate your preference to separate cleanup from semantic
change.  Perhaps this means leaving the ALLOC_CPUSET flag in your
cleanup patch, then one of us following on top of that with a patch to
simplify and fix the cpuset invocation semantics and a second cleanup
patch to remove ALLOC_CPUSET as a separate flag.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
