Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266152AbTGDUEu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 16:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266153AbTGDUEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 16:04:50 -0400
Received: from [213.39.233.138] ([213.39.233.138]:45243 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266152AbTGDUEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 16:04:48 -0400
Date: Fri, 4 Jul 2003 22:18:40 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: benh@kernel.crashing.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@lists.linuxppc.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030704201840.GH22152@wohnheim.fh-wedel.de>
References: <20030704193848.GG22152@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0307041259050.10035-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0307041259050.10035-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 July 2003 13:06:50 -0700, Linus Torvalds wrote:
> 
> Yeah, basically a lot of old threading stuff did the equivalent of 
> longjump by hand.
> 
> It is entirely possible that they do not do this out of signal handlers, 
> since that has its own set of problems anyway, and one of the reasons for 
> doing co-operative user level threading is to not need locking, and thus 
> you never want to do any thread switching asynchronously (eg from a signal 
> context).
> 
> So I'm not saying that your patch will necessarily break stuff, I'm just 
> pointing out that it was actually done the way it is done on purpose.

And there actually is a possibility for my patch to break things.
Davide's example should still work, but there may be others.  Point
taken.

> Sure it does. It can detect just about _any_ brokenness, except for the 
> very rare case of total stack pointer corruption.

Well, that rare case is one that some people are quite concerned
about.  The sigaltstack is nice because it reduces the likelyhood, but
it doesn't cure the paranoia completely.

> The people who use it tend to do user-space memory management, and for 
> example put hard limits on their stack usage - possibly because they have 
> a lot of stacks because they use threads.
> 
> Most of the time if the original stack is blown, the fault is
> non-recoverable. But you can use the alternate stack to either just give a 
> nice debug message (even in the presense of otherwise non-recoverable 
> errors), _or_ you can actually do things like fix up the stack 
> dynamically.

Both of which I want to have, right.

> Quite frankly, for the recursive SIGSEGV problem, I'd much rather look at
> the signal mask. If SIGSEGV is blocked, we should probably just kill the
> program instead of clearing the blocking and trying to handle the SIGSEGV 
> anyway. That should fix your test case, _without_ any subtle side effects.

What do we do, if a program also uses SA_NOMASK for the SIGSEGV
handler?  This is totally stupid, I agree, but it is legal.  Should we
declare it illegal from this day on, or is that path blocked as well?

Jörn

-- 
When in doubt, use brute force.
-- Ken Thompson
