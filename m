Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbVJTXqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbVJTXqa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVJTXqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:46:30 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:60304 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932555AbVJTXq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:46:29 -0400
Date: Thu, 20 Oct 2005 16:46:21 -0700
From: mike kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-ID: <20051020234621.GL5490@w-mikek2.ibm.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com> <20051020160638.58b4d08d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051020160638.58b4d08d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2005 at 04:06:38PM -0700, Andrew Morton wrote:
> Christoph Lameter <clameter@sgi.com> wrote:
> >
> > Page migration is also useful for other purposes:
> > 
> >  1. Memory hotplug. Migrating processes off a memory node that is going
> >     to be disconnected.
> > 
> >  2. Remapping of bad pages. These could be detected through soft ECC errors
> >     and other mechanisms.
> 
> It's only useful for these things if it works with close-to-100% reliability.
> 
> And there are are all sorts of things which will prevent that - mlock,
> ongoing direct-io, hugepages, whatever.

Since soft errors could happen almost anywhere, you are not going to get
close to 100% there.  'General purpose' memory hotplug is going to need
some type of page/memory grouping like Mel Gorman's fragmentation avoidance
patches.  Using such groupings, you can almost always find 'some' section
that can be offlined.  It is not close to 100%, but without it your chances
of finding a section are closer to 0%.  For applications of hotplug where
the only requirement is to remove a quantity of memory (and we are not
concerned about specific physical sections of memory) this appears to be
a viable approach.  Once you start talking about removing specific pieces
of memory, I think the only granularity that makes sense at this time is
an entire NUMA node.  Here, I 'think' you could limit the type of allocations
made on the node to something like highmem.  But, I haven't been looking
into the offlining of specific sections.  Only the offlining of any section.

Just to be clear, there are at least two distinct requirements for hotplug.
One only wants to remove a quantity of memory (location unimportant).  The
other wants to remove a specific section of memory (location specific).  I
think the first is easier to address.

-- 
Mike
