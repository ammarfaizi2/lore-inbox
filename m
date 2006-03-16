Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752275AbWCPJNt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbWCPJNt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 04:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752280AbWCPJNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 04:13:49 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:45683 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752275AbWCPJNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 04:13:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=3/SehuwhSrQXs0IqhVx2Oi5wr3laMsadp6mEP0Bv4m3vNUNtxLRmXF8ACKS4c+yGhcRnMlCqbnFQ3zNDtVEPjvfrIkSjgy8aSuYcq2VooH3/PtKW2UIZL/eqrJEefsDw+5aMhutsj82UM9JJ2C0rqeXFpT1GGAyN3zjvjDA1M6M=  ;
Message-ID: <4419062C.6000803@yahoo.com.au>
Date: Thu, 16 Mar 2006 17:31:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Andrew Morton <akpm@osdl.org>, "Bryan O'Sullivan" <bos@pathscale.com>,
       Hugh@veritas.com, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
 driver
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>	<ada4q27fban.fsf@cisco.com>	<1141948516.10693.55.camel@serpentine.pathscale.com>	<ada1wxbdv7a.fsf@cisco.com>	<1141949262.10693.69.camel@serpentine.pathscale.com>	<20060309163740.0b589ea4.akpm@osdl.org>	<1142470579.6994.78.camel@localhost.localdomain>	<ada3bhjuph2.fsf@cisco.com>	<1142475069.6994.114.camel@localhost.localdomain>	<adaslpjt8rg.fsf@cisco.com>	<1142477579.6994.124.camel@localhost.localdomain>	<20060315192813.71a5d31a.akpm@osdl.org>	<1142485103.25297.13.camel@camp4.serpentine.com>	<20060315213813.747b5967.akpm@osdl.org> <ada8xrbszmx.fsf@cisco.com>
In-Reply-To: <ada8xrbszmx.fsf@cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Andrew> Someone left PG_private set on this page (!)
> 
> How does PG_private get set?  Could doing a > 1 page kmalloc set it
> (because we end up with a compound page)?
> 

I think you should avoid slab allocations for user mappings because
you don't know that it will do compound pages properly, depending on
slab implementation details.

Also, slab lifetimes are not controlled by page refcounting, so when
your driver decides to kfree the memory, a process could still have
refs on the pages via get_user_pages, which might be reused for
unrelated slab allocations.

>     Andrew> You need to decide who "owns" these pages.  Once that's
>     Andrew> decided, it tells you who should release them.
> 
>     [... really good guide to mapping pages into userspace snipped ...]
> 
> How about the case where one wants to map pages from
> dma_alloc_coherent() into userspace?  It seems one should do
> get_page() in .nopage, and then the driver can do dma_free_coherent()
> when the vma is released.
> 

I think so, provided you set VM_IO on the vma. You need VM_IO to
ensure that get_user_pages callers can't hijack your page's lifetime
rules (Mr. Christmas tree has been carefully engineered for optimal
confusion and best bug count).

> Or maybe it's just simpler to use vm_insert_page() in the .mmap method
> and not try to be fancy with .nopage?
> 

That's not being particularly fancy. Either way you need to set VM_IO
on the vma, and make sure the correct memory freeing function (in this
case dma_free_coherent) is called sometime after the last userspace
ref goes away.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
