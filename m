Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264398AbUFEKfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUFEKfd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 06:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbUFEKfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 06:35:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:41960 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264398AbUFEKfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 06:35:17 -0400
Date: Sat, 5 Jun 2004 12:33:19 +0200
From: Andi Kleen <ak@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use numa policy API for boot time policy
Message-Id: <20040605123319.14b8ca17.ak@suse.de>
In-Reply-To: <40C19E85.7090809@colorfullife.com>
References: <20040605034356.1037d299.ak@suse.de>
	<40C12865.9050803@colorfullife.com>
	<20040605041813.75e2d22d.ak@suse.de>
	<40C19E85.7090809@colorfullife.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jun 2004 12:20:53 +0200
Manfred Spraul <manfred@colorfullife.com> wrote:

> Andi Kleen wrote:
> 
> >On Sat, 05 Jun 2004 03:56:53 +0200
> >Manfred Spraul <manfred@colorfullife.com> wrote:
> >  
> >
> >>Does it work for order != 0 allocations? It's important that the big 
> >>hash tables do not end up all in node 0. AFAICS alloc_pages_current() 
> >>calls interleave_nodes() only for order==0 allocs.
> >>    
> >>
> >
> >That's correct. It will only work for order 0 allocations.
> >
> >  
> >
> What's the purpose of the "&& order == 0)" test for MPOL_INTERLEAVE in 
> alloc_pages_current?
> What would break if it's removed?

Nothing. Just the interleaving will not be very good.
Just the vma interleaving relies on order 0 right now.

But I would really try to use vmalloc() for this. In fact you don't
even need vmalloc_interleaved(), because the normal vmalloc allocation
together with the interleave policy should do the right thing.

> 
> And what about in_interrupt() allocations? During boot everything should 
> be interleaved - I'd modify default_policy to MPOL_INTERLEAVE instead of 
> setting process affinity.

Better don't do that. It may break some subtle assumptions.

I guess the in_interrupt() allocations will have to live with that.
They should be relatively rare.

In theory you could add a system_state == SYSTEM_BOOTING check again,
but polluting the fast path for this would be imho overkill.

-Andi
 
