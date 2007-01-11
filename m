Return-Path: <linux-kernel-owner+w=401wt.eu-S1030201AbXAKCaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030201AbXAKCaW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 21:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbXAKCaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 21:30:22 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:49381 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965285AbXAKCaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 21:30:21 -0500
Date: Thu, 11 Jan 2007 08:00:05 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>,
       Benjamin Gilbert <bgilbert@cs.cmu.edu>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Gautham shenoy <ego@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [patch -mm] slab: use CPU_LOCK_[ACQUIRE|RELEASE]
Message-ID: <20070111023005.GA5357@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20070108120719.16d4674e.bgilbert@cs.cmu.edu> <20070109121738.GC9563@osiris.boeblingen.de.ibm.com> <20070109122740.GC22080@in.ibm.com> <20070109150351.GD9563@osiris.boeblingen.de.ibm.com> <20070109150615.GF9563@osiris.boeblingen.de.ibm.com> <Pine.LNX.4.64.0701101012460.21379@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701101012460.21379@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2007 at 10:20:28AM -0800, Christoph Lameter wrote:
> I have got a bad feeling about upcoming deadlock problems when looking at
> the mutex_lock / unlock code in cpuup_callback in slab.c. Branches
> that just obtain a lock or release a lock? I hope there is some
> control of  what happens between lock acquisition and release?

A cpu hotplug should happen between LOCK_ACQUIRE/RELEASE

> You are aware that this lock is taken for cache shrinking/destroy, tuning
> of cpu cache sizes, proc output and cache creation? Any of those run on
> the same processor should cause a deadlock.

Why? mutex_lock() taken in LOCK_ACQ will just block those functions
(cache create etc) from proceeding simultaneously as a hotplug event.
This per-subsystem mutex_lock() is supposed to be a replacement for the global
lock_cpu_hotplug() lock .. 

But the whole thing is changing again ..we will likely move towards a
process freezer based cpu hotplug locking ..all the lock_cpu_hotplugs()
and the existing LOCK_ACQ/RELS can go away when we do that ..

-- 
Regards,
vatsa
