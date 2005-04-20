Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVDTSEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVDTSEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 14:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbVDTSEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 14:04:52 -0400
Received: from cernmx08.cern.ch ([137.138.166.172]:32372 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S261767AbVDTSEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 14:04:44 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding; 
	b=MEIp8gtOF8BcZ2XLUrFW8wZb53DilKaTiCJOogDpuNf9caszMXkYrUoMtftZqko9bkPYUppGZQyraPdHWmcpj7XDVPyEf9APDPiAxE8+x6nXY1aJRPN4JMiHkajUamiF;
Keywords: CERN SpamKiller Note: -51 Charset: west-latin
X-Filter: CERNMX08 CERN MX v2.0 050413.1147 Release
Message-ID: <426699B8.3020504@cern.ch>
Date: Wed, 20 Apr 2005 20:04:40 +0200
From: Andreas Hirstius <Andreas.Hirstius@cern.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux ia64; en-US; rv:1.7.7) Gecko/20050418
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey <jmerkey@utah-nac.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Serious performance degradation on a RAID with kernel 2.6.10-bk7
 and later
References: <42669357.9080604@cern.ch> <42668977.5060708@utah-nac.org>
In-Reply-To: <42668977.5060708@utah-nac.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Apr 2005 18:04:40.0663 (UTC) FILETIME=[6C425670:01C545D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just tried it, but the performance problem remains :-(
 (actually, why should it change? This part of the code didn't change so 
much between 2.6.10-bk6 and -bk7...)

Andreas



jmerkey wrote:

>
>
> For 3Ware, you need to chage the queue depths, and you will see 
> dramatically improved performance. 3Ware can take requests
> a lot faster than Linux pushes them out. Try changing this instead, 
> you won't be going to sleep all the time waiting on the read/write
> request queues to get "unstarved".
>
>
> /linux/include/linux/blkdev.h
>
> //#define BLKDEV_MIN_RQ 4
> //#define BLKDEV_MAX_RQ 128 /* Default maximum */
> #define BLKDEV_MIN_RQ 4096
> #define BLKDEV_MAX_RQ 8192 /* Default maximum */
>
>
> Jeff
>
> Andreas Hirstius wrote:
>
>> Hi,
>>
>>
>> We have a rx4640 with 3x 3Ware 9500 SATA controllers and 24x WD740GD 
>> HDD in a software RAID0 configuration (using md).
>> With kernel 2.6.11 the read performance on the md is reduced by a 
>> factor of 20 (!!) compared to previous kernels.
>> The write rate to the md doesn't change!! (it actually improves a bit).
>>
>> The config for the kernels are basically identical.
>>
>> Here is some vmstat output:
>>
>> kernel 2.6.9: ~1GB/s read
>> procs memory swap io system cpu
>> r b swpd free buff cache si so bi bo in cs us sy wa id
>> 1 1 0 12672 6592 15914112 0 0 1081344 56 15719 1583 0 11 14 74
>> 1 0 0 12672 6592 15915200 0 0 1130496 0 15996 1626 0 11 14 74
>> 0 1 0 12672 6592 15914112 0 0 1081344 0 15891 1570 0 11 14 74
>> 0 1 0 12480 6592 15914112 0 0 1081344 0 15855 1537 0 11 14 74
>> 1 0 0 12416 6592 15914112 0 0 1130496 0 16006 1586 0 12 14 74
>>
>>
>> kernel 2.6.11: ~55MB/s read
>> procs memory swap io system cpu
>> r b swpd free buff cache si so bi bo in cs us sy wa id
>> 1 1 0 24448 37568 15905984 0 0 56934 0 5166 1862 0 1 24 75
>> 0 1 0 20672 37568 15909248 0 0 57280 0 5168 1871 0 1 24 75
>> 0 1 0 22848 37568 15907072 0 0 57306 0 5173 1874 0 1 24 75
>> 0 1 0 25664 37568 15903808 0 0 57190 0 5171 1870 0 1 24 75
>> 0 1 0 21952 37568 15908160 0 0 57267 0 5168 1871 0 1 24 75
>>
>>
>> Because the filesystem might have an impact on the measurement, "dd" 
>> on /dev/md0
>> was used to get information about the performance. This also opens 
>> the possibility to test with block sizes larger than the page size.
>> And it appears that the performance with kernel 2.6.11 is closely 
>> related to the block size.
>> For example if the block size is exactly a multiple (>2) of the page 
>> size the performance is back to ~1.1GB/s.
>> The general behaviour is a bit more complicated:
>> 1. bs <= 1.5 * ps : ~27-57MB/s (differs with ps)
>> 2. bs > 1.5 * ps && bs < 2 * ps : rate increases to max. rate
>> 3. bs = n * ps ; (n >= 2) : ~1.1GB/s (== max. rate)
>> 4. bs > n * ps && bs < ~(n+0.5) * ps ; (n > 2) : ~27-70MB/s (differs 
>> with ps)
>> 5. bs > ~(n+0.5) * ps && bs < (n+1) * ps ; (n > 2) : increasing rate 
>> in several, more or
>> less, distinct steps (e.g. 1/3 of max. rate and then 2/3 of max rate 
>> for 64k pages)
>>
>> I've tested all four possible page sizes on Itanium (4k, 8k, 16k and 
>> 64k) and the pattern is always the same!!
>>
>> With kernel 2.6.9 (any kernel before 2.6.10-bk6) the read rate is 
>> always at ~1.1GB/s,
>> independent of the block size.
>>
>>
>> This simple patch solves the problem, but I have no idea of possible 
>> side-effects ...
>>
>> --- linux-2.6.12-rc2_orig/mm/filemap.c 2005-04-04 18:40:05.000000000 
>> +0200
>> +++ linux-2.6.12-rc2/mm/filemap.c 2005-04-20 10:27:42.000000000 +0200
>> @@ -719,7 +719,7 @@
>> index = *ppos >> PAGE_CACHE_SHIFT;
>> next_index = index;
>> prev_index = ra.prev_page;
>> - last_index = (*ppos + desc->count + PAGE_CACHE_SIZE-1) >> 
>> PAGE_CACHE_SHIFT;
>> + last_index = (*ppos + desc->count + PAGE_CACHE_SIZE) >> 
>> PAGE_CACHE_SHIFT;
>> offset = *ppos & ~PAGE_CACHE_MASK;
>>
>> isize = i_size_read(inode);
>> --- linux-2.6.12-rc2_orig/mm/readahead.c 2005-04-04 
>> 18:40:05.000000000 +0200
>> +++ linux-2.6.12-rc2/mm/readahead.c 2005-04-20 18:37:04.000000000 +0200
>> @@ -70,7 +70,7 @@
>> */
>> static unsigned long get_init_ra_size(unsigned long size, unsigned 
>> long max)
>> {
>> - unsigned long newsize = roundup_pow_of_two(size);
>> + unsigned long newsize = size;
>>
>> if (newsize <= max / 64)
>> newsize = newsize * newsize;
>>
>>
>>
>> In order to keep this mail short, I've created a webpage that 
>> contains all the detailed information and some plots:
>> http://www.cern.ch/openlab-debugging/raid
>>
>>
>> Regards,
>>
>> Andreas Hirstius
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at http://www.tux.org/lkml/
>>
>
