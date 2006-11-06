Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753835AbWKFVnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbWKFVnA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbWKFVnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:43:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:31123 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1753835AbWKFVm7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:42:59 -0500
Date: Mon, 6 Nov 2006 13:42:56 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Avoid allocating during interleave from almost full nodes
In-Reply-To: <20061106132029.28cd88b5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0611061334380.30192@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611031256190.15870@schroedinger.engr.sgi.com>
 <20061103134633.a815c7b3.akpm@osdl.org> <Pine.LNX.4.64.0611031353570.16486@schroedinger.engr.sgi.com>
 <20061103143145.85a9c63f.akpm@osdl.org> <Pine.LNX.4.64.0611031622540.16997@schroedinger.engr.sgi.com>
 <20061103165854.0f3e77ad.akpm@osdl.org> <Pine.LNX.4.64.0611060846070.25351@schroedinger.engr.sgi.com>
 <20061106115925.1dd41a77.akpm@osdl.org> <Pine.LNX.4.64.0611061207310.26685@schroedinger.engr.sgi.com>
 <20061106122446.8269f7bc.akpm@osdl.org> <Pine.LNX.4.64.0611061229080.29760@schroedinger.engr.sgi.com>
 <20061106124257.deffa31c.akpm@osdl.org> <Pine.LNX.4.64.0611061252140.29760@schroedinger.engr.sgi.com>
 <20061106132029.28cd88b5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2006, Andrew Morton wrote:

> But doesn't this patch introduce considerable risks of the above problems
> occurring?  In the two-nodes-have-lots-of-free-memory scenario?

If two nodes have lots of memory then we will alternate between both 
nodes. If one of the nodes is going below the interleave limit then we 
will indeed only allocate from that single node. At some point both are 
dropping below the limit and we will revert back to alternating.

We can avoid the phase where we only allocate from one node by checking 
the node weight of the available nodes instead of checking for an empty 
node mask.

For systems with less than 3 nodes the approach will not be useful. What I 
had in mind when writing this patch were systems with a large number of 
nodes segmented by cpusets into smaller slices. The segments would 
still be greater than 4 nodes.
