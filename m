Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVJMOSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVJMOSz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 10:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVJMOSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 10:18:55 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:26594 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750810AbVJMOSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 10:18:55 -0400
Subject: Re: [PATCH 2/8] Fragmentation Avoidance V17: 002_usemap
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: Andrew Morton <akpm@osdl.org>, jschopp@austin.ibm.com, kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0510131500020.7570@skynet>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
	 <20051011151231.16178.58396.sendpatchset@skynet.csn.ul.ie>
	 <1129211783.7780.7.camel@localhost>
	 <Pine.LNX.4.58.0510131500020.7570@skynet>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 07:18:29 -0700
Message-Id: <1129213109.7780.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 15:10 +0100, Mel Gorman wrote:
> On Thu, 13 Oct 2005, Dave Hansen wrote:
> > > +static inline int pfn_to_bitidx(struct zone *zone, unsigned long pfn)
> > > +{
> > > +	pfn &= (PAGES_PER_SECTION-1);
> > > +	return (int)((pfn >> (MAX_ORDER-1)) * BITS_PER_RCLM_TYPE);
> > > +}
> >
> > Why does that return int?  Should it be "unsigned long", maybe?  Also,
> > that cast is implicit in the return and shouldn't be needed.
> >
> 
> It returns int because the bit functions like assign_bit() expect an int
> for the bit index, not an unsigned long or anything else.

You don't need to explicitly cast between int and unsigned long.  It'll
probably hide more bugs than it reveals.

> > >  /*
> > > + * RCLM_SHIFT is the number of bits that a gfp_mask has to be shifted right
> > > + * to have just the __GFP_USER and __GFP_KERNRCLM bits. The static check is
> > > + * made afterwards in case the GFP flags are not updated without updating
> > > + * this number
> > > + */
> > > +#define RCLM_SHIFT 19
> > > +#if (__GFP_USER >> RCLM_SHIFT) != RCLM_USER
> > > +#error __GFP_USER not mapping to RCLM_USER
> > > +#endif
> > > +#if (__GFP_KERNRCLM >> RCLM_SHIFT) != RCLM_KERN
> > > +#error __GFP_KERNRCLM not mapping to RCLM_KERN
> > > +#endif
> >
> > Should this really be in page_alloc.c, or should it be close to the
> > RCLM_* definitions?
> 
> I can't test it right now, but I think the reason it is here is because
> RCLM_* and __GFP_* are in different headers that are not aware of each
> other. This is the place a static compile-time check can be made.

Well, they're pretty intricately linked, so maybe they should go in the
same header, no?

> It was pointed out that type used for use with the bit functions should
> all be unsigned long, not int as they were previously. However, I found if
> I used unsigned long throughout the code, including for array operations,
> there was a 10-12% slowdown in AIM9. These casts were the compromise.
> alloctype is unsigned long when used with the functions like assign_bit()
> but int every other time.

Why does it slow down?  Do you have any detailed profiles?

> In this case, there is an implicit cast so the cast is redundent if that
> is the problem you are pointing out. I can remove the explicit casts that
> are dotted around the place.

There needs to be a reason for the casts.  They certainly don't help
readability or correctness, so there needs to be some justification.  If
there are performance reasons somehow, they need to be analyzed as well.

-- Dave

