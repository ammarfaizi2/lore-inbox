Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbULWT3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbULWT3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 14:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbULWT3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 14:29:44 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:48559 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261271AbULWT3Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 14:29:24 -0500
Date: Thu, 23 Dec 2004 11:29:10 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
cc: akpm@osdl.org, linux-ia64@vger.kernel.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Prezeroing V2 [0/3]: Why and When it works
In-Reply-To: <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change from V1 to V2:
o Add explanation--and some bench results--as to why and when this optimization works
  and why other approaches have not worked.
o Instead of zero_page(p,order) extend clear_page to take second argument
o Update all architectures to accept second argument for clear_pages
o Extensive removal of all page allocs/clear_page combination from all archs
o Blank / typo fixups
o SGI BTE zero driver update: Use node specific variables instead of cpu specific
  since a cpu may be responsible for multiple nodes.

The patches increasing the page fault rate (introduction of atomic pte operations
and anticipatory prefaulting) do so by reducing the locking overhead and are
therefore mainly of interest for applications running in SMP systems with a high
number of cpus. The single thread performance does just show minor increases.
Only the performance of multi-threaded applications increase significantly.

The most expensive operation in the page fault handler is (apart of SMP
locking overhead) the zeroing of the page. This zeroing means that all
cachelines of the faulted page (on Altix that means all 128 cachelines of
128 byte each) must be loaded and later written back. This patch allows to
avoid having to load all cachelines if only a part of the cachelines of
that page is needed immediately after the fault.

Thus the patch will only be effective for sparsely accessed memory which
is typicalfor anonymous memory and pte maps. Prezeroed pages will be used
for those purposes. Unzeroed pages will be used as usual for the other
purposes.

Others have also thought that prezeroing could be a benefit and have tried
provide a way to provide zeroed pages to the page fault handler:

http://marc.theaimsgroup.com/?t=109914559100004&r=1&w=2
http://marc.theaimsgroup.com/?t=109777267500005&r=1&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=104931944213955&w=2

However, these attempt have tried to zero pages soon to be
accessed (and which may already have recently been accessed). Elements of
these pages are thus already in the cache. Approaches like that will only
shift processing a bit and not yield performance benefits.
Prezeroing only makes sense for pages that are not currently needed and
that are not in the cpu caches. Pages that have recently been touched and
that soon will be touched again are better hot zeroed since the zeroing
will largely be done to cachelines already in the cpu caches.

The patch makes prezeroing very effective by:

1. Aggregating zeroing operations to only apply to pages of higher order,
which results in many pages that will later become order 0 to be
zeroed in one go. For that purpose the existing clear_page function is
extended and made to take an additional argument specifying the order of
the page to be cleared.

2. Hardware support for offloading zeroing from the cpu. This avoids
the invalidation of the cpu caches by extensive zeroing operations.

The result is a significant increase of the page fault performance even for
single threaded applications:

w/o patch:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
   4   3    1    0.146s     11.155s  11.030s 69584.896  69566.852

w/patch
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
   1   1    1    0.014s      0.110s   0.012s524292.194 517665.538

The performance can only be upheld if enough zeroed pages are available.
In a heavy memory intensive benchmarks the system could potentially
run out of zeroed pages but the efficient algorithm for page zeroing still
shows this to be a winner:

(8 way system with 6 GB RAM, no hardware zeroing support)

w/o patch:
Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 4   3    1    0.146s     11.155s  11.030s 69584.896  69566.852
 4   3    2    0.170s     14.909s   7.097s 52150.369  98643.687
 4   3    4    0.181s     16.597s   5.079s 46869.167 135642.420
 4   3    8    0.166s     23.239s   4.037s 33599.215 179791.120

w/patch
Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
 4   3    1    0.183s      2.750s   2.093s268077.996 267952.890
 4   3    2    0.185s      4.876s   2.097s155344.562 263967.292
 4   3    4    0.150s      6.617s   2.097s116205.793 264774.080
 4   3    8    0.186s     13.693s   3.054s 56659.819 221701.073

Note that zeroing of pages makes no sense if the application
touches all cache lines of a page allocated (there is no influence of
prezeroing on benchmarks like lmbench for that reason) since the extensive
caching of modern cpus means that the zeroes written to a hot zeroed page
will then be overwritten by the application in the cpu cache and thus
the zeros will never make it to memory! The test program used above only
touches one 128 byte cache line of a 16k page (ia64).

Here is another test in order to gauge the influence of the number of cache
lines touched on the performance of the prezero enhancements:

 Gb Rep Thr CLine  User      System   Wall  flt/cpu/s fault/wsec
  1  1    1   1    0.01s      0.12s   0.01s500813.853 497925.891
  1  1    1   2    0.01s      0.11s   0.01s493453.103 472877.725
  1  1    1   4    0.02s      0.10s   0.01s479351.658 471507.415
  1  1    1   8    0.01s      0.13s   0.01s424742.054 416725.013
  1  1    1  16    0.05s      0.12s   0.01s347715.359 336983.834
  1  1    1  32    0.12s      0.13s   0.02s258112.286 256246.731
  1  1    1  64    0.24s      0.14s   0.03s169896.381 168189.283
  1  1    1 128    0.49s      0.14s   0.06s102300.257 101674.435

The benefits of prezeroing become smaller the more cache lines of
a page are touched. Prezeroing can only be effective if memory is not
immediately touched after the anonymous page fault.

The patch is composed of 4 parts:

[1/4] Introduce __GFP_ZERO
	Modifies the page allocator to be able to take the __GFP_ZERO flag
	and returns zeroed memory on request. Modifies locations throughout
	the linux sources that retrieve a page and then zero it to request
	a zeroed page.

[2/4] Architecture specific clear_page updates
	Adds second order argument to clear_page and updates all arches.

Note: The two first pages may be used alone if no zeroing engine is wanted.

[3/4] Page Zeroing
	Adds management of ZEROED and NOT_ZEROED pages and a background daemon
	called scrubd. scrubd is disabled by default but can be enabled
	by writing an order number to /proc/sys/vm/scrub_start. If a page
	is coalesced of that order or higher then the scrub daemon will
	start zeroing until all pages of order /proc/sys/vm/scrub_stop and
	higher are zeroed and then go back to sleep.

	In an SMP environment the scrub daemon is typically
	running on the most idle cpu. Thus a single threaded application running
	on one cpu may have the other cpu zeroing pages for it etc. The scrub
	daemon is hardly noticable and usually finished zeroing quickly since most
	processors are optimized for linear memory filling.

[4/4]	SGI Altix Block Transfer Engine Support
	Implements a driver to shift the zeroing off the cpu into hardware.
	With hardware support there will be minimal impact of zeroing
	on the performance of the system.
