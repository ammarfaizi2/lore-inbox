Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTGGDEX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 23:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbTGGDEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 23:04:22 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:44218 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264551AbTGGDET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 23:04:19 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O3int interactivity for 2.5.74-mm2
Date: Mon, 7 Jul 2003 13:19:57 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200307070317.11246.kernel@kolivas.org> <1057516609.818.4.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1057516609.818.4.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dbOC/IROpr9FrQ8"
Message-Id: <200307071319.57511.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dbOC/IROpr9FrQ8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 7 Jul 2003 04:36, Felipe Alfaro Solana wrote:
> On Sun, 2003-07-06 at 19:16, Con Kolivas wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Attached is an incremental patch against 2.5.74-mm2 with more
> > interactivity work. Audio should be quite resistant to skips with this,
> > and it should not induce further unfairness.
> >
> > Changes:
> > The sleep_avg buffer was not needed with the improved semantics in O2int
> > so it has been removed entirely as it created regressions in O2int.
> >
> > A small change to the idle detection code to only make tasks with enough
> > accumulated sleep_avg become idle.
> >
> > Minor cleanups and clarified code.
> >
> >
> > Other issues:
> > Jerky mouse with heavy page rendering in web browsers remains. This is a
> > different issue to the audio and will need some more thought.
> >
> > The patch is also available for download here:
> > http://kernel.kolivas.org/2.5
> >
> > Note for those who wish to get smooth X desktop feel now for their own
> > use, the granularity patch on that website will do wonders on top of
> > O3int, but a different approach will be needed for mainstream
> > consumption.
>
> I'm seeing extreme X starvation with this patch under 2.5.74-mm2 when
> starting a CPU hogger:
>
> 1. Start a KDE session.
> 2. Launch a Konsole
> 3. Launch Konqueror
> 4. Launch XMMS
> 5. Make XMMS play an MP3 file
> 6. On the Konsole terminal, run "while true; do a=2; done"
>
> When the "while..." is run, X starves completely for ~5 seconds (e.g.
> the mouse cursor doesn't respond to my input events). After those 5
> seconds, the mouse cursor goes jerky for a while (~2 seconds) and then
> the system gets responsive.

Aha!

Thanks to Felipe who picked this up I was able to find the one bug causing me 
grief. The idle detection code was allowing the sleep_avg to get to 
ridiculously high levels. This is corrected in the following replacement 
O3int patch. Note this fixes the mozilla issue too. Kick arse!!

Con

--Boundary-00=_dbOC/IROpr9FrQ8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-O3int-0307071315"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-O3int-0307071315"

--- linux-2.5.74/kernel/sched.c	2003-07-07 02:13:57.000000000 +1000
+++ linux-2.5.74-test/kernel/sched.c	2003-07-07 13:15:04.000000000 +1000
@@ -77,6 +77,7 @@
 #define MAX_SLEEP_AVG		(10*HZ)
 #define STARVATION_LIMIT	(10*HZ)
 #define NODE_THRESHOLD		125
+#define MAX_BONUS		((MAX_USER_PRIO - MAX_RT_PRIO) * PRIO_BONUS_RATIO / 100)
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -306,7 +307,7 @@ static inline void normalise_sleep(task_
 {
 	unsigned long old_avg_time = jiffies - p->avg_start;
 
-	if (old_avg_time < MIN_SLEEP_AVG)
+	if (unlikely(old_avg_time < MIN_SLEEP_AVG))
 		return;
 
 	if (p->sleep_avg > MAX_SLEEP_AVG)
@@ -406,22 +407,19 @@ static inline void activate_task(task_t 
 		 */
 		if (runtime < MAX_SLEEP_AVG)
 			p->sleep_avg += (runtime - p->sleep_avg) * (MAX_SLEEP_AVG - runtime) *
-				(10 - INTERACTIVE_DELTA) / 10 / MAX_SLEEP_AVG;
+				(MAX_BONUS - INTERACTIVE_DELTA) / MAX_BONUS / MAX_SLEEP_AVG;
 
-		/*
-		 * Keep a buffer of 10% sleep_avg
-		 * to prevent short bursts of cpu activity from making
-		 * interactive tasks lose their bonus
-		 */
-		if (p->sleep_avg > MAX_SLEEP_AVG * 11/10)
-			p->sleep_avg = MAX_SLEEP_AVG * 11/10;
+		if (p->sleep_avg > MAX_SLEEP_AVG)
+			p->sleep_avg = MAX_SLEEP_AVG;
 
 		/*
 		 * Tasks that sleep a long time are categorised as idle and
 		 * get their static priority only
 		 */
-		if (sleep_time > MIN_SLEEP_AVG)
-			p->sleep_avg = runtime / 2;
+		if (sleep_time > MIN_SLEEP_AVG){
+			p->avg_start = jiffies - MIN_SLEEP_AVG;
+			p->sleep_avg = MIN_SLEEP_AVG / 2;
+		}
 
 		if (unlikely(p->avg_start > jiffies)){
 			p->avg_start = jiffies;

--Boundary-00=_dbOC/IROpr9FrQ8--

