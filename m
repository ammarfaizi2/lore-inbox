Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUFDJWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUFDJWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 05:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUFDJWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 05:22:24 -0400
Received: from fmr05.intel.com ([134.134.136.6]:10966 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S264414AbUFDJVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 05:21:39 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C44A15.48BE291F"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] One possible bugfix for CLOCK_REALTIME timer.
Date: Fri, 4 Jun 2004 17:21:14 +0800
Message-ID: <37FBBA5F3A361C41AB7CE44558C3448E045DCE7D@PDSMSX403.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] One possible bugfix for CLOCK_REALTIME timer.
Thread-Index: AcRJzBmpA+wKwyh8QqSneYabMgPNzAAPLgvg
From: "Hu, Boris" <boris.hu@intel.com>
To: "George Anzinger" <george@mvista.com>
Cc: <drepper@redhat.com>, "Li, Adam" <adam.li@intel.com>,
       <linux-kernel@vger.kernel.org>, "Hu, Boris" <boris.hu@intel.com>
X-OriginalArrivalTime: 04 Jun 2004 09:21:15.0506 (UTC) FILETIME=[4923AD20:01C44A15]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C44A15.48BE291F
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Here is one update version. wall_to_monotonic copy has been moved to
k_itimer. Thanks.=20

diff -urN -X dontdiff linux-2.6.6/include/linux/posix-timers.h
linux-2.6.6.dev/include/linux/posix-timers.h
--- linux-2.6.6/include/linux/posix-timers.h	2004-06-04
15:48:33.000000000 +0800
+++ linux-2.6.6.dev/include/linux/posix-timers.h	2004-06-04
10:40:10.000000000 +0800
@@ -1,9 +1,14 @@
 #ifndef _linux_POSIX_TIMERS_H
 #define _linux_POSIX_TIMERS_H
=20
+#include <linux/spinlock.h>
+#include <linux/list.h>
+
 struct k_clock {
 	int res;		/* in nano seconds */
-	int (*clock_set) (struct timespec * tp);
+        struct list_head abs_timer_list;
+        spinlock_t abs_timer_lock;
+        int (*clock_set) (struct timespec * tp);
 	int (*clock_get) (struct timespec * tp);
 	int (*nsleep) (int flags,
 		       struct timespec * new_setting,
diff -urN -X dontdiff linux-2.6.6/include/linux/sched.h
linux-2.6.6.dev/include/linux/sched.h
--- linux-2.6.6/include/linux/sched.h	2004-06-04 15:48:33.000000000
+0800
+++ linux-2.6.6.dev/include/linux/sched.h	2004-06-04
10:39:53.000000000 +0800
@@ -342,6 +342,8 @@
 	struct task_struct *it_process;	/* process to send signal to */
 	struct timer_list it_timer;
 	struct sigqueue *sigq;		/* signal queue entry. */
+        struct list_head abs_timer_entry; /* clock abs_timer_list */
+        struct timespec wall_to_monotonic_prev;
 };
=20
=20
diff -urN -X dontdiff linux-2.6.6/kernel/posix-timers.c
linux-2.6.6.dev/kernel/posix-timers.c
--- linux-2.6.6/kernel/posix-timers.c	2004-06-04 15:48:33.000000000
+0800
+++ linux-2.6.6.dev/kernel/posix-timers.c	2004-06-04
15:48:20.000000000 +0800
@@ -7,6 +7,9 @@
  *
  *			     Copyright (C) 2002 2003 by MontaVista
Software.
  *
+ * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
+ *                           Copyright (C) 2004 Boris Hu
+ *                           =20
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or
(at
@@ -95,7 +98,7 @@
 # define set_timer_inactive(tmr) \
 		do { \
 			(tmr)->it_timer.entry.prev =3D (void
*)TIMER_INACTIVE; \
-		} while (0)
+                } while (0)
 #else
 # define timer_active(tmr) BARFY	// error to use outside of SMP
 # define set_timer_inactive(tmr) do { } while (0)
@@ -200,7 +203,9 @@
  */
 static __init int init_posix_timers(void)
 {
-	struct k_clock clock_realtime =3D {.res =3D CLOCK_REALTIME_RES };
+	struct k_clock clock_realtime =3D {.res =3D CLOCK_REALTIME_RES,
+                .abs_timer_lock =3D SPIN_LOCK_UNLOCKED

+        };
 	struct k_clock clock_monotonic =3D {.res =3D CLOCK_REALTIME_RES,
 		.clock_get =3D do_posix_clock_monotonic_gettime,
 		.clock_set =3D do_posix_clock_monotonic_settime
@@ -212,7 +217,6 @@
 	posix_timers_cache =3D kmem_cache_create("posix_timers_cache",
 					sizeof (struct k_itimer), 0, 0,
0, 0);
 	idr_init(&posix_timers_id);
-
 	return 0;
 }
=20
@@ -360,6 +364,11 @@
  	set_timer_inactive(timr);
 	timer_notify_task(timr);
 	unlock_timer(timr, flags);
+        if (CLOCK_REALTIME =3D=3D timr->it_clock) {
+
spin_lock(&posix_clocks[CLOCK_REALTIME].abs_timer_lock);
+                list_del_init(&timr->abs_timer_entry);
+
spin_unlock(&posix_clocks[CLOCK_REALTIME].abs_timer_lock);
+        }       =20
 }
=20
=20
@@ -388,6 +397,7 @@
 		return;
 	}
 	posix_clocks[clock_id] =3D *new_clock;
+        INIT_LIST_HEAD(&posix_clocks[clock_id].abs_timer_list);
 }
=20
 static struct k_itimer * alloc_posix_timer(void)
@@ -402,6 +412,7 @@
 		kmem_cache_free(posix_timers_cache, tmr);
 		tmr =3D 0;
 	}
+        INIT_LIST_HEAD(&tmr->abs_timer_entry);
 	return tmr;
 }
=20
@@ -787,6 +798,7 @@
 {
 	struct k_clock *clock =3D &posix_clocks[timr->it_clock];
 	u64 expire_64;
+        unsigned long seq;
=20
 	if (old_setting)
 		do_timer_gettime(timr, old_setting);
@@ -813,6 +825,11 @@
 #else
 	del_timer(&timr->it_timer);
 #endif
+        if (CLOCK_REALTIME =3D=3D timr->it_clock) {
+                spin_lock(&clock->abs_timer_lock);
+                list_del_init(&timr->abs_timer_entry);
+                spin_unlock(&clock->abs_timer_lock);
+        }
 	timr->it_requeue_pending =3D (timr->it_requeue_pending + 2) &=20
 		~REQUEUE_PENDING;
 	timr->it_overrun_last =3D 0;
@@ -834,7 +851,6 @@
 	tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
 	timr->it_incr =3D (unsigned long)expire_64;
=20
-
 	/*
 	 * For some reason the timer does not fire immediately if
expires is
 	 * equal to jiffies, so the timer notify function is called
directly.
@@ -843,8 +859,21 @@
 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) !=3D SIGEV_NONE))
{
 		if (timr->it_timer.expires =3D=3D jiffies)
 			timer_notify_task(timr);
-		else
+		else {
 			add_timer(&timr->it_timer);
+                        if (flags & TIMER_ABSTIME &&
+                            timr->it_clock =3D=3D CLOCK_REALTIME) {
+                                do {
+                                        seq =3D
read_seqbegin(&xtime_lock);
+                                        timr->wall_to_monotonic_prev =
=3D
+                                                wall_to_monotonic;
+                                } while (read_seqretry(&xtime_lock,
seq));
+                                spin_lock(&clock->abs_timer_lock);
+                                list_add_tail(&(timr->abs_timer_entry),
+
&(clock->abs_timer_list));
+                                spin_unlock(&clock->abs_timer_lock);
+                        }
+                }
 	}
 	return 0;
 }
@@ -875,10 +904,10 @@
 	if (!timr)
 		return -EINVAL;
=20
-	if (!posix_clocks[timr->it_clock].timer_set)
+	if (!posix_clocks[timr->it_clock].timer_set)=20
 		error =3D do_timer_settime(timr, flags, &new_spec, rtn);
 	else
-		error =3D posix_clocks[timr->it_clock].timer_set(timr,
+                error =3D posix_clocks[timr->it_clock].timer_set(timr,
 							       flags,
=20
&new_spec, rtn);
 	unlock_timer(timr, flag);
@@ -911,6 +940,11 @@
 #else
 	del_timer(&timer->it_timer);
 #endif
+        if (CLOCK_REALTIME =3D=3D timer->it_clock) {
+
spin_lock(&posix_clocks[CLOCK_REALTIME].abs_timer_lock);
+                list_del_init(&timer->abs_timer_entry);
+
spin_unlock(&posix_clocks[CLOCK_REALTIME].abs_timer_lock);
+        }       =20
 	return 0;
 }
=20
@@ -1086,10 +1120,10 @@
 {
 	struct timespec new_tp;
=20
-	if ((unsigned) which_clock >=3D MAX_CLOCKS ||
+        if ((unsigned) which_clock >=3D MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
-	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
+        if (copy_from_user(&new_tp, tp, sizeof (*tp)))
 		return -EFAULT;
 	if (posix_clocks[which_clock].clock_set)
 		return posix_clocks[which_clock].clock_set(&new_tp);
@@ -1159,7 +1193,55 @@
=20
 void clock_was_set(void)
 {
+        struct k_clock *clock =3D &posix_clocks[CLOCK_REALTIME];
+        struct k_itimer *timr, *tmp;
+        struct timespec delta;
+        u64 exp =3D 0;
+        unsigned long seq;
+       =20
 	wake_up_all(&nanosleep_abs_wqueue);
+
+        /*
+         * Check if there exist TIMER_ABSTIME timers to correct.
+         */
+        if (list_empty(&clock->abs_timer_list))
+                return;
+
+        spin_lock(&clock->abs_timer_lock);
+        list_for_each_entry_safe(timr, tmp,
+                                 &clock->abs_timer_list,
+                                 abs_timer_entry) {
+                do {
+                        seq =3D read_seqbegin(&xtime_lock);
+                        delta.tv_sec =3D
+                                wall_to_monotonic.tv_sec
+                                - timr->wall_to_monotonic_prev.tv_sec;
+                        delta.tv_nsec =3D=20
+                                wall_to_monotonic.tv_nsec
+                                - timr->wall_to_monotonic_prev.tv_nsec;
+                } while (read_seqretry(&xtime_lock, seq));
+               =20
+                while (delta.tv_nsec >=3D NSEC_PER_SEC) {
+                        delta.tv_sec ++;
+                        delta.tv_nsec -=3D NSEC_PER_SEC;
+                }
+                while (delta.tv_nsec < 0) {
+                        delta.tv_sec --;
+                        delta.tv_nsec +=3D NSEC_PER_SEC;
+                }
+                do {
+                        seq =3D read_seqbegin(&xtime_lock);
+                        timr->wall_to_monotonic_prev =3D
wall_to_monotonic;
+                } while (read_seqretry(&xtime_lock, seq));
+                        =20
+                tstojiffie(&delta, clock->res, &exp);
+                if (del_timer(&timr->it_timer)) { /* the timer has not
run */
+                        timr->it_timer.expires +=3D exp;=20
+                        add_timer(&timr->it_timer);
+                } else=20
+                        list_del_init(&timr->abs_timer_entry);
+        }
+        spin_unlock(&clock->abs_timer_lock);
 }
=20
 long clock_nanosleep_restart(struct restart_block *restart_block);

>=20
> Hu, Boris wrote:
> > Thanks for your detailed comments. :)
> >
> >
> >>Hu, Boris wrote:
> >>
> >>> <<posix-abs_timer-bugfix.diff>> George,
> >>>
> >>>There is one bug of CLOCK_REALTIME timer reported by Adam at
> >>>http://sources.redhat.com/ml/libc-alpha/2004-05/msg00177.html.
> >>>
> >>>Here is one possible bugfix and it is against linux-2.6.6. All
> >>>TIMER_ABSTIME cloks will be collected in k_clock struct and updated
> >
> > in
> >
> >>>sys_clock_settime. Could you review it? Thanks.
> >>
> >>Thanks for the poke :).   Could you make the following changes:
> >>
> >>First, put the list in the posix timer structure (k_itimer), not in
> >>timer_list.
> >>  This means one more dereference when doing things, but it does not
> >
> > push
> >
> >>into
> >>the timer_list structure which is mostly used for other things.
> >
> >
> > Done.
> >
> >
> >>Second, I don't see the timer being removed from the list (should
> >
> > happen
> >
> >>when
> >>ever it is inactive).  Timers that repeat should be out of the list
> >
> > while
> >
> >>waiting for the signal to be picked up and put back in when
add_timer
> >
> > is
> >
> >>again
> >>called.
> >
> >
> > I tried to add the removed codes to set_timer_inactive() but it
would
> > trigger a strange oops. I am still investigating on it. Is there any
> > recommending places except set_timer_inactive()?
>=20
> Hm,  set_timer_inactive() is called from the timer create routine.
Should
> not
> need to remove it here...  Also, this function is used for SMP issues
and,
> in
> some cases (do_timer_settime is one) it is not called if not on an SMP
> system.
> Also, it seems not to be called from sys_timer_delete().  This last
would
> be a
> real problem as we are about to return the memory the list runs
through it.
>=20
> So, I think you will just have to find the places were we delete a
timer,
> that
> and the timer call back function should do it.
>=20
> >
> >
> >>Also, you should test to see if the clock is one that can be set
prior
> >
> > to
> >
> >>putting the timer in the abs timer list.  We must not correct timers
> >
> > on
> >
> >>CLOCK_MONOTONIC.
> >
> >
> >
> > Done.
> >
> >
> >>Now, for the correction.  Sys_clock_settime() is the wrong place for
> >
> > this
> >
> >>as the
> >>clock can also be set a number of other ways.  The right place is in
> >>clock_was_set(), which is called if time is set in any of the
several
> >
> > ways.
> >
> >>The
> >>next thing is to determine how far the clock was moved.  I think the
> >
> > best
> >
> >>way to
> >>do this is to keep a copy of the wall_to_monotonic var in a private
> >>location.
> >>This should be set to be exactly wall_to_monotonic when the system
is
> >>booted (in
> >>the same function you are setting up the clock lists) and at the end
> >
> > of
> >
> >>clock_was_set().  When clock_was_set() is called the difference
> >
> > between
> >
> >>this
> >>value and wall_to_monotonic is exactly how far the clock was moved.
> >
> > (Be
> >
> >>careful
> >>on the sign of this movement.)
> >>
> >
> >
> > Done.
> >
> >
> >>Finally, be careful about races.  Timers can expire while
> >
> > clock_was_set()
> >
> >>is
> >>running.  The removal code should take the timer lock as well as the
> >>abs_time
> >>list lock (at least I think this would be wise, but I could be wrong
> >
> > here).
> >
> >
> > IMHO, we need not take the timer locks. We del_timer() first and if
the
> > timer has expired, we simply removed it from the abs_timer_list
which is
> > protected by abs_timer_lock.
>=20
> Me thinks you will need to do a bit more to convince me that locks are
not
> needed here.  Lets see if I can explain my concerns.
>=20
> First, I think the clock_was_set() function needs to serialize it self
so
> only
> one cpu/ task can be in it at a time.  This, I think, can/is done with
the
> abs
> list lock.
>=20
> Second there is the possibility that a timer in the list will already
be
> set via
> the correct time.  To avoid this possibility I suggest (this is a
change
> from my
> suggestion of yesterday) putting the current value of
wall_to_monotonic in
> the
> k_timer structure when the timer is calculated.  This value must be
> obtained
> under the xtime read lock (which we already take to calculate the
timer).
> In
> this way of doing things, clock_was_set() would take the xtime write
lock,
> possibly for each entry in the abs list.  It would use the
> wall_to_monotonic
> time in the structure rather than keeping a local copy, and it would
> update that
> time once the correction was made.
>=20
> We still haven't covered the case where time is set while a timer is
being
> set.
>   I.e. where the expire time is calculated but the result has not yet
been
> put
> in the timer structure and add_timer has not yet been called.  It is
here
> that
> the timer lock would seem to be the right thing to do.  We would
require
> that
> the timer be put in the abs list while the xtime read lock is held
> (careful here
> as this is now a sequence lock and we only want to add the timer to
the
> list
> once).  This is complicated.  We must take the locks in the same order
so
> we can
> not take the timer lock while holding the abs list lock.  The, IMHO,
> simple
> thing to do is to have clock_was_set() copy the whole abs list (this
is
> just a
> simple pointer manipulation).  Then it can scan this list and move
each
> entry to
> the abs list as it updates the timers.  The timer lock would be taken
for
> each
> timer during this update.  This is to allow timers that are on the way
to
> add_timer to get there.  This code should not remove timers from the
abs
> list,
> or rather, each timer it finds in the moved list should be put back in
the
> abs
> list even if it is not in the system timer list (it just means that
> someone else
> is removing it).  Both the removal from the moved list and the insert
into
> the
> abs list should be done under the same abs list lock but it must be
> dropped
> while taking the timer lock.
>=20
> There is a possible race here with the timer delete code.  Here is how
I
> would
> solve this.  First, with the list being moved, you need only be
concerned
> with
> the first entry in the list (as you will remove it as part of
processing
> and
> then do the next first entry).  So, first lock the abs list.  Then
find
> the
> timer ID for the first entry.  Unlock the abs list, and lock the timer
> using the
> ID.  The existing lock code will take care of possible races WRT
existence.
> Once the timer is locked, re lock the abs list and if the given timer
is
> still
> the first entry, a.) remove it b.) if the system delete timer fails,
just
> take
> the abs list lock and reinsert the timer, else under the xtime
readlock
> compare
> wall_to_monotonic with the timers value c.) and put it in the abs list
and
> the
> add_timer list.
>=20
> Note that the case of an expired timer that is still in the abs list
is
> handled
> by just reinserting the timer.  This means that the expire call back
code
> needs
> to check for a clock reset that may have made the expire invalid.
>=20
> I am sure there are other ways of doing this, but the main locking
issues
> are:
>=20
> 1.) Getting the timer's value pegged to a given clock set value (done
by
> copying
> wall_to_monotonic to the k_timer struct).,  This must be done under
the
> xtime
> read lock.
>=20
> 2.) Covering the race between the timer adjustment code and possible
POSIX
> timer
> deletion (done by NOT assuming the timer is there just because we
found it
> in
> the abs timer list, although we do pin it down long enough to get it's
ID
> by
> locking this list).  This also requires us to take the timer lock
which
> means we
> have to drop the abs list lock.
>=20
> 3.) Covering the race between the timer expiring during the system
clock
> setting
> processing.  Done by having the timer call back code verify that the
same
> value
> of wall_to_monotonic is still in play.
>=20
> We note that the time used for NOW in the repeating timer update needs
to
> also
> satisfy 1. above.
>=20
> And in passing, note that the overrun count will show something going
on
> when
> the clock is moved forward and not when it is move backward.
>=20
> >
> >
> >>And a minor issue, the community seems to prefer the C comment style
> >
> > to
> >
> >>the C++
> >>style of comments...
> >>
> >
> >
> > Done.
> >
> >
> >>Thanks for your effort in this matter.
> >>
> >>George
> >>
> >>>
> >>>diff -urN -X rt.ia32/base/dontdiff
> >>>linux-2.6.6/include/linux/posix-timers.h
> >>>linux-2.6.6.dev/include/linux/posix-timers.h
> >>>--- linux-2.6.6/include/linux/posix-timers.h	2004-05-10
> >>>10:32:29.000000000 +0800
> >>>+++ linux-2.6.6.dev/include/linux/posix-timers.h	2004-06-02
> >>>10:30:57.000000000 +0800
> >>>@@ -1,9 +1,14 @@
> >>> #ifndef _linux_POSIX_TIMERS_H
> >>> #define _linux_POSIX_TIMERS_H
> >>>
> >>>+#include <linux/list.h>
> >>>+#include <linux/spinlock.h>
> >>>+
> >>> struct k_clock {
> >>> 	int res;		/* in nano seconds */
> >>>-	int (*clock_set) (struct timespec * tp);
> >>>+        struct list_head abs_timer_list;
> >>>+        spinlock_t abs_timer_lock;
> >>>+        int (*clock_set) (struct timespec * tp);
> >>> 	int (*clock_get) (struct timespec * tp);
> >>> 	int (*nsleep) (int flags,
> >>> 		       struct timespec * new_setting,
> >>>diff -urN -X rt.ia32/base/dontdiff
linux-2.6.6/include/linux/timer.h
> >>>linux-2.6.6.dev/include/linux/timer.h
> >>>--- linux-2.6.6/include/linux/timer.h	2004-05-10
> >
> > 10:32:54.000000000
> >
> >>>+0800
> >>>+++ linux-2.6.6.dev/include/linux/timer.h	2004-06-02
> >>>19:16:08.000000000 +0800
> >>>@@ -9,6 +9,7 @@
> >>>
> >>> struct timer_list {
> >>> 	struct list_head entry;
> >>>+	struct list_head abs_timer_entry;
> >>> 	unsigned long expires;
> >>>
> >>> 	spinlock_t lock;
> >>>diff -urN -X rt.ia32/base/dontdiff
linux-2.6.6/kernel/posix-timers.c
> >>>linux-2.6.6.dev/kernel/posix-timers.c
> >>>--- linux-2.6.6/kernel/posix-timers.c	2004-05-10
> >
> > 10:32:37.000000000
> >
> >>>+0800
> >>>+++ linux-2.6.6.dev/kernel/posix-timers.c	2004-06-02
> >>>19:12:31.000000000 +0800
> >>>@@ -7,6 +7,9 @@
> >>>  *
> >>>  *			     Copyright (C) 2002 2003 by
MontaVista
> >>>Software.
> >>>  *
> >>>+ * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
> >>>+ *                           Copyright (C) 2004 Boris Hu
> >>>+ *
> >>>  * This program is free software; you can redistribute it and/or
> >
> > modify
> >
> >>>  * it under the terms of the GNU General Public License as
> >
> > published by
> >
> >>>  * the Free Software Foundation; either version 2 of the License,
> >
> > or
> >
> >>>(at
> >>>@@ -200,7 +203,9 @@
> >>>  */
> >>> static __init int init_posix_timers(void)
> >>> {
> >>>-	struct k_clock clock_realtime =3D {.res =3D CLOCK_REALTIME_RES };
> >>>+	struct k_clock clock_realtime =3D {.res =3D CLOCK_REALTIME_RES,
> >>>+                .abs_timer_lock =3D SPIN_LOCK_UNLOCKED
> >>>
> >>>+        };
> >>> 	struct k_clock clock_monotonic =3D {.res =3D CLOCK_REALTIME_RES,
> >>> 		.clock_get =3D do_posix_clock_monotonic_gettime,
> >>> 		.clock_set =3D do_posix_clock_monotonic_settime
> >>>@@ -388,6 +393,7 @@
> >>> 		return;
> >>> 	}
> >>> 	posix_clocks[clock_id] =3D *new_clock;
> >>>+        INIT_LIST_HEAD(&posix_clocks[clock_id].abs_timer_list);
> >>> }
> >>>
> >>> static struct k_itimer * alloc_posix_timer(void)
> >>>@@ -843,8 +849,15 @@
> >>> 	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) !=3D SIGEV_NONE))
> >>>{
> >>> 		if (timr->it_timer.expires =3D=3D jiffies)
> >>> 			timer_notify_task(timr);
> >>>-		else
> >>>+		else {
> >>> 			add_timer(&timr->it_timer);
> >>>+                        if (flags & TIMER_ABSTIME) {
> >>>+                                spin_lock(&clock->abs_timer_lock);
> >>>+
> >>>list_add_tail(&(timr->it_timer.abs_timer_entry),
> >>>+
> >>>&(clock->abs_timer_list));
> >>>+
> >
> > spin_unlock(&clock->abs_timer_lock);
> >
> >>>+                        }
> >>>+                }
> >>> 	}
> >>> 	return 0;
> >>> }
> >>>@@ -1085,16 +1098,61 @@
> >>> sys_clock_settime(clockid_t which_clock, const struct timespec
> >
> > __user
> >
> >>>*tp)
> >>> {
> >>> 	struct timespec new_tp;
> >>>+        struct timespec before, now;
> >>>+        struct k_clock *clock;
> >>>+        long ret;
> >>>+        struct timer_list *timer, *tmp;
> >>>+        struct timespec delta;
> >>>+        u64 exp =3D 0;
> >>>
> >>>-	if ((unsigned) which_clock >=3D MAX_CLOCKS ||
> >>>+        if ((unsigned) which_clock >=3D MAX_CLOCKS ||
> >>> 					!posix_clocks[which_clock].res)
> >>> 		return -EINVAL;
> >>>-	if (copy_from_user(&new_tp, tp, sizeof (*tp)))
> >>>+
> >>>+        clock =3D &posix_clocks[which_clock];
> >>>+
> >>>+        if (copy_from_user(&new_tp, tp, sizeof (*tp)))
> >>> 		return -EFAULT;
> >>> 	if (posix_clocks[which_clock].clock_set)
> >>> 		return posix_clocks[which_clock].clock_set(&new_tp);
> >>>
> >>>-	return do_sys_settimeofday(&new_tp, NULL);
> >>>+        do_posix_gettime(clock, &before);
> >>>+
> >>>+	ret =3D do_sys_settimeofday(&new_tp, NULL);
> >>>+
> >>>+        /*
> >>>+         * Check if there exist TIMER_ABSTIME timers to update.
> >>>+         */
> >>>+        if (which_clock !=3D CLOCK_REALTIME ||
> >>>+            list_empty(&clock->abs_timer_list))
> >>>+                return ret;
> >>>+
> >>>+        do_posix_gettime(clock, &now);
> >>>+        delta.tv_sec =3D before.tv_sec - now.tv_sec;
> >>>+        delta.tv_nsec =3D before.tv_nsec - now.tv_nsec;
> >>>+        while (delta.tv_nsec >=3D NSEC_PER_SEC) {
> >>>+                delta.tv_sec ++;
> >>>+                delta.tv_nsec -=3D NSEC_PER_SEC;
> >>>+        }
> >>>+        while (delta.tv_nsec < 0) {
> >>>+                delta.tv_sec --;
> >>>+                delta.tv_nsec +=3D NSEC_PER_SEC;
> >>>+        }
> >>>+
> >>>+        tstojiffie(&delta, clock->res, &exp);
> >>>+
> >>>+        spin_lock(&(clock->abs_timer_lock));
> >>>+        list_for_each_entry_safe(timer, tmp,
> >>>+                                 &clock->abs_timer_list,
> >>>+                                 abs_timer_entry) {
> >>>+                if (timer && del_timer(timer)) { //the timer has
> >
> > not
> >
> >>>run
> >>>+                        timer->expires +=3D exp;
> >>>+                        add_timer(timer);
> >>>+                } else
> >>>+                        list_del(&timer->abs_timer_entry);
> >>>+        }
> >>>+        spin_unlock(&(clock->abs_timer_lock));
> >>>+        return ret;
> >>> }
> >>>
> >>> asmlinkage long
> >>>
> >>>Good Luck !
> >>>Boris Hu (Hu Jiangtao)
> >>>Intel China Software Center
> >>>86-021-5257-4545#1277
> >>>iNET: 8-752-1277
> >>>************************************
> >>>There are my thoughts, not my employer's.
> >>>************************************
> >>>"gpg --recv-keys --keyserver wwwkeys.pgp.net 0FD7685F"
> >>>{0FD7685F:CFD6 6F5C A2CB 7881 725B  CEA0 956F 9F14 0FD7 685F}
> >>>
> >>>
> >>
> >>--
> >>George Anzinger   george@mvista.com
> >>High-res-timers:  http://sourceforge.net/projects/high-res-timers/
> >>Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
> >
> >
> >
> >
>=20
> --
> George Anzinger   george@mvista.com
> High-res-timers:  http://sourceforge.net/projects/high-res-timers/
> Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml



------_=_NextPart_001_01C44A15.48BE291F
Content-Type: application/octet-stream;
	name="posix-abs_timer-bugfix-0.2.diff"
Content-Transfer-Encoding: base64
Content-Description: posix-abs_timer-bugfix-0.2.diff
Content-Disposition: attachment;
	filename="posix-abs_timer-bugfix-0.2.diff"

ZGlmZiAtdXJOIC1YIGRvbnRkaWZmIGxpbnV4LTIuNi42L2luY2x1ZGUvbGludXgvcG9zaXgtdGlt
ZXJzLmggbGludXgtMi42LjYuZGV2L2luY2x1ZGUvbGludXgvcG9zaXgtdGltZXJzLmgKLS0tIGxp
bnV4LTIuNi42L2luY2x1ZGUvbGludXgvcG9zaXgtdGltZXJzLmgJMjAwNC0wNi0wNCAxNTo0ODoz
My4wMDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi42LmRldi9pbmNsdWRlL2xpbnV4L3Bvc2l4
LXRpbWVycy5oCTIwMDQtMDYtMDQgMTA6NDA6MTAuMDAwMDAwMDAwICswODAwCkBAIC0xLDkgKzEs
MTQgQEAKICNpZm5kZWYgX2xpbnV4X1BPU0lYX1RJTUVSU19ICiAjZGVmaW5lIF9saW51eF9QT1NJ
WF9USU1FUlNfSAogCisjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4KKyNpbmNsdWRlIDxsaW51
eC9saXN0Lmg+CisKIHN0cnVjdCBrX2Nsb2NrIHsKIAlpbnQgcmVzOwkJLyogaW4gbmFubyBzZWNv
bmRzICovCi0JaW50ICgqY2xvY2tfc2V0KSAoc3RydWN0IHRpbWVzcGVjICogdHApOworICAgICAg
ICBzdHJ1Y3QgbGlzdF9oZWFkIGFic190aW1lcl9saXN0OworICAgICAgICBzcGlubG9ja190IGFi
c190aW1lcl9sb2NrOworICAgICAgICBpbnQgKCpjbG9ja19zZXQpIChzdHJ1Y3QgdGltZXNwZWMg
KiB0cCk7CiAJaW50ICgqY2xvY2tfZ2V0KSAoc3RydWN0IHRpbWVzcGVjICogdHApOwogCWludCAo
Km5zbGVlcCkgKGludCBmbGFncywKIAkJICAgICAgIHN0cnVjdCB0aW1lc3BlYyAqIG5ld19zZXR0
aW5nLApkaWZmIC11ck4gLVggZG9udGRpZmYgbGludXgtMi42LjYvaW5jbHVkZS9saW51eC9zY2hl
ZC5oIGxpbnV4LTIuNi42LmRldi9pbmNsdWRlL2xpbnV4L3NjaGVkLmgKLS0tIGxpbnV4LTIuNi42
L2luY2x1ZGUvbGludXgvc2NoZWQuaAkyMDA0LTA2LTA0IDE1OjQ4OjMzLjAwMDAwMDAwMCArMDgw
MAorKysgbGludXgtMi42LjYuZGV2L2luY2x1ZGUvbGludXgvc2NoZWQuaAkyMDA0LTA2LTA0IDEw
OjM5OjUzLjAwMDAwMDAwMCArMDgwMApAQCAtMzQyLDYgKzM0Miw4IEBACiAJc3RydWN0IHRhc2tf
c3RydWN0ICppdF9wcm9jZXNzOwkvKiBwcm9jZXNzIHRvIHNlbmQgc2lnbmFsIHRvICovCiAJc3Ry
dWN0IHRpbWVyX2xpc3QgaXRfdGltZXI7CiAJc3RydWN0IHNpZ3F1ZXVlICpzaWdxOwkJLyogc2ln
bmFsIHF1ZXVlIGVudHJ5LiAqLworICAgICAgICBzdHJ1Y3QgbGlzdF9oZWFkIGFic190aW1lcl9l
bnRyeTsgLyogY2xvY2sgYWJzX3RpbWVyX2xpc3QgKi8KKyAgICAgICAgc3RydWN0IHRpbWVzcGVj
IHdhbGxfdG9fbW9ub3RvbmljX3ByZXY7CiB9OwogCiAKZGlmZiAtdXJOIC1YIGRvbnRkaWZmIGxp
bnV4LTIuNi42L2tlcm5lbC9wb3NpeC10aW1lcnMuYyBsaW51eC0yLjYuNi5kZXYva2VybmVsL3Bv
c2l4LXRpbWVycy5jCi0tLSBsaW51eC0yLjYuNi9rZXJuZWwvcG9zaXgtdGltZXJzLmMJMjAwNC0w
Ni0wNCAxNTo0ODozMy4wMDAwMDAwMDAgKzA4MDAKKysrIGxpbnV4LTIuNi42LmRldi9rZXJuZWwv
cG9zaXgtdGltZXJzLmMJMjAwNC0wNi0wNCAxNTo0ODoyMC4wMDAwMDAwMDAgKzA4MDAKQEAgLTcs
NiArNyw5IEBACiAgKgogICoJCQkgICAgIENvcHlyaWdodCAoQykgMjAwMiAyMDAzIGJ5IE1vbnRh
VmlzdGEgU29mdHdhcmUuCiAgKgorICogMjAwNC0wNi0wMSAgRml4IENMT0NLX1JFQUxUSU1FIGNs
b2NrL3RpbWVyIFRJTUVSX0FCU1RJTUUgYnVnLgorICogICAgICAgICAgICAgICAgICAgICAgICAg
ICBDb3B5cmlnaHQgKEMpIDIwMDQgQm9yaXMgSHUKKyAqICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIAogICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vciBtb2RpZnkKICAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CiAgKiB0aGUgRnJlZSBTb2Z0d2Fy
ZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvciAoYXQKQEAg
LTk1LDcgKzk4LDcgQEAKICMgZGVmaW5lIHNldF90aW1lcl9pbmFjdGl2ZSh0bXIpIFwKIAkJZG8g
eyBcCiAJCQkodG1yKS0+aXRfdGltZXIuZW50cnkucHJldiA9ICh2b2lkICopVElNRVJfSU5BQ1RJ
VkU7IFwKLQkJfSB3aGlsZSAoMCkKKyAgICAgICAgICAgICAgICB9IHdoaWxlICgwKQogI2Vsc2UK
ICMgZGVmaW5lIHRpbWVyX2FjdGl2ZSh0bXIpIEJBUkZZCS8vIGVycm9yIHRvIHVzZSBvdXRzaWRl
IG9mIFNNUAogIyBkZWZpbmUgc2V0X3RpbWVyX2luYWN0aXZlKHRtcikgZG8geyB9IHdoaWxlICgw
KQpAQCAtMjAwLDcgKzIwMyw5IEBACiAgKi8KIHN0YXRpYyBfX2luaXQgaW50IGluaXRfcG9zaXhf
dGltZXJzKHZvaWQpCiB7Ci0Jc3RydWN0IGtfY2xvY2sgY2xvY2tfcmVhbHRpbWUgPSB7LnJlcyA9
IENMT0NLX1JFQUxUSU1FX1JFUyB9OworCXN0cnVjdCBrX2Nsb2NrIGNsb2NrX3JlYWx0aW1lID0g
ey5yZXMgPSBDTE9DS19SRUFMVElNRV9SRVMsCisgICAgICAgICAgICAgICAgLmFic190aW1lcl9s
b2NrID0gU1BJTl9MT0NLX1VOTE9DS0VEICAgICAgICAgICAgICAgICAgICAgICAgIAorICAgICAg
ICB9OwogCXN0cnVjdCBrX2Nsb2NrIGNsb2NrX21vbm90b25pYyA9IHsucmVzID0gQ0xPQ0tfUkVB
TFRJTUVfUkVTLAogCQkuY2xvY2tfZ2V0ID0gZG9fcG9zaXhfY2xvY2tfbW9ub3RvbmljX2dldHRp
bWUsCiAJCS5jbG9ja19zZXQgPSBkb19wb3NpeF9jbG9ja19tb25vdG9uaWNfc2V0dGltZQpAQCAt
MjEyLDcgKzIxNyw2IEBACiAJcG9zaXhfdGltZXJzX2NhY2hlID0ga21lbV9jYWNoZV9jcmVhdGUo
InBvc2l4X3RpbWVyc19jYWNoZSIsCiAJCQkJCXNpemVvZiAoc3RydWN0IGtfaXRpbWVyKSwgMCwg
MCwgMCwgMCk7CiAJaWRyX2luaXQoJnBvc2l4X3RpbWVyc19pZCk7Ci0KIAlyZXR1cm4gMDsKIH0K
IApAQCAtMzYwLDYgKzM2NCwxMSBAQAogIAlzZXRfdGltZXJfaW5hY3RpdmUodGltcik7CiAJdGlt
ZXJfbm90aWZ5X3Rhc2sodGltcik7CiAJdW5sb2NrX3RpbWVyKHRpbXIsIGZsYWdzKTsKKyAgICAg
ICAgaWYgKENMT0NLX1JFQUxUSU1FID09IHRpbXItPml0X2Nsb2NrKSB7CisgICAgICAgICAgICAg
ICAgc3Bpbl9sb2NrKCZwb3NpeF9jbG9ja3NbQ0xPQ0tfUkVBTFRJTUVdLmFic190aW1lcl9sb2Nr
KTsKKyAgICAgICAgICAgICAgICBsaXN0X2RlbF9pbml0KCZ0aW1yLT5hYnNfdGltZXJfZW50cnkp
OworICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZwb3NpeF9jbG9ja3NbQ0xPQ0tfUkVBTFRJ
TUVdLmFic190aW1lcl9sb2NrKTsKKyAgICAgICAgfSAgICAgICAgCiB9CiAKIApAQCAtMzg4LDYg
KzM5Nyw3IEBACiAJCXJldHVybjsKIAl9CiAJcG9zaXhfY2xvY2tzW2Nsb2NrX2lkXSA9ICpuZXdf
Y2xvY2s7CisgICAgICAgIElOSVRfTElTVF9IRUFEKCZwb3NpeF9jbG9ja3NbY2xvY2tfaWRdLmFi
c190aW1lcl9saXN0KTsKIH0KIAogc3RhdGljIHN0cnVjdCBrX2l0aW1lciAqIGFsbG9jX3Bvc2l4
X3RpbWVyKHZvaWQpCkBAIC00MDIsNiArNDEyLDcgQEAKIAkJa21lbV9jYWNoZV9mcmVlKHBvc2l4
X3RpbWVyc19jYWNoZSwgdG1yKTsKIAkJdG1yID0gMDsKIAl9CisgICAgICAgIElOSVRfTElTVF9I
RUFEKCZ0bXItPmFic190aW1lcl9lbnRyeSk7CiAJcmV0dXJuIHRtcjsKIH0KIApAQCAtNzg3LDYg
Kzc5OCw3IEBACiB7CiAJc3RydWN0IGtfY2xvY2sgKmNsb2NrID0gJnBvc2l4X2Nsb2Nrc1t0aW1y
LT5pdF9jbG9ja107CiAJdTY0IGV4cGlyZV82NDsKKyAgICAgICAgdW5zaWduZWQgbG9uZyBzZXE7
CiAKIAlpZiAob2xkX3NldHRpbmcpCiAJCWRvX3RpbWVyX2dldHRpbWUodGltciwgb2xkX3NldHRp
bmcpOwpAQCAtODEzLDYgKzgyNSwxMSBAQAogI2Vsc2UKIAlkZWxfdGltZXIoJnRpbXItPml0X3Rp
bWVyKTsKICNlbmRpZgorICAgICAgICBpZiAoQ0xPQ0tfUkVBTFRJTUUgPT0gdGltci0+aXRfY2xv
Y2spIHsKKyAgICAgICAgICAgICAgICBzcGluX2xvY2soJmNsb2NrLT5hYnNfdGltZXJfbG9jayk7
CisgICAgICAgICAgICAgICAgbGlzdF9kZWxfaW5pdCgmdGltci0+YWJzX3RpbWVyX2VudHJ5KTsK
KyAgICAgICAgICAgICAgICBzcGluX3VubG9jaygmY2xvY2stPmFic190aW1lcl9sb2NrKTsKKyAg
ICAgICAgfQogCXRpbXItPml0X3JlcXVldWVfcGVuZGluZyA9ICh0aW1yLT5pdF9yZXF1ZXVlX3Bl
bmRpbmcgKyAyKSAmIAogCQl+UkVRVUVVRV9QRU5ESU5HOwogCXRpbXItPml0X292ZXJydW5fbGFz
dCA9IDA7CkBAIC04MzQsNyArODUxLDYgQEAKIAl0c3RvamlmZmllKCZuZXdfc2V0dGluZy0+aXRf
aW50ZXJ2YWwsIGNsb2NrLT5yZXMsICZleHBpcmVfNjQpOwogCXRpbXItPml0X2luY3IgPSAodW5z
aWduZWQgbG9uZylleHBpcmVfNjQ7CiAKLQogCS8qCiAJICogRm9yIHNvbWUgcmVhc29uIHRoZSB0
aW1lciBkb2VzIG5vdCBmaXJlIGltbWVkaWF0ZWx5IGlmIGV4cGlyZXMgaXMKIAkgKiBlcXVhbCB0
byBqaWZmaWVzLCBzbyB0aGUgdGltZXIgbm90aWZ5IGZ1bmN0aW9uIGlzIGNhbGxlZCBkaXJlY3Rs
eS4KQEAgLTg0Myw4ICs4NTksMjEgQEAKIAlpZiAoKCh0aW1yLT5pdF9zaWdldl9ub3RpZnkgJiB+
U0lHRVZfVEhSRUFEX0lEKSAhPSBTSUdFVl9OT05FKSkgewogCQlpZiAodGltci0+aXRfdGltZXIu
ZXhwaXJlcyA9PSBqaWZmaWVzKQogCQkJdGltZXJfbm90aWZ5X3Rhc2sodGltcik7Ci0JCWVsc2UK
KwkJZWxzZSB7CiAJCQlhZGRfdGltZXIoJnRpbXItPml0X3RpbWVyKTsKKyAgICAgICAgICAgICAg
ICAgICAgICAgIGlmIChmbGFncyAmIFRJTUVSX0FCU1RJTUUgJiYKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB0aW1yLT5pdF9jbG9jayA9PSBDTE9DS19SRUFMVElNRSkgeworICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkbyB7CisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc2VxID0gcmVhZF9zZXFiZWdpbigmeHRpbWVfbG9jayk7CisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdGltci0+d2FsbF90b19tb25vdG9uaWNfcHJl
diA9CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3YWxs
X3RvX21vbm90b25pYzsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfSB3aGlsZSAo
cmVhZF9zZXFyZXRyeSgmeHRpbWVfbG9jaywgc2VxKSk7CisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNwaW5fbG9jaygmY2xvY2stPmFic190aW1lcl9sb2NrKTsKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgbGlzdF9hZGRfdGFpbCgmKHRpbXItPmFic190aW1lcl9lbnRy
eSksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJihjbG9j
ay0+YWJzX3RpbWVyX2xpc3QpKTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Bp
bl91bmxvY2soJmNsb2NrLT5hYnNfdGltZXJfbG9jayk7CisgICAgICAgICAgICAgICAgICAgICAg
ICB9CisgICAgICAgICAgICAgICAgfQogCX0KIAlyZXR1cm4gMDsKIH0KQEAgLTg3NSwxMCArOTA0
LDEwIEBACiAJaWYgKCF0aW1yKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCWlmICghcG9zaXhfY2xv
Y2tzW3RpbXItPml0X2Nsb2NrXS50aW1lcl9zZXQpCisJaWYgKCFwb3NpeF9jbG9ja3NbdGltci0+
aXRfY2xvY2tdLnRpbWVyX3NldCkgCiAJCWVycm9yID0gZG9fdGltZXJfc2V0dGltZSh0aW1yLCBm
bGFncywgJm5ld19zcGVjLCBydG4pOwogCWVsc2UKLQkJZXJyb3IgPSBwb3NpeF9jbG9ja3NbdGlt
ci0+aXRfY2xvY2tdLnRpbWVyX3NldCh0aW1yLAorICAgICAgICAgICAgICAgIGVycm9yID0gcG9z
aXhfY2xvY2tzW3RpbXItPml0X2Nsb2NrXS50aW1lcl9zZXQodGltciwKIAkJCQkJCQkgICAgICAg
ZmxhZ3MsCiAJCQkJCQkJICAgICAgICZuZXdfc3BlYywgcnRuKTsKIAl1bmxvY2tfdGltZXIodGlt
ciwgZmxhZyk7CkBAIC05MTEsNiArOTQwLDExIEBACiAjZWxzZQogCWRlbF90aW1lcigmdGltZXIt
Pml0X3RpbWVyKTsKICNlbmRpZgorICAgICAgICBpZiAoQ0xPQ0tfUkVBTFRJTUUgPT0gdGltZXIt
Pml0X2Nsb2NrKSB7CisgICAgICAgICAgICAgICAgc3Bpbl9sb2NrKCZwb3NpeF9jbG9ja3NbQ0xP
Q0tfUkVBTFRJTUVdLmFic190aW1lcl9sb2NrKTsKKyAgICAgICAgICAgICAgICBsaXN0X2RlbF9p
bml0KCZ0aW1lci0+YWJzX3RpbWVyX2VudHJ5KTsKKyAgICAgICAgICAgICAgICBzcGluX3VubG9j
aygmcG9zaXhfY2xvY2tzW0NMT0NLX1JFQUxUSU1FXS5hYnNfdGltZXJfbG9jayk7CisgICAgICAg
IH0gICAgICAgIAogCXJldHVybiAwOwogfQogCkBAIC0xMDg2LDEwICsxMTIwLDEwIEBACiB7CiAJ
c3RydWN0IHRpbWVzcGVjIG5ld190cDsKIAotCWlmICgodW5zaWduZWQpIHdoaWNoX2Nsb2NrID49
IE1BWF9DTE9DS1MgfHwKKyAgICAgICAgaWYgKCh1bnNpZ25lZCkgd2hpY2hfY2xvY2sgPj0gTUFY
X0NMT0NLUyB8fAogCQkJCQkhcG9zaXhfY2xvY2tzW3doaWNoX2Nsb2NrXS5yZXMpCiAJCXJldHVy
biAtRUlOVkFMOwotCWlmIChjb3B5X2Zyb21fdXNlcigmbmV3X3RwLCB0cCwgc2l6ZW9mICgqdHAp
KSkKKyAgICAgICAgaWYgKGNvcHlfZnJvbV91c2VyKCZuZXdfdHAsIHRwLCBzaXplb2YgKCp0cCkp
KQogCQlyZXR1cm4gLUVGQVVMVDsKIAlpZiAocG9zaXhfY2xvY2tzW3doaWNoX2Nsb2NrXS5jbG9j
a19zZXQpCiAJCXJldHVybiBwb3NpeF9jbG9ja3Nbd2hpY2hfY2xvY2tdLmNsb2NrX3NldCgmbmV3
X3RwKTsKQEAgLTExNTksNyArMTE5Myw1NSBAQAogCiB2b2lkIGNsb2NrX3dhc19zZXQodm9pZCkK
IHsKKyAgICAgICAgc3RydWN0IGtfY2xvY2sgKmNsb2NrID0gJnBvc2l4X2Nsb2Nrc1tDTE9DS19S
RUFMVElNRV07CisgICAgICAgIHN0cnVjdCBrX2l0aW1lciAqdGltciwgKnRtcDsKKyAgICAgICAg
c3RydWN0IHRpbWVzcGVjIGRlbHRhOworICAgICAgICB1NjQgZXhwID0gMDsKKyAgICAgICAgdW5z
aWduZWQgbG9uZyBzZXE7CisgICAgICAgIAogCXdha2VfdXBfYWxsKCZuYW5vc2xlZXBfYWJzX3dx
dWV1ZSk7CisKKyAgICAgICAgLyoKKyAgICAgICAgICogQ2hlY2sgaWYgdGhlcmUgZXhpc3QgVElN
RVJfQUJTVElNRSB0aW1lcnMgdG8gY29ycmVjdC4KKyAgICAgICAgICovCisgICAgICAgIGlmIChs
aXN0X2VtcHR5KCZjbG9jay0+YWJzX3RpbWVyX2xpc3QpKQorICAgICAgICAgICAgICAgIHJldHVy
bjsKKworICAgICAgICBzcGluX2xvY2soJmNsb2NrLT5hYnNfdGltZXJfbG9jayk7CisgICAgICAg
IGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZSh0aW1yLCB0bXAsCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAmY2xvY2stPmFic190aW1lcl9saXN0LAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYWJzX3RpbWVyX2VudHJ5KSB7CisgICAgICAgICAgICAgICAgZG8gewor
ICAgICAgICAgICAgICAgICAgICAgICAgc2VxID0gcmVhZF9zZXFiZWdpbigmeHRpbWVfbG9jayk7
CisgICAgICAgICAgICAgICAgICAgICAgICBkZWx0YS50dl9zZWMgPQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB3YWxsX3RvX21vbm90b25pYy50dl9zZWMKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgLSB0aW1yLT53YWxsX3RvX21vbm90b25pY19wcmV2LnR2X3NlYzsK
KyAgICAgICAgICAgICAgICAgICAgICAgIGRlbHRhLnR2X25zZWMgPSAKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgd2FsbF90b19tb25vdG9uaWMudHZfbnNlYworICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtIHRpbXItPndhbGxfdG9fbW9ub3RvbmljX3ByZXYudHZfbnNl
YzsKKyAgICAgICAgICAgICAgICB9IHdoaWxlIChyZWFkX3NlcXJldHJ5KCZ4dGltZV9sb2NrLCBz
ZXEpKTsKKyAgICAgICAgICAgICAgICAKKyAgICAgICAgICAgICAgICB3aGlsZSAoZGVsdGEudHZf
bnNlYyA+PSBOU0VDX1BFUl9TRUMpIHsKKyAgICAgICAgICAgICAgICAgICAgICAgIGRlbHRhLnR2
X3NlYyArKzsKKyAgICAgICAgICAgICAgICAgICAgICAgIGRlbHRhLnR2X25zZWMgLT0gTlNFQ19Q
RVJfU0VDOworICAgICAgICAgICAgICAgIH0KKyAgICAgICAgICAgICAgICB3aGlsZSAoZGVsdGEu
dHZfbnNlYyA8IDApIHsKKyAgICAgICAgICAgICAgICAgICAgICAgIGRlbHRhLnR2X3NlYyAtLTsK
KyAgICAgICAgICAgICAgICAgICAgICAgIGRlbHRhLnR2X25zZWMgKz0gTlNFQ19QRVJfU0VDOwor
ICAgICAgICAgICAgICAgIH0KKyAgICAgICAgICAgICAgICBkbyB7CisgICAgICAgICAgICAgICAg
ICAgICAgICBzZXEgPSByZWFkX3NlcWJlZ2luKCZ4dGltZV9sb2NrKTsKKyAgICAgICAgICAgICAg
ICAgICAgICAgIHRpbXItPndhbGxfdG9fbW9ub3RvbmljX3ByZXYgPSB3YWxsX3RvX21vbm90b25p
YzsKKyAgICAgICAgICAgICAgICB9IHdoaWxlIChyZWFkX3NlcXJldHJ5KCZ4dGltZV9sb2NrLCBz
ZXEpKTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAKKyAgICAgICAgICAgICAgICB0c3Rvamlm
ZmllKCZkZWx0YSwgY2xvY2stPnJlcywgJmV4cCk7CisgICAgICAgICAgICAgICAgaWYgKGRlbF90
aW1lcigmdGltci0+aXRfdGltZXIpKSB7IC8qIHRoZSB0aW1lciBoYXMgbm90IHJ1biAqLworICAg
ICAgICAgICAgICAgICAgICAgICAgdGltci0+aXRfdGltZXIuZXhwaXJlcyArPSBleHA7IAorICAg
ICAgICAgICAgICAgICAgICAgICAgYWRkX3RpbWVyKCZ0aW1yLT5pdF90aW1lcik7CisgICAgICAg
ICAgICAgICAgfSBlbHNlIAorICAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9kZWxfaW5pdCgm
dGltci0+YWJzX3RpbWVyX2VudHJ5KTsKKyAgICAgICAgfQorICAgICAgICBzcGluX3VubG9jaygm
Y2xvY2stPmFic190aW1lcl9sb2NrKTsKIH0KIAogbG9uZyBjbG9ja19uYW5vc2xlZXBfcmVzdGFy
dChzdHJ1Y3QgcmVzdGFydF9ibG9jayAqcmVzdGFydF9ibG9jayk7Cg==

------_=_NextPart_001_01C44A15.48BE291F--
