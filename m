Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263613AbUJ2VcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263613AbUJ2VcP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263617AbUJ2V3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:29:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29662 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263614AbUJ2VYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:24:53 -0400
Date: Fri, 29 Oct 2004 23:25:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029212545.GA13199@elte.hu>
References: <20041029163155.GA9005@elte.hu> <20041029191652.1e480e2d@mango.fruits.de> <20041029170237.GA12374@elte.hu> <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de> <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu> <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu> <20041029233117.6d29c383@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029233117.6d29c383@mango.fruits.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > do you compile jackd from sources? If yes then could you try the patch
> > below? With this added, the kernel will produce a stackdump whenever
> > jackd does an 'illegal' sleep.
> > 
> > Also, could you do a small modification to kernel/sched.c and remove
> > this line:
> > 
> > 		send_sig(SIGUSR1, current, 1);
> > 
> > just to make it easier to get Jack up and running. (by default an
> > atomicity violation triggers a signal to make it easier to debug it in
> > userspace, but i suspect there will be alot of such violations so jackd
> > would stop all the time.)
> 
> [snip]
> 
> will do so. btw: i think i'm a bit confused right now. What debugging
> features should i have enabled for this test?

this particular one (atomicity-checking) is always-enabled if you have
the -RT patch applied (it's a really cheap check).

for the 'application-triggered tracing' facility we talked about earlier
is only active if LATENCY_TRACING is enabled. In that case to turn the 
tracer on, call:

	gettimeofday(0,1);

and to turn the tracer off and save the current trace into 
/proc/latency_trace, call:

	gettimeofday(0,0);

or apply the patch below - i've added the tracer bits too. I've added a
simple limit: all delays above 2 msec will be saved - you might want to
do a maximum search there or something. And dont forget to:

	echo 2 > /proc/sys/kernel/trace_enabled

to activate the jackd-triggered kernel tracer.

	Ingo

--- jack-audio-connection-kit-0.99.0/drivers/alsa/alsa_driver.c.orig
+++ jack-audio-connection-kit-0.99.0/drivers/alsa/alsa_driver.c
@@ -1161,6 +1161,7 @@ alsa_driver_wait (alsa_driver_t *driver,
 		unsigned int p_timed_out, c_timed_out;
 		unsigned int ci = 0;
 		unsigned int nfds;
+		int ret;
 
 		nfds = 0;
 
@@ -1194,7 +1195,20 @@ alsa_driver_wait (alsa_driver_t *driver,
 
 		poll_enter = jack_get_microseconds ();
 
-		if (poll (driver->pfd, nfds, driver->poll_timeout) < 0) {
+		gettimeofday((void *)1,(void *)0); // atomic off
+
+		gettimeofday((void *)0,(void *)1); // start tracing
+
+		ret = poll (driver->pfd, nfds, driver->poll_timeout);
+
+		poll_ret = jack_get_microseconds ();
+
+		if (poll_ret - poll_enter > 2000)
+			gettimeofday((void *)0,(void *)0); // save trace
+
+		gettimeofday((void *)1,(void *)1); // atomic on
+
+		if (ret < 0) {
 
 			if (errno == EINTR) {
 				printf ("poll interrupt\n");
@@ -1214,8 +1228,6 @@ alsa_driver_wait (alsa_driver_t *driver,
 			
 		}
 
-		poll_ret = jack_get_microseconds ();
-
 		if (extra_fd < 0) {
 			if (driver->poll_next && poll_ret > driver->poll_next) {
 				*delayed_usecs = poll_ret - driver->poll_next;
