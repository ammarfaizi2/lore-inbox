Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263368AbUJ2QbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263368AbUJ2QbH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 12:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbUJ2Q3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 12:29:10 -0400
Received: from dfw-gate4.raytheon.com ([199.46.199.233]:34235 "EHLO
	dfw-gate4.raytheon.com") by vger.kernel.org with ESMTP
	id S263415AbUJ2QWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 12:22:36 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark_H_Johnson@raytheon.com, Rui Nuno Capela <rncbc@rncbc.org>,
       linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5.2
Date: Fri, 29 Oct 2004 11:20:20 -0500
Message-ID: <OFDD5E88CA.56DEE781-ON86256F3C.0059C080-86256F3C.0059C0A2@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/29/2004 11:20:21 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Today's run with -V0.5.11.

In short, the tracing appears to be broken on SMP systems and
may have caused the crash in the first attempt. In the second
attempt (no tracing), the system ran but the something is not
quite right in the scheduler (or in marking tasks "ready to run"
since it appears that my cpu burner (a nice'd task) is getting
run when the system should run the X server & other applications.

Will be sending system logs and serial console output separately.
  --Mark

-----

First attempt.

[1] Build / boot to X server OK. Only unusual message is the one
with the atomic counter underflow (in system log, not on console output).

[2] Set IRQ priorities & ran my "get_ltrace" script which looks for
changes in the latency trace output & dumps them out. Had one trace
and then soon after, the machine locked up. No console output for
several seconds, then finally a stream of errors.

The serial console messages appear to be incomplete at the beginning
(not sure why). Looks something like this

Starting system message bus: [  OK  ]^M
(kdeinit/3196/CPU#0): new 1204 us maximum-latency wakeup.
(X/2832/CPU#1): new 68008 us maximum-latency wakeup.
(get_ltrace.sh/3482/CPU#1): new 3814 us maximum-latency wakeup.
(get_ltrace.sh/3530/CPU#1): new 3963 us maximum-latency wakeup.
(artsd/2965/CPU#1): new 78620 us maximum-latency wakeup.

  (124)
 [<c012454b>] profile_task_exit+0x1b/0x50 (24)
 [<c012691f>] do_exit+0x1f/0x5c0 (40)

[note how the prologue data is missing & the output starts in
the middle of a line]

The critical section nesting was "unique" and looks like

| preempt count: 00010005 ]
| 5-level deep critical section nesting:
----------------------------------------
.. [<c03257cf>] .... _spin_lock+0x1f/0x70
.....[<c01e217a>] ..   ( <= __up_write+0x26a/0x2a0)
.. [<c03257cf>] .... _spin_lock+0x1f/0x70
.....[<c01e1f65>] ..   ( <= __up_write+0x55/0x2a0)
.. [<c0325817>] .... _spin_lock+0x67/0x70
.....[<c011b54d>] ..   ( <= task_rq_lock+0x3d/0x70)
.. [<c03257cf>] .... _spin_lock+0x1f/0x70
.....[<c0115f47>] ..   ( <= nmi_watchdog_tick+0x127/0x140)
.. [<c013d5bd>] .... print_traces+0x1d/0x60
.....[<c0105bec>] ..   ( <= show_regs+0x14c/0x174)

The script then exits with preempt count of 3 and an atomic counter
underflow BUG message. This is followed right after with

BUG: Unable to handle kernel NULL pointer dereference at virtual address
00000
020

and the appropriate dump messages. The cycle of script failure and
kernel BUG repeats a few cycles and then stops.

Let's reboot and not look at the latency traces.

Second attempt.

Boots OK and started the stress test.

[1] Got through about 80% of the X11perf stress test before the system
"live locked" again. The audio continued to come out but the display
stopped updating. I found that Alt-Sysrq-L and Alt-Sysrq-T seemed to
work so I did both while waiting for the audio test to stop on its own.

[2] Running the second test, a similar symptom occurred where the
display froze during the top test, but it finished as well.

[3] Running the third test (network output), I got a number of error
messages on the X display (but not on the serial console) indicating
segmentation violation for the command
  sudo -u me rcp file remote-system
I was able to manipulate the display at this point.

[4] It then ran the fourth test (network input), and the symptom of
locking up the display repeated (still no serial console messages).

[5] Disk write test had the same display lockup (audio OK).
Did Alt-Sysrq-L and -T to see what the status of tasks was.
Noticed that the cpu_burn program (nice'd) was still the active
task even though I had higher priority jobs (e.g., the X server)
that should have been ready to run.

[6] Disk copy & read tests, same symptoms, though it unfroze sometime
later in the test (and then froze again...). Something is not
quite consistent in how the system runs under these stress tests.

Application level charts are "interesting". All of them show very
little overhead to the CPU task with a few glitches. The audio
loop is consistently getting done "early". The yellow line showing
the nominal audio cycle time is well above the white line showing
the actual duration. To recap, in latencytest, we have a loop like
this...

  capture T1
  CPU burn 80% of nominal audio duration
  capture T2
  write next audio segment
  capture T3

where T2-T1 is the CPU time and T3-T1 is the audio time. Some of the
delays were extremely long, but I assume that was due to the occasional
use of Alt-Sysrq keys. Some may also be due to that scheduling problem
I described above as well.


