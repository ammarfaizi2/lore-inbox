Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVIMPva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVIMPva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbVIMPva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:51:30 -0400
Received: from serv01.siteground.net ([70.85.91.68]:60586 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964812AbVIMPv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:51:29 -0400
Date: Tue, 13 Sep 2005 08:51:12 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, bharata@in.ibm.com,
       shai@scalex86.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch 0/11] mm: Reimplementation of dynamic per-cpu allocator
Message-ID: <20050913155112.GB3570@localhost.localdomain>
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

I have been maintaining a set of patches based on the reimplemented dynamic
per-cpu allocator.  I would like to have them included in -mm for testing
and maybe merged when the mainline merge window opens  :)...

The reimplementation of the dynamic per-cpu allocator has been published
earlier and discussed, But the re-implementation with the applications and
supporting numbers weren't published earlier.  Here is an attempt towards
the same.

This patchset contains 
a) Reimplementation of alloc_percpu. 
b) Rusty's implementation of distributed reference counters (bigrefs)
c) Code to change struct netdevice.refcnt to bigrefs -- this patch improves
tbench performance by 6% on a 8 way 3.00 GHZ x86 Intel xeon (x445).
d) Code to change struct dst_entry.__refcnt per-cpu.  This patch was
originally submitted sometime back by Christoph.  The reworked patch uses
alloc_percpu, and struct dst_entry does not bloat up now.  This patch along with
the netdevice ref-counter patch above gives a whopping 55 % improvement on
tbench on a 8way x86 xeon (x445).  The same patchset resulted in 30% better
tbench throughput on a x460 (8 way 3.3 Ghz x86_64 xeon).

All tbench numbers were on loopback with 8 clients.

The patches consist of

1. vmalloc_fixup 
(Fix up __get_vm_area to take gfp flags as extra arg -- preparatory for 3.)

2. alloc_percpu 
(Main allocator)

3. alloc_percpu_atomic 
(Add GFP_FLAGS args to alloc_percpu -- for dst_entry.refcount)

4.change_alloc_percpu_users 
(Change  alloc_percpu users to use modified interface (with gfp_flags))

5. add_getcpuptr 
(This is needed for bigrefs)

6. bigrefs 
(Fixed up bigref from rusty)

7. netdev_refcnt_bigref.patch 
(Bigref based netdev refcount)

8. dst_abstraction 
9. dst_alloc_percpu 
(dst_entry.refcount patches)

10. allow_early_mapvmarea 
11. hotplug_alloc_percpu_blocks 
(If alloc_percpu needs to be used real early then these patches will be
needed.  This patch allows us to use bigrefs/alloc_percpu for refcounters 
like struct vfsmount.mnt_count)
