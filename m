Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUC3TCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263849AbUC3TCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:02:19 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:37564
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263792AbUC3TBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:01:03 -0500
Date: Tue, 30 Mar 2004 21:01:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: mapped pages being truncated [was Re: 2.6.5-rc2-aa5]
Message-ID: <20040330190102.GD3808@dualathlon.random>
References: <20040330182018.GB3808@dualathlon.random> <Pine.LNX.4.44.0403301930040.23534-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403301930040.23534-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 07:48:42PM +0100, Hugh Dickins wrote:
> On Tue, 30 Mar 2004, Andrea Arcangeli wrote:
> > 
> > note that the very same bug triggers with objrmap only applied (before I
> > applied anon-vma and prio-tree on top of it), so at very least this is a
> > bug in Dave's code too. See the same BUG_ON triggering in rmap.c before
> > I replace it with objrmap.c in anon-vma. Almost certainly it will trigger with
> > your patches applied too and probably it happens with mainline 2.6 too
> > but nobody tested that yet.
> 
> Do you have enough evidence that it's the very same bug?

yes, see the two stack traces, they trigger in the same place and it's
the very same workload. Andrew just noticed that xfs indeed calls
truncate_inode_pages before vmtruncate. It will trigger with your
patches too.

> I believe there were other loopholes in the original objrmap code,
> we've both moved on from there (e.g. we both decided it's safer to
> set and clear PageAnon inside the maplock), so I'm not concerned
> about the original objrmap.

Ok I see what you mean, this should fix it, agreed?

--- x/mm/memory.c.~1~	2004-03-29 19:24:39.000000000 +0200
+++ x/mm/memory.c	2004-03-30 20:57:35.889344056 +0200
@@ -1448,6 +1448,7 @@ retry:
 		lru_cache_add_active(page);
 		new_page = page;
 		anon = 1;
+		pageable = 1;
 	}
 
 	spin_lock(&mm->page_table_lock);


In practice doing a cow on a dma region is pretty useless, so I doubt
anybody would run into it but I agree the above is making the anon page
swappable and it's more correct.
