Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVCQWdC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVCQWdC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVCQWcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:32:53 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:9162 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261313AbVCQWbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:31:48 -0500
Date: Thu, 17 Mar 2005 14:31:40 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prezeroing V8
In-Reply-To: <20050317140831.414b73bb.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0503171423590.10008@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
 <20050317140831.414b73bb.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2005, Andrew Morton wrote:

> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > Adds management of ZEROED and NOT_ZEROED pages and a background daemon
> > called scrubd. /proc/sys/vm/scrubd_load, /proc/sys/vm_scrubd_start and
> > /proc/sys/vm_scrubd_stop control the scrub daemon. See Documentation/vm/
> > scrubd.txt
>
> It's hard to know what to think about this without benchmarking numbers.
>
> It would help if you could briefly describe the implementation and design
> decisions when sending patches.

Oh. This was discussed so many times that I thought it would not be
necessary anymore. The discussion is attached.

> For example, one area where we could use this is in pagetable management,
> where we need zeroed pages and we tend to free up known-to-be-zero and
> probably cache-warm pages.  Right now some architectures are maintaining
> their own quicklists, or using a slab cache, both of which are suboptimal.

Right.

> But afaict the patch doesn't differentiate between cache-cold and cache-hot
> zeroed pages, and doesn't have an API with which clients can free up a
> known-to-be-zero page.

end_zero_page(page, 0) would do put a zeroed page back on the zeroed list.
But we may have to define a cleaner API for it. Plus this is a hot zero
page. So I would need to add a hot zero hotlist to the existing cold zero
hotlist.

---- Description ----

The most expensive operation in the page fault handler is (apart of SMP
locking overhead) the touching of all cache lines of a page by
zeroing the page. This zeroing means that all cachelines of the faulted
page (on Altix that means all 128 cachelines of 128 byte each) must be
handled and later written back. This patch allows to avoid having to
use all cachelines  if only a part of the cachelines of that page is
needed immediately after the fault. Doing so will only be effective for
sparsely accessed memory which is typical for anonymous memory and pte
maps.

The patch makes prezeroing very effective by also allowing the use
of hardware support for offloading zeroing from the cpu. This avoids
the invalidation of the cpu caches by extensive zeroing operations.

The scrub daemon is invoked when the number of zeroed pages falls below a
lower threshhold (defined by setting /proc/sys/vm/scrub_start) so
that its worth running it. kscrubd then zeroes free pages until the upper
threshold is reached (set by /proc/sys/vm/scrub_stop). The zeroing
is performed on a percentage of pages at each order of freed pages.

kscrubd performs short bursts of zeroing when needed and tries to stay out
off the processor as much as possible. Kscrubd will only run when the load
is less than set in /proc/sys/vm/scrub_load (defaults to 1).

The benefits of prezeroing are reduced to minimal quantities if all
cachelines of a page are touched. Prezeroing can only be effective
if the whole page is not immediately used after the page fault.
