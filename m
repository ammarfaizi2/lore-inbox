Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVARF4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVARF4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 00:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVARF4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 00:56:17 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:14816 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261238AbVARF4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 00:56:15 -0500
Date: Tue, 18 Jan 2005 11:29:34 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       rusty@rustcorp.com.au, dipankar@in.ibm.com
Subject: Re: [patch] mm: Reimplementation of dynamic percpu memory allocator
Message-ID: <20050118055934.GB3143@impedimenta.in.ibm.com>
References: <20050113083412.GA7567@impedimenta.in.ibm.com> <20050113005730.0e10b2d9.akpm@osdl.org> <20050114150519.GA3189@impedimenta.in.ibm.com> <20050114013425.77ad7c3f.akpm@osdl.org> <20050117182735.GA2322@impedimenta.in.ibm.com> <20050117141117.4606b58a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117141117.4606b58a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 02:11:17PM -0800, Andrew Morton wrote:
> Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
> >
> >  > So...  is it not possible to enhance vmalloc() for node-awareness, then
> >  > just use it?
> >  > 
> > 
> >  Memory for block management (free lists, bufctl lists) is also resident 
> >  in one block.  A typical block in this allocator looks like this:
> > 
> 
> I still don't get it.  It is possible to calculate the total size of the
> block beforehand, yes?  So why not simply vmalloc_numa() a block of that
> size then populate it?

I should be excited to add a new api ;), but, then we would have something
like:
 
void *vmalloc_numa(unsigned long size, unsigned long extra)

which would 
1. Allocate (size * NR_CPUS + extra) worth of va space (vm_struct)
2. Allocate node local pages amounting to 'size' for each possible cpu
3. Allocate pages for 'extra'
4. Mapping 'size' amount of pages allocated for cpus to corresponding 
   va space beginning from  vm_struct.addr to 
  (vm_struct.addr + NR_CPUS * size - 1) 
5. Map vm_struct.addr + NR_CPUS * size to pages allocated for extra in (3).

It is the need for this 'extra' -- the block management memory, which made me 
think against a common api outside the allocator.  If you feel vmalloc_numa 
is the right approach, I will make a patch to put it in vmalloc.c in the 
next iteration.

Thanks,
Kiran

