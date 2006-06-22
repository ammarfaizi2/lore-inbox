Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751850AbWFVRfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbWFVRfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWFVRfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:35:54 -0400
Received: from silver.veritas.com ([143.127.12.111]:25945 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751850AbWFVRfy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:35:54 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,166,1149490800"; 
   d="scan'208"; a="39473057:sNHT22681908"
Date: Thu, 22 Jun 2006 18:35:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Christoph Lameter <clameter@sgi.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
       David Miller <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 6/6] mm: remove some update_mmu_cache() calls
In-Reply-To: <Pine.LNX.4.64.0606220935130.28760@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0606221824260.13355@blonde.wat.veritas.com>
References: <20060619175243.24655.76005.sendpatchset@lappy>
 <20060619175347.24655.67680.sendpatchset@lappy>
 <Pine.LNX.4.64.0606221646000.4977@blonde.wat.veritas.com>
 <Pine.LNX.4.64.0606220935130.28760@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Jun 2006 17:35:53.0452 (UTC) FILETIME=[4F8FDAC0:01C69622]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Christoph Lameter wrote:
> On Thu, 22 Jun 2006, Hugh Dickins wrote:
> 
> > The answer I expect is that update_mmu_cache is essential there in
> > do_wp_page (reuse case) and handle_pte_fault, on at least some if
> > not all of those arches which implement it.  That without those
> > lines, they'll fault and refault endlessly, since the "MMU cache"
> > has not been updated with the write permission.
> 
> Yes a likely scenario.
>  
> > But omitted from mprotect, since that's dealing with a batch of
> > pages, perhaps none of which will be faulted in the near future:
> > a waste of resources to update for all those entries.
> 
> So we intentially allow mprotect to be racy?

It's intentionally allowed to be racy (ambiguous whether a racing
thread sees protections before or protections after) up until the
flush_tlb_range.  Should be well-defined from there on.
Or am I misunderstanding you?

> > But now I wonder, why does do_wp_page reuse case flush_cache_page?
> 
> Some arches may have virtual caches?

Sorry, I don't get it, you'll have to spell it out to me in detail.
We have a page mapped for reading, we're about to map that same page
for writing too.  We have no modifications to flush yet,
why flush_cache_page there?

Hugh
