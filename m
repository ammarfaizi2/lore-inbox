Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263155AbUJ2I6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbUJ2I6m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbUJ2I6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:58:42 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45491 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263155AbUJ2I6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:58:34 -0400
Date: Fri, 29 Oct 2004 10:59:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029085943.GA1250@elte.hu>
References: <1099008264.4199.4.camel@krustophenia.net> <200410290057.i9T0v5I8011561@localhost.localdomain> <20041029080247.GC30400@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <20041029080247.GC30400@elte.hu>
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


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Ingo Molnar <mingo@elte.hu> wrote:

> Could the kernel help some more in debugging this? E.g. if the Jackd
> SCHED_FIFO thread (after it has started up) can never legitimately
> reschedule except via poll(), i could try to put in a syscall hack in
> where in the Jackd code you could call say gettimeofday(0,3) to turn
> on 'do not reschedule' mode, and call gettimeofday(0,4) to turn it
> off. If Jackd reschedules while in 'do not reschedule' mode then the
> scheduler code will detect this and will print out the offending
> user-space EIP and a stacktrace. [and will turn off 'do-not schedule'
> mode.]

i've implemented this feature and have put it into -RT-V0.5.5 which can
be downloaded from the usual place:

	http://redhat.com/~mingo/realtime-preempt/

i've attached a simple testcase showing how to use it. When running the 
testcode on a -V0.5.5 kernel it gives:

 saturn:~> ./rt-atomic
 testing atomic mode functionality.
 ok, kernel supports atomic mode.
 atomic mode is now off - doing sleep(), should succeed:
 turning atomic mode on.
 doing getppid() syscall - should succeed.
 doing sleep() syscall - should abort!
 User defined signal 1

the kernel sends SIGUSR1 when it detects illegal scheduling. (change the
SIGUSR1 in the patch if you want another signal.)

could someone with more Jackd experience than me add this to the Jackd
code and check whether and where it triggers? I'd suggest to do
something like around the poll() call:

	atomic_off();
	poll();
	atomic_on();

and add an atomic_off() to the Jackd shutdown handler (or any codepath
that is legitimately allowed to schedule).

	Ingo

--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rt-atomic.c"


#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <unistd.h>

#define atomic_on() \
do { \
	if (gettimeofday((void *)1,(void *)1)) { \
		printf("failed: wrong kernel?\n"); \
		abort(); \
	} \
} while (0)

#define atomic_off()	gettimeofday((void *)1,(void *)0)

int main(void)
{
	printf("testing atomic mode functionality.\n");
	atomic_on();
	atomic_off();
	printf("ok, kernel supports atomic mode.\n");

	printf("atomic mode is now off - doing sleep(), should succeed:\n");
	sleep(1);
	printf("turning atomic mode on.\n");
	atomic_on();
	printf("doing getppid() syscall - should succeed.\n");
	getppid();
	printf("doing sleep() syscall - should abort!\n");
	sleep(1);
	printf("huh? got back and no signal?\n");

	return 0;
}

--XOIedfhf+7KOe/yw--
