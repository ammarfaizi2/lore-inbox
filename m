Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314748AbSEMX5j>; Mon, 13 May 2002 19:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314755AbSEMX5i>; Mon, 13 May 2002 19:57:38 -0400
Received: from sj-msg-core-4.cisco.com ([171.71.163.10]:42485 "EHLO
	sj-msg-core-4.cisco.com") by vger.kernel.org with ESMTP
	id <S314748AbSEMX5h>; Mon, 13 May 2002 19:57:37 -0400
Message-Id: <5.1.0.14.2.20020514095214.040f5098@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 14 May 2002 09:58:31 +1000
To: Andrea Arcangeli <andrea@suse.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH]
  2.5.14IDE  56)
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020513131940.P13730@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:19 PM 13/05/2002 +0200, Andrea Arcangeli wrote:
> > so the above is:
> >   blocks = 64K, bs=8k means 64000 x 8192-byte read()s = 524288000 bytes
> >   blocks = 5K, bs=1m means 5000 x 1048576-byte read()s = 5242880000 bytes
>
>if the program is doing only what shown in the main loop, then you're
>reading 10 times more data with O_DIRECT, that was my point in saying
>64k*8k == 5k * 1M / 10, but I assume you took it into account (otherwise
>it means O_DIRECT is just 5 times faster than buffered-I/O for you)

no- count them up above.
   without O_DIRECT i was doing: 64000 x 8192 = 524288000 bytes
   with O_DIRECT i was doing: 5000 x 1048576 = 524288000 bytes.

ie. same amount of data.

regardless, the "mbyte/sec" is calculated at the very end.

>Also I would suggest to measure the time taken by the whole workload, not only
>the time for read/write syscalls.

the time taken for the whole workload _is_ calculated at the very end of 
the workload.  that way and "readahead" doesn't have an unfair advantage.
i also have gettimeofday() calls to measure latency on a per-read or 
per-write basis

...
>One thing I would also recommend is to write a threaded version of the 
>program,
>that reads or writes to all the /dev/sd disks simultaneously, first w/ 
>O_DIRECT
>then w/o O_DIRECT. The reason is that currently you aren't using all the disks
>at once with O_DIRECT due the lack of async-io

i've thought about doing that - shame that there isn't an async version of 
read().  the hard part is that i want to keep the disks at roughly the same 
"block" at the same time, so there will still need to be some 
syncronization of threads.
otherwise, basic SCSI id priority means that it won't be fair across all 
disks.  (remeber that i'm also attempting to measure latency)

...
>Since you "stripe" by hand in all disks you do a different workload than my
>previous benchs and you definitely want to keep all the harddisk running 
>at the
>same time. I would also suggest to benchmark a single disk, to see if there is
>still such a big performance difference (again: including the cost outside the
>syscalls too).

a single-disk means we hit the performance limits of a single disk 
spindle.  ie. around 45mbyte/sec sustained throughput.
if you don't think there's any real overhead in the MD driver, i'll just 
use that instead for now. (raid-0)

>Thanks for the interesting big-iron number-feedback :)

kinda fun. :-)


cheers,

lincoln.

