Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbVKSLim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbVKSLim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 06:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbVKSLim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 06:38:42 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15437
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1751077AbVKSLim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 06:38:42 -0500
Date: Sat, 19 Nov 2005 12:38:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, edwardsg@sgi.com
Subject: Re: shrinker->nr = LONG_MAX means deadlock for icache
Message-ID: <20051119113834.GB18782@opteron.random>
References: <20051118171249.GJ24970@opteron.random> <20051118232904.4231ad87.akpm@osdl.org> <20051119103723.GA18782@opteron.random> <20051119030306.3049837d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119030306.3049837d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 03:03:06AM -0800, Andrew Morton wrote:
> It would be nice to understand exactly what's gone wrong.

I found something more, see below.

> I guess so, although I worry that this way we'll obscure the real bug,
> whatever it is.

Now that I understand better the math around scanned and lru_pages I
believe their caller could be the reason they have this huge number in
"nr" is because they pass 0 to shrink all slabs entries. As said in the
previous email they lockup when invoking the slab shrinking with the
toss-cache feature.  They should have passed "tossed" as third parameter
too, not 0.

			int tossed = atomic_read(&npgs_tossed);
			shrink_slab(tossed, GFP_KERNEL, 0 /* shrink max */);
			atomic_set(&npgs_tossed, 0);

The zero as thrid parameter means nr will be "max_pass * scanned", so if
both the page-lru is huge and the icache is huge, that can lead to an
huge value.

They should also add a WARN_ON to be sure that "tossed" is never
negative just in case: when the "tossed" gets sign zero extended during
the int2unsigned-long conversion, that could generate the huge number if
tossed was negative.

So the caller has to be fixed too, even if now it would be ok to pass 0
without risking huge nr values (after fixing the unrelated __GFP_IO bug).

So hopefully the "0" as third parameter is good enough to explain the
(other) real bug and we won't be hiding more bugs with this fix.

> Sure.  You've limited the number of scanned objects in one pass to twice
> the number of objects - there's no point in doing more work than that.

Agreed.

> A return value of 3 is very odd.  I'd be suspecting a mismeasurement. 
> Unless someone had altered vfs_cache_pressure.

Exactly.

> OK.  Well If Edward&co could do a bit more investigation it'd be great -
> meanwhile I'll hang onto this (and might add some mm-only debugging,
> depending on how Edward gets on):

Looks good to me, thanks!
