Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVHaHes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVHaHes (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVHaHes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:34:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:37608 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932454AbVHaHer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:34:47 -0400
Date: Wed, 31 Aug 2005 09:35:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: jackit-devel@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, cc@ccrma.Stanford.EDU,
       Steven Rostedt <rostedt@goodmis.org>
Subject: Re: jack, PREEMPT_DESKTOP, delayed interrupts?
Message-ID: <20050831073518.GA7582@elte.hu>
References: <1125453795.25823.121.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125453795.25823.121.camel@cmn37.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Do a "tar cvf usr.tar /usr" just to read/write a lot to disk (this 
> within the same SATA disk). Watch memory being used in a system 
> monitor applet up to 100%. After a while, hard to say how long (maybe 
> 10/15 minutes?) the system eventually can get into a state where Jack 
> starts printing messages of the type "delay of 3856.000 usecs exceeds 
> estimated spare time of 2653.000; restart ..." (if I understand 
> correctly this means interrupts are being delayed on their way to 
> Jack, or at least Jack thinks they are arriving too late), along with 
> some less frequent xun notices.
> 
> Now the strange thing is that this condition seems to be persistent.  
> Nothing I do after it starts to happen seems to halt those messages.  
> Including stopping Jack and starting it again, and even (tried it 
> once) stopping the alsa sound driver and loading it again. Nothing out 
> of the ordinary in dmesg or /var/log/messages. I would guess that 
> something "breaks" inside the kernel with regards to interrupt 
> handling and/or whatever Jack uses to measure time inside the kernel?  
> Interrupts are prioritized correctly (rtc, then audio and jack runs at 
> lower realtime priority than the audio interrupts), everything else 
> looks fine.

are the messages unstoppable, even if the system is completely idle? And 
you get this only with the SMP kernel, correct?

i dont know what's going on, but here are a couple of ideas to debug 
this further:

- could you check whether there are any SCHED_FIFO tasks that shouldnt 
  be there:

    ps -meo pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm | grep FF

  we had bugs in the past that caused RT priorities to 'leak' on SMP 
  systems.

- please enable all latency tracing options like Lee suggested, and do 
  "echo 0 > /proc/sys/kernel/preempt_max_latency" to get some traces. 

- if everything fails and automatic latency tracing does not show 
  anything out of ordinary, then you could try to do "user-triggered 
  tracing" of jackd's critical path. This is more laborous to do, but
  should pinpoint the latency reason in a pretty sure way.

  user-triggered tracing is done via adding those special gettimeofday 
  calls to jackd and recompiling jackd. I've attached an older hack
  against jackd below, you might need to merge it to recent jackd. NOTE: 
  this patch will only work if you are getting xrun messages from ALSA.  
  It has to be reworked if your latencies are not actual xruns.

  then, once the patched jackd is running, you can enable user-triggered
  tracing via:

	echo 1 > /proc/sys/kernel/trace_user_triggered

  then you should start seeing jackd's latency path measured, not the
  kernel's internal critical sections. [ Tracing overhead tip: for
  user-triggered tracing it is enough to have CONFIG_WAKEUP_TIMING and 
  CONFIG_LATENCY_TRACE enabled, the other debugging options can be 
  turned off, to minimize overhead. ]

	Ingo

diff -dupPNr jackit.0/drivers/alsa/alsa_driver.c jackit.1/drivers/alsa/alsa_driver.c
--- jackit.0/drivers/alsa/alsa_driver.c	2004-11-26 17:24:24.000000000 +0000
+++ jackit.1/drivers/alsa/alsa_driver.c	2004-11-30 13:41:24.521791456 +0000
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
@@ -1185,6 +1188,12 @@ alsa_driver_wait (alsa_driver_t *driver,
 			nfds++;
 		}
 
+		{	// Trigger off trace every other poll...
+			static unsigned int xruntrace_count = 0;
+			if ((xruntrace_count++ % 1) == 0)
+				gettimeofday(0,1);
+		}
+  
 		poll_enter = jack_get_microseconds ();
 
 		if (poll_enter > driver->poll_next) {
