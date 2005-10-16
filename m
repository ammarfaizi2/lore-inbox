Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVJPUo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVJPUo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 16:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVJPUo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 16:44:29 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:27024 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751201AbVJPUo2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 16:44:28 -0400
Date: Sun, 16 Oct 2005 21:44:18 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: jschopp@austin.ibm.com, kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [PATCH 2/8] Fragmentation Avoidance V17: 002_usemap
In-Reply-To: <1129213109.7780.18.camel@localhost>
Message-ID: <Pine.LNX.4.58.0510162141150.14697@skynet>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie> 
 <20051011151231.16178.58396.sendpatchset@skynet.csn.ul.ie> 
 <1129211783.7780.7.camel@localhost>  <Pine.LNX.4.58.0510131500020.7570@skynet>
 <1129213109.7780.18.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2005, Dave Hansen wrote:

> > > > + * RCLM_SHIFT is the number of bits that a gfp_mask has to be shifted right
> > > > + * to have just the __GFP_USER and __GFP_KERNRCLM bits. The static check is
> > > > + * made afterwards in case the GFP flags are not updated without updating
> > > > + * this number
> > > > + */
> > > > +#define RCLM_SHIFT 19
> > > > +#if (__GFP_USER >> RCLM_SHIFT) != RCLM_USER
> > > > +#error __GFP_USER not mapping to RCLM_USER
> > > > +#endif
> > > > +#if (__GFP_KERNRCLM >> RCLM_SHIFT) != RCLM_KERN
> > > > +#error __GFP_KERNRCLM not mapping to RCLM_KERN
> > > > +#endif
> > >
> > > Should this really be in page_alloc.c, or should it be close to the
> > > RCLM_* definitions?
> >
> > I can't test it right now, but I think the reason it is here is because
> > RCLM_* and __GFP_* are in different headers that are not aware of each
> > other. This is the place a static compile-time check can be made.
>
> Well, they're pretty intricately linked, so maybe they should go in the
> same header, no?
>

I looked into this more and I did have a good reason for putting them in
different headers. The __GFP_* flags have to be defined with the other GFP
flags, it just does not make sense otherwise. The RCLM_* flags must be
with the definition of struct zone * because there determine the number of
free lists that exist in the zone. There is no obvious way to have the
RCLM_* and __GFP_* flags in the same place unless mmzone.h includes gfp.h
which I seriously doubt we want.

The value of RCLM_SHIFT depends on both __GFP_* and RCLM_* so it needs to
be defined in a place that can see both gfp.h and mmzone.h . As
page_alloc.c is the only user of RCLM_SHIFT, it made sense to define it
there.

Is there a clearer way of doing this?
