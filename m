Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVCODyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVCODyn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVCODym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:54:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:7676 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261691AbVCODyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:54:05 -0500
Subject: Re: [PATCH 0/4] sparsemem intro patches
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew E Tolentino <matthew.e.tolentino@intel.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Mike Kravetz <kravetz@us.ibm.com>,
       Bob Picco <bob.picco@hp.com>, Joel Schopp <jschopp@austin.ibm.com>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20050314183042.7e7087a2.akpm@osdl.org>
References: <1110834883.19340.47.camel@localhost>
	 <20050314183042.7e7087a2.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 19:53:42 -0800
Message-Id: <1110858822.19340.127.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-14 at 18:30 -0800, Andrew Morton wrote:
> Dave Hansen <haveblue@us.ibm.com> wrote:
> >
> >  The following four patches provide the last needed changes before the
> >  introduction of sparsemem.  For a more complete description of what this
> >  will do, please see this patch:
> > 
> >  http://www.sr71.net/patches/2.6.11/2.6.11-bk7-mhp1/broken-out/B-sparse-150-sparsemem.patch
> 
> I don't know what to think about this.  Can you describe sparsemem a little
> further, differentiate it from discontigmem and tell us why we want one?
>
> Is it for memory hotplug?  If so, how does it support hotplug?

Sparsemem is more flexible than discontig, and not tied to any existing
NUMA or MM structures like zones or pgdats.  That makes it ideal for
hotplug where those structures are going to be coming and going, sliced
and diced.

Another advantage is that sparse doesn't require each NUMA node's ranges
to be contiguous.  It can handle overlapping ranges between nodes with
no problems, where DISCONTIGMEM currently throws away that memory.
DISCONTIGMEM also requires that memory *inside* of a node be contiguous,
and have mem_map for all of it.  A once 64GB NUMA node with 63GB of the
memory removed wouldn't have much space left for anything but its
mem_map without sparsemem.

> To which architectures is this useful, and what is the attitude of the
> relevant maintenance teams?

We have implementations for NUMAQ, x86 Summit, flat x86, flat x86-64,
flat and NUMA ppc64, and some ia64 configurations.  All of those can
either do simulated, virtualized, or actual hardware memory hotplug of
some kind based on the sparsemem implementations. 

Not to put words in their mouths, but there hasn't been anything
negative that I can recall in a while from the architecture maintainers.
What was said that was negative was months ago, and resolved.  We've
been talking about this to most of them for quite a while now, and I
think they've grown accustomed to the idea. :)

I've cc'd all of the guilty parties.  Perhaps they can fill in my vague
statements with actual facts.  But, here are the vague statements
anyway:

  i386 - Martin Bligh seems happy with it, he helped design it.
x86-64 - Matt Tolentino has approached Andi Kleen with the necessary
         cleanups, and I believe the reaction has been positive.  I
         think Andi had some other non-hotplug plans for sparsemem, too.
 ppc64 - I can bribe Anton and Paul's employer.  Mike Kravetz and Joel
         Schopp have been working on this port, and I believe they've
         kept the maintainers informed and calm.
  ia64 - Quote from Jesse Barnes (November 19, 2004):

>         CONFIG_NONLINEAR (SPARSE's old name) should be the *only*
>         memory init code on ia64  when this is done.  That means
>         getting rid of both discontig and contig and virtual memmap...

         I believe Jesse's been keeping up with the development as well.


> Quoting from the above patch:
> 
> > Sparsemem replaces DISCONTIGMEM when enabled, and it is hoped that
> > it can eventually become a complete replacement.
> > ...
> > This patch introduces CONFIG_FLATMEM.  It is used in almost all
> > cases where there used to be an #ifndef DISCONTIG, because
> > SPARSEMEM and DISCONTIGMEM often have to compile out the same areas
> > of code.
> 
> Would I be right to worry about increasing complexity, decreased
> maintainability and generally increasing mayhem?

You certainly would be.  For the time being, this increases the number
of config options and places for us to screw up.  However, I am
confident at this point that we're doing the right thing.  We had a more
complicated version of sparsemem at first.  We stripped it down to the
bare bones, and that's what we would like to submit soon.  It has the
capability to replace discontig, and will eventually _reduce_
complexity.

One of my favorite ways to demonstrate why I think it's *simple* are the
architecture ports.  The longest added function that I can find in the
ports is 17 lines including whitespace.

139 insertions(+), 36 deletions(-) for ia64:
http://www.sr71.net/patches/2.6.11/2.6.11-bk7-mhp1/broken-out/B-sparse-180-sparsemem-ia64.patch

75 insertions(+), 17 deletions(-) for ppc64:
http://www.sr71.net/patches/2.6.11/2.6.11-bk7-mhp1/broken-out/B-sparse-170-sparsemem-ppc64.patch

x86_64 is broken up a little more, but it's probably smaller than the
ppc64 one.

> If a competent kernel developer who is not familiar with how all this code
> hangs together wishes to acquaint himself with it, what steps should he
> take?

Dan Phillips spelled out the basic concepts of chopping things up into
sections a few years ago:

	http://lwn.net/2002/0411/a/discontig.php3

However, we haven't yet implemented the phys_to_virt() translations that
he envisioned.  We don't need that until unless we need some advanced
hot-remove features which are many, many months away. 

Where should a competent kernel developer look to understand the code
more?

The sparsemem implementation isn't horribly deep.  At the implementation
level, it replaces pfn_to_page() and page_to_pfn().  It does that with
an array lookup and some bits from page->flags.  I'd check out a few
architectures' current implementations of those functions as well as the
one in the patch referenced at the beginning of the mail:
B-sparse-150-sparsemem.patch .

Next, see how the memory_present() abstraction allows the memory layout
of the system to be either encoded in arch-specific discontig structures
or fed into the arch-independent structures that sparse_init() uses to
set up the mem_section[] array.

You could also go look at some of the hotplug code, but this email is
getting long enough as it is :)

-- Dave

