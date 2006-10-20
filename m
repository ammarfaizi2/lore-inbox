Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992610AbWJTP5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992610AbWJTP5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992591AbWJTP5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:57:38 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:23476 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932265AbWJTP5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:57:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=SPDEXaoB32MqdJD8JWiU2RgHhpHRdl2oqjoOzvDXMRNQrXedzs9RKl9IHW8ddgMb8f29FL+QoqNvoKASCR/ykYA1F1pMECbr9cK22klEGzgsGXyhPQZ9kQZSQlgDHEUMt5ZDqH+91j+fdXuyX1H0f1N0+oq3x7oaMSGZB7tvcp0=  ;
Message-ID: <4538F1EC.1020806@yahoo.com.au>
Date: Sat, 21 Oct 2006 01:57:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Miller <davem@davemloft.net>, ralf@linux-mips.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
References: <1161275748231-git-send-email-ralf@linux-mips.org> <4537B9FB.7050303@yahoo.com.au> <20061019181346.GA5421@linux-mips.org> <20061019.155939.48528489.davem@davemloft.net> <4538DFAC.1090206@yahoo.com.au> <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 21 Oct 2006, Nick Piggin wrote:
> 
>>So moving the flush_cache_mm below the copy_page_range, to just
>>before the flush_tlb_mm, would work then? This would make the
>>race much smaller than with this patchset.
>>
>>But doesn't that still leave a race?
>>
>>What if another thread writes to cache after we have flushed it
>>but before flushing the TLBs? Although we've marked the the ptes
>>readonly, the CPU won't trap if the TLB is valid? There must be
>>some special way for the arch to handle this, but I can't see it.
> 
> 
> Why not do the cache flush _after_ the TLB flush? There's still a mapping, 
> and never mind that it's read-only: the _mapping_ still exists, and I 
> doubt any CPU will not do the writeback (the readonly bit had better 
> affect the _frontend_ of the memory pipeline, but affectign the back end 
> would be insane and very hard, since you can't raise a fault any more).

I didn't think that would work if there is no TLB. But if the writeback
can cause a TLB reload, and then bypass the readonly protection, then
yes would close all races.

Of course, you may also want to do the racy cache flush before the
TLB flush as well, so you don't immediately take a load of TLB misses
to write it out.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
