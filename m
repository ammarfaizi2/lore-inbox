Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262729AbSJCEvR>; Thu, 3 Oct 2002 00:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSJCEvR>; Thu, 3 Oct 2002 00:51:17 -0400
Received: from dp.samba.org ([66.70.73.150]:6019 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262729AbSJCEvQ>;
	Thu, 3 Oct 2002 00:51:16 -0400
Date: Thu, 3 Oct 2002 14:56:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@digeo.com>, David Miller <davem@redhat.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH,RFC] Add gfp_mask to get_vm_area()
Message-ID: <20021003045644.GO1102@zax>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	David Miller <davem@redhat.com>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-embedded@lists.linuxppc.org
References: <20021001044226.GS10265@zax> <3D992DB0.9A8942D@digeo.com> <20021001053417.GW10265@zax> <20021003043948.GN1102@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003043948.GN1102@zax>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 02:39:48PM +1000, David Gibson wrote:
> 
> On Tue, Oct 01, 2002 at 03:34:17PM +1000, David Gibson wrote:
> >
> > On Mon, Sep 30, 2002 at 10:08:00PM -0700, Andrew Morton wrote:
> > >
> > > David Gibson wrote:
> > > >
> > > > Dave, please consider this patch.  It renames get_vm_area() to
> > > > __get_vm_area() and adds a gfp_mask parameter which is passed on to
> > > > kmalloc().  get_vm_area(size,flags) is then defined as as
> > > > __get_vm_area(size,flags,GFP_KERNEL) to avoid messing with existing
> > > > callers.
> > > >
> > > > We need this in order to sanely make pci_alloc_consistent() (and other
> > > > consistent allocation functions) obey the DMA-mapping.txt rules on PPC
> > > > embedded machines (specifically the requirement that it be callable
> > > > from interrupt context).
> > > >
> > >
> > > I can look after that for you.  But I'd prefer that you just add the
> > > extra gfp_flags argument to get_vm_area() and update the 16 callers.
> > >
> > > You cannot call get_vm_area() from interrupt context at present;
> > > it does write_lock(&vmlist_lock) unsafely.
> >
> > Oh crap, I'm an idiot.  I've even seen prototype patches for this one
> > that changed the write_lock() to write_lock_irq(). Duh.
> >
> > > It would be a bit sad to make vmlist_lock interrupt-safe for this.  Is
> > > there no alternative?
> >
> > I don't see an easy one: PPC 4xx has non-coherent cache, so we have to
> > mark consistent memory non-cacheable.  We want to make the normal
> > lowmem mapping use large page TLB entries, so we can't frob the
> > attribute bits on the pages in place.  That means we need to create a
> > new, non-cacheable mapping for the physical RAM we allocate, which in
> > turn means allocating a chunk of kernel virtual memory.
> 
> Well, here is an updated patch which should make the vmlist_lock
> interrupt-safe.  It makes __get_vm_area() and remove_vm_area()
> callable from interrupt context.  If you can think of some way of
> avoiding doing that, I'd love to hear it - I agree this would be
> rather sad.

Blah.  It gets worse.  Making map_page() or remap_page_range()
interrupt-safe would require making mm->page_table_lock irq-safe too
:-(

Maybe non-coherent architectures should should pre-allocate a chunk of
virtual memory for consistent allocations, and pre-allocate all its
page tables.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
