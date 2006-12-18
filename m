Return-Path: <linux-kernel-owner+w=401wt.eu-S1754658AbWLRV4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbWLRV4v (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbWLRV4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:56:51 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:7440 "EHLO
	amsfep18-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754658AbWLRV4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 16:56:50 -0500
Subject: Re: 2.6.19 file content corruption on ext3
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
In-Reply-To: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>
	 <20061217040620.91dac272.akpm@osdl.org> <1166362772.8593.2.camel@localhost>
	 <20061217154026.219b294f.akpm@osdl.org> <1166460945.10372.84.camel@twins>
	 <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
	 <1166466272.10372.96.camel@twins>
	 <Pine.LNX.4.64.0612181030330.3479@woody.osdl.org>
	 <1166468651.6983.6.camel@localhost>
	 <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org>
	 <1166471069.6940.4.camel@localhost>
	 <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
Content-Type: text/plain
Date: Mon, 18 Dec 2006 22:49:35 +0100
Message-Id: <1166478575.10372.106.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-18 at 12:14 -0800, Linus Torvalds wrote:
> 
> On Mon, 18 Dec 2006, Andrei Popa wrote:
> > 
> > I dropped that patch and added WARN_ON(1), the unified patch is
> > attached.
> > 
> > I got corruption: "Hash check on download completion found bad chunks,
> > consider using "safe_sync"."
> 
> Ok. That is actually _very_ interesting.
> 
> It's interesting because (a) the corruption obviously goes away with the 
> one-liner that effectively disables "page_mkclean_one()".
> 
> So that tells us that yes, it's a PTE dirty bit that matters.
> 
> But at the same time, it's interesting that it still happens when we try 
> to re-add the dirty bit. That would tell me that it's one of two cases:
> 
>  - there is another caller of page cleaning that should have done the same 
>    thing (we could check that by just doing this all _inside_ the 
>    page_mkclean() thing)
> 
> OR:
> 
>  - page_mkclean_one() is simply buggy.
> 
> And I'm starting to wonder about the second case. But it all LOOKS really 
> fine - I can't see anything wrong there (it uses the extremely 
> conservative "ptep_get_and_clear()", and seems to flush everything right 
> too, through "ptep_establish()").

How about this:

we get confused on what PG_dirty tells us, we fall back to pte_dirty,
transfer pte_dirty to PG_dirty and clear pte_dirty. Now it happens
again, however we don't have pte_dirty to fall back to anymore.

This would explain why disabling pte_mkclean() does make it go away and
non of the other tried approaches works.

We really need a way to sort out PG_dirty, independent of pte_dirty. 

