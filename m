Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbUKNREH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbUKNREH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 12:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbUKNREH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 12:04:07 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:43979 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261317AbUKNRED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 12:04:03 -0500
Date: Sun, 14 Nov 2004 18:03:39 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Chris Ross <chris@tebibyte.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Nick Piggin <piggin@cyberone.com.au>,
       Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041114170339.GB13733@dualathlon.random>
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114094417.GC29267@logos.cnet>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 07:44:17AM -0200, Marcelo Tosatti wrote:
> Well, I'll wait for your correct and definitive approach.

I doubt my patch will be definitive and you're welcome to keep hacking
without waiting ;). There are various problems, one issue is the
try_to_free_pages side, the other severe and obvious bug is the
invocation of the oom killer in vmscan.c that cannot know if enough
memory is already free via racing tasks (like other context and like
kswapd).

I'm looking at the latter first since that is easy to fix, but as you
said the zone->all_unreclaimable is hard and it may be buggy too, so I
doubt my fix will be definitive ;) but it'll worth a try. Feel free to
work on the zone->all_unreclaimable for example.

Especially the fact your patch didn't help make me think my firts patch
also won't fix it and we'll have to look into the try_to_free_pages
internals to fix it completely.

My patch compared to yours will only save .text/.data/.bss bloat (i.e.
the opposite of what Martin was worried about) to avoid message passing
via global variable w/o locks from task context to kswapd.

Chris, since you can reproduce so easily, could you try a `vmstat 1`
while the oom killing happens, and can you post it?

We've also to differentiate between true early-oom kills, and genuine
oom-kills. The oom killing triggering is not always by mistake ;). Chris
if you could post the vmstat 1 that would help to be sure it's really a
kernel bug (if you already posted it in another thread just let me know
and I'll search for such an email ;). Thanks!
