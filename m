Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbVJNTWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVJNTWO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 15:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbVJNTWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 15:22:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:24454 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750898AbVJNTWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 15:22:12 -0400
Date: Fri, 14 Oct 2005 14:21:11 -0500
From: Robin Holt <holt@sgi.com>
To: linux-ia64@vger.kernel.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, jgarzik@pobox.com,
       wli@holomorphy.com, Dave Hansen <haveblue@us.ibm.com>,
       Jack Steiner <steiner@americas.sgi.com>
Subject: [Patch 0/3] SGI Altix and ia64 special memory support.
Message-ID: <20051014192111.GB14418@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SGI hardware supports a special type of memory called fetchop or atomic
memory. This memory does atomic operations at the memory controller
instead of using the processor.

This patch set introduces a driver so user land can map the devices and
fault pages of the appropriate type.  Pages are inserted on first touch.
The reason for that was hashed out earlier on the lists, but can be
distilled to node locality, node resource limitation, and application
performance.

Since a typical ia64 uncached page does not have a page struct backing it,
we first modify do_no_page to handle a new return type of NOPAGE_FAULTED.
This indicates to the nopage handler that the desired operation is
complete and should be treated as a minor fault.  This is a result of a
discussion which Jes Sorenson started on the the ia64 mailing list and
Christoph Hellwig carried over to the linux-mm mailing list.

The second patch introduces the mspec driver.

I am reposting these today.  The last version went out in a rush last
night and I did not take the time to notify the people that were part
of the earlier discussion.

Additionally, the version which Jes posted last April was using
remap_pfn_range().  This version uses set_pte().  I realize that is
probably the wrong thing to do.  Unfortunately, we need this to be
thread-safe.  With remap_pfn_range() there is a BUG_ON(!pte_none(*pte));
in remap_pte_range() which would trip if there were multiple threads
faulting at the same time.  To work around that, I started looking at
breaking remap_pfn_range() into an _remap_pfn_range() which assumed
the locks were already held.  At that point, it became apparent I
was stretching the use of remap_pfn_range beyond its original intent.
For this driver, we are inserting a single pte, the page tables have
already been put in place by the caller's chain, why not just insert
the pte directly.  That is what I finally did.

Thanks,
Robin Holt
