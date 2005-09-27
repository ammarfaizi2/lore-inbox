Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbVI0Mae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbVI0Mae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVI0Mae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:30:34 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:26451 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964839AbVI0Mae convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:30:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gsl0IbStgYSE8IDBMidjikySqmGM6f9T51q8oRs7S4FzDtj2aHYLVhQIs5dXFgtOfLFi/RdCe4ae13XfjmUVT2fZMXsFR3XnEUMljC+x2BWNXrwDo/mptaGI+paKMCJhWVOYhDxrJbvgm5Wd/bKFsTCgEoI+mS89aSBxLIW1/p4=
Message-ID: <cda58cb8050927053056ce6b96@mail.gmail.com>
Date: Tue, 27 Sep 2005 14:30:32 +0200
From: Franck <vagabon.xyz@gmail.com>
Reply-To: Franck <vagabon.xyz@gmail.com>
To: Marc Singer <elf@buici.com>
Subject: Re: questions on discontgmem.
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050926222207.GA987@buici.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cda58cb8050926114675524d59@mail.gmail.com>
	 <20050926191921.GA25724@buici.com>
	 <cda58cb805092612573bedb88d@mail.gmail.com>
	 <20050926222207.GA987@buici.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

2005/9/27, Marc Singer <elf@buici.com>:
> On Mon, Sep 26, 2005 at 09:57:10PM +0200, Franck wrote:
> > 2005/9/26, Marc Singer <elf@buici.com>:
> > > On Mon, Sep 26, 2005 at 08:46:34PM +0200, Franck wrote:
> > > > Hi,
> > > >
> > > > I'd like to use discontigmem to access several RAM memories on an _no_
> > > > NUMA embedded system. In that case, does a node  mean a single RAM
> > > > whose start address is very different from the others ?
> > >
> > > I don't know what you mean by this.  The difference between
> > > discontiguous memory and non-discontiguous [sic] memory is that, well,
> > > the latter is contiguous.  If you have 64MiB of RAM, it is addressed
> > > starting at a base address and all 64 MiB's of addresses following it
> > > are valid.
> > >
> > > Discontiguous memory means that that isn't true, there is more than
> > > one start address with gaps of addresses between them which are either
> > > invalid, or which are aliases of other addresses.
> > >
> >
> > yeah, I know what is discontiguous memory. What I'm trying to ask is:
> > in this case (discontiguous memory), the kernel seems to describe each
> > memory with a single node (cf alloc_page_node for instance). Unlike
> > for NUMA system where several memories can belong to the same node. Is
> > that correct ?
>
> I don't know what you mean by a 'memory'.  Are you talking about an
> IC?

yes I'm taking about IC. But each IC has a different start base
address with huge hole between each of them. For instance I have 2 RAM
mapped as shown below:

RAM1 -> physical address at 0x2000 0000, size = 32 Mo
RAM2 -> physical address at 0x3000 0000, size = 2 Mo

> performance characteristics of that access.  I write possibly because
> I've not worked with that attribute of discontigmem.
>

did you work on ARM discontig memory ?

> There is a potential misunderstanding in how discontigmem really
> works.  There may be a memory system which is truly discontiguous, but
> that uses a single node.  It is wasteful because the node tables are
> accessed as arrays, so non-existent pages require data structure space
> just as existent ones do.
>
> With discontigmem, we can use multiple nodes in order to cluster pages
> and eliminate unused array entries.  Assuming that this is *not* done
> for the sake of differing memory access times, the advantage is in
> saving node table space.  There are macros in the architecture/machine
> specific include files that create the mapping between physical
> addresses and nodes/pages.  At least, that's how ARM does it.
>

yes that what I understand. CONFIG_DISCONTIGMEM is used on UMA system
to avoid mem_map to blow up when using RAMs whose start base addresses
are separated with huge hole.

> > If so, how does the kernel select a node when allocating a page for a UMA ?
>
> Perhaps someone else can fill in that part.  I've been assuming that
> pages with equivalent access times are put in zones, on free-page
> lists and allocated as needed.  Nothing special is done with respect
> to the different discontigmem nodes.
>

hmm, not sure it works the way you described. I thought there were
nodes gathering several RAM whose start address are _contiguous_. Each
node has several zones (dma, normal and highmem). But I don't see how
allocation can be done using *all* nodes...

I found in "include/linux/gfp.h", for a UMA system:

               #define alloc_pages(gfp_mask, order) \
                            alloc_pages_node(numa_node_id(), gfp_mask, order)

and numa_node_id expands to 0 for a UP system.
Any Idea ?

Thanks
--
               Franck
