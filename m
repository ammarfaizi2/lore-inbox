Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbVAKACf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbVAKACf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVAJX6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:58:12 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:18345 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262508AbVAJXxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:53:38 -0500
Date: Mon, 10 Jan 2005 15:53:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>, linux-ia64@vger.kernel.org,
       linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Prezeroing V4 [0/4]: Overview
In-Reply-To: <Pine.LNX.4.58.0501101004230.2373@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0501101552100.25654@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0501082103120.5207-100000@localhost.localdomain>
 <Pine.LNX.4.58.0501100915200.19135@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501101004230.2373@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from V3 to V4:
o Drop __GFP_ZERO patch since its in Linus tree. Include new patch that allows
  archs that need special measures around zeroing of user pages during a page
  fault to maintain their special adaptations.
o Use zeroed pages during COW.
o Updates for clear_page for various platforms. Make clear_page an optional
  patch and fall back to a series of clear_page without order if the patch
  to expand clear_page patch has not been applied.
o x86_64 asm code fixed up
o Port patches to 2.6.10-bk13 and make it fit the bitmapless buddy allocator

The patches increasing the page fault rate (introduction of atomic pte
operations and anticipatory prefaulting) do so by reducing the locking
overhead and are therefore mainly of interest for applications running in
SMP systems with a high number of cpus. The single thread performance does
just show minor increases. Only the performance of multi-threaded
applications increases significantly.

The most expensive operation in the page fault handler is (apart of SMP
locking overhead) the zeroing of the page that is also done in the page fault
handler. This zeroing means that all cachelines of the faulted page (on Altix
that means all 128 cachelines of 128 byte each) must be loaded and later
written back. This patch allows to avoid having to load all cachelines
if only a part of the cachelines of that page is needed immediately after
the fault. Doing so will only be effective for sparsely accessed memory
which is typical for anonymous memory and pte maps. Prezeroed pages will
only be used for those purposes. Unzeroed pages will be used as usual for
file mapping, page caching etc etc.

The patch makes prezeroing very effective by:

1. Aggregating zeroing operations to only apply to pages of higher order,
which results in many pages that will later become zero 0 to be zeroed in one
step.
For that purpose the existing clear_page function is extended and made to
take an additional argument specifying the order of the page to be cleared.

2. Hardware support for offloading zeroing from the cpu. This avoids
the invalidation of the cpu caches by extensive zeroing operations.

The scrub daemon is invoked when a unzeroed page of a certain order has
been generated so that its worth running it. If no higher order pages are
present then the logic will favor hot zeroing rather than simply shifting
processing around. kscrubd typically runs only for a fraction of a second
and sleeps for long periods of time even under memory benchmarking. kscrubd
performs short bursts of zeroing when needed and tries to stay out off the
processor as much as possible.

The benefits of prezeroing are reduced to minimal quantities if all
cachelines of a page are touched. Prezeroing can only be effective
if the whole page is not immediately used after the page fault.

The patch is composed of 4 parts:

[1/4] GFP_ZERO fixups
	Adds alloc_zeroed_user_highpage(vma, vaddr) that may be customized for
	each arch by defining __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE. Includes
	proper definitions for a large selection of arches, others fall back to
	the default function in include/linux/highmem.h (and falls back to not
	using prezeroed pages).

[2/4] Page Zeroing
	Adds management of ZEROED and NOT_ZEROED pages and a background daemon
	called scrubd. scrubd is disabled by default but can be enabled
	by writing an order number to /proc/sys/vm/scrub_start. If a page
	is coalesced of that order or higher then the scrub daemon will
	start zeroing until all pages of order /proc/sys/vm/scrub_stop and
	higher are zeroed and then go back to sleep.

	In an SMP environment the scrub daemon is typically
	running on the most idle cpu. Thus a single threaded application running
	on one cpu may have the other cpu zeroing pages for it etc. The scrub
	daemon is hardly noticable and usually finished zeroing quickly since
	most processors are optimized for linear memory filling.

The following patches increase performance but may be omitted:


[2/4] SGI Altix Block Transfer Engine Support
	Implements a driver to shift the zeroing off the cpu into hardware.
	With hardware support the impact of zeroing on the system is reduced
	to a minimum.

[4/4] Architecture specific clear_page updates
	Adds second order argument to clear_page and updates all arches.
	This allows the zeroing of large areas of memory without repeately
	invoking clear_page() for the page allocator, scrubd and the huge
	page allocator.


