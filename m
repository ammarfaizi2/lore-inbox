Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUJRWtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUJRWtj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUJRWtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:49:18 -0400
Received: from fmr05.intel.com ([134.134.136.6]:41144 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S267743AbUJRWsn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:48:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cpufreq_ondemand
Date: Mon, 18 Oct 2004 15:48:28 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB60031DA62A@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpufreq_ondemand
Thread-Index: AcS05DDcd8rTaTI/SQqZ4oU+pwmMYwAfIaXQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Dominik Brodowski" <linux@dominikbrodowski.de>,
       "Alexander Clouter" <alex-kernel@digriz.org.uk>
Cc: <cpufreq@www.linux.org.uk>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Oct 2004 22:48:29.0618 (UTC) FILETIME=[964CA920:01C4B564]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From:       Alexander Clouter <alex-kernel () digriz ! org ! uk>
>Date:       2004-10-17 22:29:16
>Message-ID: <20041017222916.GA30841 () inskipp ! digriz ! org ! uk>
>[Download message RAW]
>
>[Attachment #2 (multipart/mixed)]
>
>
>Hi all,
>
>After playing with the cpufreq_ondemand governor (many thanks 
>to those whom 
>made it) I made a number of alterations which suit me at 
>least.  Really 
>looking for feedback and of course once people have fixed any 
>bugs they find 
>and made the code look neater, possible inclusion?
>
>The improvements (well I think they are) I have made:
>
>1. I have replaced the algoritm it used to one which 
>calculates the number of
>	cpu idle cycles that have passed and compares it to the 
>number of cpu
>	cycles it would have expected to pass (for, the 
>defaults, 20%/80%)
>
>	this means a couple of divisions have been removed, 
>which is always 
>	nice and it lead to clearer code (for me at least), that was 
>	until I added the handful of 'if' conditionals though.... :-/


Good idea. This part of the patch has to go into ondemand governor.
But, I think there is a minor bug in the code though.
With current ondemand governor, we poll at some X freq and check 
whether we need to increase the freq. And with some Y freq (Y > X and 
a multiple of it), we check whether we need to decrase the freq.
That is the reason I have two different variables 
prev_cpu_idle_down and prev_cpu_idle_up to store the previous idle 
times at these two different polling intervals (X and Y).
Now, you have previous idle time at only one point. So, this may 
not work cleanly. From the code I feel what will happen is
You will only see the CPU activity in last X time and decide on 
frequency down decisions (even though you check this with Y polling 
interval). Not sure whether I was clear with this explanation.

Note, I haven't really run your version yet. This is what 
I feel by looking at the patch. I may well be wrong.

> 2. controllable through 
>	/sys/.../ondemand/ignore_nice, you can tell it to 
>consider 'nice' 
>	time as also idle cpu cycles.  Set it to '1' to treat 
>'nice' as cpu 
>	in an active state.
>

OK. This has to be in ondemand governor as well.

>3. (major) the scaling up and down of the cpufreq is now 
>smoother.  I found 
>	it really nasty that if it tripped < 20% idle time that 
>the freq was 
>	set to 100%.  This code smoothly increases the cpufreq 
>as well as 
>	doing a better job of decreasing it too
>
>4. (minor) I changed DEF_SAMPLING_RATE_LATENCY_MULTIPLIER to 50000 and
>	DEF_SAMPLING_DOWN_FACTOR to 5 as I found the defaults a 
>bit annoying 
>	on my system and resulted in the cpufreq constantly jumping.
>
>	For my patch it works far better if the sampling rate 
>is much lower 
>	anyway, which can only be good for cpu efficiency in 
>the long run

Somehow, I feel quick response time for increased load is more 
important than smooth increase in frequency. As the CPU latency for 
doing the freq transition is lower, I think governor should use that 
and do quick adjustments to the freq depending on the load. Probably, I 
am thinking more in terms of places where performance is critical.
As Dominik pointed out, it's the time to fork put a new ondemand 
governor with this algorithm....

>5. the grainity of how much cpufreq is increased or decreased 
>is controlled 
>	with sending a percentage to /sys/.../ondemand/freq_step_percent
>
>6. debugging (with 'watch -n1 cat 
>/sys/.../ondemand/requested_freq') and 
>	backwards 'compatibility' to act like the 'userspace' 
>governor is 
>	avaliable with /sys/.../ondemand/requested_freq if 
>	'freq_step_percent' is set to zero

I again agree with Dominik's opinion on this :)

Thanks for all the experiments and all these improvements.
I will rollout a patch for ondemand governor soon, by 
stealing some code from your patch below :)

Thanks,
Venki

