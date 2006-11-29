Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933563AbWK2E5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933563AbWK2E5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933429AbWK2E5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:57:37 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:18353 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S933563AbWK2E5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:57:36 -0500
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick
	away
From: Nicholas Miell <nmiell@comcast.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
In-Reply-To: <23328.1164774627@kao2.melbourne.sgi.com>
References: <23328.1164774627@kao2.melbourne.sgi.com>
Content-Type: text/plain
Date: Tue, 28 Nov 2006 20:57:33 -0800
Message-Id: <1164776253.2825.9.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-29 at 15:30 +1100, Keith Owens wrote:
> David Miller (on Tue, 28 Nov 2006 20:04:53 -0800 (PST)) wrote:
> >From: Keith Owens <kaos@ocs.com.au>
> >Date: Wed, 29 Nov 2006 14:56:20 +1100
> >
> >> Secondly, I believe that this is a separate problem from bug 22278.
> >> hpet_readl() is correctly using volatile internally, but its result is
> >> being assigned to a pair of normal integers (not declared as volatile).
> >> In the context of wait_hpet_tick, all the variables are unqualified so
> >> gcc is allowed to optimize the comparison away.
> >> 
> >> The same problem may exist in other parts of arch/i386/kernel/time_hpet.c,
> >> where the return value from hpet_readl() is assigned to a normal
> >> variable.  Nothing in the C standard says that those unqualified
> >> variables should be magically treated as volatile, just because the
> >> original code that extracted the value used volatile.  IOW, time_hpet.c
> >> needs to declare any variables that hold the result of hpet_readl() as
> >> being volatile variables.
> >
> >I disagree with this.
> >
> >readl() returns values from an opaque source, and it is declared
> >as such to show this to GCC.  It's like a function that GCC
> >cannot see the implementation of, which it cannot determine
> >anything about wrt. return values.
> >
> >The volatile'ness does not simply disappear the moment you
> >assign the result to some local variable which is not volatile.
> >
> >Half of our drivers would break if this were true.
> 
> This is definitely a gcc bug, 4.1.0 is doing something weird.  Compile
> with CONFIG_CC_OPTIMIZE_FOR_SIZE=n and the bug appears,
> CONFIG_CC_OPTIMIZE_FOR_SIZE=y has no problem.
> 
> Compile with CONFIG_CC_OPTIMIZE_FOR_SIZE=n and _either_ of the patches
> below and the problem disappears.
> 

My theory: gcc is inlining readl into hpet_readl (readl is an inline
function, so it should be doing this no matter what), and inlining
hpet_readl into wait_hpet_tick (otherwise, it can't possibly make any
assumptions about the return values of hpet_readl -- this looks to be a
SUSE-specific over-aggressive optimization), and somewhere along the way
the volatile qualifier is getting lost.

-- 
Nicholas Miell <nmiell@comcast.net>

