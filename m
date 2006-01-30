Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWA3RBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWA3RBJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWA3RBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:01:09 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:65494 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964783AbWA3RBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:01:08 -0500
Date: Mon, 30 Jan 2006 22:30:28 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: paulmck@us.ibm.com, dada1@cosmosbay.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       nickpiggin@yahoo.com.au, hch@infradead.org
Subject: Re: [patch 2/2] fix file counting
Message-ID: <20060130170028.GA6264@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060126184010.GD4166@in.ibm.com> <20060126184127.GE4166@in.ibm.com> <20060126184233.GF4166@in.ibm.com> <43D92DD6.6090607@cosmosbay.com> <20060127145412.7d23e004.akpm@osdl.org> <20060127231420.GA10075@us.ibm.com> <20060127152857.32066a69.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127152857.32066a69.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 03:28:57PM -0800, Andrew Morton wrote:
> "Paul E. McKenney" <paulmck@us.ibm.com> wrote:
> >
> > > > I am using a patch that seems sligthly better : It removes the filp_count_lock 
> > > > as yours but introduces a percpu variable, and a lazy nr_files . (Its value 
> > > > can be off with a delta of +/- 16*num_possible_cpus()
> > > 
> > > Yes, I think that is better.
> > 
> > I agree that Eric's approach likely improves performance on large systems
> > due to decreased cache thrashing.  However, the real problem is getting
> > both good throughput and good latency in RCU callback processing, given
> > Lee Revell's latency testing results.  Once we get that in hand, then
> > we should consider Eric's approach.
> 
> Dipankar's patch risks worsening large-SMP scalability, doesn't it? 
> Putting an atomic op into the file_free path?

Here are some numbers from a 32-way (HT) P4 xeon box with kernbench -

2.6.16-rc1 vanilla
------------------
kernbench 32 5 -m 2
  Completed successfully
    Elapsed: 109.346s User: 1426.506s System: 178.71s CPU: 1467.6%
    1426.63user 177.89system 1:49.07elapsed 1471%CPU (0avgtext+0avgdata
0maxresident)k
    1425.48user 179.08system 1:49.09elapsed 1470%CPU (0avgtext+0avgdata
0maxresident)k
    1427.02user 179.17system 1:49.82elapsed 1462%CPU (0avgtext+0avgdata
0maxresident)k
    1427.13user 179.47system 1:50.00elapsed 1460%CPU (0avgtext+0avgdata
0maxresident)k
    1426.27user 177.94system 1:48.75elapsed 1475%CPU (0avgtext+0avgdata
0maxresident)k


2.6.16-rc1+fix-file-counting.patch (with atomic_t nr_files)
-----------------------------------------------------------
kernbench 32 5 -m 2
  Completed successfully
    Elapsed: 109.338s User: 1427.554s System: 179.764s CPU: 1469.4%
    1425.98user 179.32system 1:49.18elapsed 1470%CPU (0avgtext+0avgdata
0maxresident)k
    1427.36user 179.60system 1:49.34elapsed 1469%CPU (0avgtext+0avgdata
0maxresident)k
    1428.19user 179.92system 1:49.97elapsed 1462%CPU (0avgtext+0avgdata
0maxresident)k
    1426.53user 180.45system 1:49.02elapsed 1473%CPU (0avgtext+0avgdata
0maxresident)k
    1429.71user 179.53system 1:49.18elapsed 1473%CPU (0avgtext+0avgdata
0maxresident)k

2.6.16-rc1+nr-files.patch (with percpu counters [Eric's patch])
------------------------------------------------
kernbench 32 5 -m 2
  Completed successfully
    Elapsed: 109.38s User: 1427.684s System: 179.372s CPU: 1468.8%
    1429.92user 179.37system 1:48.64elapsed 1481%CPU (0avgtext+0avgdata
0maxresident)k
    1427.10user 178.60system 1:48.83elapsed 1475%CPU (0avgtext+0avgdata
0maxresident)k
    1425.99user 177.75system 1:49.81elapsed 1460%CPU (0avgtext+0avgdata
0maxresident)k
    1426.65user 181.33system 1:49.95elapsed 1462%CPU (0avgtext+0avgdata
0maxresident)k
    1428.76user 179.81system 1:49.67elapsed 1466%CPU (0avgtext+0avgdata
0maxresident)k

The difference between atomic_t nr_files and percpu counters are
statistically insignficant. That said, there could be other workloads
where we may get hit badly by the global atomic_t or big SGI boxen
can be a problem.

I will poke around with this a little bit more to see what else
I can analyze.

Thanks
Dipankar
