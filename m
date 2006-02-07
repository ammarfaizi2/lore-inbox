Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWBGFzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWBGFzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 00:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWBGFzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 00:55:18 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:14247 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750930AbWBGFzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 00:55:16 -0500
Date: Tue, 7 Feb 2006 11:29:55 +0530
From: Bharata B Rao <bharata@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Lameter <clameter@engr.sgi.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Message-ID: <20060207055955.GB18917@in.ibm.com>
Reply-To: bharata@in.ibm.com
References: <20060205163618.GB21972@in.ibm.com> <200602061931.13953.ak@suse.de> <Pine.LNX.4.62.0602061043440.16829@schroedinger.engr.sgi.com> <200602061955.19702.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602061955.19702.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2006 at 07:55:18PM +0100, Andi Kleen wrote:
> On Monday 06 February 2006 19:45, Christoph Lameter wrote:
> > On Mon, 6 Feb 2006, Andi Kleen wrote:
> > 
> > > > If node 0 is exhausted then you have an OOM situation.
> > > 
> > > No - it could just need to free some cleanable pages first. That's
> > > a long way before going OOM.
> > 
> > Then node 0 still has memory available. So you suspect zone_reclaim?
> 
> Either zone reclaim or the first entry in the zonelist is ok, but it's 
> not correctly terminated or something like that so it causes 
> problems when the kernel looks for the second (just speculating here,
> i don't know if that is the problem) 
>    

I can still crash my x86_64 box with Christoph's program.

The meminfo in my case looks like this just before I execute the
program.

llm07:~ # cat /sys/devices/system/node/node0/meminfo

Node 0 MemTotal:      3095532 kB
Node 0 MemFree:       2960972 kB
Node 0 MemUsed:        134560 kB
Node 0 Active:          19752 kB
Node 0 Inactive:        14908 kB
Node 0 HighTotal:           0 kB
Node 0 HighFree:            0 kB
Node 0 LowTotal:      3095532 kB
Node 0 LowFree:       2960972 kB
Node 0 Dirty:               0 kB
Node 0 Writeback:         576 kB
Node 0 Mapped:              0 kB
Node 0 Slab:            24200 kB
Node 0 HugePages_Total:     0
Node 0 HugePages_Free:      0
llm07:~ # cat /sys/devices/system/node/node1/meminfo

Node 1 MemTotal:      2002368 kB
Node 1 MemFree:       1964464 kB
Node 1 MemUsed:         37904 kB
Node 1 Active:          10608 kB
Node 1 Inactive:         3056 kB
Node 1 HighTotal:           0 kB
Node 1 HighFree:            0 kB
Node 1 LowTotal:      2002368 kB
Node 1 LowFree:       1964464 kB
Node 1 Dirty:            1164 kB
Node 1 Writeback:           0 kB
Node 1 Mapped:          43064 kB
Node 1 Slab:             9648 kB
Node 1 HugePages_Total:     0
Node 1 HugePages_Free:      0

I was trying to bind the memory to node 0, which still has enough
free memory.

Not sure if this helps, but I have some more debug data.
While the kernel(2.6.16-rc1) oopes at page_alloc.c, line no: 556
(list_del(&page->lru), some of the variables in __rmqueue look like this at the time of crash:

page = 0xffffffffffffffd8
&page->lru = 0000000000000000
zone = 0xffff81000000e700
zone->name Normal
current_order 0
area->nr_free 0

Regards,
Bharata.
