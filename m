Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWAQCNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWAQCNp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 21:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWAQCNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 21:13:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:3457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751086AbWAQCNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 21:13:44 -0500
Date: Mon, 16 Jan 2006 18:13:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] mm: Convert global dirty_exceeded flag to per-node
 node_dirty_exceeded
Message-Id: <20060116181323.7a5f0ac7.akpm@osdl.org>
In-Reply-To: <20060117020352.GB5313@localhost.localdomain>
References: <20060117020352.GB5313@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> This is a repost.  I did not get any comments when I last posted this
> about a month back. So I guess this patch is all good :)
> 

I thought it was fairly ghastly, sorry ;)

> Convert global dirty_exceeded flag to per-node node_dirty_exceeded.
> 
> dirty_exceeded ping pongs between nodes in order to force all cpus in
> the system to increase the frequency of calls to balance_dirty_pages.
> 
> Currently dirty_exceeded is used by balance_dirty_pages_ratelimited to
> force all CPUs in the system call balance_dirty_pages often, in order to
> reduce the amount of dirty pages in the entire system (based on
> dirty_thresh and one CPU exceeding thee ratelimits).  As dirty_exceeded
> is a global variable, it will ping-pong between nodes of a NUMA system
> which is not good.

Did you not test this obvious little optimisation?

--- devel/mm/page-writeback.c~mm-dirty_exceeded-speedup	2006-01-16 18:11:36.000000000 -0800
+++ devel-akpm/mm/page-writeback.c	2006-01-16 18:11:56.000000000 -0800
@@ -212,7 +212,8 @@ static void balance_dirty_pages(struct a
 		if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
 			break;
 
-		dirty_exceeded = 1;
+		if (!dirty_exceeded)
+			dirty_exceeded = 1;
 
 		/* Note: nr_reclaimable denotes nr_dirty + nr_unstable.
 		 * Unstable writes are a feature of certain networked
@@ -234,7 +235,7 @@ static void balance_dirty_pages(struct a
 		blk_congestion_wait(WRITE, HZ/10);
 	}
 
-	if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
+	if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh && dirty_exceeded)
 		dirty_exceeded = 0;
 
 	if (writeback_in_progress(bdi))
_

