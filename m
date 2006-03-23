Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751419AbWCWRxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbWCWRxZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbWCWRxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:53:25 -0500
Received: from kanga.kvack.org ([66.96.29.28]:17887 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751419AbWCWRxY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:53:24 -0500
Date: Thu, 23 Mar 2006 14:53:24 -0600
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, bob.picco@hp.com, iwamoto@valinux.co.jp,
       christoph@lameter.com, wfg@mail.ustc.edu.cn, npiggin@suse.de,
       torvalds@osdl.org, riel@redhat.com
Subject: Re: [PATCH 00/34] mm: Page Replacement Policy Framework
Message-ID: <20060323205324.GA11676@dmt.cnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet> <20060322145132.0886f742.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322145132.0886f742.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 22, 2006 at 02:51:32PM -0800, Andrew Morton wrote:
> Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> >
> > 
> > This patch-set introduces a page replacement policy framework and 4 new 
> > experimental policies.
> 
> Holy cow.
> 
> > The page replacement algorithm determines which pages to swap out.
> > The current algorithm has some problems that are increasingly noticable, even
> > on desktop workloads.
> 
> Rather than replacing the whole lot four times I'd really prefer to see
> precise descriptions of these problems, see if we can improve the situation
> incrementally rather than wholesale slash-n-burn... 
>
> Once we've done that work to the best of our ability, *then* we're in a
> position to evaluate the performance benefits of this new work.  Because
> there's not much point in comparing known-to-have-unaddressed-problems old
> code with fancy new code.

IMHO the page replacement framework intent is wider than fixing the     
currently known performance problems.

It allows easier implementation of new algorithms, which are being
invented/adapted over time as necessity appears. At the moment Linux is
stuck with a single policy - and if you think for a moment about the
wide range of scenarios where Linux is being used its easy to conclude
that one policy can't fit all.

It would be great to provide an interface for easier development of
such ideas - keep in mind that page replacement is an area of active
research.

One example (which I mentioned several times) is power saving:

PB-LRU: A Self-Tuning Power Aware Storage Cache Replacement Algorithm
for Conserving Disk Energy.

> 2.6.16-rc6 seems to do OK.  I assume the cyclic patterns exploit the lru
> worst case thing?  Has consideration been given to tweaking the existing
> code, detect the situation and work avoid the problem?

Use-once fixes the cyclic access pattern case - but at the moment we don't 
have use-once for memory mapped pages.

http://marc.theaimsgroup.com/?l=linux-mm&m=113721453502138&w=2

Nick mentions:

"Yes, I found that also doing use-once on mapped pages caused fairly
huge slowdowns in some cases. File IO could much more easily cause X and
its applications to get swapped out."

Anyway, thats not the only problem with LRU, but one of them. The most
fundamental one is the lack of page access frequency book keeping:

http://www.linux-mm.org/PageReplacementTesting

Frequency

The most significant issue with LRU is that it uses too little
information to base the replacement decision: recency alone. It does not
take frequency of page accesses into account.

Here is one example from the LRU-K paper.

"The LRU-K Page-Replacement Algorithm for Database Disk Buffering":

"Consider a multi-user database application, which references randomly
chosen customer records through a clustered B-tree indexed key, CUST-ID,
to retrieve desired information. Assume simplistically that 20,000
customers exist, that a customer reeord is 2000 bytes in length, and
that space needed for the B-tree index at the leaf level, free space
included, is 20 bytes for each key entry. Then if disk pages contain
4000 bytes of usable space and ean be packed full, we require 100 pages
to hold the leaf level nodes of the B-tree index (there is a sin- gle
B-tree root node), and 10,000 pages to hold the reeords. The pattern of
reference to these pages (ignoring the B-tree root node) is clearly:
11, Rl, 12, R2, 13, R3, ... alternate references to random index leaf
pages and record pages. If we can only afford to buffer 101 pages
in memory for this application, the B-tree root node is automatic;
we should buffer all the B-tree leaf pages, since each of them is
referenced with a probability of .005 (once in each 200 general *page*
references), while it is clearly wasteful to displace one of these leaf
pages with a data *page*, since data pages have only .00005 probability
of reference (once in each 20,000 general *page* references). Using the
LRU *algorithm*, however, the pages held in memory buffers will be the
hundred most recently referenced ones. To a first approximation, this
means 50 B-tree leaf pages and 50 record pages. Given that a *page* gets
no extra credit for being referenced twice in the recent past and that
this is more likely to happen with B-tree leaf pages, there will even
be slightly more data pages present in memory than leaf pages. This
is clearly inappropriate behavior for a very common paradigm of disk
accesses."

To me it appears natural that page replacement should be pluggable and
not hard coded in the operating system.


