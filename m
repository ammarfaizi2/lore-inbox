Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbUKFPpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbUKFPpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 10:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbUKFPpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 10:45:16 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:58070 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261406AbUKFPpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 10:45:06 -0500
Date: Sat, 6 Nov 2004 16:44:15 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jesse Barnes <jbarnes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041106154415.GD3851@dualathlon.random>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <20041106100516.GA22514@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106100516.GA22514@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Sat, Nov 06, 2004 at 08:05:16AM -0200, Marcelo Tosatti wrote:
> The OOM killer is only going to get triggered if kswapd is not able 
> to make _any_ progress in all zones.  So it wont "fail balancing because there's 
> a GFP_DMA allocation that eat the last dma page".  
> 
> As long as frees _one_ page during all passes from DEF_PRIORITY till priority=0, 
> it wont kill any task. See?

It's still wrong on numa. the machine isn't oom despite kswapd couldn't
free any page (the local node will fallback in the other nodes instead)

> > If you move it in kswapd there's no way to prevent oom-killing from a
> > syscall allocation (I guess even right now it would go wrong in this
> > sense, but at least right now it's more fixable).
> 
> I dont understand what you mean. "prevent oom-killing from a syscall allocation" ?

yes. oom killing should be avoided as far as we can avoid it. Ideally we
should never invoke the oom killer and we should always return -ENOMEM
to applications. If a syscall runs oom then we can return -ENOMEM and
handle the failure gracefully instead of getting a sigkill.

With 2.4 -ENOMEM is returned and the machine doesn't deadlock when the
zone normal is full and that works fine.

> Isnt OOM killing all about the reclaiming efforts not being able to make progress? 

it's invoked when we're not able to make progress and no fail path
exists.

> To me having tasks trigger the OOM kill is fundamentally broken 
> because it doesnt take into account kswapd page freeing 
> efforts which are in-progress at the very moment.

kswapd page freeing efforts are not very useful. kswapd is an helper,
it's not the thing that can or should guarantee allocations to succeed.

The rule is that if you want to allocate 1 page, you've to free the page
yourself. Then if kswapd frees a page too, that's welcome. But keep also
in mind kswapd may be running in another cpu, and it will put the pages
back into the per-cpu queue of the other cpu. So you should really free
a page yourself to be guaranteed to find that page later on.

kswapd is more for keeping the balance between low and high so that we
never block freeing memory, and to keep the disk running.

> See, its completly screwed right now. The code inside out_of_memory()
> which only triggers OOM if it has happened several times during the 
> past few seconds is horrible and shows how bad it is. 

that's very bad indeed. But anything happening inside out_of_memory has
nothing to do with what we discussed above like Thomas Gleixner pointed
out yesterday.

these are two different things:

1) choose when we need to invoke out_of_memory
2) choose what to do inside out_of_memory

I definitely agree about the 5 sec waiting being an hack, to me even
blk_congest_wait looks an hack.
