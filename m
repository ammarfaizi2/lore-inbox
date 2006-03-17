Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932808AbWCQWPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbWCQWPF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 17:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbWCQWPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 17:15:04 -0500
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:19811 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932807AbWCQWPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 17:15:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=e5zWYDBvePklpipZoiuUr8u2pkWp3pLK/wiZiZs4CFKY1LBKZ/duFtsUO1CaRBaLIUkKWWxzwoHxMDe2vZF2XOEmX9gMp7ogn0K3DqKHu8yVO9Rvlw4vi84fDXsrSOl+wG/A4b9JFv4hYZ2lCHJkmAeUZWq9zar0rCGFaUnf0kk=  ;
Message-ID: <441B34DA.3040709@yahoo.com.au>
Date: Sat, 18 Mar 2006 09:14:50 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@pathscale.com>
CC: Hugh Dickins <hugh@veritas.com>, Roland Dreier <rdreier@cisco.com>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>	 <ada4q27fban.fsf@cisco.com>	 <1141948516.10693.55.camel@serpentine.pathscale.com>	 <ada1wxbdv7a.fsf@cisco.com>	 <1141949262.10693.69.camel@serpentine.pathscale.com>	 <20060309163740.0b589ea4.akpm@osdl.org>	 <1142470579.6994.78.camel@localhost.localdomain>	 <ada3bhjuph2.fsf@cisco.com>	 <1142475069.6994.114.camel@localhost.localdomain>	 <adaslpjt8rg.fsf@cisco.com>	 <1142477579.6994.124.camel@localhost.localdomain>	 <20060315192813.71a5d31a.akpm@osdl.org>	 <1142485103.25297.13.camel@camp4.serpentine.com>	 <20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>	 <4419062C.6000803@yahoo.com.au>	 <Pine.LNX.4.61.0603161426010.21570@goblin.wat.veritas.com>	 <441A04D0.3060201@yahoo.com.au> <1142611861.28538.22.camel@serpentine.pathscale.com>
In-Reply-To: <1142611861.28538.22.camel@serpentine.pathscale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:
> On Fri, 2006-03-17 at 11:37 +1100, Nick Piggin wrote:
> 
> 
>>But it doesn't look like dma_alloc_coherent is guaranteed to return
>>memory allocated from the regular page allocator, nor even memory
>>backed by a struct page.
> 
> 
> Hmm.  Which of the implementations that you've seen will return
> something not backed by a struct page?  On the half dozen arches I've
> looked at (i386/x86_64, powerpc, sparc64, ia64, mips), every one uses
> either kmalloc, __get_free_pages, or __alloc_pages at some point, and I
> think they all have struct pages behind them.
> 

Well I was mainly just looking at the interface definition and that it
only returns an address. i386 specifically looks like it can return
ioremap memory in some cases, right? (which I don't think needs to have
a struct page behind it)

> 
>>For example, I see one that returns kmalloc()ed memory. If the pages
>>for the slab are already allocated then __GFP_COMP will not do anything
>>there.
> 
> 
> Bleh.  Perhaps I'm being dense here, but if I'm making a request of
> non-zero order and the slab has already been allocated, won't it be
> populated with compound pages anyway?  Or will it have been allocated as
> a single giant compound page, just handing me back individual hunks of
> the appropriate size?
> 

By the looks of the slab implementation, it will vary depending on
whether or not the slab was already allocated and whether that was using
__GFP_COMP or not.

> I ask this because I seemed to be getting compound pages out of
> dma_alloc_coherent even when I *wasn't* passing in __GFP_COMP.  This is
> apparently why PG_private was set on the individual pages I was getting
> back.
> 

I think the reason was a little different: you're getting a higher order
page. This can either be compound or non-compound. If it is not compound,
then you (or the VM) can easily end up freeing one of its constituent
pages (and PagePrivate is set when that page is free in the allocator).
Then when you go to free the whole higher-order page, it finds that one
of its constituent pages has PagePrivate set (which is a bug).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
