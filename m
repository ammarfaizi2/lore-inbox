Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262323AbSJQX0W>; Thu, 17 Oct 2002 19:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262328AbSJQX0W>; Thu, 17 Oct 2002 19:26:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:8356 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262323AbSJQX0S>;
	Thu, 17 Oct 2002 19:26:18 -0400
Subject: Re: [Lse-tech] Re: Skb initialization patch
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, hartner@austin.ibm.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFD446395A.FCBE2A74-ON87256C55.0048570F@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Thu, 17 Oct 2002 18:30:50 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/17/2002 05:30:52 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



   Are you saying that the skbs do not migrate between the per cpu
   pools (hotlist) if you have enough skbs in the hotlist/slab cache.
   There is always going to be migration of objects between CPUs
   even if you have enough objects per cpu pool.  There are other
   elements come into picture such as memory reclaim etc.,
   Moreover there is no guarantee that once a skb is allocated from
   cpu 0 pool, it would be freed to cpu 0 pool.

>Your original claim was that moving the initialization from "free
>time" to "alloc time" reduces inter-cpu cache activity.

Yes that is correct.

>You are arguing now that, after allocation, the object can move from
>one cpu to another.

That was just to point out that there is another way objects can
migrate from one cpu to another. Even if you fix the code so that you
always have enough objects per cpu pool/slab cache, the objects
still migrate for other reasons. I am not saying that this patch
takes care of all migration problems.

   If the per cpu SLAB pool is depleted, it goes to the general
   slab pool. As I pointed out earlier you cannot eliminate this
   completely.

>No, but you can make it happen much less often.  I really believe
>the effort belongs here, because it helps everyone using SLAB
>with constructors.

The slab runs the constructor when the object is created, it does
not touch the object until it is time to destory the cache object.
So the user can free the object and allocate as many times as it
wants without slab messing it up. This basically helps to preserve
read only variables in the object. When the object needs to be
initialized between uses it is upto the user to do it and that is
what alloc_skb and free_skb are doing. I am just saying
initializing during allocation is better (saves some cycles) than
initializing during free time. It is not a problem with SLAB,
it is a problem with skb alloc and free code. There is no guarantee
that the initialized skb freed on CPU 0 will be allocated on CPU 0.
This patch helps those cases.

I have not found code, (atleast the amount of code that I looked) in
any other part of the kernel, that initializes during free instead
of during allocation.

>If the SLAB problem is "unsolvable", then we should just kill
>constructor/destructor facility of SLAB because, as per your
>arguments, it deteriorates performance on SMP if actually used.
It is not a SLAB constructor/destructor problem.

   BTW SLAB is where I started the investigation, I will go back
   to that later. We can modify SLAB cache to hold more objects
   per cpu, but that won't eliminate the migration of objects.

>And I argue that your patch cannot improve locality for the bad
>inter-cpu SKB movement cases which occur post-allocation.

The results speak for itself. The number of connections increased by 32
in SPECWeb99 workload.

   I am working on the problem I posted yesterday. This skb init patch
   was done long time ago. I just collected data on new kernels.

>Hmmm, you said data was with 2.5.38 kernel.  Were these SKB init tests
>done with something more recent?

Yes I tested on 2.5.40 kernel, that is how I found out the context switch
problem. I was supposed to send this patch few weeks ago, I got busy
with other work.

The problem in 2.5.40 turned out to be that we were calling schedule_task
in batch_entropy_store. So for every interrupt, we were calling context
switch (my understanding). It is fixed in 2.5.43 and so I ran the test
on 2.5.43 and the results are as follows:


The following are the results running Netperf3:
Pentium III 998 MHz 2-way system
Netperf3 tcp_stream test on an 2-way system using 2.5.43 SMP
kernel. One adapter one connection test with 64k socket buffer
and tcp no-delay ON. NAPI and TSO are disabled.

             2.5.43             2.5.43+patch      % Improvment
Msg size     Throughput          Throughput
(bytes)       Mbits/sec           Mbits/sec
512            533.1               537.2              0.8
1024           587.7               590.0              0.4
2048           631.8               645.3              2.1
4096           677.1               679.0              0.3
8192           715.2               712.4             -0.4
16384          726.5               746.0              2.7
32768          715.4               728.0              1.8
65536          668.2               679.6              1.7

2.5.43 kernel baseline profile for 4k msg size  - routines
affected by the patch:

c02aacd0 alloc_skb                                  777
c02aaf20 skb_release_data                           873
c02aafd0 kfree_skbmem                               323
c02ab040 __kfree_skb                               1254
      Total ticks spent in these routines:         3227


2.5.43 kernel+skbinit patch profile for 4k msg size -
routines affected by the patch:

c02aacd0 alloc_skb                                  1099
c02aaf80 skb_release_data                            712
c02ab030 kfree_skbmem                                302
c02ab0a0 __kfree_skb                                 958
     Total ticks spent in these routines:           3071


Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




