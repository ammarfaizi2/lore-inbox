Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVC1P4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVC1P4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 10:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVC1P4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 10:56:50 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:22024 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261879AbVC1P4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 10:56:44 -0500
Date: Mon, 28 Mar 2005 17:55:54 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Eric Bambach <eric@cisu.net>
Cc: mingo@elte.hu, kernel@kolivas.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Scheduler latency measurements on 2.6.11.6
Message-ID: <20050328155554.GA2252@pcw.home.local>
References: <20050328141449.GA2216@pcw.home.local> <200503280921.03851.eric@cisu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503280921.03851.eric@cisu.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 09:21:03AM -0600, Eric Bambach wrote:
> No-where in your mail, unless I missed it because i've been awake for 15 
> minutes now, do you mention pre-emption. One of the major latency affecting 
> differences between 2.4 and 2.6 is the introduction of pre-emption and with 
> 2.6.10(ish?) you can pre-empt the big kernel lock.

Sorry, you're perfectly right. I wanted to precise this first, but I forgot
it during the mail.

The reports below were obtained with CONFIG_PREEMPT and CONFIG_PREEMPT_BLK,
but the server on which I encountered the problems first is SMP without
PREEMPT. It is more difficult to get reproducable results on SMP, that's
why I launched the tests on the notebook.

> Since you are experiencing odd latencies w.r.t. syscalls, pre-emption is a 
> major point to look at. In fact, the JACK and RT Linux people are working on 
> problems similiar to this right now. If your program for whatever reason has 
> *hard-time* latency requirements then I suggest you look at the Realtime 
> Patches for Linux 2.6.

Well, I don't need such a perfect latency, the one in Linux 2.4 was
more than enough. I can even bear several tens of ms or even occasionally
a few hundreds ms, but freezing several *seconds* regularly becomes a
real problem, particularly when the process freezes longer than the
application timeouts permit !

> I would suggest you try a few more test with various combinations of 
> pre-emption. The consesus in the documentation seems to be that pre-emption  
> make desktops only feel snappier and "real" workloads will suffer as a 
> result.

I've just finished rebuilding the kernel without PREEMPT, I first left it
enabled by accident. I've already noticed in 2.4+preempt that it sometimes
increased the time taken by certain types of processing.

Here's a new test with 2 simultaneous 'lat3 1000000' (loop 1 second then
sleep 1 ms) :

P: Date_sec.usec   select    loop  maxlat    nbmax

2: 1112024537.278       0 1000000      51       0
2: 1112024538.279     463 1000000   24648       1
2: 1112024539.279     787 1000000      51       0
2: 1112024540.280     793 1000000      82       0
2: 1112024541.281     790 1000000      51       0
2: 1112024542.282     793 1000000    8307       0
2: 1112024543.283     840 1000000    7973       0
2: 1112024544.284     840 1000000      51       0
2: 1112024545.284     841 1000000      51       0
2: 1112024546.285     839 1000000      51       0
2: 1112024547.286     840 1000000      51       0
1: 1112024548.428       0 1000006      51       0
2: 1112024548.428     841 1140890 1000597       1
1: 1112024550.034     939 1604916 1000021       1
2: 1112024550.034  605834 1000000      51       0
2: 1112024551.035     842 1000000      51       0
1: 1112024552.184 1000794 1149662  249973       1
1: 1112024553.784  599853 1000000      51       0
2: 1112024553.784  899702 1849928 1000059       1
1: 1112024555.485     795 1699739  899864       1
2: 1112024555.925  800662 1339834  399940       1
1: 1112024557.425   39976 1899874 1000060       1
2: 1112024557.425  499918 1000000      51       0
1: 1112024559.185  760628 1000000      51       0
2: 1112024559.185     804 1759937 1000067       1
1: 1112024560.886     796 1699739  899864       1
2: 1112024561.326  800665 1339795  399950       1
1: 1112024562.826   39938 1899873 1000011       1
2: 1112024562.826  499917 1000000      51       0
1: 1112024564.587  760668 1000000    8282       0
2: 1112024564.587     843 1759890 1000020       1
1: 1112024566.295     844 1707737  899874       1
2: 1112024566.635  808661 1239812  299966       1
1: 1112024568.235   39986 1899922 1000059       1
2: 1112024568.235  599854 1000000      51       0
1: 1112024569.996  760668 1000000      51       0
2: 1112024569.996     794 1759893 1000012       1
1: 1112024571.704     842 1707737  899874       1
2: 1112024572.304  808659 1500056  560210       1
2: 1112024573.305     711 1000000      51       0

I've just found something interesting when I run one process with a
1-second loop and another one in parallel with a 10-seconds loop. The
first process is heavily hindered each time the second one leaves the
select() : pauses of up to 2.5 seconds are observed, and I cannot
explain them as the max time_slice should be 800 ms. It's just as if
the second process could get 3 consecutive full time-slices + one
little :

P: Date_sec.usec   select    loop  maxlat    nbmax
1: 1112024838.490       0 1000000      52       0
1: 1112024839.491     510 1000000      51       0
1: 1112024840.492     793 1000000   24782       1
1: 1112024841.520     835 1027841  745569       2
1: 1112024842.620   99976 1000000    8287       0
1: 1112024843.621     791 1000000      51       0
1: 1112024844.628     793 1005846   99996       3
1: 1112024845.728   99930 1000000      56       0
1: 1112024846.729     792 1000000    8298       0
1: 1112024847.745     840 1015844   99996       3
1: 1112024848.746     945 1000000   99996       5
1: 1112024849.747     793 1000000   99996       5
2: 1112024850.645       0 10017626 1000070      26  => process2 sleeps
1: 1112024853.245     792 3496467 2499621       5
1: 1112024854.344   99929 1000000    8297       0
1: 1112024855.345     841 1000000    8308       0
1: 1112024856.362     792 1015845   99996       3
1: 1112024857.462   99930 1000000      51       0
1: 1112024858.463     793 1000000      51       0
1: 1112024859.464     793 1000000   99995       3
1: 1112024860.465     792 1000000   99996       5
2: 1112024860.721   99969 10016477 1000070      17  => process2 sleeps
1: 1112024863.361     793 2895559 2499631       2
1: 1112024864.461   99928 1000000      51       0

Regards,
Willy

