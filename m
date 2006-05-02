Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWEBQoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWEBQoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWEBQoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:44:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:54172 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964924AbWEBQoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:44:01 -0400
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sched_clock() uses are broken
References: <20060502132953.GA30146@flint.arm.linux.org.uk>
From: Andi Kleen <ak@suse.de>
Date: 02 May 2006 18:43:45 +0200
In-Reply-To: <20060502132953.GA30146@flint.arm.linux.org.uk>
Message-ID: <p73slns5qda.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:
> 
> However, this is not the case.  On x86 with TSC, it returns a 54 bit
> number.  This means that when t1 < t0, time_passed_ns becomes a very
> large number which no longer represents the amount of time.

Good point. For a 1Ghz system this would happen every ~0.57 years.

The problem is there is AFAIK no non destructive[1] way to find out how
many bits the TSC has

Destructive would be to overwrite it with -1 and see how many stick.

> All uses in kernel/sched.c seem to be aflicted by this problem.
> 
> There are several solutions to this - the most obvious being that we
> need a function which returns the nanosecond difference between two
> sched_clock() return values, and this function needs to know how to
> handle the case where sched_clock() has wrapped.

Ok it can be done with a simple test.

> 
> IOW:
> 
> 	t0 = sched_clock();
> 	/* do something */
> 	t1 = sched_clock();
> 
> 	time_passed = sched_clock_diff(t1, t0);
> 
> Comments?

Agreed it's a problem, but probably a small one. At worst you'll get
a small scheduling hickup every half year, which should be hardly 
that big an issue.

Might chose to just ignore it with a big fat comment?

-Andi

