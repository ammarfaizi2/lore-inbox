Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753197AbWKFUMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbWKFUMz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbWKFUMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:12:55 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:17355 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753197AbWKFUMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:12:55 -0500
Date: Mon, 6 Nov 2006 12:12:50 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
In-Reply-To: <20061106115925.1dd41a77.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611061207310.26685@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
 <20061103134633.a815c7b3.akpm@osdl.org> <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
 <20061103143145.85a9c63f.akpm@osdl.org> <Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
 <20061103165854.0f3e77ad.akpm@osdl.org> <Pine.LNX.4.64.0611060846070.25351@schroedinger.engr.sgi.com>
 <20061106115925.1dd41a77.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006, Andrew Morton wrote:

> > It should do interleaving because the data is to be accessed from multiple 
> > nodes.
> 
> I think you missed the point.
> 
> At present the code does interleaving by taking one page from each zone and
> then advancing onto the next zone, yes?

s/zone/node/ then yes (zone == node if we just have a single zone).

> If so, this is pretty awful frmo a cache utilsiation POV.  it'd be much
> better to take 16 pages from one zone before advancing onto the next one.

The L1/L2 cpu cache or the pageset hot / cold caches? Take N pages 
from a node instead of 1? That would mean we need to have more complex 
interleaving logic that keeps track of how many pages we took. The number 
of pages to take will vary depending on the size of the shared data. For 
shared data areas that are just a couple of pages this wont work.

> > Clustering on a single node may create hotspots or imbalances. 
> 
> Umm, but that's exactly what the patch we're discussing will do.

Not if we have a set of remaining nodes.
