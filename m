Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbUKKEfN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbUKKEfN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 23:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbUKKEfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 23:35:13 -0500
Received: from relay03.pair.com ([209.68.5.17]:40464 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S262169AbUKKEey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 23:34:54 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <4192EBE9.60300@cybsft.com>
Date: Wed, 10 Nov 2004 22:34:49 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
References: <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <20041103105840.GA3992@elte.hu> <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu>
In-Reply-To: <20041109160544.GA28242@elte.hu>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.7.23 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 

I have found some test results that I find interesting with -V0.7.24. I 
modified the rtc-debug patch to work with any program that can use the 
rtc driver. It measures the latency between handling an interrupt and 
the actual read. The amlat program normally used with this patch sets up 
a signal handler that reads /dev/rtc when there is data available and 
then sleeps until it receives the signal. Realfeel just does a blocking 
read on /dev/rtc. Oh and both of them setup the rtc for periodic 
interrupts. I would probably expect the blocking read to be a bit faster 
but not dramatically. Here are the results of a couple of very short 
runs to illustrate the difference:

amlat results (sleep/sighandler):
Nov 10 21:10:39 daffy kernel: rtc histogram:
Nov 10 21:10:39 daffy kernel: 26 1
Nov 10 21:10:39 daffy kernel: 28 2152
Nov 10 21:10:39 daffy kernel: 29 4286
Nov 10 21:10:39 daffy kernel: 30 6857
Nov 10 21:10:39 daffy kernel: 31 408
Nov 10 21:10:39 daffy kernel: 32 9
Nov 10 21:10:39 daffy kernel: 33 32
Nov 10 21:10:39 daffy kernel: 34 217
Nov 10 21:10:39 daffy kernel: 35 145
Nov 10 21:10:39 daffy kernel: 36 26
Nov 10 21:10:39 daffy kernel: 40 2
Nov 10 21:10:39 daffy kernel: 41 9
Nov 10 21:10:39 daffy kernel: 42 100
Nov 10 21:10:39 daffy kernel: 43 180
Nov 10 21:10:39 daffy kernel: 44 113
Nov 10 21:10:39 daffy kernel: 45 30
Nov 10 21:10:39 daffy kernel: 46 2
Nov 10 21:10:39 daffy kernel: 47 4
Nov 10 21:10:39 daffy kernel: 48 15
Nov 10 21:10:39 daffy kernel: 49 4
Nov 10 21:10:39 daffy kernel: 50 5
Nov 10 21:10:39 daffy kernel:
Nov 10 21:10:39 daffy kernel: Total samples: 14597

realfeel results (blocking read):
Nov 10 21:11:32 daffy kernel: rtc histogram:
Nov 10 21:11:32 daffy kernel: 3 17844
Nov 10 21:11:32 daffy kernel: 4 859
Nov 10 21:11:32 daffy kernel: 5 34
Nov 10 21:11:32 daffy kernel: 6 1
Nov 10 21:11:32 daffy kernel: 8 1
Nov 10 21:11:32 daffy kernel: 12 19
Nov 10 21:11:32 daffy kernel: 13 41
Nov 10 21:11:32 daffy kernel: 14 7
Nov 10 21:11:32 daffy kernel:
Nov 10 21:11:32 daffy kernel: Total samples: 18806

Both of the above runs were with 'IRQ 8' running at SCHED_FF 99. Amlat 
and realfeel were both running at SCHED_FF 98. The updated  rtc-debug 
patch to follow in case anyone is interested.

kr
