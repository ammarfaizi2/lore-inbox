Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbULUT4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbULUT4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 14:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbULUT4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 14:56:19 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:22449 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261579AbULUT4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 14:56:05 -0500
Date: Tue, 21 Dec 2004 11:55:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: "Luck, Tony" <tony.luck@intel.com>, Robin Holt <holt@sgi.com>,
       Adam Litke <agl@us.ibm.com>, linux-ia64@vger.kernel.org,
       torvalds@osdl.org, linux-mm@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Increase page fault rate by prezeroing V1 [0/3]: Overview
In-Reply-To: <41C20E3E.3070209@yahoo.com.au>
Message-ID: <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patches increasing the page fault rate (introduction of atomic pte operations
and anticipatory prefaulting) do so by reducing the locking overhead and are
therefore mainly of interest for applications running in SMP systems with a high
number of cpus. The single thread performance does just show minor increases.
Only the performance of multi-threaded applications increase significantly.

The most expensive operation in the page fault handler is (apart of SMP
locking overhead) the zeroing of the page that is also done in the page fault
handler. Others have seen this too and have tried provide a way to provide
zeroed pages to the page fault handler:

http://marc.theaimsgroup.com/?t=109914559100004&r=1&w=2
http://marc.theaimsgroup.com/?t=109777267500005&r=1&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=104931944213955&w=2

The problem so far has been that simple zeroing of pages simply shifts
the time spend somewhere else. Plus one would not want to zero hot
pages.

This patch addresses those issues by making it more effective to zero pages by:

1. Aggregating zeroing operations to mainly apply to larger order pages
which results in many later order 0 pages to be zeroed in one go.
For that purpose a new achitecture specific function zero_page(page, order)
is introduced.

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

This is a performance increase by a factor 8!

The performance can only be upheld if enough zeroed pages are available.
In a heavy memory intensive benchmark the system will run out of these very
fast but the efficient algorithm for page zeroing still makes this a winner
(8 way system with 6 GB RAM, no hardware zeroing support):

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

The patch is composed of 3 parts:

[1/3] Introduce __GFP_ZERO
	Modifies the page allocator to be able to take the __GFP_ZERO flag
	and returns zeroed memory on request. Modifies locations throughout
	the linux sources that retrieve a page and then zeroe it to request
	a zeroed page.
	Adds new low level zero_page functions for i386, ia64 and x86_64.
	(x64_64 untested)

[2/3] Page Zeroing
	Adds management of ZEROED and NOT_ZEROED pages and a background daemon
	called scrubd. scrubd is disable by default but can be enabled
	by writing an order number to /proc/sys/vm/scrub_start. If a page
	is coalesced of that order then the scrub daemon will start zeroing
	until all pages of order /proc/sys/vm/scrub_stop and higher are
	zeroed.

[3/3]	SGI Altix Block Transfer Engine Support
	Implements a driver to shift the zeroing off the cpu into hardware.
	With hardware support there will be minimal impact of zeroing
	on the performance of the system.


