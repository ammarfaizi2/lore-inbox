Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWBFKrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWBFKrF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWBFKrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:47:05 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:13137 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751061AbWBFKrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:47:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iDkCmLzfC0LA9IajjGQnoQwj9ea1NnvWYj0D3D2rnCEisXwVLSNFzBuIi45sdTJWPv17mp21FiM/cHPh5z3e3iKKcmz+aTw2mwIzfYeMEMFDiP8tMZguog5yFL2gv3ASvKW04xiBmjVva722e9ORhJzQPb0AXtXj+tbGH+kO6d0=  ;
Message-ID: <43E7291B.7090701@yahoo.com.au>
Date: Mon, 06 Feb 2006 21:46:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Shantanu Goel <sgoel01@yahoo.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [VM PATCH] rotate_reclaimable_page fails frequently
References: <20060205150259.1549.qmail@web33007.mail.mud.yahoo.com> <20060206010506.GA30318@dmt.cnet>
In-Reply-To: <20060206010506.GA30318@dmt.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> Marking PG_writeback pages as PG_rotated once they're chosen candidates
> for eviction increases the number of rotated pages dramatically, but
> that does not necessarily increase performance (I was unable to see any
> performance increase under the limited testing I've done, even though
> the pgrotated numbers were _way_ higher).
> 

Just FYI, this change can end up leaking the PageReclaim bit
which IIRC can make bad noises in the free pages check, and
is also a tiny bit sloppy unless we also do a precautionary
ClearPageReclaim in writeback paths.

However I don't think it is a bad idea in theory.

> Another issue is that increasing the number of rotated pages increases
> lru_lock contention, which might not be an advantage for certain
> workloads.
> 
> So, any change in this area needs careful study under a varied,
> meaningful set of workloads and configurations (which has not been
> happening very often).
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 5a61080..26319eb 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -447,8 +447,14 @@ static int shrink_list(struct list_head 
>  		if (page_mapped(page) || PageSwapCache(page))
>  			sc->nr_scanned++;
>  
> -		if (PageWriteback(page))
> +		if (PageWriteback(page)) {
> +			/* mark writeback, candidate for eviction pages as 
> +			 * PG_reclaim to free them immediately once they're 
> +			 * laundered.
> +			 */
> +			SetPageReclaim(page);
>  			goto keep_locked;
> +		}
>  
>  		referenced = page_referenced(page, 1);
>  		/* In active use or really unfreeable?  Activate it. */
> 

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
