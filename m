Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262794AbSITQEV>; Fri, 20 Sep 2002 12:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262795AbSITQEV>; Fri, 20 Sep 2002 12:04:21 -0400
Received: from franka.aracnet.com ([216.99.193.44]:63915 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262794AbSITQEU>; Fri, 20 Sep 2002 12:04:20 -0400
Date: Fri, 20 Sep 2002 09:07:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Hansen <haveblue@us.ibm.com>, maneesh@in.ibm.com
cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu,
       Hanna Linder <hannal@us.ibm.com>
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <509891064.1032512823@[10.10.2.3]>
In-Reply-To: <3D8B31F8.40900@us.ibm.com>
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <3D8B31F8.40900@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> For a 32-way system fastwalk will perform badly from dcache_lock point of 
>> view, basically due to increased lock hold time. dcache_rcu-12 should reduce
>> dcache_lock contention and hold time.
> 
> Isn't increased hold time _good_ on NUMA-Q?  I thought that the 
> really costy operation was bouncing the lock around the interconnect, 
> not holding it. 

Depends what you get it return. The object of fastwalk was to stop the
cacheline bouncing on all the individual dentry counters, at the cost
of increased dcache_lock hold times. It's a tradeoff ... and in this
instance it wins. In general, long lock hold times are bad.

> Has fastwalk ever been tested on NUMA-Q?

Yes, in 2.4. Gave good results, I forget exactly what ... something
like 5-10% off kernel compile times.

> Remember when John Stultz tried MCS (fair) locks on NUMA-Q?  They
> sucked because low hold times, which result from fairness, aren't 
> efficient.  It is actually faster to somewhat starve remote CPUs.

Nothing to do with low hold times - it's to do with bouncing the 
lock between nodes.

> In any case, we all know often acquired global locks are a bad idea 
> on a 32-way, and should be avoided like the plague.  I just wish we 
> had a dcache solution that didn't even need locks as much... :)

Well, avoiding data corruption is a preferable goal too. The point of
RCU is not to have to take a lock for the common read case. I'd expect
good results from it on the NUMA machines - never been benchmarked, as
far as I recall.

M.

