Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVFOMVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVFOMVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 08:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbVFOMVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 08:21:20 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:59895 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261424AbVFOMVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 08:21:12 -0400
Date: Wed, 15 Jun 2005 17:48:42 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] files: scalable fd management (V4)
Message-ID: <20050615121841.GB4845@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050614142612.GA4557@in.ibm.com> <20050614130338.70e99074.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050614130338.70e99074.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Tue, Jun 14, 2005 at 01:03:38PM -0700, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > tiobench on a 4-way ppc64 system :
> >                                          (lockfree)
> >  Test            2.6.10-vanilla  Stdev   2.6.10-fd       Stdev
> >  -------------------------------------------------------------
> >  Seqread         1428            32.47   1475.0          29.11
> 
> We don't seem to have gained anything?

I repeated the measurements on ramfs (as opposed to ext2 on ramdisk in
the earlier measurement) and I got more consistent results from tiobench :

4(8) way xeon P4 
-----------------
                                        (lock-free)
Test            2.6.12-rc5      Stdev   2.6.12-rc5-fd   Stdev
-------------------------------------------------------------
Seqread         1282            18.59   1343.6          26.37
Randread        1517            7       2415            34.27
Seqwrite        702.2           5.27    709.46           5.9 
Randwrite       846.86          15.15   919.68          21.4 


4-way ppc64
------------
                                        (lock-free)
Test            2.6.12-rc5      Stdev   2.6.12-rc5-fd   Stdev
-------------------------------------------------------------
Seqread         1549            91.16   1569.6          47.2 
Randread        1473.6          25.11   1585.4          69.99
Seqwrite        1096.8          20.03   1136            29.61
Randwrite       1189.6           4.04   1275.2          32.96

Also running Tridge's thread_perf test on ppc64 :

2.6.12-rc5-vanilla
--------------------
Running test 'readwrite' with 4 tasks
Threads     0.20 +/- 0.02 seconds
Processes   0.16 +/- 0.01 seconds

2.6.12-rc5-fd
--------------------
Running test 'readwrite' with 4 tasks
Threads     0.18 +/- 0.04 seconds
Processes   0.16 +/- 0.01 seconds

The benefits are huge (upto ~60%) in some cases on x86 primarily
due to the atomic operations during acquisition of ->file_lock
and cache line bouncing in fast path. ppc64 benefits are modest
due to LL/SC based locking, but still statistically significant.

Thanks
Dipankar
