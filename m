Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbWFVVbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbWFVVbY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932656AbWFVVbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:31:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6585 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932658AbWFVVbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:31:23 -0400
Date: Thu, 22 Jun 2006 14:31:02 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Jens Axboe <axboe@suse.de>,
       Dave Miller <davem@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       Ingo Molnar <mingo@elte.hu>
Message-Id: <20060622213102.32391.19996.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 0/4] struct file RCU optimizations V2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize RCU handling for struct file by relying on slab RCU handling

(Thanks for all the feedback on the RFC for this....)

Currently we schedule RCU frees for each file we free separately. That has
several drawbacks against the earlier file handling (in 2.6.5 f.e.), which
did not require RCU callbacks:

1. Excessive number of RCU callbacks can be generated causing long RCU
   queues that in turn cause long latencies.

2. The cache hot object is not preserved between free and realloc. A close
   followed by another open is very fast with the RCUless approach because
   the last freed object is returned by the slab allocator that is
   still cache hot. RCU free means that the object is not immediately
   available again. The new object is cache cold and therefore open/close
   performance tests show a significant degradation with the RCU
   implementation.

One solution to this problem is to move the RCU freeing into the Slab
allocator by specifying SLAB_DESTROY_BY_RCU as an option at slab creation
time. The slab allocator will do RCU frees only when it is necessary
to dispose of slabs of objects (rare). So with that approach we can cut
out the RCU overhead significantly.

However, the slab allocator may return the object for another use even
before the RCU period has expired under SLAB_DESTROY_BY_RCU. This means
there is the (unlikely) possibility that the object is going to be
switched under us in sections protected by rcu_read_lock() and
rcu_read_unlock(). So we need to verify that we have acquired the correct
object after establishing a stable object reference (incrementing the
refcounter does that).

I have tested this on IA64 NUMA with aim7.

Patch was first discussed at:
http://marc.theaimsgroup.com/?t=115048747200002&r=1&w=2

V1->V2:
- Consolidate common code after finding fget in fget_light.
- Rename fu_list to its prior name f_list.
- Do not clear variables in get_empty_filp() that are cleared
  later by other subsystems.
- Move the eventpoll initialization into the constructor.
- Split up the patch into patchset of 4 patches.

The patchset consists of 4 patches against 2.6.17 that are following
this message.


