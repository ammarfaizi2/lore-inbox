Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261773AbSJQEUl>; Thu, 17 Oct 2002 00:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261775AbSJQEUl>; Thu, 17 Oct 2002 00:20:41 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:32996 "EHLO
	kolivas.net") by vger.kernel.org with ESMTP id <S261773AbSJQEUj>;
	Thu, 17 Oct 2002 00:20:39 -0400
Message-ID: <1034828795.3dae3bfb42911@kolivas.net>
Date: Thu, 17 Oct 2002 14:26:35 +1000
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin <wli@holomorphy.com>
Subject: Re: Pathological case identified from contest
References: <1034820820.3dae1cd4bc0e3@kolivas.net> <3DAE252B.A9A5F6B1@digeo.com>
In-Reply-To: <3DAE252B.A9A5F6B1@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@digeo.com>:

> Con Kolivas wrote:
> > 
> > I found a pathological case in 2.5 while running contest with process_load
> > recently after checking the results which showed a bad result for
> 2.5.43-mm1:
> > 
> > 2.5.43-mm1              101.38  72%     42      31%
> > 2.5.43-mm1              102.90  75%     34      28%
> > 2.5.43-mm1              504.12  14%     603     85%
> > 2.5.43-mm1              96.73   77%     34      26%
> > 
> > This was very strange so I looked into it further
> > 
> > The default for process_load is this command:
> > 
> > process_load --processes $nproc --recordsize 8192 --injections 2
> > 
> > where $nproc=4*num_cpus
> > 
> > When I changed recordsize to 16384, many of the 2.5 kernels started
> exhibiting
> > the same behaviour. While the machine was apparently still alive and would
> > respond to my request to abort, the kernel compile would all but stop
> while
> > process_load just continued without allowing anything to happen from
> kernel
> > compilation for up to 5 minutes at a time. This doesnt happen with any 2.4
> kernels.
> > 
> 
> Well it doesn't happen on my test machine (UP or SMP).  I tried
> various recordsizes.  It's probably related to HZ, memory bandwidth
> and the precise timing at which things happen.
> 
> The test describes itself thusly:
> 
>  *  This test generates a load which simulates a process-loaded system.
>  *
>  *  The test creates a ring of processes, each connected to its predecessor
>  *  and successor by a pipe.  After the ring is created, the parent process
>  *  injects some dummy data records into the ring and then joins.  The
>  *  processes pass the data records around the ring until they are killed.
>  *
> 
> It'll be starvation in the CPU scheduler I expect.  For some reason
> the ring of piping processes is just never giving a timeslice to
> anything else.  Or maybe something to do with the exceptional
> wakeup strategy which pipes use.
> 
> Don't now, sorry.  One for the kernel/*.c guys.

Ok well I've done some profiling as suggested by wli and it shows pretty much
what I find in the results - it gets stuck while doing process_load and never
moves on.

recordsize 8192 kern profile:
c01223ac 76997    4.48583     do_anonymous_page
c0188694 135835   7.91373     __generic_copy_from_user
c0188610 345071   20.1038     __generic_copy_to_user
c0105298 801429   46.6911     poll_idle
sysprofile:
00000000 160258   5.03854     (no symbol)             /lib/i686/libc-2.2.5.so
c0188610 345071   10.8491     __generic_copy_to_user 
/home/con/kernel/linux-2.5.43/vmlinux
c0105298 801429   25.1971     poll_idle              
/home/con/kernel/linux-2.5.43/vmlinux
00000000 1132668  35.6113     (no symbol)            
/usr/lib/gcc-lib/i686-pc-linux-gnu/2.95.3/cc1

Normal run consistent with doing kernel compilation most of the time.

recordsize 16384 kernprofile: 
c0111ef4 403545   4.3407      do_schedule
c0105298 558704   6.00965     poll_idle
c0188694 2571995  27.6655     __generic_copy_from_user
c0188610 4489796  48.2941     __generic_copy_to_user
sysprofile:
c0111ef4 403545   4.24896     do_schedule            
/home/con/kernel/linux-2.5.43/vmlinux
c0105298 558704   5.88264     poll_idle              
/home/con/kernel/linux-2.5.43/vmlinux
c0188694 2571995  27.0807     __generic_copy_from_user
/home/con/kernel/linux-2.5.43/vmlinux
c0188610 4489796  47.2734     __generic_copy_to_user 
/home/con/kernel/linux-2.5.43/vmlinux

I had to abort the run with recordsize 16384 but you can see it's just stuck in
process_load copying data between forked processes.

Can someone else on lkml decipher why it gets stuck here?

Con
