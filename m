Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTFTCPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 22:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbTFTCPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 22:15:55 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:7123 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262165AbTFTCPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 22:15:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andreas Boman <aboman@midgaard.us>
Subject: Re: [PATCH] sleep_decay for interactivity 2.5.72 - testers  needed
Date: Fri, 20 Jun 2003 12:29:55 +1000
User-Agent: KMail/1.5.2
References: <5.2.0.9.2.20030619171843.02299e00@pop.gmx.net> <200306200250.01865.kernel@kolivas.org> <1056058342.917.69.camel@asgaard.midgaard.us>
In-Reply-To: <1056058342.917.69.camel@asgaard.midgaard.us>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jGn8+DzdsrSs50F"
Message-Id: <200306201229.55425.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_jGn8+DzdsrSs50F
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 20 Jun 2003 07:32, Andreas Boman wrote:
> On Thu, 2003-06-19 at 12:50, Con Kolivas wrote:
> > On Fri, 20 Jun 2003 02:42, Andreas Boman wrote:
> > > On Thu, 2003-06-19 at 12:06, Con Kolivas wrote:
> > > > On Fri, 20 Jun 2003 02:02, Con Kolivas wrote:
> > > > > On Fri, 20 Jun 2003 01:47, Mike Galbraith wrote:
> > > > > > At 12:05 AM 6/20/2003 +1000, Con Kolivas wrote:
> > > > > > >Testers required. A version for -ck will be created soon.
> > > > > >
> > > > > > That idea definitely needs some refinement.
> > > > >
> > > > > Actually no it needs a bugfix even more than a refinement!
> > > > >
> > > > > The best_sleep_decay should be 60, NOT 60*Hz
> > > >
> > > > Here's a fixed patch.
> > >
> > > Ok, that doesnt really seem to change behavior much (from just a little
> > > testing). I can still easily starve xmms by moving a window around over
> > > mozilla or evolution (I suspect for thoose that use nautilus to draw
> > > the desktop that would happen on an 'empty' desktop too..).
> > >
> > > With 2.5.72-mm1, HZ 1000 and MAX_SLEEP_AVG 2 that does *not* happen,
> > > even with a cpu hog running (mpeg2enc) or during make -j20. However
> > > with this kernel, after having moved a window around madly for a while
> > > the mouse pointer is very laggy/jerky for atleast 30 sec after i
> > > release the window (not so with your patch).
> > >
> > > I'm not hitting swap at all, so thats not a factor here.
> >
> > Ok well next thing to try is max_sleep_avg 2*HZ with my patch, possibly
> > with best_sleep_decay 10
>
> Ok, 2.5.72-mm2 + your patch + rml's setscheduler fix,  MAX_SLEEP_AVG
> 2*HZ, BEST_SLEEP_DECAY 10, HZ 1000
>
> This kernel is acting pretty good, I can still starve xmms if I start
> wiggeling a window around right about when a song changes in xmms, but
> it seems to get a timeslice in <20 sec while I'm still wiggeling the
> thing around (this is with make -j20 running as well). Repainting
> windows (evolution -its the slowest app to repaint, and the one its
> easiest to starve xmms with) post-wiggle sometimes takes while, not too
> bad on the whole though.
>
> The mouse pointer isn't all laggy post-window-wiggle like it was with
> -mm1, HZ 1000, MAX_SLEEP_AVG 2*HZ
>
> I have managed to get a few xmms skips when switching desktops (still
> with make -j20 running), but its pretty rare and not at all as
> predictable as it was without your patch (usually takes a few quick
> desktop changes within the first few seconds of playtime).
>
> I may have seen some strangeness while doing concurrent builds and
> similar things (make in linux tree, rpmbuild -ba mozilla.spec for
> example), the bunzip2 of the mozilla tree seemed to take _very_ long,
> and I'm not sure how the fairness is between theese processes now.. (I'm
> wondering if that may be something contest would be able to measure?)

The resolution of results in contest is not up to telling us that I'm afraid. 

> Playing a mpeg movie in mplayer (windowed or fullscreen) while doing the
> concurrent kernel and mozilla builds works just great without any
> noticable framedrops, and no sound skips.
>
> Doing the 'mad window wiggle' with the mplayer window (over evolution)
> will evenually cause some audio skips and/or frame drops, and the mouse
> pointer and framedropping may continue for a few (~15 tops) seconds
> after I stop moving that window around. Just moving the mplayer window
> around 'normally' doesnt cause any bad behavior (still with concurrent
> kernel and mozilla builds running).
>
> Basicly, for normal usage this kernel is acting *very* well here.

Great! Thanks for doing this testing. I've attached a patch with the updated 
figures and cc'ed lkml for others to test.

Con

--Boundary-00=_jGn8+DzdsrSs50F
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-sleep_decay-0306201225"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-sleep_decay-0306201225"

diff -Naurp linux-2.5.72/kernel/sched.c linux-2.5.72-test/kernel/sched.c
--- linux-2.5.72/kernel/sched.c	2003-06-18 22:47:25.000000000 +1000
+++ linux-2.5.72-test/kernel/sched.c	2003-06-19 22:23:33.000000000 +1000
@@ -72,7 +72,8 @@
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
 #define INTERACTIVE_DELTA	2
-#define MAX_SLEEP_AVG		(10*HZ)
+#define MAX_SLEEP_AVG		(2 * HZ)
+#define BEST_SLEEP_DECAY	(10)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
 
@@ -318,7 +319,7 @@ static int effective_prio(task_t *p)
 	if (rt_task(p))
 		return p->prio;
 
-	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*p->sleep_avg/MAX_SLEEP_AVG/100 -
+	bonus = MAX_USER_PRIO*PRIO_BONUS_RATIO*(p->best_sleep_avg/BEST_SLEEP_DECAY)/MAX_SLEEP_AVG/100 -
 			MAX_USER_PRIO*PRIO_BONUS_RATIO/100/2;

 	prio = p->static_prio - bonus;
@@ -371,6 +372,8 @@ static inline void activate_task(task_t 
 			sleep_avg = MAX_SLEEP_AVG;
 		if (p->sleep_avg != sleep_avg) {
 			p->sleep_avg = sleep_avg;
+			if ((sleep_avg * BEST_SLEEP_DECAY) > p->best_sleep_avg)
+				p->best_sleep_avg = sleep_avg * BEST_SLEEP_DECAY;
 			p->prio = effective_prio(p);
 		}
 	}
@@ -551,6 +554,7 @@ void wake_up_forked_process(task_t * p)
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
+	p->best_sleep_avg = p->sleep_avg * BEST_SLEEP_DECAY;
 	p->prio = effective_prio(p);
 	set_task_cpu(p, smp_processor_id());
 
@@ -1200,6 +1204,8 @@ void scheduler_tick(int user_ticks, int 
 	 */
 	if (p->sleep_avg)
 		p->sleep_avg--;
+	if (p->best_sleep_avg)
+		p->best_sleep_avg--;
 	if (unlikely(rt_task(p))) {
 		/*
 		 * RR tasks need a special form of timeslice management.
diff -Naurp linux-2.5.72/include/linux/sched.h linux-2.5.72-test/include/linux/sched.h
--- linux-2.5.72/include/linux/sched.h	2003-06-18 22:47:19.000000000 +1000
+++ linux-2.5.72-test/include/linux/sched.h	2003-06-19 20:56:18.000000000 +1000
@@ -332,6 +332,7 @@ struct task_struct {
 
 	unsigned long sleep_avg;
 	unsigned long last_run;
+	unsigned long best_sleep_avg;
 
 	unsigned long policy;
 	unsigned long cpus_allowed;

--Boundary-00=_jGn8+DzdsrSs50F--

