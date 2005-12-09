Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVLIRQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVLIRQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVLIRQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:16:43 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:52102
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932295AbVLIRQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:16:42 -0500
Subject: Re: [patch 00/21] hrtimer - High-resolution timer subsystem
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       rostedt@goodmis.org, johnstul@us.ibm.com, mingo@elte.hu
In-Reply-To: <Pine.LNX.4.61.0512070347450.1609@scrub.home>
References: <20051206000126.589223000@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512061628050.1610@scrub.home>
	 <1133908082.16302.93.camel@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0512070347450.1609@scrub.home>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 09 Dec 2005 18:23:00 +0100
Message-Id: <1134148980.16302.409.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for the late reply. I was travelling and cut off the net for a
while.

On Wed, 2005-12-07 at 13:18 +0100, Roman Zippel wrote:
> > It might turn out in the rework of the hrt bits that the list can go
> > away, but this is a nobrainer to do. (The very first unpublished version
> > of ktimers had no list, it got introduced during the hrt addon and
> > stayed there to make the hrt patch less intrusive.)
> 
> If it's such a nobrainer to remove it, why don't you add it later? As it 
> is right now, it's not needed and nobody but you knows what it's good for. 
> This way yoy make it only harder to review the code, if one stumbles over 
> these pieces all the time.

Well, if it makes it simpler for you to review the code.

But can you please explain to a code review unaware kernel developer
newbie like me, why this makes a lot of difference and why it makes it
so much easier to review ?

Actually the change adds more code lines and removes one field of the
hrtimer structure, but it has exactly the same functionality: Fast
access to the first expiring timer without walking the rb_tree.


 include/linux/hrtimer.h |    7 ++-----
 kernel/hrtimer.c        |   26 ++++++++++++++------------
 2 files changed, 16 insertions(+), 17 deletions(-)


Index: linux-2.6.15-rc5/include/linux/hrtimer.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/hrtimer.h
+++ linux-2.6.15-rc5/include/linux/hrtimer.h
@@ -49,8 +49,6 @@ struct hrtimer_base;
  * struct hrtimer - the basic hrtimer structure
  *
  * @node:	red black tree node for time ordered insertion
- * @list:	list head for easier access to the time ordered list,
- *		without walking the red black tree.
  * @expires:	the absolute expiry time in the hrtimers internal
  *		representation. The time is related to the clock on
  *		which the timer is based.
@@ -63,7 +61,6 @@ struct hrtimer_base;
  */
 struct hrtimer {
 	struct rb_node		node;
-	struct list_head	list;
 	ktime_t			expires;
 	enum hrtimer_state	state;
 	int			(*function)(void *);
@@ -78,7 +75,7 @@ struct hrtimer {
  *		to a base on another cpu.
  * @lock:	lock protecting the base and associated timers
  * @active:	red black tree root node for the active timers
- * @pending:	list of pending timers for simple time ordered access
+ * @first:	pointer to the timer node which expires first
  * @resolution:	the resolution of the clock, in nanoseconds
  * @get_time:	function to retrieve the current time of the clock
  * @curr_timer:	the timer which is executing a callback right now
@@ -87,7 +84,7 @@ struct hrtimer_base {
 	clockid_t		index;
 	spinlock_t		lock;
 	struct rb_root		active;
-	struct list_head	pending;
+	struct rb_node		*first;
 	unsigned long		resolution;
 	ktime_t			(*get_time)(void);
 	struct hrtimer		*curr_timer;
Index: linux-2.6.15-rc5/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rc5.orig/kernel/hrtimer.c
+++ linux-2.6.15-rc5/kernel/hrtimer.c
@@ -313,7 +313,6 @@ hrtimer_forward(struct hrtimer *timer, c
 static void enqueue_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
 {
 	struct rb_node **link = &base->active.rb_node;
-	struct list_head *prev = &base->pending;
 	struct rb_node *parent = NULL;
 	struct hrtimer *entry;
 
@@ -329,22 +328,23 @@ static void enqueue_hrtimer(struct hrtim
 		 */
 		if (timer->expires.tv64 < entry->expires.tv64)
 			link = &(*link)->rb_left;
-		else {
+		else
 			link = &(*link)->rb_right;
-			prev = &entry->list;
-		}
 	}
 
 	/*
-	 * Insert the timer to the rbtree and to the sorted list:
+	 * Insert the timer to the rbtree and check whether it
+	 * replaces the first pending timer
 	 */
 	rb_link_node(&timer->node, parent, link);
 	rb_insert_color(&timer->node, &base->active);
-	list_add(&timer->list, prev);
 
 	timer->state = HRTIMER_PENDING;
-}
 
+	if (!base->first || timer->expires.tv64 <
+	    rb_entry(base->first, struct hrtimer, node)->expires.tv64)
+		base->first = &timer->node;
+}
 
 /*
  * __remove_hrtimer - internal function to remove a timer
@@ -354,9 +354,11 @@ static void enqueue_hrtimer(struct hrtim
 static void __remove_hrtimer(struct hrtimer *timer, struct hrtimer_base *base)
 {
 	/*
-	 * Remove the timer from the sorted list and from the rbtree:
+	 * Remove the timer from the rbtree and replace the
+	 * first entry pointer if necessary.
 	 */
-	list_del(&timer->list);
+	if (base->first == &timer->node)
+		base->first = rb_next(&timer->node);
 	rb_erase(&timer->node, &base->active);
 }
 
@@ -528,16 +530,17 @@ int hrtimer_get_res(const clockid_t whic
 static inline void run_hrtimer_queue(struct hrtimer_base *base)
 {
 	ktime_t now = base->get_time();
+	struct rb_node *node;
 
 	spin_lock_irq(&base->lock);
 
-	while (!list_empty(&base->pending)) {
+	while ((node = base->first)) {
 		struct hrtimer *timer;
 		int (*fn)(void *);
 		int restart;
 		void *data;
 
-		timer = list_entry(base->pending.next, struct hrtimer, list);
+		timer = rb_entry(node, struct hrtimer, node);
 		if (now.tv64 <= timer->expires.tv64)
 			break;
 
@@ -590,7 +593,6 @@ static void __devinit init_hrtimers_cpu(
 
 	for (i = 0; i < MAX_HRTIMER_BASES; i++) {
 		spin_lock_init(&base->lock);
-		INIT_LIST_HEAD(&base->pending);
 		base++;
 	}
 }


> > > Nice, that you finally also come to that conclusion, after I said that 
> > > already for ages. (It's also interesting how you do that without 
> > > giving me any credit for it.)
> > 
> > Sorry if it was previously your idea and if we didnt credit you for it.
> > I did not keep track of each word said in these endless mail threads. We
> > credited every suggestion and idea which we picked up from you, see our
> > previous emails. If we missed one, it was definitely not intentional.
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112755827327101
> http://marc.theaimsgroup.com/?l=linux-kernel&m=112760582427537
> 
> A bit later ktime_t looked pretty much like the 64bit part of my ktimespec.
> I don't won't to imply any intention, but please try to see this from my 
> perspective, after this happens a number of times.

I have seen your and Ingos conversation on that and I dont want to add
more flames into this.

> > You define that absolute interval timers on clock realtime change their
> > behaviour when the initial time value is expired into relative timers
> > which are not affected by time settings. I have no idea how you came to
> > that interpretation of the spec. I completely disagree [but if you would
> > like I can go into more detail why I think it's wrong.]
> 
> Please do. I explained it in one of my patches:
> 
> [PATCH 5/9] remove relative timer from abs_list
> 
> When an absolute timer expires, it becomes a relative timer, so remove
> it from the abs_list.  The TIMER_ABSTIME flag for timer_settime()
> changes the interpretation of the it_value member, but it_interval is
> always a relative value and clock_settime() only affects absolute time
> services.

This is your interpretation and I disagree.

If I set up a timer with a 24 hour interval, which should go off
everyday at 6:00 AM, then I expect that this timer does this even when
the clock is set e.g. by daylight saving. I think, that this is a
completely valid interpretation and makes a lot of sense from a
practical point of view. The existing implementation does it that way
already, so why do we want to change this ?

Also you treat the interval relative to the current time of the callback
function:

timer->expires = ktime_add(timer->base->last_expired,
					   timr->it.real.incr);

This leads to a summing up error and even if the result is similar to
the summing up error of the current vanilla implementation I prefer a
solution which adds the interval to the previous set expiry time

timer->expires = ktime_add(timer->expires,
	        		   timr->it.real.incr);

The spec says:
"Also note that some implementations may choose to adjust time and/or
interval values to exactly match the ticks of the underlying clock."

So there is no requirement to do so. Of course you may, but this takes
simply the name "precision" ad absurdum.

> > Beside of that, the implementation is also completely broken. (You
> > rebase the timer from the realtime base to the monotonic base inside of
> > the timer callback function. On return you lock the realtime base and
> > enqueue the timer into the realtime queue, but the base field of the
> > timer points to the monotonic queue. It needs not much phantasy to get
> > this exploited into a crash.)
> 
> If you provide the wrong parameters, you can crash a lot of stuff in the 
> kernel. "exploited" usually implies it can be abused from userspace, which 
> is not the case here.

Thanks for teaching me what an "exploit" usally means! 

I intentionally wrote "exploited into a crash".

How do you think I got this to crash ? By hacking up some complex kernel
code ? No, simply by running my unmodified test scripts from user space
with completely valid and correct parameters. Of course its also
possible to write a program which actually exploits this.

The implementation is simply broken. Can you just accept this ?

> > Furthermore, your implementation is calculating the next expiry value
> > based on the current time of the expiration rather than on the previous
> > expected expiry time, which would be the natural thing to do. This
> > detail also explains the system-load dependent random drifting of
> > ptimers quite well.
> 
> Is this conclusion based on actual testing? The behaviour of ptimer should 
> be quite close to the old jiffie based timer, so I'm a bit at a loss here, 
> how you get to this conclusion. Please provide more details.

It is based on testing. Do you think I pulled numbers out of my nose ? 

But I have to admit that I did not look close enough into your code and
so I missed the ptimer_run_queue call inside of the lost jiffie loop.
Sorry, my conclusion was wrong. 

The problem seems to be related to the rebase code, which leads to a
wrong expiry value for clock realtime interval timers with the ABSTIME
flag set.

> > The changes you did to the timer locking code (also in timer.c) are racy
> > and simply exposable. Oleg's locking implementation is there for a good
> > reason.
> 
> Thomas, bringing up this issue is really weak. With Oleg's help it's 
> already solved, you don't have to warm it up. :(

I did not warm anything up. I was not aware that Oleg jumped already in
on this - I was not cc'ed and I really did not pay much attention on
LKML during this time. 
I'm familiar enough with locking, that I can recognize such a problem on
my own.

> > Neither do I understand the jiffie boundness you re-introduced all over
> > the place. The softirq code is called once per jiffy and the expiry is
> > checked versus the current time. Basing a new design on jiffies, where
> > the design intends to be easily extensible to high resolution clocks, is
> > wrong IMNSHO. Doing a high resolution extension on top of it is just
> > introducing a lot of #ifdef mess in places where none has to be. We had
> > that before, and dont want to go back there.
> 
> I don't understand where you get this from, I explicitely said that higher 
> resolution requires a better clock abstraction, bascially any place which 
> mentions TICK_NSEC has to be cleaned up like this. I'm at loss why you 
> think this requires "a lot of #ifdef mess".

Why do you need all this jiffie stuff in the first place? It is not
necessary at all. The hrtimer code does not contain a single reference
of jiffies and therefor it does not need anything to clean up. I
consider even a single high resolution timer related #ifdef outside of
hrtimer.c and the clock event abstraction as an unnecessary mess. Sure
you can replace the TICK_NSEC and ktime_to_jiffie stuff completely, but
I still do not see the point why it is necessary to put it there first.
It just makes it overly complex to review and understand :)

I'm happy that we at least agree that we need better clock abstraction
layers. How do you think does our existing high resolution timer
implementation work ? While you explicitely said that it is required, we
explicitely used exactly such a mechanism from the very first day.

Please stop your absurd schoolmasterly attempts to teach me stuff which
I'm well aware off. Can you please accept, that I exactly know what I'm
talking about?

> Anyway, thanks for finally responding, there seem have to piled up a 
> number of misconceptions, please give it some time to clear up.

Roman, I have no interest and no intention to spend any more of my
private time on a discussion like this.

I always was and I'm still up for a technical discussion and
cooperation. I'm not vengeful at all and if I ever meet you in person,
the first beers at the bar are on my bill.

But I seriously will ignore you completely, if you keep this tone and
attitude with me.

I'm well aware that LKML is not a nun convent, but the basic rules of
human behaviour and respect still apply.

	tglx


