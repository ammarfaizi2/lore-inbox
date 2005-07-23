Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVGWBus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVGWBus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 21:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVGWBus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 21:50:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43254 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262271AbVGWBup
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 21:50:45 -0400
Message-ID: <42E1A208.8060408@mvista.com>
Date: Fri, 22 Jul 2005 18:48:56 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Marshall <tmarshall@real.com>, Paulo Marques <pmarques@grupopie.com>,
       Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: itimer oddness in 2.6.12
References: <20050722171657.GG4311@real.com> <42E14735.1090205@grupopie.com> <20050722205825.GB6476@real.com>
In-Reply-To: <20050722205825.GB6476@real.com>
Content-Type: multipart/mixed;
 boundary="------------040306000908080304070703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040306000908080304070703
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tom Marshall wrote:
> On Fri, Jul 22, 2005 at 08:21:25PM +0100, Paulo Marques wrote:
> 
>>Tom Marshall wrote:
>>
>>>The patch to fix "setitimer timer expires too early" is causing issues for
>>>the Helix server.  We have a timer processs that updates the server's
>>>timestamp on an itimer and it expects the signal to be delivered at roughly
>>>the interval retrieved from getitimer.  This is very consistent on every
>>>platform, including Linux up to 2.6.11, but breaks on 2.6.12.  On 2.6.12,
>>>setting the itimer to 10ms and retrieving the actual interval from 
>>>getitimer
>>>reports 10.998ms, but the timer interrupts are consistently delivered at
>>>roughly 11.998ms.  
>>
>>Unfortunately, this is not so clear cut as it seems :(

Oops!  That patch is wrong.  The +1 should be applied to the initial 
interval _only_.  We KNOW when the repeating intervals start (i.e. at 
the jiffie edge) and don't need to adjust them.  The patch, however, 
incorrectly, rolls them all into one.  The attach patch should fix the 
problem.  Warnning, it compiles and boots, but I have not tested it.

George
-- 
> 
> 
> Yes, I am sure that it is not a simple problem.  I am not a kernel developer
> but I imagine that issues such as NTP adjustments would complicate this
> issue.  I must also admit that I am not intimately familiar with the POSIX
> spec regarding itimers.
> 
> Our current code does a setitimer followed by getitimer, then uses the
> actual interval retrieved by getitimer to set a global timer delta.  On each
> timer signal, it updates the notion of the current time by the timer delta. 
> As mentioned, this works on every other platform (Solaris, BSD, HPUX, AIX,
> DGUX, IRIX, Tru64, and Linux up to 2.6.11) but breaks on 2.6.12.

> 
> This is not an insurmountable problem for userspace.  It can be easily
> solved by using gettimeofday in the timer interrupt instead of adding the
> delta to the current time blindly.  No big deal.  I just wanted to point
> this issue out and ensure that (1) it was a known issue, and (2) it is the
> direction that the Linux kernel intends to take.  If so, no big deal and we
> can modify the timer code to take that into account.
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------040306000908080304070703
Content-Type: text/plain;
 name="itimer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="itimer.patch"

Source: MontaVista Software, Inc. <george@mvista.com>
Type: Defect Fix
Disposition: 
Description:

This changes setitimer as follows:
1. The repeating timer is figured using the requested time 
	(not +1 as we know where we are in the jiffie).
2. The tests for interval too large are left to the time_val to jiffie code.


Signed-off-by: George Anzinger <george@mvista.com>
 itimer.c |   37 ++++++++++++++++---------------------
 1 files changed, 16 insertions(+), 21 deletions(-)

Index: linux-2.6.13-rc/kernel/itimer.c
===================================================================
--- linux-2.6.13-rc.orig/kernel/itimer.c
+++ linux-2.6.13-rc/kernel/itimer.c
@@ -112,28 +112,11 @@ asmlinkage long sys_getitimer(int which,
 	return error;
 }
 
-/*
- * Called with P->sighand->siglock held and P->signal->real_timer inactive.
- * If interval is nonzero, arm the timer for interval ticks from now.
- */
-static inline void it_real_arm(struct task_struct *p, unsigned long interval)
-{
-	p->signal->it_real_value = interval; /* XXX unnecessary field?? */
-	if (interval == 0)
-		return;
-	if (interval > (unsigned long) LONG_MAX)
-		interval = LONG_MAX;
-	/* the "+ 1" below makes sure that the timer doesn't go off before
-	 * the interval requested. This could happen if
-	 * time requested % (usecs per jiffy) is more than the usecs left
-	 * in the current jiffy */
-	p->signal->real_timer.expires = jiffies + interval + 1;
-	add_timer(&p->signal->real_timer);
-}
 
 void it_real_fn(unsigned long __data)
 {
 	struct task_struct * p = (struct task_struct *) __data;
+	unsigned long inc = p->signal->it_real_incr;
 
 	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, p);
 
@@ -141,14 +124,23 @@ void it_real_fn(unsigned long __data)
 	 * Now restart the timer if necessary.  We don't need any locking
 	 * here because do_setitimer makes sure we have finished running
 	 * before it touches anything.
+	 * Note, we KNOW we are (or should be) at a jiffie edge here so 
+	 * we don't need the +1 stuff.  Also, we want to use the prior
+	 * expire value so as to not "slip" a jiffie if we are late.
+	 * Deal with requesting a time prior to "now" here rather than
+	 * in add_timer.
 	 */
-	it_real_arm(p, p->signal->it_real_incr);
+	if (!inc)
+		return;
+	while (time_before_eq(p->signal->real_timer.expires, jiffies))
+		p->signal->real_timer.expires += inc;
+	add_timer(&p->signal->real_timer);	
 }
 
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 {
 	struct task_struct *tsk = current;
- 	unsigned long val, interval;
+ 	unsigned long val, interval, expires;
 	cputime_t cval, cinterval, nval, ninterval;
 
 	switch (which) {
@@ -160,7 +152,10 @@ int do_setitimer(int which, struct itime
 			del_timer_sync(&tsk->signal->real_timer);
 		tsk->signal->it_real_incr =
 			timeval_to_jiffies(&value->it_interval);
-		it_real_arm(tsk, timeval_to_jiffies(&value->it_value));
+		expires = timeval_to_jiffies(&value->it_value);
+		if (expires)
+			mod_timer(&tsk->signal->real_timer,
+				  jiffies + 1 + expires);
 		spin_unlock_irq(&tsk->sighand->siglock);
 		if (ovalue) {
 			jiffies_to_timeval(val, &ovalue->it_value);

--------------040306000908080304070703--
