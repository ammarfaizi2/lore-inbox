Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265512AbUFDB3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265512AbUFDB3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 21:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265407AbUFDB3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 21:29:54 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:26613 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S265512AbUFDB3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 21:29:52 -0400
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: Paul Jackson <pj@sgi.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ak@suse.de
In-Reply-To: <20040603165142.GA3959@kroah.com>
References: <20040602161115.1340f698.pj@sgi.com>
	 <1086222156.29391.337.camel@bach> <20040603162712.GA3291@kroah.com>
	 <20040603093807.33bc670d.pj@sgi.com>  <20040603165142.GA3959@kroah.com>
Content-Type: text/plain
Message-Id: <1086312466.7990.884.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 11:27:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-04 at 02:51, Greg KH wrote:
> Just be aware of the size and code your show() function to be defensive
> and not overrun that size.

This is where we have a philosophical difference.  As I understand it,
the rule is, "don't put big things in attributes".  If we want to change
that rule, we need to do more work, like pass the length to the show
function, and handle -ENOMEM by reallocating and looping.

But I think the /rule/ is a good one: if you need to handle something
arbitrarily large, DON'T USE THIS INTERFACE, because there is no way to
do that correctly.  This allows us to handle 99.9% of cases as a
one-liner, which I think has great merit.

I think we should guarantee any kernel primitive fits into the space:
this means it should comfortably fit printing a cpumask_t.  I would
argue for a #error inside the cpumask or sysfs code which ensures we can
fit two cpumasks (~7000 CPUs on page-size 4096), so we explode early if
this ever becomes a problem, and a runtime sanity check inside the sysfs
code to BUG on overrun.

If the average code is worrying about the exact size of the sysfs
buffer, I think they're on the wrong path.  If they are checking it at
runtime, they've got a bug.

I hope this clarifies my thinking, and I can understand that people
would disagree with my premise: that's OK.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

