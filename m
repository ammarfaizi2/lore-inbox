Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261646AbSJQCnY>; Wed, 16 Oct 2002 22:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261650AbSJQCnY>; Wed, 16 Oct 2002 22:43:24 -0400
Received: from packet.digeo.com ([12.110.80.53]:41877 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261646AbSJQCnX>;
	Wed, 16 Oct 2002 22:43:23 -0400
Message-ID: <3DAE252B.A9A5F6B1@digeo.com>
Date: Wed, 16 Oct 2002 19:49:15 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Pathological case identified from contest
References: <1034820820.3dae1cd4bc0e3@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Oct 2002 02:49:15.0399 (UTC) FILETIME=[C7DD2970:01C27587]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> I found a pathological case in 2.5 while running contest with process_load
> recently after checking the results which showed a bad result for 2.5.43-mm1:
> 
> 2.5.43-mm1              101.38  72%     42      31%
> 2.5.43-mm1              102.90  75%     34      28%
> 2.5.43-mm1              504.12  14%     603     85%
> 2.5.43-mm1              96.73   77%     34      26%
> 
> This was very strange so I looked into it further
> 
> The default for process_load is this command:
> 
> process_load --processes $nproc --recordsize 8192 --injections 2
> 
> where $nproc=4*num_cpus
> 
> When I changed recordsize to 16384, many of the 2.5 kernels started exhibiting
> the same behaviour. While the machine was apparently still alive and would
> respond to my request to abort, the kernel compile would all but stop while
> process_load just continued without allowing anything to happen from kernel
> compilation for up to 5 minutes at a time. This doesnt happen with any 2.4 kernels.
> 

Well it doesn't happen on my test machine (UP or SMP).  I tried
various recordsizes.  It's probably related to HZ, memory bandwidth
and the precise timing at which things happen.

The test describes itself thusly:

 *  This test generates a load which simulates a process-loaded system.
 *
 *  The test creates a ring of processes, each connected to its predecessor
 *  and successor by a pipe.  After the ring is created, the parent process
 *  injects some dummy data records into the ring and then joins.  The
 *  processes pass the data records around the ring until they are killed.
 *

It'll be starvation in the CPU scheduler I expect.  For some reason
the ring of piping processes is just never giving a timeslice to
anything else.  Or maybe something to do with the exceptional
wakeup strategy which pipes use.

Don't now, sorry.  One for the kernel/*.c guys.
