Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVJ0BWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVJ0BWc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 21:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVJ0BWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 21:22:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:8381 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964953AbVJ0BWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 21:22:31 -0400
Subject: Re: 2.6.14-rc4-rt7
From: john stultz <johnstul@us.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: William Weston <weston@lysdexia.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       george@mvista.com, Ingo Molnar <mingo@elte.hu>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
In-Reply-To: <1130375244.21118.91.camel@localhost.localdomain>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>
	 <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>
	 <20051025154440.GA12149@elte.hu>
	 <1130264218.27168.320.camel@cog.beaverton.ibm.com>
	 <435E91AA.7080900@mvista.com> <20051026082800.GB28660@elte.hu>
	 <435FA8BD.4050105@mvista.com> <435FBA34.5040000@mvista.com>
	 <435FEAE7.8090104@rncbc.org>
	 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
	 <1130371042.21118.76.camel@localhost.localdomain>
	 <1130373953.27168.370.camel@cog.beaverton.ibm.com>
	 <1130375244.21118.91.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 26 Oct 2005 18:22:27 -0700
Message-Id: <1130376147.27168.381.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 21:07 -0400, Steven Rostedt wrote:
> On Wed, 2005-10-26 at 17:45 -0700, john stultz wrote:
> 
> > Ok, I've reproduced the issue. 
> > 
> > However, running a clock_gettime(CLOCK_MONOTONIC) inconsistency check
> > results in no failures, but triggers this code in the kernel.
> > 
> > Looking at the code, these may be false positives. The bit that is
> > complaining I believe Ingo added to get_monotonic_clock_ts() in
> > kernel/time/timeofday.c.  However I don't see any locking that
> > serializes the writes the prev in the same order as the
> > get_monotonic_clock_ts is called.
> > 
> > I'm still digging and will send out some mail when I figure out whats
> > wrong.
> 
> Hmm, I'm wondering if these are a false positive. Being a fully
> preemptible kernel, we could be preempted between taking now and getting
> prev, so the prev could be updated to a time after now and show a warp.
> 
> William and Rui, could you try this patch and see if you still get the
> warnings.  Although I doubt this is really the problem, since I can't
> see how it would cause clusters of these messages.

I don't know if that would really fix it, because ideally you want to
read the prev_mono_time at the same point you calculate the time inside
the read lock'ed critical section.

The difficulty is then even if you do read the prev value in a
serialized manner, you have to serialize the writes properly as well. So
really you want to do all four operations (read prev, calculate time, do
comparision, write prev) under a write lock.

Again, I'm not totally sure about this, but even removing the part where
it overwrites the ts pointer w/ the prev time, I do not see
inconsistencies from userland. 

Also I'm not seeing clusters of messages. If you call
clock_gettime(CLOCK_MONOTONIC,..) in a loop, you'll see tons of these
message.

The only odd part is the regularness of the errors. I'm seeing the ~5000
ns deltas ~every ms. So there may be something going wrong, but I don't
see it yet.

thanks
-john


