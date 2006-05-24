Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWEXEXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWEXEXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWEXEXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:23:13 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:14555 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S932551AbWEXEXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:23:13 -0400
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists.
From: Arjan van de Ven <arjan@infradead.org>
To: David Chinner <dgc@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20060524040142.GC7418631@melbourne.sgi.com>
References: <20060524012412.GB7412499@melbourne.sgi.com>
	 <1148435980.3049.11.camel@laptopd505.fenrus.org>
	 <20060524040142.GC7418631@melbourne.sgi.com>
Content-Type: text/plain
Date: Wed, 24 May 2006 06:23:09 +0200
Message-Id: <1148444589.3049.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 14:01 +1000, David Chinner wrote:
> On Wed, May 24, 2006 at 03:59:40AM +0200, Arjan van de Ven wrote:
> > On Wed, 2006-05-24 at 11:24 +1000, David Chinner wrote:
> > 
> > 
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=114491661527656&w=2
> > > 
> > > shrink_dcache_sb() becomes a severe bottleneck when the unused dentry
> > > list becomes long and mounts and unmounts occur frequently on the
> > > machine.
> > 
> > how does a per SB list deal with umounts that occur frequently? I
> > suppose it means destroying just your list... 
> 
> shrink_dcache_sb no longer walks the single unsed dentry list
> with the dcache lock held. With many millions of dentries on the
> unused list, this meant that all dentry operations come to a
> halt while one process executes shrink_dcache_sb().
> 
> With a per-sb lru, we no longer have to walk a global list to find
> all the dentries that belong to the superblock we are unmounting.
> Hence we only hold the dcache_lock for as long as it takes to pull
> a dentry of the list and free it.

list_splice is great for that. I can for sure see this benefit

> Yup, that is what the current code I've written will do. I just
> wanted someting that worked over all superblocks to begin with.
> It's not very smart, but improving it can be done incrementally.

I think that if you say A you should say B, I mean, if you make the list
per SB you probably just should do the step and make at least the
counter per SB as well. That will also save in cacheline bounces I
suppose...  but more importantly you keep the counters next to the list.
Which you'll also need to do any kind of scaling I suppose later on, so
might as well keep the stats already.


> > this makes me wonder btw if we can do a per superblock slab for these
> > dentries, that may decrease fragmentation of slabs in combination with
> > your patch....
> 
> That doesn't prevent slab fragmentation per filesystem. And most of
> the fragmentation problems I see are in the inode caches so at best
> this would be a bandaid rather than a real solution to the fundamental
> problems....

well what it would do is make sure an unmount causes a lot of free
pages, not just fragmented slabs.

Also it will give some more locality to group related dentries together,
so pinning wise it will help some.. but yeah at this point this is just
hand holding. I'm just sort of wondering how much stuff can be made per
SB.. if we go this way with the list, maybe just more can follow...


