Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbULJQDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbULJQDu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbULJQCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:02:52 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:16611 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261738AbULJP7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:59:38 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Date: Fri, 10 Dec 2004 10:59:32 -0500
User-Agent: KMail/1.7
Cc: Ingo Molnar <mingo@elte.hu>, Mark_H_Johnson@raytheon.com,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
References: <OF8ABCEBAC.0259E37D-ON86256F65.00727E98@raytheon.com> <20041210105352.GA4749@elte.hu> <200412100959.04829.gene.heskett@verizon.net>
In-Reply-To: <200412100959.04829.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200412101059.35446.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.42.94] at Fri, 10 Dec 2004 09:59:36 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 December 2004 09:59, Gene Heskett wrote:
>On Friday 10 December 2004 05:53, Ingo Molnar wrote:
>>* Ingo Molnar <mingo@elte.hu> wrote:
>>> this smells too. [...]
>
>Humm, something else does too Ingo.  Amanda failed on this
>machine last night, and so did an amcheck just now, returning this:
>
>[amanda@coyote driver]$ amcheck Daily
>Amanda Tape Server Host Check
>-----------------------------
>Holding disk /dumps: 26444 MB disk space available, using 25944 MB
>amcheck-server: slot 8: date 20041210 label Dailys-8 (active tape)
>amcheck-server: slot 9: date 20041124 label Dailys-9 (exact label
>match)
>NOTE: skipping tape-writable test
>Tape Dailys-9 label ok
>Server check took 0.386 seconds
>
>Amanda Backup Client Hosts Check
>--------------------------------
>WARNING: coyote: selfcheck reply timed out.
>Client check: 2 hosts checked in 22.199 seconds, 1 problem found
>
>(brought to you by Amanda 2.4.5b1-20041122)
>------------------
>This was while running 32-12, which otherwise feels good and gave
>me no other indication of a problem.  I've also looked at the log,
>but its silent on this subject.  I'll get the latest and try it.

Ok, the 32-18 is up and running, and it appears that amanda is not
so unhappy now as I seem to have a hand launched session thats
running nominally now.

To toss in a few more items, I noted that I had several copies of
amandad, and a copy of self-check that were getting 0 cpu according
to htop.  They were killable however, and re-running the amcheck
again left them behind.

Another factoid.  kpm, the kde version of htop, was unable to
display a process table listing while -12 was running.

32-18 seems to have restored all those to normal.

Is there a way I can run tvtime without making /var/log/messages
bigger by about 20k a minute with those 3 line reports it
apparently spits out for every frame of tv?  These patches aren't
apparently doing anything for the problem one way or the other, so
AFAIAC the constant flow messages are a waste of time and may even
be causing their own problem with the constant traffic to the
logfile..

>
>>found two brown-paperbag bugs that caused bad latencies in the -RT
>>kernel: when i added PREEMPT_DIRECT (which first showed up in
>> -32-10) i also added a missed-reschedule bug to try_to_wake_up()
>> and to mutex/semaphore-unlock (__up()). Oops.
>>
>>i dont think this bug could explain a msec-range latency because
>> the syscall return path should catch the missed reschedule and it
>> would need continuous syscall execution in the milliseconds range
>> by a lowprio task for a latency to be transported to latencytest,
>> but certainly the bug doesnt help latencies. The -32-15 kernel can
>> be downloaded from the usual place:
>>
>> http://redhat.com/~mingo/realtime-preempt/
>>
>>other changes in -32-15: more work on the tracer, cleaner trace
>> output and the tracing of syscall entries and returns, with
>> arguments and return values displayed as well (i.e. a simple
>> strace variant). Here is how a syscall now looks like in
>> /proc/latency_trace:
>>
>> loop-tes-3885  0....  100µs > sys_getppid (002fcffc 00000001
>> 0000007b) loop-tes-3885  0....  101µs+: sys_getppid
>> (sysenter_past_esp) loop-tes-3885  0d...  103µs < (3868)
>>
>>'< (return-val)' is the syscall return value, '> sys_name(params)'
>> is the syscall itself. (note that the return path is also used by
>> interrupts, so it's not purely a syscall-return point) This makes
>> it easier to track userspace execution.
>>
>> Ingo
>>-
>>To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to
>> majordomo@vger.kernel.org More majordomo info at 
>> http://vger.kernel.org/majordomo-info.html Please read the FAQ at 
>> http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.

