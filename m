Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWHTUgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWHTUgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 16:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWHTUgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 16:36:39 -0400
Received: from 1wt.eu ([62.212.114.60]:59152 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751227AbWHTUgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 16:36:38 -0400
Date: Sun, 20 Aug 2006 22:35:59 +0200
From: Willy Tarreau <w@1wt.eu>
To: David Miller <davem@davemloft.net>
Cc: mb@bu3sch.de, solar@openwall.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
Message-ID: <20060820203559.GT602@1wt.eu>
References: <20060819234806.GB27115@1wt.eu> <200608200205.20876.mb@bu3sch.de> <20060820004307.GD27115@1wt.eu> <20060820.124427.74745779.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820.124427.74745779.davem@davemloft.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Sun, Aug 20, 2006 at 12:44:27PM -0700, David Miller wrote:
> From: Willy Tarreau <w@1wt.eu>
> Date: Sun, 20 Aug 2006 02:43:07 +0200
> 
> > On Sun, Aug 20, 2006 at 02:05:20AM +0200, Michael Buesch wrote:
> > > Not to me. It heavily violates codingstyle and screws brains
> >                 ^^^^^^^
> > little exageration detected here.
> > 
> > > with the non-indented else branches.
> > 
> > while they surprized me first, they make the *patch* more readable
> > by clearly showing what has been inserted and where. However, I have
> > joined the lines for the merge.
> 
> Thanks for consulting the networking maintainer before merging
> this. :-/

I'm sorry, will try to do better next time :-(
I only queue the patches locally while they're being discussed anyway.

> What if some sockopt treats a negative length specially?
> Maybe some setsockopt() doesn't care about the optlen pointer?

Which should not be a reason for userspace to respect the calling convention.
>From man 2 getsockopt, it's clear that optlen is the size of the buffer :

       For getsockopt, optlen is a value-result
       parameter, initially containing the  size  of  the  buffer
       pointed  to  by optval, and modified on return to indicate
       the actual size of the value returned.

Where I can agree with you is on this part of the man :

       If no option value is to be supplied or returned, optval may be NULL.

Nothing is said about optlen's validity in such a case.

> This toplevel code has no buisness interpreting the arguments when the
> downcall and argument interpretation is by definition protocol
> specific.

Generally, the advantage of doing checks early is that they help enforcing
conventions and sometimes protect against a stupid bug in one of the multiple
leaves. It should in no way be an excuse to keep the remaining stupid bugs
when we spot them.

> It also means we'll touch userspace twice for this value which is really
> dumb.

If this is that dumb, then why is it done twice in tcp_getsockopt() for
TCP_INFO ? would you accept a fix which copies it in a local variable
instead ? 2.6 would also benefit from this for TCP_CONGESTION.

> The only nice part about this change is that it allows us to be lazy
> about auditing the individual setsockopt() implementations.

This is absolutely not the intent. When we merged Julien Tinnes's fixes
for NULL pointer checks, it "looked like" the callers already performed
the tests, but that was not a reason not to complete the test in the leaf
functions.

> I'd rather fix the broken cases than add a patch which just assumes they
> are broken and not worth fixing

We're not assuming they're broken. When some code is maintained by many people
and when conventions differ between similar functions (eg: setsockopt does
the check at top level and getsockopt in the leaves), it should be expected
that we populate the CVE lists from time to time when we decide that there
will always be one single check for every argument. And this is true for all
system parts.

> and also imposes a convention for the optlen argument.

I would better understand this one considering the fact that the man is
vague on this matter.

> No thanks.

OK, fine, I drop it. People who seek better security know where to find
hardening patches anyway.

Willy

