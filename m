Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751488AbWFDNoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWFDNoK (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 09:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWFDNoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 09:44:10 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:55474 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751488AbWFDNoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 09:44:09 -0400
Subject: Re: [patch 05/61] lock validator: introduce WARN_ON_ONCE(cond)
From: Steven Rostedt <rostedt@goodmis.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1149412718.3109.88.camel@laptopd505.fenrus.org>
References: <20060529212109.GA2058@elte.hu> <20060529212328.GE3155@elte.hu>
	 <20060529183321.6c1a3cba.akpm@osdl.org>
	 <1149010697.8104.11.camel@localhost.localdomain>
	 <1149358157.13993.94.camel@localhost.localdomain>
	 <1149412718.3109.88.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 09:43:52 -0400
Message-Id: <1149428632.27696.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 11:18 +0200, Arjan van de Ven wrote:
> On Sat, 2006-06-03 at 14:09 -0400, Steven Rostedt wrote:
> 
> > 
> > As you can see, because the whole thing is unlikely, the first condition
> > is expected to fail.  With the current WARN_ON logic, that means that
> > the __warn_once is expected to fail, but that's not the case.  So on a
> > normal system where the WARN_ON_ONCE condition would never happen, you
> > are always branching. 
> 
> which is no cost since it's consistent for the branch predictor
> 
> >   So simply reversing the order to test the
> > condition before testing the __warn_once variable should improve cache
> > performance.
> > -	if (unlikely(__warn_once && (condition))) {	\
> > +	if (unlikely((condition) && __warn_once)) {	\
> >  		__warn_once = 0;			\
> 
> I disagree with this; "condition" can be a relatively complex thing,
> such as a function call. doing the cheaper (and consistent!) test first
> will be better. 

Wrong!  It's not better, because it is pretty much ALWAYS TRUE!  So even
if you have branch prediction you will call the condition regardless!

> __warn_once will be branch predicted correctly ALWAYS,
> except the exact ONE time you turn hit the backtrace. So it's really
> really cheap to test, and if the WARN_ON_ONCE is triggering a lot after
> the first time, you now would have a flapping first condition (which
> means lots of branch mispredicts) while the original code has a perfect
> one-check-predicted-exit scenario.

Who cares?  If the WARN_ON_ONCE _is_ triggered a bunch of times, that
means the kernel is broken.  The WARN_ON is about checking for validity,
and the condition should never trigger on a proper setup.  The ONCE part
is to keep the users logs from getting full and killing performance with
printk. And even so.  If you have 100 instances of WARN_ON_ONCE in the
kernel, only one at time would probably trigger, so you save on the
other 99.  Your idea is to optimize the broken kernel while punishing
the working one.

The analysis wasn't only about the code, but also about the use of
WARN_ON_ONCE.  The condition should _not_ be too complex and slow since
the WARN_ON_ONCE is just a check, and not something that should slow the
system down too much.

One other thing that wasn't mentioned.  The __warn_once variable is
global and not setup as a read_mostly (which maybe it should).  Because
now it can be placed in the same cache line as some global variable that
is modified a lot, so every time you test __warn_once you need to do a
cache coherency  with other CPUS, thus bringing down the performance
further.

-- Steve

