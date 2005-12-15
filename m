Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVLORsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVLORsA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVLORr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:47:59 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:11441 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750854AbVLORr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:47:58 -0500
Message-ID: <43A1AC43.9050005@de.ibm.com>
Date: Thu, 15 Dec 2005 18:47:47 +0100
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James.Smart@Emulex.Com
CC: arjan@infradead.org, linux-scsi@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Re: [patch 6/6] statistics infrastructure - exploitation: zfcp
References: <9BB4DECD4CFE6D43AA8EA8D768ED51C21D7BA6@xbl3.emulex.com>
In-Reply-To: <9BB4DECD4CFE6D43AA8EA8D768ED51C21D7BA6@xbl3.emulex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James.Smart@Emulex.Com wrote:

>This patch is right along the lines of what we did with this earlier patch
>http://marc.theaimsgroup.com/?l=linux-scsi&m=110700743207792&w=2
>which adds, at the sdev level, counters for # of requests performed,
># of requests completed, # of requests completed in error.
>
>of all the stats you propose:
>  
>
>>>+	struct statistic		*stat_sizes_scsi_write;
>>>+	struct statistic		*stat_sizes_scsi_read;
>>>+	struct statistic		*stat_sizes_scsi_nodata;
>>>+	struct statistic		*stat_sizes_scsi_nofit;
>>>+	struct statistic		*stat_sizes_scsi_nomem;
>>>+	struct statistic		*stat_sizes_timedout_write;
>>>+	struct statistic		*stat_sizes_timedout_read;
>>>+	struct statistic		*stat_sizes_timedout_nodata;
>>>+	struct statistic		*stat_latencies_scsi_write;
>>>+	struct statistic		*stat_latencies_scsi_read;
>>>+	struct statistic		*stat_latencies_scsi_nodata;
>>>+	struct statistic		*stat_pending_scsi_write;
>>>+	struct statistic		*stat_pending_scsi_read;
>>>+	struct statistic		*stat_erp;
>>>+	struct statistic		*stat_eh_reset;
>>>      
>>>
>
>All of these are best served to be managed by the midlayer at the
>sdev.
>
Yes.

>Please don't make the LLDDs do the incrementing, etc
>
Though this has been my initial (cautious) attempt, I won't object to 
moving things up one layer or two.

>- or something
>that is owned by one layer, modified by another, and bounces back and forth.
>  
>
I try to avoid that.

>The only question is the latency fields, as your statement on latency is a
>good one. IMHO, the latency that matters is the latency the midlayer sees
>when it calls queuecommand.  The LLDD interface is designed to not queue in
>the LLDD's, and you really can't peek lower than the LLDD to know when the
>i/o actually hits the wire. So - just measure at the queuecommand/scsidone level
>(or up in the block request queue level).
>  
>
I agree. For now, I tend to stick to queuecommand/scsi_done.

>And, if we are expanding stats from the earlier 3 things, we ought to follow
>the framework the fc transport used for stats (stolen from the network world)
>and create a subdirectory under the /sys/block/<>/ object that reports
>the stats.
>  
>
Well, I am not yet convinced that sysfs is necessarily the answer for 
this, because of the one value per file policy,
which is fine for some purposes, but not for potentially larger amounts 
of data, or data where the number of values comprising the statistic is 
variable.

In general, I see a statistic as something that can be more than a 
single counter. It can be a histogram, or a counter over time in the 
form of a history buffer.
Certainly we could split up every histogram, fill level indicator, 
megabytes-per-seconds-like statistic and so on. But I think that would 
result in nasty directory structures which would impose effort to 
collect the data available for one entitity like.

My output in debugfs currently looks like this:

 latencies_scsi_write <=0 0
 latencies_scsi_write <=1 0
 latencies_scsi_write <=2 0
 latencies_scsi_write <=4 174
 latencies_scsi_write <=8 872
 latencies_scsi_write <=16 2555
 latencies_scsi_write <=32 2483
 ...
 latencies_scsi_write <=1024 1872
 latencies_scsi_write >1024 1637

 latencies_scsi_read <=0 0
 latencies_scsi_read <=1 0
 latencies_scsi_read <=2 0
 latencies_scsi_read <=4 57265
 latencies_scsi_read <=8 13610
 latencies_scsi_read <=16 1082
 latencies_scsi_read <=32 319
 latencies_scsi_read <=64 63
 ...
 latencies_scsi_read >1024 0

 ...
 util_qdio_outb [3097394.211992] 865 1 1.052 5
 util_qdio_outb [3097395.211992] 737 1 4.558 125
 util_qdio_outb [3097396.211992] 396 1 11.765 77
 util_qdio_outb [3097397.211992] 270 1 12.863 128
 util_qdio_outb [3097398.211992] 765 1 7.271 26
 util_qdio_outb [3097399.211992] 577 1 4.036 27
 ...

I like it, because it can be read easily; it can be grep-ed; a simple 
(generic) script could generate whatever output format is required from 
whatever statistic is given.

The meaning of a value is not so much determined by its position in the 
file but by preceding tags. There are a few generic rules on how a 
histogram or a fill level indicator looks like. That's basically all a 
user (or a script) needs to know in order to be able to read a 
networking related histogram, or a disk I/O related histogram, or any 
other histogram.

Besides, I'd like to allow users to customize statistics to some degree. 
If a user needs to tune, say, a histogram to provide a better 
resolution, then the number of buckets might be changed form 5 to 20, 
resulting in longer output. Then the position of a counter is not 
sufficient to determine which range of values it stands for. Counter #4 
out of 5 probably has a different meaning than counter #4 out of 20. 
That is why I propose to label buckets or counters appropriately (see 
above). I doubt this can be reflected in sysfs without too much pain.

An then there is relayfs, mentioned by Andy Kleen. I guess, what it is 
meant to be good at is quite opposite to what sysfs does for us. Still 
it looks appropriate for some statistics, not necessarily for all forms 
of output - similar issue as with sysfs.
So far, neither of them seems to be a perfect fit, and, IMO, debugfs 
looks like a feasible alternative. But the question of which fs to chose 
probably depends on how we define a statistic and on which ways of 
in-kernel data processing and corresponding output formats we agree on.

Martin

