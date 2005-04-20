Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVDTUNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVDTUNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 16:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVDTUNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 16:13:53 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:38334 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261773AbVDTUNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 16:13:41 -0400
Message-ID: <4266AAE0.1020000@utah-nac.org>
Date: Wed, 20 Apr 2005 13:17:52 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Hirstius <Andreas.Hirstius@cern.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7
 and later
References: <42669357.9080604@cern.ch> <42668977.5060708@utah-nac.org> <42669E73.4000304@cern.ch>
In-Reply-To: <42669E73.4000304@cern.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Burst is good.  There's another window in the SCSI layer that limits to 
bursts of 128 sector runs (this seems to be the behavior
on 3Ware).  I've never changed this, but increasing the max number of 
SCSI requests at this layer may help.  The
bursty behavior is good, BTW.

Jeff

Andreas Hirstius wrote:

>
> I was curious if your patch would change the write rate because I see 
> only ~550MB/s (continuous) which is about a factor two away from the 
> capabilities of the disks.
> ... and got this behaviour (with and without my other patch):
>
> (with single "dd if=/dev/zero of=testxx bs=65536 count=150000 &" or 
> several of them in parallel on an XFS fs)
>
> "vmstat 1" output
> 0  0      0  28416  37888 15778368    0    0     0     0 8485  3043  
> 0  0  0 100
> 6  0      0  22144  37952 15785920    0    0     0 12356 7695  2029  0 
> 61  0 39
> 7  0      0  20864  38016 15785856    0    0   324 1722240 8046  4159  
> 0 100  0  0
> 7  0      0  20864  38016 15784768    0    0     0 1261440 8391  5222  
> 0 100  0  0
> 7  0      0  25984  38016 15781504    0    0     0 2003456 8372  5038  
> 0 100  0  0
> 0  6      0  22784  38016 15781504    0    0     0 2826624 8397  8423  
> 0 93  7  0
> 0  0      0  21632  38016 15783680    0    0     0 147840 8572 12114  
> 0  9 17 74
> 0  0      0  21632  38016 15783680    0    0     0    52 8586  5185  
> 0  0  0 100
> 0  0      0  21632  38016 15783680    0    0     0     0 8588  5412  
> 0  0  0 100
> 0  0      0  21632  38016 15783680    0    0     0     0 8580  5372  
> 0  0  0 100
> 0  0      0  21632  38016 15783680    0    0     0     0 7840  5590  
> 0  0  0 100
> 0  0      0  21632  38016 15783680    0    0     0     0 8587  5321  
> 0  0  0 100
> 0  0      0  21632  38016 15783680    0    0     0     0 8569  5575  
> 0  0  0 100
> 0  0      0  21632  38016 15783680    0    0     0     0 8550  5157  
> 0  0  0 100
> 0  0      0  21632  38016 15783680    0    0     0     0 7963  5640  
> 0  0  0 100
> 0  0      0  21632  38016 15783680    0    0     0    32 8583  4434  
> 0  0  0 100
> 7  0      0  20800  38016 15784768    0    0     0  7424 8404  3638  0 
> 15  0 85
> 8  0      0  20864  38016 15786944    0    0     0 688768 7357  3221  
> 0 100  0  0
> 8  0      0  20736  28544 15794240    0    0     0 1978560 8376  4897  
> 0 100  0  0
> 7  0      0  22208  20736 15798784    0    0     0 1385088 8367  4984  
> 0 100  0  0
> 6  0      0  22144   6848 15812672    0    0    56 1291904 8377  4815  
> 0 100  0  0
> 0  0      0  50240   6848 15809408    0    0   304  3136 8556  5088  1 
> 26  0 74
> 0  0      0  50304   6848 15809408    0    0     0     0 8572  5181  
> 0  0  0 100
>
> The average rate here is again pretty close to 550MB/s, it just writes 
> the blocks in "bursts"...
>
>
> Andreas
>
>
> jmerkey wrote:
>
>>
>>
>> For 3Ware, you need to chage the queue depths, and you will see 
>> dramatically improved performance. 3Ware can take requests
>> a lot faster than Linux pushes them out. Try changing this instead, 
>> you won't be going to sleep all the time waiting on the read/write
>> request queues to get "unstarved".
>>
>>
>> /linux/include/linux/blkdev.h
>>
>> //#define BLKDEV_MIN_RQ 4
>> //#define BLKDEV_MAX_RQ 128 /* Default maximum */
>> #define BLKDEV_MIN_RQ 4096
>> #define BLKDEV_MAX_RQ 8192 /* Default maximum */
>>
>>
>> Jeff
>>
>> Andreas Hirstius wrote:
>>
>>> Hi,
>>>
>>>
>>> We have a rx4640 with 3x 3Ware 9500 SATA controllers and 24x WD740GD 
>>> HDD in a software RAID0 configuration (using md).
>>> With kernel 2.6.11 the read performance on the md is reduced by a 
>>> factor of 20 (!!) compared to previous kernels.
>>> The write rate to the md doesn't change!! (it actually improves a bit).
>>>
>>> The config for the kernels are basically identical.
>>>
>>> Here is some vmstat output:
>>>
>>> kernel 2.6.9: ~1GB/s read
>>> procs memory swap io system cpu
>>> r b swpd free buff cache si so bi bo in cs us sy wa id
>>> 1 1 0 12672 6592 15914112 0 0 1081344 56 15719 1583 0 11 14 74
>>> 1 0 0 12672 6592 15915200 0 0 1130496 0 15996 1626 0 11 14 74
>>> 0 1 0 12672 6592 15914112 0 0 1081344 0 15891 1570 0 11 14 74
>>> 0 1 0 12480 6592 15914112 0 0 1081344 0 15855 1537 0 11 14 74
>>> 1 0 0 12416 6592 15914112 0 0 1130496 0 16006 1586 0 12 14 74
>>>
>>>
>>> kernel 2.6.11: ~55MB/s read
>>> procs memory swap io system cpu
>>> r b swpd free buff cache si so bi bo in cs us sy wa id
>>> 1 1 0 24448 37568 15905984 0 0 56934 0 5166 1862 0 1 24 75
>>> 0 1 0 20672 37568 15909248 0 0 57280 0 5168 1871 0 1 24 75
>>> 0 1 0 22848 37568 15907072 0 0 57306 0 5173 1874 0 1 24 75
>>> 0 1 0 25664 37568 15903808 0 0 57190 0 5171 1870 0 1 24 75
>>> 0 1 0 21952 37568 15908160 0 0 57267 0 5168 1871 0 1 24 75
>>>
>>>
>>> Because the filesystem might have an impact on the measurement, "dd" 
>>> on /dev/md0
>>> was used to get information about the performance. This also opens 
>>> the possibility to test with block sizes larger than the page size.
>>> And it appears that the performance with kernel 2.6.11 is closely 
>>> related to the block size.
>>> For example if the block size is exactly a multiple (>2) of the page 
>>> size the performance is back to ~1.1GB/s.
>>> The general behaviour is a bit more complicated:
>>> 1. bs <= 1.5 * ps : ~27-57MB/s (differs with ps)
>>> 2. bs > 1.5 * ps && bs < 2 * ps : rate increases to max. rate
>>> 3. bs = n * ps ; (n >= 2) : ~1.1GB/s (== max. rate)
>>> 4. bs > n * ps && bs < ~(n+0.5) * ps ; (n > 2) : ~27-70MB/s (differs 
>>> with ps)
>>> 5. bs > ~(n+0.5) * ps && bs < (n+1) * ps ; (n > 2) : increasing rate 
>>> in several, more or
>>> less, distinct steps (e.g. 1/3 of max. rate and then 2/3 of max rate 
>>> for 64k pages)
>>>
>>> I've tested all four possible page sizes on Itanium (4k, 8k, 16k and 
>>> 64k) and the pattern is always the same!!
>>>
>>> With kernel 2.6.9 (any kernel before 2.6.10-bk6) the read rate is 
>>> always at ~1.1GB/s,
>>> independent of the block size.
>>>
>>>
>>> This simple patch solves the problem, but I have no idea of possible 
>>> side-effects ...
>>>
>>> --- linux-2.6.12-rc2_orig/mm/filemap.c 2005-04-04 18:40:05.000000000 
>>> +0200
>>> +++ linux-2.6.12-rc2/mm/filemap.c 2005-04-20 10:27:42.000000000 +0200
>>> @@ -719,7 +719,7 @@
>>> index = *ppos >> PAGE_CACHE_SHIFT;
>>> next_index = index;
>>> prev_index = ra.prev_page;
>>> - last_index = (*ppos + desc->count + PAGE_CACHE_SIZE-1) >> 
>>> PAGE_CACHE_SHIFT;
>>> + last_index = (*ppos + desc->count + PAGE_CACHE_SIZE) >> 
>>> PAGE_CACHE_SHIFT;
>>> offset = *ppos & ~PAGE_CACHE_MASK;
>>>
>>> isize = i_size_read(inode);
>>> --- linux-2.6.12-rc2_orig/mm/readahead.c 2005-04-04 
>>> 18:40:05.000000000 +0200
>>> +++ linux-2.6.12-rc2/mm/readahead.c 2005-04-20 18:37:04.000000000 +0200
>>> @@ -70,7 +70,7 @@
>>> */
>>> static unsigned long get_init_ra_size(unsigned long size, unsigned 
>>> long max)
>>> {
>>> - unsigned long newsize = roundup_pow_of_two(size);
>>> + unsigned long newsize = size;
>>>
>>> if (newsize <= max / 64)
>>> newsize = newsize * newsize;
>>>
>>>
>>>
>>> In order to keep this mail short, I've created a webpage that 
>>> contains all the detailed information and some plots:
>>> http://www.cern.ch/openlab-debugging/raid
>>>
>>>
>>> Regards,
>>>
>>> Andreas Hirstius
>>>
>>>
>>> -
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at http://www.tux.org/lkml/
>>>
>>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

