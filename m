Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWFFFON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWFFFON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 01:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWFFFON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 01:14:13 -0400
Received: from silver.veritas.com ([143.127.12.111]:19085 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932112AbWFFFON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 01:14:13 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,213,1146466800"; 
   d="scan'208"; a="38859910:sNHT23343140"
Date: Tue, 6 Jun 2006 06:14:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@sgi.com>, mbligh@google.com, apw@shadowen.org,
       mbligh@mbligh.org, linux-kernel@vger.kernel.org, ak@suse.de,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <20060605135812.30138205.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org>
 <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org>
 <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
 <44848DD2.7010506@shadowen.org> <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
 <44848F45.1070205@shadowen.org> <44849075.5070802@google.com>
 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com>
 <20060605135812.30138205.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Jun 2006 05:14:12.0385 (UTC) FILETIME=[0C3FE910:01C68928]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006, Andrew Morton wrote:
> On Mon, 5 Jun 2006 13:43:47 -0700 (PDT)
> Christoph Lameter <clameter@sgi.com> wrote:
> 
> > Fix this by limiting the number of swap devices in swapon to 
> > MAX_SWAPFILES
> > 
> > Signed-off-by: Christoph Lameter <clameter@sgi.com>
> > 
> > Index: linux-2.6.17-rc5-mm2/mm/swapfile.c
> > ===================================================================
> > --- linux-2.6.17-rc5-mm2.orig/mm/swapfile.c	2006-06-01 10:03:07.127259731 -0700
> > +++ linux-2.6.17-rc5-mm2/mm/swapfile.c	2006-06-05 13:40:45.887291175 -0700
> > @@ -1408,8 +1408,13 @@ asmlinkage long sys_swapon(const char __
> >  		spin_unlock(&swap_lock);
> >  		goto out;
> >  	}
> > -	if (type >= nr_swapfiles)
> > +	if (type >= nr_swapfiles) {
> > +		if (nr_swapfiles >= MAX_SWAPFILES) {
> > +			spin_unlock(&swap_lock);
> > +			goto out;
> > +		}
> >  		nr_swapfiles = type+1;
> > +	}
> >  	INIT_LIST_HEAD(&p->extent_list);
> >  	p->flags = SWP_USED;
> >  	p->swap_file = NULL;
> 
> Thanks, Christoph.  So we get to keep the crappy test?

Christoph's patch looks like it will fix the corruption to me (though
I'd have thought the alternative below a little cleaner, keeping the
associated tests together and avoiding a second unlock: whatever).

Whether it's correct depends on what Martin was trying to achieve
with his test.  I'm surprised to find a very ordinary
#define __swp_type(entry)	(((entry).val >> 2) & 0x1f)
in include/asm-s390/pgtable.h, and no architecture with a more
limiting mask.

I had expected that s390 (or some other) was short of bits and was
having to use a more limiting mask: in which case neither Christoph's
patch nor the one below would be appropriate, since the migration
types 30 and 31 would then fall outside the mask (though it'd only
be a problem if page migration were required on such an architecture).

So, the patch should do for now, but it'd be helpful if Martin can
explain why he needed to use that test in 2.6.5.  (Perhaps he went
through a phase of reducing the swap type and extending the swap
offset, and this is a remnant of that phase?)

> I wonder what LTP was corrupting before it started to corrupt page
> migration data?
> 
> The above looks like a 2.6.17 thing to me.

Not really (though the clarity and reassurance of the additional
MAX_SWAPFILES test is good).  We went over it a year or two back,
and the macro contortions do involve MAX_SWAPFILES_SHIFT: which
up to and including 2.6.17 has enforced the MAX_SWAPFILES limit.

But swapless migration has changed the relationship between
MAX_SWAPFILES_SHIFT and MAX_SWAPFILES (-2 when CONFIG_MIGRATION),
hence this corruption now surfacing in -mm.

Hugh

--- 2.6.17-rc5-mm3/mm/swapfile.c	2006-06-04 11:52:47.000000000 +0100
+++ linux/mm/swapfile.c	2006-06-06 05:23:05.000000000 +0100
@@ -1404,7 +1404,8 @@ asmlinkage long sys_swapon(const char __
 	 * from the initial ~0UL that can't be encoded in either the
 	 * swp_entry_t or the architecture definition of a swap pte.
 	 */
-	if (type > swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))) {
+	if (type >= MAX_SWAPFILES ||
+	    type > swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))) {
 		spin_unlock(&swap_lock);
 		goto out;
 	}
