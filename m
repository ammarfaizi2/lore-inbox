Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131742AbRDQKrA>; Tue, 17 Apr 2001 06:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131820AbRDQKqu>; Tue, 17 Apr 2001 06:46:50 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29663 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S131742AbRDQKqp>; Tue, 17 Apr 2001 06:46:45 -0400
Date: Tue, 17 Apr 2001 16:19:16 +0530
From: Maneesh Soni <smaneesh@in.ibm.com>
To: Anton Blanchard <anton@samba.org>
Cc: Paul.McKenney@us.ibm.com, dipankar@sequent.com,
        lkml <linux-kernel@vger.kernel.org>,
        lse tech <lse-tech@lists.sourceforge.net>
Subject: Re: Scalable FD Management ....
Message-ID: <20010417161916.A11419@in.ibm.com>
Reply-To: smaneesh@in.ibm.com
In-Reply-To: <20010409201311.D9013@in.ibm.com> <20010411182929.A16665@va.samba.org> <20010412211354.A25905@in.ibm.com> <20010412085118.A26665@va.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010412085118.A26665@va.samba.org>; from anton@samba.org on Thu, Apr 12, 2001 at 08:51:18AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2001 at 08:51:18AM -0700, Anton Blanchard wrote:
>  
> Hi,
> 
> > Base (2.4.2) - 
> >         100 Average Throughput = 39.628  MB/sec
> >         200 Average Throughput = 22.792  MB/sec
> > 
> > Base + files_struct patch - 
> >         100 Average Throughput = 39.874 MB/sec
> >         200 Average Throughput = 23.174 MB/sec  
> >          
> > I found this value quite less than the one present in the README distributed
> > with dbench tarball. I think the numbers in the README were for a similar 
> > machine but with 2.2.9 kernel.
> 
> If you guestimate that each dbench client uses about 20M of RAM then dbench
> 100 has no chance of remaining in memory. Once you hit disk then spinlock
> optimisations are all in the noise :) Smaller runs (< 30) should see 
> it stay in memory.
> 
> Also if you turn of kupdated (so old buffers are not flushed out just
> because they are old) and make the VM more agressive about filling
> memory with dirty buffers then you will not hit the disk and then
> hopefully the optimisations will be more obvious.
> 
> killall -STOP kupdated
> echo "90 64 64 256 500 3000 95 0 0" > /proc/sys/vm/bdflush
> 
> Remember to killall -CONT kupdated when you are finished :)
> 
> > I am copying this to Andrew also, if he can also help. Also if you have some
> > dbench numbers from 2.4.x kernel, please let me have a look into those also.
> 
> The single CPU 333MHz POWER 3 I was playing with got 100MB/s when not
> touching disk.
> 
> Anton
> -

Hi Anton,

I ran the dbench test as per your suggesstions. Now I get similar throughput 
numbers as yours. 

But still the throughput improvement is not there for my patch. the reason, I 
think, is that I didnot get too many hits to fget() routine. It will be helpful
if you can tell how you got fget() chewing up more than its fair share of CPU
time.

For 30 clients:
      Base(2.4.2)                - Average Throughput = 235.139 MB/S  
      Base + Files_struct patch  - Average Throughput = 235.751 MB/S 

I also did profiling while running these tests, using kernprof. The fget hits
are as below
      Base(2.4.2)                   304  
      Base + Files_struct patch     189

Though while doing kernprofile'ing my sample size is quite big (the top ranker 
in profiling is "default_idle" with 28471 hits). The fget's hit count is quite
low compared to "default_idle".

As you can also see, the files_struct patch is able to reduce the number of hits
to fget by around 37%

I also saw the dbench.c code. It does creates no. of child processes but with
fork() and not through __clone(). 

I think the fget() will affect the performance in the scenarios where the 
childs are created using clone() with CLONE_FILES flag set. That is when many 
child processes share parent's files_struct and everybody tries to acquire the 
same files->file_lock. And in those scenarios we should see considerable 
performance improvement by using the files_struct patch as in the case of "chat"benchmark.

Regards,
Maneesh

-- 
Maneesh Soni <smaneesh@in.ibm.com>
http://lse.sourceforge.net/locking/rclock.html
IBM Linux Technology Center,
IBM Software Lab, Bangalore, India
