Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbUJ0NbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbUJ0NbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbUJ0N2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:28:54 -0400
Received: from mx1.elte.hu ([157.181.1.137]:7356 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262435AbUJ0N2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:28:22 -0400
Date: Wed, 27 Oct 2004 15:29:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-ID: <20041027132926.GA7171@elte.hu>
References: <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <417D4B5E.4010509@cybsft.com> <20041025203807.GB27865@elte.hu> <417E2CB7.4090608@cybsft.com> <20041027002455.GC31852@elte.hu> <417F16BB.3030300@cybsft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <417F16BB.3030300@cybsft.com>
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


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* K.R. Foley <kr@cybsft.com> wrote:

> Running amlat [...]

btw., to get good 'realfeel' results i had to apply the attached patch. 
Especially when running realfeel over the network it can easily happen
that it's delayed for some time and gets out of sync with the RTC. So
after a new maximum latency has triggered the code now waits 10 periods
to wait for the timings to recover.

this does not hurt the latency measurements in any way - latencies that
occur after these 10 ticks (~5 msecs) are over are still fully measured
and reported.

amlat produces weird output for me, continuously increasing latency
values:

 latency = 2967939 milliseconds
 latency = 2967950 milliseconds
 sigint
 max jitter = 0 microseconds

maybe some /dev/rtc API detail changed? Or is this the normal output?

	Ingo

--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="realfeel.diff"

--- realfeel.c.orig	2004-10-27 15:04:46.237707040 +0200
+++ realfeel.c	2004-10-27 15:04:50.204104056 +0200
@@ -91,7 +91,7 @@ int set_realtime_priority(void)
 	 * set the process to realtime privs
 	 */
 	memset(&schp, 0, sizeof(schp));
-	schp.sched_priority = sched_get_priority_max(SCHED_FIFO);
+	schp.sched_priority = sched_get_priority_max(SCHED_FIFO) - 1;
 	
 	if (sched_setscheduler(0, SCHED_FIFO, &schp) != 0) {
 		perror("sched_setscheduler");
@@ -191,8 +191,19 @@ int main(int argc, char *argv[])
 		now = rdtsc();
 		delay = secondsPerTick * (now - last);
 		if (delay > max_delay) {
+			int i;
+
 			max_delay = delay;
 			printf("%.3f msec\n", 1e3 * (ideal - delay));
+			/*
+			 * To make sure that the delay due to the printf
+			 * is not counted we skip the next period:
+			 */
+			for (i = 0; i < 10; i++)
+				if (read(fd, &data, sizeof(data)) == -1)
+					fatal("blocking read failed");
+			last = rdtsc();
+			continue;
 		}
 		ms = (-(ideal - delay) + 1.0/20000.0) * 10000;
 		if (ms < 0)

--AqsLC8rIMeq19msA--
