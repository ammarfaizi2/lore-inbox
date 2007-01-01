Return-Path: <linux-kernel-owner+w=401wt.eu-S932638AbXAAQoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbXAAQoz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 11:44:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbXAAQoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 11:44:55 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:33089 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932413AbXAAQoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 11:44:54 -0500
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
	that again
From: James Bottomley <James.Bottomley@SteelEye.com>
To: David Miller <davem@davemloft.net>
Cc: torvalds@osdl.org, miklos@szeredi.hu, rmk+lkml@arm.linux.org.uk,
       arjan@infradead.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20061231.131216.105428418.davem@davemloft.net>
References: <E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu>
	 <20061231.124017.85689231.davem@davemloft.net>
	 <Pine.LNX.4.64.0612311249240.4473@woody.osdl.org>
	 <20061231.131216.105428418.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 01 Jan 2007 10:44:36 -0600
Message-Id: <1167669876.5302.60.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-31 at 13:12 -0800, David Miller wrote:
> From: Linus Torvalds <torvalds@osdl.org>
> Date: Sun, 31 Dec 2006 12:58:45 -0800 (PST)
> 
> > So there really is two different cases here:
> > 
> >  - flush the cache as seen by A PARTICULAR virtual mapping.
> > 
> >    This is ptrace, but it's other things like "unmap page from this VM" 
> >    too.
> > 
> >  - flush the cache for all possible virtual mappings - simply because we 
> >    don't even know who has it mapped dirty. 
> > 
> >    And the thing is, the more I think about it, the more I end up 
> >    wondering:
> > 
> >    I'm not even sure how valid this is. Whatever path needs to do this is 
> >    likely doing something wrong anyway. If there are multiple possible 
> >    sources of cache conflicts, the thing is a disaster and the end result 
> >    depends on our ordering anyway, so I'd argue that it is just about as 
> >    correct to flush as it is to NOT flush.
> > 
> > So I have this nagging suspicion that "flush_dcache_page()" is always a 
> > bug when it is about "virtual caches". It should NEVER flush any virtual 
> > caches, since that whole operations is by necessity something where you 
> > should be talking about _which_ virtual cache you should flush.
> 
> It's the aliasing between the _1_ valid user mapping and the kernel's
> virtual mapping, that's the problem and that's very valid and that's
> why we have flush_dcache_page() to begin with.
> 
> > So "flush_dcache_page()" is - I think - more validtly thought about as 
> > just DMA coherency (in a system where DMA does not participate in 
> > _physical_ cache coherency). Not about virtual caches at all.
> 
> And I guess that's what you're trying to say here.
> 
> I'm beginning to think that Ralf Baechle had the best idea here,
> where he recently made it such that platforms could override
> kmap() and friends even on non-HIGHMEM configurations.
> 
> In theory it's the perfect interface to handle this problem,
> you flush exactly where the physical page is made visible to
> the kernel for a cpu load/store.  All the locations where that
> happens are perfectly annotated already with kmap() calls.

Actually, this was proposed here:

http://marc.theaimsgroup.com/?t=115409754100003

When I updated the interface to work for the combined VIPT/PIPT cache on
the latest pariscs.  However, there were no takers for the idea.

James


