Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUBUT2J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 14:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUBUT2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 14:28:09 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:64482 "EHLO
	ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S261604AbUBUT15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 14:27:57 -0500
Date: Sat, 21 Feb 2004 14:27:42 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][4/4] poll()/select() timeout behavior
Message-ID: <20040221192742.GA26614@ti19.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
	torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20040220210452.GE1912@ti19.telemetry-investments.com> <20040220201328.609fe4e2.akpm@osdl.org> <20040221161806.GA15991@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040221161806.GA15991@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 04:18:06PM +0000, Jamie Lokier wrote:
> select's behaviour is fun when trying to do smooth game animation on
> X...  Humans are pretty good at noticing jitter in the animation of a
> moving object.  Years ago, I ended up writing an estimator which
> deduced the granularity and rounding of select(), so that I could then
> _reduce_ the timeout given to select() followed by a busy wait up to
> the desired time.  That was needed for SunOS.  Nowadays with 1kHz
> jiffies it's not a problem, but not all systems have that.
> 
> So, I agree, the change might break current apps.

Hi Jamie,

Sorry I forgot to CC you on this ...

I don't feel strongly about the select() fencepost change, so no matter.
The man page wording in the past has been "unfortunate", using phrases
like "no longer than", which is a ridiculously imprecise wording in
light of how timers and sleep queues actually work.

As for the behaviour of usec overflow, there are probably existing
apps that abuse the interface (which is strictly checked on other platforms).

Below is a merged patch which drops the select fencepost change and handles
usec overflow instead of rejecting it.  It incorporates the poll overflow
fix and the "don't sleep forever" semantic (and cleans up the use of < v. <=
in my earlier patches).
 
> If the current behaviour is retained, shouldn't select(), poll() and
> epoll() at least agree on the same rounding direction?  poll/epoll
> should be suitable as replacements for select, but I don't think they
> are timing-wise.
 
You can compare the two manpages:
http://www.opengroup.org/onlinepubs/007904975/functions/select.html

   If none of the selected descriptors are ready for the requested operation,
   the pselect() or select() function shall block until at least one of
   the requested operations becomes ready, until the timeout occurs, or
   until interrupted by a signal. The timeout parameter controls how long
   the pselect() or select() function shall take before timing out. If
   the timeout parameter is not a null pointer, it specifies a maximum
   interval to wait for the selection to complete. If the specified time
   interval expires without any requested operation becoming ready, the
   function shall return. If the timeout parameter is a null pointer,
   then the call to pselect() or select() shall block indefinitely until
   at least one descriptor meets the specified criteria. To effect a poll,
   the timeout parameter should not be a null pointer, and should point to
   a zero-valued timespec structure.

   ...

   Implementations may place limitations on the maximum timeout interval
   supported. All implementations shall support a maximum timeout interval
   of at least 31 days. If the timeout argument specifies a timeout interval
   greater than the implementation-defined maximum value, the maximum value
   shall be used as the actual timeout value. Implementations may also place
   limitations on the granularity of timeout intervals. If the requested
   timeout interval requires a finer granularity than the implementation
   supports, the actual timeout interval shall be rounded up to the next
   supported value.

[Btw, we don't honor the 31-day requirement on 32-bit platforms with HZ=1000;
 I certainly don't care.]

http://www.opengroup.org/onlinepubs/007904975/functions/poll.html


   If none of the defined events have occurred on any selected file
   descriptor, poll() shall wait at least timeout milliseconds for an event
   to occur on any of the selected file descriptors. If the value of timeout
   is 0, poll() shall return immediately. If the value of timeout is -1,
   poll() shall block until a requested event occurs or until the call
   is interrupted.

   Implementations may place limitations on the granularity of timeout
   intervals. If the requested timeout interval requires a finer granularity
   than the implementation supports, the actual timeout interval shall be
   rounded up to the next supported value.

I think the intention is that poll() requires the +1 jiffy.

Since it is not stated explicitly in the manpage, this raises the question:
should poll() return early if the timeout exceeds the implementation
maximum?  I think so, because in a correctly written poll() loop it does
no harm, while the existing behavior is problematic.  The select() manpage
explicitly specifies the early return.

> (Btw, Bill, did you take a look at epoll too?)

I hadn't, but I just did, and it also has the poll() overflow problem.
Interestingly, it has the select() fencepost behavior.

Should epoll() behave like poll() or select(), or should
we modify poll() to also behave like select()?

In the patch below I've chosen the first option.

W.r.t the overflow calculation: in the typical (non-overflow) case
we can trade off a compare/branch for one of the constant divisions
by 1000.  I have no clue which is more costly.

	- Bill Rugolsky


--- linux/fs/select.c 	2004-02-17 22:57:12.000000000 -0500
+++ linux/fs/select.c	2004-02-21 12:55:32.357875000 -0500
@@ -291,8 +291,6 @@
  * Update: ERESTARTSYS breaks at least the xview clock binary, so
  * I'm trying ERESTARTNOHAND which restart only when you want to.
  */
-#define MAX_SELECT_SECONDS \
-	((unsigned long) (MAX_SCHEDULE_TIMEOUT / HZ)-1)
 
 asmlinkage long
 sys_select(int n, fd_set __user *inp, fd_set __user *outp, fd_set __user *exp, struct timeval __user *tvp)
@@ -315,9 +313,16 @@
 		if (sec < 0 || usec < 0)
 			goto out_nofds;
 
-		if ((unsigned long) sec < MAX_SELECT_SECONDS) {
-			timeout = ROUND_UP(usec, 1000000/HZ);
-			timeout += sec * (unsigned long) HZ;
+		/* be careful about overflow */
+		if ((unsigned long) sec < ((MAX_SCHEDULE_TIMEOUT-1) / HZ)) {
+			long fraction = ROUND_UP(usec, 1000000/HZ);
+			timeout = sec * (unsigned long) HZ;
+			if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT - fraction)
+				timeout += fraction;
+			else
+				timeout = MAX_SCHEDULE_TIMEOUT-1;
+		} else {
+			timeout = MAX_SCHEDULE_TIMEOUT-1;
 		}
 	}
 
@@ -469,11 +474,17 @@
 		return -EINVAL;
 
 	if (timeout) {
-		/* Careful about overflow in the intermediate values */
-		if ((unsigned long) timeout < MAX_SCHEDULE_TIMEOUT / HZ)
-			timeout = (unsigned long)(timeout*HZ+999)/1000+1;
-		else /* Negative or overflow */
+                if (timeout < 0) {
 			timeout = MAX_SCHEDULE_TIMEOUT;
+		} else { 
+			/* Careful about overflow in the intermediate values */
+			long seconds = timeout/1000;
+			timeout = ((timeout - 1000*seconds)*HZ + 999)/1000 + 1;
+			if (seconds < (MAX_SCHEDULE_TIMEOUT-2) / HZ)
+				timeout += seconds * HZ;
+			else
+				timeout = MAX_SCHEDULE_TIMEOUT-1;
+		}
 	}
 
 	poll_initwait(&table);
--- linux/fs/eventpoll.c 	2004-02-17 22:57:29.000000000 -0500
+++ linux/fs/eventpoll.c	2004-02-21 13:38:29.987875000 -0500
@@ -1576,7 +1576,6 @@
 {
 	int res, eavail;
 	unsigned long flags;
-	long jtimeout;
 	wait_queue_t wait;
 
 	/*
@@ -1584,8 +1583,17 @@
 	 * and the overflow condition. The passed timeout is in milliseconds,
 	 * that why (t * HZ) / 1000.
 	 */
-	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
-		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
+	if (timeout < 0) {
+		timeout = MAX_SCHEDULE_TIMEOUT;
+	} else {
+		/* Careful about overflow in the intermediate values */
+		long seconds = timeout/1000;
+		timeout = ((timeout - 1000*seconds)*HZ + 999)/1000 + 1;
+		if (seconds < (MAX_SCHEDULE_TIMEOUT-2) / HZ)
+			timeout += seconds * HZ;
+		else
+			timeout = MAX_SCHEDULE_TIMEOUT-1;
+	}
 
 retry:
 	write_lock_irqsave(&ep->lock, flags);
@@ -1607,7 +1615,7 @@
 			 * to TASK_INTERRUPTIBLE before doing the checks.
 			 */
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (!list_empty(&ep->rdllist) || !jtimeout)
+			if (!list_empty(&ep->rdllist) || !timeout)
 				break;
 			if (signal_pending(current)) {
 				res = -EINTR;
@@ -1615,7 +1623,7 @@
 			}
 
 			write_unlock_irqrestore(&ep->lock, flags);
-			jtimeout = schedule_timeout(jtimeout);
+			timeout = schedule_timeout(timeout);
 			write_lock_irqsave(&ep->lock, flags);
 		}
 		remove_wait_queue(&ep->wq, &wait);
@@ -1634,7 +1642,7 @@
 	 * more luck.
 	 */
 	if (!res && eavail &&
-	    !(res = ep_events_transfer(ep, events, maxevents)) && jtimeout)
+	    !(res = ep_events_transfer(ep, events, maxevents)) && timeout)
 		goto retry;
 
 	return res;
