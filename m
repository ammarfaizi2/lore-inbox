Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285023AbSAUMJ4>; Mon, 21 Jan 2002 07:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbSAUMJq>; Mon, 21 Jan 2002 07:09:46 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:26844 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S285023AbSAUMJh>;
	Mon, 21 Jan 2002 07:09:37 -0500
Date: Mon, 21 Jan 2002 17:40:39 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: lse-tech <lse-tech@lists.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>,
        Paul McKenney <Paul.McKenney@us.ibm.com>, viro@math.psu.edu,
        anton@samba.org, andrea@suse.dec, tytso@mit.edu
Subject: [RFC] Peeling off dcache_lock
Message-ID: <20020121174039.D8289@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

We have been doing experiments with dcache_lock to provide some relief from it.
Though dcache_lock is not a very hot lock in comparision to BKL but on higher
end machines it becomes quite contentious. We would like to have feedbacks,
comments about the approach taken and guidance on how to improve this further.

As dcache_lock is acquired maximum number of times while doing lookup, the main
idea was to remove dcache_lock from d_lookup. With the help of Read Copy Update
it is possible to lookup the hash list of dentries without taking dcache_lock
but as d_lookup also updates the lru list, removing dcache_lock from d_lookup
was not straight forward. Various approaches were tried for that and the most
successful is doing lazy updation of lru list. 

Using this the dcache_lock contention was down from 16.5% to 0.95% on an 
8-way SMP box and lock utilization was down from 5.3% to 0.89%

The patch for lazy lru updation using RCU can be found here:

http://lse.sourceforge.net/locking/dcache/patches/2.4.17/dcache_rcu-lazy_lru-2.4.17-06.patch

The basic conecpt for this approach is to not update the lru list in d_lookup
facilitating lockless d_lookup. The lru list can now have dentries with non zero
reference count also. The lru list is updated while pruning dentry cache. The
dcache_lock is kept around so that there are no changes in the update side 
locking.

The implementation details for lazy lru list updation and other approaches
can be found here:

http://lse.sourceforge.net/locking/dcache/dcache_lock.html 

The above patch works fine with various file systems like ext2, JFS, ext3, /procand has been tested ok with ltp-20020108, dbench, httperf. And doesnot not have
any adverse effects on uni processor performance.


Regards,
Maneesh


-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/locking/rcupdate.html
