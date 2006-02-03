Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945952AbWBCUxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945952AbWBCUxu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:53:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945953AbWBCUxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:53:50 -0500
Received: from ns1.siteground.net ([207.218.208.2]:35513 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1945952AbWBCUxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:53:49 -0500
Date: Fri, 3 Feb 2006 12:53:41 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Manfred Spraul <manfred@colorfullife.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       Alok Kataria <alok.kataria@calsoftinc.com>, sonny@burdell.org
Subject: [patch 0/3] NUMA slab locking fixes
Message-ID: <20060203205341.GC3653@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

There were some locking oddities in the NUMA slab allocator which broke cpu
hotplug.  Here is a patchset to correct locking and also fix the
breakage with cpu hotplug Sonny Rao noticed on POWER5.  We hit the bug 
on POWER, but not on other arches because other arches failed to update
the node cpumasks when a cpu went down.

Following patches are included in the series:

1. slab-colour-next fix: Moves the slab colouring index from kmem_cache_t
to kmem_list3. Per node cache colouring makes sense, and also, we can now
avoid taking the cachep->spinlock in the alloc patch (cache_grow).  Now, alloc
and free need not take cachep->spinlock and just need to take the respective
kmem_list3 locks.

2. slab-locking-irq-optimization: With patch 1, we don't need to disable 
on chip interrupts while taking the cachep->spinlock.  (We needed to disable
interrupts while taking cachep->spinlock earlier because alloc can happen
from interrupt context, and we had to take the cachep->lock to protect
color_next -- which is not the case now).

3. slab-hotplug-fix: Fix the cpu_down and cpu_up slab locking. When the last
cpu of a node goes down, cpu_down path used to free the shared array_cache,
alien array_cache and l3, with the kmem_list3 lock held, which resulted in
badness.  This patch fixes the locking not to do that.  Now we don't free
l3 on cpu_down (because there could be a request from other cpus to get
memory from the node going down, while the last cpu is going down).  This
fixes the problem reported by Sonny Rao.

2.6.16-rc1mmm4 with the above patches ran successfully overnight on a 4 cpu 2
node amd tyan box, with 4 dbench processes running all the time and cpus
offlined and onlined in an infinite loop.

Thanks,
Kiran
