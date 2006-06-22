Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWFVLnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWFVLnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWFVLnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:43:42 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:50980 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1161085AbWFVLnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:43:41 -0400
Message-ID: <449A8264.8000507@de.ibm.com>
Date: Thu, 22 Jun 2006 13:43:32 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: artusemrys@sbcglobal.net
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, greg@kroah.com, akpm@osdl.org,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: statistics infrastructure (in -mm tree) review
References: <20060613232131.GA30196@kroah.com>	 <20060613234739.GA30534@kroah.com>	 <20060613171827.73cd0688.rdunlap@xenotime.net> <4490923D.10904@de.ibm.com>	 <20060619221238.GA20018@kroah.com> <449816D1.3040104@de.ibm.com>	 <20060620095015.532901b4.rdunlap@xenotime.net> <1150915877.2938.133.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <4499A030.8020106@sbcglobal.net>
In-Reply-To: <4499A030.8020106@sbcglobal.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Frost wrote:
> Martin Peschke wrote:
>> On Tue, 2006-06-20 at 09:50 -0700, Randy.Dunlap wrote:
>>> On Tue, 20 Jun 2006 17:40:01 +0200 Martin Peschke wrote:
>>>> Greg KH wrote:
>>>>>> 7) With regard to the delivery of statistic data to user land,
>>>>>> a library maintaining statistic counters, histograms or whatever
>>>>>> on behalf of exploiters doesn't need any help from the exploiter.
>>>>>> We can avoid the usual callbacks and code bloat in exploiters
>>>>>> this way.
>>>>> I don't really understand what you are stating here.
>>>> Sorry.
>>>> 1,$s/exploiter/client/g
>>>>
>>>> Any device driver or whatever gathering statistics data currently
>>>> has code dealing with showing the data. Usually, they have some
>>>> callbacks for procfs, sysfs or whatever.
>>>>
>>>> My point is that, if a library keeps track of statistics on behalf
>>>> of its clients, no client needs to be called back in order to
>>>> merge, format, copy, etc. data being shown to users. The library
>>>> can handle as a background operation without disturbing clients.
>>> That could be a good thing.  OTOH, it means that the library
>>> has to be either all-ways flexible or willing to change to
>>> accommodate clients since you can't predict the universe of all
>>> clients' requirements.
>>
>> Right. I have made provisions for that to some degree.
>>
>>
>> First, I could imagine that the statistics data of a client requires
>> a new way its data should be aggregated and, therewith, requires
>> a new form of statistic result being shown to users.
>>
>> I have scanned through the kernel sources for ways of aggregating
>> and showing statistics data. The usual constructs appear to be:
>>
>> - counter
>> - histogram (for intervals), linear scale
>> - histogram (for intervals), logarithmic scale
>> - "histogram" for discrete and sparse values
>> - "utilisation indicator" or "fill level indicator" (num-min-avg-max)
>>
>> These are implemented in my patches. I would expect these to cover most
>> requirements of possible new clients.
> 
> So you're saying, as regards "putting presentation format in ... the 
> kernel", that we already have presentation formats specified pell-mell 
> in the kernel.  That should then be a non-issue, because you aren't 
> introducing anything new, just centralizing an existing kernel behavior. 
>  Do I have you right?

Yes, there seem to be as many formats as statistics. See examples below.
My patches can help to improve usuability by providing some common basic
formats.

IMO, it would not make sense to "enhance" the statistics library in an
attempt to emulate all the preexisting statistic output formats.

[root@t2930041 ~]# cat /proc/dasd/statistics
31 dasd I/O requests
with 392 sectors(512B each)
    __<4    ___8    __16    __32    __64    _128    _256    _512    __1k
    __2k    __4k    __8k    _16k    _32k    _64k    128k
    _256    _512    __1M    __2M    __4M    __8M    _16M    _32M    _64M
    128M    256M    512M    __1G    __2G    __4G    _>4G
Histogram of sizes (512B secs)
       0       0      21       7       3       0       0       0       0
       0       0       0       0       0       0       0
       0       0       0       0       0       0       0       0       0
       0       0       0       0       0       0       0
Histogram of I/O times (microseconds)
       0       0       0       0       0       0       0       3       6
       1       5       6      10       0       0       0
       0       0       0       0       0       0       0       0       0
       0       0       0       0       0       0       0
<snip>

[root@t2930041 ~]# cat /proc/diskstats
<snip>
   94    0 dasda 67389 1478 1142520 281080 78260 461181 4326752 10280570
  0 6392030 10565980
   94    1 dasda1 68849 1142272 540838 4326704
   94    4 dasdb 27 29 448 0 0 0 0 0 0 0 0
   94    5 dasdb1 27 216 0 0
   94    8 dasdc 28 29 456 40 0 0 0 0 0 30 40
   94    9 dasdc1 28 224 0 0
    9    0 md0 0 0 0 0 0 0 0 0 0 0 0
    8    0 sda 35423 12268 4340826 284540 8605 275966 2276792 980810
  0 219260 1265370
    8   16 sdb 36741 12626 4588754 293140 10090 277678 2302400 440010
  0 221990 733140
    8   32 sdc 36621 11748 4548722 298170 10394 272680 2264736 303580
  0 223110 601730

[root@t2930041 ~]# cat /proc/net/stat/arp_cache
entries  allocs destroys hash_grows  lookups hits  res_failed
rcv_probes_mcast rcv_probes_ucast  periodic_gc_runs forced_gc_runs
00000002  0000002c 000000cd 00000000  00000082 00000056
00000000  00000000 00000000  00017306 00000000
00000002  00000031 00000000 00000000  0000007d 0000004c
00000000  00000000 00000000  00000000 00000000
00000002  0000002f 00000000 00000001  00000074 00000045
00000000  00000000 00000000  00000000 00000000
00000002  00000043 00000000 00000000  00000084 00000041
00000000  00000000 00000000  00000000 00000000

>> If another construct would be needed anyway, it can be added to the
>> statistics library by implemententing about half a dozen routines
>> described by struct statistic_discipline. I might be wrong, but I don't
>> think we would see an inflationary growth there.
>>
>>
> -- elision --
>>
>> OTOH, I don't see a real need for allowing that. Data can be reformatted
>> and rearranged in any possible way in user space.
> 
> Because you're just providing a range of basic output formats, 
> standardized.  So anybody can ask for statistics from the kernel in a 
> preferred output to then massage as needed in userland.  ACK?  Am I 
> oversimplifying?

Sounds reasonable.

Thanks, Martin

