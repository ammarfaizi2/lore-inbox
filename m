Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVHDFO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVHDFO5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 01:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVHDFO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 01:14:57 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:53658 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261828AbVHDFOk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 01:14:40 -0400
Date: Wed, 3 Aug 2005 22:14:34 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       domen@coderock.org, linux-kernel@vger.kernel.org, clucas@rotomalug.org
Subject: [UPDATE PATCH] push rounding up of relative request to schedule_timeout()
Message-ID: <20050804051434.GA4520@us.ibm.com>
References: <Pine.LNX.4.61.0507231456000.3728@scrub.home> <20050723164310.GD4951@us.ibm.com> <Pine.LNX.4.61.0507231911540.3743@scrub.home> <20050723191004.GB4345@us.ibm.com> <Pine.LNX.4.61.0507232151150.3743@scrub.home> <20050727222914.GB3291@us.ibm.com> <Pine.LNX.4.61.0507310046590.3728@scrub.home> <20050801193522.GA24909@us.ibm.com> <Pine.LNX.4.61.0508031419000.3728@scrub.home> <20050804005147.GC4255@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050804005147.GC4255@us.ibm.com>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.08.2005 [17:51:47 -0700], Nishanth Aravamudan wrote:
> On 03.08.2005 [16:20:57 +0200], Roman Zippel wrote:
> > Hi,
> > 
> > On Mon, 1 Aug 2005, Nishanth Aravamudan wrote:
> > 
> > > +unsigned int __sched schedule_timeout_msecs(unsigned int timeout_msecs)
> > > +{
> > > +	unsigned long expire_jifs;
> > > +
> > > +	if (timeout_msecs == MAX_SCHEDULE_TIMEOUT_MSECS) {
> > > +		expire_jifs = MAX_SCHEDULE_TIMEOUT;
> > > +	} else {
> > > +		/*
> > > +		 * msecs_to_jiffies() is a unit conversion, which truncates
> > > +		 * (rounds down), so we need to add 1.
> > > +		 */
> > > +		expire_jifs = msecs_to_jiffies(timeout_msecs) + 1;
> > > +	}
> > > +
> > > +	expire_jifs = schedule_timeout(expire_jifs);
> > > +
> > > +	/*
> > > +	 * don't need to add 1 here, even though there is truncation,
> > > +	 * because we will add 1 if/when the value is sent back in
> > > +	 */
> > > +	return jiffies_to_msecs(expire_jifs);
> > > +}
> > 
> > As I already mentioned for msleep_interruptible this is a really terrible 
> > interface.
> > The "jiffies_to_msecs(msecs_to_jiffies(timeout_msecs) + 1)" case (when the 
> > process is immediately woken up again) makes the caller suspectible to 
> > timeout manipulations and requires constant reauditing, that no caller 
> > gets it wrong, so it's better to avoid this error source completely.
> 
> After some thought today, I realized the +1 case is not specific to
> milliseconds. It's just that it's only being done *correctly* in the
> milliseconds case...I think ;)

<snip>

> Description: Ensure that schedule_timeout() requests can not possibly
> expire early in the timeout case, by adding the requested relative jiffy
> value to the next value of jiffies. Currently, by adding to the current
> value of jiffies, we might actually expire a jiffy too early (in a
> corner case).

Sorry, I forgot that sys_nanosleep() also always adds 1 to the request
(to account for this same issue, I believe, as POSIX demands no early
return from nanosleep() calls). There are some other locations where
similar

	+ (t.tv_sec || t.tv_nsec)

rounding-ups occur. I'll fix those separately if this patch goes in.  I
change the one in sys_nanosleep() below to maintain the same latency as
we currently have. I also screwed up my layout in the previous
submission, sorry about that.

Description: Ensure that schedule_timeout() requests can not possibly
expire early in the timeout case, by adding the requested relative jiffy
value to the next value of jiffies. Currently, by adding to the current
value of jiffies, we might actually expire a jiffy too early (in a
corner case). Modify the callers of schedule_timeout() in timer.c to not
add 1 themselves.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 timer.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

--- 2.6.13-rc4-dev/kernel/timer.c	2005-08-01 12:31:53.000000000 -0700
+++ 2.6.13-rc5/kernel/timer.c	2005-08-03 22:05:16.000000000 -0700
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
@@ -1286,7 +1287,7 @@ asmlinkage long sys_nanosleep(struct tim
 	if ((t.tv_nsec >= 1000000000L) || (t.tv_nsec < 0) || (t.tv_sec < 0))
 		return -EINVAL;
 
-	expire = timespec_to_jiffies(&t) + (t.tv_sec || t.tv_nsec);
+	expire = timespec_to_jiffies(&t);
 	current->state = TASK_INTERRUPTIBLE;
 	expire = schedule_timeout(expire);
 
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

