Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTKYVOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 16:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbTKYVOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 16:14:33 -0500
Received: from users.ccur.com ([208.248.32.211]:23461 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S263101AbTKYVOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 16:14:31 -0500
Date: Tue, 25 Nov 2003 16:12:40 -0500
From: Joe Korty <joe.korty@ccur.com>
To: George Anzinger <george@mvista.com>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, root@chaos.analogic.com,
       Stephen Hemminger <shemminger@osdl.org>,
       Gabriel Paubert <paubert@iram.es>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] possible erronous use of tick_usec in do_gettimeofday
Message-ID: <20031125211240.GA15759@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20031028115558.GA20482@iram.es> <20031028102120.01987aa4.shemminger@osdl.org> <20031029100745.GA6674@iram.es> <20031029113850.047282c4.shemminger@osdl.org> <16288.17470.778408.883304@wombat.chubb.wattle.id.au> <3FA1838C.3060909@mvista.com> <Pine.LNX.4.53.0310301645170.16005@chaos> <16289.39801.239846.9369@wombat.chubb.wattle.id.au> <20031125164237.GA15498@rudolph.ccur.com> <3FC3B443.2060804@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC3B443.2060804@mvista.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 11:57:55AM -0800, George Anzinger wrote:
> Joe Korty wrote:
> >test10's version of do_gettimeofday is using tick_usec which is
> >defined in terms of USER_HZ not HZ.
> 
> We still have the problem that we are doing this calculation in usecs while 
> the wall clock uses nsecs.  This would be fine if there were an even number 
> of usecs in tick_nsec, but in fact it is somewhat less than (USEC_PER_SEC / 
> HZ).  This means that this correction (if we are behind by 7 or more ticks) 
> will push the clock past current time.  Here are the numbers:
> 
> tick_nsec =999849 or 1ms less 151 ns.  So if we are behind 7 or more ticks 
> we will report the time out 1 us too high.  (7 * 151 = 1057 or 1.057 usec).
> 
> Question is, do we care?  Will we ever be 7ms late in updating the wall 
> clock? As I recall, the wall clock is updated in the interrupt handler for 
> the tick so, to be this late, we would need to suffer a long interrupt hold 
> off AND the tick recovery code would need to have done its thing.  But this 
> whole time is covered by a write_seqlock on xtime_lock, so how can this 
> even happen?  Seems like it is only possible when we are locked and we then 
> throw the whole thing away.
> 
> A test I would like to see is to put this in the code AFTER the read unlock:
> 
> if (lost )
> 	printk("Lost is %d\n", lost);
> 
> (need to pull "	unsigned long lost;" out of the do{}while loop to do 
> this)
> 
> In short, I think we are beating a dead issue.

There are other issues too: the 'lost' calculation is a prediction
over the next 'lost' number of ticks.  That prediction will be wrong
if 1) adjtime goes to zero within that interval or, 2) adjtime was
zero but went nonzero in that interval due to a adjtimex(2) call.

Despite these flaws the patch replaces truly broken code with code
that is good but slightly inaccurate, which is good enough for now.

Joe
