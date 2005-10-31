Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbVJaJSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbVJaJSA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVJaJSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:18:00 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:42857 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932070AbVJaJSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:18:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=VIQZICkFcG0+aYxAvGnXzOqXH0t+ndEx0aPHR4qkdHw6pO8BcM22cGAkpKfALmOdnhb4Uig3Y+GWOyra4WhSnQh4vzev/Vi+UPVSHQBE0oYLqovDYSVMCWczKdydV1M7TXuuv1FNJgJONm7yDRVCzWeVfnhlA0Z3mbZHbrVhRh0=  ;
Message-ID: <4365E1B4.4050409@yahoo.com.au>
Date: Mon, 31 Oct 2005 20:19:48 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: munmap extremely slow even with untouched mapping.
References: <20051028013738.GA19727@attica.americas.sgi.com> <43620138.6060707@yahoo.com.au> <Pine.LNX.4.61.0510281557440.3229@goblin.wat.veritas.com> <43644C22.8050501@yahoo.com.au> <Pine.LNX.4.61.0510301631360.2848@goblin.wat.veritas.com> <4365DF9A.5040101@yahoo.com.au>
In-Reply-To: <4365DF9A.5040101@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> The address based work estimate for unmapping (for lockbreak) is and
> always was horribly inefficient for sparse mappings. The problem is most
> simply explained with an example:
> 
> If we find a pgd is clear, we still have to call into unmap_page_range
> PGDIR_SIZE / ZAP_BLOCK_SIZE times, each time checking the clear pgd, in
> order to progress the working address to the next pgd.
> 
> The fundamental way to solve the problem is to keep track of the end address
> we've processed and pass it back to the higher layers.
> 
> From: Robin Holt <holt@sgi.com>
> 
> Modification to completely get away from address based work estimate and
> instead use an abstract count, with a very small cost for empty entries as
> opposed to present pages.
> 
> On 2.6.14-git2, ppc64, and CONFIG_PREEMPT=y, mapping and unmapping 1TB of
> virtual address space takes 1.69s; with the following patch applied, this
> operation can be done 1000 times in less than 0.01s
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 

Note that I think this patch will cripple our nice page table folding
in the unmap path, due to no longer using the 'next' from p??_addr_end,
even if the compiler is very smart.

I haven't confirmed this by looking at assembly, however I'd be almost
sure this is the case. Possibly a followup patch would be in order so
as to restore this, but I couldn't think of a really nice way to do it.

Basically we only want to return the return of the next level
zap_p??_range in the case that it returns with zap_work < 0.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
