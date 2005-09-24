Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVIXRTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVIXRTa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 13:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVIXRTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 13:19:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:61599 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932198AbVIXRT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 13:19:29 -0400
Date: Sat, 24 Sep 2005 10:19:28 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Message-ID: <20050924171928.GF3950@us.ibm.com>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924061500.GA24628@alpha.home.local>
X-Operating-System: Linux 2.6.14-rc2 (x86_64)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.09.2005 [08:15:00 +0200], Willy Tarreau wrote:
> On Fri, Sep 23, 2005 at 09:44:10PM -0700, Nish Aravamudan wrote:
> > > >        * that why (t * HZ) / 1000.
> > > >        */
> > > > -     jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
> > > > +     jtimeout = timeout < 0 || (timeout / 1000) >= (MAX_SCHEDULE_TIMEOUT / HZ) ?
> > > >               MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
> > >
> > > Here, I'm not certain that gcc will optimize the divide. It would be better
> > > anyway to write this which is equivalent, and a pure integer comparison :
> > >
> > > +       jtimeout = timeout < 0 || timeout >= 1000 * MAX_SCHEDULE_TIMEOUT / HZ ?
> > > >               MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
> > 
> > Just a question here, maybe it's dumb.
> 
> Your question is not dumb, this code is not trivial at all !
> 
> > * and / have the same priority in the order of operations, yes? If so,
> > won't the the 1000 * MAX_SCHEDULE_TIMEOUT overflow
> > (MAX_SCHEDULE_TIMEOUT is LONG_MAX)?
> 
> Yes it can, and that's why I said that gcc should send a warning when
> comparing an int with something too large for an int. But I should have
> forced the constant to be evaluated as long long. At the moment, the
> constant cannot overflow, but it can reach a value so high that
> timeout/1000 will never reach it. Example :

Ok, makes sense!

<snip>

> > In any case, this code is approaching unreadable with lots of jiffies
> > <--> human-time units manipulations done in non-standard ways, which
> > the updated sys_poll() also tries to avoid.
> 
> I've not checked sys_poll(), but I agree with you that it's rather
> difficult to imagine all corner cases this way.

Here is the patch I was referring to, adapted to the epoll use of
schedule_timeout(). A similar fix is in -mm for almost identical code in
sys_poll().

Description: The @timeout parameter to ep_poll() is in milliseconds but
we compare it to (MAX_SCHEDULE_TIMEOUT - 1000 / HZ), which is
(jiffies/jiffies-per-sec) or seconds. That seems blatantly broken.  This
led to improper overflow checking for @timeout. As Andrew Morton pointed
out in a similar fix for sys_poll(), the best solution is to to check
for potential overflow first, then either select an indefinite value or
convert @timeout.

To achieve this and clean-up the code, change the prototype of the
ep_poll() to make it clear that the parameter is in milliseconds and
rename jtimeout to timeout_jiffies to hold the corresonding jiffies
value.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 fs/eventpoll.c |   46 ++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 38 insertions(+), 8 deletions(-)

diff -urpN 2.6.14-rc2-mm1/fs/eventpoll.c 2.6.14-rc2-mm1-dev/fs/eventpoll.c
--- 2.6.14-rc2-mm1/fs/eventpoll.c	2005-09-21 23:50:28.000000000 -0700
+++ 2.6.14-rc2-mm1-dev/fs/eventpoll.c	2005-09-24 10:07:51.000000000 -0700
@@ -260,7 +260,7 @@ static int ep_events_transfer(struct eve
 			      struct epoll_event __user *events,
 			      int maxevents);
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
-		   int maxevents, long timeout);
+		   int maxevents, long timeout_msecs);
 static int eventpollfs_delete_dentry(struct dentry *dentry);
 static struct inode *ep_eventpoll_inode(void);
 static struct super_block *eventpollfs_get_sb(struct file_system_type *fs_type,
@@ -1494,11 +1494,12 @@ static int ep_events_transfer(struct eve
 
 
 static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
-		   int maxevents, long timeout)
+		   int maxevents, long timeout_msecs)
 {
 	int res, eavail;
+	int overflow;
 	unsigned long flags;
-	long jtimeout;
+	long timeout_jiffies;
 	wait_queue_t wait;
 
 	/*
@@ -1506,8 +1507,36 @@ static int ep_poll(struct eventpoll *ep,
 	 * and the overflow condition. The passed timeout is in milliseconds,
 	 * that why (t * HZ) / 1000.
 	 */
-	jtimeout = timeout == -1 || timeout > (MAX_SCHEDULE_TIMEOUT - 1000) / HZ ?
-		MAX_SCHEDULE_TIMEOUT: (timeout * HZ + 999) / 1000;
+
+	if (timeout_msecs) {
+		/*
+		 * We compare HZ with 1000 to work out which side of the
+		 * expression needs conversion.  Because we want to
+		 * avoid converting any value to a numerically higher
+		 * value, which could overflow.
+		 */
+#if HZ > 1000
+		overflow = timeout_msecs >=
+				jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
+#else
+		overflow = msecs_to_jiffies(timeout_msecs) >=
+				MAX_SCHEDULE_TIMEOUT;
+#endif
+
+		/*
+		 * If we would overflow in the conversion or a negative
+		 * timeout is requested, sleep indefinitely.
+		 */
+		if (overflow || timeout_msecs < 0)
+			timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
+		else
+			timeout_jiffies = msecs_to_jiffies(timeout_msecs) + 1;
+	} else {
+		/*
+		 * 0 millisecond requests become 0 jiffy requests
+		 */
+		timeout_jiffies = 0;
+	}
 
 retry:
 	write_lock_irqsave(&ep->lock, flags);
@@ -1529,7 +1558,7 @@ retry:
 			 * to TASK_INTERRUPTIBLE before doing the checks.
 			 */
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (!list_empty(&ep->rdllist) || !jtimeout)
+			if (!list_empty(&ep->rdllist) || !timeout_jiffies)
 				break;
 			if (signal_pending(current)) {
 				res = -EINTR;
@@ -1537,7 +1566,7 @@ retry:
 			}
 
 			write_unlock_irqrestore(&ep->lock, flags);
-			jtimeout = schedule_timeout(jtimeout);
+			timeout_jiffies = schedule_timeout(timeout_jiffies);
 			write_lock_irqsave(&ep->lock, flags);
 		}
 		remove_wait_queue(&ep->wq, &wait);
@@ -1556,7 +1585,8 @@ retry:
 	 * more luck.
 	 */
 	if (!res && eavail &&
-	    !(res = ep_events_transfer(ep, events, maxevents)) && jtimeout)
+	    !(res = ep_events_transfer(ep, events, maxevents)) &&
+	    timeout_jiffies)
 		goto retry;
 
 	return res;
