Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbUKNRLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbUKNRLw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 12:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbUKNRLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 12:11:52 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:17377 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261318AbUKNRLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 12:11:50 -0500
Date: Sun, 14 Nov 2004 18:11:31 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Chris Ross <chris@tebibyte.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Nick Piggin <piggin@cyberone.com.au>,
       Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041114171131.GC13733@dualathlon.random>
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114100227.GA2764@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114100227.GA2764@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 08:02:27AM -0200, Marcelo Tosatti wrote:
> Take zone->all_unreclaimable into account when you move oom_kill in page_alloc.c, 
> which I now think might be the simpler fix.
> 
> shrink_caches() will fail early due to all_unreclaimable() logic (it wont 
> scan/writeout at lower priorities):
> 
> 	if (zone->all_unreclaimable && sc->priority != DEF_PRIORITY)
> 		continue;       /* Let kswapd poll it */
> 
> I disabled all_unreclaimable after 5 seconds allowed kswapd to scan
> the full zone and reliably detect OOM in my kill-from-kswapd patch - 
> you might want something similar.
> 
> That seems one the main reasons for the spurious OOM kills.
> 
> Anxious to see your patch! 

could you make a patch for the above part? I agree likely we've to work
on the shrink_cache stuff to fix it.

Your patch does many things, some of which I believe it's wrong, but you
can split it, and take care of the above part so Chris can test it in
the meantime. In the spare time of the weekend I'm trying not to do
linux coding since I've to code for a private project that has to keep
going, so I'll move the oom killing in page_alloc.c only tomorrow (it
won't take very long to do it at it will at last fix one strict bug,
that your patch didn't fix competely and it'll avoid the complexity of
message passing to do it).

But today you can already post your change for the above sc->priority !=
DEF_PRIORITY if you think it's correct, I don't see why you need to wait
for my patch before posting it (they're pretty orthogonal, I didn't mean
to change shrink_cache at all but just to fixup and serialize the oom
invocation by moving it in page_alloc.c).
