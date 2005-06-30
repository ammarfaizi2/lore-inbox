Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbVF3QtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVF3QtV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 12:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVF3QtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 12:49:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17403 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262774AbVF3QtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 12:49:12 -0400
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, take 3
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, Bill Huey <bhuey@lnxw.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, dwalker@mvista.com, hch@infradead.org, akpm@osdl.org,
       rpm@xenomai.org
In-Reply-To: <20050630161726.GA11185@elte.hu>
References: <42C320C4.9000302@opersys.com>
	 <20050629225734.GA23793@nietzsche.lynx.com>
	 <20050629235422.GI1299@us.ibm.com> <20050630070709.GA26239@elte.hu>
	 <20050630154304.GA1298@us.ibm.com>  <20050630161726.GA11185@elte.hu>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:48:53 -0700
Message-Id: <1120150133.4453.79.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-30 at 18:17 +0200, Ingo Molnar wrote:
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > > another point is that this test is measuring the overhead of PREEMPT_RT, 
> > > without measuring the benefit of the cost: RT-task scheduling latencies.  
> > > We know since the rtirq patch (to which i-pipe is quite similar) that we 
> > > can achieve good irq-service latencies via relatively simple means, but 
> > > that's not what PREEMPT_RT attempts to do. (PREEMPT_RT necessarily has 
> > > to have good irq-response times too, but much of the focus went to the 
> > > other aspects of RT task scheduling.)
> > 
> > Agreed, a PREEMPT_RT-to-IPIPE comparison will never be an 
> > apples-to-apples comparison.  Raw data will never be a substitute for 
> > careful thought, right?  ;-)
> 
> well, it could still be tested, since it's so easy: the dohell script is 
> already doing all of that as it runs rtc_wakeup - which runs a 
> SCHED_FIFO task and carefully measures wakeup latencies. If it is used 
> with 1024 Hz (the default) and it can be used in every test without 
> impacting the system load in any noticeable way.
> 

I use a parallel implementation that has acquired the name FRD 
(Fast Real Time Domain). 

It triggers off any IRQ, and measures time to get RT task(s) running.  

The objective is to measure periodic task performance for one or more
tasks of equal, ascending, or descending priorities. 

The first task is worken by IRQ, the other tasks wake each other and
either yield or preempt, depending on ascending or descending priority. 

Especially when one RT task wakes an RT task of higher priority,
interesting things happen.

Average and Worst-case Histograms are produced in /proc, for sleep time,
run time, task wake-up latency (preemption), inter-task switch, and
absolute latency from IRQ assertion (IRQ latency + preemption) if the
IRQ assertion time is available.

On many archs, a spare auto-resetting timer can be used for the IRQ
source. With the auto-rest timer, the rollover count is available
a-priori. 

This allows getting the absolute latency since IRQ assertion, i.e. time
since timer rollover. 

It is nice to get a feel for the combined impact of IRQ disable and
preemption on task response.

For portability, I have a hook into do_timer, and I acknowledge the
blind spot this creates, but like I said, you can use any IRQ and just
hook up your own way to get the IRQ-assert time stamps.

For a really scientific test, you can write an IRQ handler and a driver
to hook up an external signal generator, Cesium or GPS, and GPIB, or
what have you. Anything to drive the external time stamps into the
program, but that is an exercise for the developer.

If anyone is interested, I can update it for Ingo's latest RT tree and
send it out.

Sven




