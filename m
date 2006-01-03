Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWACFBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWACFBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 00:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWACFBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 00:01:19 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:2934 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751152AbWACFBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 00:01:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=kyrRCcNJ0JGEDhdD9bpODjPyJJB8WmEykJDqpC9ewllvsvZzuNq1bjXrMgI3UxazQX0Z85GCom0M7FR3LujMgFHlhdQgsjkpd5cdj8IJ5VusLfAk1Y5HrexPJTRHSfn925LxSTLhVzYp80cbdTYKDzpXSkn70nzfqGr+nySM2KU=  ;
Subject: Re: [RFC] Event counters [1/3]: Basic counter functionality
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Christoph Lameter <clameter@sgi.com>, lkml <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
In-Reply-To: <20051231202602.GC3903@dmt.cnet>
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com>
	 <20051231064615.GB11069@dmt.cnet> <43B63931.6000307@yahoo.com.au>
	 <20051231202602.GC3903@dmt.cnet>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 16:01:04 +1100
Message-Id: <1136264464.5261.23.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 18:26 -0200, Marcelo Tosatti wrote:
> Hi Nick!
> 

Hey Marcelo!

> On Sat, Dec 31, 2005 at 06:54:25PM +1100, Nick Piggin wrote:
> > 
> > Hi Guys,
> > 
> > I've been waiting for some mm/ patches to clear from -mm before commenting
> > too much... however I see that this patch is actually against -mm itself,
> > with my __mod_page_state stuff in it... that makes the page state accounting
> > much lighter weight AND is not racy.
> 
> It is racy with reference to preempt (please refer to the race condition
> described above):
> 
> diff -puN mm/rmap.c~mm-page_state-opt mm/rmap.c
> --- devel/mm/rmap.c~mm-page_state-opt   2005-12-13 22:25:01.000000000 -0800
> +++ devel-akpm/mm/rmap.c        2005-12-13 22:25:01.000000000 -0800
> @@ -451,7 +451,11 @@ static void __page_set_anon_rmap(struct 
> 
>         page->index = linear_page_index(vma, address);
>  
> -       inc_page_state(nr_mapped);
> +       /*
> +        * nr_mapped state can be updated without turning off
> +        * interrupts because it is not modified via interrupt.
> +        */
> +       __inc_page_state(nr_mapped);
>  }
> 
> And since "nr_mapped" is not a counter for debugging purposes only, you 
> can't be lazy with reference to its consistency.
> 
> I would argue that you need a preempt save version for this important
> counters, surrounded by preempt_disable/preempt_enable (which vanish 
> if one selects !CONFIG_PREEMPT).
> 

I think it should not be racy because the function should always be
called with the page table lock held, which disables preempt. I guess
the comment should be explicit about that as well.

There were some runtime warnings that come up when this patch first
went into -mm because of a silly typo, however that should now be
resolved too.

> As Christoph notes, debugging counter consistency can be lazy, not even
> requiring correct preempt locking (hum, this is debatable, needs careful
> verification).
>  
> > So I'm not exactly sure why such a patch as this is wanted now? Are there
> > any more xxx_page_state hotspots? (I admit to only looking at page faults,
> > page allocator, and page reclaim).
> 
> A consolidation of the good parts of both would be interesting.
> 
> I don't see much point in Christoph's naming change to "event_counter", 
> why are you doing that?
> 
> And follows an addition to your's mm-page_state-opt-docs.patch. Still
> need to verify "nr_dirty" and "nr_unstable".
> 
> Happy new year!
> 

Thanks, happy new year to you too!

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
