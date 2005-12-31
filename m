Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbVLaJzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbVLaJzO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 04:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVLaJzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 04:55:14 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.21]:50725 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932129AbVLaJzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 04:55:11 -0500
Subject: Re: [PATCH 1/9] clockpro-nonresident.patch
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Marijn Meijles <marijn@bitpit.net>, Rik van Riel <riel@redhat.com>
In-Reply-To: <20051231011324.GB4913@dmt.cnet>
References: <20051230223952.765.21096.sendpatchset@twins.localnet>
	 <20051230224222.765.32499.sendpatchset@twins.localnet>
	 <20051231011324.GB4913@dmt.cnet>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 10:54:46 +0100
Message-Id: <1136022886.17853.18.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 23:13 -0200, Marcelo Tosatti wrote:
> On Fri, Dec 30, 2005 at 11:42:44PM +0100, Peter Zijlstra wrote:
> > 
> > From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > 
> > Originally started by Rik van Riel, I heavily modified the code
> > to suit my needs.
> > 
> > The nonresident code approximates a clock but sacrifices precision in order
> > to accomplish faster lookups.
> > 
> > The actual datastructure is a hash of small clocks, so that, assuming an 
> > equal distribution by the hash function, each clock has comparable order.
> > 
> > TODO:
> >  - remove the ARC requirements.
> > 
> > Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> <snip>
> 
> > + *
> > + *
> > + * Modified to work with ARC like algorithms who:
> > + *  - need to balance two FIFOs; |b1| + |b2| = c,
> > + *
> > + * The bucket contains four single linked cyclic lists (CLOCKS) and each
> > + * clock has a tail hand. By selecting a victim clock upon insertion it
> > + * is possible to balance them.
> > + *
> > + * The first two lists are used for B1/B2 and a third for a free slot list.
> > + * The fourth list is unused.
> > + *
> > + * The slot looks like this:
> > + * struct slot_t {
> > + *         u32 cookie : 24; // LSB
> > + *         u32 index  :  6;
> > + *         u32 listid :  2;
> > + * };
> 
> 8 and 16 bit accesses are slower than 32 bit on i386 (Arjan pointed this out sometime ago).
> 
> Might be faster to load a full word and shape it as necessary, will see if I can do 
> something instead of talking. ;)

everything is 32bit except for the hands, but yes, this code needs to be
redone.

> > +/*
> > + * For interactive workloads, we remember about as many non-resident pages
> > + * as we have actual memory pages.  For server workloads with large inter-
> > + * reference distances we could benefit from remembering more. 
> > + */
> 
> This comment is bogus. Interactive or server loads have nothing to do
> with the inter reference distance. To the contrary, interactive loads
> have a higher chance to contain large inter reference distances, and
> many common server loads have strong locality.
> 
> <snip>

Happy to drop it, Rik?

> > +++ linux-2.6-git/include/linux/swap.h
> > @@ -152,6 +152,31 @@ extern void out_of_memory(gfp_t gfp_mask
> >  /* linux/mm/memory.c */
> >  extern void swapin_readahead(swp_entry_t, unsigned long, struct vm_area_struct *);
> >  
> > +/* linux/mm/nonresident.c */
> > +#define NR_b1		0
> > +#define NR_b2		1
> > +#define NR_free		2
> > +#define NR_lost		3
> 
> What is the meaning of "NR_lost" ? 

should have read, NR_unused, it is the available fourth hand which is
unused. I just put it there for completeness sake and remember
struggling with the name while doing it, guess I should've taken that as
a hint.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

