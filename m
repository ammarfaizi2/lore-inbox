Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269079AbUINDTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269079AbUINDTR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUINDTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:19:17 -0400
Received: from holomorphy.com ([207.189.100.168]:30096 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269079AbUINDMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:12:43 -0400
Date: Mon, 13 Sep 2004 20:12:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nickpiggin@yahoo.com.au, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-ID: <20040914031237.GW9106@holomorphy.com>
References: <414133EB.8020802@yahoo.com.au> <20040910174915.GA4750@logos.cnet> <20040912045636.GA2660@holomorphy.com> <4143D07E.3030408@yahoo.com.au> <20040912062703.GF2660@holomorphy.com> <4143E6C6.40908@yahoo.com.au> <20040912071948.GH2660@holomorphy.com> <20040912004256.59a74c28.akpm@osdl.org> <20040914021844.GN9106@holomorphy.com> <20040913195731.28dcc2e3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040913195731.28dcc2e3.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 12:42:56AM -0700, Andrew Morton wrote:
>>> Instantiation via normal fault-in becomes lock-intensive once you have
>>> enough CPUs.  At low CPU count the page zeroing probably preponderates.

William Lee Irwin III <wli@holomorphy.com> wrote:
>> But that's mm->page_table_lock, for which pagevecs aren't used,

On Mon, Sep 13, 2004 at 07:57:31PM -0700, Andrew Morton wrote:
> It is zone->lru_lock and pagevecs are indeed used.  See
> do_anonymous_page->lru_cache_add_active.

zone->lru_lock is acquired there, but I believe locks in the mm are the
dominant overhead in such scenarios.


William Lee Irwin III <wli@holomorphy.com> wrote:
>> mlock() is the case I have in hand, though I've only heard of it being
>> problematic on vendor kernels. MAP_POPULATE is underutilized in
>> userspace thus far, so I've not heard anything about it good or bad.

On Mon, Sep 13, 2004 at 07:57:31PM -0700, Andrew Morton wrote:
> If you're referring to mlock() of an anonymous vma then that should all go
> through do_anonymous_page->lru_cache_add_active anyway?

It's a shared memory segment. It's not clear that it was lock
contention per se that was the issue in this case, merely a lot of
(unexpected) cpu overhead. I'm going to check in with the reporter of
the issue to see whether this still an issue in 2.6.x. The vendor
solution was to ask the app politely not to mlock the shm segments; in
2.6.x this can be addressed if it's still an issue. I believe a fair
amount of the computational expense may be attributed to atomic
operations (not lock contention per se) that may be reduced by batching.
i.e. the pagevecs would merely be used to reduce the number of slow
atomic operations and to avoid walking trees from the top-down for each
element, not to address lock contention.


-- wli
