Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270730AbTGNSyz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270731AbTGNSyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:54:55 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:44248 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S270730AbTGNSyw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:54:52 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O5int for interactivity
Date: Tue, 15 Jul 2003 05:11:49 +1000
User-Agent: KMail/1.5.2
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@arcor.de>,
       Mike Galbraith <efault@gmx.de>
References: <200307142232.05782.kernel@kolivas.org> <1058196300.582.5.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1058196300.582.5.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307150511.49294.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jul 2003 01:25, Felipe Alfaro Solana wrote:
> On Mon, 2003-07-14 at 14:32, Con Kolivas wrote:
> > More interactivity work for audio and X smoothness. I have fixed all my
> > test cases and need feedback about others to develop beyond this.
> >
> > Changes
> > The idle code now gives just under interactive state based on the runtime
> >  instead of min_sleep_avg - minor startup speed improvement.
> >
> > Tasks that drop their priority while running are now put to the end of
> > the queue to continue their timeslice. Fixes a little flutter when tasks
> > are cpu hogs for short periods (eg mozilla).
> >
> > Tasks that are complete cpu hogs are put on the expired array every time
> > they run out of timeslice.
>
> Hmmm... Starvation is back for me (Pentium III 700Mhz + ACPI):
>
> 1. Log on to X/KDE
> 2. Launch Konqueror
> 3. Launch XMMS
> 4. Make XMMS play a song
> 5. Move the Konqueror window all over the desktop.
>
> Step 5 causes XMMS to completely starve for exactly 5 seconds. After
> those 5 seconds, the XMMS priority gets adjusted and sound comes back
> from my speakers.
>
> Another way to starve XMMS for 5 seconds:
>
> 1. Launch XMMS
> 2. Make it play
> 3. Run a standard CPU hogger: "while true; do a=2; done"
>
> Step 3 will make XMMS starve for exactly 5 seconds. Also, during those 5
> seconds, X is completely jerky and moving the mouse makes the pointer
> goes jumping all over the screen.
>
> Do you want additional information? Any patch trying?
> Thanks!

Great thanks for test. Can you try reverting this:


diff -Naurp linux-2.5.75-mm1/kernel/sched.c linux-2.5.75-test/kernel/sched.c
--- linux-2.5.75-mm1/kernel/sched.c	2003-07-13 00:21:30.000000000 +1000
+++ linux-2.5.75-test/kernel/sched.c	2003-07-14 22:13:51.000000000 +1000
@@ -388,19 +388,19 @@ static inline void __activate_task(task_
 static inline void activate_task(task_t *p, runqueue_t *rq)
 {
 	long sleep_time = jiffies - p->last_run - 1;
+	long runtime = jiffies - p->avg_start;
 
 	if (sleep_time > 0) {
-		unsigned long runtime = jiffies - p->avg_start;
-
 		/*
 		 * Tasks that sleep a long time are categorised as idle and
-		 * will get just under interactive status with a small runtime
-		 * to allow them to become interactive or non-interactive rapidly
+		 * will get just under interactive status
 		 */
 		if (sleep_time > MIN_SLEEP_AVG){
-			p->avg_start = jiffies - MIN_SLEEP_AVG;
-			p->sleep_avg = MIN_SLEEP_AVG * (MAX_BONUS - INTERACTIVE_DELTA - 1) /
-				MAX_BONUS;
+			if (runtime > MAX_SLEEP_AVG){
+				runtime = MAX_SLEEP_AVG;
+				p->avg_start = jiffies - runtime;
+			}
+			p->sleep_avg = runtime * (MAX_BONUS - INTERACTIVE_DELTA - 1) / MAX_BONUS;
 		} else {
 			/*
 			 * This code gives a bonus to interactive tasks.

