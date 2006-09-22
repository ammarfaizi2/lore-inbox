Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWIVC7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWIVC7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 22:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWIVC7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 22:59:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29093 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932240AbWIVC7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 22:59:14 -0400
Date: Thu, 21 Sep 2006 19:59:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Martin Bligh <mbligh@mbligh.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Rohit Seth <rohitseth@google.com>
Subject: Re: ZONE_DMA
In-Reply-To: <45131D2D.8020403@mbligh.org>
Message-ID: <Pine.LNX.4.64.0609211937460.4433@schroedinger.engr.sgi.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <4511D855.7050100@mbligh.org>
 <20060920172253.f6d11445.akpm@osdl.org> <4511E1CA.6090403@mbligh.org>
 <Pine.LNX.4.64.0609201804320.2844@schroedinger.engr.sgi.com>
 <4511E9AC.2050507@mbligh.org> <Pine.LNX.4.64.0609210854210.5626@schroedinger.engr.sgi.com>
 <4512C469.5060107@mbligh.org> <Pine.LNX.4.64.0609211045400.5959@schroedinger.engr.sgi.com>
 <45131D2D.8020403@mbligh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006, Martin Bligh wrote:

> Just ignoring GFP_DMA in the allocator seems like a horrible violation
> to me. GFP_DMA means "give me memory from ZONE_DMA". We're both well
> aware that the whole concept of ZONE_DMA doesn't make much sense, but
> still, that's what it does.

We agreed that the definition of ZONE_DMA is not consistent across 
architectures.

The concept of ZONE_DMA makes only sense in terms of an architectures 
definition if a memory boundary (MAX_DMA_ADDRESS) exists for special DMA 
devices not able to reach all of memory. If we do not have ZONE_DMA then the 
architecture has to remove the definition of CONFIG_ZONE_DMA 
and with that action told us that it is allowable to ignore GFP_DMA since 
all devices can do DMA to all of memory (and all of memory is memory 
without a border which is of course in ZONE_NORMAL).

GFP_DMA like GFP_HIGHMEM and GFP_DMA32 means give me memory from the zone 
if its there. If not (the arch has no such memory) we fall back to ZONE_NORMAL.

This is fully consistent with established uses.

> So if you just put all of memory in ZONE_DMA for your particular
> machine, and bumped the DMA limit up to infinity, we wouldn't need
> any of these patches, right? Which would also match what the other
> arches do for this (eg PPC64).

That would mean abusing ZONE_DMA for a purpose it was not intended for. 
ZOME_DMA is used to partition memory for a DMA not for covering all of 
memory. That works yes but it shows a misunderstanding of the purpose for 
which ZONE_DMA was created.

Also if you would do that then ZONE_NORMAL would be empty and you would 
not be able to reach the goal of a system with a single zone. The slab 
allocator gets thoroughly confused and waste pages allocating 
memory in different slabs for ZONE_NORMAL and ZONE_DMA but they end up in 
the same ZONE_DMA. Various other bits and pieces of the VM behave in 
strange way but it works mostly. Seems that you got lucky but this should 
be fixed.

ZONE_NORMAL is DMAable. GFP_DMA has never meant this is for DMA but it has 
always meant this is for a special restricted DMA zone. That is also why 
you have GFP_DMA32. Both GFP_DMA and GFP_DMA32 select special restricted 
memory areas for handicapped DMA devices that are not able to reach all of 
memory. Neither should cover all of memory.

