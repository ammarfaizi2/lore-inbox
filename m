Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290599AbSAYJ1w>; Fri, 25 Jan 2002 04:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290601AbSAYJ1l>; Fri, 25 Jan 2002 04:27:41 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:52441 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290599AbSAYJ12>; Fri, 25 Jan 2002 04:27:28 -0500
Date: Fri, 25 Jan 2002 15:00:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: lse-tech <lse-tech@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <Paul.McKenney@us.ibm.com>, viro@math.psu.edu,
        anton@samba.org, andrea@suse.de, tytso@mit.edu, riel@conectiva.com.br
Subject: Re: [RFC] Peeling off dcache_lock
Message-ID: <20020125150000.B1782@in.ibm.com>
Reply-To: dipankar@in.ibm.com
In-Reply-To: <20020121174039.D8289@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020121174039.D8289@in.ibm.com>; from maneesh@in.ibm.com on Mon, Jan 21, 2002 at 05:40:39PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since there has been speculation about the throughput #s for lower end,
I have put up the comparison graph in the same page 
(http://lse.sf.net/locking/dcache/dcache_lock.html).

As http://lse.sourceforge.net/locking/dcache/results/dbench/base+dc-tpt.png
would show, there is *no* performance degradation at the lower end or
UP. The absolute numbers are in
http://lse.sourceforge.net/locking/dcache/results/dbench/.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.


On Mon, Jan 21, 2002 at 05:40:39PM +0530, Maneesh Soni wrote:
> Hi All,
> 
> We have been doing experiments with dcache_lock to provide some relief from it.
> Though dcache_lock is not a very hot lock in comparision to BKL but on higher
> end machines it becomes quite contentious. We would like to have feedbacks,
> comments about the approach taken and guidance on how to improve this further.
> 
> As dcache_lock is acquired maximum number of times while doing lookup, the main
> idea was to remove dcache_lock from d_lookup. With the help of Read Copy Update
> it is possible to lookup the hash list of dentries without taking dcache_lock
> but as d_lookup also updates the lru list, removing dcache_lock from d_lookup
> was not straight forward. Various approaches were tried for that and the most
> successful is doing lazy updation of lru list. 
> 
> Using this the dcache_lock contention was down from 16.5% to 0.95% on an 
> 8-way SMP box and lock utilization was down from 5.3% to 0.89%
> 
> The patch for lazy lru updation using RCU can be found here:
> 
> http://lse.sourceforge.net/locking/dcache/patches/2.4.17/dcache_rcu-lazy_lru-2.4.17-06.patch
> 
> The basic conecpt for this approach is to not update the lru list in d_lookup
> facilitating lockless d_lookup. The lru list can now have dentries with non zero
> reference count also. The lru list is updated while pruning dentry cache. The
> dcache_lock is kept around so that there are no changes in the update side 
> locking.
> 
> The implementation details for lazy lru list updation and other approaches
> can be found here:
> 
> http://lse.sourceforge.net/locking/dcache/dcache_lock.html 
> 
> The above patch works fine with various file systems like ext2, JFS, ext3, /procand has been tested ok with ltp-20020108, dbench, httperf. And doesnot not have
> any adverse effects on uni processor performance.
> 
> 
> Regards,
> Maneesh
> 
> 
> -- 
> Maneesh Soni
> IBM Linux Technology Center, 
> IBM India Software Lab, Bangalore.
> Phone: +91-80-5044999 email: maneesh@in.ibm.com
> http://lse.sourceforge.net/locking/rcupdate.html

