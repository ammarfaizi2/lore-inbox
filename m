Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbVLPD14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbVLPD14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 22:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVLPD14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 22:27:56 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:34751 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932086AbVLPD1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 22:27:55 -0500
Subject: Re: severe jitter experienced with "select()" in linux 2.6.14-rt22
From: Lee Revell <rlrevell@joe-job.com>
To: Gautam Thaker <gthaker@comcast.net>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <43A21324.2050905@comcast.net>
References: <43A21324.2050905@comcast.net>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 22:30:44 -0500
Message-Id: <1134703845.12086.237.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 20:06 -0500, Gautam Thaker wrote:
> 
> /proc/latency trace is full of lines such as these:
> 
>    <...>-3     0.... 20317us : __down_mutex (rt_run_flush)
>    <...>-3     0.... 20317us : __up_mutex_savestate (rt_run_flush)
>    <...>-3     0.... 20317us : __down_mutex (rt_run_flush)
>    <...>-3     0.... 20317us : __up_mutex_savestate (rt_run_flush)
>    <...>-3     0.... 20317us : __down_mutex (rt_run_flush)
>    <...>-3     0.... 20317us : __up_mutex_savestate (rt_run_flush)
>    <...>-3     0.... 20318us : __down_mutex (rt_run_flush)
>    <...>-3     0.... 20318us : __up_mutex_savestate (rt_run_flush)
>    <...>-3     0.... 20318us : __down_mutex (rt_run_flush)
>    <...>-3     0.... 20318us : __up_mutex_savestate (rt_run_flush)
>    <...>-3     0.... 20318us : __down_mutex (rt_run_flush)
>    <...>-3     0.... 20318us : __up_mutex_savestate (rt_run_flush)
>    <...>-3     0.... 20319us : __down_mutex (rt_run_flush)
> 
> and
> 
> "dmesg" says somethign like this:
> 
> (        ubersock-4032 |#0): new 131 us user-latency.
> (        ubersock-4032 |#0): new 131 us user-latency.
> (        ubersock-4032 |#0): new 133 us user-latency.
> (        ubersock-4032 |#0): new 221 us user-latency.
> (        ubersock-4032 |#0): new 223 us user-latency.
> (        ubersock-4032 |#0): new 20629 us user-latency.
> root@blade8>
> 
> When tracing I exit my test when a large latency is observed (in the
> case above a 20,629 usec value was observed by the "select()" test. 
> 

AI've seen this in my tests too, I think it's still a problem that
rt_run_flush can cause a 20ms+ non preemptible section.

Ingo mentioned that he may push softirq preemption upstream which would
fix this.  You can also try tweaking these sysctls:

net.ipv4.route.gc_elasticity = 8
net.ipv4.route.gc_interval = 60
net.ipv4.route.gc_timeout = 300
net.ipv4.route.gc_min_interval_ms = 500
net.ipv4.route.gc_min_interval = 0
net.ipv4.route.gc_thresh = 4096

which AFAICT should let you tune the route cache garbage collection to
run more often and hopefully process fewer routes per run.

Lee



