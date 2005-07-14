Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVGNTPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVGNTPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbVGNTNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:13:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41993 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261688AbVGNTKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:10:41 -0400
Date: Thu, 14 Jul 2005 20:09:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
       azarah@nosferatu.za.org, christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050714200926.C10410@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@infradead.org>,
	Vojtech Pavlik <vojtech@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
	"Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
	david.lang@digitalinsight.com, davidsen@tmr.com, kernel@kolivas.org,
	linux-kernel@vger.kernel.org, mbligh@mbligh.org, diegocg@gmail.com,
	azarah@nosferatu.za.org, christoph@lameter.com
References: <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org> <20050714005106.GA16085@taniwha.stupidest.org> <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org> <1121304825.4435.126.camel@mindpipe> <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org> <1121326938.3967.12.camel@laptopd505.fenrus.org> <20050714121340.GA1072@ucw.cz> <Pine.LNX.4.58.0507140933150.19183@g5.osdl.org> <1121360561.3967.55.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0507141010530.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507141010530.19183@g5.osdl.org>; from torvalds@osdl.org on Thu, Jul 14, 2005 at 10:21:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 10:21:41AM -0700, Linus Torvalds wrote:
> In other words, the _right_ way to do this is literally
> 
> 	unsigned long timeout = jiffies + HZ/2;
> 	for (;;) {
> 		if (ready())
> 			return 0;
> 		if (time_after(timeout, jiffies))
> 			break;
> 		msleep(10);
> 	}
> 
> which is unquestionably more complex, yes, but it's more complex because 
> it is CORRECT!

Umm.  Except, according to your description of what it's supposed to
do, the above code can have an accumulating error.

	unsigned long timeout, max_timeout, now;

	now = jiffies;
	timeout = now + HZ/100;
	max_timeout = now + HZ/2;

	for (;;) {
		if (ready())
			return 0;
		if (time_after(timeout, jiffies))
			break;
		sleep_until(timeout);
		timeout += HZ/100;
	}

would be even more correct, if we had an absolute schedule_timeout()
called sleep_until().  If we woke up late, we will schedule the next
wakeup exactly 10ms after the previous wakeup _should_ have happened.

Quick!  Convert all the kernel interfaces back to absolute time! 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
