Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWCRKhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWCRKhM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 05:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWCRKhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 05:37:12 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:58584
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932378AbWCRKhK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 05:37:10 -0500
Subject: Re: 2.6.16-rc6-rt7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tom Rini <trini@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>,
       Martin Ridgeway <mridge@users.sourceforge.net>
In-Reply-To: <20060317233636.GB26253@smtp.west.cox.net>
References: <20060316095607.GA28571@elte.hu>
	 <20060317233636.GB26253@smtp.west.cox.net>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 11:37:19 +0100
Message-Id: <1142678240.17279.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 16:36 -0700, Tom Rini wrote:
> On Thu, Mar 16, 2006 at 10:56:08AM +0100, Ingo Molnar wrote:
> 
> > i have released the 2.6.16-rc6-rt7 tree, which can be downloaded from 
> > the usual place:
> > 
> >    http://redhat.com/~mingo/realtime-preempt/
> 
> I was wondering, is it normal for the nanosleep02 and alarm02 LTP tests
> to fail?  For sometime I've seen these tests fail from time to time with
> the -RT patch but not the regular kernel.

The nanosleep02 failure is incorrect due to rounding errors in the test
code.

Requested time to sleep is 5.000009999 seconds (5s 9999ns)

Program flow is:

unsigned long req, rem, before, after, elapsed;

gettimeofday(&otime);
nanosleep(&timereq, &timerem); <- Interrupted by a signal
gettimeofday(&ntime);

req = timereq.tv_sec * 1000 + timereq.tv_nsec / 1000000;
rem = timerem.tv_sec * 1000 + timerem.tv_nsec / 1000000;
before = otime.tv_sec * 1000 + otime.tv_usec/1000;
after = ntime.tv_sec * 1000 + ntime.tv_usec/1000;
elapsed = after - before;

if (rem - (req -elapsed) > 250)
	fail;

The error message is:
nanosleep02    1  FAIL  :  Remaining sleep time 3999 msec doesn't match with the expected 4000 msec time

rem: 3999 ms
req - elasped: 4000 ms

The unsigned long subtraction results in a value > 250, where the real
result is < 0.

Looking at the real values with usec resolution gives:

req: 5000009 usec 
rem: 3999740 usec
elapsed: 1000452 usec
req - elapsed: 3999557 usec

rem - (req -elapsed) = 183 usec

Truncating the real values by the division used in the test code results
in:

req_ms = 5000010 / 1000 = 5000 ms
rem_ms = 3999470 / 1000 = 3999 ms
elapsed_ms = 1000452 / 1000 = 1000ms
req_ms - elapsed_ms = 4000ms

This never happens on vanilla, as the nanosleep is rounded to the next
jiffie. -rt has high resolution timers which are delivered accurate, so
the rounding errors of the testcode surface.

	tglx


