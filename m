Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVAMRS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVAMRS2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVAMROu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:14:50 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:50861 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261256AbVAMRMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:12:00 -0500
Date: Thu, 13 Jan 2005 09:11:29 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, hugh@veritas.com, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: page table lock patch V15 [0/7]: overview
In-Reply-To: <20050113031807.GA97340@muc.de>
Message-ID: <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
References: <41E4BCBE.2010001@yahoo.com.au> <20050112014235.7095dcf4.akpm@osdl.org>
 <Pine.LNX.4.58.0501120833060.10380@schroedinger.engr.sgi.com>
 <20050112104326.69b99298.akpm@osdl.org> <41E5AFE6.6000509@yahoo.com.au>
 <20050112153033.6e2e4c6e.akpm@osdl.org> <41E5B7AD.40304@yahoo.com.au>
 <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
 <41E5BC60.3090309@yahoo.com.au> <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
 <20050113031807.GA97340@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2005, Andi Kleen wrote:

> Alternatively you can use a lazy load, checking for changes.
> (untested)
>
> pte_t read_pte(volatile pte_t *pte)
> {
> 	pte_t n;
> 	do {
> 		n.pte_low = pte->pte_low;
> 		rmb();
> 		n.pte_high = pte->pte_high;
> 		rmb();
> 	} while (n.pte_low != pte->pte_low);
> 	return pte;
> }
>
> No atomic operations, I bet it's actually faster than the cmpxchg8.
> There is a small risk for livelock, but not much worse than with an
> ordinary spinlock.

Hmm.... This may replace the get of a 64 bit value. But here could still
be another process that is setting the pte in a non-atomic way.

> Not that I get it what you want it for exactly - the content
> of the pte could change any time when you don't hold page_table_lock, right?

The content of the pte can change anytime the page_table_lock is held and
it may change from cleared to a value through a cmpxchg while the lock is
not held.
