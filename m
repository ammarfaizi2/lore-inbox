Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbUKFNSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbUKFNSF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 08:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUKFNSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 08:18:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46232 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261385AbUKFNSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 08:18:00 -0500
Date: Sat, 6 Nov 2004 08:05:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@novell.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041106100516.GA22514@logos.cnet>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106012018.GT8229@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 02:20:18AM +0100, Andrea Arcangeli wrote:
> On Fri, Nov 05, 2004 at 03:32:50PM -0800, Jesse Barnes wrote:
> > On Friday, November 05, 2004 12:01 pm, Marcelo Tosatti wrote:
> > > In my opinion the correct approach is to trigger the OOM killer
> > > when kswapd is unable to free pages. Once that is done, the number
> > > of tasks inside page reclaim is irrelevant.
> > 
> > That makes sense.

Hi Andrea,

> I don't like it, kswapd may fail balancing because there's a GFP_DMA
> allocation that eat the last dma page, but we should not kill tasks if
> we fail to balance in kswapd, we should kill tasks only when no fail
> path exists (i.e. only during page faults, everything else in the kernel
> has a fail path and it should never trigger oom).

The OOM killer is only going to get triggered if kswapd is not able 
to make _any_ progress in all zones.  So it wont "fail balancing because there's 
a GFP_DMA allocation that eat the last dma page".  

As long as frees _one_ page during all passes from DEF_PRIORITY till priority=0, 
it wont kill any task. See?

I dont get your point.

> If you move it in kswapd there's no way to prevent oom-killing from a
> syscall allocation (I guess even right now it would go wrong in this
> sense, but at least right now it's more fixable).

I dont understand what you mean. "prevent oom-killing from a syscall allocation" ?

>  I want to move the oom
> kill outside the alloc_page paths. The oom killing is all about the page
> faults not having a fail path, and in turn the oom killing should be
> moved in the page fault code, not in the allocator. Everything else
> should keep returning -ENOMEM to the caller.

Isnt OOM killing all about the reclaiming efforts not being able to make progress? 

> So to me moving the oom killer into kswapd looks a regression. 

To me having tasks trigger the OOM kill is fundamentally broken 
because it doesnt take into account kswapd page freeing 
efforts which are in-progress at the very moment.

That makes senses a lot of sense to me - would love to be proved
wrong.

See, its completly screwed right now. The code inside out_of_memory()
which only triggers OOM if it has happened several times during the 
past few seconds is horrible and shows how bad it is. 
