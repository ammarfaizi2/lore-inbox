Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263678AbTIBIZe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263683AbTIBIZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:25:34 -0400
Received: from [63.205.85.133] ([63.205.85.133]:62717 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S263678AbTIBIZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:25:32 -0400
Date: Tue, 2 Sep 2003 01:32:56 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] might_sleep() improvements
Message-ID: <20030902083256.GA52644@gaz.sfgoth.com>
References: <20030902075145.GA12817@sfgoth.com> <3F545175.1080505@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F545175.1080505@cyberone.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> >Andrew - I thought this might be appropriate for -mm kernels.
> >
> >This patch makes the following improvements to might_sleep():
> >
> >o Add a "might_sleep_if()" macro for when we might sleep only if some
> >  condition is met.  I think this is a bit better than the currently used
> >  "if (cond) might_sleep();" since it's clearer that the test won't be
> >  compiled in if spinlock sleep debugging is turned off.  (Obviously
> >  gcc is smart enough to omit simple conditions in that case)  It also
> >  looks cleaner, IMO.  Think of it as analogous to BUG()/BUG_ON().
> >
> 
> I think these should be pushed down to where the sleeping
> actually happens if possible.

No, you want to generate the warning as early as possible in case the
sleeping case happens very infrequently.  For instance:

	newskb = skb_unshare(skb, GFP_KERNEL);

might not even need to do any allocation (much less a sleep) in 99.9% of
cases, but it's still a bug if it's called in atomic context and we want
spinlock sleep debugging to catch that for us.

-Mitch
