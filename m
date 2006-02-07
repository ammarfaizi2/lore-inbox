Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWBGSLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWBGSLK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWBGSLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:11:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42943 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932075AbWBGSLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:11:08 -0500
Date: Tue, 7 Feb 2006 10:10:58 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: OOM behavior in constrained memory situations
In-Reply-To: <200602071858.13002.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602071005310.24993@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com>
 <200602071845.19567.ak@suse.de> <Pine.LNX.4.62.0602070947100.24920@schroedinger.engr.sgi.com>
 <200602071858.13002.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006, Andi Kleen wrote:

> On Tuesday 07 February 2006 18:51, Christoph Lameter wrote:
> 
> > > I back then spent some time to make the data structure as small as possible
> > > and I would hate to destroy it with such thoughtless changes.
> > 
> > Well the ability to set bits for policy controlled allocations may come in 
> > handy if we want to support memory policy controlling some other aspect 
> > for page allocation.
> 
> Actually looking at it again "v" should be aligned to 4 bytes anyways, so
> there is a unused 2 byte hole that you can use for this.
> 
> Still think the way of converting the policy is more elegant though.

True I could use these two spare bytes to store the 2 highest bytes of the 
GFP flags. But then I'd still have some more complicated bit arithmetic in the 
hot code paths of the page allocator to wedge these bits into the gfp 
flags.
 
> > > > Should the system swap if an MPOL_BIND request does not find enough 
> > > > memory? Maybe it would be good to not swap, rely on zone_reclaim only and 
> > > > fail if there is no local memory? 
> > > 
> > > Not sure. I guess it depends. Maybe it needs a nodeswappiness sysctl.
> > 
> > Hmm.... Maybe make this a separate post?
> 
> Do you have enough new thoughts on it for one?

Right now I think it could just work by simply not swapping for 
constrained allocations. Do an agressive zone_reclaim that writes out 
potentially dirty pages if needed. But that is a significant change of 
memory allocation behavior. Maybe that would need some kind of option 
during bind that would then set something in the gfp_flags that would then 
trigger the agressive zone_reclaim?

