Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWIURyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWIURyy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 13:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWIURyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 13:54:54 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5825 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751401AbWIURyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 13:54:53 -0400
Date: Thu, 21 Sep 2006 10:54:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_DMA
In-Reply-To: <4512C469.5060107@mbligh.org>
Message-ID: <Pine.LNX.4.64.0609211045400.5959@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org>
 <20060920172253.f6d11445.akpm@osdl.org> <4511E1CA.6090403@mbligh.org>
 <Pine.LNX.4.64.0609201804320.2844@schroedinger.engr.sgi.com>
 <4511E9AC.2050507@mbligh.org> <Pine.LNX.4.64.0609210854210.5626@schroedinger.engr.sgi.com>
 <4512C469.5060107@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Martin Bligh wrote:

> I presume the fallback order for everything is still
> HIGHMEM -> NORMAL -> DMA, and nobody is proposing changing that.
> (ignoring DMA32 to keep thing simpler).

It would help if you would actually look at the code instead of presuming. 
No changes are made in that area.

> If a device driver wants "DMAable" memory, and thus does a ZONE_DMA
> allocation, and we've moved all its memory from ZONE_DMA to ZONE_NORMAL
> (as I think you're proposing doing for PPC64 (and ia64?)), then the
> allocation will fail.

I would not presume proposing anything for PPC64 and left everything the 
way it is. The arch people can control if they want ZONE DMA or not and 
the default is to leave things as is. If PPC64 wants to go ZONE_DMAless 
then the arch code needs to be modified not refer to ZONE_DMA anymore and 
if that works then we can switch CONFIG_ZONE_DMA off for PPC64. See the 
patches in mm for examples how other arches have done it.

> So are we saying that no driver code should be calling with GFP_DMA
> (a quick grep turns up 148 instances under driver/), that if they do
> they should only work on specific architectures (some instances were
> s390-only drivers)? If so, should we not be removing the definiton of
> GFP_DMA itself if ZONE_DMA is config'ed out, so that it fails at
> compile time, rather than runtime?

This was covered at length before. Removing all GFP_DMA references would 
require extensive #ifdefs. The limited patch in mm is only neutering 
GFP_DMA for arches that do not need it. If an arch has removed its definition of 
CONFIG_ZONE_DMA then __GFP_DMA will be ignored in the page allocator.
 
> > > AFAICS, the correct way to do this is have the requestor pass a memory
> > > bound into the allocator, and have the arch figure out which zones
> > > are applicable.
> > 
> > Exactly. But you cannot do that with ZONE_DMA __GFP_DMA. We likely need a
> > new page  allocator API for that.
> 
> Glad we're agreed on that, at least.

I think we agree on a lot more. Hopefully when we meet at lunch today we 
can sync some more.
