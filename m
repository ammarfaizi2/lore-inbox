Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWBGSCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWBGSCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 13:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWBGSCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 13:02:17 -0500
Received: from cantor.suse.de ([195.135.220.2]:23739 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964778AbWBGSCQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 13:02:16 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: OOM behavior in constrained memory situations
Date: Tue, 7 Feb 2006 18:58:12 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com> <200602071845.19567.ak@suse.de> <Pine.LNX.4.62.0602070947100.24920@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602070947100.24920@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071858.13002.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 18:51, Christoph Lameter wrote:

> > I back then spent some time to make the data structure as small as possible
> > and I would hate to destroy it with such thoughtless changes.
> 
> Well the ability to set bits for policy controlled allocations may come in 
> handy if we want to support memory policy controlling some other aspect 
> for page allocation.

Actually looking at it again "v" should be aligned to 4 bytes anyways, so
there is a unused 2 byte hole that you can use for this.

Still think the way of converting the policy is more elegant though.

> > when MPOL_BIND == node_online_map automatically revert to MPOL_PREFERED with empty mask.
> > Then on the allocation only set the gfp flag for MPOL_BIND
> 
> That would work for MPOL_BIND. How about MPOL_INTERLEAVE with a restricted 
> set of nodes? cpusets may cause any policy to have a restricted nodeset.

MPOL_INTERLEAVE isn't strict, so it can never cause OOMs unless the complete
system is out of memory. It just changes which node is tried first.

> 
> > > Should the system swap if an MPOL_BIND request does not find enough 
> > > memory? Maybe it would be good to not swap, rely on zone_reclaim only and 
> > > fail if there is no local memory? 
> > 
> > Not sure. I guess it depends. Maybe it needs a nodeswappiness sysctl.
> 
> Hmm.... Maybe make this a separate post?

Do you have enough new thoughts on it for one?

> > > We could change __GFP_NO_OOM_KILLER to __GFP_CONSTRAINED_ALLOC and then 
> > > not invoke kswapd and neither the OOM killer on a constrained allocation.
> > 
> > That could be a problem if one node is filled with dirty file cache pages,
> > no? There needs to be some action to free it. I had a few reports of this case.
> > It needs to make at least some effort to wait for these pages and push them out.
> 
> zone_reclaim can be configured to write out dirty file cache pages during 
> reclaim. So this could be addressed. 

Would be good.

-Andi
