Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWCQQ2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWCQQ2V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWCQQ2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:28:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52108 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030209AbWCQQ2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:28:20 -0500
Date: Fri, 17 Mar 2006 08:28:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Roland Dreier <rdreier@cisco.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
In-Reply-To: <1142611861.28538.22.camel@serpentine.pathscale.com>
Message-ID: <Pine.LNX.4.64.0603170825540.3618@g5.osdl.org>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain> 
 <ada4q27fban.fsf@cisco.com>  <1141948516.10693.55.camel@serpentine.pathscale.com>
  <ada1wxbdv7a.fsf@cisco.com>  <1141949262.10693.69.camel@serpentine.pathscale.com>
  <20060309163740.0b589ea4.akpm@osdl.org>  <1142470579.6994.78.camel@localhost.localdomain>
  <ada3bhjuph2.fsf@cisco.com>  <1142475069.6994.114.camel@localhost.localdomain>
  <adaslpjt8rg.fsf@cisco.com>  <1142477579.6994.124.camel@localhost.localdomain>
  <20060315192813.71a5d31a.akpm@osdl.org>  <1142485103.25297.13.camel@camp4.serpentine.com>
  <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com> 
 <4419062C.6000803@yahoo.com.au>  <Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com>
  <441A04D0.3060201@yahoo.com.au> <1142611861.28538.22.camel@serpentine.pathscale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Mar 2006, Bryan O'Sullivan wrote:
> 
> Hmm.  Which of the implementations that you've seen will return
> something not backed by a struct page?  On the half dozen arches I've
> looked at (i386/x86_64, powerpc, sparc64, ia64, mips), every one uses
> either kmalloc, __get_free_pages, or __alloc_pages at some point, and I
> think they all have struct pages behind them.

kmalloc may be backed by a "struct page", but the point is that it does 
not honor the page _count_, and as such it is totally unsuitable for any 
VM usage.

The VM relies on the page count very fundamentally, so by doing a 
"get_page()" you'll tell every other user that you have a reference to a 
page, and it won't be free'd until all references are gone. In contrast, 
if you do a "get_page()" on something that has been allocated with 
kmalloc(), the slab code will totally ignore it, and happily re-allocate 
it to something else once the _original_ allocator free's it.

So kmalloc() really isn't appropriate.

		Linus
