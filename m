Return-Path: <linux-kernel-owner+w=401wt.eu-S932312AbWLZKbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbWLZKbu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 05:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbWLZKbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 05:31:50 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:40471 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932312AbWLZKbt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 05:31:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=fvFlBoNL7czZRpHtwvM7eLxawZcoZbsLnywV7YGXAtPhvU/wqKSFJJ3djLgTp6dMLLjWBu/8fxnBUJy2UKnh6gXUZg7HGrConfHzO25kZZdhW2ZyH/tOVQ7Yvl1KnmLtmp5q2RbqVwpjKVea3UZPgncl8m1a6jrrbOU7rXRNMUU=  ;
X-YMail-OSG: kO58QZgVM1kjCEowVs7ln7Fix_nypY3AbqvpbQZzDMzIpq6aYCh08AhzQ7NdfwatmTY7ev8ov.ktp7TrnSdFMQ8aR7m1c5JgXeWSrG7s0SaHDDQjgI5xn6vm8On29njiV9yl._HihCIv8Ak-
Message-ID: <4590F9E5.4060300@yahoo.com.au>
Date: Tue, 26 Dec 2006 21:31:01 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrei Popa <andrei.popa@i-neo.ro>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>, Hugh Dickins <hugh@veritas.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption
 on ext3)
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>  <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>  <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>  <20061222100004.GC10273@deprecation.cyrius.com>  <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost>  <20061222123249.GG13727@deprecation.cyrius.com>  <20061222125920.GA16763@deprecation.cyrius.com>  <1166793952.32117.29.camel@twins>  <20061222192027.GJ4229@deprecation.cyrius.com>  <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>  <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>  <20061224005752.937493c8.akpm@osdl.org> <1166962478.7442.0.camel@localhost>  <20061224043102.d152e5b4.akpm@osdl.org> <1166978752.7022.1.camel@localhost> <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org> <Pine.LNX.4.64.0612241029460.3671@woody.osdl.org> <Pine.LNX.4.64.0612241115130.3671@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612241115130.3671@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 24 Dec 2006, Linus Torvalds wrote:
> 
>>Peter, tell me I'm crazy, but with the new rules, the following condition 
>>is a bug:
>>
>> - shared mapping
>> - writable
>> - not already marked dirty in the PTE
> 
> 
> Ok, so how about this diff.
> 
> I'm actually feeling good about this one. It really looks like 
> "do_no_page()" was simply buggy, and that this explains everything.

Still trying to catch up here, so I'm not going to reply to any old
stuff and just start at the tip of the thread... Other than to say
that I really like cancel_page_dirty ;)

I think your patch is quite right so that's a good catch. But I'm not
too surprised that it does not help the problem, because I don't
think we have started shedding any old pte_dirty tests at
unmap/reclaim-time, have we? So the dirty bit isn't going to get lost,
as such.

I was hoping that you've almost narrowed it down to the filesystem
writeback code, with the last few mails?

Nick

> Please please please test. Throw all the other patches away (with the 
> possible exception of the "update_mmu_cache()" sanity checker, which is 
> still interesting in case some _other_ place does this too).
> 
> Don't do the "wait_on_page_writeback()" thing, because it changes timings 
> and might hide thngs for the wrong reasons.  Just apply this on top of a 
> known failing kernel, and test.
> 
> 			Linus
> 
> ---
> diff --git a/mm/memory.c b/mm/memory.c
> index 563792f..cf429c4 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2247,21 +2249,23 @@ retry:
>  	if (pte_none(*page_table)) {
>  		flush_icache_page(vma, new_page);
>  		entry = mk_pte(new_page, vma->vm_page_prot);
> -		if (write_access)
> -			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> -		set_pte_at(mm, address, page_table, entry);
>  		if (anon) {
>  			inc_mm_counter(mm, anon_rss);
>  			lru_cache_add_active(new_page);
>  			page_add_new_anon_rmap(new_page, vma, address);
> +			if (write_access)
> +				entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  		} else {
>  			inc_mm_counter(mm, file_rss);
>  			page_add_file_rmap(new_page);
> +			entry = pte_wrprotect(entry);
>  			if (write_access) {
>  				dirty_page = new_page;
>  				get_page(dirty_page);
> +				entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  			}
>  		}
> +		set_pte_at(mm, address, page_table, entry);
>  	} else {
>  		/* One of our sibling threads was faster, back out. */
>  		page_cache_release(new_page);
> 


-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
