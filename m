Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbULIXvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbULIXvD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 18:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbULIXvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 18:51:03 -0500
Received: from zeus.kernel.org ([204.152.189.113]:46776 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261680AbULIXuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 18:50:50 -0500
Date: Thu, 9 Dec 2004 15:49:53 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V12: rss tasklist vs sloppy rss
In-Reply-To: <20041209232945.GH2714@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0412091543100.1369@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>
 <Pine.LNX.4.58.0412091348130.7478@schroedinger.engr.sgi.com>
 <20041209225259.GG2714@holomorphy.com> <Pine.LNX.4.58.0412091500360.1102@schroedinger.engr.sgi.com>
 <20041209232945.GH2714@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Dec 2004, William Lee Irwin III wrote:

> On Thu, Dec 09, 2004 at 03:07:13PM -0800, Christoph Lameter wrote:
> > Sloppy rss left the rss in the section of mm that contained the counters.
> > So that has a separate cacheline. The idea of putting the atomic ops in a
> > group was to only have one exclusive cacheline for mmap_sem and the rss.
> > Which could lead to more bouncing of a single cache line rather than
> > bouncing multiple cache lines less. But it seems to me that the problem
> > essentially remains the same if the rss counter is not split.
>
> The prior results Robin Holt cited were that the counter needed to be
> in a different cacheline from the ->mmap_sem and ->page_table_lock.
> We shouldn't need to evaluate splitting for the atomic RSS algorithm.

Ok. Then we would need rss and rss_anon on two additional cache lines?
Both rss and anon_rss on one line? mmap_sem and the page_table_lock also
each on different cache lines?

> A faithful implementation would just move the atomic counters away from
> the ->mmap_sem and ->page_table_lock (just shuffle some mm fields).
> Obviously a complete set of results won't be needed unless it's very
> surprisingly competitive with the stronger algorithms. Things should be
> fine just making sure that behaves similarly to the one with the shared
> cacheline with ->mmap_sem in the sense of having a curve of similar shape
> on smaller systems. The absolute difference probably doesn't matter,
> but there is something to prove, and the largest risk of not doing so
> is exaggerating the low-end performance benefits of stronger algorithms.

The advantage in the split rss solution is that it can be placed on the
same cacheline as other stuff from task that is already needed. So there
is minimal overhead involved. But I can certainly give it a spin and see
what the results are.

