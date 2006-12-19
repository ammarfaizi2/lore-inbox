Return-Path: <linux-kernel-owner+w=401wt.eu-S932768AbWLSKmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbWLSKmv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 05:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932775AbWLSKmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 05:42:51 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:32920 "HELO
	smtp110.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932768AbWLSKmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 05:42:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=rRnszN/B5HpVlxqRyYppZ31iYHwHUmR322ppKd1Pez0tA2WgNe0lbNdQSAFeUEmNHw2oNS8bQ2t+eX/+r6jP4hSBLIPhiUuA9bKl99OBTTRYSb6BItqiqhNlYA4jKHnc2rCgOR8kH5BAskwV1WNmMI2duk99fdHLItGWVIfXFT8=  ;
X-YMail-OSG: QU8aE6sVM1mgcY8NtTSj3Ee8b8rFkcKEQFPr5JmrzHnmeM6rcTKr_BbnT9YKlkrzKikymvNYAQPplyz4mS5fmJWHhcNKY1nCClfTZjS3BXgSRJ01LmQvyw--
Message-ID: <4587C205.10509@yahoo.com.au>
Date: Tue, 19 Dec 2006 21:42:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
References: <1166314399.7018.6.camel@localhost>	<20061217040620.91dac272.akpm@osdl.org>	<1166362772.8593.2.camel@localhost>	<20061217154026.219b294f.akpm@osdl.org>	<1166460945.10372.84.camel@twins>	<Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>	<45876C65.7010301@yahoo.com.au>	<Pine.LNX.4.64.0612182230301.3479@woody.osdl.org>	<45878BE8.8010700@yahoo.com.au>	<Pine.LNX.4.64.0612182313550.3479@woody.osdl.org>	<Pine.LNX.4.64.0612182342030.3479@woody.osdl.org>	<4587B762.2030603@yahoo.com.au> <20061219023255.f5241bb0.akpm@osdl.org>
In-Reply-To: <20061219023255.f5241bb0.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 19 Dec 2006 20:56:50 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Linus Torvalds wrote:
>>
>>
>>>NOTICE? First you make a BIG DEAL about how dirty bits should never get 
>>>lost, but THE VERY SAME FUNCTION actually very much on purpose DOES drop 
>>>the dirty bit for when it's not in the page tables.
>>
>>try_to_free_buffers is quite a special case, where we're transferring
>>the page dirty metadata from the buffers to the page. I think Andrew
>>would have a better grasp of it so he could correct me, but what it
>>does is legitimate.
> 
> 
> Well it used to be.  After 2.6.19 it can do the wrong thing for mapped
> pages.

Yes, that is what I was trying to get at.

>  But it turns out that we don't feed it mapped pages, apart from
> pagevec_strip() and possibly races against pagefaults.

True, and I think we have pretty well established that this isn't the
cause of Andrei's problem, but I think we all agree it is *a* bug?

And surely Andrei's data corruption will be of the same flavour in
that test_clear_page_dirty somewhere is now stripping pte dirty bits
where it shouldn't? (because it went away after Peter nooped that
behaviour)

>>I think it could be very likely that indeed the bug is a latent one in
>>a clear_page_dirty caller, rather than dirty-tracking itself.
> 
> 
> The only callers are try_to_free_buffers(), truncate and a few scruffy
> possibly-wrong-for-fsync filesytems which aren't being used here.
> 
> 
> <spots a race in do_no_page()>
> 
> If a write-fault races with a read-fault and the write-fault loses, we forget
> to mark the page dirty.

Hmm.. in that case will the pte still be readonly, and thus the write
faulter will have to try again I think?

> 
> Something like this, but it's probably wrong - I didn't try very hard (am
> feeling ill, and vaguely grumpy)
> 
> 
> From: Andrew Morton <akpm@osdl.org>
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  mm/memory.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff -puN mm/memory.c~a mm/memory.c
> --- a/mm/memory.c~a
> +++ a/mm/memory.c
> @@ -2264,10 +2264,22 @@ retry:
>  		}
>  	} else {
>  		/* One of our sibling threads was faster, back out. */
> +		if (write_access) {
> +			/*
> +			 * We might have raced against a read-fault.  We still
> +			 * need to dirty the page.
> +			 */
> +			dirty_page = vm_normal_page(vma, address, *page_table);
> +			if (dirty_page) {
> +				get_page(dirty_page);
> +				goto dirty_it;
> +			}
> +		}
>  		page_cache_release(new_page);
>  		goto unlock;
>  	}
>  
> +dirty_it:
>  	/* no need to invalidate: a not-present page shouldn't be cached */
>  	update_mmu_cache(vma, address, entry);
>  	lazy_mmu_prot_update(entry);
> _
> 
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
