Return-Path: <linux-kernel-owner+w=401wt.eu-S965005AbXALTql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965005AbXALTql (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 14:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbXALTqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 14:46:40 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:45459 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965005AbXALTqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 14:46:40 -0500
Date: Fri, 12 Jan 2007 11:46:22 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
Subject: Re: High lock spin time for zone->lru_lock under extreme conditions
In-Reply-To: <20070112160104.GA5766@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0701121137430.2306@schroedinger.engr.sgi.com>
References: <20070112160104.GA5766@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007, Ravikiran G Thirumalai wrote:

> The test was simple, we have 16 processes, each allocating 3.5G of memory
> and and touching each and every page and returning.  Each of the process is
> bound to a node (socket), with the local node being the preferred node for
> allocation (numactl --cpubind=$node ./numa-membomb --preferred=$node).  Each
> socket has 4G of physical memory and there are two cores on each socket. On
> start of the test, the machine becomes unresponsive after sometime and
> prints out softlockup and OOM messages.  We then found out the cause
> for softlockups being the excessive spin times on zone_lru lock.  The fact
> that spin_lock_irq disables interrupts while spinning made matters very bad.
> We instrumented the spin_lock_irq code and found that the spin time on the
> lru locks was in the order of a few seconds (tens of seconds at times) and
> the hold time was comparatively lesser.

So the issue is two processes contenting on the zone lock for one node? 
You are overallocating the 4G node with two processes attempting to 
allocate 7.5GB? So we go off node for 3.5G of the allocation?

Does the system scale the right way if you stay within the bounds of node 
memory? I.e. allocate 1.5GB from each process?

Have you tried increasing the size of the per cpu caches in 
/proc/sys/vm/percpu_pagelist_fraction?

> While the softlockups and the like went away by enabling interrupts during
> spinning, as mentioned in http://lkml.org/lkml/2007/1/3/29 ,
> Andi thought maybe this is exposing a problem with zone->lru_locks and 
> hence warrants a discussion on lkml, hence this post.  Are there any 
> plans/patches/ideas to address the spin time under such extreme conditions?

Could this be a hardware problem? Some issue with atomic ops in the 
Sun hardware?
