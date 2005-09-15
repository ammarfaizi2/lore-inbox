Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbVIOWxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbVIOWxe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 18:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbVIOWxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 18:53:34 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:5807
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1161009AbVIOWxd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 18:53:33 -0400
Subject: Re: 2.6.13-rt6, ktimer subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: george@mvista.com
Cc: john stultz <johnstul@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>, dwalker@mvista.com,
       "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>
In-Reply-To: <4329F733.2090604@mvista.com>
References: <20050913100040.GA13103@elte.hu>  <43287C52.7050002@mvista.com>
	 <1126751140.6509.474.camel@tglx.tec.linutronix.de>
	 <4329F733.2090604@mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 16 Sep 2005 00:53:39 +0200
Message-Id: <1126824819.6509.540.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-15 at 15:35 -0700, George Anzinger wrote:

> > Performance is a straw man argument here. You know very well that > 90%
> > of the timers are inaccurate "timeout" timers related to I/O,
> > networking, devices. Most of those never expire (the positive feedback
> > removes the timer before expiry) and those timers have no constraint to
> > be accurate, except for the fact that they have to detect an
> > device/network problem at some time. In this case it is completely
> > irrelevant whether the timeout occurs n msecs earlier or later.
> 
> I agree, but it not accuracy that I am arguing, but cpu cycles.  Those 
> we use in the kernel are not available for the user.

The time used for recascding is neither available :). Seriously, I'm
quite sure that the rbtree for the sorting of "timers" - not "timeouts"
- will not have any relevant performance impact. If there is a faster
sorted tree around, I have no problem to use that.

> I confess I don't understand the above numbers.  What are min and max 
> and in what units?  Are you saying the large max numbers are caused by 
> the cascade?

Sorry, all units usec.

Yes. The problem is the combined base lock, which holds off interrupts
for quite a bunch of time. Daniel was experiencing this too.
 
> > - The posix timer tests run all successful, except the broken 2timertest
> > which fails on any other HRT kernel too and the sleep to long for real
> > timers when the clock is set backwards, which is easily solvable
> > (working on that).
> 
> Your mileage seems to differ from mine.  Here is what I get from ./do_test:
> The following tests failed:
> clock_nanosleeptest
> abs_timer_test
> 4-1
> clock_settimetest
> clock_gettimetest2
> 2timer_test 

Hmm. Except for the 2timer_test, where my source seems to be broken it
works here. 

> Then, on the second run, it crashed in an attempt to get the monotonic 
> clock (a divide error).  System is a dual PIII, 800Mhz.  This from the 
> rt11 patch.

Hmm, divide error. I had one of those in the early phase due to some
strange 64/32 truncation problem, which was caused by nested
inline/macros. After unmingling the problem went away.

tglx


