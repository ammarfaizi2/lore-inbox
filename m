Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269655AbUINTId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269655AbUINTId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUINTI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:08:28 -0400
Received: from peabody.ximian.com ([130.57.169.10]:45497 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S269655AbUINTDv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:03:51 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Robert Love <rml@ximian.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20040914185212.GY9106@holomorphy.com>
References: <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu>
	 <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au>
	 <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au>
	 <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au>
	 <20040914150316.GN4180@dualathlon.random>
	 <1095185103.23385.1.camel@betsy.boston.ximian.com>
	 <20040914185212.GY9106@holomorphy.com>
Content-Type: text/plain
Date: Tue, 14 Sep 2004 15:02:49 -0400
Message-Id: <1095188569.23385.11.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 11:52 -0700, William Lee Irwin III wrote:

> I'd vaguely prefer to clean up the BKL (ab)users... of course, this
> involves working with some of the dirtiest code in the kernel that's
> already discouraged most/all of those who work on reducing/eliminating
> BKL use from touching it... maybe the latency trend is the final nail
> in the coffin of resistance to cleaning that up, though I agree with
> Alan that we have to be very careful about it, particularly since all
> prior attempts failed to be sufficiently so.

I'd love to just throw away all the BKL users, too, William.  But
pragmatism and my cautious sense of reality tells me that the BKL is not
going anywhere anytime soon.  We might get it down to 1% of its previous
usage, but it is awful intertwined in some places.  It will take some
time.

What I think we can do is start looking at removing the special
properties of the BKL, or at least better containing and documenting
them.  The BKL has a few oddities over other spin locks:

	- you can safely call schedule() while holding it
	- you can grab it recursively
	- you cannot use it in interrupt handlers

Getting rid of these, or at least better delineating them, will move the
BKL closer to being just a very granular lock.

cond_resched_bkl() is a step toward that.

I want the BKL gone, too; I think reducing its specialness is a good way
to achieve that.  If you can also s/BKL/some other lock/ at the same
time, rock that.

Best,

	Robert Love


