Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWHHKKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWHHKKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWHHKKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:10:43 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:41376 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S964786AbWHHKKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:10:42 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [RFC] NUMA futex hashing
Date: Tue, 8 Aug 2006 12:10:39 +0200
User-Agent: KMail/1.9.1
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       linux-kernel@vger.kernel.org
References: <20060808070708.GA3931@localhost.localdomain> <p73bqqvpn14.fsf@verdi.suse.de>
In-Reply-To: <p73bqqvpn14.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081210.40334.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 11:57, Andi Kleen wrote:
> Ravikiran G Thirumalai <kiran@scalex86.org> writes:
> > Current futex hash scheme is not the best for NUMA.   The futex hash
> > table is an array of struct futex_hash_bucket, which is just a spinlock
> > and a list_head -- this means multiple spinlocks on the same cacheline
> > and on NUMA machines, on the same internode cacheline.  If futexes of two
> > unrelated threads running on two different nodes happen to hash onto
> > adjacent hash buckets, or buckets on the same internode cacheline, then
> > we have the internode cacheline bouncing between nodes.
>
> When I did some testing with a (arguably far too lock intensive) benchmark
> on a bigger box I got most bouncing cycles not in the futex locks itself,
> but in the down_read on the mm semaphore.

This is true, even with a normal application (not a biased benchmark) and 
using oprofile. mmap_sem is the killer.

We may have special case for PRIVATE futexes (they dont need to be chained in 
a global table, but a process private table)

POSIX thread api already can let the application tell glibc/kernel a 
mutex/futex ahe a process scope.

For this private futexes, I think we would not need to down_read(mmap_sem) at 
all. (only a/some lock/s protecting the process private table)

Eric
 
