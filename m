Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269135AbUINDCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269135AbUINDCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUINDCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:02:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:39119 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269135AbUINC7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:59:34 -0400
Date: Mon, 13 Sep 2004 19:57:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: nickpiggin@yahoo.com.au, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: [pagevec] resize pagevec to O(lg(NR_CPUS))
Message-Id: <20040913195731.28dcc2e3.akpm@osdl.org>
In-Reply-To: <20040914021844.GN9106@holomorphy.com>
References: <20040909162245.606403d3.akpm@osdl.org>
	<20040910000717.GR3106@holomorphy.com>
	<414133EB.8020802@yahoo.com.au>
	<20040910174915.GA4750@logos.cnet>
	<20040912045636.GA2660@holomorphy.com>
	<4143D07E.3030408@yahoo.com.au>
	<20040912062703.GF2660@holomorphy.com>
	<4143E6C6.40908@yahoo.com.au>
	<20040912071948.GH2660@holomorphy.com>
	<20040912004256.59a74c28.akpm@osdl.org>
	<20040914021844.GN9106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >> A large stream of faults to map in a file will blow L1 caches of the
> >>  sizes you've mentioned at every kernel/user context switch. 256 distinct
> >>  cachelines will very easily be referenced between faults. MAP_POPULATE
> >>  and mlock() don't implement batching for either ->page_table_lock or
> >>  ->tree_lock, so the pagevec point is moot in pagetable instantiation
> >>  codepaths (though it probably shouldn't be).
> 
> On Sun, Sep 12, 2004 at 12:42:56AM -0700, Andrew Morton wrote:
> > Instantiation via normal fault-in becomes lock-intensive once you have
> > enough CPUs.  At low CPU count the page zeroing probably preponderates.
> 
> But that's mm->page_table_lock, for which pagevecs aren't used,

It is zone->lru_lock and pagevecs are indeed used.  See
do_anonymous_page->lru_cache_add_active.

> On Sun, Sep 12, 2004 at 12:42:56AM -0700, Andrew Morton wrote:
> > Possibly.  I wouldn't bother converting anything unless a profiler tells
> > you to though.
> 
> mlock() is the case I have in hand, though I've only heard of it being
> problematic on vendor kernels. MAP_POPULATE is underutilized in
> userspace thus far, so I've not heard anything about it good or bad.
> 

If you're referring to mlock() of an anonymous vma then that should all go
through do_anonymous_page->lru_cache_add_active anyway?

