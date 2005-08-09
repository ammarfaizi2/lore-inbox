Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVHIJti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVHIJti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVHIJti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:49:38 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:42941 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932492AbVHIJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:49:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mweHJAKTcVBe4QeKKU5H4kfdSCbMUMDEm5nH5hrU30Moh/tUTvoIZ3EiiqLqwb0eWU1KB77QaMHGHXm2q1Jqo0KexNj/qLJMBgKuahsJZs5X7ntV4vIGF7zo/yHIRrByVPtBJSZGmYfWGAgjoqICSWeHwA/bc4qnfm88BOB3oFc=  ;
Message-ID: <42F87C24.4080000@yahoo.com.au>
Date: Tue, 09 Aug 2005 19:49:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Daniel Phillips <phillips@arcor.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
References: <42F57FCA.9040805@yahoo.com.au>	 <200508090710.00637.phillips@arcor.de>  <42F7F5AE.6070403@yahoo.com.au> <1123577509.30257.173.camel@gaston>
In-Reply-To: <1123577509.30257.173.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

> 
> I have no problem keeping PG_reserved for that, and _ONLY_ for that.
> (though i'd rather see it renamed then). I'm just afraid by doing so,
> some drivers will jump in the gap and abuse it again...

Sure it would be renamed (better yet may be a slower page_is_valid()
that doesn't need to use a flag).

There is always the possibility for driver abuse, I guess... however
as it is now, the tree is basically past the critical mass of self
perpetuation (ie. cut-n-paste). So getting rid of that should certianly
help get things cleaner.

> Also, we should
> make sure we kill the "trick" of refcounting only in one direction.
> Either we refcount both (but do nothing, or maybe just BUG_ON if the
> page is "reserved" -> not valid RAM), or we don't refcount at all.
> 

Yep, that's done. Actually having a BUG_ON PageReserved in the refcount
functions isn't a bad idea for the initial merge, and should help allay
my fears that I might have introduced refcount leaks on PageReserved
pages.

> For things like Cell, We'll really end up needing struct page covering
> the SPUs for example. That is not valid RAM, shouldn't be refcounted,
> but we need to be able to have nopage() returning these etc...
>

In that case, remap_pfn_range should take care of it for you by
setting the VM_RESERVED flag on the vma.

Swsusp is the main "is valid ram" user I have in mind here. It
wants to know whether or not it should save and restore the
memory of a given `struct page`.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
