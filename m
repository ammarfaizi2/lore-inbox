Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751725AbWJTOjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbWJTOjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 10:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbWJTOjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 10:39:52 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:64594 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751724AbWJTOjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 10:39:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=IEtKEp6DhwizbgQ4ZF/TrEGipfLu9i+wSWt5fOKjV4M3hvy+7QCrfmySRS2Nrt9pYoZeY6ip4Xddl3ZawNXWFrtbrI4oMSqNK0B0ebL/1gJlGrdBdmt56v0eU8Dy0NZlXMYNr8Rm0eNadjY/jTIGi3LIp+q3U6RW3W0hXZ7mFZM=  ;
Message-ID: <4538DFAC.1090206@yahoo.com.au>
Date: Sat, 21 Oct 2006 00:39:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: ralf@linux-mips.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
References: <1161275748231-git-send-email-ralf@linux-mips.org>	<4537B9FB.7050303@yahoo.com.au>	<20061019181346.GA5421@linux-mips.org> <20061019.155939.48528489.davem@davemloft.net>
In-Reply-To: <20061019.155939.48528489.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> From: Ralf Baechle <ralf@linux-mips.org>
> Date: Thu, 19 Oct 2006 19:13:46 +0100
> 
> 
>>That would require changing the order of cache flush and tlb flush.
>>To keep certain architectures that require a valid translation in
>>the TLB the cacheflush has to be done first.  Not sure if those
>>architectures need a writeable mapping for dirty cachelines - I
>>think hypersparc was one of them.
> 
> 
> There just has to be "a mapping" in the TLB so that the L2 cache can
> translate the virtual address to a physical one for the writeback to
> main memory.

So moving the flush_cache_mm below the copy_page_range, to just
before the flush_tlb_mm, would work then? This would make the
race much smaller than with this patchset.

But doesn't that still leave a race?

What if another thread writes to cache after we have flushed it
but before flushing the TLBs? Although we've marked the the ptes
readonly, the CPU won't trap if the TLB is valid? There must be
some special way for the arch to handle this, but I can't see it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
