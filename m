Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265522AbSJSEIF>; Sat, 19 Oct 2002 00:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265526AbSJSEIF>; Sat, 19 Oct 2002 00:08:05 -0400
Received: from ns.suse.de ([213.95.15.193]:269 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265522AbSJSEH4>;
	Sat, 19 Oct 2002 00:07:56 -0400
Date: Sat, 19 Oct 2002 06:13:57 +0200
From: Andi Kleen <ak@suse.de>
To: Mala Anand <manand@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, akpm@digeo.com,
       hartner@austin.ibm.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: Skb initialization patch
Message-ID: <20021019061356.A8704@wotan.suse.de>
References: <OFD446395A.FCBE2A74-ON87256C55.0048570F@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFD446395A.FCBE2A74-ON87256C55.0048570F@boulder.ibm.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 06:30:50PM -0500, Mala Anand wrote:
> So the user can free the object and allocate as many times as it
> wants without slab messing it up. This basically helps to preserve
> read only variables in the object. When the object needs to be
> initialized between uses it is upto the user to do it and that is
> what alloc_skb and free_skb are doing. I am just saying
> initializing during allocation is better (saves some cycles) than
> initializing during free time. It is not a problem with SLAB,
> it is a problem with skb alloc and free code. There is no guarantee
> that the initialized skb freed on CPU 0 will be allocated on CPU 0.
> This patch helps those cases.
> 
> I have not found code, (atleast the amount of code that I looked) in
> any other part of the kernel, that initializes during free instead
> of during allocation.

I wrote the original skb slab code. As far as I remember I didn't really 
consider SMP when I designed it. The main design point was actually to only 
dirty a single cache line for fast routing on UP using special allocation 
/free function, but that has been long broken anyways. At least from my 
standpoint I have no problems with your changes.


-Andi

> 
> >If the SLAB problem is "unsolvable", then we should just kill
> >constructor/destructor facility of SLAB because, as per your
> >arguments, it deteriorates performance on SMP if actually used.
> It is not a SLAB constructor/destructor problem.
> 
>    BTW SLAB is where I started the investigation, I will go back
>    to that later. We can modify SLAB cache to hold more objects
>    per cpu, but that won't eliminate the migration of objects.
> 
> >And I argue that your patch cannot improve locality for the bad
> >inter-cpu SKB movement cases which occur post-allocation.
> 
> The results speak for itself. The number of connections increased by 32
> in SPECWeb99 workload.
> 
>    I am working on the problem I posted yesterday. This skb init patch
>    was done long time ago. I just collected data on new kernels.
> 
> >Hmmm, you said data was with 2.5.38 kernel.  Were these SKB init tests
> >done with something more recent?
> 
> Yes I tested on 2.5.40 kernel, that is how I found out the context switch
> problem. I was supposed to send this patch few weeks ago, I got busy
> with other work.
> 
> The problem in 2.5.40 turned out to be that we were calling schedule_task
> in batch_entropy_store. So for every interrupt, we were calling context
> switch (my understanding). It is fixed in 2.5.43 and so I ran the test
> on 2.5.43 and the results are as follows:
> 
> 
> The following are the results running Netperf3:
> Pentium III 998 MHz 2-way system
> Netperf3 tcp_stream test on an 2-way system using 2.5.43 SMP
> kernel. One adapter one connection test with 64k socket buffer
> and tcp no-delay ON. NAPI and TSO are disabled.
> 
>              2.5.43             2.5.43+patch      % Improvment
> Msg size     Throughput          Throughput
> (bytes)       Mbits/sec           Mbits/sec
> 512            533.1               537.2              0.8
> 1024           587.7               590.0              0.4
> 2048           631.8               645.3              2.1
> 4096           677.1               679.0              0.3
> 8192           715.2               712.4             -0.4
> 16384          726.5               746.0              2.7
> 32768          715.4               728.0              1.8
> 65536          668.2               679.6              1.7
> 
> 2.5.43 kernel baseline profile for 4k msg size  - routines
> affected by the patch:
> 
> c02aacd0 alloc_skb                                  777
> c02aaf20 skb_release_data                           873
> c02aafd0 kfree_skbmem                               323
> c02ab040 __kfree_skb                               1254
>       Total ticks spent in these routines:         3227
> 
> 
> 2.5.43 kernel+skbinit patch profile for 4k msg size -
> routines affected by the patch:
> 
> c02aacd0 alloc_skb                                  1099
> c02aaf80 skb_release_data                            712
> c02ab030 kfree_skbmem                                302
> c02ab0a0 __kfree_skb                                 958
>      Total ticks spent in these routines:           3071
> 
> 
> Regards,
>     Mala
> 
> 
>    Mala Anand
>    IBM Linux Technology Center - Kernel Performance
>    E-mail:manand@us.ibm.com
>    http://www-124.ibm.com/developerworks/opensource/linuxperf
>    http://www-124.ibm.com/developerworks/projects/linuxperf
>    Phone:838-8088; Tie-line:678-8088
> 
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by: viaVerio will pay you up to
> $1,000 for every account that you consolidate with us.
> http://ad.doubleclick.net/clk;4749864;7604308;v?
> http://www.viaverio.com/consolidator/osdn.cfm
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
