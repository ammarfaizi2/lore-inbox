Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVEXICp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVEXICp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 04:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVEXICp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 04:02:45 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:56166 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261423AbVEXICT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 04:02:19 -0400
Message-ID: <4292DF78.5000900@yahoo.com.au>
Date: Tue, 24 May 2005 18:02:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [bugfix] try_to_unmap_cluster() passes out-of-bounds pte to 
   pte_unmap()
References: <20050516021302.13bd285a.akpm@osdl.org>     <20050522212734.GF2057@holomorphy.com>     <20050523171406.483cdf69.akpm@osdl.org>     <20050524024849.GH2057@holomorphy.com> <Pine.LNX.4.61.0505240535540.5541@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0505240535540.5541@goblin.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Mon, 23 May 2005, William Lee Irwin III wrote:
> 
>>On Mon, May 23, 2005 at 05:14:06PM -0700, Andrew Morton wrote:
>>
>>>I must say that I continue to find this approach a bit queazifying.
>>>After some reading of the code I'd agree that yes, it's not possible for us
>>>to get here with `pte' pointing at the first slot of the pte page, but it's
>>>not 100% obvious and it's possible that someone will come along later and
>>>will change things in try_to_unmap_cluster() which cause this unmap to
>>>suddenly do the wrong thing in rare circumstances.
>>>IOW: I'd sleep better at night if we took a temporary and actually unmapped
>>>the thing which we we got back from pte_offset_map()..  Am I being silly?
> 
> 
> There's a similar argument for queasiness in all the other (8 or more)
> instances of the idiom.  I think we originally adopted (and I furthered)
> this pte_unmap(pte - 1) idiom because in the majority of architecture's
> configurations pte_unmap does nothing at all, so we resented assigning
> a pointless variable in some critical loops.
> 

Still, the compiler should be able to eliminate that extra register
as well as it can eliminate the intermediate (pte - 1) result (that
is to say, I hope perfectly in this day and age).

It may be more of an issue with architectures that actually *do* do
something in pte_unmap, in which case perhaps you increase the
register pressure over the critical loop? I guess we can just laugh
at them.

> 
>>Not at all. I merely attempt to minimize diffsize by default. An
>>alternative implementation follows (changelog etc. to be taken
>>from the prior patch) in case it saves the time (however short) needed
>>to write it yourself.
> 
> 
> Either of wli's patches is fine with me.  There are several levels on
> which try_to_unmap_cluster is harder to understand than the others,
> and no good reason to resist the variable assignment.
> 
> We could rewrite pte_unmap to avoid the issue completely, since its
> job is to unmap (or pretend to unmap) KM_PTE0's pte if the address
> is in the fixmap area: but changing it to tolerate an off-by-one
> address gives a queasy feeling too.
> 

Looks like no architecture (other than maybe frv?) even uses the
kvaddr argument to kunmap_atomic unless HIGHMEM_DEBUG/DEBUG_HIGHMEM
is enabled. If you stored that info elsewhere, you wouldn't even
need to pass the argument in.

But hmm... I don't see anyone getting motivated enough to rewrite the
debug code over this issue :)

-- 
SUSE Labs, Novell Inc.

