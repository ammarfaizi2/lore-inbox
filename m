Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbVLLQdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbVLLQdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 11:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbVLLQdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 11:33:10 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50335 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751250AbVLLQdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 11:33:09 -0500
Date: Mon, 12 Dec 2005 08:32:49 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC 1/6] Framework
In-Reply-To: <20051210033235.GP11190@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0512120827470.14274@schroedinger.engr.sgi.com>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com>
 <20051210005445.3887.94119.sendpatchset@schroedinger.engr.sgi.com>
 <20051210033235.GP11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2005, Andi Kleen wrote:

> > +#define global_page_state(__x) atomic_long_read(&vm_stat[__x])
> > +#define zone_page_state(__z,__x) atomic_long_read(&(__z)->vm_stat[__x])
> > +extern unsigned long node_page_state(int node, enum zone_stat_item);
> > +
> > +/*
> > + * For use when we know that interrupts are disabled.
> 
> Why do you need to disable interupts for atomic_t ? 

Interrupts need to be disabled because the processing of the byte sized 
differential could be interrupted.

> If you just want to prevent switching CPUs that could be 
> done with get_cpu(), but alternatively you could just ignore
> that race (it wouldn't be a big issue to still increment
> the counter on the old CPU)

There is no increment or decrement right now. We add an offset and that 
offset could easily burst the limits of a byte sized differential. A check 
needs to happen before the differential is updated.

> And why atomic and not just local_t?  On x86/x86-64 local_t
> would be much cheaper at least. It's not long, but that could
> be as well added.

local_t is long on ia64. 

The atomics are used for global updates of counters in struct zone and the 
vm_stats array. local_t wont help there.

local_t could be used for the differentials. Special functions for 
increment and decrement could use the non-interruptible nature of inc/decs 
on i386 and x86_64.

There is no byte sized local_t though so its difficult to use local_t 
here. I think this whole local_t stuff is not too useful after all. 
Could we add an incp/decp macro that is like cmpxchg? That macro should 
be able to operation on various sizes of counters.
