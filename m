Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbUKWW6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbUKWW6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUKWRni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:43:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:909 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261354AbUKWQ4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:56:04 -0500
Date: Tue, 23 Nov 2004 18:58:23 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-9
Message-ID: <20041123175823.GA8803@elte.hu>
References: <20041109160544.GA28242@elte.hu> <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122005411.GA19363@elte.hu>
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


i have released the -V0.7.30-9 Real-Time Preemption patch, which can be
downloaded from the usual place:

    http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release.

most importantly it includes a JACK related latency fix. With Florian
Schmidt's great detective work we honed in on a big latency source
within JACK: the use of named pipes (fifos) on journalled filesystems. 

This issue has been empirically identified before (and is mentioned in
the JACK howto) but has never been given high enough prominence. It
turns out that the atime updates done while read()ing or write()ing
named pipes causes the delays - it may under certain circumstances call
out into the journalling code. It may block even on non-journalled
filesystems.

To work this issue around, when PREEMPT_RT is enabled the -30-9 kernel
skips atime updates on named-fifos. (it's pretty pointless anyway.)
Alternative userspace workarounds are to put the fifos on tmpfs/ramfs,
or to mark the filesystem noatime,nodiratime.

those experiencing xruns under JACK should definitely try the -30-9
kernel.

Changes since -V0.7.30-2:

 - named fifo reads/writes are now atomic, whenever possible

 - fixed pi_lock related SMP & CRITICAL_IRQSOFF_TIMING lockups, this 
   could resolve the lockups reported by Mark H. Johnson.

 - fixed one more PI buglet: wake up the new owner _after_ restoring
   the priority of the old owner.

 - made the NMI oopser more robust - it should print out some message 
   in pretty much any locking scenario.

 - added the blocker device used by Esben Nielsen's pi_test suite.

 - added user-triggerable ALSA xrun tracing to the patch: if a 
   sound IO channel has xrun_debug enabled in /proc then 
   user_trace_stop() will be called before printing the xrun message,
   and the current trace will be saved to /proc/latency_trace. This is a
   'one-shot' tracing method for now. I can be activated via:

     echo 1 > /proc/asound/card0/pcm0p/xrun_debug

     echo 1 > /proc/sys/kernel/trace_user_triggered
     echo 1 > /proc/sys/kernel/trace_freerunning
     echo 0 > /proc/sys/kernel/preempt_max_latency
     echo 0 > /proc/sys/kernel/preempt_thresh
     echo 0 > /proc/sys/kernel/preempt_wakeup_timing

     ./gettimeofday 0 1

  gettimeofday.c is attached below. The JACK fifo xrun source was found
  via this tracing facility.

to create a -V0.7.30-9 tree from scratch, the patching order is:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.9.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.10-rc2.bz2
  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/2.6.10-rc2-mm2.bz2
  http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.10-rc2-mm2-V0.7.30-9

	Ingo


-- gettimeofday.c:

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <sys/wait.h>
#include <linux/unistd.h>

int main (int argc, char **argv)
{
	if (argc != 3) {
		printf("usage: gettimeofday <val1> <val2>\n");
		exit(0);
	}
	gettimeofday(atol(argv[1]), atol(argv[2]));

	return 0;
}

