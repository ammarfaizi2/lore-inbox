Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbVIAJNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbVIAJNN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 05:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbVIAJNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 05:13:13 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:39047 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S1750814AbVIAJNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 05:13:11 -0400
Date: Thu, 1 Sep 2005 09:12:30 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <Pine.LNX.4.61.0508312148040.1081@diagnostix.dwd.de>
Message-ID: <Pine.LNX.4.61.0509010852040.17882@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
 <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
 <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de>
 <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <4315A179.8070102@yahoo.com.au>
 <Pine.LNX.4.61.0508311524190.16574@diagnostix.dwd.de> <4315E810.4030305@yahoo.com.au>
 <Pine.LNX.4.61.0508312148040.1081@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Holger Kiehl wrote:

> On Thu, 1 Sep 2005, Nick Piggin wrote:
>
>> Holger Kiehl wrote:
>> 
>>> meminfo.dump:
>>> 
>>>    MemTotal:      8124172 kB
>>>    MemFree:         23564 kB
>>>    Buffers:       7825944 kB
>>>    Cached:          19216 kB
>>>    SwapCached:          0 kB
>>>    Active:          25708 kB
>>>    Inactive:      7835548 kB
>>>    HighTotal:           0 kB
>>>    HighFree:            0 kB
>>>    LowTotal:      8124172 kB
>>>    LowFree:         23564 kB
>>>    SwapTotal:    15631160 kB
>>>    SwapFree:     15631160 kB
>>>    Dirty:         3145604 kB
>> 
>> Hmm OK, dirty memory is pinned pretty much exactly on dirty_ratio
>> so maybe I've just led you on a goose chase.
>> 
>> You could
>>    echo 5 > /proc/sys/vm/dirty_background_ratio
>>    echo 10 > /proc/sys/vm/dirty_ratio
>> 
>> To further reduce dirty memory in the system, however this is
>> a long shot, so please continue your interaction with the
>> other people in the thread first.
>> 
> Yes, this does make a difference, here the results of running
>
>  dd if=/dev/full of=/dev/sd?1 bs=4M count=4883
>
> on 8 disks at the same time:
>
>  34.273340
>  33.938829
>  33.598469
>  32.970575
>  32.841351
>  32.723988
>  31.559880
>  29.778112
>
> That's 32.710568 MB/s on average per disk with your change and without
> it it was 24.958557 MB/s on average per disk.
>
> I will do more tests tomorrow.
>
Just rechecked those numbers. Did a fresh boot and run the test several
times. With defaults (dirty_background_ratio=10, dirty_ratio=40) I get
for the dd write tests an average of 24.559491 MB/s (8 disks in parallel)
per disk. With the suggested values (dirty_background_ratio=5, dirty_ratio=10)
32.390659 MB/s per disk.

I then did a SW raid0 over all disks with the following command:

   mdadm -C /dev/md3 -l0 -n8 /dev/sd[cdefghij]1

   (dirty_background_ratio=10, dirty_ratio=40) 223.955995 MB/s
   (dirty_background_ratio=5, dirty_ratio=10)  234.318936 MB/s

So the differnece is not so big anymore.

Something else I notice while doing the dd over 8 disks is the following
(top just before they are finished):

top - 08:39:11 up  2:03,  2 users,  load average: 23.01, 21.48, 15.64
Tasks: 102 total,   2 running, 100 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0% us, 17.7% sy,  0.0% ni,  0.0% id, 78.9% wa,  0.2% hi,  3.1% si
Mem:   8124184k total,  8093068k used,    31116k free,  7831348k buffers
Swap: 15631160k total,    13352k used, 15617808k free,     5524k cached

   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
  3423 root      18   0 55204  460  392 R 12.0  0.0   1:15.55 dd
  3421 root      18   0 55204  464  392 D 11.3  0.0   1:17.36 dd
  3418 root      18   0 55204  464  392 D 10.3  0.0   1:10.92 dd
  3416 root      18   0 55200  464  392 D 10.0  0.0   1:09.20 dd
  3420 root      18   0 55204  464  392 D 10.0  0.0   1:10.49 dd
  3422 root      18   0 55200  460  392 D  9.3  0.0   1:13.58 dd
  3417 root      18   0 55204  460  392 D  7.6  0.0   1:13.11 dd
   158 root      15   0     0    0    0 D  1.3  0.0   1:12.61 kswapd3
   159 root      15   0     0    0    0 D  1.3  0.0   1:08.75 kswapd2
   160 root      15   0     0    0    0 D  1.0  0.0   1:07.11 kswapd1
  3419 root      18   0 51096  552  476 D  1.0  0.0   1:17.15 dd
   161 root      15   0     0    0    0 D  0.7  0.0   0:54.46 kswapd0
     1 root      16   0  4876  372  332 S  0.0  0.0   0:01.15 init
     2 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/0
     3 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/0
     4 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/1
     5 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/1
     6 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/2
     7 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/2
     8 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/3
     9 root      34  19     0    0    0 S  0.0  0.0   0:00.00 ksoftirqd/3

A loadaverage of 23 for 8 dd's seems a bit high. Also why is kswapd working
so hard? Is that correct.

Please just tell me if there is anything else I can test or dumps that
could be useful.

Thanks,
Holger

