Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWHHJhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWHHJhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWHHJhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:37:25 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:32944 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S932167AbWHHJhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:37:24 -0400
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>
Subject: Re: [RFC] NUMA futex hashing
References: <20060808070708.GA3931@localhost.localdomain>
From: Jes Sorensen <jes@sgi.com>
Date: 08 Aug 2006 05:37:23 -0400
In-Reply-To: <20060808070708.GA3931@localhost.localdomain>
Message-ID: <yq0d5bbva98.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ravikiran" == Ravikiran G Thirumalai <kiran@scalex86.org> writes:

Ravikiran> Current futex hash scheme is not the best for NUMA.  The
Ravikiran> futex hash table is an array of struct futex_hash_bucket,
Ravikiran> which is just a spinlock and a list_head -- this means
Ravikiran> multiple spinlocks on the same cacheline and on NUMA
Ravikiran> machines, on the same internode cacheline.  If futexes of
Ravikiran> two unrelated threads running on two different nodes happen
Ravikiran> to hash onto adjacent hash buckets, or buckets on the same
Ravikiran> internode cacheline, then we have the internode cacheline
Ravikiran> bouncing between nodes.

Ravikiran,

Using that argument, all you need to do is to add the alignment
____cacheline_aligned_in_smp to the definition of
struct futex_hash_bucket and the problem is solved, given that the
internode cacheline in a NUMA system is defined to be the same as the
SMP cacheline size.

Ravikiran> Here is a simple scheme which maintains per-node hash
Ravikiran> tables for futexes.

Ravikiran> In this scheme, a private futex is assigned to the node id
Ravikiran> of the futex's KVA.  The reasoning is, the futex KVA is
Ravikiran> allocated from the node as indicated by memory policy set
Ravikiran> by the process, and that should be a good 'home node' for
Ravikiran> that futex.  Of course this helps workloads where all the
Ravikiran> threads of a process are bound to the same node, but it
Ravikiran> seems reasonable to run all threads of a process on the
Ravikiran> same node.

You can't make that assumption at all. In many NUMA workloads it is
not common to have all threads of a process run on the same node. You
often see a case where one thread spawns a number of threads that are
then grouped onto the various nodes.

If we want to make the futexes really NUMA aware, having them
explicitly allocated on a given node would be more useful or
alternatively have them allocated on a first touch basis.

But to be honest, I doubt it matters too much since the futex
cacheline is most likely to end up in cache on the node where it's
being used and as long as the other nodes don't try and touch the same
futex this becomes a non-issue with the proper alignment.

I don't think your patch is harmful, but it looks awfully complex for
something that could be solved just as well by a simple alignment
statement.

Cheers,
Jes
