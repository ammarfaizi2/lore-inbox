Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbUKFBVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUKFBVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 20:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUKFBVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 20:21:17 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:12960 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261221AbUKFBVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 20:21:14 -0500
Date: Sat, 6 Nov 2004 02:20:18 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041106012018.GT8229@dualathlon.random>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411051532.51150.jbarnes@sgi.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 03:32:50PM -0800, Jesse Barnes wrote:
> On Friday, November 05, 2004 12:01 pm, Marcelo Tosatti wrote:
> > In my opinion the correct approach is to trigger the OOM killer
> > when kswapd is unable to free pages. Once that is done, the number
> > of tasks inside page reclaim is irrelevant.
> 
> That makes sense.

I don't like it, kswapd may fail balancing because there's a GFP_DMA
allocation that eat the last dma page, but we should not kill tasks if
we fail to balance in kswapd, we should kill tasks only when no fail
path exists (i.e. only during page faults, everything else in the kernel
has a fail path and it should never trigger oom).

If you move it in kswapd there's no way to prevent oom-killing from a
syscall allocation (I guess even right now it would go wrong in this
sense, but at least right now it's more fixable). I want to move the oom
kill outside the alloc_page paths. The oom killing is all about the page
faults not having a fail path, and in turn the oom killing should be
moved in the page fault code, not in the allocator. Everything else
should keep returning -ENOMEM to the caller.

So to me moving the oom killer into kswapd looks a regression.
