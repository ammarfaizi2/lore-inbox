Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261496AbUK1Pjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261496AbUK1Pjt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUK1Pjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:39:48 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:40956 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261496AbUK1Pjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:39:46 -0500
Date: Sun, 28 Nov 2004 21:12:27 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] rcu: cosmetic, delete wrong comment, use HARDIRQ_OFFSET
Message-ID: <20041128154227.GC20894@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <41A9E98C.2C1D07EF@tv-sign.ru> <20041128151925.GA20894@in.ibm.com> <41A9EDB7.8020304@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A9EDB7.8020304@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2004 at 04:24:39PM +0100, Manfred Spraul wrote:
> Dipankar Sarma wrote:
> 
> >On Sun, Nov 28, 2004 at 06:06:52PM +0300, Oleg Nesterov wrote:
> > 
> >
> >>Afaics, this comment is misleading. rcu_check_quiescent_state()
> >>is executed in softirq context, while rcu_check_callbacks() checks
> >>in_softirq() before ++qsctr.
> >>
> >>Also, replace (1 << HARDIRQ_SHIFT) by HARDIRQ_OFFSET.
> >>
> >>   
> >>
> >
> >Looks good to me. IIRC, that comment has been around since very
> >early prototypes, so it is probably leftover trash.
> >
> > 
> >
> I agree. I think I only moved it around.
> But I don't like the HARDIRQ_OFFSET change. If I understand the code 
> correctly it checks that there is no hardirq reentrancy, i.e. the count 
> is 0 or 1. Shifted to the appropriate position for the actual test.
> I'd either leave it as it is or use "1*HARDIRQ_OFFSET" - otherwise the 
> information that the count should be less of equal one is lost.

Hmm. I agree with Manfred.  hardirq_count() <= (1 << HARDIRQ_SHIFT)
was the test I arrived at since it was most explicit - One level
of (local timer) interrupt over idle task and no softirq in between
is OK to indicate that the cpu had seen an idle task. A bigger
hardirq_count() indicates reentrant hardirq over idle task and we
are no longer safe.

So, let's drop the HARDIRQ_OFFSET change.

Thanks
Dipankar
