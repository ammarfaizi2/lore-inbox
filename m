Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbTL0AgD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 19:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbTL0AgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 19:36:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:48537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265279AbTL0AgA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 19:36:00 -0500
Date: Fri, 26 Dec 2003 16:35:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@surriel.com>, Andrew Morton <akpm@osdl.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: Page aging broken in 2.6
In-Reply-To: <1072482941.15458.90.camel@gaston>
Message-ID: <Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
References: <1072423739.15458.62.camel@gaston>  <Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
 <1072482941.15458.90.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 27 Dec 2003, Benjamin Herrenschmidt wrote:
> 
> Or do what I propose here, that is have ptep_test_and_clear_* be
> responsible for the flush on archs where it is necessary, but then
> it would be nice to have more than the ptep as an argument...

The dirty handling already does the TLB flush (in that case it's a 
correctness issue, not a hint). So it's only ptep_test_and_clear_young() 
that matters.

I don't know whather that ever ends up being performance-critical, and I
don't see what else could be passed into it. We literally don't _have_
anythign else than the pte.

But the ppc architecture could easily decide to walk the hash tables and
invalidate in ptep_test_and_clear_young(). And if it ends up being a
performance issue, it _appears_ that all users of "page_referenced()" 
(which is the only thing that does this) are actually using the return 
value as just a boolean. And it's entirely possible that we should break 
out of "page_referenced()" on the _first_ hit of "yes, this has been 
referenced".

That would make it much less CPU-intensive to make
"ptep_test_and_clear_young()" slightly heavier to execute. It would also 
cause "page_referenced()" to not clear _all_ mapped reference bits at the 
same time - which might unfairly cause multi-used pages to stay in memory. 
On the other hand, that might be the _right_ behaviour.

Rik? Andrea? 

Worth testing, perhaps.

		Linus
