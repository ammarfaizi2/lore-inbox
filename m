Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317987AbSGLHBU>; Fri, 12 Jul 2002 03:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317991AbSGLHBT>; Fri, 12 Jul 2002 03:01:19 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:24778 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317987AbSGLHBQ>; Fri, 12 Jul 2002 03:01:16 -0400
Date: Fri, 12 Jul 2002 12:37:51 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, wilsont@us.ibm.com
Subject: specweb99: dcache scalability results
Message-ID: <20020712123751.B19931@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At OLS, Hanna presented some of our work related to directory entry
cache. I am presenting another set of interesting results
that are a part of this ongoing work.

Mainly, we have been working on two tracks - reduce dcache_lock
acquisitions by holding it while walking a cached path as suggested
by Al Viro (fastwalk) and do a completely lockfree lookup/walk using RCU and
lazy updation of the LRU list (dcache_rcu). Both showed promise and
Troy Wilson from LTC perfromance team did a comparative study of these 
two dcache patches using specweb99. His measurement identifies
what is good for dentry cache to use. Here is a summary of his reasults. 

The measurements were done on a 8-CPU PIII Xeon server with more RAM than 
you and I can dream of getting in your desktop ;-)

More details of the directory entry cache work can be found in
http://lse.sourceforge.net/locking/dcache/dcache.html.
The dcache patches are available from Read-Copy Update
package in  http://www.sourceforge.net/projects/lse.

Throughput comparison:
---------------------

kernel 			   throughput 				% improvement
			   (simultaneous connections) 	
-----			   --------------------------          	-------------
2.4.17+lse02E 		   2258 				-
2.4.17+lse02E+fastwalk     2280 				1%
2.4.17+lse02E+dcache_rcu   2530 				12%


Lockmeter comparison: (with apology for the > 80 col text)
---------------------

2.4.17+lse02E:

SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
 15.7% 20.8%  2.1us(6668us)   23us(  14ms)( 4.4%)   5215460 79.2% 20.8% 0%  dcache_lock

2.4.17+lse02E+fastwalk:

SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
 17.2% 17.7%  7.0us(  13ms)   53us(  30ms)( 2.9%)   1608566 82.3% 17.7% 0%  dcache_lock

2.4.17+lse02E+dcache_rcu:

SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME
  1.9%  2.3%  2.0us(3343us)   71us(9406us)(0.20%)    657152 97.7%  2.3% 0%  dcache_lock

Conclusions:
------------

Fastwalk clearly helps by reducing the number of dcache_lock 
acquisitions by 69.9%. However, holding the lock over entire walk of 
the path is clearly detrimental to performance as seen by the 3-fold 
increase in average hold time and average wait time. dcache_rcu has 
the biggest positive impact on performance for webserver type of 
workload. Its gains come from two improvements - 87.3% reduction in 
lock acquisitions at the same time keeping the lock hold time constant. 

Acknowledgements:
-----------------

SPEC(tm) and the benchmark name SPECweb(tm) are registered trademarks
of the Standard Performance Evaluation Corporation. The benchmarking
were done for research purpose only and were non-compliant with the
following devaitions from the rules -

   1. It was run on hardware that does not meet the SPEC
      availability-to-the-public criteria. The machine was an
      engineering sample.
   2. access_log wasn't kept for full accounting. It was being
      written, but deleted every 200 seconds.

For the latest SPECweb99 benchmark results visit http://www.spec.org


Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
