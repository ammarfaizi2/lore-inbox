Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbUKFCEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUKFCEQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 21:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUKFCEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 21:04:16 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:49064
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261289AbUKFCEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 21:04:11 -0500
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages /
	all_unreclaimable braindamage
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@novell.com>
Cc: Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <piggin@cyberone.com.au>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <20041106012018.GT8229@dualathlon.random>
References: <20041105200118.GA20321@logos.cnet>
	 <200411051532.51150.jbarnes@sgi.com>
	 <20041106012018.GT8229@dualathlon.random>
Content-Type: text/plain
Organization: linutronix
Date: Sat, 06 Nov 2004 02:55:50 +0100
Message-Id: <1099706150.2810.147.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-06 at 02:20 +0100, Andrea Arcangeli wrote:
> On Fri, Nov 05, 2004 at 03:32:50PM -0800, Jesse Barnes wrote:
> > On Friday, November 05, 2004 12:01 pm, Marcelo Tosatti wrote:
> > > In my opinion the correct approach is to trigger the OOM killer
> > > when kswapd is unable to free pages. Once that is done, the number
> > > of tasks inside page reclaim is irrelevant.
> > 
> > That makes sense.
> 
> I don't like it, kswapd may fail balancing because there's a GFP_DMA
> allocation that eat the last dma page, but we should not kill tasks if
> we fail to balance in kswapd, we should kill tasks only when no fail
> path exists (i.e. only during page faults, everything else in the kernel
> has a fail path and it should never trigger oom).
> 
> If you move it in kswapd there's no way to prevent oom-killing from a
> syscall allocation (I guess even right now it would go wrong in this
> sense, but at least right now it's more fixable). I want to move the oom
> kill outside the alloc_page paths. The oom killing is all about the page
> faults not having a fail path, and in turn the oom killing should be
> moved in the page fault code, not in the allocator. Everything else
> should keep returning -ENOMEM to the caller.
> 
> So to me moving the oom killer into kswapd looks a regression.

My point is not where oom-killer is triggered. My point is the decision
criteria of oom-killer, when it is finally invoked, which process to
kill. That's kind of independend of your patch. Your patch corrects the
context in which oom-killer is called. My concern is that the decision
critrion which process should be killed is not sufficient. In my case it
kills sshd instead of a process which forks a bunch of child processes.
Thats just wrong, because it takes away the chance to log into the
machine remotely and fix the problem.

tglx


