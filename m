Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261455AbSJDDVz>; Thu, 3 Oct 2002 23:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261456AbSJDDVy>; Thu, 3 Oct 2002 23:21:54 -0400
Received: from dp.samba.org ([66.70.73.150]:38819 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261455AbSJDDVx>;
	Thu, 3 Oct 2002 23:21:53 -0400
Date: Fri, 4 Oct 2002 13:27:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, David Miller <davem@redhat.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH,RFC] Add gfp_mask to get_vm_area()
Message-ID: <20021004032730.GL1933@zax>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	Andrew Morton <akpm@digeo.com>, David Miller <davem@redhat.com>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-embedded@lists.linuxppc.org
References: <20021001044226.GS10265@zax> <3D992DB0.9A8942D@digeo.com> <20021001053417.GW10265@zax> <20021003043948.GN1102@zax> <20021003045644.GO1102@zax> <20021003161816.I2304@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021003161816.I2304@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 04:18:16PM +0100, Russell King wrote:
> 
> On Thu, Oct 03, 2002 at 02:56:44PM +1000, David Gibson wrote:
> > Blah.  It gets worse.  Making map_page() or remap_page_range()
> > interrupt-safe would require making mm->page_table_lock irq-safe too
> > :-(
> >
> > Maybe non-coherent architectures should should pre-allocate a chunk of
> > virtual memory for consistent allocations, and pre-allocate all its
> > page tables.
> 
> There are a growing number of applications out there for ARM stuff where
> this would be impractical.  Those wanting about 3GB of kernel space vs
> 1GB user space.
> 
> Doubling the virtual requirement for the SDRAM will make Linux unusable
> in these situations, and then you'll have nice people from Intel and
> Montavista banging on your door asking you why you killed their product
> line.

Well I certainly wasn't we have an additional virtual mapping for all
of physical RAM - if nothing else that would waste a bunch of space in
page tables.  I was thinking of a pool of VM out of which to establish
new consistent mappings - with a simple and irq-safe allocated working
within the pre-allocated chunk of VM.

Which of course raises the hard question: how big should the pool be?
It would be possible to have something running in user context which
tops up the pool if it is low, but that starts getting complex, and
wouldn't help a driver which wants to allocate a large chunk of
consistent memory from interrupt context.

> The current situation on ARM works for 95% of cases.  If the choice is
> between "95% working" and "cutting off the hand that feeds you" I'd
> prefer the former.
> 
> On a more constructive note, I believe there is a way around the
> mm->page_table_lock problem.  I believe we should completely split the
> handling of the user space page tables from the kernel space page tables.
> 
> User space can carry on using mm->page_table_lock and be happy; it should
> never ever touch the kernel page tables.
> 
> We then only have to worry about making things that touch the kernel page
> tables irq-safe.  How many of those are there?  Two.  ioremap and vmalloc.
> Neither of these two functions has any business touching anything other
> than pid0's tables, and certainly has no business touching user space
> page tables.  The problem is now far easier to deal with.

Well, that sounds like it would work.  On the other hand, it seems
like a non-trivial set of modifications to the VM structure.

> remap_page_range() shouldn't be a problem - its supposed to map pages
> into user space, and if you're calling that from IRQ context, you're
> doing something really wrong.
> 
> If I can get out of my current circle of never-ending problems and paid-
> for work on other areas of ARM stuff, I might be able to look at this.
> I've currently got an estimated backlog of one whole week on anything I
> do atm.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
