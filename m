Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUHMRdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUHMRdw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUHMRdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:33:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54452 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266293AbUHMRbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:31:52 -0400
Date: Fri, 13 Aug 2004 12:31:41 -0500
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
In-Reply-To: <200408130904.00537.jbarnes@engr.sgi.com>
Message-ID: <Pine.SGI.4.58.0408131220460.27384@kzerza.americas.sgi.com>
References: <2sxuC-429-3@gated-at.bofh.it> <m3657nu9dl.fsf@averell.firstfloor.org>
 <200408130904.00537.jbarnes@engr.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004, Jesse Barnes wrote:

> On Thursday, August 12, 2004 6:14 pm, Andi Kleen wrote:
> > I don't like this approach using a dynamic counter. I think it would
> > be better to add a new function that takes the vma and uses the offset
> > into the inode for static interleaving (anonymous memory would still
> > use the vma offset). This way you would have a good guarantee that the
> > interleaving stays interleaved even when the system swaps pages in and
> > out and you're less likely to get anomalies in the page distribution.
>
> That sounds like a good approach, care to show me exactly what you mean
> with a
> patch? :)

Make sure to have some sort of offset for the static interleaving that
is random or semi-random for each inode, as we discussed on linux-mm last
week.  Otherwise you'll end up with pages for small files clustered on
a few nodes, as the offset into the inode will never exceed some small
value.

And even though I know Andi doesn't care for a dynamic counter, this
last week I implemented a new MPOL_ROUNDROBIN using just such a counter.
The only significant difference from MPOL_INTERLEAVE is the use of a
per-task dynamic counter rather than an index based on offsets into a
vma and/or inode.  It seems to work quite well in my testing.  My next
step was going to be using this policy for tmpfs file allocations by
default (overridable by mbind()).  Does anyone think this idea has
merit?  If so I'll clean up the MPOL_ROUNDROBiN patch and post it,
then follow it by a tmpfs patch sometime soon (I'm just beginning
work on it).

Thanks,
Brent

-- 
Brent Casavant             bcasavan@sgi.com        Forget bright-eyed and
Operating System Engineer  http://www.sgi.com/     bushy-tailed; I'm red-
Silicon Graphics, Inc.     44.8562N 93.1355W 860F  eyed and bushy-haired.
