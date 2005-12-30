Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbVL3WQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbVL3WQg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 17:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVL3WQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 17:16:36 -0500
Received: from waste.org ([64.81.244.121]:47029 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750930AbVL3WQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 17:16:36 -0500
Date: Fri, 30 Dec 2005 16:12:22 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051230221222.GJ3356@waste.org>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228201150.b6cfca14.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 08:11:50PM -0800, Andrew Morton wrote:
> If no-forced-inlining makes the kernel smaller then we probably have (yet
> more) incorrect inlining.  We should hunt those down and fix them.  We did
> quite a lot of this in 2.5.x/2.6.early.  Didn't someone have a script which
> would identify which functions are a candidate for uninlining?

It was a combination of a tool I wrote for -tiny, which added
deprecation warnings to inlines along with a post-processing tool to
count instantiations, nestings, etc., and a post-post-processing tool
written by Denis Vlasenko that guessed at the space usage.

We cleaned up most of the obvious offenders quite a while ago, but
there's quite a long tail on the usage distribution. It's simply not
worth the trouble to go through the far half of the distribution one
by one to figure out whether inlining makes sense.

So I'm in favor of changing our inlining philosophy moving forward.
The world has changed since we started physically marking functions
inline. When we started, basically all arches gained advantage from
heavy inlining due to favorable CPU to memory speed ratios. And the
compiler's automatic inlining was quite primitive. Now most (but not
all!) arches heavily favor out of line code except in fairly critical
locations and the compiler has gotten (just recently) quite a bit
smarter with its inlining.

So we should really go back to using inline as a hint for 90%+ of
candidate functions (using always.. and no.. for the rest), and using
our compile-time size and arch information to fine-tune the compiler's
decisions as to which hints to take.

-- 
Mathematics is the supreme nostalgia of our time.
