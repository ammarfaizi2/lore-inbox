Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbUK2L0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUK2L0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUK2L0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:26:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11938 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261681AbUK2L0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:26:11 -0500
Date: Mon, 29 Nov 2004 12:24:23 +0100
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
Message-ID: <20041129112423.GA10386@elte.hu>
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129111634.GB10123@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129111634.GB10123@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> --- ./drivers/alsa/alsa_driver.c.orig	2004-11-26 14:11:26.000000000 +0100
> +++ ./drivers/alsa/alsa_driver.c	2004-11-26 14:24:41.000000000 +0100

i think the one below is a better approach - it will only trace events
that the ALSA driver has reported to be an xrun. I.e. the full latency
path from the point where poll() is called, up to the point where jackd
[after the latency has occured] considers it an xrun worth
counting/reporting. The tracing restarts at every poll(), so only the 
latency is captured. If you up your tracebuffer to 40K+ entries then i'd 
suggest to use the following trace settings:

 echo 0 > /proc/asound/card0/pcm0p/xrun_debug

 echo 1 > /proc/sys/kernel/trace_user_triggered
 echo 0 > /proc/sys/kernel/trace_freerunning
 echo 0 > /proc/sys/kernel/preempt_max_latency
 echo 0 > /proc/sys/kernel/preempt_thresh
 echo 0 > /proc/sys/kernel/preempt_wakeup_timing

i.e. dont use trace_freerunning - this will give much easier to parse
traces.

a suggestion wrt. the format of the .trc files: it would be nice if you
could dump the PIDs of all relevant tasks into it too, to make it easier
to identify who causes what latency. Ideally it would be useful to 
have a more symbolic trace - i.e. instead of:

 3570 00000000 254981.991ms (+0.000ms): up (ext3_orphan_del)

it would be:

 jackd-3570 00000000 254981.991ms (+0.000ms): up (ext3_orphan_del)

but this is easier done in the kernel - some of the tasks involved in a
latency might be long gone by the time you detect the xrun.

	Ingo

--- ./drivers/alsa/alsa_driver.c.orig	2004-11-26 14:11:26.000000000 +0100
+++ ./drivers/alsa/alsa_driver.c	2004-11-26 15:31:37.000000000 +0100
@@ -1077,13 +1077,16 @@ alsa_driver_xrun_recovery (alsa_driver_t
 	    && driver->process_count > XRUN_REPORT_DELAY) {
 		struct timeval now, diff, tstamp;
 		driver->xrun_count++;
+		gettimeofday(0,0);
 		gettimeofday(&now, 0);
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
@@ -1185,6 +1188,7 @@ alsa_driver_wait (alsa_driver_t *driver,
 			nfds++;
 		}
 
+		gettimeofday(0,1);
 		poll_enter = jack_get_microseconds ();
 
 		if (poll (driver->pfd, nfds, driver->poll_timeout) < 0) {
