Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbTCFXZW>; Thu, 6 Mar 2003 18:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbTCFXZV>; Thu, 6 Mar 2003 18:25:21 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:42246
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261271AbTCFXZR>; Thu, 6 Mar 2003 18:25:17 -0500
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
From: Robert Love <rml@tech9.net>
To: Martin Waitz <tali@admingilde.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20030306232730.GC1326@admingilde.org>
References: <20030228202555.4391bf87.akpm@digeo.com>
	 <Pine.LNX.4.44.0303051910380.1429-100000@home.transmeta.com>
	 <20030306220307.GA1326@admingilde.org>
	 <1046988457.715.37.camel@phantasy.awol.org>
	 <20030306223518.GB1326@admingilde.org>
	 <1046991366.715.52.camel@phantasy.awol.org>
	 <20030306232730.GC1326@admingilde.org>
Content-Type: text/plain
Organization: 
Message-Id: <1046993765.715.101.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 06 Mar 2003 18:36:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 18:27, Martin Waitz wrote:

> schedule() does prev->sleep_timestamp = jiffies; just before
> deactivating prev.
> so i guess inactivity is counted towards sleep_avg, too

That is just the initial value.  See activate_task() which actually sets
the sleep_avg value.  If the task is never woken up, sleep_timestamp is
never used and sleep_avg is not touched.

sleep_avg is the important value.

sleep_timestamp is missed named, its really just the jiffies value at
which the task last ran.  Ingo renamed it "last_run" in his latest
patch.

> but most of the time, not _one_ process is waken up, but several at once
> 
> if it happens that the first who gets to run is cpu-bound,
> then all other interactive processes have to wait a long time, even
> if they would only need 1ms to finish their work.

Interactive tasks also have a higher dynamic priority.  So they will be
the one to run.

> scheduling overhead was successfully brought down to a minimum
> thanks to the great work of a lot of people.
> i think we should use that work to improve latency by reducing
> the available timeslice for interactive processes.
>
> if the process is still considered interactive after the time slice had run
> out, nothing is lost; it simply gets another one.
> 
> but the kernel should get the chance to frequently reschedule
> when interactivity is needed.

I understand your point, but we get that now without using super small
timeslices.

Giving interactive tasks larger timeslice ensures they can always run
when they need to.  It also lets us set an upper bound and not have to
recalculate timeslices constantly.

If an interactive task _does_ use all its timeslice, then it is no
longer interactive and that will be noted and it will lose its bonus.

	Robert Love

