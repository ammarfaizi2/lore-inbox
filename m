Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVADXl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVADXl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVADXjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:39:33 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25306 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262415AbVADXMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:12:44 -0500
Date: Tue, 4 Jan 2005 15:12:36 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
cc: Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, linux-mm@kvack.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Prezeroing V3 [0/4]: Discussion and i386 performance tests
In-Reply-To: <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
 <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change from V2 to V3:
o Updates for clear_page on various platforms
o Performance measurements on i386 (2x PIII-450 384M RAM)
o Port patches to 2.6.10-bk7
o Add scrub_load so that a high load prevents scrubd from running
  (So that people may feel better about this approach. Set by
  default to 999 so its off. The typical result of not running kscrubd
  under high loads is to slow the system down even further since zeroing
  large consecutive areas of memory is more efficient than zeroing page
  size chunks. Memory subsystems are typically optimized for linear accesses
  and reach their peak performance if large areas of memory are written to)
o Various fixes

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

Others have also thought that prezeroing could be a benefit and have tried
provide a way to provide zeroed pages to the page fault handler:

http://marc.theaimsgroup.com/?t=109914559100004&r=1&w=2
http://marc.theaimsgroup.com/?t=109777267500005&r=1&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=104931944213955&w=2

However, these attempt have tried to zero pages that are like to be used
soon (and that may have recently been accessed). Elements of these pages
are thus already in the cpu caches. Approaches like that will only shift
processing to somewhere else and not bring any performance benefits.
Prezeroing only makes sense for pages that are not currently needed and that
are not in the cpu caches. Pages that have recently been touched and that
soon will be touched again are better hot zeroed since the zeroing will
largely be done to cachelines already in the cpu caches.

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

The result is a significant increase of the page fault performance even for
single threaded applications (i386 2x PIII-450 384M RAM allocating 256M in
each run):

w/o patch:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0   1    1    0.006s      0.389s   0.039s157455.320 157070.694
  0   1    2    0.007s      0.607s   0.032s101476.689 190350.885

w/patch
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0   1    1    0.008s      0.083s   0.009s672151.422 664045.899
  0   1    2    0.005s      0.129s   0.008s459629.796 741857.373

The performance can only be upheld if enough zeroed pages are available.
In a heavy memory intensive benchmark the system may run out of these very
fast but the efficient algorithm for page zeroing still makes this a winner
(2 way system with 384MB RAM, no hardware zeroing support). In the following
measurement the test is repeated 10 times allocating 256M each in rapid
succession which would deplete the pool of zeroed pages quickly):

w/o patch:
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0  10    1    0.058s      3.913s   3.097s157335.774 157076.932
  0  10    2    0.063s      6.139s   3.027s100756.788 190572.486

w/patch
 Gb Rep Threads   User      System     Wall flt/cpu/s fault/wsec
  0  10    1    0.059s      1.828s   1.089s330913.517 330225.515
  0  10    2    0.082s      1.951s   1.094s307172.100 320680.232

Note that zeroing of pages makes no sense if the application
touches all cache lines of a page allocated (there is no influence of
prezeroing on benchmarks like lmbench for that reason) since the extensive
caching of modern cpus means that the zeroes written to a hot zeroed page
will then be overwritten by the application in the cpu cache and thus
the zeros will never make it to memory! The test program used above only
touches one 128 byte cache line of a 16k page (ia64). Sparsely
populated and accessed areas are typical for lots of applications.

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

The benefits of prezeroing are reduced to minimal quantities if all
cachelines of a page are touched. Prezeroing can only be effective
if the whole page is not immediately used after the page fault.

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
	daemon is hardly noticable and usually finished zeroing quickly since
	most processors are optimized for linear memory filling.

[4/4]	SGI Altix Block Transfer Engine Support
	Implements a driver to shift the zeroing off the cpu into hardware.
	With hardware support there will be minimal impact of zeroing
	on the performance of the system.
