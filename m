Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVJVFc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVJVFc1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 01:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVJVFc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 01:32:27 -0400
Received: from hera.kernel.org ([140.211.167.34]:65161 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932187AbVJVFc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 01:32:27 -0400
Date: Fri, 21 Oct 2005 22:50:50 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-ID: <20051022005050.GA27317@logos.cnet>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <aec7e5c30510201857r7cf9d337wce9a4017064adcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aec7e5c30510201857r7cf9d337wce9a4017064adcf@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2005 at 10:57:02AM +0900, Magnus Damm wrote:
> On 10/21/05, Christoph Lameter <clameter@sgi.com> wrote:
> > Page migration is also useful for other purposes:
> >
> > 1. Memory hotplug. Migrating processes off a memory node that is going
> >    to be disconnected.
> >
> > 2. Remapping of bad pages. These could be detected through soft ECC errors
> >    and other mechanisms.
> 
> 3. Migrating between zones.
> 
> The current per-zone LRU design might have some drawbacks. I would
> prefer a per-node LRU to avoid that certain zones needs to shrink more
> often than others. But maybe that is not the case, please let me know
> if I'm wrong.
> 
> If you think about it, say that a certain user space page happens to
> be allocated from the DMA zone, and for some reason this DMA zone is
> very popular because you have crappy hardware, then it might be more
> probable that this page is paged out before some other much older/less
> used page in another (larger) zone. And I guess the same applies to
> small HIGHMEM zones.

User pages (accessed through their virtual pte mapping) can be moved
around zones freely - user pages do not suffer from zone requirements.
So you can just migrate a user page in DMA zone to another node's
highmem zone.

Pages with zone requirements (DMA pages for driver buffers or user mmap()
on crappy hardware, lowmem restricted kernel pages (SLAB caches), etc.
can't be migrated easily (and no one attempted to do that yet AFAIK).

> This could very well be related to the "1 GB Memory is bad for you"
> problem described briefly here: http://kerneltrap.org/node/2450
> 
> Maybe it is possible to have a per-node LRU and always page out the
> least recently used page in the entire node, and then migrate pages to
> solve specific "within N bits of address space" requirements.

Pages with "N bits of address space" requirement pages can't be migrated
at the moment (on the hardware requirement it would be necessary to have
synchronization with driver operation, shutdown it down, and restartup 
it up...)

For SLAB there is no solution as far as I know (except an indirection 
level in memory access to these pages, as discussed in this years
memory hotplug presentation by Dave Hansen).

> But I'm probably underestimating the cost of page migration...

The zone balancing issue you describe might be an issue once zone
said pages can be migrated :)
