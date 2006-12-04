Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967190AbWLDVU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967190AbWLDVU3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937401AbWLDVU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:20:29 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50973 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937400AbWLDVU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:20:28 -0500
Date: Mon, 4 Dec 2006 13:19:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Mel Gorman <mel@skynet.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
Message-Id: <20061204131959.bdeeee41.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612041211390.32337@schroedinger.engr.sgi.com>
References: <20061130170746.GA11363@skynet.ie>
	<20061130173129.4ebccaa2.akpm@osdl.org>
	<Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie>
	<20061201110103.08d0cf3d.akpm@osdl.org>
	<20061204140747.GA21662@skynet.ie>
	<20061204113051.4e90b249.akpm@osdl.org>
	<Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
	<20061204120611.4306024e.akpm@osdl.org>
	<Pine.LNX.4.64.0612041211390.32337@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 12:17:26 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> > I suspect you'll have to live with that.  I've yet to see a vaguely sane
> > proposal to otherwise prevent unreclaimable, unmoveable kernel allocations
> > from landing in a hot-unpluggable physical memory region.
> 
> Mel's approach already mananges memory in a chunks of MAX_ORDER. It is 
> easy to just restrict the unmovable types of allocation to a section of 
> the zone.

What happens when we need to run reclaim against just a section of a zone?
Lumpy-reclaim could be used here; perhaps that's Mel's approach too?

We'd need new infrastructure to perform the
section-of-a-zone<->physical-memory-block mapping, and to track various
states of the section-of-a-zone.  This will be complex, and buggy.  It will
probably require the introduction of some sort of "sub-zone" structure.  At
which stage people would be justified in asking "why didn't you just use
zones - that's what they're for?"

> Then we should be doing some work to cut down the number of unmovable 
> allocations.

That's rather pointless.  A feature is either reliable or it is not.  We'll
never be able to make all kernel allocations reclaimable/moveable so we'll
never be reliable with this approach.  I don't see any alternative to the
never-allocate-kernel-objects-in-removeable-memory approach.  
