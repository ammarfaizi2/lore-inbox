Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbUKKV4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbUKKV4n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262375AbUKKVxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:53:46 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5252
	"EHLO x30.random") by vger.kernel.org with ESMTP id S262372AbUKKVuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:50:46 -0500
Date: Thu, 11 Nov 2004 22:50:43 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041111215043.GC5138@x30.random>
References: <20041111112922.GA15948@logos.cnet> <20041111154238.GD18365@x30.random> <20041111123850.GA16349@logos.cnet> <20041111165050.GA5822@x30.random> <318860000.1100194936@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <318860000.1100194936@[10.10.2.4]>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2004 at 09:42:17AM -0800, Martin J. Bligh wrote:
> >> > I disagree about the design of killing anything from kswapd. kswapd is
> >> > an async helper like pdflush and it has no knowledge on the caller (it
> >> > cannot know if the caller is ok with the memory currently available in
> >> > the freelists, before triggering the oom). 
> >> 
> >> If zone_dma / zone_normal are below pages_min no caller is "OK with
> >> memory currently available" except GFP_ATOMIC/realtime callers.
> > 
> > If the GFP_DMA zone is filled, and nobody allocates with GFP_DMA,
> > nothing should be killed and everything should run fine, how can you
> > get this right from kswapd?
> 
> Technically, that seems correct, but does it really matter much? We're 
> talking about 
> 
> "it's full of unreclaimable stuff" vs
> "it's full of unreclaimable stuff and someone tried to allocate a page".

exactly, that's the difference.

> So the difference is only ever one page, right? Doesn't really seem 

there's not a single page of difference.

> worth worrying about - we'll burn that in code space for the algorithms
> to do this ;-)

are you kidding? burnt space in the algorithm? the burnt space is to
move the thing in kswapd, period. that global variable and message
passing protocol between the task context and kswapd is the total waste.
There's no waste at all in moving the oom killer up the stack to
alloc_pages and in the future up outside alloc_pages with some more
higher level API.
