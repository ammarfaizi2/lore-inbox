Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268030AbUHFAUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268030AbUHFAUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 20:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268028AbUHFAUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 20:20:04 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22144 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268011AbUHFATo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 20:19:44 -0400
Date: Thu, 5 Aug 2004 20:19:41 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RSS ulimit enforcement for 2.6.8
In-Reply-To: <20040805153116.3e820106.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0408052016490.8229-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Andrew Morton wrote:

> I'd kinda expected that the patch would try to limit a process to its
> RLIMIT_RSS all the time.  So if a process is set to 16MB and tries to use
> 32MB it gets to do a lot of swapping.  But you're not doing that.  Instead,
> the patch is preferentially penalising processes which are over their limit
> when we enter page reclaim.  What are the pros and cons, and what is the
> thinking behind this?

Hard limiting a process when there is memory available
means that it's trying to saturate the IO subsystem,
slowing down other tasks in the system.

Basically when memory isn't the bottleneck, I think you
shouldn't try to create an IO bottleneck for the other
tasks in the system, just because an RLIMIT_RSS got set.

The downside is that the pages of the process need to be
swapped out when something else needs the memory, but if
the alternative is constant swapping, we'd have the IO
overhead regardless...

> Also, I wonder if it would be useful if refill_inactive_zone() were to
> unconditionally move pages from over-rss-limit mm's onto the inactive
> list, ignoring swappiness.  Or if we should explicitly deactivate pages
> which are newly added to the LRU on behalf of an over-rss-limit process.

If the current patch isn't effective enough, we may want
to add more code.  However, we may want to try the simplest
possible approach first.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

