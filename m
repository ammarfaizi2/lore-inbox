Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUJ2Uyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUJ2Uyz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 16:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUJ2UyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 16:54:09 -0400
Received: from mx1.elte.hu ([157.181.1.137]:40872 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263504AbUJ2UlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 16:41:13 -0400
Date: Fri, 29 Oct 2004 22:42:20 +0200
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
Message-ID: <20041029204220.GA6727@elte.hu>
References: <20041029183256.564897b2@mango.fruits.de> <20041029162316.GA7743@elte.hu> <20041029163155.GA9005@elte.hu> <20041029191652.1e480e2d@mango.fruits.de> <20041029170237.GA12374@elte.hu> <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de> <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu> <20041029203619.37b54cba@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029203619.37b54cba@mango.fruits.de>
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

> > > fs.h chunk went missing ... uploading -V0.5.14 in a minute.
> > 
> > done.
> 
> compiles and boots fine. no observable change in xrun behaviour
> though. 

do you compile jackd from sources? If yes then could you try the patch
below? With this added, the kernel will produce a stackdump whenever
jackd does an 'illegal' sleep.

Also, could you do a small modification to kernel/sched.c and remove
this line:

		send_sig(SIGUSR1, current, 1);

just to make it easier to get Jack up and running. (by default an
atomicity violation triggers a signal to make it easier to debug it in
userspace, but i suspect there will be alot of such violations so jackd
would stop all the time.)

	Ingo

--- jack-audio-connection-kit-0.99.0/drivers/alsa/alsa_driver.c.orig
+++ jack-audio-connection-kit-0.99.0/drivers/alsa/alsa_driver.c
@@ -1161,6 +1161,7 @@ alsa_driver_wait (alsa_driver_t *driver,
 		unsigned int p_timed_out, c_timed_out;
 		unsigned int ci = 0;
 		unsigned int nfds;
+		int ret;
 
 		nfds = 0;
 
@@ -1194,7 +1195,11 @@ alsa_driver_wait (alsa_driver_t *driver,
 
 		poll_enter = jack_get_microseconds ();
 
-		if (poll (driver->pfd, nfds, driver->poll_timeout) < 0) {
+		gettimeofday((void *)1,(void *)0); // atomic off
+		ret = poll (driver->pfd, nfds, driver->poll_timeout);
+		gettimeofday((void *)1,(void *)1); // atomic on
+
+		if (ret < 0) {
 
 			if (errno == EINTR) {
 				printf ("poll interrupt\n");
