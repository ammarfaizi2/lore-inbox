Return-Path: <linux-kernel-owner+w=401wt.eu-S1161080AbXALVkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbXALVkn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbXALVkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:40:43 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:35758 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161080AbXALVkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:40:42 -0500
Date: Fri, 12 Jan 2007 13:40:21 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>, a.p.zijlstra@chello.nl
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
Message-ID: <20070112214021.GA4300@localhost.localdomain>
References: <20070112160104.GA5766@localhost.localdomain> <Pine.LNX.4.64.0701121137430.2306@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701121137430.2306@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 11:46:22AM -0800, Christoph Lameter wrote:
> On Fri, 12 Jan 2007, Ravikiran G Thirumalai wrote:
> 
> > The test was simple, we have 16 processes, each allocating 3.5G of memory
> > and and touching each and every page and returning.  Each of the process is
> > bound to a node (socket), with the local node being the preferred node for
> > allocation (numactl --cpubind=$node ./numa-membomb --preferred=$node).  Each
> > socket has 4G of physical memory and there are two cores on each socket. On
> > start of the test, the machine becomes unresponsive after sometime and
> > prints out softlockup and OOM messages.  We then found out the cause
> > for softlockups being the excessive spin times on zone_lru lock.  The fact
> > that spin_lock_irq disables interrupts while spinning made matters very bad.
> > We instrumented the spin_lock_irq code and found that the spin time on the
> > lru locks was in the order of a few seconds (tens of seconds at times) and
> > the hold time was comparatively lesser.
> 
> So the issue is two processes contenting on the zone lock for one node? 
> You are overallocating the 4G node with two processes attempting to 
> allocate 7.5GB? So we go off node for 3.5G of the allocation?

Yes.

> 
> Does the system scale the right way if you stay within the bounds of node 
> memory? I.e. allocate 1.5GB from each process?

Yes. We see problems only when we oversubscribe memory.

> 
> Have you tried increasing the size of the per cpu caches in 
> /proc/sys/vm/percpu_pagelist_fraction?

No not yet. I can give it a try.

> 
> > While the softlockups and the like went away by enabling interrupts during
> > spinning, as mentioned in http://lkml.org/lkml/2007/1/3/29 ,
> > Andi thought maybe this is exposing a problem with zone->lru_locks and 
> > hence warrants a discussion on lkml, hence this post.  Are there any 
> > plans/patches/ideas to address the spin time under such extreme conditions?
> 
> Could this be a hardware problem? Some issue with atomic ops in the 
> Sun hardware?

I think that is unlikely -- because when we donot oversubscribe
memory, the tests complete quickly without softlockups ane the like.  Peter 
has also noticed this (presumeably on different hardware).  I would think
this could also be locking unfairness (cpus of the same node getting the 
lock and starving out other nodes) case under extreme contention.
