Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVJWMuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVJWMuU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 08:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbVJWMuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 08:50:20 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:12855 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750710AbVJWMuT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 08:50:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U6N/dyyRCnBrZifoorTexRGJjF03x9Lfct3E9klF6EH0fZIsmYjs48sgASh5RT9nn7Yfq6DBVk7/73awP5yqIrlU/JtJ445S8/xFO+iw5Qw2bCCUUhdcCbd1JuVaOFdR8t38k86mzpVoCShchzUBtg/MCcOaVzhdekRJC6od5yw=
Message-ID: <aec7e5c30510230550j66d6e37fg505fd6041dca9bee@mail.gmail.com>
Date: Sun, 23 Oct 2005 21:50:18 +0900
From: Magnus Damm <magnus.damm@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Cc: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
In-Reply-To: <20051022005050.GA27317@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	 <aec7e5c30510201857r7cf9d337wce9a4017064adcf@mail.gmail.com>
	 <20051022005050.GA27317@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/05, Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> On Fri, Oct 21, 2005 at 10:57:02AM +0900, Magnus Damm wrote:
> > On 10/21/05, Christoph Lameter <clameter@sgi.com> wrote:
> > > Page migration is also useful for other purposes:
> > >
> > > 1. Memory hotplug. Migrating processes off a memory node that is going
> > >    to be disconnected.
> > >
> > > 2. Remapping of bad pages. These could be detected through soft ECC errors
> > >    and other mechanisms.
> >
> > 3. Migrating between zones.
> >
> > The current per-zone LRU design might have some drawbacks. I would
> > prefer a per-node LRU to avoid that certain zones needs to shrink more
> > often than others. But maybe that is not the case, please let me know
> > if I'm wrong.
> >
> > If you think about it, say that a certain user space page happens to
> > be allocated from the DMA zone, and for some reason this DMA zone is
> > very popular because you have crappy hardware, then it might be more
> > probable that this page is paged out before some other much older/less
> > used page in another (larger) zone. And I guess the same applies to
> > small HIGHMEM zones.
>
> User pages (accessed through their virtual pte mapping) can be moved
> around zones freely - user pages do not suffer from zone requirements.
> So you can just migrate a user page in DMA zone to another node's
> highmem zone.

Exactly. If I'm not mistaken only anonymous pages and page cache are
present on the LRU lists. And like you say, these pages do not really
suffer from zone requirements. So to me, the only reason to have one
LRU per zone is to be able to shrink the amount of LRU pages per zone
if pages are allocated with specific zone requirements and the
watermarks are reached.

> Pages with zone requirements (DMA pages for driver buffers or user mmap()
> on crappy hardware, lowmem restricted kernel pages (SLAB caches), etc.
> can't be migrated easily (and no one attempted to do that yet AFAIK).

I suspected so. But such pages are never included on the LRU lists, right?

> > This could very well be related to the "1 GB Memory is bad for you"
> > problem described briefly here: http://kerneltrap.org/node/2450
> >
> > Maybe it is possible to have a per-node LRU and always page out the
> > least recently used page in the entire node, and then migrate pages to
> > solve specific "within N bits of address space" requirements.
>
> Pages with "N bits of address space" requirement pages can't be migrated
> at the moment (on the hardware requirement it would be necessary to have
> synchronization with driver operation, shutdown it down, and restartup
> it up...)

That's what I thought. But the point I was trying to make was probably
not very clear... Let me clarify a bit.

Today there is a small chance that a user space page might be
allocated from a zone that has very few pages compared to other zones,
and this might lead to that page gets paged out earlier than if the
page would have been allocated from another larger zone.

I propose to have one LRU per node instead of one per zone. When the
kernel then needs to allocate a page with certain requirements
("within N bits of address space") and that zone has too few free
pages, instead of shrinking the per-zone LRU we use page migration.

So, first we check if the requested amount of pages is available in
any zone in the node. If not we shrink the per-node LRU to free up
some pages. Then we somehow locate any unlocked pages in the zone that
is low on pages (no LRU here). These pages are then migrated to free
pages from any other zone. And this migration gives us free pages in
the requested zone.

> For SLAB there is no solution as far as I know (except an indirection
> level in memory access to these pages, as discussed in this years
> memory hotplug presentation by Dave Hansen).

Maybe SLAB defragmentation code is suitable for page migration too?

> > But I'm probably underestimating the cost of page migration...
>
> The zone balancing issue you describe might be an issue once zone
> said pages can be migrated :)

My main concern is that we use one LRU per zone, and I suspect that
this design might be suboptimal if the sizes of the zones differs
much. But I have no numbers.

There are probably not that many drivers using the DMA zone on a
modern PC, so instead of bringing performance penalty on the entire
system I think it would be nicer to punish the evil hardware instead.

Thanks!

/ magnus
