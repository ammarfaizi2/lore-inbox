Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274838AbRIZFcI>; Wed, 26 Sep 2001 01:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274842AbRIZFb7>; Wed, 26 Sep 2001 01:31:59 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:35592 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S274838AbRIZFbp>; Wed, 26 Sep 2001 01:31:45 -0400
Message-ID: <3BB16834.4393EEA3@zip.com.au>
Date: Tue, 25 Sep 2001 22:31:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: davem@redhat.com, marcelo@connectiva.com.br, riel@connectiva.com.br,
        Andrea Arcangeli <andrea@suse.de>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, hawkes@engr.sgi.com
Subject: Re: Locking comment on shrink_caches()
In-Reply-To: <20010926103424.A8893@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> 
> In article <20010925.132816.52117370.davem@redhat.com> David S. Miller wrote:
> >    From: Rik van Riel <riel@conectiva.com.br>
> >    Date: Tue, 25 Sep 2001 17:24:21 -0300 (BRST)
> >
> >    Or were you measuring loads which are mostly read-only ?
> 
> > When Kanoj Sarcar was back at SGI testing 32 processor Origin
> > MIPS systems, pagecache_lock was at the top.
> 
> John Hawkes from SGI had published some AIM7 numbers that showed
> pagecache_lock to be a bottleneck above 4 processors. At 32 processors,
> half the CPU cycles were spent on waiting for pagecache_lock. The
> thread is at -
> 
> http://marc.theaimsgroup.com/?l=lse-tech&m=98459051027582&w=2
> 

That's NUMA hardware.   The per-hashqueue locking change made
a big improvement on that hardware.  But when it was used on
Intel hardware it made no measurable difference at all.

Sorry, but the patch adds compexity and unless a significant
throughput benefit can be demonstrated on less exotic hardware,
why use it?

Here are kumon's test results from March, with and without
the hashed lock patch:



-------- Original Message --------
Subject: Re: [Fwd: Re: [Lse-tech] AIM7 scaling, pagecache_lock, multiqueue scheduler]
Date: Thu, 15 Mar 2001 18:03:55 +0900
From: kumon@flab.fujitsu.co.jp
Reply-To: kumon@flab.fujitsu.co.jp
To: Andrew Morton <andrewm@uow.edu.au>
CC: kumon@flab.fujitsu.co.jp, ahirai@flab.fujitsu.co.jp,John Hawkes <hawkes@engr.sgi.com>,kumon@flab.fujitsu.co.jp
In-Reply-To: <3AB032B3.87940521@uow.edu.au>,<3AB0089B.CF3496D2@uow.edu.au><200103150234.LAA28075@asami.proc><3AB032B3.87940521@uow.edu.au>

OK, the followings are a result of our brief measurement with WebBench
(mindcraft type) of 2.4.2 and 2.4.2+pcl .

Workload: WebBench 3.0 (static get)
Machine: Profusion 8way 550MHz/1MB cache 1GB mem.
Server: Apache 1.3.9-8 (w/ SINGLE_LISTEN_UNSERIALIZED_ACCEPT)
	obtained from RedHat.
Clients: 32 clients each has 2 requesting threads.

The following number is Request per sec.

		242	242+pcl	ratio
-------------------------------------
1SMP    	1,603	1,584	0.99
2(1+1)SMP	2,443	2,437	1.00
4(1+3)SMP	4,420	4,426	1.00
8(4+4)SMP	5,381	5,400	1.00

#No idle time observed in the 1 to 4 SMP runs.
#Only 8 SMP cases shows cpu-idle time, but it is about 2.1-2.8% of the
#total CPU time.

Note: The load of two buses of Profusion system isn't balance, because
the number of CPUs on each bus is unbalance.

Summary:
 From the above brief test, (+pcl) patch doens't show the measurable
performance gain.

-
