Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbUKNS1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbUKNS1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 13:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbUKNS1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 13:27:52 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:29319 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261328AbUKNS1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 13:27:37 -0500
Date: Sun, 14 Nov 2004 19:27:14 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Chris Ross <chris@tebibyte.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Nick Piggin <piggin@cyberone.com.au>,
       Rik van Riel <riel@redhat.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
Message-ID: <20041114182714.GF13733@dualathlon.random>
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org> <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114170339.GB13733@dualathlon.random> <480430000.1100456191@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <480430000.1100456191@[10.10.2.4]>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 10:16:32AM -0800, Martin J. Bligh wrote:
> Heh, I wasn't really worried about the code size at all ... I was just 
> pointing out that 1 page was a trivial amount to be worried about, in
> terms of when we start reclaim.

Ok, my point is that the code size will be smaller and simpler without
message passing, the locking will be a lot simpler since there will be
no locking at all (all info is in the local stack, no need to send local
info to a global kswapd). Plus kswapd when fails the paging is no
different from task context failing the paging, since kswapd will be
racing against all task context, like all task context races against
each other and kswapd too.

About the 1 page trivial amount, I missed/forgot where this 1 page
trivial amount comes from. There's not at all any 1 page trivial amount
of difference between doing oom kill in kswapd based on information
passed from the page_alloc.c task-context, or doing it in the
page_alloc.c task-context directly. Obviously if it was only 1
off-by-one issue it couldn't make any difference, the watermarks are big
enough not having to care about 1 page more or less. Perhaps I wasn't
very clear in explaning why it's better to do the oom killing in
page_alloc.c (where we've the task local information to know if the
allocation is just going to fail) instead of vmscan.c.
