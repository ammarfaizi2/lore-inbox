Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268448AbUILFOD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268448AbUILFOD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268450AbUILFOC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:14:02 -0400
Received: from ozlabs.org ([203.10.76.45]:21384 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268448AbUILFNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:13:50 -0400
Date: Sun, 12 Sep 2004 15:10:54 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@fsmlabs.com>, torvalds@osdl.org, paulus@samba.org,
       linux-kernel@vger.kernel.org, jun.nakajima@intel.com, ak@suse.de,
       mingo@elte.hu
Subject: Re: [PATCH] Yielding processor resources during lock contention
Message-ID: <20040912051054.GI32755@krispykreme>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org> <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org> <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com> <20040911220003.0e9061ad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040911220003.0e9061ad.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Now, maybe Paul has tied himself into sufficiently tangly locking knots
> that in some circumstances he needs to spin on the lock and cannot schedule
> away.  But he can still use a semaphore and spin on down_trylock.
> 
> Confused by all of this.

On a shared processor machine you might have a 4 way box with a number
of 4 way partitions on it. Having them sized as 4 way partitions allows
them to utilise the entire machine when the others are idle.

Now when all partitions start getting busy you have the problem where
one partition may be spinning waiting for a lock but the cpu with the
lock is not currently being scheduled by the hypervisor. Some other
partition is running over there.

At the moment we spin burning cycles until the other cpu finally gets
scheduled by the hypervisor. A slightly better option is for the busy
spinning cpu to call the hypervisor telling it youve got no useful work
to do. 

The best option is to call the hypervisor and tell it that you are are
busy spinning waiting for that other cpu to be scheduled. The hypervisor
then takes whatever action it sees fit (transferring the current cpus
timeslice to the other cpu etc).

Anton
