Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTBJUFM>; Mon, 10 Feb 2003 15:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262871AbTBJUFM>; Mon, 10 Feb 2003 15:05:12 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:4055 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S262821AbTBJUFJ>;
	Mon, 10 Feb 2003 15:05:09 -0500
Message-ID: <3E48083E.6000901@namesys.com>
Date: Mon, 10 Feb 2003 23:14:54 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andrew Morton <akpm@digeo.com>, piggin@cyberone.com.au,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3
 / aa / rmap with contest]
References: <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com> <20030210120916.GD31401@dualathlon.random> <3E47A1E5.6020902@namesys.com> <20030210131858.GP31401@dualathlon.random>
In-Reply-To: <20030210131858.GP31401@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:

>On Mon, Feb 10, 2003 at 03:58:13PM +0300, Hans Reiser wrote:
>  
>
>>Is the following a fair summary?
>>
>>There is a certain minimum size required for the IOs to be cost 
>>effective.  This can be determined by single reader benchmarking.  Only 
>>readahead and not anticipatory scheduling addresses that.
>>
>>Anticipatory scheduling does not address the application that spends one 
>>minute processing every read that it makes.  Readahead does.
>>
>>Anticipatory scheduling does address the application that reads multiple 
>>files that are near each other (because they are in the same directory), 
>>and current readahead implementations (excepting reiser4 in progress 
>>vaporware) do not.
>>
>>Anticipatory scheduling can do a better job of avoiding unnecessary 
>>reads for workloads with small time gaps between reads than readahead 
>>(it is potentially more accurate for some workloads).
>>
>>Is this a fair summary?
>>    
>>
>
>I would also add what I feel the most important thing, that is
>anticipatory scheduling can help decreasing a lot the latencies of
>filesystem reads in presence of lots of misc I/O, by knowing which are
>the read commands that are intermediate-dependent-sync, that means
>knowing a new dependent read will be submitted very quickly as soon as
>the current read-I/O is completed.
>
Ah.... yes...  I have seen that be a problem, and reiserfs suffers from 
it more than ext2....

maybe we should simply have an explicit protocol for that...  I would be 
quite willing to have reiserfs use some flag that says 
WILL_READ_NEARBY_NEXT whenever it reads an internal node to get the 
location of its children....  that might be a lot cleaner than trying to 
do it all in your layer...  what do you guys think...

Perhaps it will be both less code, and a better result in that it avoids 
some unnecessary lingering....

> In such a case it makes lots sense to
>wait for the next read to be submitted instead of start processing
>immediatly the rest of the I/O queue.  This way when you read a file and
>you've to walk the indirect blocks before being able to read the data,
>you won't be greatly peanalized against the writes or reads that won't
>need to pass through metadata I/O before being served.
>
>This doesn't obviate the need of SFQ for the patological multimedia
>cases where I/O latency is the first prio, or for workloads where
>sync-write latency is the first prio.
>
>BTW, I'm also thinking that the SFQ could be selected not system wide,
>but per-process basis, with a prctl or something, so you could have all
>the I/O going into the single default async-io queue, except for mplayer
>that will use the SFQ queues. This may not even need to be privilegied
>since SFQ is fair and if an user can write a lot it can just hurt
>latency, with SFQ could hurt more but still not deadlock. This SFQ prctl
>for the I/O scheduler, would be very similar to the RT policy for the
>main process scheduler. Infact it maybe the best to just have SFQ always
>enabled, and selectable only via the SFQ prctl, and to enable the
>functionaltiy only per-process basis rather than global. We can still
>add a sysctl to enable it globally despite nobody set the per-process
>flag.
>
>Andrea
>
>
>  
>
I still don't really understand your SFQ design, probably because I 
haven't studied recent networking algorithms that your description 
assumed I understand.

-- 
Hans


