Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932543AbWKDA66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbWKDA66 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 19:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWKDA65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 19:58:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46466 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932543AbWKDA65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 19:58:57 -0500
Date: Fri, 3 Nov 2006 16:58:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
Message-Id: <20061103165854.0f3e77ad.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
	<20061103134633.a815c7b3.akpm@osdl.org>
	<Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
	<20061103143145.85a9c63f.akpm@osdl.org>
	<Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006 16:28:31 -0800 (PST)
Christoph Lameter <clameter@sgi.com> wrote:

> On Fri, 3 Nov 2006, Andrew Morton wrote:
> 
> > But in this application which you are proposing, any correlation with
> > elapsed walltime is very slight.  It's just the wrong baseline to use. 
> > What is the *sense* in it?
> 
> You just accepted Paul's use of a similar mechanism to void cached 
> zonelists. He has a one second timeout for the cache there it seems.

With complaints.

> The sense is that memory on nodes may be freed and then we need to 
> allocate from those nodes again.

This has almost nothing to do with elapsed time.

How about doing, in free_pages_bulk():

	if (zone->over_interleave_pages) {
		zone->over_interleave_pages = 0;
		node_clear(zone_to_nid(zone), full_interleave_nodes);
	}

?

> > Yes.  And it is wrong to do so.  Because a node may well have no "free"
> > pages but plenty of completely stale ones which should be reclaimed.
> 
> But there may be other nodes that have more free pages. If we allocate 
> from those then we can avoid reclaim.
> 
> > Reclaim isn't expensive.
> 
> It is needlessly expensive if its done for an allocation that is not bound 
> to a specific node and there are other nodes with free pages. We may throw 
> out pages that we need later.

Well it grossly changes the meaning of "interleaving".  We might as well
call it something else.  It's not necessarily worse, but it's not
interleaved any more.

Actually by staying on the same node for a string of successive allocations
it could well be quicker.  How come MPOL_INTERLEAVE doesn't already do some
batching?   Or does it, and I missed it?

