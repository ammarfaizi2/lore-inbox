Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVLNKsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVLNKsm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 05:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVLNKsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 05:48:42 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:51469
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S932354AbVLNKsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 05:48:41 -0500
Date: Wed, 14 Dec 2005 11:48:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Sridhar Samudrala <sri@us.ibm.com>,
       pavel@suse.cz, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 1/6] Create Critical Page Pool
Message-ID: <20051214104839.GJ23878@opteron.random>
References: <439FCECA.3060909@us.ibm.com> <439FCF4E.3090202@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439FCF4E.3090202@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Tue, Dec 13, 2005 at 11:52:46PM -0800, Matthew Dobson wrote:
> Create the basic Critical Page Pool.  Any allocation specifying
> __GFP_CRITICAL will, as a last resort before failing the allocation, try to
> get a page from the critical pool.  For now, only singleton (order 0) pages
> are supported.

Hmm sorry, but this design looks wrong to me. Since the caller has to
use __GFP_CRITICAL anyway, why don't you build this critical pool
_outside_ the page allocator exactly like the mempool does?

Then you will also get an huge advantage, that is allowing to create
more than one critical pool without having to add a __GFP_CRITICAL2 next
month.

So IMHO if something you should create something like a mempool (if the
mempool isn't good enough already for your usage), so more subsystems
can register their critical pools. Call it criticalpool.c or similar but
I wouldn't mess with __GFP_* and page_alloc.c, and the sysctl should be
in the user subsystem, not global.

Or perhaps you can share the mempool code and extend the mempool API to
refill itself internally automatically as soon as pages are being
released.

You may still need a single hook in the __free_pages path, to refill
pools transparently from any freeing (not only the freeing of your
subsystem) but such an hook is acceptable. You may need to set
priorities in the criticalpool.c api as well to choose which pool to
refill first, or if to refill them in round robin when they've the same
priority.

I would touch page_alloc.c only with regard of the prioritized pool
refilling with a registration hook and I would definitely not use a
global pool and I wouldn't use __GFP_ bitflag for it.

Then each slab will be allowed to have its criticalpool too, then, not
a global one. A global one driven by the __GFP_CRITICAL flag will
quickly become useless as soon as you've more than one subsystem using
it, plus it unnecessairly mess with page_alloc.c APIs where the only
thing you care about is to catch the freeing operation with a hook.
