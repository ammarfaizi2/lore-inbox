Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbTJ1EiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 23:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbTJ1EiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 23:38:21 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:64913 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263852AbTJ1EiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 23:38:19 -0500
Message-ID: <3F9DF0D3.60707@cyberone.com.au>
Date: Tue, 28 Oct 2003 15:30:11 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Frank <mhf@linuxmail.org>
CC: cliff white <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
       Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
References: <200310261201.14719.mhf@linuxmail.org> <20031027145531.2eb01017.cliffw@osdl.org> <3F9DAF2C.8010308@cyberone.com.au> <200310281213.31709.mhf@linuxmail.org>
In-Reply-To: <200310281213.31709.mhf@linuxmail.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Michael Frank wrote:

>On Tuesday 28 October 2003 07:50, Nick Piggin wrote:
>
>>cliff white wrote:
>>
>>
>>>On Tue, 28 Oct 2003 05:52:45 +0800
>>>Michael Frank <mhf@linuxmail.org> wrote:
>>>
>>>
>>>
>>>>To my surprise 2.6 - which used to do better then 2.4 - does no longer 
>>>>handle these test that well.
>>>>
>>>>Generally, IDE IO throughput is _very_ uneven and IO _stops_ at times with the
>>>>system cpu load very high (and the disk LED off).
>>>>
>>>>IMHO the CPU scheduling is OK but the IO scheduling acts up here.
>>>>
>>>>The test system is a 2.4GHz P4 with 512M RAM and a 55MB/s udma IDE harddisk.
>>>>
>>>>The tests load the system to loadavg > 30. IO should be about 20MB/s on avg.
>>>>
>>>>Enclosed are vmstat -1 logs for 2.6-test9-Vanilla, followed by 2.6-test8-Vanilla 
>>>>(-mm1 behaves similar), 2.4.22-Vanilla and 2.4.21+swsusp all compiled wo preempt.
>>>>
>>>>IO on 2.6 stops now for seconds at a time. -test8 is worse than -test9
>>>>
>>>>
>>>We see the same delta at OSDL. Try repeating your tests with 'elevator=deadline' 
>>>to confirm.
>>>For example, on the 8-cpu platform:
>>>STP id Kernel Name         MaxJPM      Change  Options
>>>281669 linux-2.6.0-test8   7014.42      0.0    
>>>281671 linux-2.6.0-test8   8294.94     +18.26%  elevator=deadline
>>>
>>>The -mm kernels don't show this big delta. We also do not see this delta on
>>>smaller machines
>>>
>>>
>>I'm working with Randy to fix this. Attached is what I have so far. See how
>>you go with it.
>>
>>
>>
>
>This has been done without running a kernel compile, by $ ti-tests/ti stat ub17 ddw 4 5000
>
>Seems to be more even on average but still drops IO too low and then gets overloaded. 
>
>By "too low" I mean io bo less than 10000.
>
>By overloaded I mean io bo goes much above 40000. The disk can do maybe 60000. 
>
>When io bo is much above 40000, cpu scheduling is being impaired as indicated
>by vmstat stopping output for a second or so...
>

The bi / bo fields in vmstat aren't exactly what the disk is doing, rather
the requests the queue is taking. The interesting thing is how your final
measurement compares with 2.4.

I think 2.4 has quite a lot more free requests by default (512 vs 128 for
2.6). This might also be causing Nigel's writeout problems perhaps. Try
echo 512 > /sys/block/xxx/queue/nr_requests


