Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263084AbSITRbQ>; Fri, 20 Sep 2002 13:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263141AbSITRbQ>; Fri, 20 Sep 2002 13:31:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41682 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263084AbSITRbP>;
	Fri, 20 Sep 2002 13:31:15 -0400
Date: Fri, 20 Sep 2002 23:10:20 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: maneesh@in.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       viro@math.psu.edu, Hanna Linder <hannal@us.ibm.com>
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020920231020.A4357@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <3D8B31F8.40900@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8B31F8.40900@us.ibm.com>; from haveblue@us.ibm.com on Fri, Sep 20, 2002 at 02:37:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 02:37:41PM +0000, Dave Hansen wrote:
> Isn't increased hold time _good_ on NUMA-Q?  I thought that the really 
> costy operation was bouncing the lock around the interconnect, not 

Increased hold time isn't necessarily good. If you acquire the lock
often, your lock wait time will increase correspondingly. The ultimate
goal should be to decrease the total number of acquisitions.

> holding it.  Has fastwalk ever been tested on NUMA-Q?

Fastwalk is in 2.5. You can see wli's profile numbers for dbench 512
earlier in this thread.

> 
> Remember when John Stultz tried MCS (fair) locks on NUMA-Q?  They 
> sucked because low hold times, which result from fairness, aren't 
> efficient.  It is actually faster to somewhat starve remote CPUs.

One workaround is to keep scheduling the lock within the CPUs of
a node as much as possible and release it to a different node
only if there isn't any CPU available in the current node. Anyway
these are not real solutions, just band-aids.

> 
> In any case, we all know often acquired global locks are a bad idea on 
> a 32-way, and should be avoided like the plague.  I just wish we had a 
> dcache solution that didn't even need locks as much... :)

You have one - dcache_rcu. It reduces the dcache_lock acquisition
by about 65% over fastwalk.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
