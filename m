Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936903AbWLFRbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936903AbWLFRbo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936930AbWLFRbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:31:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:33946 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S936903AbWLFRbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:31:43 -0500
Date: Wed, 6 Dec 2006 09:31:25 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Mel Gorman <mel@csn.ul.ie>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
 may be migrated
In-Reply-To: <Pine.LNX.4.64.0612060903161.7238@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0612060921230.26185@schroedinger.engr.sgi.com>
References: <20061204113051.4e90b249.akpm@osdl.org>
 <Pine.LNX.4.64.0612041133020.32337@schroedinger.engr.sgi.com>
 <20061204120611.4306024e.akpm@osdl.org> <Pine.LNX.4.64.0612041211390.32337@schroedinger.engr.sgi.com>
 <20061204131959.bdeeee41.akpm@osdl.org> <Pine.LNX.4.64.0612041337520.851@schroedinger.engr.sgi.com>
 <20061204142259.3cdda664.akpm@osdl.org> <Pine.LNX.4.64.0612050754560.11213@schroedinger.engr.sgi.com>
 <20061205112541.2a4b7414.akpm@osdl.org> <Pine.LNX.4.64.0612051159510.18687@schroedinger.engr.sgi.com>
 <20061205214721.GE20614@skynet.ie> <Pine.LNX.4.64.0612051521060.20570@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0612060903161.7238@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Mel Gorman wrote:
> Objective: Get contiguous block of free pages
> Required: Pages that can move
> Move means: Migrating them or reclaiming
> How we do it for high-order allocations: Take a page from the LRU, move
> 	the pages within that high-order block
> How we do it for unplug: Take the pages within the range of interest, move
> 	all the pages out of that range

This is mostly the same. For unplug we would clear the freelists of 
page in the unplug range and take the pages off the LRU that are in the 
range of interest and then move them. Page migration takes pages off the 
LRU.

> In both cases, you are taking a subsection of a zone and doing something to
> it. In the beginning, we'll be reclaiming because it's easier and it's
> relatively well understood. Once stable, then work can start on defrag
> properly.

Both cases require a scanning of the LRU or freelists for pages in 
that range. We are not actually doing reclaim since we do not age the 
pages. We evict them all and are not doing reclaim in the usual way.

> I don't intend to marry the two. However, I intend to handle reclaim first
> because it's needed whether defrag exists or not.

Yes and we already have reclaim implemented. It can be used for freeing up
memory in a zone. But if you want to open up a specific range then what we
do may look a bit like reclaim but its fundamentally different since we 
unconditionally clear the range regardless of aging.
