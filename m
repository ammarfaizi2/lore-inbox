Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131530AbRC0T6u>; Tue, 27 Mar 2001 14:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbRC0T6m>; Tue, 27 Mar 2001 14:58:42 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:9281 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S131528AbRC0T6e>; Tue, 27 Mar 2001 14:58:34 -0500
Date: Tue, 27 Mar 2001 13:57:42 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103271957.NAA13547@tomcat.admin.navo.hpc.mil>
To: jaharkes@cs.cmu.edu, LA Walsh <law@sgi.com>
Subject: Re: 64-bit block sizes on 32-bit systems
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------  Received message begins Here  ---------

> 
> On Tue, Mar 27, 2001 at 09:15:08AM -0800, LA Walsh wrote:
> > 	Now lets look at the sites want to process terabytes of
> > data -- perhaps files systems up into the Pentabyte range.  Often I
> > can see these being large multi-node (think 16-1024 clusters as 
> > are in use today for large super-clusters).  If I was to characterize
> > the performance of them, I'd likely see the CPU pegged at 100% 
> > with 99% usage in user space.  Let's assume that increasing the
> > block size decreases disk accesses by as much as 10% (you'll have
> > to admit -- using a 64bit quantity vs. 32bit quantity isn't going
> > to even come close to increasing disk access times by 1 millisecond,
> > really, so it really is going to be a much smaller fraction when
> > compared to the actual disk latency).  
> [snip]
> > 	Is there some logical flaw in the above reasoning?
> 
> But those changes will affect even the fastpath, i.e. data that is
> already in the page/buffer caches. In which case we don't have to wait
> for disk access latency. Why would anyone who is working with a
> pentabyte of data even consider not relying on essentially always
> hitting data that is available the read-ahead cache.

It depends entirely on the application. Where the cache can contain
20% of the data, most accesses should already be in memory. If the
data is significantly larger, there is a high chance that the data
will not be there.

> 
> Using similar numbers as presented. If we are working our way through
> every single block in a Pentabyte filesystem, and the blocksize is 512
> bytes. Then the 1us in extra CPU cycles because of 64-bit operations
> would add, according to by back of the envelope calculation, 2199023
> seconds of CPU time a bit more than 25 days.

Ummm... I don't think it adds that much. You seem to be leaving out the
overlap disk/IO and computation for read-ahead. This should eliminate the
majority of the delay effect.

> Seriously, there is a lot more that needs to be done than introducing a
> 64-bit blocknumber. Effectively 512 byte blocks are far too small for
> that kind of data, and going to pagesize blocks (and increasing pagesize
> to 64KB or 2MB at the same time) is a solution that is far more likely
> to give good results since it reduces both the total the number of
> 'blocks' on the device as well as reducing the total amount of calls
> throughout kernel space instead of increasing the cost per call.

Talk about adding overhead... How long do you think it takes to read a
2MB block (not to mention the time to update that page..) The additional
contention on the fiberchannel I/O alone might kill it if the filesystem
is busy.

Granted, 512 bytes could be considered too small for some things, but
once you pass 32K you start adding a lot of rotational delay problems.
I've used file systems with 256K blocks - they are slow when compaired
to the throughput using 32K. I wasn't the one running the benchmarks,
but with a MaxStrat 400GB raid with 256K sized data transfer was much
slower (around 3 times slower) than 32K. (The target application was
a GIS server using Oracle).

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
