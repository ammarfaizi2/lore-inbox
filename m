Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317868AbSFNBhY>; Thu, 13 Jun 2002 21:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317869AbSFNBhX>; Thu, 13 Jun 2002 21:37:23 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:58362 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317868AbSFNBhX>; Thu, 13 Jun 2002 21:37:23 -0400
Date: Thu, 13 Jun 2002 21:37:24 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, Richard Brunner <richard.brunner@amd.com>,
        mark.langsdorf@amd.com
Subject: Re: New version of pageattr caching conflict fix for 2.4
Message-ID: <20020613213724.C21542@redhat.com>
In-Reply-To: <20020613221533.A2544@wotan.suse.de> <20020613210339.B21542@redhat.com> <20020614032429.A19018@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 03:24:29AM +0200, Andi Kleen wrote:
> > This version is missing a few of the fixes included in my version: 
> > it doesn't properly flush global tlb entries, or update the page 
> 
> Sure it does. INVLPG (__flush_tlb_one) flushes global entries.

It failed to do so in my testing.  The only safe way of flushing 
global entries is to disable them in cr4 before attempting the 
tlb flush.

> > tables of processes which have copied 4MB page table entries into 
> > their page tables.  Also, the revert_page function must be called 
> 
> That's done in set_pmd_page.

Doh.  I should consume coffee after waking up but before posting...

> > before the tlb flush and free the page after the tlb flush, or 
> > else tlb prefetching on the P4 can cache stale pmd pointers.  I'd 
> 
> Fair point. Hmm, I had that correct, but somehow it got messed up again.
> 
> Another thing that probably needs to be added is that DRM needs 
> some change_page_attr() calls too, because it does private AGP mappings.

I'd still prefer to get the typing of the page table manipulations 
correct.  Also, the code can prematurely revert to 4MB mappings if 
the caller does anything awry, like changing the attributes back to 
standard attributes on the same page twice.  The usage of #ifdef __i386__ 
is inconsistent, too.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
