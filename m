Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965103AbWCUUwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103AbWCUUwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWCUUwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:52:34 -0500
Received: from mx.pathscale.com ([64.160.42.68]:50620 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S965103AbWCUUwc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:52:32 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, rdreier@cisco.com, torvalds@osdl.org,
       hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
	 <1142477579.6994.124.camel@localhost.localdomain>
	 <20060315192813.71a5d31a.akpm@osdl.org>
	 <1142485103.25297.13.camel@camp4.serpentine.com>
	 <20060315213813.747b5967.akpm@osdl.org>
	 <Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	 <1142523201.25297.56.camel@camp4.serpentine.com>
	 <Pine.LNX.4.61.0603161629150.23220@goblin.wat.veritas.com>
	 <1142538765.10950.16.camel@serpentine.pathscale.com>
	 <Pine.LNX.4.61.0603162003140.25033@goblin.wat.veritas.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Tue, 21 Mar 2006 12:52:27 -0800
Message-Id: <1142974347.29199.87.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 20:10 +0000, Hugh Dickins wrote:

> You wisely remarked earlier that you'd not yet checked for memory leaks:
> that is of course the complementary, less obvious, error to the troubles
> you've been having so far: and I wish you luck when you come to check,
> hoping that I haven't merely misled you from one side to the other!

Well, as it turns out, we're not out of the woods.

The memory that we allocate with dma_alloc_coherent is indeed being
handed back to us as compound pages, but something horrible is happening
after that.

Our nopage handler does an unconditional get_page on every page that it
gets handed, but nothing seems to ever call put_page on those pages.  At
least, I infer this to be the case, because the page counts look all
wrong when I free them.  The kernel thinks I leak 4.5MB of memory every
time I run "hello, world" (~1300 allocations of 4K).

If you recall, we have three different areas of memory that userspace
can mmap.  Two of these (rcvhdrq and pioavailregs) are allocated at
driver init time, and freed when the driver exits.  The third (egrbufs)
is allocated when the process opens the char device, and closed when the
char device's release method is called.

I've instrumented my calls to dma_alloc_coherent and dma_free_coherent,
and they are getting called when they should be.  However, on each
successive run of "hello, world", the page counts on the rcvhdrq and
pioavailregs pages (the ones allocated at driver start) increase,
without ever decreasing.  And for the egrbufs pages, the page counts go
up to 8 (I'm allocating 32K at a time, so get_page is called 8 times per
compound page), but I never get handed the same struct page on two
successive runs, so I conclude that the struct pages are leaking.

So my belief is that I am freeing the memory behind the struct pages,
but the struct pages themselves stay stuck with a permanently elevated
count.  This is obviously not a winning strategy.

On 2.6.15, this all "works", but I have the poor kernel thinking it
loses 4.5MB of memory on every run.  On 2.6.16-rc6, I get a BUG.  I'll
have to do a bit of work to reproduce it, so I can't paste it here yet.

So my quandary is thus: what am I doing wrong?  It seems that my calls
to get_page are more or less correct, but should I be doing a put_page
somewhere, too, such as when the char dev's release method is called,
prior to calling dma_free_coherent?

	<b

