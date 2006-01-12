Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWALDuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWALDuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 22:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWALDuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 22:50:21 -0500
Received: from ms-smtp-02-smtplb.tampabay.rr.com ([65.32.5.132]:61617 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751162AbWALDuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 22:50:19 -0500
Message-ID: <43C5D1F3.3060503@cfl.rr.com>
Date: Wed, 11 Jan 2006 22:50:11 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kenny Simpson <theonetruekenny@yahoo.com>
CC: David Lloyd <dmlloyd@tds.net>, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is user-space AIO dead?
References: <20060111220231.27064.qmail@web34106.mail.mud.yahoo.com>
In-Reply-To: <20060111220231.27064.qmail@web34106.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached are the results of some simple testing I did in ods format. 
These tests involved having dd read the first GB of data from my two 
drive sata (fake)raid0 array with varying numbers of concurrent aio 
operations ( except for the original, non aio dd of course ).

I performed these tests with cpufreq disabled and filesystems mounted 
with noatime to insure no disturbances.  I also set the IO scheduler to 
noop, otherwise the default scheduler reordered the IO requests which 
was not good for sequential throughput.  I used commands like this:

sync
dd bs=512 count=1 iflag=direct if=/dev/sda of=/dev/null
dd bs=512 count=1 iflag=direct if=/dev/sdb of=/dev/null
time dd bs=128KiB count=32768 iflag=direct if=/dev/mapper/via_hfciifae 
of=/dev/null

The first two commands were to make sure the drive head was on track 
zero, otherwise the TCQ on the drives kicked in and reordered some of 
the earlier reads as the head seeked to track zero.

The results show a rather large increase in throughput for block sizes 
under 128 KB, with a smaller improvement on larger block size. 
Likewise, the cpu time used was significantly lower, especially with 
block sizes less than 128 KB.  In most cases, the original dd uses 2-3 
times more cpu time than the aio dd.

The original dd reached near peak throughput ( 93.4 MB/s ) at a block 
size of 128 KB.  I believe this is due in part to that being the stripe 
width of the array, so smaller block sizes did not keep both drives 
operating full time.  In contrast all of the aio trials reached peak 
throughput of 97.x MB/s with a block size of only 32 KB, and at the 
smallest block size of 16 KB, the aio(16) trial managed more than 20% 
higher throughput than the non aio dd ( 72.1 vs  59.7 MB/s ), and did so 
using 1/7th the cpu time.

To show the difference O_DIRECT makes, at 128 KB block size the original 
dd with O_DIRECT managed 93.4 MB/s using 0.906 seconds of CPU time. 
Without O_DIRECT, the original dd only sustains 82.6 MB/s and uses a 
whopping 2.912 seconds of cpu time, or more than triple the time without 
O_DIRECT, and 13x more cpu time than the aio(4) test at that block size!

Kenny Simpson wrote:
> --- Phillip Susi <psusi@cfl.rr.com> wrote:
> 
>>I actually hacked up dd to use async IO ( via io_submit ) in conjunction 
>>with O_DIRECT and it did noticeably improve ( ~10% ish ) both throughput 
>>and cpu utilization.  I have an OO.o spreadsheet showing the results of 
>>some simple benchmarking with various parameters I did at home, which I 
>>will post later this evening. 
>>
>>Of course, dd is a simplistic case of sequential IO.  If you have 
>>something like a big database that needs to concurrently handle dozens 
>>or hundreds of random IO requests at once, O_DIRECT async IO is 
>>definitely going to be a clear winner. 
> 
> 
> The part I am writing looks like a transaction log writer:
>   Lots of sequential small-ish writes (call each quanta a transaction)
>   Must be written to stable storage
>   Must know when the writes are completed
>   The data is only read back for recovery processing
> 
>   In the past, the way I found to have worked best is to have a dedicated thread pulling
> transactions off a queue and doing the blocking syncronous writes either by write(v)/fsync or
> write(v) on a file opened with O_SYNC | O_DIRECT.  Once the fsync returned, the thread would
> signal completion and grab the next batch to start writing.
>   This works very well and can easily max out any real device's bandwidth, but incurs more latency
> than should be absolutely needed due to the extra context switching from the completion
> signalling.
> 
>   I am hoping AIO can be used to reduce the latency, but was a bit discouraged after reading the
> IBM paper.
> 
>   I am looking forward to your post reguarding dd.
> 
> thanks,
> -Kenny
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

