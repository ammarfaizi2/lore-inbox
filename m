Return-Path: <linux-kernel-owner+w=401wt.eu-S1752061AbWL2MJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbWL2MJs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 07:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752100AbWL2MJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 07:09:48 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:42170 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752061AbWL2MJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 07:09:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xuNM4Ojn49uB7mjOoRk9P2gGBERP4VfFolkPK8qms74si3CTmEBOhjlWMPGB1PGvWiQHbaEI5H6pWjbJUSx9juuXDy/SzFYaN9iwWx0+AexylxpTkt9XD7ootwg2p+MFE/IPi+nOGOpRMeQIMpDQTJbvYaGi0P02XAACZAbOfek=  ;
X-YMail-OSG: 1Y1OqHAVM1kFNRdX14xsOxQref_ZCJMVUAE13JFoyyAL6xpn3020RG8g4.LPVSsNOxENykSoSLurHukHKGpRe7jMi.IdpH1X0LTub74UwUH1wocMxgHfKpbCkFGhqYFeDUca2U2WNQQTdmY-
Message-ID: <45950561.6040508@yahoo.com.au>
Date: Fri, 29 Dec 2006 23:09:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, kenneth.w.chen@intel.com,
       guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com,
       Andrew Morton <akpm@osdl.org>, a.p.zijlstra@chello.nl, tbm@cyrius.com,
       arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org> <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org> <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org> <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org> <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org> <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey nice work Linus!

Linus Torvalds wrote:
> 
> On Fri, 29 Dec 2006, Linus Torvalds wrote:
> 
>>Hmm? I'd love it if somebody else wrote the patch and tested it, because 
>>I'm getting sick and tired of this bug ;)
> 
> 
> Who the hell am I kidding? I haven't been able to sleep right for the last 
> few days over this bug. It was really getting to me.
> 
> And putting on the thinking cap, there's actually a fairly simple an 
> nonintrusive patch.

Yeah *this* makes more sense. And in retrospect it was simple, we
can't just throw out pte dirtiness information if the page doesn't
have all buffers dirtied.

> It still has a tiny tiny race (see the comment), but I 
> bet nobody can really hit it in real life anyway, and I know several ways 
> to fix it, so I'm not really _that_ worried about it.

Well the race isn't a data loss one, is it? Just a case where the
pte may be dirty but the page dirty state not accounted for.

Can we fix it by just putting the page_mkclean back inside the
TestClearPageDirty check, and re-clearing PG_dirty after redoing
the set_page_dirty?


> 
> The patch is mostly a comment. The "real" meat of it is actually just a 
> few lines.
> 
> Can anybody get corruption with this thing applied? It goes on top of 
> plain v2.6.20-rc2.
> 
> 		Linus
> 
> ----
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index b3a198c..ec01da1 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -862,17 +862,46 @@ int clear_page_dirty_for_io(struct page *page)
>  {
>  	struct address_space *mapping = page_mapping(page);
>  
> -	if (!mapping)
> -		return TestClearPageDirty(page);
> -
> -	if (TestClearPageDirty(page)) {
> -		if (mapping_cap_account_dirty(mapping)) {
> -			page_mkclean(page);
> +	if (mapping && mapping_cap_account_dirty(mapping)) {
> +		/*
> +		 * Yes, Virginia, this is indeed insane.
> +		 *
> +		 * We use this sequence to make sure that
> +		 *  (a) we account for dirty stats properly
> +		 *  (b) we tell the low-level filesystem to
> +		 *      mark the whole page dirty if it was
> +		 *      dirty in a pagetable. Only to then
> +		 *  (c) clean the page again and return 1 to
> +		 *      cause the writeback.
> +		 *
> +		 * This way we avoid all nasty races with the
> +		 * dirty bit in multiple places and clearing
> +		 * them concurrently from different threads.
> +		 *
> +		 * Note! Normally the "set_page_dirty(page)"
> +		 * has no effect on the actual dirty bit - since
> +		 * that will already usually be set. But we
> +		 * need the side effects, and it can help us
> +		 * avoid races.
> +		 *
> +		 * We basically use the page "master dirty bit"
> +		 * as a serialization point for all the different
> +		 * threds doing their things.
> +		 *
> +		 * FIXME! We still have a race here: if somebody
> +		 * adds the page back to the page tables in
> +		 * between the "page_mkclean()" and the "TestClearPageDirty()",
> +		 * we might have it mapped without the dirty bit set.
> +		 */
> +		if (page_mkclean(page))
> +			set_page_dirty(page);
> +		if (TestClearPageDirty(page)) {
>  			dec_zone_page_state(page, NR_FILE_DIRTY);
> +			return 1;
>  		}
> -		return 1;
> +		return 0;
>  	}
> -	return 0;
> +	return TestClearPageDirty(page);
>  }
>  EXPORT_SYMBOL(clear_page_dirty_for_io);
>  
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
