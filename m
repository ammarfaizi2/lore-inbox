Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVHIAPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVHIAPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVHIAPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:15:47 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:8126 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932383AbVHIAPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:15:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=eK9gwTQsZIQUiyhCSkyVCdNz9X1dVta6vzMdUS2oaFosvE/k6GkjP4OpydwM45GHxxjcGMWYo+sB/4qtG0g0Xv3JdA6lOIyYABeSVWnbgMzD4jhE9+SNX+5syNMrFxEO/KGWUxz1pEcTRPetOkmCRAynIGcMDKuF9IGZqo5D1C8=  ;
Message-ID: <42F7F5AE.6070403@yahoo.com.au>
Date: Tue, 09 Aug 2005 10:15:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][patch 0/2] mm: remove PageReserved
References: <42F57FCA.9040805@yahoo.com.au> <200508090710.00637.phillips@arcor.de>
In-Reply-To: <200508090710.00637.phillips@arcor.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Sunday 07 August 2005 13:28, Nick Piggin wrote:

>>If anyone has an issue with the patches or my merge plan, let's
>>get some discussion going.
> 
> 
> You forgot to mention what replaces PageReserved: the VM_RESERVED vma flag, 
> which is now added to the whole zap_pte call chain.  A slight efficiency win?  
> Anyway, it looks like forward progress because some inner loops are a little 
> straighter.  I've always wondered what PG_reserved was actually doing, and 
> now I know: compensating for the missing vma parameter in the zap call 
> chains.
> 

Basically, it was doing a whole lot of vaguely related things. It
was set for ZERO_PAGE pages. It was (and still is) set for struct
pages that don't point to valid ram. Drivers set it, hoping it will
do something magical for them.

And yes, the VM_RESERVED flag is able to replace most usages.
Checking (pte_page(pte) == ZERO_PAGE(addr)) picks up others.

What we don't have is something to indicate the page does not point
to valid ram.

> Why don't you pass the vma in zap_details?  For that matter, why are addr and 
> end still passed down the zap chain when zap_details appears to duplicate 
> that information?  OK, it is because zap_details is NULL in about twice as 
> many places as it carries data.  But since the details parameter is already 
> there, would it not make sense to press it into service to slim down those 
> parameter lists a little?
> 

Possibly. I initially did it that way, but it ended up fattening
paths that don't use details. And this way is less intrusive.

> What stops swsusp from also using the vma flag?  Why does swsusp need both 
> PG_reserved and PG_nosave?
> 

Because swsusp isn't looking through a process mapping.

swsusp also uses PG_nosave_free, believe it or not. Though I think
PG_nosave and PG_nosave_free can be consolidated quite easily.

> Is there automated testing planned for this one?  It looks right as closely as 
> I've read, but it tickles an awful lot of code.
> 

I haven't planned anything. I've tested it on machines here,
but I should probably do so a bit more heavily (ie. thrashing
swap, reclaiming pagecache, etc for hours).

Thanks for having a look!

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
