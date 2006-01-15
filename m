Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWAOOBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWAOOBm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 09:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWAOOBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 09:01:42 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:36569 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750737AbWAOOBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 09:01:41 -0500
Date: Sun, 15 Jan 2006 14:00:21 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: akpm@osdl.org, lhms-devel@lists.sourceforge.net, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG: gfp_zone() not mapping zone modifiers correctly
 and bad ordering of fallback lists
In-Reply-To: <43C7EDCF.3050402@kolumbus.fi>
Message-ID: <Pine.LNX.4.58.0601151355040.28172@skynet>
References: <20060113155026.GA4811@skynet.ie> <43C7EDCF.3050402@kolumbus.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, Mika Penttilä wrote:

> Mel Gorman wrote:
>
> > Hi Andrew,
> >
> > This patch is divided into two parts and addresses a bug in how zone
> > fallback lists are calculated and how __GFP_* zone modifiers are mapped to
> > their equivilant ZONE_* type. It applies to 2.6.15-mm3 and has been tested
> > on x86 and ppc64. It has been reported by Yasunori Goto that it boots on
> > ia64. Details as follows;
> >
> > build_zonelists() attempts to be smart, and uses highest_zone() so that it
> > doesn't attempt to call build_zonelists_node() for empty zones.  However,
> > build_zonelists_node() is smart enough to do the right thing by itself and
> > build_zonelists() already has the zone index that highest_zone() is meant
> > to provide. So, remove the unnecessary function highest_zone().
> >
> > The helper function gfp_zone() assumes that the bits used in the zone
> > modifier
> > of a GFP flag maps directory on to their ZONE_* equivalent and just applies
> > a
> > mask. However, the bits do not map directly and the wrong fallback lists can
> > be used. If unluckly, the system can go OOM when plenty of suitable memory
> > is available. This patch redefines the __GFP_ zone modifier flags to allow
> > a simple mapping to their equivilant ZONE_ type.
> >
> >
> What's the exact failure case? Afaik, we loop though all the GFP_ZONETYPES,
> building the appropriate zone lists at 0 - GFP_ZONETYPES-1 indexes. So the
> direct GFP -> ZONE mapping should do the right thing.
>

It goes wrong if one tries to add a different zone. What is currently
there happens to work, but there seemed to be confusion of when __GFP_
bits were being used or when ZONE_ indices were used.

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
