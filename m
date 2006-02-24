Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751747AbWBXB1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbWBXB1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWBXB1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:27:44 -0500
Received: from ns1.siteground.net ([207.218.208.2]:16000 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751747AbWBXB1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:27:43 -0500
Date: Thu, 23 Feb 2006 17:28:15 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, alokk@calsoftinc.com,
       manfred@colorfullife.com, penberg@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Slab: Node rotor for freeing alien caches and remote per cpu pages.
Message-ID: <20060224012815.GB5589@localhost.localdomain>
References: <Pine.LNX.4.64.0602231036480.13184@schroedinger.engr.sgi.com> <20060223113331.6b345e1b.akpm@osdl.org> <Pine.LNX.4.64.0602231140140.13899@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602231140140.13899@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 11:41:51AM -0800, Christoph Lameter wrote:
> On Thu, 23 Feb 2006, Andrew Morton wrote:
> 
> > Christoph Lameter <clameter@engr.sgi.com> wrote:
> > >
> > > The cache reaper currently tries to free all alien caches and all remote
> > >  per cpu pages in each pass of cache_reap.
> > 
> > umm, why?  We have a reap timer per cpu - why doesn't each CPU drain its
> > own stuff and its own node's stuff and leave the other nodes&cpus alone?
> 
> Each cpu has per cpu pages on remote nodes and also has alien caches 
> on remote nodes. These are only accessible from the processor using them.

Actually, all cpus on the node share the alien_cache, and the alien_cache is
one per remote node (for the cachep).  So currently each cpu on the node 
drains the same alien_cache onto all the remote nodes in the per-cpu eventd.  

What is probably very expensive here at drain_alien_cache is free_block 
getting called from the foreign node, and freeing remote pages.
We have a patch-set here to drop-in the alien objects from the current node to 
the respective alien node's drop box, and that drop box will be cleared
locally (so that freeing happens locally).  This would happen off cache_reap. 
(I was holding from posting it because akpm complained about slab.c 
being full on -mm.  Maybe I should post it now...).   

Round robin might still be useful for drain_alien_cache with that approach, 
but maybe init_reap_node should initialize the per-cpu reap_node with a skew
for cpus on the same node (so all cpus of a node do not drain to the same 
foreign node when the eventd runs?)

Round robin for drain_remote_pages is going to be useful for us too I think.

Thanks,
Kiran
