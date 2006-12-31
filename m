Return-Path: <linux-kernel-owner+w=401wt.eu-S933225AbWLaU7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933225AbWLaU7r (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 15:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933223AbWLaU7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 15:59:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:54639 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933221AbWLaU7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 15:59:46 -0500
Date: Sun, 31 Dec 2006 12:58:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Miller <davem@davemloft.net>
cc: miklos@szeredi.hu, rmk+lkml@arm.linux.org.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
In-Reply-To: <20061231.124017.85689231.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0612311249240.4473@woody.osdl.org>
References: <20061231.014756.112264804.davem@davemloft.net>
 <20061231100007.GC1702@flint.arm.linux.org.uk> <E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu>
 <20061231.124017.85689231.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 31 Dec 2006, David Miller wrote:
>
> Even in the ptrace() case, you do want to flush all the other VMA's
> that might be out there with an aliased cached copy in the cpu cache.

I don't think that's necessarily true.

If the same page is cached differently (and virtually) in multiple 
different places, the end result is random _anyway_. The only thing you 
care about for ptrace is what the process YOU ARE TRACING sees. If 
somebody else has something else in their cachelines, that's utterly 
uninteresting to ptrace, imnsho.

So there really is two different cases here:

 - flush the cache as seen by A PARTICULAR virtual mapping.

   This is ptrace, but it's other things like "unmap page from this VM" 
   too.

 - flush the cache for all possible virtual mappings - simply because we 
   don't even know who has it mapped dirty. 

   And the thing is, the more I think about it, the more I end up 
   wondering:

   I'm not even sure how valid this is. Whatever path needs to do this is 
   likely doing something wrong anyway. If there are multiple possible 
   sources of cache conflicts, the thing is a disaster and the end result 
   depends on our ordering anyway, so I'd argue that it is just about as 
   correct to flush as it is to NOT flush.

So I have this nagging suspicion that "flush_dcache_page()" is always a 
bug when it is about "virtual caches". It should NEVER flush any virtual 
caches, since that whole operations is by necessity something where you 
should be talking about _which_ virtual cache you should flush.

So "flush_dcache_page()" is - I think - more validtly thought about as 
just DMA coherency (in a system where DMA does not participate in 
_physical_ cache coherency). Not about virtual caches at all.

(Or, possibly, we could specify that it does a _particular_ virtual cache 
flush, namely the "kernel mapping" for that page, and nothing else. So if 
you have done a "write()" system call, and actually updated a page cache 
page, _then_ it makes sense to flush the KERNEL virtual mapping to memory: 
you could think of that as the "physical" cache case).

Hmm? What say you?

		Linus
