Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbTGDEop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 00:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265767AbTGDEop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 00:44:45 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:7627 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265764AbTGDEom
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 00:44:42 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] O2int 0307041440 for 2.5.74-mm1
Date: Fri, 4 Jul 2003 14:59:08 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cmQB//nWK+3AkA7"
Message-Id: <200307041459.33326.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_cmQB//nWK+3AkA7
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is a patch against the current O1int patch in 2.5.74-mm1.
Since the O1int didn't mean anything I thought I'd call this O2int.

This one wont blow you away but tames those corner cases.

Changes:
The child penalty is set on 80% which means that tasks that wait on their=20
children have children forking just on the edge of the interactive delta so=
=20
they shouldn't starve their own children.

The non linear sleep avg boost is scaled down slightly to prevent this=20
particular boost from being capable of making a task highly interactive. Th=
is=20
makes very new tasks less likely to have a little spurt of too high priorit=
y.

Idle tasks now get their static priority over the full time they've been=20
running rather than starting again at 1 second. This makes it harder for id=
le=20
tasks to suddenly become highly interactive and _then_ fork an interactive=
=20
bomb. Not sure on this one yet.

The sched_exit penalty to parents of cpu hungry children is scaled accordin=
gly=20
(was missed on the original conversion so works better now).

Hysteresis on interactive buffer removed (was unecessary).

Minor cleanup.

Known issue remaining:
Mozilla acts just like X in that it is mostly interactive but has bursts of=
=20
heavy cpu activity so it gets the same bonus as X. However it makes X jerky=
=20
during it's heavy cpu activity, and might in some circumstances make audio=
=20
skip. Fixing this kills X smoothness as they seem very similar to the=20
estimator. Still haven't sorted a workaround for this one but I'm working o=
n=20
it. Ingo's original timeslice granularity patch helps a little and may be=20
worth resuscitating (and the desktop only people can change the granularity=
=20
down to 10ms to satisfy their needs).

Con
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/BQmjF6dfvkL3i1gRAiYhAKCnpZN//FkD1iO5b2SZ6HTURMUULwCfS43B
Pn/1kRndvUz/lnjFI+lUpEc=3D
=3DO+VS
=2D----END PGP SIGNATURE-----

--Boundary-00=_cmQB//nWK+3AkA7
Content-Type: text/x-diff;
  charset="us-ascii";
  name="patch-O2int-0307041440"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-O2int-0307041440"

--- linux-2.5.74/kernel/sched.c	2003-07-04 14:30:11.000000000 +1000
+++ linux-2.5.74-test/kernel/sched.c	2003-07-04 14:41:22.000000000 +1000
@@ -68,7 +68,7 @@
  */
 #define MIN_TIMESLICE		( 10 * HZ / 1000)
 #define MAX_TIMESLICE		(200 * HZ / 1000)
-#define CHILD_PENALTY		50
+#define CHILD_PENALTY		80
 #define PARENT_PENALTY		100
 #define EXIT_WEIGHT		3
 #define PRIO_BONUS_RATIO	25
@@ -405,30 +405,30 @@ static inline void activate_task(task_t 
 		 * from continually getting larger.
 		 */
 		if (runtime < MAX_SLEEP_AVG)
-			p->sleep_avg += (runtime - p->sleep_avg) * (MAX_SLEEP_AVG - runtime) / MAX_SLEEP_AVG;
+			p->sleep_avg += (runtime - p->sleep_avg) * (MAX_SLEEP_AVG - runtime) *
+				(10 - INTERACTIVE_DELTA) / 10 / MAX_SLEEP_AVG;
 
 		/*
-		 * Keep a buffer of 10-20% bonus sleep_avg with hysteresis
+		 * Keep a buffer of 10% sleep_avg
 		 * to prevent short bursts of cpu activity from making
 		 * interactive tasks lose their bonus
 		 */
-		if (p->sleep_avg > MAX_SLEEP_AVG * 12/10)
+		if (p->sleep_avg > MAX_SLEEP_AVG * 11/10)
 			p->sleep_avg = MAX_SLEEP_AVG * 11/10;
 
 		/*
 		 * Tasks that sleep a long time are categorised as idle and
 		 * get their static priority only
 		 */
-		if (sleep_time > MIN_SLEEP_AVG){
-			p->avg_start = jiffies - MIN_SLEEP_AVG;
-			p->sleep_avg = MIN_SLEEP_AVG / 2;
-		}
+		if (sleep_time > MIN_SLEEP_AVG)
+			p->sleep_avg = runtime / 2;
+
 		if (unlikely(p->avg_start > jiffies)){
 			p->avg_start = jiffies;
 			p->sleep_avg = 0;
 		}
-		p->prio = effective_prio(p);
 	}
+	p->prio = effective_prio(p);
 	__activate_task(p, rq);
 }
 
@@ -605,7 +605,6 @@ void wake_up_forked_process(task_t * p)
 	 * from forking tasks that are max-interactive.
 	 */
 	current->sleep_avg = current->sleep_avg * PARENT_PENALTY / 100;
-	p->avg_start = current->avg_start;
 	normalise_sleep(p);
 	p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 	p->prio = effective_prio(p);
@@ -647,6 +646,8 @@ void sched_exit(task_t * p)
 	 * If the child was a (relative-) CPU hog then decrease
 	 * the sleep_avg of the parent as well.
 	 */
+	normalise_sleep(p);
+	normalise_sleep(p->parent);
 	if (p->sleep_avg < p->parent->sleep_avg)
 		p->parent->sleep_avg = (p->parent->sleep_avg * EXIT_WEIGHT +
 			p->sleep_avg) / (EXIT_WEIGHT + 1);

--Boundary-00=_cmQB//nWK+3AkA7--

