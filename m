Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbUK2LRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUK2LRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbUK2LRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:17:45 -0500
Received: from mx1.elte.hu ([157.181.1.137]:8411 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261660AbUK2LQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:16:46 -0500
Date: Mon, 29 Nov 2004 12:16:34 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Message-ID: <20041129111634.GB10123@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93>
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


* Rui Nuno Capela <rncbc@rncbc.org> wrote:

>   xruntrace1.0.tar.gz
>      - scripts used for xrun trace capture automation
>
>   xruntrace1-2.6.10-rc2-mm3-RT-V0.7.31-7.tar.gz
>      - actual xrun traces captured while running jackd on RT-V0.7.31-7

the trace buffer is too small to capture a significant portion of the
xrun - i'd suggest for you to increase it from 4096-1 to 4096*16-1, to
be able to capture a couple of hundreds of millisecs worth of traces.

also, i think it produces more stable results if the tracing is
activated and deactivated from userspace - i.e. the patch below will
measure the latency of poll() executed by the ALSA glue code within
JACK. (i also removed the xrun printf, because it can cause delays.)

this patch can be used the following way: do not activate xrun_debug via
/proc (to not create additional latencies that make xruns worse), but
otherwise set the /proc/sys/kernel/ flags the same way you do already. 
If the patch is applied to jackd then /proc/latency_trace will show the
latest and highest latency that was measured.

note that this captures latencies visible in the ALSA glue, which doesnt
cover the whole jackd critical path - but it should be pretty good as an
initial start. It will definitely show all jackd-unrelated delay
sources.

to cover all latency paths, the last chunk of the patch could perhaps be
modified to do:

+		gettimeofday(1,0);
+		gettimeofday(1,1);

this will also capture latencies within jackd itself. But i think it is
better to separate 'external' from 'internal' latencies, because the two
situations are quite different and it might be hard to identify which
particular latency we are seeing in /proc/latency_trace.

	Ingo

--- ./drivers/alsa/alsa_driver.c.orig	2004-11-26 14:11:26.000000000 +0100
+++ ./drivers/alsa/alsa_driver.c	2004-11-26 14:24:41.000000000 +0100
@@ -1081,9 +1081,11 @@ alsa_driver_xrun_recovery (alsa_driver_t
 		snd_pcm_status_get_trigger_tstamp(status, &tstamp);
 		timersub(&now, &tstamp, &diff);
 		*delayed_usecs = diff.tv_sec * 1000000.0 + diff.tv_usec;
+#if 0
 		fprintf(stderr, "\n\n**** alsa_pcm: xrun of at least %.3f "
 			"msecs\n\n",
 			*delayed_usecs / 1000.0);
+#endif
 	}
 
 	if (alsa_driver_stop (driver) ||
@@ -1187,6 +1189,7 @@ alsa_driver_wait (alsa_driver_t *driver,
 
 		poll_enter = jack_get_microseconds ();
 
+		gettimeofday(1,1);
 		if (poll (driver->pfd, nfds, driver->poll_timeout) < 0) {
 
 			if (errno == EINTR) {
@@ -1206,6 +1209,7 @@ alsa_driver_wait (alsa_driver_t *driver,
 			return 0;
 			
 		}
+		gettimeofday(1,0);
 
 		poll_ret = jack_get_microseconds ();
 

