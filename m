Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVGHN7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVGHN7D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVGHN7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:59:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:25488 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262666AbVGHN7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:59:01 -0400
Date: Fri, 8 Jul 2005 15:58:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PREEMPT_RT and latency_trace
Message-ID: <20050708135828.GA5355@elte.hu>
References: <1120826951.6225.167.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <1120826951.6225.167.camel@ibiza.btsn.frna.bull.fr>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> Hi,
> 
> I have a big dilemna on one machine :
> I run a task with RT priority which make a loop to mesure the system
> perturbation.
> It works well except on  one machine.
> On a multi-cpu, If I run the program on cpu 1, I get 23us. It's OK.
> If I run the same program on cpu 0, I get 17373us !
> If I do :
> # echo 0 >/proc/sys/kernel/preempt_max_latency

you can start/stop tracing from userspace too. Then you'll see what 
happens. See the attached trace-it.c code. After having activated 
user-triggered tracing, do something like this in your testcode:

	for (;;) {
	        gettimeofday(0, 1);
        	gettimeofday(0, 0);
	}

this should measure the maximum userspace delay on that CPU. You can 
also read the TSC in the inner loop to validate the kernel tracer:

	for (;;) {
	        gettimeofday(0, 1);
		t0 = rdtsc();
		t1 = rdtsc();
        	gettimeofday(0, 0);
		if (t1-t0 > max)
			print_max();
	}

(you should not measure the trace start/stop functions themselves, they 
can take alot of time when a maximum-latency event happens.)

	Ingo

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="trace-it.c"


/*
 * Copyright (C) 1999, Ingo Molnar <mingo@redhat.com>
 */

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <linux/unistd.h>

int main (int argc, char **argv)
{
	int ret;

	if (getuid() != 0) {
		fprintf(stderr, "needs to run as root.\n");
		exit(1);
	}
	ret = system("cat /proc/sys/kernel/mcount_enabled >/dev/null 2>/dev/null");
	if (ret) {
		fprintf(stderr, "CONFIG_LATENCY_TRACING not enabled?\n");
		exit(1);
	}
	system("echo 1 > /proc/sys/kernel/trace_all_cpus");
	system("echo 1 > /proc/sys/kernel/trace_enabled");
	system("echo 0 > /proc/sys/kernel/trace_freerunning");
	system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
	system("echo 1 > /proc/sys/kernel/trace_user_triggered");
	system("echo 0 > /proc/sys/kernel/trace_verbose");
	system("echo 0 > /proc/sys/kernel/preempt_max_latency");
	system("echo 0 > /proc/sys/kernel/preempt_thresh");
	system("[ -e /proc/sys/kernel/wakeup_timing ] && echo 0 > /proc/sys/kernel/wakeup_timing");
	system("echo 1 > /proc/sys/kernel/mcount_enabled");

	gettimeofday(0, 1);
	usleep(100000);
	gettimeofday(0, 0);

	system("cat /proc/latency_trace");

	return 0;
}



--d6Gm4EdcadzBjdND--
