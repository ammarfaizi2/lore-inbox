Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbVHDAyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVHDAyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVHDAwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:52:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:52869 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261689AbVHDAv4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:51:56 -0400
Date: Wed, 3 Aug 2005 17:51:47 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: [PATCH] push rounding up of relative request to schedule_timeout()
Message-ID: <20050804005147.GC4255@us.ibm.com>
References: <1122123085.3582.13.camel@localhost.localdomain> <Pine.LNX.4.61.0507231456000.3728@scrub.home> <20050723164310.GD4951@us.ibm.com> <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508031419000.3728@scrub.home>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.2005 [16:20:57 +0200], Roman Zippel wrote:
> Hi,
> 
> On Mon, 1 Aug 2005, Nishanth Aravamudan wrote:
> 
> > +unsigned int __sched schedule_timeout_msecs(unsigned int timeout_msecs)
> > +{
> > +	unsigned long expire_jifs;
> > +
> > +	if (timeout_msecs == MAX_SCHEDULE_TIMEOUT_MSECS) {
> > +		expire_jifs = MAX_SCHEDULE_TIMEOUT;
> > +	} else {
> > +		/*
> > +		 * msecs_to_jiffies() is a unit conversion, which truncates
> > +		 * (rounds down), so we need to add 1.
> > +		 */
> > +		expire_jifs = msecs_to_jiffies(timeout_msecs) + 1;
> > +	}
> > +
> > +	expire_jifs = schedule_timeout(expire_jifs);
> > +
> > +	/*
> > +	 * don't need to add 1 here, even though there is truncation,
> > +	 * because we will add 1 if/when the value is sent back in
> > +	 */
> > +	return jiffies_to_msecs(expire_jifs);
> > +}
> 
> As I already mentioned for msleep_interruptible this is a really terrible 
> interface.
> The "jiffies_to_msecs(msecs_to_jiffies(timeout_msecs) + 1)" case (when the 
> process is immediately woken up again) makes the caller suspectible to 
> timeout manipulations and requires constant reauditing, that no caller 
> gets it wrong, so it's better to avoid this error source completely.

After some thought today, I realized the +1 case is not specific to
milliseconds. It's just that it's only being done *correctly* in the
milliseconds case...I think ;)

So, consider the following:

We are requesting a 10 jiffy sleep via

	set_current_state(TASK_INTERRUPTIBLE);
	schedule_timeout(10);

Keep in mind that jiffies is only incremented when the timer interrupt
occurs (the whole point being, again, we do not have any inter-tick
jiffy-value).

In schedule_timeout() we will add the 10 to jiffies' current value. But
what happens if we were calling schedule_timeout() immediately before
the next timer interrupt occurs? Then we will only sleep slightly more
than 9 jiffies, instead of the 10 requested. The basic issue is that we
are always taking the floor of the current position in jiffies in
schedule_timeout() by adding the relative offset to jiffies. To
guarantee the timeout requested passes, we must add the relative offset
to (jiffies+1) [See the attached patch, which I think fixes the
"problem" in 2.6.13-rc5]. Most callers are already rounding up or adding
one to their request, so it may not be a problem. And, often, these are
sleeping paths, so most callers don't care about precision. So, while
you are correct that there is a chance for "infinite" sleep in
msleep_interruptible() and schedule_timeout_{intr,unintr}_msecs(), there
technically *should* be such a possibility in the jiffies case too, but
the code wasn't correct up until now.

All in all, seems buggy, but my analysis may also be wrong -- and this
case may be damn well near impossible to actually create.

> Constant conversion between different time units is a really bad idea. If 
> the user needs the remaining time, he is really better off to do it 
> himself by checking jiffies and only does an initial conversion from 
> relative to absolute (kernel) time.
> This wrapper function really should be an inline function and should look 
> more like this:
> 
> static inline int schedule_timeout_msecs(unsigned int timeout_msecs)
> {
> 	return schedule_timeout(msecs_to_jiffies(timeout_msecs) + 1) != 0;
> }

I don't think I want the schedule_timeout*() functions' return values'
meanings to be different depending on whether you use milliseconds or
jiffies. Your version makes the millisecond-case boolean in return,
which is differnent than schedule_timeout()'s remaining-jiffies return
value.

I have also been thinking about the need to use
while(time_after(timeout_jiffies, timeout)) vs.  while(timeout_msecs),
but I will respond to a different e-mail about that.

Thanks,
Nish

---

 timer.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

Description: Ensure that schedule_timeout() requests can not possibly
expire early in the timeout case, by adding the requested relative jiffy
value to the next value of jiffies. Currently, by adding to the current
value of jiffies, we might actually expire a jiffy too early (in a
corner case).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.13-rc5/kernel/timer.c	2005-08-01 12:31:53.000000000 -0700
+++ 2.6.13-rc5-dev/kernel/timer.c	2005-08-03 17:30:10.000000000 -0700
@@ -1134,7 +1134,7 @@ fastcall signed long __sched schedule_ti
 		}
 	}
 
-	expire = timeout + jiffies;
+	expire = timeout + jiffies + 1;
 
 	init_timer(&timer);
 	timer.expires = expire;
@@ -1190,9 +1190,10 @@ unsigned int __sched schedule_timeout_ms
 	} else {
 		/*
 		 * msecs_to_jiffies() is a unit conversion, which truncates
-		 * (rounds down), so we need to add 1.
+		 * (rounds down), so we need to add 1, but this is taken
+		 * care of by schedule_timeout() now.
 		 */
-		expire_jifs = msecs_to_jiffies(timeout_msecs) + 1;
+		expire_jifs = msecs_to_jiffies(timeout_msecs);
 	}
 
 	expire_jifs = schedule_timeout(expire_jifs);
@@ -1675,7 +1676,7 @@ unregister_time_interpolator(struct time
  */
 void msleep(unsigned int msecs)
 {
-	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
+	unsigned long timeout = msecs_to_jiffies(msecs);
 
 	while (timeout) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -1691,7 +1692,7 @@ EXPORT_SYMBOL(msleep);
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
-	unsigned long timeout = msecs_to_jiffies(msecs) + 1;
+	unsigned long timeout = msecs_to_jiffies(msecs);
 
 	while (timeout && !signal_pending(current)) {
 		set_current_state(TASK_INTERRUPTIBLE);
