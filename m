Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbTJ1SWT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbTJ1SWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:22:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:35233 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264034AbTJ1SWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:22:15 -0500
Date: Tue, 28 Oct 2003 10:21:20 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: john stultz <johnstul@us.ibm.com>, Joe Korty <joe.korty@ccur.com>,
       Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
Message-Id: <20031028102120.01987aa4.shemminger@osdl.org>
In-Reply-To: <20031028115558.GA20482@iram.es>
References: <20031027234447.GA7417@rudolph.ccur.com>
	<1067300966.1118.378.camel@cog.beaverton.ibm.com>
	<20031027171738.1f962565.shemminger@osdl.org>
	<20031028115558.GA20482@iram.es>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003 12:55:58 +0100
Gabriel Paubert <paubert@iram.es> wrote:

> On Mon, Oct 27, 2003 at 05:17:38PM -0800, Stephen Hemminger wrote:
> > Arghh... the patch was being way more agressive than necessary.  
> > tickadj which limits NTP is always 1 (for HZ=1000) so NTP will change
> > at most 1 us per clock tick.  This meant we only had to stop time
> > for the last us of the interval.
> 
> Hmm, I still don't like it. What does it do to timestamping in
> interrupts in the kernel, especially when there is a burst of
> interrupts?
> 
> If I read it correctly, the time will be frozen between the time
> the timer interrupt should have arrived and the time it is processed.
> So the last micosecond of the interval could extend well into the next
> interval, or do I miss something (I also suspect that it could
> make PPSKit behave strangely for this reason)?

The original problem all this is solving is that when NTP is slowing the clock
there existed real cases where time appeared to go backwards. Assuming NTP was
slowing the clock, then it would update the xtime by 999us at the next timer interrupt.
If a program read time three times:

A:	    xtime = t0
B: A+1000   xtime = t0 + 1000
C: B+1	    xtime = t0 + 999

To behave correctly C > B > A; but we were returning C < B

The code does have bug if we are losing clock interrupts.  The test for
lost interrupts needs to be after the interval clamp.

This should work better. Patch against 2.6.0-test9

diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Oct 28 10:08:52 2003
+++ b/arch/i386/kernel/time.c	Tue Oct 28 10:08:52 2003
@@ -94,6 +94,7 @@
 {
 	unsigned long seq;
 	unsigned long usec, sec;
+	unsigned long max_ntp_tick = tick_usec - tickadj;
 
 	do {
 		unsigned long lost;
@@ -102,16 +103,20 @@
 
 		usec = cur_timer->get_offset();
 		lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * (1000000 / HZ);
 
 		/*
 		 * If time_adjust is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0) && usec > tickadj)
-			usec = tickadj;
+		if (unlikely(time_adjust < 0)) {
+			usec = min(usec, max_ntp_tick);
+
+			if (lost)
+				usec += lost * max_ntp_tick;
+		} 
+		else if (unlikely(lost))
+			usec += lost * tick_usec;
 
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
