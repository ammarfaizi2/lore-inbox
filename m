Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263846AbTJ1HNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 02:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTJ1HNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 02:13:08 -0500
Received: from zeus.kernel.org ([204.152.189.113]:37858 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263846AbTJ1HND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 02:13:03 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
Date: Tue, 28 Oct 2003 14:11:20 +0800
User-Agent: KMail/1.5.2
Cc: cliff white <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
       Nigel Cunningham <ncunningham@clear.net.nz>
References: <200310261201.14719.mhf@linuxmail.org> <200310281213.31709.mhf@linuxmail.org> <3F9DF0D3.60707@cyberone.com.au>
In-Reply-To: <3F9DF0D3.60707@cyberone.com.au>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310281411.20165.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 October 2003 12:30, Nick Piggin wrote:
> 
> Michael Frank wrote:
> 
> >On Tuesday 28 October 2003 07:50, Nick Piggin wrote:
> >
> >>cliff white wrote:
> >>
> >>
> >>>On Tue, 28 Oct 2003 05:52:45 +0800
> >>>Michael Frank <mhf@linuxmail.org> wrote:
> >>>
> >>>
> >>>
> >>>>To my surprise 2.6 - which used to do better then 2.4 - does no longer 
> >>>>handle these test that well.
> >>>>
> >>>>Generally, IDE IO throughput is _very_ uneven and IO _stops_ at times with the
> >>>>system cpu load very high (and the disk LED off).
> >>>>
> >>>>IMHO the CPU scheduling is OK but the IO scheduling acts up here.
> >>>>
> >>>>The test system is a 2.4GHz P4 with 512M RAM and a 55MB/s udma IDE harddisk.
> >>>>
> >>>>The tests load the system to loadavg > 30. IO should be about 20MB/s on avg.
> >>>>
> >>>>Enclosed are vmstat -1 logs for 2.6-test9-Vanilla, followed by 2.6-test8-Vanilla 
> >>>>(-mm1 behaves similar), 2.4.22-Vanilla and 2.4.21+swsusp all compiled wo preempt.
> >>>>
> >>>>IO on 2.6 stops now for seconds at a time. -test8 is worse than -test9
> >>>>
> >>>>
> >>>We see the same delta at OSDL. Try repeating your tests with 'elevator=deadline' 
> >>>to confirm.
> >>>For example, on the 8-cpu platform:
> >>>STP id Kernel Name         MaxJPM      Change  Options
> >>>281669 linux-2.6.0-test8   7014.42      0.0    
> >>>281671 linux-2.6.0-test8   8294.94     +18.26%  elevator=deadline
> >>>
> >>>The -mm kernels don't show this big delta. We also do not see this delta on
> >>>smaller machines
> >>>
> >>>
> >>I'm working with Randy to fix this. Attached is what I have so far. See how
> >>you go with it.
> >>
> >>
> >>
> >
> >This has been done without running a kernel compile, by $ ti-tests/ti stat ub17 ddw 4 5000
> >
> >Seems to be more even on average but still drops IO too low and then gets overloaded. 
> >
> >By "too low" I mean io bo less than 10000.
> >
> >By overloaded I mean io bo goes much above 40000. The disk can do maybe 60000. 
> >
> >When io bo is much above 40000, cpu scheduling is being impaired as indicated
> >by vmstat stopping output for a second or so...
> >
> 
> The bi / bo fields in vmstat aren't exactly what the disk is doing, rather
> the requests the queue is taking. The interesting thing is how your final
> measurement compares with 2.4.

Well this is one easy "measurement", an other being hooking up an oscilloscope
to IDE - might do that actually as well ;)

Anyway, what matters is the user side. IO intensive tasks are the most affected. 
Running on $ ti stat ddw 4 5000, any one out of 4 ddd's gets locked  out at times 
for several seconds. This was a problem on 2.4 with 2.4.18 - 2.4.20 and is 
fixed again since 2.4.21 while at that time the focus was more on general 
interactivity with regard to desktop use.

Going to improve the time info output of the ddd loops to get better data and 
provide a comparison of -test9 with 2.4.22 and 2.4.23-pre-latest within a 
few days.

> 
> I think 2.4 has quite a lot more free requests by default (512 vs 128 for
> 2.6). This might also be causing Nigel's writeout problems perhaps. Try
> echo 512 > /sys/block/xxx/queue/nr_requests
> 

Superficially, the effect between 128 up to 2048 is insignificant.
The effect down to the minimum of 4 is noticable both in userspace 
and with physical disk activity.

BTW, with the patch the hang reported earlier was not encountered again so 
far, but this needs more testing. Is this an anticipated or side-effect 
of the patch?

Regards
Michael

