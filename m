Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267112AbTGKX45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 19:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267127AbTGKX41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 19:56:27 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:10927 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S267112AbTGKX4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 19:56:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: smiler@lanil.mine.nu
Subject: Re: [RFC][PATCH] SCHED_ISO for interactivity
Date: Sat, 12 Jul 2003 10:13:14 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, phillips@arcor.de
References: <200307112053.55880.kernel@kolivas.org> <200307120030.31958.kernel@kolivas.org> <1057966657.4326.6.camel@sm-wks1.lan.irkk.nu>
In-Reply-To: <1057966657.4326.6.camel@sm-wks1.lan.irkk.nu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aK1D/wqAaloQ4RV"
Message-Id: <200307121013.14347.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_aK1D/wqAaloQ4RV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sat, 12 Jul 2003 09:37, Christian Axelsson wrote:
> On Fri, 2003-07-11 at 16:30, Con Kolivas wrote:
> > On Fri, 11 Jul 2003 22:48, Christian Axelsson wrote:
> > > Ok complies and boot fine
> > >
> > > BUT... after loading X up and gnome-theme-manager I start clicking
> > > around abit.. then gnome-theme-manager starts eating 99.9% CPU (prolly
> > > a bug in the program). Problem here is that the machine stops
> > > responding to input, at first I can move mouse around (but Im stuck in
> > > the current focused X-client) and later it all stalls... Cant even get
> > > in via SSH. Ive put on a top before repeating this showing
> > > gnome-theme-manager eating all CPU-time (PRI 15/NICE 0) and load
> > > showing ~55% user ~45% system.
> > >
> > > Anything I can do to help debugging?
> >
> > Can you try this patch instead which should stop the machine from getting
> > into a deadlock? I dont think I have found the problem but at least it
> > should be easier to diagnose without the machine locking up.
>
> Deadlock is gone but problem is still there.
> Running processes (state R) keep running smooth until they try to access
> any resource (ie. xmms keeps playing the current file but gets stuck
> when trying to open next one, top keeps running with full
> interactivity). Spawning new processes is impossible.
> I had top running over SSH and when I exited I managed to type 1 char
> then it hung up. A note is that sometimes the load is ~45% user ~55%
> system instead of ~55% user and ~45% system. There are always those
> values.
> I tried to reproduce by creating a while(1){} loop but it runs smooth.
>
> Any suggestions on methods to debug this?

Difficult apart from what you're already describing. The interesting point is 
the waiting for something that makes it hang, which reminds me of the 
parent-child waiting problem and is likely to be similar. The thing about iso 
tasks is they are by definition always active so they always get reinserted 
into the active array. However if they are waiting for something and are 
constantly preempting that something it will never happen. Can you try the 
attached diff which always puts them on the expired array if they run out of 
timeslice to see if that helps? This is not the ideal fix, but I need to see 
if it is the problem.

Con

--Boundary-00=_aK1D/wqAaloQ4RV
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-SIfix"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patch-SIfix"

diff -Naurp linux-2.5.75-mm1/kernel/sched.c linux-2.5.75-test/kernel/sched.c
--- linux-2.5.75-mm1/kernel/sched.c	2003-07-12 10:04:21.000000000 +1000
+++ linux-2.5.75-test/kernel/sched.c	2003-07-12 10:05:34.000000000 +1000
@@ -1333,7 +1333,7 @@ void scheduler_tick(int user_ticks, int 
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
+		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq) || iso_task(p)) {
 			if (!rq->expired_timestamp)
 				rq->expired_timestamp = jiffies;
 			enqueue_task(p, rq->expired);

--Boundary-00=_aK1D/wqAaloQ4RV--

