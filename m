Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbTBUDWj>; Thu, 20 Feb 2003 22:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267099AbTBUDWj>; Thu, 20 Feb 2003 22:22:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:55740 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267098AbTBUDWh>; Thu, 20 Feb 2003 22:22:37 -0500
Date: Thu, 20 Feb 2003 19:32:35 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Performance of partial object-based rmap
Message-ID: <7830000.1045798354@[10.10.2.4]>
In-Reply-To: <20030220190819.531e119d.akpm@digeo.com>
References: <7490000.1045715152@[10.10.2.4]><278890000.1045791857@flay> <20030220190819.531e119d.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ...
>> Did some space consumption comparisons on make -j 256:
>> 
>> before:
>> 	24116 pte_chain objects in slab cache
>> after:
>> 	716 pte_chain objects in slab cache
>> 
>> The vast majority of anonymous pages (for which we're using the non
>> object based method) are singletons, and hence use pte_direct ...
>> hence the massive space reduction.
>> 
> 
> OK.  And that'll help the fork+exit CPU overhead too.
> 
> Let's talk about this a bit.
> 
> The problem remains that this design means that we need to walk all the vma's
> which are attached to a page's address_space in an attempt to unmap that
> page.
> 
> Whereas with the existing pte_chain walk, we only need to visit those pte's
> which are still mapping the page.
> 
> So with 1000 processes, each holding 1000 vma's against the same file, we
> need to visit 1,000,000 vma's to unmap one page.  If that unmap attempt is
> unsuccessful, we *still* need to walk 1,000,000 vma's next time we try to
> unmap it.

That's completely true, but I don't accept the 1000*1000 as a realistic
scenario. I do acknowledge that it will perform worse on pageout operations
in some cases ... there's certainly a tradeoff here, and we need to measure
things on the other side of the scenario.
 
> Whereas with pte-based rmap, we do not need to walk over already-unmapped
> pte's.
> 
> So it is easy to see how there is at least a theoretical collapse in search
> complexity here.  Which affects all platforms.  And, of course there is a
> demonstrated space consumption collapse with the existing code which affects
> big ia32 machines.

The benefits come in both space and performance ... the space issue is,
admittedly, most important for ia32, but will to some extent affect all
machines.
 
> It is not clear how realistic the search complexity problem really is - the
> 2.4 virtual scan has basically the same problem and there is not a lot of
> evidence of people hurting from it.  In fact we see more hurt from full rmap
> than from the 1000x1000 thing.
> 
> The search complexity _may_ affect less exotic things than databases.  Many
> processes mapping libc, say.  But in that case the number of VMA's is very
> small - if this was a realistic problem then 2.4 would be in real strife.
>
> Dave's patch is simple enough to merit serious consideration.

Indeed, it's really astoundingly small.
 
> <scratches head>
> 
> I think the guiding principle here is that we should not optimise for the
> uncommon case (as rmap is doing), and we should not allow the uncommon case
> to be utterly terrible (as Dave's patch can do).

Absolutely. As long as uncommon is slightly realistic that it might happen.
 
> It would be overly optimistic to assume that hugetlb pages will save us here.
> 
> Any bright ideas?

I'd like to see a semi-realistic workload that demonstrates the downside
of this method ... both to prove that it can exceed the upside, and so that
we can use it to analyse any possible fixes. All I have at the moment is
some theory - I can perfectly understand the problem in theory, and see
that it exists ... but I'd like at least a synthetic microbenchmark that
pretends at least to simulate something vaguely realistic. I'm perfectly
prepared to write it myself if someone can show some pseudo-code or whatever
that gives a rough scenario, and some description of why they think that's
realistic. Personally, I don't really see it in reality.

We definitely need to do some UP tests under reasonably memory pressure 
swapping to disk ... I'll try to get that underway soon.

M.
