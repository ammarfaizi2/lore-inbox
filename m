Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945983AbWANCZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945983AbWANCZO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 21:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945984AbWANCZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 21:25:14 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:65431 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1945983AbWANCZM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 21:25:12 -0500
Subject: Re: [PATCH] BUG: gfp_zone() not mapping zone modifiers correctly
	and bad ordering of fallback lists
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mel Gorman <mel@csn.ul.ie>, lhms-devel@lists.sourceforge.net,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060113121652.114941a3.akpm@osdl.org>
References: <20060113155026.GA4811@skynet.ie>
	 <20060113121652.114941a3.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 18:24:44 -0800
Message-Id: <1137205485.7130.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 12:16 -0800, Andrew Morton wrote:
> mel@csn.ul.ie (Mel Gorman) wrote:
> > build_zonelists() attempts to be smart, and uses highest_zone() so that it
> > doesn't attempt to call build_zonelists_node() for empty zones.  However,
> > build_zonelists_node() is smart enough to do the right thing by itself and
> > build_zonelists() already has the zone index that highest_zone() is meant
> > to provide. So, remove the unnecessary function highest_zone().
> 
> Dave, Andy: could you please have a think about the fallback list thing?

It's bogus.  Mel, I didn't take a close enough look when we were talking
about it earlier, and I fear I led you astray.  I misunderstood what it
was trying to do, and though that the zone_populated() check replaced
the highest_zone() check, when they actually do completely different
things.

highest_zone(zone_nr) actually means, given these "zone_bits" (which is
actually a set of __GFP_XXXX flags), what is the highest zone number
that we could possibly use to satisfy an allocation with those __GFP
flags.

We can't just get rid of it.  If we do, we might put a highmem zone in
the fallback list for a normal zone.  Badness.

So, Mel, I have couple of patches that I put together that the two
copies of build_zonelists(), and move some of build_zonelists() itself
down into build_zonelists_node(), including the highest_zone() call.
They're no good to you by themselves.  But, I think we can make a little
function to go into the loop in build_zonelists_node().  The new
function would ask, "can this zone be used to satisfy this GFP mask?"
We'd start the loop at the absolutely highest-numbered zone.  I think
that's a decently clean way to do what you want with the reclaim zone.  

In the process of investigating this, I noticed that Andy's nice
calculation and comment for GFP_ZONETYPES went away.  Might be nice to
put it back, just so we know how '5' got there:

http://www.kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ac3461ad632e86e7debd871776683c05ef3ba4c6

Mel, you might also want to take a look at what Linus is suggesting
there.

-- Dave

