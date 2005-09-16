Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbVIPPdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbVIPPdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 11:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030472AbVIPPdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 11:33:50 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38692
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030404AbVIPPdu (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 16 Sep 2005 11:33:50 -0400
Date: Fri, 16 Sep 2005 17:34:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH] per-task-predictive-write-throttling-1
Message-ID: <20050916153410.GS4122@opteron.random>
References: <20050914220334.GF4966@opteron.random> <17193.3830.498682.626783@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17193.3830.498682.626783@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 10:04:38AM +0400, Nikita Danilov wrote:
> Why is that useful? Don't we want (in general) to cache as many dirty

It allows all tasks to have a chance to take advantage of the writeback
cache, not only the first one like now.

> pages as possible in the hope that some of them will be re-dirtied (thus
> avoiding additional write) or truncated (avoiding write altogether)?

We could add an option to increase the per-task future_dirty pages only
if we had to allocate a new pagecache (i.e. cache miss), that
would leave the rewrite behaviour unchanged, but still if we've a huge
write-hog, we should reserve some cache for other people anyway, so I'm
unsure if we should allow rewriter-hogs to use half the ram and leave
nothing to the other potential small writers. Certainly accounting for
future_dirty only on cache-misses on the radix-tree would still catch
the bad untarring and cp beahviour just fine, so that might be good
enough and I would certainly agree that's more conservative approach.

Initially every task has access to the whole dirty cache, even "cp
/dev/zero ." initially allocates half the ram, but then if it keeps
writing that fast, the dirty cache decreases, to give a chance to other
tasks to avoid blocking while writing.

If the write-hog becomes reasoanable and it slowdown writing, it can
then use more dirty cache again.
